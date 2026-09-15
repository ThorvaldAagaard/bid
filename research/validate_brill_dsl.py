#!/usr/bin/env python3
"""
validate_brill_dsl.py — checks system/brill.dsl actually works.

  python3 research/validate_brill_dsl.py

1. every CONDITION key exists in the real feature vocabulary (a typo would
   silently make the rule unmatchable — RuleCondition returns False for
   unknown keys)
2. fuzz: random hands x random auction prefixes, calling DecisionNet.actions()
   and failing on any TypeError (catches int-vs-str comparisons)
3. curated smoke cases where the right call is obvious to a bridge player
"""

import random
import sys
import os
from collections import Counter

sys.path.insert(0, os.path.join(os.path.dirname(os.path.abspath(__file__)), "..", "src"))

from bid.eval_vs_dds import load_decision_net_dsl                     # noqa: E402
from bid.features import BridgeFeatures                               # noqa: E402
from bid.models import Hand, Card, Suit, Rank, Seat, Call, CallType, Strain  # noqa: E402
from bid.scoring import Vulnerability                                 # noqa: E402

REPO = os.path.join(os.path.dirname(os.path.abspath(__file__)), "..")
PATH = os.path.join(REPO, "system", "brill.dsl")

P = Call(CallType.PASS)


def bid(level, strain):
    return Call(CallType.BID, level, strain)


SUITS = {"S": Suit.SPADES, "H": Suit.HEARTS, "D": Suit.DIAMONDS, "C": Suit.CLUBS}


def hand(spec):
    cards = [Card(SUITS[s], getattr(Rank, r)) for s, rs in spec.items() for r in rs]
    return Hand(cards)


# Auction prefixes the DSL is exercised on. Also used to build the feature
# universe, so the vocabulary check covers every position the fuzz test hits.
VOCAB_POSITIONS = [
    ([], Seat.SOUTH),
    ([bid(1, Strain.CLUBS)], Seat.WEST),
    ([bid(1, Strain.HEARTS), P], Seat.NORTH),
    ([bid(1, Strain.HEARTS), bid(1, Strain.SPADES)], Seat.NORTH),
    ([bid(1, Strain.NT), P], Seat.NORTH),
    ([bid(2, Strain.CLUBS), P], Seat.NORTH),
    ([bid(1, Strain.SPADES), Call(CallType.DOUBLE)], Seat.NORTH),
    ([P, bid(1, Strain.DIAMONDS)], Seat.WEST),
    ([bid(2, Strain.HEARTS)], Seat.WEST),
    ([bid(3, Strain.CLUBS), P], Seat.NORTH),
]


