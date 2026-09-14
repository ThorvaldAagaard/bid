import unittest
from bid.models import Hand, Seat, Call, CallType, Strain
from bid.decision_net import DecisionNet
from bid.sampling import Deal, PartialState
from bid.pidm import PIDMEngine
from bid.protocol import ConventionProtocol, ProtocolStep, ProtocolOpType, ValueOfInformationEvaluator, AdversarialSignalingEvaluator

class TestProtocolSynthesisAndVOI(unittest.TestCase):

    def test_protocol_rule_compilation(self):
        stayman = ConventionProtocol.create_stayman()
        rules = stayman.compile_to_rules()
        self.assertGreaterEqual(len(rules), 2)

        # Apply Stayman to DecisionNet
        net = DecisionNet("1NT_System")
        for r in rules:
            net.add_rule(r)

        # N=1NT E=P S=2C, opener (North) to act. Seat-correct: S is North's
        # partner, so South needs the pass in between to be the 2C bidder.
        history = [Call(CallType.BID, 1, Strain.NT), Call(CallType.PASS),
                   Call(CallType.BID, 2, Strain.CLUBS)]
        seat, dealer = Seat.NORTH, Seat.NORTH

        # Opener with 4 hearts should bid 2H
        opener_hand_hearts = Hand.from_string("SA4 HKJ43 DQ432 CA3")
        actions = net.actions(opener_hand_hearts, history, seat, dealer)
        self.assertIn(Call(CallType.BID, 2, Strain.HEARTS), actions)

        # Opener with 2 hearts should bid 2D
        opener_hand_no_major = Hand.from_string("SA4 HK4 DQJ432 CA43")
        actions_no_m = net.actions(opener_hand_no_major, history, seat, dealer)
        self.assertIn(Call(CallType.BID, 2, Strain.DIAMONDS), actions_no_m)

    def test_jacoby_transfer_compilation(self):
        jacoby = ConventionProtocol.create_jacoby_transfer()
        rules = jacoby.compile_to_rules()
        self.assertGreaterEqual(len(rules), 1)

        net = DecisionNet("JacobyNet")
        for r in rules:
            net.add_rule(r)

        # N=1NT E=P S=2D, opener (North) accepts the transfer with 2H.
        opener_hand = Hand.from_string("SAK4 H432 DK432 CA3")
        history = [Call(CallType.BID, 1, Strain.NT), Call(CallType.PASS),
                   Call(CallType.BID, 2, Strain.DIAMONDS)]
        actions = net.actions(opener_hand, history, Seat.NORTH, Seat.NORTH)
        self.assertIn(Call(CallType.BID, 2, Strain.HEARTS), actions)

    def test_blackwood_step_encoding(self):
        blackwood = ConventionProtocol.create_blackwood()
        rules = blackwood.compile_to_rules()

        net = DecisionNet("BlackwoodNet")
        for r in rules:
            net.add_rule(r)

        # Partner has 2 aces
        hand_2_aces = Hand.from_string("SA4 HA32 DK432 CT98")
        self.assertEqual(hand_2_aces.ace_count, 2)

        history = [Call(CallType.BID, 4, Strain.NT)]
        actions = net.actions(hand_2_aces, history)
        self.assertIn(Call(CallType.BID, 5, Strain.HEARTS), actions)

    def test_trigger_sequence_is_not_context_free(self):
        """A convention step must stay silent outside its trigger auction.

        Before `trigger_sequence` was compiled into conditions, Stayman
        lowered to a bare `heart_len >= 4 -> 2H` and Blackwood to
        `ace_count == 2 -> 5H` — both fired on literally every auction,
        including the opening seat.
        """
        net = DecisionNet("Ctx")
        for r in ConventionProtocol.create_stayman().compile_to_rules():
            net.add_rule(r)

        hand = Hand.from_string("SA4 HKJ43 DQ432 CA3")   # 4 hearts
        for history in ([],
                        [Call(CallType.BID, 1, Strain.SPADES)],
                        [Call(CallType.BID, 1, Strain.NT)]):
            actions = net.actions(hand, history, Seat.NORTH, Seat.NORTH)
            self.assertNotIn(
                Call(CallType.BID, 2, Strain.HEARTS), actions,
                f"Stayman fired on {[str(c) for c in history]}")

        blackwood = DecisionNet("BW")
        for r in ConventionProtocol.create_blackwood().compile_to_rules():
            blackwood.add_rule(r)
        hand_2_aces = Hand.from_string("SA4 HA32 DK432 CT98")
        self.assertNotIn(
            Call(CallType.BID, 5, Strain.HEARTS),
            blackwood.actions(hand_2_aces, [], Seat.SOUTH, Seat.NORTH))

    def test_value_of_information(self):
        engine = PIDMEngine()
        voi_eval = ValueOfInformationEvaluator(engine)

        stayman = ConventionProtocol.create_stayman()
        step = stayman.steps[0]

        # States facing 1NT opening
        states = []
        for _ in range(3):
            states.append(PartialState(Seat.NORTH, Hand.random(), [Call(CallType.BID, 1, Strain.NT), Call(CallType.BID, 2, Strain.CLUBS)]))

        models = {s: DecisionNet(f"M_{s}") for s in Seat}
        voi = voi_eval.evaluate_voi(step, states, models)
        self.assertGreaterEqual(voi, 0.0)

    def test_competitive_value_of_information(self):
        engine = PIDMEngine()
        voi_eval = ValueOfInformationEvaluator(engine)

        stayman = ConventionProtocol.create_stayman()
        step = stayman.steps[0]

        states = [
            PartialState(Seat.NORTH, Hand.random(), [Call(CallType.BID, 1, Strain.NT), Call(CallType.BID, 2, Strain.CLUBS)])
            for _ in range(2)
        ]
        models = {s: DecisionNet(f"M_{s}") for s in Seat}
        comp_voi = voi_eval.evaluate_competitive_voi(step, states, models, leakage_penalty=0.2, preemption_bonus=0.3)

        self.assertIn("voi_partner", comp_voi)
        self.assertIn("leakage", comp_voi)
        self.assertIn("disruption", comp_voi)
        self.assertIn("net_voi", comp_voi)
        self.assertGreaterEqual(comp_voi["leakage"], 0.0)
        self.assertLessEqual(comp_voi["leakage"], 1.0)
        self.assertGreaterEqual(comp_voi["disruption"], 0.0)


if __name__ == "__main__":
    unittest.main()