def run():
    net = load_decision_net_dsl(PATH)
    print(f"loaded {len(net.rules)} rules from system/brill.dsl")

    # ---- 1. feature vocabulary -------------------------------------------
    # The universe must come from `extract_all`, which is the only function
    # DecisionNet.actions() actually calls. Building it from
    # extract_hand_features | extract_auction_features reports `rule_of_21`
    # as unknown and condemns 15 live rules, because that feature is computed
    # in extract_all from BOTH halves at once (hcp + two longest suits +
    # quick tricks) and does not exist in either half separately.
    deck = [Card(s, r) for s in Suit for r in Rank]
    random.seed(11)
    random.shuffle(deck)
    h = Hand(deck[:13])
    universe: set = set()
    for _hist, _dealer in VOCAB_POSITIONS:
        universe |= set(BridgeFeatures.extract_all(
            h, list(_hist), Seat.SOUTH, _dealer, Vulnerability.NONE))
    used = Counter(c.key for r in net.rules for c in r.conditions)
    missing = {k: v for k, v in used.items() if k not in universe}
    print(f"condition keys: {len(used)} | unknown: {missing or 'none'}")
    if missing:
        return 1

    # ---- 2. fuzz ----------------------------------------------------------
    prefixes = [
        ([], Seat.SOUTH),
        ([bid(1, Strain.CLUBS)], Seat.WEST),
        ([bid(1, Strain.HEARTS), P], Seat.NORTH),
        ([bid(1, Strain.HEARTS), bid(1, Strain.SPADES)], Seat.NORTH),
        ([bid(1, Strain.NT), P], Seat.NORTH),
        ([bid(2, Strain.CLUBS), P], Seat.NORTH),
        ([bid(1, Strain.SPADES), Call(CallType.DOUBLE)], Seat.NORTH),
        ([P, bid(1, Strain.DIAMONDS)], Seat.WEST),
        ([bid(2, Strain.HEARTS)], Seat.WEST),
        ([bid(3, Strain.CLUBS), P], Seat.NORTH),
    ]
    rng = random.Random(5)
    errs, fired, total = [], 0, 0
    for _ in range(400):
        random.shuffle(deck)
        hd = Hand(deck[:13])
        hist, dealer = prefixes[rng.randrange(len(prefixes))]
        try:
            acts = net.actions(hd, list(hist), Seat.SOUTH, dealer, Vulnerability.NONE)
        except TypeError as e:
            errs.append((str(e), [str(c) for c in hist]))
            continue
        fired += 1
        total += len(acts)
    print(f"fuzz: {fired}/400 positions evaluated, "
          f"{total} candidate calls, {len(errs)} type errors")
    for e in errs[:5]:
        print("   ", e)
    if errs:
        return 1

    # ---- 3. curated smoke cases ------------------------------------------
    # NOTE: brill.dsl cannot open 1H/1S (Brill gates those on unpublished
    # internal macros), so the opening cases here only cover what survived.
    cases = [
        ("15 HCP 4333, opening", hand({
            'S': ['ACE', 'SEVEN', 'THREE'], 'H': ['KING', 'FIVE', 'FOUR'],
            'D': ['ACE', 'JACK', 'SIX'], 'C': ['QUEEN', 'JACK', 'SEVEN', 'TWO']}),
         [], Seat.SOUTH, "1NT"),
        # Restored from the Part 1 prose (BR_PROSE_* rules) — the tree rules
        # for these all depended on unpublished macros.
        ("15 HCP 5 spades, opening", hand({
            'S': ['ACE', 'KING', 'QUEEN', 'JACK', 'THREE'], 'H': ['SEVEN', 'TWO'],
            'D': ['KING', 'FIVE', 'FOUR'], 'C': ['QUEEN', 'SIX', 'THREE']}),
         [], Seat.SOUTH, "1S"),
        ("8 HCP 6 hearts, opening", hand({
            'S': ['FIVE', 'TWO'], 'H': ['ACE', 'QUEEN', 'JACK', 'NINE', 'EIGHT', 'THREE'],
            'D': ['SIX', 'FOUR'], 'C': ['JACK', 'SEVEN', 'FIVE']}),
         [], Seat.SOUTH, "2H"),
        ("6 HCP 7 spades, opening", hand({
            'S': ['KING', 'JACK', 'NINE', 'EIGHT', 'SEVEN', 'SIX', 'FIVE'],
            'H': ['QUEEN', 'THREE'], 'D': ['FOUR', 'TWO'], 'C': ['SIX', 'FIVE']}),
         [], Seat.SOUTH, "3S"),
        # KNOWN GAP (asserted, not a failure): Brill opens this 1C on
        # `clublongest`, which the DSL cannot express, so brill.dsl passes.
        ("13 HCP 3334, opening (GAP)", hand({
            'S': ['ACE', 'SEVEN', 'THREE'], 'H': ['KING', 'FIVE', 'FOUR'],
            'D': ['QUEEN', 'JACK', 'SIX'], 'C': ['KING', 'SEVEN', 'SIX', 'TWO']}),
         [], Seat.SOUTH, "PASS"),
        ("1H-P, 8 HCP 5 spades", hand({
            'S': ['KING', 'QUEEN', 'JACK', 'NINE', 'TWO'], 'H': ['SIX', 'THREE'],
            'D': ['ACE', 'SEVEN', 'FOUR'], 'C': ['EIGHT', 'FIVE', 'TWO']}),
         [bid(1, Strain.HEARTS), P], Seat.NORTH, "1S"),
        ("1H-P, 4 HCP bust", hand({
            'S': ['SEVEN', 'FOUR', 'TWO'], 'H': ['SIX', 'FIVE'],
            'D': ['QUEEN', 'EIGHT', 'FIVE'], 'C': ['NINE', 'SEVEN', 'THREE']}),
         [bid(1, Strain.HEARTS), P], Seat.NORTH, "PASS"),
        ("1N-P, 10 HCP 5 hearts", hand({
            'S': ['SEVEN', 'THREE', 'TWO'], 'H': ['KING', 'QUEEN', 'JACK', 'NINE', 'FOUR'],
            'D': ['ACE', 'SIX'], 'C': ['EIGHT', 'FIVE', 'THREE']}),
         [bid(1, Strain.NT), P], Seat.NORTH, "2D"),
    ]
    print("\nsmoke cases (first 5 candidates, priority-ordered):")
    ok = 0
    for title, hd, hist, dealer, expect in cases:
        acts = net.actions(hd, hist, Seat.SOUTH, dealer, Vulnerability.NONE)
        names = [str(a) for a in acts[:5]]
        hit = expect in names
        ok += hit
        print(f"  [{'ok ' if hit else 'MISS'}] {title:28s} want {expect:4s} "
              f"-> {', '.join(names) if names else '(none)'}")
    print(f"\n{ok}/{len(cases)} smoke cases place the expected call in the top 5")
    return 0


if __name__ == "__main__":
    sys.exit(run())
