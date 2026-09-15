# ==========================================================
# BRILL BIDDING SYSTEM — converted from system/brill.md
#
# Source : https://brillsystem.aalborgdata.dk/
#         Brill 0.1.0+20260913.1018.g5039e2b-dirty
#         (1,040,694 rules in the live engine)
# Convert: python3 research/brill_to_dsl.py
#
# 3052 Brill call definitions -> 1932 DSL rules.
#
# CAVEATS — read before trusting this file:
#   * Only the tree 2 calls deep was captured.
#   * Clauses containing atoms with no DSL equivalent are
#     DROPPED, never relaxed.  Brill's own computed verdicts
#     (game / slammish / CanBid6_* / CanAsk_*_RKC / loserlevel)
#     and most of its suit-quality tests (trump / rebiddable /
#     monsterslam) are NOT reproduced.  `realsolid('X')` IS,
#     measured from Brill's engine rather than guessed (§6.53).
#     The system here is therefore thinner than Brill,
#     especially for slams and sacrifices.
#
#   * MEASURED, NOT ASSUMED (§6.56). An earlier header
#     claimed this system "will underbid rather than
#     overbid, which is the safe direction". That was an
#     assumption, never a measurement, and it has been
#     retracted in both directions — the system is not
#     reliably better OR worse, it is INCOMPLETE and
#     higher-variance.
#
#     FIRST-CALL-ONLY. Every rule requires
#     my_last_call == 'NONE'. Measured over 200 boards
#     (1,727 real calls) it can make 60.6% of first calls
#     (485/800) and 0% of the 927 later ones — 28.1%
#     overall. Auctions cannot continue past one round,
#     and 120/400 boards (30%) are passed out entirely.
#
#     RANKING DEPENDS ON THE METRIC (400 boards):
#       abs deviation from par : champion better by 0.92
#         IMP/board (t 4.31, 95% CI 0.50-1.34)
#       signed 'beating par'   : DEAD HEAT, -0.32 vs
#         champion's -0.35 (diff -0.03, CI -0.68..+0.62)
#     It beats par on 179 boards vs champion's 173 and by
#     more (+7.70 vs +6.87), but loses on 198 vs 172. A
#     wider spread, not a worse system.
#
#     A hybrid (this file where a rule matches, champion
#     elsewhere) is indistinguishable from champion alone
#     on BOTH metrics: the part that DID convert adds
#     ~0.01 IMP/board.
#
#     Treat this file as a position catalogue, not a system.
#     But note (§6.57): REMOTE Brill, scored the same way,
#     beats champion by +0.98 abs IMP/board (t 3.74) with
#     1 pass-out in 250. The target is worth ~2.0 IMP/board
#     more than this file renders — so the failure is the
#     2-deep capture, not Brill. Distil from /bid traces
#     rather than translating rules.
#   * Approximations in use:
#       losers        -> losing_trick_count
#       X_points      -> X_hcp
#       balish        -> is_semi_balanced
#       stopper('X')  -> X_stopper >= 2
#   * Feature-to-feature compares, precomputed in features.py
#     as booleans rather than dropped (§6.51, §6.53):
#       Xlongest -> X_is_longest      bestsuit(X)  -> X_is_longest
#       bestmajor(X) -> X_is_best_major   bestminor(X) -> X_is_best_minor
#       realsolid('X') -> X_realsolid
#
# WHAT IS MISSING, AND WHY IT CANNOT BE FIXED HERE
#   * Tree rules for the 1M openings, the weak twos and the 3-level
#     preempts all depend on unpublished macros (Opening1H/1S,
#     ruleof21, loserlevel), so none survive translation.  They are
#     RESTORED at the end of this file from Part 1's prose summary
#     (mark: BR_PROSE_*).  The 1C/1D openings still only survive for
#     the specific balanced shapes Brill spells out.
#   * The slam apparatus is gone (RKC0314, GSF, CanBid6_*, splinter
#     slam tries) — it is expressed as Brill's own computed verdicts.
#   * Sacrifices and competitive doubles are largely gone.
#   * Adding a `*_is_longest` feature to bid/features.py would
#     recover ~55 more rules, but does NOT recover 1H/1S.
#
# WHAT IS SOLID: responding and competing over partner's 1-level
# opening and over their 1NT — 60 auction positions, where the
# strength of the captured tree lies.
# ==========================================================

RULE B_1C_PASS_0_0:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: opp_last_call == '1C'
  CONDITION: partner_last_call == 'NONE'

RULE B_1C_PASS_0_1:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: opp_last_call == '1C'
  CONDITION: partner_last_call == 'NONE'
  CONDITION: club_len >= 7

RULE B_1C_1D_1_0:
  CALL: 1D
  PRIORITY: 21
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: opp_last_call == '1C'
  CONDITION: partner_last_call == 'NONE'
  CONDITION: diamond_len >= 5
  CONDITION: hcp >= 10
  CONDITION: hcp <= 17
  CONDITION: d_is_longest == True
  CONDITION: d_top3_honors >= 1

RULE B_1C_1H_2_0:
  CALL: 1H
  PRIORITY: 72
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: opp_last_call == '1C'
  CONDITION: partner_last_call == 'NONE'
  CONDITION: heart_len >= 6
  CONDITION: hcp >= 7
  CONDITION: heart_hcp >= 10
  CONDITION: hcp <= 17
  CONDITION: h_is_longest == True
  CONDITION: h_top3_honors >= 1

RULE B_1C_1S_3_0:
  CALL: 1S
  PRIORITY: 72
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: opp_last_call == '1C'
  CONDITION: partner_last_call == 'NONE'
  CONDITION: spade_len >= 6
  CONDITION: hcp >= 7
  CONDITION: spade_hcp >= 10
  CONDITION: hcp <= 17
  CONDITION: s_is_longest == True
  CONDITION: s_top3_honors >= 1

RULE B_1C_1NT_4_0:
  CALL: 1NT
  PRIORITY: 60
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: opp_last_call == '1C'
  CONDITION: partner_last_call == 'NONE'
  CONDITION: club_len >= 4
  CONDITION: hcp >= 15
  CONDITION: hcp <= 17
  CONDITION: is_balanced == True

RULE B_1C_1NT_4_1:
  CALL: 1NT
  PRIORITY: 60
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: opp_last_call == '1C'
  CONDITION: partner_last_call == 'NONE'
  CONDITION: club_len >= 4
  CONDITION: hcp >= 15
  CONDITION: hcp <= 17
  CONDITION: is_semi_balanced == True

RULE B_1C_1NT_4_2:
  CALL: 1NT
  PRIORITY: 60
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: opp_last_call == '1C'
  CONDITION: partner_last_call == 'NONE'
  CONDITION: club_len >= 5
  CONDITION: hcp >= 15
  CONDITION: hcp <= 18
  CONDITION: is_balanced == True

RULE B_1C_1NT_4_3:
  CALL: 1NT
  PRIORITY: 60
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: opp_last_call == '1C'
  CONDITION: partner_last_call == 'NONE'
  CONDITION: club_len >= 5
  CONDITION: hcp >= 15
  CONDITION: hcp <= 18
  CONDITION: is_semi_balanced == True

RULE B_1C_1NT_4_4:
  CALL: 1NT
  PRIORITY: 60
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: opp_last_call == '1C'
  CONDITION: partner_last_call == 'NONE'
  CONDITION: c_stopper >= 2
  CONDITION: hcp >= 15
  CONDITION: hcp <= 17
  CONDITION: is_balanced == True

RULE B_1C_1NT_4_5:
  CALL: 1NT
  PRIORITY: 60
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: opp_last_call == '1C'
  CONDITION: partner_last_call == 'NONE'
  CONDITION: c_stopper >= 2
  CONDITION: hcp >= 15
  CONDITION: hcp <= 17
  CONDITION: is_semi_balanced == True

RULE B_1C_4H_20_0_0:
  CALL: 4H
  PRIORITY: 91
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: opp_last_call == '1C'
  CONDITION: partner_last_call == 'NONE'
  CONDITION: heart_len >= 8
  CONDITION: hcp <= 10
  CONDITION: h_has_ace == True

RULE B_1C_4H_20_0_1:
  CALL: 4H
  PRIORITY: 91
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: opp_last_call == '1C'
  CONDITION: partner_last_call == 'NONE'
  CONDITION: heart_len >= 8
  CONDITION: hcp <= 10
  CONDITION: h_has_king == True

RULE B_1C_4H_20_0_2:
  CALL: 4H
  PRIORITY: 91
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: opp_last_call == '1C'
  CONDITION: partner_last_call == 'NONE'
  CONDITION: heart_len >= 8
  CONDITION: hcp <= 10
  CONDITION: h_has_queen == True

RULE B_1C_4H_20_0_3:
  CALL: 4H
  PRIORITY: 91
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: opp_last_call == '1C'
  CONDITION: partner_last_call == 'NONE'
  CONDITION: heart_len >= 8
  CONDITION: hcp <= 10
  CONDITION: h_has_jack == True

RULE B_1C_4H_20_0_4:
  CALL: 4H
  PRIORITY: 91
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: opp_last_call == '1C'
  CONDITION: partner_last_call == 'NONE'
  CONDITION: heart_len >= 8
  CONDITION: hcp <= 10
  CONDITION: h_has_ten == True

RULE B_1C_4S_24_0_0:
  CALL: 4S
  PRIORITY: 91
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: opp_last_call == '1C'
  CONDITION: partner_last_call == 'NONE'
  CONDITION: spade_len >= 8
  CONDITION: hcp <= 10
  CONDITION: s_has_ace == True

RULE B_1C_4S_24_0_1:
  CALL: 4S
  PRIORITY: 91
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: opp_last_call == '1C'
  CONDITION: partner_last_call == 'NONE'
  CONDITION: spade_len >= 8
  CONDITION: hcp <= 10
  CONDITION: s_has_king == True

RULE B_1C_4S_24_0_2:
  CALL: 4S
  PRIORITY: 91
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: opp_last_call == '1C'
  CONDITION: partner_last_call == 'NONE'
  CONDITION: spade_len >= 8
  CONDITION: hcp <= 10
  CONDITION: s_has_queen == True

RULE B_1C_4S_24_0_3:
  CALL: 4S
  PRIORITY: 91
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: opp_last_call == '1C'
  CONDITION: partner_last_call == 'NONE'
  CONDITION: spade_len >= 8
  CONDITION: hcp <= 10
  CONDITION: s_has_jack == True

RULE B_1C_4S_24_0_4:
  CALL: 4S
  PRIORITY: 91
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: opp_last_call == '1C'
  CONDITION: partner_last_call == 'NONE'
  CONDITION: spade_len >= 8
  CONDITION: hcp <= 10
  CONDITION: s_has_ten == True

RULE B_1C_6D_28_0:
  CALL: 6D
  PRIORITY: 140
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: opp_last_call == '1C'
  CONDITION: partner_last_call == 'NONE'
  CONDITION: d_realsolid == True
  CONDITION: losing_trick_count == 1

RULE B_1C_6H_29_0:
  CALL: 6H
  PRIORITY: 142
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: opp_last_call == '1C'
  CONDITION: partner_last_call == 'NONE'
  CONDITION: h_realsolid == True
  CONDITION: losing_trick_count == 1

RULE B_1C_6S_30_0:
  CALL: 6S
  PRIORITY: 142
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: opp_last_call == '1C'
  CONDITION: partner_last_call == 'NONE'
  CONDITION: s_realsolid == True
  CONDITION: losing_trick_count == 1

RULE B_1C_7D_31_0:
  CALL: 7D
  PRIORITY: 141
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: opp_last_call == '1C'
  CONDITION: partner_last_call == 'NONE'
  CONDITION: d_realsolid == True
  CONDITION: losing_trick_count <= 0

RULE B_1C_7H_32_0:
  CALL: 7H
  PRIORITY: 143
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: opp_last_call == '1C'
  CONDITION: partner_last_call == 'NONE'
  CONDITION: h_realsolid == True
  CONDITION: losing_trick_count <= 0

RULE B_1C_7S_33_0:
  CALL: 7S
  PRIORITY: 143
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: opp_last_call == '1C'
  CONDITION: partner_last_call == 'NONE'
  CONDITION: s_realsolid == True
  CONDITION: losing_trick_count <= 0

RULE B_1C_X_34_1:
  CALL: X
  PRIORITY: 74
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: opp_last_call == '1C'
  CONDITION: partner_last_call == 'NONE'
  CONDITION: hcp >= 18

RULE B_1C_X_34_3:
  CALL: X
  PRIORITY: 74
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: opp_last_call == '1C'
  CONDITION: partner_last_call == 'NONE'
  CONDITION: hcp >= 10
  CONDITION: spade_len >= 4
  CONDITION: heart_len >= 4
  CONDITION: diamond_len >= 3
  CONDITION: club_len <= 1

RULE B_1D_PASS_35_0:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: opp_last_call == '1D'
  CONDITION: partner_last_call == 'NONE'

RULE B_1D_PASS_35_1:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: opp_last_call == '1D'
  CONDITION: partner_last_call == 'NONE'
  CONDITION: diamond_len >= 7

RULE B_1D_1H_36_0:
  CALL: 1H
  PRIORITY: 72
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: opp_last_call == '1D'
  CONDITION: partner_last_call == 'NONE'
  CONDITION: heart_len >= 6
  CONDITION: hcp >= 7
  CONDITION: heart_hcp >= 10
  CONDITION: hcp <= 17
  CONDITION: h_is_longest == True
  CONDITION: h_top3_honors >= 1

RULE B_1D_1S_37_0:
  CALL: 1S
  PRIORITY: 72
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: opp_last_call == '1D'
  CONDITION: partner_last_call == 'NONE'
  CONDITION: spade_len >= 6
  CONDITION: hcp >= 7
  CONDITION: spade_hcp >= 10
  CONDITION: hcp <= 17
  CONDITION: s_is_longest == True
  CONDITION: s_top3_honors >= 1

RULE B_1D_1NT_38_0:
  CALL: 1NT
  PRIORITY: 60
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: opp_last_call == '1D'
  CONDITION: partner_last_call == 'NONE'
  CONDITION: diamond_len >= 4
  CONDITION: hcp >= 15
  CONDITION: hcp <= 17
  CONDITION: is_balanced == True

RULE B_1D_1NT_38_1:
  CALL: 1NT
  PRIORITY: 60
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: opp_last_call == '1D'
  CONDITION: partner_last_call == 'NONE'
  CONDITION: diamond_len >= 4
  CONDITION: hcp >= 15
  CONDITION: hcp <= 17
  CONDITION: is_semi_balanced == True

RULE B_1D_1NT_38_2:
  CALL: 1NT
  PRIORITY: 60
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: opp_last_call == '1D'
  CONDITION: partner_last_call == 'NONE'
  CONDITION: diamond_len >= 5
  CONDITION: hcp >= 15
  CONDITION: hcp <= 18
  CONDITION: is_balanced == True

RULE B_1D_1NT_38_3:
  CALL: 1NT
  PRIORITY: 60
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: opp_last_call == '1D'
  CONDITION: partner_last_call == 'NONE'
  CONDITION: diamond_len >= 5
  CONDITION: hcp >= 15
  CONDITION: hcp <= 18
  CONDITION: is_semi_balanced == True

RULE B_1D_1NT_38_4:
  CALL: 1NT
  PRIORITY: 60
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: opp_last_call == '1D'
  CONDITION: partner_last_call == 'NONE'
  CONDITION: d_stopper >= 2
  CONDITION: hcp >= 15
  CONDITION: hcp <= 17
  CONDITION: is_balanced == True

RULE B_1D_1NT_38_5:
  CALL: 1NT
  PRIORITY: 60
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: opp_last_call == '1D'
  CONDITION: partner_last_call == 'NONE'
  CONDITION: d_stopper >= 2
  CONDITION: hcp >= 15
  CONDITION: hcp <= 17
  CONDITION: is_semi_balanced == True

RULE B_1D_4H_54_0_0:
  CALL: 4H
  PRIORITY: 91
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: opp_last_call == '1D'
  CONDITION: partner_last_call == 'NONE'
  CONDITION: heart_len >= 8
  CONDITION: hcp <= 10
  CONDITION: h_has_ace == True

RULE B_1D_4H_54_0_1:
  CALL: 4H
  PRIORITY: 91
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: opp_last_call == '1D'
  CONDITION: partner_last_call == 'NONE'
  CONDITION: heart_len >= 8
  CONDITION: hcp <= 10
  CONDITION: h_has_king == True

RULE B_1D_4H_54_0_2:
  CALL: 4H
  PRIORITY: 91
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: opp_last_call == '1D'
  CONDITION: partner_last_call == 'NONE'
  CONDITION: heart_len >= 8
  CONDITION: hcp <= 10
  CONDITION: h_has_queen == True

RULE B_1D_4H_54_0_3:
  CALL: 4H
  PRIORITY: 91
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: opp_last_call == '1D'
  CONDITION: partner_last_call == 'NONE'
  CONDITION: heart_len >= 8
  CONDITION: hcp <= 10
  CONDITION: h_has_jack == True

RULE B_1D_4H_54_0_4:
  CALL: 4H
  PRIORITY: 91
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: opp_last_call == '1D'
  CONDITION: partner_last_call == 'NONE'
  CONDITION: heart_len >= 8
  CONDITION: hcp <= 10
  CONDITION: h_has_ten == True

RULE B_1D_4S_58_0_0:
  CALL: 4S
  PRIORITY: 91
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: opp_last_call == '1D'
  CONDITION: partner_last_call == 'NONE'
  CONDITION: spade_len >= 8
  CONDITION: hcp <= 10
  CONDITION: s_has_ace == True

RULE B_1D_4S_58_0_1:
  CALL: 4S
  PRIORITY: 91
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: opp_last_call == '1D'
  CONDITION: partner_last_call == 'NONE'
  CONDITION: spade_len >= 8
  CONDITION: hcp <= 10
  CONDITION: s_has_king == True

RULE B_1D_4S_58_0_2:
  CALL: 4S
  PRIORITY: 91
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: opp_last_call == '1D'
  CONDITION: partner_last_call == 'NONE'
  CONDITION: spade_len >= 8
  CONDITION: hcp <= 10
  CONDITION: s_has_queen == True

RULE B_1D_4S_58_0_3:
  CALL: 4S
  PRIORITY: 91
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: opp_last_call == '1D'
  CONDITION: partner_last_call == 'NONE'
  CONDITION: spade_len >= 8
  CONDITION: hcp <= 10
  CONDITION: s_has_jack == True

RULE B_1D_4S_58_0_4:
  CALL: 4S
  PRIORITY: 91
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: opp_last_call == '1D'
  CONDITION: partner_last_call == 'NONE'
  CONDITION: spade_len >= 8
  CONDITION: hcp <= 10
  CONDITION: s_has_ten == True

RULE B_1D_6C_62_0:
  CALL: 6C
  PRIORITY: 140
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: opp_last_call == '1D'
  CONDITION: partner_last_call == 'NONE'
  CONDITION: c_realsolid == True
  CONDITION: losing_trick_count == 1

RULE B_1D_6H_63_0:
  CALL: 6H
  PRIORITY: 142
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: opp_last_call == '1D'
  CONDITION: partner_last_call == 'NONE'
  CONDITION: h_realsolid == True
  CONDITION: losing_trick_count == 1

RULE B_1D_6S_64_0:
  CALL: 6S
  PRIORITY: 142
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: opp_last_call == '1D'
  CONDITION: partner_last_call == 'NONE'
  CONDITION: s_realsolid == True
  CONDITION: losing_trick_count == 1

RULE B_1D_7C_65_0:
  CALL: 7C
  PRIORITY: 141
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: opp_last_call == '1D'
  CONDITION: partner_last_call == 'NONE'
  CONDITION: c_realsolid == True
  CONDITION: losing_trick_count <= 0

RULE B_1D_7H_66_0:
  CALL: 7H
  PRIORITY: 143
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: opp_last_call == '1D'
  CONDITION: partner_last_call == 'NONE'
  CONDITION: h_realsolid == True
  CONDITION: losing_trick_count <= 0

RULE B_1D_7S_67_0:
  CALL: 7S
  PRIORITY: 143
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: opp_last_call == '1D'
  CONDITION: partner_last_call == 'NONE'
  CONDITION: s_realsolid == True
  CONDITION: losing_trick_count <= 0

RULE B_1D_X_68_1:
  CALL: X
  PRIORITY: 74
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: opp_last_call == '1D'
  CONDITION: partner_last_call == 'NONE'
  CONDITION: hcp >= 18

RULE B_1D_X_68_3:
  CALL: X
  PRIORITY: 74
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: opp_last_call == '1D'
  CONDITION: partner_last_call == 'NONE'
  CONDITION: hcp >= 10
  CONDITION: spade_len >= 4
  CONDITION: heart_len >= 4
  CONDITION: club_len >= 3
  CONDITION: diamond_len <= 1

RULE B_1H_PASS_69_0:
  CALL: PASS
  PRIORITY: 1
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: opp_last_call == '1H'
  CONDITION: partner_last_call == 'NONE'

RULE B_1H_PASS_69_1:
  CALL: PASS
  PRIORITY: 1
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: opp_last_call == '1H'
  CONDITION: partner_last_call == 'NONE'
  CONDITION: heart_len >= 6

RULE B_1H_1S_70_0:
  CALL: 1S
  PRIORITY: 60
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: opp_last_call == '1H'
  CONDITION: partner_last_call == 'NONE'
  CONDITION: spade_len >= 5
  CONDITION: hcp >= 8
  CONDITION: hcp <= 17

RULE B_1H_1NT_71_0:
  CALL: 1NT
  PRIORITY: 60
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: opp_last_call == '1H'
  CONDITION: partner_last_call == 'NONE'
  CONDITION: h_stopper >= 2
  CONDITION: hcp >= 15
  CONDITION: hcp <= 17
  CONDITION: is_balanced == True

RULE B_1H_1NT_71_1:
  CALL: 1NT
  PRIORITY: 60
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: opp_last_call == '1H'
  CONDITION: partner_last_call == 'NONE'
  CONDITION: h_stopper >= 2
  CONDITION: hcp >= 15
  CONDITION: hcp <= 17
  CONDITION: is_semi_balanced == True

RULE B_1H_6C_93_0:
  CALL: 6C
  PRIORITY: 140
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: opp_last_call == '1H'
  CONDITION: partner_last_call == 'NONE'
  CONDITION: c_realsolid == True
  CONDITION: losing_trick_count == 1

RULE B_1H_6D_94_0:
  CALL: 6D
  PRIORITY: 140
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: opp_last_call == '1H'
  CONDITION: partner_last_call == 'NONE'
  CONDITION: d_realsolid == True
  CONDITION: losing_trick_count == 1

RULE B_1H_6S_95_0:
  CALL: 6S
  PRIORITY: 142
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: opp_last_call == '1H'
  CONDITION: partner_last_call == 'NONE'
  CONDITION: s_realsolid == True
  CONDITION: losing_trick_count == 1

RULE B_1H_7C_96_0:
  CALL: 7C
  PRIORITY: 141
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: opp_last_call == '1H'
  CONDITION: partner_last_call == 'NONE'
  CONDITION: c_realsolid == True
  CONDITION: losing_trick_count <= 0

RULE B_1H_7D_97_0:
  CALL: 7D
  PRIORITY: 141
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: opp_last_call == '1H'
  CONDITION: partner_last_call == 'NONE'
  CONDITION: d_realsolid == True
  CONDITION: losing_trick_count <= 0

RULE B_1H_7S_98_0:
  CALL: 7S
  PRIORITY: 143
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: opp_last_call == '1H'
  CONDITION: partner_last_call == 'NONE'
  CONDITION: s_realsolid == True
  CONDITION: losing_trick_count <= 0

RULE B_1H_X_99_0:
  CALL: X
  PRIORITY: 76
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: opp_last_call == '1H'
  CONDITION: partner_last_call == 'NONE'
  CONDITION: hcp >= 18
  CONDITION: heart_len <= 4

RULE B_1H_X_99_1:
  CALL: X
  PRIORITY: 76
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: opp_last_call == '1H'
  CONDITION: partner_last_call == 'NONE'
  CONDITION: hcp >= 18
  CONDITION: is_balanced == True

RULE B_1H_X_99_2:
  CALL: X
  PRIORITY: 76
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: opp_last_call == '1H'
  CONDITION: partner_last_call == 'NONE'
  CONDITION: hcp >= 10
  CONDITION: hcp <= 17
  CONDITION: heart_len <= 1
  CONDITION: spade_len >= 3
  CONDITION: club_len >= 3
  CONDITION: diamond_len >= 3

RULE B_1S_PASS_100_0:
  CALL: PASS
  PRIORITY: 1
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: opp_last_call == '1S'
  CONDITION: partner_last_call == 'NONE'

RULE B_1S_PASS_100_1:
  CALL: PASS
  PRIORITY: 1
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: opp_last_call == '1S'
  CONDITION: partner_last_call == 'NONE'
  CONDITION: spade_len >= 6

RULE B_1S_1NT_101_0:
  CALL: 1NT
  PRIORITY: 60
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: opp_last_call == '1S'
  CONDITION: partner_last_call == 'NONE'
  CONDITION: s_stopper >= 2
  CONDITION: hcp >= 15
  CONDITION: hcp <= 17
  CONDITION: is_balanced == True

RULE B_1S_1NT_101_1:
  CALL: 1NT
  PRIORITY: 60
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: opp_last_call == '1S'
  CONDITION: partner_last_call == 'NONE'
  CONDITION: s_stopper >= 2
  CONDITION: hcp >= 15
  CONDITION: hcp <= 17
  CONDITION: is_semi_balanced == True

RULE B_1S_6C_123_0:
  CALL: 6C
  PRIORITY: 140
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: opp_last_call == '1S'
  CONDITION: partner_last_call == 'NONE'
  CONDITION: c_realsolid == True
  CONDITION: losing_trick_count == 1

RULE B_1S_6D_124_0:
  CALL: 6D
  PRIORITY: 140
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: opp_last_call == '1S'
  CONDITION: partner_last_call == 'NONE'
  CONDITION: d_realsolid == True
  CONDITION: losing_trick_count == 1

RULE B_1S_6H_125_0:
  CALL: 6H
  PRIORITY: 142
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: opp_last_call == '1S'
  CONDITION: partner_last_call == 'NONE'
  CONDITION: h_realsolid == True
  CONDITION: losing_trick_count == 1

RULE B_1S_7C_126_0:
  CALL: 7C
  PRIORITY: 141
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: opp_last_call == '1S'
  CONDITION: partner_last_call == 'NONE'
  CONDITION: c_realsolid == True
  CONDITION: losing_trick_count <= 0

RULE B_1S_7D_127_0:
  CALL: 7D
  PRIORITY: 141
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: opp_last_call == '1S'
  CONDITION: partner_last_call == 'NONE'
  CONDITION: d_realsolid == True
  CONDITION: losing_trick_count <= 0

RULE B_1S_7H_128_0:
  CALL: 7H
  PRIORITY: 143
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: opp_last_call == '1S'
  CONDITION: partner_last_call == 'NONE'
  CONDITION: h_realsolid == True
  CONDITION: losing_trick_count <= 0

RULE B_1S_X_129_0:
  CALL: X
  PRIORITY: 76
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: opp_last_call == '1S'
  CONDITION: partner_last_call == 'NONE'
  CONDITION: hcp >= 18
  CONDITION: spade_len <= 4

RULE B_1S_X_129_1:
  CALL: X
  PRIORITY: 76
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: opp_last_call == '1S'
  CONDITION: partner_last_call == 'NONE'
  CONDITION: hcp >= 18
  CONDITION: is_balanced == True

RULE B_1S_X_129_2:
  CALL: X
  PRIORITY: 76
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: opp_last_call == '1S'
  CONDITION: partner_last_call == 'NONE'
  CONDITION: hcp >= 10
  CONDITION: hcp <= 17
  CONDITION: spade_len <= 1
  CONDITION: heart_len >= 3
  CONDITION: club_len >= 3
  CONDITION: diamond_len >= 3

RULE B_2C_PASS_130_0:
  CALL: PASS
  PRIORITY: -1
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: opp_last_call == '2C'
  CONDITION: partner_last_call == 'NONE'

RULE B_2D_PASS_145_0:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: opp_last_call == '2D'
  CONDITION: partner_last_call == 'NONE'
  CONDITION: hcp <= 15

RULE B_2D_PASS_145_1:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: opp_last_call == '2D'
  CONDITION: partner_last_call == 'NONE'
  CONDITION: diamond_len >= 5

RULE B_2D_2H_146_0:
  CALL: 2H
  PRIORITY: 90
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: opp_last_call == '2D'
  CONDITION: partner_last_call == 'NONE'
  CONDITION: h_is_best_major == True
  CONDITION: heart_len >= 6
  CONDITION: hcp >= 11
  CONDITION: hcp <= 17

RULE B_2D_2H_146_1:
  CALL: 2H
  PRIORITY: 90
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: opp_last_call == '2D'
  CONDITION: partner_last_call == 'NONE'
  CONDITION: h_is_best_major == True
  CONDITION: heart_len >= 5
  CONDITION: hcp >= 13
  CONDITION: hcp <= 18

RULE B_2D_2S_147_0:
  CALL: 2S
  PRIORITY: 90
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: opp_last_call == '2D'
  CONDITION: partner_last_call == 'NONE'
  CONDITION: s_is_best_major == True
  CONDITION: spade_len >= 6
  CONDITION: hcp >= 11
  CONDITION: hcp <= 17

RULE B_2D_2S_147_1:
  CALL: 2S
  PRIORITY: 90
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: opp_last_call == '2D'
  CONDITION: partner_last_call == 'NONE'
  CONDITION: s_is_best_major == True
  CONDITION: spade_len >= 5
  CONDITION: hcp >= 13
  CONDITION: hcp <= 18

RULE B_2D_2NT_148_0:
  CALL: 2NT
  PRIORITY: 80
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: opp_last_call == '2D'
  CONDITION: partner_last_call == 'NONE'
  CONDITION: hcp >= 15
  CONDITION: hcp <= 18
  CONDITION: is_semi_balanced == True
  CONDITION: d_stopper >= 2

RULE B_2D_3C_149_0:
  CALL: 3C
  PRIORITY: 79
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: opp_last_call == '2D'
  CONDITION: partner_last_call == 'NONE'
  CONDITION: club_len >= 5
  CONDITION: hcp >= 14
  CONDITION: hcp <= 19
  CONDITION: c_is_longest == True

RULE B_2D_3C_149_1:
  CALL: 3C
  PRIORITY: 79
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: opp_last_call == '2D'
  CONDITION: partner_last_call == 'NONE'
  CONDITION: club_len >= 5
  CONDITION: hcp >= 14
  CONDITION: hcp <= 19
  CONDITION: heart_len <= 2
  CONDITION: c_is_longest == True

RULE B_2D_3C_149_2:
  CALL: 3C
  PRIORITY: 79
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: opp_last_call == '2D'
  CONDITION: partner_last_call == 'NONE'
  CONDITION: club_len >= 5
  CONDITION: hcp >= 14
  CONDITION: hcp <= 19
  CONDITION: spade_len <= 2
  CONDITION: c_is_longest == True

RULE B_2D_3H_151_0:
  CALL: 3H
  PRIORITY: 93
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: opp_last_call == '2D'
  CONDITION: partner_last_call == 'NONE'
  CONDITION: heart_len >= 7
  CONDITION: hcp >= 19

RULE B_2D_3S_152_0:
  CALL: 3S
  PRIORITY: 93
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: opp_last_call == '2D'
  CONDITION: partner_last_call == 'NONE'
  CONDITION: spade_len >= 7
  CONDITION: hcp >= 19

RULE B_2D_3NT_153_0:
  CALL: 3NT
  PRIORITY: 82
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: opp_last_call == '2D'
  CONDITION: partner_last_call == 'NONE'
  CONDITION: hcp >= 19
  CONDITION: hcp <= 24
  CONDITION: is_semi_balanced == True
  CONDITION: d_stopper >= 2

RULE B_2D_4C_154_0:
  CALL: 4C
  PRIORITY: 95
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: opp_last_call == '2D'
  CONDITION: partner_last_call == 'NONE'
  CONDITION: club_len >= 7
  CONDITION: hcp >= 19
  CONDITION: hcp <= 24

RULE B_2D_4H_155_0:
  CALL: 4H
  PRIORITY: 97
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: opp_last_call == '2D'
  CONDITION: partner_last_call == 'NONE'
  CONDITION: heart_len >= 7
  CONDITION: hcp >= 12
  CONDITION: hcp <= 14

RULE B_2D_4H_155_1:
  CALL: 4H
  PRIORITY: 97
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: opp_last_call == '2D'
  CONDITION: partner_last_call == 'NONE'
  CONDITION: heart_len >= 7
  CONDITION: losing_trick_count <= 3
  CONDITION: hcp <= 15

RULE B_2D_4S_156_0:
  CALL: 4S
  PRIORITY: 97
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: opp_last_call == '2D'
  CONDITION: partner_last_call == 'NONE'
  CONDITION: spade_len >= 7
  CONDITION: hcp >= 12
  CONDITION: hcp <= 14

RULE B_2D_4S_156_1:
  CALL: 4S
  PRIORITY: 97
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: opp_last_call == '2D'
  CONDITION: partner_last_call == 'NONE'
  CONDITION: spade_len >= 7
  CONDITION: losing_trick_count <= 3
  CONDITION: hcp <= 15

RULE B_2D_6C_157_0:
  CALL: 6C
  PRIORITY: 140
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: opp_last_call == '2D'
  CONDITION: partner_last_call == 'NONE'
  CONDITION: c_realsolid == True
  CONDITION: losing_trick_count == 1

RULE B_2D_6H_158_0:
  CALL: 6H
  PRIORITY: 142
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: opp_last_call == '2D'
  CONDITION: partner_last_call == 'NONE'
  CONDITION: h_realsolid == True
  CONDITION: losing_trick_count == 1

RULE B_2D_6S_159_0:
  CALL: 6S
  PRIORITY: 142
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: opp_last_call == '2D'
  CONDITION: partner_last_call == 'NONE'
  CONDITION: s_realsolid == True
  CONDITION: losing_trick_count == 1

RULE B_2D_7C_160_0:
  CALL: 7C
  PRIORITY: 141
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: opp_last_call == '2D'
  CONDITION: partner_last_call == 'NONE'
  CONDITION: c_realsolid == True
  CONDITION: losing_trick_count <= 0

RULE B_2D_7H_161_0:
  CALL: 7H
  PRIORITY: 143
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: opp_last_call == '2D'
  CONDITION: partner_last_call == 'NONE'
  CONDITION: h_realsolid == True
  CONDITION: losing_trick_count <= 0

RULE B_2D_7S_162_0:
  CALL: 7S
  PRIORITY: 143
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: opp_last_call == '2D'
  CONDITION: partner_last_call == 'NONE'
  CONDITION: s_realsolid == True
  CONDITION: losing_trick_count <= 0

RULE B_2D_X_163_0:
  CALL: X
  PRIORITY: 105
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: opp_last_call == '2D'
  CONDITION: partner_last_call == 'NONE'
  CONDITION: hcp >= 12
  CONDITION: diamond_len <= 1
  CONDITION: spade_len >= 3
  CONDITION: heart_len >= 3
  CONDITION: club_len <= 5

RULE B_2D_X_163_1:
  CALL: X
  PRIORITY: 105
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: opp_last_call == '2D'
  CONDITION: partner_last_call == 'NONE'
  CONDITION: hcp >= 13
  CONDITION: spade_len >= 3
  CONDITION: heart_len >= 4

RULE B_2D_X_163_2:
  CALL: X
  PRIORITY: 105
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: opp_last_call == '2D'
  CONDITION: partner_last_call == 'NONE'
  CONDITION: hcp >= 13
  CONDITION: spade_len >= 4
  CONDITION: heart_len >= 3

RULE B_2D_X_163_3:
  CALL: X
  PRIORITY: 105
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: opp_last_call == '2D'
  CONDITION: partner_last_call == 'NONE'
  CONDITION: hcp >= 16

RULE B_2D_X_163_4:
  CALL: X
  PRIORITY: 105
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: opp_last_call == '2D'
  CONDITION: partner_last_call == 'NONE'
  CONDITION: heart_len >= 6
  CONDITION: hcp >= 18
  CONDITION: losing_trick_count <= 4

RULE B_2D_X_163_5:
  CALL: X
  PRIORITY: 105
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: opp_last_call == '2D'
  CONDITION: partner_last_call == 'NONE'
  CONDITION: spade_len >= 6
  CONDITION: hcp >= 18
  CONDITION: losing_trick_count <= 4

RULE B_2H_PASS_164_0:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: opp_last_call == '2H'
  CONDITION: partner_last_call == 'NONE'
  CONDITION: hcp <= 17

RULE B_2H_2S_165_0:
  CALL: 2S
  PRIORITY: 18
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: opp_last_call == '2H'
  CONDITION: partner_last_call == 'NONE'
  CONDITION: spade_len >= 6
  CONDITION: hcp >= 10
  CONDITION: hcp <= 12
  CONDITION: s_top3_honors >= 2

RULE B_2H_2S_166_0:
  CALL: 2S
  PRIORITY: 20
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: opp_last_call == '2H'
  CONDITION: partner_last_call == 'NONE'
  CONDITION: spade_len >= 5
  CONDITION: hcp >= 13
  CONDITION: hcp <= 19

RULE B_2H_2NT_167_0:
  CALL: 2NT
  PRIORITY: 100
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: opp_last_call == '2H'
  CONDITION: partner_last_call == 'NONE'
  CONDITION: hcp >= 15
  CONDITION: hcp <= 18
  CONDITION: is_semi_balanced == True
  CONDITION: h_stopper >= 3

RULE B_2H_2NT_167_1:
  CALL: 2NT
  PRIORITY: 100
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: opp_last_call == '2H'
  CONDITION: partner_last_call == 'NONE'
  CONDITION: hcp >= 16
  CONDITION: hcp <= 18
  CONDITION: is_semi_balanced == True
  CONDITION: h_stopper >= 2

RULE B_2H_3C_168_0:
  CALL: 3C
  PRIORITY: 20
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: opp_last_call == '2H'
  CONDITION: partner_last_call == 'NONE'
  CONDITION: c_is_best_minor == True
  CONDITION: club_len >= 5
  CONDITION: spade_len <= 2
  CONDITION: hcp >= 14
  CONDITION: hcp <= 19
  CONDITION: d_top3_honors >= 2

RULE B_2H_3C_168_1:
  CALL: 3C
  PRIORITY: 20
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: opp_last_call == '2H'
  CONDITION: partner_last_call == 'NONE'
  CONDITION: c_is_best_minor == True
  CONDITION: club_len >= 6
  CONDITION: hcp >= 14
  CONDITION: hcp <= 19

RULE B_2H_3D_169_0:
  CALL: 3D
  PRIORITY: 20
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: opp_last_call == '2H'
  CONDITION: partner_last_call == 'NONE'
  CONDITION: d_is_best_minor == True
  CONDITION: diamond_len >= 5
  CONDITION: spade_len <= 2
  CONDITION: hcp >= 14
  CONDITION: hcp <= 19
  CONDITION: d_top3_honors >= 2

RULE B_2H_3D_169_1:
  CALL: 3D
  PRIORITY: 20
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: opp_last_call == '2H'
  CONDITION: partner_last_call == 'NONE'
  CONDITION: d_is_best_minor == True
  CONDITION: diamond_len >= 6
  CONDITION: hcp >= 14
  CONDITION: hcp <= 19

RULE B_2H_3S_171_0:
  CALL: 3S
  PRIORITY: 30
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: opp_last_call == '2H'
  CONDITION: partner_last_call == 'NONE'
  CONDITION: spade_len >= 6
  CONDITION: hcp >= 19
  CONDITION: losing_trick_count >= 4

RULE B_2H_3NT_172_0:
  CALL: 3NT
  PRIORITY: 50
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: opp_last_call == '2H'
  CONDITION: partner_last_call == 'NONE'
  CONDITION: hcp >= 19
  CONDITION: hcp <= 24
  CONDITION: is_semi_balanced == True
  CONDITION: h_stopper >= 2

RULE B_2H_3NT_172_1:
  CALL: 3NT
  PRIORITY: 50
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: opp_last_call == '2H'
  CONDITION: partner_last_call == 'NONE'
  CONDITION: hcp >= 20
  CONDITION: hcp <= 24
  CONDITION: heart_len >= 4
  CONDITION: h_stopper >= 2

RULE B_2H_4H_175_0:
  CALL: 4H
  PRIORITY: 120
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: opp_last_call == '2H'
  CONDITION: partner_last_call == 'NONE'
  CONDITION: diamond_len >= 5
  CONDITION: club_len >= 5
  CONDITION: losing_trick_count <= 4
  CONDITION: hcp >= 17

RULE B_2H_4S_176_0:
  CALL: 4S
  PRIORITY: 29
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: opp_last_call == '2H'
  CONDITION: partner_last_call == 'NONE'
  CONDITION: spade_len >= 7
  CONDITION: spade_hcp >= 18
  CONDITION: losing_trick_count <= 4

RULE B_2H_6C_178_0:
  CALL: 6C
  PRIORITY: 140
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: opp_last_call == '2H'
  CONDITION: partner_last_call == 'NONE'
  CONDITION: c_realsolid == True
  CONDITION: losing_trick_count == 1

RULE B_2H_6D_179_0:
  CALL: 6D
  PRIORITY: 140
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: opp_last_call == '2H'
  CONDITION: partner_last_call == 'NONE'
  CONDITION: d_realsolid == True
  CONDITION: losing_trick_count == 1

RULE B_2H_6S_180_0:
  CALL: 6S
  PRIORITY: 142
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: opp_last_call == '2H'
  CONDITION: partner_last_call == 'NONE'
  CONDITION: s_realsolid == True
  CONDITION: losing_trick_count == 1

RULE B_2H_7C_181_0:
  CALL: 7C
  PRIORITY: 141
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: opp_last_call == '2H'
  CONDITION: partner_last_call == 'NONE'
  CONDITION: c_realsolid == True
  CONDITION: losing_trick_count <= 0

RULE B_2H_7D_182_0:
  CALL: 7D
  PRIORITY: 141
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: opp_last_call == '2H'
  CONDITION: partner_last_call == 'NONE'
  CONDITION: d_realsolid == True
  CONDITION: losing_trick_count <= 0

RULE B_2H_7S_183_0:
  CALL: 7S
  PRIORITY: 143
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: opp_last_call == '2H'
  CONDITION: partner_last_call == 'NONE'
  CONDITION: s_realsolid == True
  CONDITION: losing_trick_count <= 0

RULE B_2H_X_184_0:
  CALL: X
  PRIORITY: 24
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: opp_last_call == '2H'
  CONDITION: partner_last_call == 'NONE'
  CONDITION: hcp >= 15
  CONDITION: spade_len >= 3
  CONDITION: heart_len <= 3

RULE B_2H_X_184_1:
  CALL: X
  PRIORITY: 24
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: opp_last_call == '2H'
  CONDITION: partner_last_call == 'NONE'
  CONDITION: hcp >= 13
  CONDITION: spade_len >= 4
  CONDITION: club_len >= 2
  CONDITION: diamond_len >= 2
  CONDITION: heart_len <= 3

RULE B_2H_X_184_2:
  CALL: X
  PRIORITY: 24
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: opp_last_call == '2H'
  CONDITION: partner_last_call == 'NONE'
  CONDITION: hcp >= 18

RULE B_2S_PASS_185_0:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: opp_last_call == '2S'
  CONDITION: partner_last_call == 'NONE'
  CONDITION: hcp <= 17

RULE B_2S_2NT_186_0:
  CALL: 2NT
  PRIORITY: 100
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: opp_last_call == '2S'
  CONDITION: partner_last_call == 'NONE'
  CONDITION: hcp >= 15
  CONDITION: hcp <= 18
  CONDITION: is_semi_balanced == True
  CONDITION: s_stopper >= 3

RULE B_2S_2NT_186_1:
  CALL: 2NT
  PRIORITY: 100
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: opp_last_call == '2S'
  CONDITION: partner_last_call == 'NONE'
  CONDITION: hcp >= 16
  CONDITION: hcp <= 18
  CONDITION: is_semi_balanced == True
  CONDITION: s_stopper >= 2

RULE B_2S_3C_187_0:
  CALL: 3C
  PRIORITY: 20
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: opp_last_call == '2S'
  CONDITION: partner_last_call == 'NONE'
  CONDITION: c_is_best_minor == True
  CONDITION: club_len >= 5
  CONDITION: heart_len <= 2
  CONDITION: hcp >= 14
  CONDITION: hcp <= 19
  CONDITION: d_top3_honors >= 2

RULE B_2S_3C_187_1:
  CALL: 3C
  PRIORITY: 20
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: opp_last_call == '2S'
  CONDITION: partner_last_call == 'NONE'
  CONDITION: c_is_best_minor == True
  CONDITION: club_len >= 6
  CONDITION: hcp >= 14
  CONDITION: hcp <= 19

RULE B_2S_3D_188_0:
  CALL: 3D
  PRIORITY: 20
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: opp_last_call == '2S'
  CONDITION: partner_last_call == 'NONE'
  CONDITION: d_is_best_minor == True
  CONDITION: diamond_len >= 5
  CONDITION: heart_len <= 2
  CONDITION: hcp >= 14
  CONDITION: hcp <= 19
  CONDITION: d_top3_honors >= 2

RULE B_2S_3D_188_1:
  CALL: 3D
  PRIORITY: 20
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: opp_last_call == '2S'
  CONDITION: partner_last_call == 'NONE'
  CONDITION: d_is_best_minor == True
  CONDITION: diamond_len >= 6
  CONDITION: hcp >= 14
  CONDITION: hcp <= 19

RULE B_2S_3H_189_0:
  CALL: 3H
  PRIORITY: 20
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: opp_last_call == '2S'
  CONDITION: partner_last_call == 'NONE'
  CONDITION: heart_len >= 6
  CONDITION: hcp >= 13
  CONDITION: hcp <= 19

RULE B_2S_3NT_191_0:
  CALL: 3NT
  PRIORITY: 50
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: opp_last_call == '2S'
  CONDITION: partner_last_call == 'NONE'
  CONDITION: hcp >= 19
  CONDITION: hcp <= 24
  CONDITION: is_semi_balanced == True
  CONDITION: s_stopper >= 2

RULE B_2S_3NT_191_1:
  CALL: 3NT
  PRIORITY: 50
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: opp_last_call == '2S'
  CONDITION: partner_last_call == 'NONE'
  CONDITION: hcp >= 20
  CONDITION: hcp <= 24
  CONDITION: spade_len >= 4
  CONDITION: s_stopper >= 2

RULE B_2S_4H_194_0:
  CALL: 4H
  PRIORITY: 30
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: opp_last_call == '2S'
  CONDITION: partner_last_call == 'NONE'
  CONDITION: heart_len >= 7
  CONDITION: heart_hcp >= 18
  CONDITION: losing_trick_count <= 4

RULE B_2S_4H_194_1_0:
  CALL: 4H
  PRIORITY: 30
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: opp_last_call == '2S'
  CONDITION: partner_last_call == 'NONE'
  CONDITION: heart_len >= 6
  CONDITION: losing_trick_count <= 4
  CONDITION: hcp >= 15
  CONDITION: h_has_ace == True
  CONDITION: h_has_king == True
  CONDITION: h_has_queen == True

RULE B_2S_4H_194_1_1:
  CALL: 4H
  PRIORITY: 30
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: opp_last_call == '2S'
  CONDITION: partner_last_call == 'NONE'
  CONDITION: heart_len >= 6
  CONDITION: losing_trick_count <= 4
  CONDITION: hcp >= 15
  CONDITION: h_has_ace == True
  CONDITION: h_has_king == True
  CONDITION: h_has_jack == True

RULE B_2S_4H_194_1_2:
  CALL: 4H
  PRIORITY: 30
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: opp_last_call == '2S'
  CONDITION: partner_last_call == 'NONE'
  CONDITION: heart_len >= 6
  CONDITION: losing_trick_count <= 4
  CONDITION: hcp >= 15
  CONDITION: h_has_ace == True
  CONDITION: h_has_king == True
  CONDITION: h_has_ten == True

RULE B_2S_4H_194_1_3:
  CALL: 4H
  PRIORITY: 30
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: opp_last_call == '2S'
  CONDITION: partner_last_call == 'NONE'
  CONDITION: heart_len >= 6
  CONDITION: losing_trick_count <= 4
  CONDITION: hcp >= 15
  CONDITION: h_has_ace == True
  CONDITION: h_has_queen == True
  CONDITION: h_has_jack == True

RULE B_2S_4H_194_1_4:
  CALL: 4H
  PRIORITY: 30
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: opp_last_call == '2S'
  CONDITION: partner_last_call == 'NONE'
  CONDITION: heart_len >= 6
  CONDITION: losing_trick_count <= 4
  CONDITION: hcp >= 15
  CONDITION: h_has_ace == True
  CONDITION: h_has_queen == True
  CONDITION: h_has_ten == True

RULE B_2S_4H_194_1_5:
  CALL: 4H
  PRIORITY: 30
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: opp_last_call == '2S'
  CONDITION: partner_last_call == 'NONE'
  CONDITION: heart_len >= 6
  CONDITION: losing_trick_count <= 4
  CONDITION: hcp >= 15
  CONDITION: h_has_ace == True
  CONDITION: h_has_jack == True
  CONDITION: h_has_ten == True

RULE B_2S_4H_194_1_6:
  CALL: 4H
  PRIORITY: 30
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: opp_last_call == '2S'
  CONDITION: partner_last_call == 'NONE'
  CONDITION: heart_len >= 6
  CONDITION: losing_trick_count <= 4
  CONDITION: hcp >= 15
  CONDITION: h_has_king == True
  CONDITION: h_has_queen == True
  CONDITION: h_has_jack == True

RULE B_2S_4H_194_1_7:
  CALL: 4H
  PRIORITY: 30
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: opp_last_call == '2S'
  CONDITION: partner_last_call == 'NONE'
  CONDITION: heart_len >= 6
  CONDITION: losing_trick_count <= 4
  CONDITION: hcp >= 15
  CONDITION: h_has_king == True
  CONDITION: h_has_queen == True
  CONDITION: h_has_ten == True

RULE B_2S_4H_194_1_8:
  CALL: 4H
  PRIORITY: 30
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: opp_last_call == '2S'
  CONDITION: partner_last_call == 'NONE'
  CONDITION: heart_len >= 6
  CONDITION: losing_trick_count <= 4
  CONDITION: hcp >= 15
  CONDITION: h_has_king == True
  CONDITION: h_has_jack == True
  CONDITION: h_has_ten == True

RULE B_2S_4H_194_1_9:
  CALL: 4H
  PRIORITY: 30
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: opp_last_call == '2S'
  CONDITION: partner_last_call == 'NONE'
  CONDITION: heart_len >= 6
  CONDITION: losing_trick_count <= 4
  CONDITION: hcp >= 15
  CONDITION: h_has_queen == True
  CONDITION: h_has_jack == True
  CONDITION: h_has_ten == True

RULE B_2S_4S_195_0:
  CALL: 4S
  PRIORITY: 120
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: opp_last_call == '2S'
  CONDITION: partner_last_call == 'NONE'
  CONDITION: diamond_len >= 5
  CONDITION: club_len >= 5
  CONDITION: losing_trick_count <= 4
  CONDITION: hcp >= 17

RULE B_2S_6C_197_0:
  CALL: 6C
  PRIORITY: 140
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: opp_last_call == '2S'
  CONDITION: partner_last_call == 'NONE'
  CONDITION: c_realsolid == True
  CONDITION: losing_trick_count == 1

RULE B_2S_6D_198_0:
  CALL: 6D
  PRIORITY: 140
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: opp_last_call == '2S'
  CONDITION: partner_last_call == 'NONE'
  CONDITION: d_realsolid == True
  CONDITION: losing_trick_count == 1

RULE B_2S_6H_199_0:
  CALL: 6H
  PRIORITY: 142
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: opp_last_call == '2S'
  CONDITION: partner_last_call == 'NONE'
  CONDITION: h_realsolid == True
  CONDITION: losing_trick_count == 1

RULE B_2S_7C_200_0:
  CALL: 7C
  PRIORITY: 141
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: opp_last_call == '2S'
  CONDITION: partner_last_call == 'NONE'
  CONDITION: c_realsolid == True
  CONDITION: losing_trick_count <= 0

RULE B_2S_7D_201_0:
  CALL: 7D
  PRIORITY: 141
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: opp_last_call == '2S'
  CONDITION: partner_last_call == 'NONE'
  CONDITION: d_realsolid == True
  CONDITION: losing_trick_count <= 0

RULE B_2S_7H_202_0:
  CALL: 7H
  PRIORITY: 143
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: opp_last_call == '2S'
  CONDITION: partner_last_call == 'NONE'
  CONDITION: h_realsolid == True
  CONDITION: losing_trick_count <= 0

RULE B_2S_X_203_0:
  CALL: X
  PRIORITY: 24
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: opp_last_call == '2S'
  CONDITION: partner_last_call == 'NONE'
  CONDITION: hcp >= 15
  CONDITION: heart_len >= 3
  CONDITION: spade_len <= 3

RULE B_2S_X_203_1:
  CALL: X
  PRIORITY: 24
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: opp_last_call == '2S'
  CONDITION: partner_last_call == 'NONE'
  CONDITION: hcp >= 13
  CONDITION: heart_len >= 4
  CONDITION: club_len >= 2
  CONDITION: diamond_len >= 2
  CONDITION: spade_len <= 3

RULE B_2S_X_203_2:
  CALL: X
  PRIORITY: 24
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: opp_last_call == '2S'
  CONDITION: partner_last_call == 'NONE'
  CONDITION: hcp >= 18

RULE B_3C_PASS_204_0:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: opp_last_call == '3C'
  CONDITION: partner_last_call == 'NONE'
  CONDITION: hcp <= 20
  CONDITION: club_len >= 4

RULE B_3C_PASS_204_1:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: opp_last_call == '3C'
  CONDITION: partner_last_call == 'NONE'
  CONDITION: hcp <= 17
  CONDITION: spade_len <= 2

RULE B_3C_PASS_204_2:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: opp_last_call == '3C'
  CONDITION: partner_last_call == 'NONE'
  CONDITION: hcp <= 17
  CONDITION: heart_len <= 2

RULE B_3C_PASS_204_3:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: opp_last_call == '3C'
  CONDITION: partner_last_call == 'NONE'
  CONDITION: hcp <= 16
  CONDITION: club_len >= 3

RULE B_3C_PASS_204_4:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: opp_last_call == '3C'
  CONDITION: partner_last_call == 'NONE'
  CONDITION: hcp <= 14

RULE B_3C_3D_205_0:
  CALL: 3D
  PRIORITY: 31
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: opp_last_call == '3C'
  CONDITION: partner_last_call == 'NONE'
  CONDITION: diamond_len >= 5
  CONDITION: diamond_hcp >= 13
  CONDITION: hcp >= 11
  CONDITION: hcp <= 19
  CONDITION: spade_len <= 4
  CONDITION: heart_len <= 4

RULE B_3C_3D_205_1:
  CALL: 3D
  PRIORITY: 31
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: opp_last_call == '3C'
  CONDITION: partner_last_call == 'NONE'
  CONDITION: diamond_len >= 6
  CONDITION: diamond_hcp >= 14
  CONDITION: hcp >= 12
  CONDITION: hcp <= 19
  CONDITION: spade_len <= 5
  CONDITION: heart_len <= 5

RULE B_3C_3H_206_0:
  CALL: 3H
  PRIORITY: 55
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: opp_last_call == '3C'
  CONDITION: partner_last_call == 'NONE'
  CONDITION: heart_len >= 7
  CONDITION: losing_trick_count <= 5
  CONDITION: hcp >= 10
  CONDITION: h_top2_honors >= 1

RULE B_3C_3H_207_0:
  CALL: 3H
  PRIORITY: 57
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: opp_last_call == '3C'
  CONDITION: partner_last_call == 'NONE'
  CONDITION: heart_len >= 6
  CONDITION: losing_trick_count <= 5
  CONDITION: hcp >= 11
  CONDITION: h_top3_honors >= 2

RULE B_3C_3H_208_0:
  CALL: 3H
  PRIORITY: 60
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: opp_last_call == '3C'
  CONDITION: partner_last_call == 'NONE'
  CONDITION: heart_len >= 5
  CONDITION: hcp >= 14
  CONDITION: hcp <= 19

RULE B_3C_3H_208_1:
  CALL: 3H
  PRIORITY: 60
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: opp_last_call == '3C'
  CONDITION: partner_last_call == 'NONE'
  CONDITION: heart_len >= 5
  CONDITION: spade_len <= 1
  CONDITION: hcp >= 14
  CONDITION: hcp <= 20

RULE B_3C_3H_208_2:
  CALL: 3H
  PRIORITY: 60
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: opp_last_call == '3C'
  CONDITION: partner_last_call == 'NONE'
  CONDITION: heart_len >= 6
  CONDITION: hcp >= 14
  CONDITION: hcp <= 19

RULE B_3C_3S_209_0:
  CALL: 3S
  PRIORITY: 55
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: opp_last_call == '3C'
  CONDITION: partner_last_call == 'NONE'
  CONDITION: spade_len >= 7
  CONDITION: losing_trick_count <= 5
  CONDITION: hcp >= 10
  CONDITION: s_top2_honors >= 1

RULE B_3C_3S_210_0:
  CALL: 3S
  PRIORITY: 57
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: opp_last_call == '3C'
  CONDITION: partner_last_call == 'NONE'
  CONDITION: spade_len >= 6
  CONDITION: losing_trick_count <= 5
  CONDITION: hcp >= 11
  CONDITION: s_top3_honors >= 2

RULE B_3C_3S_211_0:
  CALL: 3S
  PRIORITY: 60
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: opp_last_call == '3C'
  CONDITION: partner_last_call == 'NONE'
  CONDITION: spade_len >= 5
  CONDITION: hcp >= 14
  CONDITION: hcp <= 19

RULE B_3C_3S_211_1:
  CALL: 3S
  PRIORITY: 60
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: opp_last_call == '3C'
  CONDITION: partner_last_call == 'NONE'
  CONDITION: spade_len >= 5
  CONDITION: heart_len <= 1
  CONDITION: hcp >= 14
  CONDITION: hcp <= 20

RULE B_3C_3S_211_2:
  CALL: 3S
  PRIORITY: 60
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: opp_last_call == '3C'
  CONDITION: partner_last_call == 'NONE'
  CONDITION: spade_len >= 6
  CONDITION: hcp >= 14
  CONDITION: hcp <= 19

RULE B_3C_3NT_212_0:
  CALL: 3NT
  PRIORITY: 50
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: opp_last_call == '3C'
  CONDITION: partner_last_call == 'NONE'
  CONDITION: hcp >= 16
  CONDITION: c_stopper >= 2

RULE B_3C_3NT_212_1:
  CALL: 3NT
  PRIORITY: 50
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: opp_last_call == '3C'
  CONDITION: partner_last_call == 'NONE'
  CONDITION: hcp >= 17
  CONDITION: c_stopper >= 2

RULE B_3C_4C_213_0:
  CALL: 4C
  PRIORITY: 70
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: opp_last_call == '3C'
  CONDITION: partner_last_call == 'NONE'
  CONDITION: heart_len >= 5
  CONDITION: spade_len >= 5
  CONDITION: losing_trick_count <= 5
  CONDITION: club_len <= 4
  CONDITION: controls >= 5

RULE B_3C_4H_214_0:
  CALL: 4H
  PRIORITY: 72
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: opp_last_call == '3C'
  CONDITION: partner_last_call == 'NONE'
  CONDITION: heart_len >= 7
  CONDITION: losing_trick_count <= 4
  CONDITION: hcp >= 12
  CONDITION: h_top3_honors >= 2

RULE B_3C_4H_215_0:
  CALL: 4H
  PRIORITY: 73
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: opp_last_call == '3C'
  CONDITION: partner_last_call == 'NONE'
  CONDITION: heart_len >= 6
  CONDITION: losing_trick_count <= 4
  CONDITION: hcp >= 14
  CONDITION: h_top3_honors >= 2

RULE B_3C_4H_216_0:
  CALL: 4H
  PRIORITY: 74
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: opp_last_call == '3C'
  CONDITION: partner_last_call == 'NONE'
  CONDITION: heart_len >= 6
  CONDITION: hcp >= 17

RULE B_3C_4S_217_0:
  CALL: 4S
  PRIORITY: 72
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: opp_last_call == '3C'
  CONDITION: partner_last_call == 'NONE'
  CONDITION: spade_len >= 7
  CONDITION: losing_trick_count <= 4
  CONDITION: hcp >= 12
  CONDITION: s_top3_honors >= 2

RULE B_3C_4S_218_0:
  CALL: 4S
  PRIORITY: 73
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: opp_last_call == '3C'
  CONDITION: partner_last_call == 'NONE'
  CONDITION: spade_len >= 6
  CONDITION: losing_trick_count <= 4
  CONDITION: hcp >= 14
  CONDITION: s_top3_honors >= 2

RULE B_3C_4S_219_0:
  CALL: 4S
  PRIORITY: 74
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: opp_last_call == '3C'
  CONDITION: partner_last_call == 'NONE'
  CONDITION: spade_len >= 6
  CONDITION: hcp >= 17

RULE B_3C_6D_221_0:
  CALL: 6D
  PRIORITY: 140
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: opp_last_call == '3C'
  CONDITION: partner_last_call == 'NONE'
  CONDITION: d_realsolid == True
  CONDITION: losing_trick_count == 1

RULE B_3C_6H_222_0:
  CALL: 6H
  PRIORITY: 142
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: opp_last_call == '3C'
  CONDITION: partner_last_call == 'NONE'
  CONDITION: h_realsolid == True
  CONDITION: losing_trick_count == 1

RULE B_3C_6S_223_0:
  CALL: 6S
  PRIORITY: 142
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: opp_last_call == '3C'
  CONDITION: partner_last_call == 'NONE'
  CONDITION: s_realsolid == True
  CONDITION: losing_trick_count == 1

RULE B_3C_7D_224_0:
  CALL: 7D
  PRIORITY: 141
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: opp_last_call == '3C'
  CONDITION: partner_last_call == 'NONE'
  CONDITION: d_realsolid == True
  CONDITION: losing_trick_count <= 0

RULE B_3C_7H_225_0:
  CALL: 7H
  PRIORITY: 143
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: opp_last_call == '3C'
  CONDITION: partner_last_call == 'NONE'
  CONDITION: h_realsolid == True
  CONDITION: losing_trick_count <= 0

RULE B_3C_7S_226_0:
  CALL: 7S
  PRIORITY: 143
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: opp_last_call == '3C'
  CONDITION: partner_last_call == 'NONE'
  CONDITION: s_realsolid == True
  CONDITION: losing_trick_count <= 0

RULE B_3C_X_227_0:
  CALL: X
  PRIORITY: 32
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: opp_last_call == '3C'
  CONDITION: partner_last_call == 'NONE'
  CONDITION: hcp >= 13
  CONDITION: heart_len >= 3
  CONDITION: spade_len >= 3
  CONDITION: club_len <= 3
  CONDITION: c_is_longest == False

RULE B_3C_X_227_1:
  CALL: X
  PRIORITY: 32
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: opp_last_call == '3C'
  CONDITION: partner_last_call == 'NONE'
  CONDITION: hcp >= 14
  CONDITION: heart_len >= 4
  CONDITION: spade_len >= 4

RULE B_3C_X_227_3:
  CALL: X
  PRIORITY: 32
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: opp_last_call == '3C'
  CONDITION: partner_last_call == 'NONE'
  CONDITION: hcp >= 20

RULE B_3D_PASS_228_0:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: opp_last_call == '3D'
  CONDITION: partner_last_call == 'NONE'
  CONDITION: hcp <= 20
  CONDITION: diamond_len >= 4

RULE B_3D_PASS_228_1:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: opp_last_call == '3D'
  CONDITION: partner_last_call == 'NONE'
  CONDITION: hcp <= 17
  CONDITION: spade_len <= 2

RULE B_3D_PASS_228_2:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: opp_last_call == '3D'
  CONDITION: partner_last_call == 'NONE'
  CONDITION: hcp <= 17
  CONDITION: heart_len <= 2

RULE B_3D_PASS_228_3:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: opp_last_call == '3D'
  CONDITION: partner_last_call == 'NONE'
  CONDITION: hcp <= 16
  CONDITION: diamond_len >= 3

RULE B_3D_PASS_228_4:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: opp_last_call == '3D'
  CONDITION: partner_last_call == 'NONE'
  CONDITION: hcp <= 14

RULE B_3D_3H_229_0:
  CALL: 3H
  PRIORITY: 55
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: opp_last_call == '3D'
  CONDITION: partner_last_call == 'NONE'
  CONDITION: heart_len >= 7
  CONDITION: losing_trick_count <= 5
  CONDITION: hcp >= 10
  CONDITION: h_top2_honors >= 1

RULE B_3D_3H_230_0:
  CALL: 3H
  PRIORITY: 57
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: opp_last_call == '3D'
  CONDITION: partner_last_call == 'NONE'
  CONDITION: heart_len >= 6
  CONDITION: losing_trick_count <= 5
  CONDITION: hcp >= 11
  CONDITION: h_top3_honors >= 2

RULE B_3D_3H_231_0:
  CALL: 3H
  PRIORITY: 60
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: opp_last_call == '3D'
  CONDITION: partner_last_call == 'NONE'
  CONDITION: heart_len >= 5
  CONDITION: hcp >= 14
  CONDITION: hcp <= 19

RULE B_3D_3H_231_1:
  CALL: 3H
  PRIORITY: 60
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: opp_last_call == '3D'
  CONDITION: partner_last_call == 'NONE'
  CONDITION: heart_len >= 5
  CONDITION: spade_len <= 1
  CONDITION: hcp >= 14
  CONDITION: hcp <= 20

RULE B_3D_3H_231_2:
  CALL: 3H
  PRIORITY: 60
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: opp_last_call == '3D'
  CONDITION: partner_last_call == 'NONE'
  CONDITION: heart_len >= 6
  CONDITION: hcp >= 14
  CONDITION: hcp <= 19

RULE B_3D_3S_232_0:
  CALL: 3S
  PRIORITY: 55
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: opp_last_call == '3D'
  CONDITION: partner_last_call == 'NONE'
  CONDITION: spade_len >= 7
  CONDITION: losing_trick_count <= 5
  CONDITION: hcp >= 10
  CONDITION: s_top2_honors >= 1

RULE B_3D_3S_233_0:
  CALL: 3S
  PRIORITY: 57
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: opp_last_call == '3D'
  CONDITION: partner_last_call == 'NONE'
  CONDITION: spade_len >= 6
  CONDITION: losing_trick_count <= 5
  CONDITION: hcp >= 11
  CONDITION: s_top3_honors >= 2

RULE B_3D_3S_234_0:
  CALL: 3S
  PRIORITY: 60
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: opp_last_call == '3D'
  CONDITION: partner_last_call == 'NONE'
  CONDITION: spade_len >= 5
  CONDITION: hcp >= 14
  CONDITION: hcp <= 19

RULE B_3D_3S_234_1:
  CALL: 3S
  PRIORITY: 60
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: opp_last_call == '3D'
  CONDITION: partner_last_call == 'NONE'
  CONDITION: spade_len >= 5
  CONDITION: heart_len <= 1
  CONDITION: hcp >= 14
  CONDITION: hcp <= 20

RULE B_3D_3S_234_2:
  CALL: 3S
  PRIORITY: 60
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: opp_last_call == '3D'
  CONDITION: partner_last_call == 'NONE'
  CONDITION: spade_len >= 6
  CONDITION: hcp >= 14
  CONDITION: hcp <= 19

RULE B_3D_3NT_235_0:
  CALL: 3NT
  PRIORITY: 50
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: opp_last_call == '3D'
  CONDITION: partner_last_call == 'NONE'
  CONDITION: hcp >= 16
  CONDITION: d_stopper >= 2

RULE B_3D_3NT_235_1:
  CALL: 3NT
  PRIORITY: 50
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: opp_last_call == '3D'
  CONDITION: partner_last_call == 'NONE'
  CONDITION: hcp >= 17
  CONDITION: d_stopper >= 2

RULE B_3D_4C_236_0:
  CALL: 4C
  PRIORITY: 20
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: opp_last_call == '3D'
  CONDITION: partner_last_call == 'NONE'
  CONDITION: club_len >= 5
  CONDITION: club_hcp >= 14
  CONDITION: hcp <= 19
  CONDITION: hcp >= 14
  CONDITION: spade_len <= 4
  CONDITION: heart_len <= 4

RULE B_3D_4C_236_1:
  CALL: 4C
  PRIORITY: 20
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: opp_last_call == '3D'
  CONDITION: partner_last_call == 'NONE'
  CONDITION: club_len >= 6
  CONDITION: club_hcp >= 14
  CONDITION: hcp <= 19
  CONDITION: hcp >= 10
  CONDITION: spade_len <= 5
  CONDITION: heart_len <= 5

RULE B_3D_4D_237_0:
  CALL: 4D
  PRIORITY: 70
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: opp_last_call == '3D'
  CONDITION: partner_last_call == 'NONE'
  CONDITION: heart_len >= 5
  CONDITION: spade_len >= 5
  CONDITION: losing_trick_count <= 5
  CONDITION: diamond_len <= 4
  CONDITION: controls >= 5

RULE B_3D_4H_238_0:
  CALL: 4H
  PRIORITY: 72
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: opp_last_call == '3D'
  CONDITION: partner_last_call == 'NONE'
  CONDITION: heart_len >= 7
  CONDITION: losing_trick_count <= 4
  CONDITION: hcp >= 12
  CONDITION: h_top3_honors >= 2

RULE B_3D_4H_239_0:
  CALL: 4H
  PRIORITY: 73
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: opp_last_call == '3D'
  CONDITION: partner_last_call == 'NONE'
  CONDITION: heart_len >= 6
  CONDITION: losing_trick_count <= 4
  CONDITION: hcp >= 14
  CONDITION: h_top3_honors >= 2

RULE B_3D_4H_240_0:
  CALL: 4H
  PRIORITY: 74
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: opp_last_call == '3D'
  CONDITION: partner_last_call == 'NONE'
  CONDITION: heart_len >= 6
  CONDITION: hcp >= 17

RULE B_3D_4S_241_0:
  CALL: 4S
  PRIORITY: 72
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: opp_last_call == '3D'
  CONDITION: partner_last_call == 'NONE'
  CONDITION: spade_len >= 7
  CONDITION: losing_trick_count <= 4
  CONDITION: hcp >= 12
  CONDITION: s_top3_honors >= 2

RULE B_3D_4S_242_0:
  CALL: 4S
  PRIORITY: 73
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: opp_last_call == '3D'
  CONDITION: partner_last_call == 'NONE'
  CONDITION: spade_len >= 6
  CONDITION: losing_trick_count <= 4
  CONDITION: hcp >= 14
  CONDITION: s_top3_honors >= 2

RULE B_3D_4S_243_0:
  CALL: 4S
  PRIORITY: 74
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: opp_last_call == '3D'
  CONDITION: partner_last_call == 'NONE'
  CONDITION: spade_len >= 6
  CONDITION: hcp >= 17

RULE B_3D_6C_245_0:
  CALL: 6C
  PRIORITY: 140
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: opp_last_call == '3D'
  CONDITION: partner_last_call == 'NONE'
  CONDITION: c_realsolid == True
  CONDITION: losing_trick_count == 1

RULE B_3D_6H_246_0:
  CALL: 6H
  PRIORITY: 142
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: opp_last_call == '3D'
  CONDITION: partner_last_call == 'NONE'
  CONDITION: h_realsolid == True
  CONDITION: losing_trick_count == 1

RULE B_3D_6S_247_0:
  CALL: 6S
  PRIORITY: 142
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: opp_last_call == '3D'
  CONDITION: partner_last_call == 'NONE'
  CONDITION: s_realsolid == True
  CONDITION: losing_trick_count == 1

RULE B_3D_7C_248_0:
  CALL: 7C
  PRIORITY: 141
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: opp_last_call == '3D'
  CONDITION: partner_last_call == 'NONE'
  CONDITION: c_realsolid == True
  CONDITION: losing_trick_count <= 0

RULE B_3D_7H_249_0:
  CALL: 7H
  PRIORITY: 143
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: opp_last_call == '3D'
  CONDITION: partner_last_call == 'NONE'
  CONDITION: h_realsolid == True
  CONDITION: losing_trick_count <= 0

RULE B_3D_7S_250_0:
  CALL: 7S
  PRIORITY: 143
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: opp_last_call == '3D'
  CONDITION: partner_last_call == 'NONE'
  CONDITION: s_realsolid == True
  CONDITION: losing_trick_count <= 0

RULE B_3D_X_251_0:
  CALL: X
  PRIORITY: 32
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: opp_last_call == '3D'
  CONDITION: partner_last_call == 'NONE'
  CONDITION: hcp >= 13
  CONDITION: heart_len >= 3
  CONDITION: spade_len >= 3
  CONDITION: diamond_len <= 3
  CONDITION: d_is_longest == False

RULE B_3D_X_251_1:
  CALL: X
  PRIORITY: 32
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: opp_last_call == '3D'
  CONDITION: partner_last_call == 'NONE'
  CONDITION: hcp >= 14
  CONDITION: heart_len >= 4
  CONDITION: spade_len >= 4

RULE B_3D_X_251_3:
  CALL: X
  PRIORITY: 32
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: opp_last_call == '3D'
  CONDITION: partner_last_call == 'NONE'
  CONDITION: hcp >= 20

RULE B_3H_PASS_252_0:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: opp_last_call == '3H'
  CONDITION: partner_last_call == 'NONE'
  CONDITION: hcp <= 20
  CONDITION: heart_len >= 4

RULE B_3H_PASS_252_1:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: opp_last_call == '3H'
  CONDITION: partner_last_call == 'NONE'
  CONDITION: hcp <= 17

RULE B_3H_3S_253_0:
  CALL: 3S
  PRIORITY: 25
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: opp_last_call == '3H'
  CONDITION: partner_last_call == 'NONE'
  CONDITION: spade_len >= 5
  CONDITION: hcp >= 12

RULE B_3H_3S_253_1:
  CALL: 3S
  PRIORITY: 25
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: opp_last_call == '3H'
  CONDITION: partner_last_call == 'NONE'
  CONDITION: spade_len >= 6
  CONDITION: hcp >= 14
  CONDITION: hcp <= 19

RULE B_3H_3NT_254_0:
  CALL: 3NT
  PRIORITY: 60
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: opp_last_call == '3H'
  CONDITION: partner_last_call == 'NONE'
  CONDITION: hcp >= 17
  CONDITION: h_stopper >= 2

RULE B_3H_3NT_254_1:
  CALL: 3NT
  PRIORITY: 60
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: opp_last_call == '3H'
  CONDITION: partner_last_call == 'NONE'
  CONDITION: hcp >= 17
  CONDITION: h_stopper >= 3

RULE B_3H_4C_255_0:
  CALL: 4C
  PRIORITY: 22
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: opp_last_call == '3H'
  CONDITION: partner_last_call == 'NONE'
  CONDITION: club_len >= 5
  CONDITION: hcp >= 16
  CONDITION: hcp <= 19

RULE B_3H_4C_255_1:
  CALL: 4C
  PRIORITY: 22
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: opp_last_call == '3H'
  CONDITION: partner_last_call == 'NONE'
  CONDITION: club_len >= 6
  CONDITION: hcp >= 14
  CONDITION: hcp <= 19

RULE B_3H_4D_256_0:
  CALL: 4D
  PRIORITY: 22
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: opp_last_call == '3H'
  CONDITION: partner_last_call == 'NONE'
  CONDITION: diamond_len >= 5
  CONDITION: hcp >= 16
  CONDITION: hcp <= 19

RULE B_3H_4D_256_1:
  CALL: 4D
  PRIORITY: 22
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: opp_last_call == '3H'
  CONDITION: partner_last_call == 'NONE'
  CONDITION: diamond_len >= 6
  CONDITION: hcp >= 14
  CONDITION: hcp <= 19

RULE B_3H_4H_257_0:
  CALL: 4H
  PRIORITY: 70
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: opp_last_call == '3H'
  CONDITION: partner_last_call == 'NONE'
  CONDITION: spade_len >= 5
  CONDITION: diamond_len >= 5
  CONDITION: losing_trick_count <= 5
  CONDITION: heart_len <= 3
  CONDITION: hcp >= 15

RULE B_3H_4H_257_1:
  CALL: 4H
  PRIORITY: 70
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: opp_last_call == '3H'
  CONDITION: partner_last_call == 'NONE'
  CONDITION: spade_len >= 5
  CONDITION: club_len >= 5
  CONDITION: losing_trick_count <= 5
  CONDITION: heart_len <= 3
  CONDITION: hcp >= 15

RULE B_3H_4S_258_0:
  CALL: 4S
  PRIORITY: 75
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: opp_last_call == '3H'
  CONDITION: partner_last_call == 'NONE'
  CONDITION: spade_len >= 6
  CONDITION: hcp >= 14
  CONDITION: hcp <= 19

RULE B_3H_4S_258_1:
  CALL: 4S
  PRIORITY: 75
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: opp_last_call == '3H'
  CONDITION: partner_last_call == 'NONE'
  CONDITION: spade_len >= 6
  CONDITION: losing_trick_count <= 4

RULE B_3H_4S_258_2:
  CALL: 4S
  PRIORITY: 75
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: opp_last_call == '3H'
  CONDITION: partner_last_call == 'NONE'
  CONDITION: spade_len >= 7
  CONDITION: losing_trick_count <= 3

RULE B_3H_6C_260_0:
  CALL: 6C
  PRIORITY: 140
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: opp_last_call == '3H'
  CONDITION: partner_last_call == 'NONE'
  CONDITION: c_realsolid == True
  CONDITION: losing_trick_count == 1

RULE B_3H_6D_261_0:
  CALL: 6D
  PRIORITY: 140
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: opp_last_call == '3H'
  CONDITION: partner_last_call == 'NONE'
  CONDITION: d_realsolid == True
  CONDITION: losing_trick_count == 1

RULE B_3H_6S_262_0:
  CALL: 6S
  PRIORITY: 142
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: opp_last_call == '3H'
  CONDITION: partner_last_call == 'NONE'
  CONDITION: s_realsolid == True
  CONDITION: losing_trick_count == 1

RULE B_3H_7C_263_0:
  CALL: 7C
  PRIORITY: 141
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: opp_last_call == '3H'
  CONDITION: partner_last_call == 'NONE'
  CONDITION: c_realsolid == True
  CONDITION: losing_trick_count <= 0

RULE B_3H_7D_264_0:
  CALL: 7D
  PRIORITY: 141
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: opp_last_call == '3H'
  CONDITION: partner_last_call == 'NONE'
  CONDITION: d_realsolid == True
  CONDITION: losing_trick_count <= 0

RULE B_3H_7S_265_0:
  CALL: 7S
  PRIORITY: 143
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: opp_last_call == '3H'
  CONDITION: partner_last_call == 'NONE'
  CONDITION: s_realsolid == True
  CONDITION: losing_trick_count <= 0

RULE B_3H_X_266_0:
  CALL: X
  PRIORITY: 18
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: opp_last_call == '3H'
  CONDITION: partner_last_call == 'NONE'
  CONDITION: hcp >= 18

RULE B_3H_X_266_1:
  CALL: X
  PRIORITY: 18
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: opp_last_call == '3H'
  CONDITION: partner_last_call == 'NONE'
  CONDITION: spade_len >= 4
  CONDITION: hcp >= 14
  CONDITION: club_len >= 3
  CONDITION: diamond_len >= 3

RULE B_3H_X_266_2:
  CALL: X
  PRIORITY: 18
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: opp_last_call == '3H'
  CONDITION: partner_last_call == 'NONE'
  CONDITION: spade_len >= 3
  CONDITION: hcp >= 17
  CONDITION: club_len >= 3
  CONDITION: diamond_len >= 3

RULE B_3S_PASS_267_0:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: opp_last_call == '3S'
  CONDITION: partner_last_call == 'NONE'
  CONDITION: hcp <= 20
  CONDITION: spade_len >= 4

RULE B_3S_PASS_267_1:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: opp_last_call == '3S'
  CONDITION: partner_last_call == 'NONE'
  CONDITION: hcp <= 17

RULE B_3S_3NT_268_0:
  CALL: 3NT
  PRIORITY: 60
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: opp_last_call == '3S'
  CONDITION: partner_last_call == 'NONE'
  CONDITION: hcp >= 17
  CONDITION: s_stopper >= 2

RULE B_3S_3NT_268_1:
  CALL: 3NT
  PRIORITY: 60
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: opp_last_call == '3S'
  CONDITION: partner_last_call == 'NONE'
  CONDITION: hcp >= 17
  CONDITION: s_stopper >= 3

RULE B_3S_4C_269_0:
  CALL: 4C
  PRIORITY: 22
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: opp_last_call == '3S'
  CONDITION: partner_last_call == 'NONE'
  CONDITION: club_len >= 5
  CONDITION: hcp >= 16
  CONDITION: hcp <= 19

RULE B_3S_4C_269_1:
  CALL: 4C
  PRIORITY: 22
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: opp_last_call == '3S'
  CONDITION: partner_last_call == 'NONE'
  CONDITION: club_len >= 6
  CONDITION: hcp >= 14
  CONDITION: hcp <= 19

RULE B_3S_4D_270_0:
  CALL: 4D
  PRIORITY: 22
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: opp_last_call == '3S'
  CONDITION: partner_last_call == 'NONE'
  CONDITION: diamond_len >= 5
  CONDITION: hcp >= 16
  CONDITION: hcp <= 19

RULE B_3S_4D_270_1:
  CALL: 4D
  PRIORITY: 22
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: opp_last_call == '3S'
  CONDITION: partner_last_call == 'NONE'
  CONDITION: diamond_len >= 6
  CONDITION: hcp >= 14
  CONDITION: hcp <= 19

RULE B_3S_4H_271_0:
  CALL: 4H
  PRIORITY: 75
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: opp_last_call == '3S'
  CONDITION: partner_last_call == 'NONE'
  CONDITION: heart_len >= 6
  CONDITION: hcp >= 14
  CONDITION: hcp <= 19

RULE B_3S_4H_271_1:
  CALL: 4H
  PRIORITY: 75
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: opp_last_call == '3S'
  CONDITION: partner_last_call == 'NONE'
  CONDITION: heart_len >= 6
  CONDITION: losing_trick_count <= 4

RULE B_3S_4H_271_2:
  CALL: 4H
  PRIORITY: 75
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: opp_last_call == '3S'
  CONDITION: partner_last_call == 'NONE'
  CONDITION: heart_len >= 7
  CONDITION: losing_trick_count <= 3

RULE B_3S_4S_272_0:
  CALL: 4S
  PRIORITY: 70
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: opp_last_call == '3S'
  CONDITION: partner_last_call == 'NONE'
  CONDITION: heart_len >= 5
  CONDITION: diamond_len >= 5
  CONDITION: losing_trick_count <= 5
  CONDITION: spade_len <= 3
  CONDITION: hcp >= 15

RULE B_3S_4S_272_1:
  CALL: 4S
  PRIORITY: 70
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: opp_last_call == '3S'
  CONDITION: partner_last_call == 'NONE'
  CONDITION: heart_len >= 5
  CONDITION: club_len >= 5
  CONDITION: losing_trick_count <= 5
  CONDITION: spade_len <= 3
  CONDITION: hcp >= 15

RULE B_3S_6C_274_0:
  CALL: 6C
  PRIORITY: 140
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: opp_last_call == '3S'
  CONDITION: partner_last_call == 'NONE'
  CONDITION: c_realsolid == True
  CONDITION: losing_trick_count == 1

RULE B_3S_6D_275_0:
  CALL: 6D
  PRIORITY: 140
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: opp_last_call == '3S'
  CONDITION: partner_last_call == 'NONE'
  CONDITION: d_realsolid == True
  CONDITION: losing_trick_count == 1

RULE B_3S_6H_276_0:
  CALL: 6H
  PRIORITY: 142
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: opp_last_call == '3S'
  CONDITION: partner_last_call == 'NONE'
  CONDITION: h_realsolid == True
  CONDITION: losing_trick_count == 1

RULE B_3S_7C_277_0:
  CALL: 7C
  PRIORITY: 141
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: opp_last_call == '3S'
  CONDITION: partner_last_call == 'NONE'
  CONDITION: c_realsolid == True
  CONDITION: losing_trick_count <= 0

RULE B_3S_7D_278_0:
  CALL: 7D
  PRIORITY: 141
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: opp_last_call == '3S'
  CONDITION: partner_last_call == 'NONE'
  CONDITION: d_realsolid == True
  CONDITION: losing_trick_count <= 0

RULE B_3S_7H_279_0:
  CALL: 7H
  PRIORITY: 143
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: opp_last_call == '3S'
  CONDITION: partner_last_call == 'NONE'
  CONDITION: h_realsolid == True
  CONDITION: losing_trick_count <= 0

RULE B_3S_X_280_0:
  CALL: X
  PRIORITY: 18
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: opp_last_call == '3S'
  CONDITION: partner_last_call == 'NONE'
  CONDITION: hcp >= 18

RULE B_3S_X_280_1:
  CALL: X
  PRIORITY: 18
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: opp_last_call == '3S'
  CONDITION: partner_last_call == 'NONE'
  CONDITION: heart_len >= 4
  CONDITION: hcp >= 14
  CONDITION: club_len >= 3
  CONDITION: diamond_len >= 3

RULE B_3S_X_280_2:
  CALL: X
  PRIORITY: 18
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: opp_last_call == '3S'
  CONDITION: partner_last_call == 'NONE'
  CONDITION: heart_len >= 3
  CONDITION: hcp >= 17
  CONDITION: club_len >= 3
  CONDITION: diamond_len >= 3

RULE B_4C_PASS_281_0:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: opp_last_call == '4C'
  CONDITION: partner_last_call == 'NONE'
  CONDITION: hcp <= 16
  CONDITION: spade_len <= 2

RULE B_4C_PASS_281_1:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: opp_last_call == '4C'
  CONDITION: partner_last_call == 'NONE'
  CONDITION: hcp <= 16
  CONDITION: heart_len <= 2

RULE B_4C_PASS_281_2:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: opp_last_call == '4C'
  CONDITION: partner_last_call == 'NONE'
  CONDITION: hcp <= 18

RULE B_4C_4D_282_0:
  CALL: 4D
  PRIORITY: -1
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: opp_last_call == '4C'
  CONDITION: partner_last_call == 'NONE'
  CONDITION: diamond_len >= 6
  CONDITION: hcp >= 14
  CONDITION: hcp <= 19

RULE B_4C_4H_283_0:
  CALL: 4H
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: opp_last_call == '4C'
  CONDITION: partner_last_call == 'NONE'
  CONDITION: h_is_best_major == True
  CONDITION: heart_len >= 5
  CONDITION: hcp >= 14
  CONDITION: hcp <= 19

RULE B_4C_4H_283_1:
  CALL: 4H
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: opp_last_call == '4C'
  CONDITION: partner_last_call == 'NONE'
  CONDITION: h_is_best_major == True
  CONDITION: heart_len >= 6
  CONDITION: hcp >= 14
  CONDITION: hcp <= 19

RULE B_4C_4S_284_0:
  CALL: 4S
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: opp_last_call == '4C'
  CONDITION: partner_last_call == 'NONE'
  CONDITION: s_is_best_major == True
  CONDITION: spade_len >= 5
  CONDITION: hcp >= 14
  CONDITION: hcp <= 19

RULE B_4C_4S_284_1:
  CALL: 4S
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: opp_last_call == '4C'
  CONDITION: partner_last_call == 'NONE'
  CONDITION: s_is_best_major == True
  CONDITION: spade_len >= 6
  CONDITION: hcp >= 14
  CONDITION: hcp <= 19

RULE B_4C_5C_285_0:
  CALL: 5C
  PRIORITY: 70
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: opp_last_call == '4C'
  CONDITION: partner_last_call == 'NONE'
  CONDITION: heart_len >= 5
  CONDITION: spade_len >= 5
  CONDITION: losing_trick_count <= 2
  CONDITION: club_len <= 4

RULE B_4C_X_286_2:
  CALL: X
  PRIORITY: 30
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: opp_last_call == '4C'
  CONDITION: partner_last_call == 'NONE'
  CONDITION: hcp >= 16
  CONDITION: heart_len >= 2
  CONDITION: spade_len >= 2

RULE B_4C_X_286_3:
  CALL: X
  PRIORITY: 30
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: opp_last_call == '4C'
  CONDITION: partner_last_call == 'NONE'
  CONDITION: hcp >= 19

RULE B_4D_PASS_287_0:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: opp_last_call == '4D'
  CONDITION: partner_last_call == 'NONE'
  CONDITION: hcp <= 16
  CONDITION: spade_len <= 2

RULE B_4D_PASS_287_1:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: opp_last_call == '4D'
  CONDITION: partner_last_call == 'NONE'
  CONDITION: hcp <= 16
  CONDITION: heart_len <= 2

RULE B_4D_PASS_287_2:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: opp_last_call == '4D'
  CONDITION: partner_last_call == 'NONE'
  CONDITION: hcp <= 18

RULE B_4D_4H_288_0:
  CALL: 4H
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: opp_last_call == '4D'
  CONDITION: partner_last_call == 'NONE'
  CONDITION: h_is_best_major == True
  CONDITION: heart_len >= 5
  CONDITION: hcp >= 14
  CONDITION: hcp <= 19

RULE B_4D_4H_288_1:
  CALL: 4H
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: opp_last_call == '4D'
  CONDITION: partner_last_call == 'NONE'
  CONDITION: h_is_best_major == True
  CONDITION: heart_len >= 6
  CONDITION: hcp >= 14
  CONDITION: hcp <= 19

RULE B_4D_4S_289_0:
  CALL: 4S
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: opp_last_call == '4D'
  CONDITION: partner_last_call == 'NONE'
  CONDITION: s_is_best_major == True
  CONDITION: spade_len >= 5
  CONDITION: hcp >= 14
  CONDITION: hcp <= 19

RULE B_4D_4S_289_1:
  CALL: 4S
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: opp_last_call == '4D'
  CONDITION: partner_last_call == 'NONE'
  CONDITION: s_is_best_major == True
  CONDITION: spade_len >= 6
  CONDITION: hcp >= 14
  CONDITION: hcp <= 19

RULE B_4D_5C_290_0:
  CALL: 5C
  PRIORITY: 20
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: opp_last_call == '4D'
  CONDITION: partner_last_call == 'NONE'
  CONDITION: club_len >= 7
  CONDITION: losing_trick_count <= 4
  CONDITION: hcp >= 14

RULE B_4D_5D_291_0:
  CALL: 5D
  PRIORITY: 70
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: opp_last_call == '4D'
  CONDITION: partner_last_call == 'NONE'
  CONDITION: heart_len >= 5
  CONDITION: spade_len >= 5
  CONDITION: losing_trick_count <= 2
  CONDITION: diamond_len <= 4

RULE B_4D_X_292_2:
  CALL: X
  PRIORITY: 30
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: opp_last_call == '4D'
  CONDITION: partner_last_call == 'NONE'
  CONDITION: hcp >= 16
  CONDITION: heart_len >= 2
  CONDITION: spade_len >= 2

RULE B_4D_X_292_3:
  CALL: X
  PRIORITY: 30
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: opp_last_call == '4D'
  CONDITION: partner_last_call == 'NONE'
  CONDITION: hcp >= 19

RULE B_4H_4S_294_0:
  CALL: 4S
  PRIORITY: 25
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: opp_last_call == '4H'
  CONDITION: partner_last_call == 'NONE'
  CONDITION: hcp >= 12
  CONDITION: spade_len >= 5
  CONDITION: losing_trick_count <= 4

RULE B_4H_4S_294_1:
  CALL: 4S
  PRIORITY: 25
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: opp_last_call == '4H'
  CONDITION: partner_last_call == 'NONE'
  CONDITION: hcp >= 10
  CONDITION: spade_len >= 6
  CONDITION: losing_trick_count <= 5

RULE B_4H_4S_294_2:
  CALL: 4S
  PRIORITY: 25
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: opp_last_call == '4H'
  CONDITION: partner_last_call == 'NONE'
  CONDITION: hcp >= 14
  CONDITION: spade_len >= 6

RULE B_4H_5C_297_0:
  CALL: 5C
  PRIORITY: 30
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: opp_last_call == '4H'
  CONDITION: partner_last_call == 'NONE'
  CONDITION: club_len >= 7
  CONDITION: hcp >= 16

RULE B_4H_5D_299_0:
  CALL: 5D
  PRIORITY: 30
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: opp_last_call == '4H'
  CONDITION: partner_last_call == 'NONE'
  CONDITION: diamond_len >= 7
  CONDITION: hcp >= 16

RULE B_4H_X_301_0:
  CALL: X
  PRIORITY: 24
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: opp_last_call == '4H'
  CONDITION: partner_last_call == 'NONE'
  CONDITION: hcp >= 14
  CONDITION: heart_len <= 2
  CONDITION: spade_len >= 4

RULE B_4H_X_301_1:
  CALL: X
  PRIORITY: 24
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: opp_last_call == '4H'
  CONDITION: partner_last_call == 'NONE'
  CONDITION: hcp >= 15
  CONDITION: heart_len <= 1
  CONDITION: spade_len >= 3

RULE B_4H_X_301_2:
  CALL: X
  PRIORITY: 24
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: opp_last_call == '4H'
  CONDITION: partner_last_call == 'NONE'
  CONDITION: hcp >= 18

RULE B_4S_4NT_303_1:
  CALL: 4NT
  PRIORITY: 120
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: opp_last_call == '4S'
  CONDITION: partner_last_call == 'NONE'
  CONDITION: spade_len <= 1
  CONDITION: hcp >= 13
  CONDITION: heart_len >= 3
  CONDITION: diamond_len >= 3
  CONDITION: club_len >= 3

RULE B_4S_5C_305_0:
  CALL: 5C
  PRIORITY: 30
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: opp_last_call == '4S'
  CONDITION: partner_last_call == 'NONE'
  CONDITION: club_len >= 7
  CONDITION: hcp >= 16

RULE B_4S_5D_307_0:
  CALL: 5D
  PRIORITY: 30
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: opp_last_call == '4S'
  CONDITION: partner_last_call == 'NONE'
  CONDITION: diamond_len >= 7
  CONDITION: hcp >= 16

RULE B_4S_X_310_0:
  CALL: X
  PRIORITY: 120
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: opp_last_call == '4S'
  CONDITION: partner_last_call == 'NONE'
  CONDITION: hcp >= 16
  CONDITION: spade_len >= 2
  CONDITION: spade_len <= 3
  CONDITION: is_balanced == True

RULE B_5C_PASS_311_0:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: opp_last_call == '5C'
  CONDITION: partner_last_call == 'NONE'

RULE B_5H_PASS_315_0:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: opp_last_call == '5H'
  CONDITION: partner_last_call == 'NONE'

RULE B_5S_PASS_318_0:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: opp_last_call == '5S'
  CONDITION: partner_last_call == 'NONE'

RULE B___PASS_322_0:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == True
  CONDITION: partner_last_call == 'NONE'
  CONDITION: my_last_call == 'NONE'
  CONDITION: hcp < 12
  CONDITION: rule_of_21 == False

RULE B___1C_323_0:
  CALL: 1C
  PRIORITY: 60
  CONDITION: is_opening == True
  CONDITION: partner_last_call == 'NONE'
  CONDITION: my_last_call == 'NONE'
  CONDITION: rule_of_21 == True
  CONDITION: hcp <= 21
  CONDITION: c_is_longest == True

RULE B___1C_323_1:
  CALL: 1C
  PRIORITY: 60
  CONDITION: is_opening == True
  CONDITION: partner_last_call == 'NONE'
  CONDITION: my_last_call == 'NONE'
  CONDITION: rule_of_21 == True
  CONDITION: hcp <= 21
  CONDITION: shape_pattern == 4333
  CONDITION: spade_len == 4
  CONDITION: heart_len == 3
  CONDITION: diamond_len == 3
  CONDITION: club_len == 3

RULE B___1C_323_2:
  CALL: 1C
  PRIORITY: 60
  CONDITION: is_opening == True
  CONDITION: partner_last_call == 'NONE'
  CONDITION: my_last_call == 'NONE'
  CONDITION: rule_of_21 == True
  CONDITION: hcp <= 21
  CONDITION: shape_pattern == 4333
  CONDITION: spade_len == 3
  CONDITION: heart_len == 4
  CONDITION: diamond_len == 3
  CONDITION: club_len == 3

RULE B___1C_323_3:
  CALL: 1C
  PRIORITY: 60
  CONDITION: is_opening == True
  CONDITION: partner_last_call == 'NONE'
  CONDITION: my_last_call == 'NONE'
  CONDITION: rule_of_21 == True
  CONDITION: hcp <= 21
  CONDITION: shape_pattern == 4432
  CONDITION: spade_len == 4
  CONDITION: heart_len == 4
  CONDITION: diamond_len == 2
  CONDITION: club_len == 3

RULE B___1C_323_4:
  CALL: 1C
  PRIORITY: 60
  CONDITION: is_opening == True
  CONDITION: partner_last_call == 'NONE'
  CONDITION: my_last_call == 'NONE'
  CONDITION: hcp >= 12
  CONDITION: hcp <= 21
  CONDITION: c_is_longest == True

RULE B___1C_323_5:
  CALL: 1C
  PRIORITY: 60
  CONDITION: is_opening == True
  CONDITION: partner_last_call == 'NONE'
  CONDITION: my_last_call == 'NONE'
  CONDITION: hcp >= 12
  CONDITION: hcp <= 21
  CONDITION: shape_pattern == 4333
  CONDITION: spade_len == 4
  CONDITION: heart_len == 3
  CONDITION: diamond_len == 3
  CONDITION: club_len == 3

RULE B___1C_323_6:
  CALL: 1C
  PRIORITY: 60
  CONDITION: is_opening == True
  CONDITION: partner_last_call == 'NONE'
  CONDITION: my_last_call == 'NONE'
  CONDITION: hcp >= 12
  CONDITION: hcp <= 21
  CONDITION: shape_pattern == 4333
  CONDITION: spade_len == 3
  CONDITION: heart_len == 4
  CONDITION: diamond_len == 3
  CONDITION: club_len == 3

RULE B___1C_323_7:
  CALL: 1C
  PRIORITY: 60
  CONDITION: is_opening == True
  CONDITION: partner_last_call == 'NONE'
  CONDITION: my_last_call == 'NONE'
  CONDITION: hcp >= 12
  CONDITION: hcp <= 21
  CONDITION: shape_pattern == 4432
  CONDITION: spade_len == 4
  CONDITION: heart_len == 4
  CONDITION: diamond_len == 2
  CONDITION: club_len == 3

RULE B___1D_324_0:
  CALL: 1D
  PRIORITY: 65
  CONDITION: is_opening == True
  CONDITION: partner_last_call == 'NONE'
  CONDITION: my_last_call == 'NONE'
  CONDITION: rule_of_21 == True
  CONDITION: hcp <= 21
  CONDITION: d_is_longest == True

RULE B___1D_324_1:
  CALL: 1D
  PRIORITY: 65
  CONDITION: is_opening == True
  CONDITION: partner_last_call == 'NONE'
  CONDITION: my_last_call == 'NONE'
  CONDITION: rule_of_21 == True
  CONDITION: hcp <= 21
  CONDITION: shape_pattern == 4432
  CONDITION: spade_len == 4
  CONDITION: heart_len == 4
  CONDITION: diamond_len == 3
  CONDITION: club_len == 2

RULE B___1D_324_2:
  CALL: 1D
  PRIORITY: 65
  CONDITION: is_opening == True
  CONDITION: partner_last_call == 'NONE'
  CONDITION: my_last_call == 'NONE'
  CONDITION: hcp >= 12
  CONDITION: hcp <= 21
  CONDITION: d_is_longest == True

RULE B___1D_324_3:
  CALL: 1D
  PRIORITY: 65
  CONDITION: is_opening == True
  CONDITION: partner_last_call == 'NONE'
  CONDITION: my_last_call == 'NONE'
  CONDITION: hcp >= 12
  CONDITION: hcp <= 21
  CONDITION: shape_pattern == 4432
  CONDITION: spade_len == 4
  CONDITION: heart_len == 4
  CONDITION: diamond_len == 3
  CONDITION: club_len == 2

RULE B___1S_330_0:
  CALL: 1S
  PRIORITY: 75
  CONDITION: is_opening == True
  CONDITION: partner_last_call == 'NONE'
  CONDITION: my_last_call == 'NONE'
  CONDITION: rule_of_21 == True
  CONDITION: hcp <= 21
  CONDITION: spade_len >= 5
  CONDITION: s_is_longest == True

RULE B___1NT_331_3:
  CALL: 1NT
  PRIORITY: 120
  CONDITION: is_opening == True
  CONDITION: partner_last_call == 'NONE'
  CONDITION: my_last_call == 'NONE'
  CONDITION: is_semi_balanced == True
  CONDITION: hcp >= 15
  CONDITION: hcp <= 17
  CONDITION: spade_len <= 4
  CONDITION: heart_len <= 4

RULE B___2C_332_0:
  CALL: 2C
  PRIORITY: 112
  CONDITION: is_opening == True
  CONDITION: partner_last_call == 'NONE'
  CONDITION: my_last_call == 'NONE'
  CONDITION: losing_trick_count <= 1
  CONDITION: hcp >= 16

RULE B___2C_333_0:
  CALL: 2C
  PRIORITY: 113
  CONDITION: is_opening == True
  CONDITION: partner_last_call == 'NONE'
  CONDITION: my_last_call == 'NONE'
  CONDITION: losing_trick_count <= 2
  CONDITION: hcp >= 16
  CONDITION: longest_suit_len >= 5

RULE B___2C_334_1:
  CALL: 2C
  PRIORITY: 118
  CONDITION: is_opening == True
  CONDITION: partner_last_call == 'NONE'
  CONDITION: my_last_call == 'NONE'
  CONDITION: hcp >= 18
  CONDITION: hcp >= 20
  CONDITION: c_is_longest == True
  CONDITION: club_len >= 6
  CONDITION: losing_trick_count <= 2
  CONDITION: ace_count >= 2

RULE B___2C_334_3:
  CALL: 2C
  PRIORITY: 118
  CONDITION: is_opening == True
  CONDITION: partner_last_call == 'NONE'
  CONDITION: my_last_call == 'NONE'
  CONDITION: hcp >= 18
  CONDITION: hcp >= 20
  CONDITION: d_is_longest == True
  CONDITION: diamond_len >= 6
  CONDITION: losing_trick_count <= 2
  CONDITION: ace_count >= 2

RULE B___2C_334_5:
  CALL: 2C
  PRIORITY: 118
  CONDITION: is_opening == True
  CONDITION: partner_last_call == 'NONE'
  CONDITION: my_last_call == 'NONE'
  CONDITION: hcp >= 18
  CONDITION: hcp >= 20
  CONDITION: h_is_longest == True
  CONDITION: heart_len >= 6
  CONDITION: losing_trick_count <= 3
  CONDITION: ace_count >= 2

RULE B___2C_334_7:
  CALL: 2C
  PRIORITY: 118
  CONDITION: is_opening == True
  CONDITION: partner_last_call == 'NONE'
  CONDITION: my_last_call == 'NONE'
  CONDITION: hcp >= 18
  CONDITION: hcp >= 20
  CONDITION: s_is_longest == True
  CONDITION: spade_len >= 6
  CONDITION: losing_trick_count <= 3
  CONDITION: ace_count >= 2

RULE B___2C_334_8:
  CALL: 2C
  PRIORITY: 118
  CONDITION: is_opening == True
  CONDITION: partner_last_call == 'NONE'
  CONDITION: my_last_call == 'NONE'
  CONDITION: hcp >= 22
  CONDITION: is_balanced == True

RULE B___2C_334_9:
  CALL: 2C
  PRIORITY: 118
  CONDITION: is_opening == True
  CONDITION: partner_last_call == 'NONE'
  CONDITION: my_last_call == 'NONE'
  CONDITION: hcp >= 22
  CONDITION: is_semi_balanced == True

RULE B___2C_334_10:
  CALL: 2C
  PRIORITY: 118
  CONDITION: is_opening == True
  CONDITION: partner_last_call == 'NONE'
  CONDITION: my_last_call == 'NONE'
  CONDITION: hcp >= 22
  CONDITION: losing_trick_count <= 5

RULE B___2D_335_0:
  CALL: 2D
  PRIORITY: 60
  CONDITION: is_opening == True
  CONDITION: partner_last_call == 'NONE'
  CONDITION: my_last_call == 'NONE'
  CONDITION: hcp <= 11
  CONDITION: diamond_len == 6
  CONDITION: hcp > 4
  CONDITION: d_is_longest == True
  CONDITION: d_top3_honors >= 2
  CONDITION: spade_len <= 4
  CONDITION: heart_len <= 4
  CONDITION: rule_of_21 == False

RULE B___2H_336_0:
  CALL: 2H
  PRIORITY: 60
  CONDITION: is_opening == True
  CONDITION: partner_last_call == 'NONE'
  CONDITION: my_last_call == 'NONE'
  CONDITION: hcp <= 11
  CONDITION: heart_len == 6
  CONDITION: hcp > 4
  CONDITION: h_is_longest == True
  CONDITION: h_top3_honors >= 2
  CONDITION: spade_len <= 3
  CONDITION: rule_of_21 == False

RULE B___2S_337_0:
  CALL: 2S
  PRIORITY: 60
  CONDITION: is_opening == True
  CONDITION: partner_last_call == 'NONE'
  CONDITION: my_last_call == 'NONE'
  CONDITION: hcp <= 11
  CONDITION: spade_len == 6
  CONDITION: hcp > 4
  CONDITION: s_is_longest == True
  CONDITION: s_top3_honors >= 2
  CONDITION: heart_len <= 3
  CONDITION: rule_of_21 == False

RULE B___2NT_338_0:
  CALL: 2NT
  PRIORITY: 122
  CONDITION: is_opening == True
  CONDITION: partner_last_call == 'NONE'
  CONDITION: my_last_call == 'NONE'
  CONDITION: is_semi_balanced == True
  CONDITION: hcp >= 20
  CONDITION: hcp <= 21

RULE B___3C_340_0:
  CALL: 3C
  PRIORITY: 85
  CONDITION: is_opening == True
  CONDITION: partner_last_call == 'NONE'
  CONDITION: my_last_call == 'NONE'
  CONDITION: club_len >= 7
  CONDITION: hcp >= 5
  CONDITION: hcp <= 11
  CONDITION: total_points >= 6
  CONDITION: rule_of_21 == False
  CONDITION: heart_len <= 4
  CONDITION: spade_len <= 4

RULE B___3D_342_0:
  CALL: 3D
  PRIORITY: 86
  CONDITION: is_opening == True
  CONDITION: partner_last_call == 'NONE'
  CONDITION: my_last_call == 'NONE'
  CONDITION: diamond_len >= 7
  CONDITION: hcp >= 5
  CONDITION: hcp <= 11
  CONDITION: total_points >= 6
  CONDITION: rule_of_21 == False
  CONDITION: heart_len <= 4
  CONDITION: spade_len <= 4

RULE B___3H_344_0:
  CALL: 3H
  PRIORITY: 87
  CONDITION: is_opening == True
  CONDITION: partner_last_call == 'NONE'
  CONDITION: my_last_call == 'NONE'
  CONDITION: heart_len >= 7
  CONDITION: hcp >= 5
  CONDITION: hcp <= 11
  CONDITION: total_points >= 6
  CONDITION: rule_of_21 == False
  CONDITION: spade_len <= 4

RULE B___3S_346_0:
  CALL: 3S
  PRIORITY: 88
  CONDITION: is_opening == True
  CONDITION: partner_last_call == 'NONE'
  CONDITION: my_last_call == 'NONE'
  CONDITION: spade_len >= 7
  CONDITION: hcp >= 5
  CONDITION: hcp <= 11
  CONDITION: total_points >= 6
  CONDITION: rule_of_21 == False
  CONDITION: heart_len <= 4

RULE B___3NT_347_0:
  CALL: 3NT
  PRIORITY: 130
  CONDITION: is_opening == True
  CONDITION: partner_last_call == 'NONE'
  CONDITION: my_last_call == 'NONE'
  CONDITION: is_semi_balanced == True
  CONDITION: hcp >= 25
  CONDITION: hcp <= 27
  CONDITION: heart_len <= 4
  CONDITION: spade_len <= 4

RULE B___6C_356_0:
  CALL: 6C
  PRIORITY: 10
  CONDITION: is_opening == True
  CONDITION: partner_last_call == 'NONE'
  CONDITION: my_last_call == 'NONE'
  CONDITION: club_len >= 9
  CONDITION: total_points >= 32

RULE B___6D_357_0:
  CALL: 6D
  PRIORITY: 11
  CONDITION: is_opening == True
  CONDITION: partner_last_call == 'NONE'
  CONDITION: my_last_call == 'NONE'
  CONDITION: diamond_len >= 9
  CONDITION: total_points >= 32

RULE B___6H_358_0:
  CALL: 6H
  PRIORITY: 12
  CONDITION: is_opening == True
  CONDITION: partner_last_call == 'NONE'
  CONDITION: my_last_call == 'NONE'
  CONDITION: heart_len >= 9
  CONDITION: total_points >= 32

RULE B___6S_359_0:
  CALL: 6S
  PRIORITY: 13
  CONDITION: is_opening == True
  CONDITION: partner_last_call == 'NONE'
  CONDITION: my_last_call == 'NONE'
  CONDITION: spade_len >= 9
  CONDITION: total_points >= 32

RULE B___6NT_360_0:
  CALL: 6NT
  PRIORITY: 14
  CONDITION: is_opening == True
  CONDITION: partner_last_call == 'NONE'
  CONDITION: my_last_call == 'NONE'
  CONDITION: is_balanced == True
  CONDITION: hcp >= 33
  CONDITION: hcp <= 34

RULE B___7C_361_0:
  CALL: 7C
  PRIORITY: 15
  CONDITION: is_opening == True
  CONDITION: partner_last_call == 'NONE'
  CONDITION: my_last_call == 'NONE'
  CONDITION: club_len >= 9
  CONDITION: hcp >= 31
  CONDITION: total_points >= 35

RULE B___7D_362_0:
  CALL: 7D
  PRIORITY: 23
  CONDITION: is_opening == True
  CONDITION: partner_last_call == 'NONE'
  CONDITION: my_last_call == 'NONE'
  CONDITION: diamond_len >= 9
  CONDITION: hcp >= 31
  CONDITION: total_points >= 35

RULE B___7H_363_0:
  CALL: 7H
  PRIORITY: 24
  CONDITION: is_opening == True
  CONDITION: partner_last_call == 'NONE'
  CONDITION: my_last_call == 'NONE'
  CONDITION: heart_len >= 9
  CONDITION: hcp >= 31
  CONDITION: total_points >= 35

RULE B___7S_364_0:
  CALL: 7S
  PRIORITY: 25
  CONDITION: is_opening == True
  CONDITION: partner_last_call == 'NONE'
  CONDITION: my_last_call == 'NONE'
  CONDITION: spade_len >= 9
  CONDITION: hcp >= 31
  CONDITION: total_points >= 35

RULE B___7NT_365_0:
  CALL: 7NT
  PRIORITY: 26
  CONDITION: is_opening == True
  CONDITION: partner_last_call == 'NONE'
  CONDITION: my_last_call == 'NONE'
  CONDITION: is_balanced == True
  CONDITION: hcp >= 36
  CONDITION: total_points >= 35

RULE B_1N_PASS_366_0:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: opp_last_call == '1NT'
  CONDITION: partner_last_call == 'NONE'

RULE B_1N_2C_367_1:
  CALL: 2C
  PRIORITY: 50
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: opp_last_call == '1NT'
  CONDITION: partner_last_call == 'NONE'
  CONDITION: total_points >= 10
  CONDITION: longest_suit_len >= 7
  CONDITION: hcp >= 10

RULE B_1N_2D_368_0:
  CALL: 2D
  PRIORITY: 90
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: opp_last_call == '1NT'
  CONDITION: partner_last_call == 'NONE'
  CONDITION: heart_len >= 5
  CONDITION: spade_len >= 5
  CONDITION: hcp >= 10

RULE B_1N_2NT_371_0:
  CALL: 2NT
  PRIORITY: 80
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: opp_last_call == '1NT'
  CONDITION: partner_last_call == 'NONE'
  CONDITION: club_len >= 5
  CONDITION: diamond_len >= 5
  CONDITION: total_points >= 15
  CONDITION: hcp >= 10

RULE B_2N_PASS_381_0:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: opp_last_call == '2NT'
  CONDITION: partner_last_call == 'NONE'

RULE B_3N_PASS_392_0:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: opp_last_call == '3NT'
  CONDITION: partner_last_call == 'NONE'

RULE B_7N_PASS_397_0:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: opp_last_call == '7NT'
  CONDITION: partner_last_call == 'NONE'

RULE B_1C_P_PASS_399_0:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1C'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 1
  CONDITION: hcp < 6

RULE B_1C_P_1D_400_0:
  CALL: 1D
  PRIORITY: 30
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1C'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 1
  CONDITION: hcp > 5
  CONDITION: d_is_longest == True
  CONDITION: diamond_len < 5

RULE B_1C_P_1D_400_1:
  CALL: 1D
  PRIORITY: 30
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1C'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 1
  CONDITION: hcp > 5
  CONDITION: d_is_longest == True
  CONDITION: s_is_longest == False
  CONDITION: h_is_longest == False

RULE B_1C_P_1NT_403_0:
  CALL: 1NT
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1C'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 1
  CONDITION: hcp <= 10
  CONDITION: hcp >= 6
  CONDITION: spade_len < 4
  CONDITION: heart_len < 4
  CONDITION: is_balanced == True

RULE B_1C_P_2C_404_0:
  CALL: 2C
  PRIORITY: 80
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1C'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 1
  CONDITION: club_len >= 4
  CONDITION: hcp >= 10
  CONDITION: heart_len < 4
  CONDITION: spade_len < 4
  CONDITION: c_is_longest == True

RULE B_1C_P_2D_405_4:
  CALL: 2D
  PRIORITY: 100
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1C'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 1
  CONDITION: diamond_len >= 5
  CONDITION: club_len >= 4
  CONDITION: hcp > 17
  CONDITION: controls >= 4
  CONDITION: spade_len <= 3
  CONDITION: heart_len <= 3

RULE B_1C_P_2D_405_5:
  CALL: 2D
  PRIORITY: 100
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1C'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 1
  CONDITION: diamond_len >= 5
  CONDITION: is_balanced == True
  CONDITION: hcp > 17
  CONDITION: controls >= 4

RULE B_1C_P_2H_406_3:
  CALL: 2H
  PRIORITY: 100
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1C'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 1
  CONDITION: heart_len >= 5
  CONDITION: club_len >= 4
  CONDITION: hcp > 17
  CONDITION: controls >= 4

RULE B_1C_P_2H_406_4:
  CALL: 2H
  PRIORITY: 100
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1C'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 1
  CONDITION: heart_len >= 6
  CONDITION: is_semi_balanced == True
  CONDITION: hcp >= 17
  CONDITION: controls >= 4

RULE B_1C_P_2S_407_3:
  CALL: 2S
  PRIORITY: 100
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1C'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 1
  CONDITION: spade_len >= 5
  CONDITION: club_len >= 4
  CONDITION: hcp > 17
  CONDITION: controls >= 4

RULE B_1C_P_2S_407_4:
  CALL: 2S
  PRIORITY: 100
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1C'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 1
  CONDITION: spade_len >= 6
  CONDITION: is_semi_balanced == True
  CONDITION: hcp >= 17
  CONDITION: controls >= 4

RULE B_1C_P_2NT_408_0:
  CALL: 2NT
  PRIORITY: 65
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1C'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 1
  CONDITION: is_balanced == True
  CONDITION: hcp >= 10
  CONDITION: hcp <= 12
  CONDITION: spade_len < 4
  CONDITION: heart_len < 4

RULE B_1C_P_2NT_408_1:
  CALL: 2NT
  PRIORITY: 65
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1C'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 1
  CONDITION: is_semi_balanced == True
  CONDITION: hcp >= 10
  CONDITION: hcp <= 12
  CONDITION: spade_len < 4
  CONDITION: heart_len < 4

RULE B_1C_P_3C_409_0:
  CALL: 3C
  PRIORITY: 32
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1C'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 1
  CONDITION: club_len >= 5
  CONDITION: hcp < 10
  CONDITION: heart_len < 4
  CONDITION: spade_len < 4
  CONDITION: hcp >= 4
  CONDITION: c_is_longest == True

RULE B_1C_P_3D_410_0:
  CALL: 3D
  PRIORITY: 24
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1C'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 1
  CONDITION: club_len >= 5
  CONDITION: diamond_len <= 1
  CONDITION: total_points >= 14
  CONDITION: heart_len <= 3
  CONDITION: spade_len <= 3

RULE B_1C_P_3H_411_0:
  CALL: 3H
  PRIORITY: 150
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1C'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 1
  CONDITION: heart_len <= 1
  CONDITION: total_points >= 14
  CONDITION: club_len >= 5
  CONDITION: spade_len <= 3

RULE B_1C_P_3S_412_0:
  CALL: 3S
  PRIORITY: 150
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1C'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 1
  CONDITION: spade_len <= 1
  CONDITION: total_points >= 14
  CONDITION: club_len >= 5
  CONDITION: heart_len <= 3

RULE B_1C_P_3NT_413_0:
  CALL: 3NT
  PRIORITY: 60
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1C'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 1
  CONDITION: is_balanced == True
  CONDITION: hcp > 12
  CONDITION: hcp < 16
  CONDITION: spade_len < 4
  CONDITION: heart_len < 4

RULE B_1C_P_4H_414_0:
  CALL: 4H
  PRIORITY: 50
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1C'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 1
  CONDITION: heart_len >= 7
  CONDITION: hcp <= 10
  CONDITION: hcp >= 6

RULE B_1C_P_4S_415_0:
  CALL: 4S
  PRIORITY: 50
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1C'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 1
  CONDITION: spade_len >= 7
  CONDITION: hcp <= 10
  CONDITION: hcp >= 6

RULE B_1C_P_5C_417_0:
  CALL: 5C
  PRIORITY: 51
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1C'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 1
  CONDITION: club_len >= 7
  CONDITION: hcp <= 10
  CONDITION: hcp >= 5

RULE B_1C_P_5D_418_0:
  CALL: 5D
  PRIORITY: 72
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1C'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 1
  CONDITION: diamond_len >= 8
  CONDITION: hcp <= 10
  CONDITION: hcp >= 5

RULE B_1C_P_6C_421_0:
  CALL: 6C
  PRIORITY: 5
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1C'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 1
  CONDITION: c_realsolid == True
  CONDITION: losing_trick_count == 1

RULE B_1C_P_7C_423_0:
  CALL: 7C
  PRIORITY: 6
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1C'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 1
  CONDITION: c_realsolid == True
  CONDITION: losing_trick_count <= 0

RULE B_1C_X_PASS_426_0:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1C'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp <= 5

RULE B_1C_X_1H_428_1:
  CALL: 1H
  PRIORITY: 54
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1C'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 0
  CONDITION: h_is_best_major == True
  CONDITION: heart_len >= 5
  CONDITION: hcp >= 10

RULE B_1C_X_1S_429_1:
  CALL: 1S
  PRIORITY: 54
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1C'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 0
  CONDITION: s_is_best_major == True
  CONDITION: spade_len >= 5
  CONDITION: hcp >= 10

RULE B_1C_X_1NT_430_0:
  CALL: 1NT
  PRIORITY: 12
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1C'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp <= 10
  CONDITION: hcp >= 6

RULE B_1C_X_2C_431_0:
  CALL: 2C
  PRIORITY: 40
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1C'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 0
  CONDITION: club_len >= 4
  CONDITION: total_points >= 7
  CONDITION: total_points <= 10

RULE B_1C_X_2H_432_0:
  CALL: 2H
  PRIORITY: 95
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1C'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 0
  CONDITION: total_points >= 6
  CONDITION: hcp < 10
  CONDITION: heart_len >= 6

RULE B_1C_X_2S_433_0:
  CALL: 2S
  PRIORITY: 95
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1C'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 0
  CONDITION: total_points >= 6
  CONDITION: hcp < 10
  CONDITION: spade_len >= 6

RULE B_1C_X_2NT_434_0:
  CALL: 2NT
  PRIORITY: 120
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1C'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 0
  CONDITION: club_hcp > 12
  CONDITION: hcp >= 9
  CONDITION: club_len >= 5
  CONDITION: heart_len <= 4
  CONDITION: spade_len <= 4

RULE B_1C_X_3C_435_0:
  CALL: 3C
  PRIORITY: 90
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1C'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 7
  CONDITION: hcp <= 10
  CONDITION: club_len >= 5

RULE B_1C_X_3H_436_0:
  CALL: 3H
  PRIORITY: 94
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1C'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 0
  CONDITION: total_points >= 6
  CONDITION: hcp < 10
  CONDITION: heart_len >= 7

RULE B_1C_X_3S_437_0:
  CALL: 3S
  PRIORITY: 94
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1C'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 0
  CONDITION: total_points >= 6
  CONDITION: hcp < 10
  CONDITION: spade_len >= 7

RULE B_1C_X_4C_438_0:
  CALL: 4C
  PRIORITY: 97
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1C'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 3
  CONDITION: hcp <= 6
  CONDITION: club_len >= 7

RULE B_1C_X_4H_439_0:
  CALL: 4H
  PRIORITY: 98
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1C'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 0
  CONDITION: total_points >= 6
  CONDITION: hcp < 10
  CONDITION: heart_len >= 8

RULE B_1C_X_4S_440_0:
  CALL: 4S
  PRIORITY: 98
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1C'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 0
  CONDITION: total_points >= 6
  CONDITION: hcp < 10
  CONDITION: spade_len >= 8

RULE B_1C_X_XX_441_0:
  CALL: XX
  PRIORITY: 42
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1C'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 10
  CONDITION: longest_suit_len <= 5
  CONDITION: controls >= 2

RULE B_1C_X_XX_441_1:
  CALL: XX
  PRIORITY: 42
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1C'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 10
  CONDITION: longest_suit_len <= 5
  CONDITION: controls >= 3

RULE B_1C_X_XX_441_2:
  CALL: XX
  PRIORITY: 42
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1C'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 11
  CONDITION: longest_suit_len <= 5

RULE B_1C_X_XX_441_3:
  CALL: XX
  PRIORITY: 42
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1C'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 12
  CONDITION: diamond_len >= 5

RULE B_1C_1D_PASS_442_0:
  CALL: PASS
  PRIORITY: 50
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1C'
  CONDITION: opp_last_call == '1D'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp <= 9

RULE B_1C_1D_1H_443_0:
  CALL: 1H
  PRIORITY: 65
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1C'
  CONDITION: opp_last_call == '1D'
  CONDITION: passes_since_last_bid == 0
  CONDITION: heart_len == 4
  CONDITION: hcp >= 6

RULE B_1C_1D_1H_443_1:
  CALL: 1H
  PRIORITY: 65
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1C'
  CONDITION: opp_last_call == '1D'
  CONDITION: passes_since_last_bid == 0
  CONDITION: h_is_best_major == True
  CONDITION: heart_len >= 5
  CONDITION: hcp >= 5

RULE B_1C_1D_1S_444_0:
  CALL: 1S
  PRIORITY: 65
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1C'
  CONDITION: opp_last_call == '1D'
  CONDITION: passes_since_last_bid == 0
  CONDITION: spade_len == 4
  CONDITION: hcp >= 6

RULE B_1C_1D_1S_444_1:
  CALL: 1S
  PRIORITY: 65
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1C'
  CONDITION: opp_last_call == '1D'
  CONDITION: passes_since_last_bid == 0
  CONDITION: s_is_best_major == True
  CONDITION: spade_len >= 5
  CONDITION: hcp >= 5

RULE B_1C_1D_1NT_445_0:
  CALL: 1NT
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1C'
  CONDITION: opp_last_call == '1D'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 7
  CONDITION: diamond_len >= 3
  CONDITION: hcp <= 10

RULE B_1C_1D_1NT_445_1:
  CALL: 1NT
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1C'
  CONDITION: opp_last_call == '1D'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 7
  CONDITION: d_stopper >= 2
  CONDITION: hcp <= 10

RULE B_1C_1D_2C_446_0:
  CALL: 2C
  PRIORITY: 15
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1C'
  CONDITION: opp_last_call == '1D'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp <= 9
  CONDITION: hcp >= 6
  CONDITION: club_len >= 4

RULE B_1C_1D_2D_447_0:
  CALL: 2D
  PRIORITY: 22
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1C'
  CONDITION: opp_last_call == '1D'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 10
  CONDITION: club_len >= 4

RULE B_1C_1D_2H_448_0:
  CALL: 2H
  PRIORITY: 25
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1C'
  CONDITION: opp_last_call == '1D'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 12
  CONDITION: heart_len >= 6

RULE B_1C_1D_2S_449_0:
  CALL: 2S
  PRIORITY: 25
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1C'
  CONDITION: opp_last_call == '1D'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 12
  CONDITION: spade_len >= 6

RULE B_1C_1D_2NT_450_0:
  CALL: 2NT
  PRIORITY: 30
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1C'
  CONDITION: opp_last_call == '1D'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 10
  CONDITION: diamond_len >= 4
  CONDITION: hcp <= 12

RULE B_1C_1D_2NT_450_1:
  CALL: 2NT
  PRIORITY: 30
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1C'
  CONDITION: opp_last_call == '1D'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 10
  CONDITION: d_stopper >= 2
  CONDITION: hcp <= 11

RULE B_1C_1D_3C_451_0:
  CALL: 3C
  PRIORITY: 16
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1C'
  CONDITION: opp_last_call == '1D'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp <= 8
  CONDITION: club_hcp >= 6
  CONDITION: club_len >= 5

RULE B_1C_1D_3NT_455_0:
  CALL: 3NT
  PRIORITY: 40
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1C'
  CONDITION: opp_last_call == '1D'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 12
  CONDITION: diamond_len >= 4
  CONDITION: hcp <= 17
  CONDITION: club_len <= 3

RULE B_1C_1D_3NT_455_1:
  CALL: 3NT
  PRIORITY: 40
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1C'
  CONDITION: opp_last_call == '1D'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 12
  CONDITION: d_stopper >= 2
  CONDITION: hcp <= 17
  CONDITION: club_len <= 3

RULE B_1C_1D_4H_456_0:
  CALL: 4H
  PRIORITY: 85
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1C'
  CONDITION: opp_last_call == '1D'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp <= 10
  CONDITION: hcp >= 6
  CONDITION: heart_len >= 7

RULE B_1C_1D_4S_457_0:
  CALL: 4S
  PRIORITY: 85
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1C'
  CONDITION: opp_last_call == '1D'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp <= 10
  CONDITION: hcp >= 6
  CONDITION: spade_len >= 7

RULE B_1C_1D_6C_461_0:
  CALL: 6C
  PRIORITY: 65
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1C'
  CONDITION: opp_last_call == '1D'
  CONDITION: passes_since_last_bid == 0
  CONDITION: club_len >= 5
  CONDITION: c_realsolid == True
  CONDITION: losing_trick_count == 1

RULE B_1C_1D_7C_463_0:
  CALL: 7C
  PRIORITY: 66
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1C'
  CONDITION: opp_last_call == '1D'
  CONDITION: passes_since_last_bid == 0
  CONDITION: club_len >= 5
  CONDITION: c_realsolid == True
  CONDITION: losing_trick_count <= 0

RULE B_1C_1D_X_466_0:
  CALL: X
  PRIORITY: 54
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1C'
  CONDITION: opp_last_call == '1D'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 6
  CONDITION: heart_len == 4
  CONDITION: spade_len == 4

RULE B_1C_1H_PASS_467_0:
  CALL: PASS
  PRIORITY: 32
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1C'
  CONDITION: opp_last_call == '1H'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp <= 9

RULE B_1C_1H_PASS_467_1:
  CALL: PASS
  PRIORITY: 32
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1C'
  CONDITION: opp_last_call == '1H'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp <= 6

RULE B_1C_1H_PASS_467_2:
  CALL: PASS
  PRIORITY: 32
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1C'
  CONDITION: opp_last_call == '1H'
  CONDITION: passes_since_last_bid == 0
  CONDITION: h_is_longest == True
  CONDITION: heart_len >= 5
  CONDITION: hcp >= 10

RULE B_1C_1H_1S_468_0:
  CALL: 1S
  PRIORITY: 80
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1C'
  CONDITION: opp_last_call == '1H'
  CONDITION: passes_since_last_bid == 0
  CONDITION: spade_hcp >= 6
  CONDITION: spade_len >= 5

RULE B_1C_1H_1NT_469_0:
  CALL: 1NT
  PRIORITY: 21
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1C'
  CONDITION: opp_last_call == '1H'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 7
  CONDITION: heart_len >= 3
  CONDITION: hcp <= 11

RULE B_1C_1H_1NT_469_1:
  CALL: 1NT
  PRIORITY: 21
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1C'
  CONDITION: opp_last_call == '1H'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 7
  CONDITION: h_stopper >= 2
  CONDITION: hcp <= 10

RULE B_1C_1H_2C_470_0:
  CALL: 2C
  PRIORITY: 15
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1C'
  CONDITION: opp_last_call == '1H'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp <= 10
  CONDITION: hcp >= 6
  CONDITION: club_len >= 4

RULE B_1C_1H_2C_470_1:
  CALL: 2C
  PRIORITY: 15
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1C'
  CONDITION: opp_last_call == '1H'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp <= 9
  CONDITION: club_hcp >= 6
  CONDITION: club_len >= 4
  CONDITION: hcp >= 5

RULE B_1C_1H_2C_470_2:
  CALL: 2C
  PRIORITY: 15
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1C'
  CONDITION: opp_last_call == '1H'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp <= 9
  CONDITION: hcp >= 6
  CONDITION: club_len >= 4

RULE B_1C_1H_2D_471_0:
  CALL: 2D
  PRIORITY: 55
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1C'
  CONDITION: opp_last_call == '1H'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 9
  CONDITION: diamond_len >= 5

RULE B_1C_1H_2D_471_1_0:
  CALL: 2D
  PRIORITY: 55
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1C'
  CONDITION: opp_last_call == '1H'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 9
  CONDITION: diamond_len >= 5
  CONDITION: h_has_ace == True
  CONDITION: h_has_king == True

RULE B_1C_1H_2D_471_1_1:
  CALL: 2D
  PRIORITY: 55
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1C'
  CONDITION: opp_last_call == '1H'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 9
  CONDITION: diamond_len >= 5
  CONDITION: h_has_ace == True
  CONDITION: h_has_queen == True

RULE B_1C_1H_2D_471_1_2:
  CALL: 2D
  PRIORITY: 55
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1C'
  CONDITION: opp_last_call == '1H'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 9
  CONDITION: diamond_len >= 5
  CONDITION: h_has_ace == True
  CONDITION: h_has_jack == True

RULE B_1C_1H_2D_471_1_3:
  CALL: 2D
  PRIORITY: 55
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1C'
  CONDITION: opp_last_call == '1H'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 9
  CONDITION: diamond_len >= 5
  CONDITION: h_has_ace == True
  CONDITION: h_has_ten == True

RULE B_1C_1H_2D_471_1_4:
  CALL: 2D
  PRIORITY: 55
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1C'
  CONDITION: opp_last_call == '1H'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 9
  CONDITION: diamond_len >= 5
  CONDITION: h_has_king == True
  CONDITION: h_has_queen == True

RULE B_1C_1H_2D_471_1_5:
  CALL: 2D
  PRIORITY: 55
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1C'
  CONDITION: opp_last_call == '1H'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 9
  CONDITION: diamond_len >= 5
  CONDITION: h_has_king == True
  CONDITION: h_has_jack == True

RULE B_1C_1H_2D_471_1_6:
  CALL: 2D
  PRIORITY: 55
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1C'
  CONDITION: opp_last_call == '1H'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 9
  CONDITION: diamond_len >= 5
  CONDITION: h_has_king == True
  CONDITION: h_has_ten == True

RULE B_1C_1H_2D_471_1_7:
  CALL: 2D
  PRIORITY: 55
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1C'
  CONDITION: opp_last_call == '1H'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 9
  CONDITION: diamond_len >= 5
  CONDITION: h_has_queen == True
  CONDITION: h_has_jack == True

RULE B_1C_1H_2D_471_1_8:
  CALL: 2D
  PRIORITY: 55
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1C'
  CONDITION: opp_last_call == '1H'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 9
  CONDITION: diamond_len >= 5
  CONDITION: h_has_queen == True
  CONDITION: h_has_ten == True

RULE B_1C_1H_2D_471_1_9:
  CALL: 2D
  PRIORITY: 55
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1C'
  CONDITION: opp_last_call == '1H'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 9
  CONDITION: diamond_len >= 5
  CONDITION: h_has_jack == True
  CONDITION: h_has_ten == True

RULE B_1C_1H_2D_471_2:
  CALL: 2D
  PRIORITY: 55
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1C'
  CONDITION: opp_last_call == '1H'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 12
  CONDITION: diamond_len >= 4

RULE B_1C_1H_2D_471_3:
  CALL: 2D
  PRIORITY: 55
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1C'
  CONDITION: opp_last_call == '1H'
  CONDITION: passes_since_last_bid == 0
  CONDITION: diamond_len >= 5
  CONDITION: hcp >= 12

RULE B_1C_1H_2H_472_0:
  CALL: 2H
  PRIORITY: 58
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1C'
  CONDITION: opp_last_call == '1H'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 18
  CONDITION: club_len >= 3
  CONDITION: spade_len <= 3

RULE B_1C_1H_2H_472_1:
  CALL: 2H
  PRIORITY: 58
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1C'
  CONDITION: opp_last_call == '1H'
  CONDITION: passes_since_last_bid == 0
  CONDITION: club_hcp >= 10
  CONDITION: club_len >= 4
  CONDITION: hcp >= 9
  CONDITION: spade_len <= 3

RULE B_1C_1H_2NT_473_0:
  CALL: 2NT
  PRIORITY: 30
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1C'
  CONDITION: opp_last_call == '1H'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 10
  CONDITION: heart_len >= 4
  CONDITION: hcp <= 12

RULE B_1C_1H_2NT_473_1:
  CALL: 2NT
  PRIORITY: 30
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1C'
  CONDITION: opp_last_call == '1H'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 10
  CONDITION: h_stopper >= 2
  CONDITION: hcp <= 11

RULE B_1C_1H_3C_474_0:
  CALL: 3C
  PRIORITY: 47
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1C'
  CONDITION: opp_last_call == '1H'
  CONDITION: passes_since_last_bid == 0
  CONDITION: club_len >= 5
  CONDITION: hcp >= 4
  CONDITION: club_hcp <= 9

RULE B_1C_1H_3D_475_0:
  CALL: 3D
  PRIORITY: 45
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1C'
  CONDITION: opp_last_call == '1H'
  CONDITION: passes_since_last_bid == 0
  CONDITION: diamond_len >= 6
  CONDITION: hcp >= 13
  CONDITION: diamond_hcp <= 15

RULE B_1C_1H_3S_476_0:
  CALL: 3S
  PRIORITY: 60
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1C'
  CONDITION: opp_last_call == '1H'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 15
  CONDITION: spade_len >= 6

RULE B_1C_1H_3NT_477_0:
  CALL: 3NT
  PRIORITY: 75
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1C'
  CONDITION: opp_last_call == '1H'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 12
  CONDITION: heart_len >= 4
  CONDITION: hcp <= 17
  CONDITION: club_len <= 3

RULE B_1C_1H_3NT_477_1:
  CALL: 3NT
  PRIORITY: 75
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1C'
  CONDITION: opp_last_call == '1H'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 12
  CONDITION: h_stopper >= 2
  CONDITION: hcp <= 17
  CONDITION: club_len <= 3
  CONDITION: is_semi_balanced == True
  CONDITION: spade_len <= 3

RULE B_1C_1H_4C_478_0:
  CALL: 4C
  PRIORITY: 67
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1C'
  CONDITION: opp_last_call == '1H'
  CONDITION: passes_since_last_bid == 0
  CONDITION: club_len >= 6
  CONDITION: hcp <= 4
  CONDITION: club_hcp >= 7

RULE B_1C_1H_4S_479_0:
  CALL: 4S
  PRIORITY: 100
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1C'
  CONDITION: opp_last_call == '1H'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 6
  CONDITION: hcp <= 10
  CONDITION: spade_len >= 7

RULE B_1C_1H_6C_483_0:
  CALL: 6C
  PRIORITY: 95
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1C'
  CONDITION: opp_last_call == '1H'
  CONDITION: passes_since_last_bid == 0
  CONDITION: club_len >= 5
  CONDITION: c_realsolid == True
  CONDITION: losing_trick_count == 1

RULE B_1C_1H_7C_485_0:
  CALL: 7C
  PRIORITY: 96
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1C'
  CONDITION: opp_last_call == '1H'
  CONDITION: passes_since_last_bid == 0
  CONDITION: club_len >= 5
  CONDITION: c_realsolid == True
  CONDITION: losing_trick_count <= 0

RULE B_1C_1S_PASS_489_0:
  CALL: PASS
  PRIORITY: 32
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1C'
  CONDITION: opp_last_call == '1S'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp <= 9

RULE B_1C_1S_PASS_489_1:
  CALL: PASS
  PRIORITY: 32
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1C'
  CONDITION: opp_last_call == '1S'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp <= 6

RULE B_1C_1S_PASS_489_2:
  CALL: PASS
  PRIORITY: 32
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1C'
  CONDITION: opp_last_call == '1S'
  CONDITION: passes_since_last_bid == 0
  CONDITION: s_is_longest == True
  CONDITION: spade_len >= 5
  CONDITION: hcp >= 10

RULE B_1C_1S_1NT_490_0:
  CALL: 1NT
  PRIORITY: 21
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1C'
  CONDITION: opp_last_call == '1S'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 7
  CONDITION: spade_len >= 3
  CONDITION: hcp <= 11

RULE B_1C_1S_1NT_490_1:
  CALL: 1NT
  PRIORITY: 21
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1C'
  CONDITION: opp_last_call == '1S'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 7
  CONDITION: s_stopper >= 2
  CONDITION: hcp <= 10

RULE B_1C_1S_2C_491_0:
  CALL: 2C
  PRIORITY: 15
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1C'
  CONDITION: opp_last_call == '1S'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp <= 10
  CONDITION: hcp >= 6
  CONDITION: club_len >= 4

RULE B_1C_1S_2C_491_1:
  CALL: 2C
  PRIORITY: 15
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1C'
  CONDITION: opp_last_call == '1S'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp <= 9
  CONDITION: club_hcp >= 6
  CONDITION: club_len >= 4
  CONDITION: hcp >= 5

RULE B_1C_1S_2C_491_2:
  CALL: 2C
  PRIORITY: 15
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1C'
  CONDITION: opp_last_call == '1S'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp <= 9
  CONDITION: hcp >= 6
  CONDITION: club_len >= 4

RULE B_1C_1S_2D_492_0:
  CALL: 2D
  PRIORITY: 55
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1C'
  CONDITION: opp_last_call == '1S'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 9
  CONDITION: diamond_len >= 5

RULE B_1C_1S_2D_492_1_0:
  CALL: 2D
  PRIORITY: 55
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1C'
  CONDITION: opp_last_call == '1S'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 9
  CONDITION: diamond_len >= 5
  CONDITION: h_has_ace == True
  CONDITION: h_has_king == True

RULE B_1C_1S_2D_492_1_1:
  CALL: 2D
  PRIORITY: 55
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1C'
  CONDITION: opp_last_call == '1S'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 9
  CONDITION: diamond_len >= 5
  CONDITION: h_has_ace == True
  CONDITION: h_has_queen == True

RULE B_1C_1S_2D_492_1_2:
  CALL: 2D
  PRIORITY: 55
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1C'
  CONDITION: opp_last_call == '1S'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 9
  CONDITION: diamond_len >= 5
  CONDITION: h_has_ace == True
  CONDITION: h_has_jack == True

RULE B_1C_1S_2D_492_1_3:
  CALL: 2D
  PRIORITY: 55
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1C'
  CONDITION: opp_last_call == '1S'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 9
  CONDITION: diamond_len >= 5
  CONDITION: h_has_ace == True
  CONDITION: h_has_ten == True

RULE B_1C_1S_2D_492_1_4:
  CALL: 2D
  PRIORITY: 55
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1C'
  CONDITION: opp_last_call == '1S'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 9
  CONDITION: diamond_len >= 5
  CONDITION: h_has_king == True
  CONDITION: h_has_queen == True

RULE B_1C_1S_2D_492_1_5:
  CALL: 2D
  PRIORITY: 55
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1C'
  CONDITION: opp_last_call == '1S'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 9
  CONDITION: diamond_len >= 5
  CONDITION: h_has_king == True
  CONDITION: h_has_jack == True

RULE B_1C_1S_2D_492_1_6:
  CALL: 2D
  PRIORITY: 55
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1C'
  CONDITION: opp_last_call == '1S'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 9
  CONDITION: diamond_len >= 5
  CONDITION: h_has_king == True
  CONDITION: h_has_ten == True

RULE B_1C_1S_2D_492_1_7:
  CALL: 2D
  PRIORITY: 55
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1C'
  CONDITION: opp_last_call == '1S'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 9
  CONDITION: diamond_len >= 5
  CONDITION: h_has_queen == True
  CONDITION: h_has_jack == True

RULE B_1C_1S_2D_492_1_8:
  CALL: 2D
  PRIORITY: 55
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1C'
  CONDITION: opp_last_call == '1S'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 9
  CONDITION: diamond_len >= 5
  CONDITION: h_has_queen == True
  CONDITION: h_has_ten == True

RULE B_1C_1S_2D_492_1_9:
  CALL: 2D
  PRIORITY: 55
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1C'
  CONDITION: opp_last_call == '1S'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 9
  CONDITION: diamond_len >= 5
  CONDITION: h_has_jack == True
  CONDITION: h_has_ten == True

RULE B_1C_1S_2D_492_2:
  CALL: 2D
  PRIORITY: 55
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1C'
  CONDITION: opp_last_call == '1S'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 12
  CONDITION: diamond_len >= 4

RULE B_1C_1S_2D_492_3:
  CALL: 2D
  PRIORITY: 55
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1C'
  CONDITION: opp_last_call == '1S'
  CONDITION: passes_since_last_bid == 0
  CONDITION: diamond_len >= 5
  CONDITION: hcp >= 12

RULE B_1C_1S_2H_493_0:
  CALL: 2H
  PRIORITY: 80
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1C'
  CONDITION: opp_last_call == '1S'
  CONDITION: passes_since_last_bid == 0
  CONDITION: heart_len >= 6
  CONDITION: hcp >= 8

RULE B_1C_1S_2H_493_1:
  CALL: 2H
  PRIORITY: 80
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1C'
  CONDITION: opp_last_call == '1S'
  CONDITION: passes_since_last_bid == 0
  CONDITION: heart_len >= 5
  CONDITION: hcp >= 10

RULE B_1C_1S_2S_494_0:
  CALL: 2S
  PRIORITY: 58
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1C'
  CONDITION: opp_last_call == '1S'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 18
  CONDITION: club_len >= 3
  CONDITION: heart_len <= 3

RULE B_1C_1S_2S_494_1:
  CALL: 2S
  PRIORITY: 58
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1C'
  CONDITION: opp_last_call == '1S'
  CONDITION: passes_since_last_bid == 0
  CONDITION: club_hcp >= 10
  CONDITION: club_len >= 4
  CONDITION: hcp >= 9
  CONDITION: heart_len <= 3

RULE B_1C_1S_2NT_495_0:
  CALL: 2NT
  PRIORITY: 30
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1C'
  CONDITION: opp_last_call == '1S'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 10
  CONDITION: spade_len >= 4
  CONDITION: hcp <= 12

RULE B_1C_1S_2NT_495_1:
  CALL: 2NT
  PRIORITY: 30
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1C'
  CONDITION: opp_last_call == '1S'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 10
  CONDITION: s_stopper >= 2
  CONDITION: hcp <= 11

RULE B_1C_1S_3C_496_0:
  CALL: 3C
  PRIORITY: 47
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1C'
  CONDITION: opp_last_call == '1S'
  CONDITION: passes_since_last_bid == 0
  CONDITION: club_len >= 5
  CONDITION: hcp >= 4
  CONDITION: club_hcp <= 9

RULE B_1C_1S_3D_497_0:
  CALL: 3D
  PRIORITY: 45
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1C'
  CONDITION: opp_last_call == '1S'
  CONDITION: passes_since_last_bid == 0
  CONDITION: diamond_len >= 6
  CONDITION: hcp >= 13
  CONDITION: diamond_hcp <= 15

RULE B_1C_1S_3H_498_0:
  CALL: 3H
  PRIORITY: 60
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1C'
  CONDITION: opp_last_call == '1S'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 15
  CONDITION: heart_len >= 6

RULE B_1C_1S_3NT_499_0:
  CALL: 3NT
  PRIORITY: 75
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1C'
  CONDITION: opp_last_call == '1S'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 12
  CONDITION: spade_len >= 4
  CONDITION: hcp <= 17
  CONDITION: club_len <= 3

RULE B_1C_1S_3NT_499_1:
  CALL: 3NT
  PRIORITY: 75
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1C'
  CONDITION: opp_last_call == '1S'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 12
  CONDITION: s_stopper >= 2
  CONDITION: hcp <= 17
  CONDITION: club_len <= 3
  CONDITION: is_semi_balanced == True
  CONDITION: heart_len <= 3

RULE B_1C_1S_4C_500_0:
  CALL: 4C
  PRIORITY: 67
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1C'
  CONDITION: opp_last_call == '1S'
  CONDITION: passes_since_last_bid == 0
  CONDITION: club_len >= 6
  CONDITION: hcp <= 4
  CONDITION: club_hcp >= 7

RULE B_1C_1S_4H_501_0:
  CALL: 4H
  PRIORITY: 80
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1C'
  CONDITION: opp_last_call == '1S'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 6
  CONDITION: hcp <= 10
  CONDITION: heart_len >= 7

RULE B_1C_1S_6C_505_0:
  CALL: 6C
  PRIORITY: 95
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1C'
  CONDITION: opp_last_call == '1S'
  CONDITION: passes_since_last_bid == 0
  CONDITION: club_len >= 5
  CONDITION: c_realsolid == True
  CONDITION: losing_trick_count == 1

RULE B_1C_1S_7C_507_0:
  CALL: 7C
  PRIORITY: 96
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1C'
  CONDITION: opp_last_call == '1S'
  CONDITION: passes_since_last_bid == 0
  CONDITION: club_len >= 5
  CONDITION: c_realsolid == True
  CONDITION: losing_trick_count <= 0

RULE B_1C_2C_PASS_511_0:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1C'
  CONDITION: opp_last_call == '2C'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp <= 11

RULE B_1C_2C_2D_512_0:
  CALL: 2D
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1C'
  CONDITION: opp_last_call == '2C'
  CONDITION: passes_since_last_bid == 0
  CONDITION: diamond_len >= 5
  CONDITION: hcp >= 7
  CONDITION: hcp <= 9

RULE B_1C_2C_2H_513_0:
  CALL: 2H
  PRIORITY: 40
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1C'
  CONDITION: opp_last_call == '2C'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 10
  CONDITION: club_len >= 4

RULE B_1C_2C_2S_514_0:
  CALL: 2S
  PRIORITY: 45
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1C'
  CONDITION: opp_last_call == '2C'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 10
  CONDITION: diamond_len >= 5

RULE B_1C_2C_2S_514_1:
  CALL: 2S
  PRIORITY: 45
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1C'
  CONDITION: opp_last_call == '2C'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 10
  CONDITION: diamond_len >= 5
  CONDITION: club_len <= 4

RULE B_1C_2C_2NT_515_0:
  CALL: 2NT
  PRIORITY: 50
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1C'
  CONDITION: opp_last_call == '2C'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 10
  CONDITION: s_stopper >= 2
  CONDITION: h_stopper >= 2
  CONDITION: hcp <= 12

RULE B_1C_2C_3C_516_0:
  CALL: 3C
  PRIORITY: 52
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1C'
  CONDITION: opp_last_call == '2C'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 7
  CONDITION: club_len >= 4
  CONDITION: hcp <= 9

RULE B_1C_2C_3H_517_0:
  CALL: 3H
  PRIORITY: 55
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1C'
  CONDITION: opp_last_call == '2C'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 9
  CONDITION: club_len >= 4
  CONDITION: hcp <= 9

RULE B_1C_2C_3S_518_0:
  CALL: 3S
  PRIORITY: 56
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1C'
  CONDITION: opp_last_call == '2C'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 11
  CONDITION: club_len >= 5

RULE B_1C_2C_3NT_519_0:
  CALL: 3NT
  PRIORITY: 57
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1C'
  CONDITION: opp_last_call == '2C'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 13
  CONDITION: s_stopper >= 2
  CONDITION: h_stopper >= 2
  CONDITION: hcp <= 20

RULE B_1C_2C_4C_520_0:
  CALL: 4C
  PRIORITY: 53
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1C'
  CONDITION: opp_last_call == '2C'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 4
  CONDITION: club_len >= 6
  CONDITION: hcp <= 9

RULE B_1C_2C_4H_521_0:
  CALL: 4H
  PRIORITY: 58
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1C'
  CONDITION: opp_last_call == '2C'
  CONDITION: passes_since_last_bid == 0
  CONDITION: club_len >= 5
  CONDITION: club_hcp >= 17
  CONDITION: heart_len <= 1

RULE B_1C_2C_4S_522_0:
  CALL: 4S
  PRIORITY: 58
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1C'
  CONDITION: opp_last_call == '2C'
  CONDITION: passes_since_last_bid == 0
  CONDITION: club_len >= 5
  CONDITION: club_hcp >= 17
  CONDITION: spade_len <= 1

RULE B_1C_2C_6C_527_0:
  CALL: 6C
  PRIORITY: 65
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1C'
  CONDITION: opp_last_call == '2C'
  CONDITION: passes_since_last_bid == 0
  CONDITION: club_len >= 5
  CONDITION: c_realsolid == True
  CONDITION: losing_trick_count == 1

RULE B_1C_2C_7C_529_0:
  CALL: 7C
  PRIORITY: 66
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1C'
  CONDITION: opp_last_call == '2C'
  CONDITION: passes_since_last_bid == 0
  CONDITION: club_len >= 5
  CONDITION: c_realsolid == True
  CONDITION: losing_trick_count <= 0

RULE B_1C_2C_X_532_0:
  CALL: X
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1C'
  CONDITION: opp_last_call == '2C'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 12

RULE B_1C_2D_PASS_533_0:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1C'
  CONDITION: opp_last_call == '2D'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp <= 11

RULE B_1C_2D_PASS_533_1:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1C'
  CONDITION: opp_last_call == '2D'
  CONDITION: passes_since_last_bid == 0
  CONDITION: diamond_len >= 4

RULE B_1C_2D_PASS_533_2:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1C'
  CONDITION: opp_last_call == '2D'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp <= 8

RULE B_1C_2D_2H_534_0:
  CALL: 2H
  PRIORITY: 60
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1C'
  CONDITION: opp_last_call == '2D'
  CONDITION: passes_since_last_bid == 0
  CONDITION: h_is_best_major == True
  CONDITION: hcp >= 9
  CONDITION: heart_len >= 5

RULE B_1C_2D_2S_535_0:
  CALL: 2S
  PRIORITY: 60
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1C'
  CONDITION: opp_last_call == '2D'
  CONDITION: passes_since_last_bid == 0
  CONDITION: s_is_best_major == True
  CONDITION: hcp >= 9
  CONDITION: spade_len >= 5

RULE B_1C_2D_2NT_536_0:
  CALL: 2NT
  PRIORITY: 45
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1C'
  CONDITION: opp_last_call == '2D'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 10
  CONDITION: hcp <= 12
  CONDITION: d_stopper >= 2

RULE B_1C_2D_3C_537_0:
  CALL: 3C
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1C'
  CONDITION: opp_last_call == '2D'
  CONDITION: passes_since_last_bid == 0
  CONDITION: club_hcp >= 9
  CONDITION: hcp <= 11
  CONDITION: club_len >= 4

RULE B_1C_2D_3D_538_0:
  CALL: 3D
  PRIORITY: 20
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1C'
  CONDITION: opp_last_call == '2D'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 12
  CONDITION: club_len >= 4

RULE B_1C_2D_3D_538_1:
  CALL: 3D
  PRIORITY: 20
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1C'
  CONDITION: opp_last_call == '2D'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 11
  CONDITION: club_len >= 5

RULE B_1C_2D_3NT_539_0:
  CALL: 3NT
  PRIORITY: 50
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1C'
  CONDITION: opp_last_call == '2D'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 12
  CONDITION: d_stopper >= 2

RULE B_1C_2D_X_540_0:
  CALL: X
  PRIORITY: 51
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1C'
  CONDITION: opp_last_call == '2D'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 10
  CONDITION: spade_len >= 3
  CONDITION: heart_len >= 4

RULE B_1C_2D_X_540_1:
  CALL: X
  PRIORITY: 51
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1C'
  CONDITION: opp_last_call == '2D'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 10
  CONDITION: spade_len >= 4
  CONDITION: heart_len >= 3

RULE B_1C_2D_X_540_2:
  CALL: X
  PRIORITY: 51
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1C'
  CONDITION: opp_last_call == '2D'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 12
  CONDITION: spade_len >= 3
  CONDITION: heart_len >= 3

RULE B_1C_2D_X_540_3:
  CALL: X
  PRIORITY: 51
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1C'
  CONDITION: opp_last_call == '2D'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 8
  CONDITION: spade_len >= 5
  CONDITION: heart_len >= 5

RULE B_1C_2D_X_540_4:
  CALL: X
  PRIORITY: 51
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1C'
  CONDITION: opp_last_call == '2D'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 10
  CONDITION: spade_len >= 4
  CONDITION: heart_len >= 4

RULE B_1C_2H_PASS_541_0:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1C'
  CONDITION: opp_last_call == '2H'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp <= 11

RULE B_1C_2H_PASS_541_2:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1C'
  CONDITION: opp_last_call == '2H'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp <= 9

RULE B_1C_2H_2S_542_0:
  CALL: 2S
  PRIORITY: 70
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1C'
  CONDITION: opp_last_call == '2H'
  CONDITION: passes_since_last_bid == 0
  CONDITION: spade_hcp >= 11
  CONDITION: spade_len >= 5

RULE B_1C_2H_2NT_543_0:
  CALL: 2NT
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1C'
  CONDITION: opp_last_call == '2H'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 10
  CONDITION: h_stopper >= 2
  CONDITION: hcp <= 12

RULE B_1C_2H_3C_544_0:
  CALL: 3C
  PRIORITY: 20
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1C'
  CONDITION: opp_last_call == '2H'
  CONDITION: passes_since_last_bid == 0
  CONDITION: club_hcp >= 9
  CONDITION: hcp <= 11
  CONDITION: club_len >= 5

RULE B_1C_2H_3C_544_1:
  CALL: 3C
  PRIORITY: 20
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1C'
  CONDITION: opp_last_call == '2H'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 9
  CONDITION: hcp <= 11
  CONDITION: club_len >= 4

RULE B_1C_2H_3D_545_0:
  CALL: 3D
  PRIORITY: 30
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1C'
  CONDITION: opp_last_call == '2H'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 10
  CONDITION: diamond_len >= 5

RULE B_1C_2H_3D_545_1:
  CALL: 3D
  PRIORITY: 30
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1C'
  CONDITION: opp_last_call == '2H'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 11
  CONDITION: diamond_len >= 5

RULE B_1C_2H_3H_547_0:
  CALL: 3H
  PRIORITY: 55
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1C'
  CONDITION: opp_last_call == '2H'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 12
  CONDITION: club_len >= 3

RULE B_1C_2H_3H_547_1:
  CALL: 3H
  PRIORITY: 55
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1C'
  CONDITION: opp_last_call == '2H'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 11
  CONDITION: club_len >= 4

RULE B_1C_2H_6C_554_0:
  CALL: 6C
  PRIORITY: 75
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1C'
  CONDITION: opp_last_call == '2H'
  CONDITION: passes_since_last_bid == 0
  CONDITION: club_len >= 5
  CONDITION: c_realsolid == True
  CONDITION: losing_trick_count == 1

RULE B_1C_2H_7C_556_0:
  CALL: 7C
  PRIORITY: 76
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1C'
  CONDITION: opp_last_call == '2H'
  CONDITION: passes_since_last_bid == 0
  CONDITION: club_len >= 5
  CONDITION: c_realsolid == True
  CONDITION: losing_trick_count <= 0

RULE B_1C_2H_X_559_0:
  CALL: X
  PRIORITY: 60
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1C'
  CONDITION: opp_last_call == '2H'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 13
  CONDITION: spade_len >= 3

RULE B_1C_2H_X_559_1:
  CALL: X
  PRIORITY: 60
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1C'
  CONDITION: opp_last_call == '2H'
  CONDITION: passes_since_last_bid == 0
  CONDITION: total_points >= 9
  CONDITION: spade_len >= 4

RULE B_1C_2S_PASS_560_0:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1C'
  CONDITION: opp_last_call == '2S'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp <= 11

RULE B_1C_2S_PASS_560_2:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1C'
  CONDITION: opp_last_call == '2S'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp <= 9

RULE B_1C_2S_2NT_561_0:
  CALL: 2NT
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1C'
  CONDITION: opp_last_call == '2S'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 10
  CONDITION: s_stopper >= 2
  CONDITION: hcp <= 12

RULE B_1C_2S_3C_562_0:
  CALL: 3C
  PRIORITY: 20
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1C'
  CONDITION: opp_last_call == '2S'
  CONDITION: passes_since_last_bid == 0
  CONDITION: club_hcp >= 9
  CONDITION: hcp <= 11
  CONDITION: club_len >= 5

RULE B_1C_2S_3C_562_1:
  CALL: 3C
  PRIORITY: 20
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1C'
  CONDITION: opp_last_call == '2S'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 9
  CONDITION: hcp <= 11
  CONDITION: club_len >= 4

RULE B_1C_2S_3D_563_0:
  CALL: 3D
  PRIORITY: 30
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1C'
  CONDITION: opp_last_call == '2S'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 10
  CONDITION: diamond_len >= 5

RULE B_1C_2S_3D_563_1:
  CALL: 3D
  PRIORITY: 30
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1C'
  CONDITION: opp_last_call == '2S'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 11
  CONDITION: diamond_len >= 5

RULE B_1C_2S_3H_564_0:
  CALL: 3H
  PRIORITY: 65
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1C'
  CONDITION: opp_last_call == '2S'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 9
  CONDITION: heart_len >= 5
  CONDITION: h_is_longest == True

RULE B_1C_2S_3S_566_0:
  CALL: 3S
  PRIORITY: 55
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1C'
  CONDITION: opp_last_call == '2S'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 12
  CONDITION: club_len >= 3

RULE B_1C_2S_3S_566_1:
  CALL: 3S
  PRIORITY: 55
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1C'
  CONDITION: opp_last_call == '2S'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 11
  CONDITION: club_len >= 4

RULE B_1C_2S_6C_572_0:
  CALL: 6C
  PRIORITY: 75
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1C'
  CONDITION: opp_last_call == '2S'
  CONDITION: passes_since_last_bid == 0
  CONDITION: club_len >= 5
  CONDITION: c_realsolid == True
  CONDITION: losing_trick_count == 1

RULE B_1C_2S_7C_574_0:
  CALL: 7C
  PRIORITY: 76
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1C'
  CONDITION: opp_last_call == '2S'
  CONDITION: passes_since_last_bid == 0
  CONDITION: club_len >= 5
  CONDITION: c_realsolid == True
  CONDITION: losing_trick_count <= 0

RULE B_1C_2S_X_577_0:
  CALL: X
  PRIORITY: 60
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1C'
  CONDITION: opp_last_call == '2S'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 13
  CONDITION: heart_len >= 3

RULE B_1C_2S_X_577_1:
  CALL: X
  PRIORITY: 60
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1C'
  CONDITION: opp_last_call == '2S'
  CONDITION: passes_since_last_bid == 0
  CONDITION: total_points >= 9
  CONDITION: heart_len >= 4

RULE B_1C_3C_PASS_578_0:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1C'
  CONDITION: opp_last_call == '3C'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp <= 9

RULE B_1C_3C_X_580_0:
  CALL: X
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1C'
  CONDITION: opp_last_call == '3C'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 10

RULE B_1C_3D_PASS_581_0:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1C'
  CONDITION: opp_last_call == '3D'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp <= 9

RULE B_1C_3D_3H_582_0:
  CALL: 3H
  PRIORITY: 20
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1C'
  CONDITION: opp_last_call == '3D'
  CONDITION: passes_since_last_bid == 0
  CONDITION: h_is_best_major == True
  CONDITION: heart_len >= 6
  CONDITION: hcp >= 10

RULE B_1C_3D_3H_582_1:
  CALL: 3H
  PRIORITY: 20
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1C'
  CONDITION: opp_last_call == '3D'
  CONDITION: passes_since_last_bid == 0
  CONDITION: h_is_best_major == True
  CONDITION: heart_len >= 5
  CONDITION: hcp >= 12

RULE B_1C_3D_3S_583_0:
  CALL: 3S
  PRIORITY: 20
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1C'
  CONDITION: opp_last_call == '3D'
  CONDITION: passes_since_last_bid == 0
  CONDITION: s_is_best_major == True
  CONDITION: spade_len >= 6
  CONDITION: hcp >= 10

RULE B_1C_3D_3S_583_1:
  CALL: 3S
  PRIORITY: 20
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1C'
  CONDITION: opp_last_call == '3D'
  CONDITION: passes_since_last_bid == 0
  CONDITION: s_is_best_major == True
  CONDITION: spade_len >= 5
  CONDITION: hcp >= 12

RULE B_1C_3D_3NT_584_0:
  CALL: 3NT
  PRIORITY: 30
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1C'
  CONDITION: opp_last_call == '3D'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 12
  CONDITION: d_stopper >= 2

RULE B_1C_3D_X_587_0:
  CALL: X
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1C'
  CONDITION: opp_last_call == '3D'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 10

RULE B_1C_3H_PASS_588_0:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1C'
  CONDITION: opp_last_call == '3H'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp <= 12

RULE B_1C_3H_PASS_588_1:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1C'
  CONDITION: opp_last_call == '3H'
  CONDITION: passes_since_last_bid == 0
  CONDITION: heart_len >= 4

RULE B_1C_3H_PASS_588_2:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1C'
  CONDITION: opp_last_call == '3H'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp <= 8

RULE B_1C_3H_3S_589_0:
  CALL: 3S
  PRIORITY: 100
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1C'
  CONDITION: opp_last_call == '3H'
  CONDITION: passes_since_last_bid == 0
  CONDITION: spade_len >= 5
  CONDITION: hcp >= 12
  CONDITION: s_top2_honors >= 1

RULE B_1C_3H_3S_589_1:
  CALL: 3S
  PRIORITY: 100
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1C'
  CONDITION: opp_last_call == '3H'
  CONDITION: passes_since_last_bid == 0
  CONDITION: spade_len >= 6
  CONDITION: hcp >= 12

RULE B_1C_3H_4C_591_0:
  CALL: 4C
  PRIORITY: 12
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1C'
  CONDITION: opp_last_call == '3H'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 10
  CONDITION: club_len >= 4
  CONDITION: hcp <= 14

RULE B_1C_3H_4D_592_0:
  CALL: 4D
  PRIORITY: 16
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1C'
  CONDITION: opp_last_call == '3H'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 12
  CONDITION: diamond_len >= 6

RULE B_1C_3H_4H_593_0:
  CALL: 4H
  PRIORITY: 52
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1C'
  CONDITION: opp_last_call == '3H'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 10
  CONDITION: club_len >= 4
  CONDITION: club_hcp >= 14

RULE B_1C_3H_4S_594_0:
  CALL: 4S
  PRIORITY: 56
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1C'
  CONDITION: opp_last_call == '3H'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 10
  CONDITION: spade_len >= 6
  CONDITION: club_hcp >= 14

RULE B_1C_3H_5C_596_0:
  CALL: 5C
  PRIORITY: 27
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1C'
  CONDITION: opp_last_call == '3H'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 15
  CONDITION: club_len >= 4
  CONDITION: hcp <= 18

RULE B_1C_3H_6C_599_0:
  CALL: 6C
  PRIORITY: 35
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1C'
  CONDITION: opp_last_call == '3H'
  CONDITION: passes_since_last_bid == 0
  CONDITION: club_len >= 4
  CONDITION: c_realsolid == True
  CONDITION: losing_trick_count == 1

RULE B_1C_3H_6S_601_0:
  CALL: 6S
  PRIORITY: 66
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1C'
  CONDITION: opp_last_call == '3H'
  CONDITION: passes_since_last_bid == 0
  CONDITION: spade_len >= 8
  CONDITION: losing_trick_count <= 3

RULE B_1C_3H_7C_602_0:
  CALL: 7C
  PRIORITY: 36
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1C'
  CONDITION: opp_last_call == '3H'
  CONDITION: passes_since_last_bid == 0
  CONDITION: club_len >= 4
  CONDITION: c_realsolid == True
  CONDITION: losing_trick_count <= 0

RULE B_1C_3H_X_605_0:
  CALL: X
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1C'
  CONDITION: opp_last_call == '3H'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 12

RULE B_1C_3H_X_605_1:
  CALL: X
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1C'
  CONDITION: opp_last_call == '3H'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 10
  CONDITION: heart_len <= 2

RULE B_1C_3S_PASS_606_0:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1C'
  CONDITION: opp_last_call == '3S'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp <= 12

RULE B_1C_3S_PASS_606_1:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1C'
  CONDITION: opp_last_call == '3S'
  CONDITION: passes_since_last_bid == 0
  CONDITION: spade_len >= 4

RULE B_1C_3S_PASS_606_2:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1C'
  CONDITION: opp_last_call == '3S'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp <= 8

RULE B_1C_3S_4C_608_0:
  CALL: 4C
  PRIORITY: 12
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1C'
  CONDITION: opp_last_call == '3S'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 10
  CONDITION: club_len >= 4
  CONDITION: hcp <= 14

RULE B_1C_3S_4D_609_0:
  CALL: 4D
  PRIORITY: 16
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1C'
  CONDITION: opp_last_call == '3S'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 12
  CONDITION: diamond_len >= 6

RULE B_1C_3S_4H_610_0:
  CALL: 4H
  PRIORITY: 56
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1C'
  CONDITION: opp_last_call == '3S'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 10
  CONDITION: heart_len >= 6
  CONDITION: club_hcp >= 14

RULE B_1C_3S_4S_611_0:
  CALL: 4S
  PRIORITY: 52
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1C'
  CONDITION: opp_last_call == '3S'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 10
  CONDITION: club_len >= 4
  CONDITION: club_hcp >= 14

RULE B_1C_3S_5C_613_0:
  CALL: 5C
  PRIORITY: 27
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1C'
  CONDITION: opp_last_call == '3S'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 15
  CONDITION: club_len >= 4
  CONDITION: hcp <= 18

RULE B_1C_3S_6C_616_0:
  CALL: 6C
  PRIORITY: 35
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1C'
  CONDITION: opp_last_call == '3S'
  CONDITION: passes_since_last_bid == 0
  CONDITION: club_len >= 4
  CONDITION: c_realsolid == True
  CONDITION: losing_trick_count == 1

RULE B_1C_3S_6H_618_0:
  CALL: 6H
  PRIORITY: 66
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1C'
  CONDITION: opp_last_call == '3S'
  CONDITION: passes_since_last_bid == 0
  CONDITION: heart_len >= 8
  CONDITION: losing_trick_count <= 3

RULE B_1C_3S_7C_619_0:
  CALL: 7C
  PRIORITY: 36
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1C'
  CONDITION: opp_last_call == '3S'
  CONDITION: passes_since_last_bid == 0
  CONDITION: club_len >= 4
  CONDITION: c_realsolid == True
  CONDITION: losing_trick_count <= 0

RULE B_1C_3S_X_622_0:
  CALL: X
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1C'
  CONDITION: opp_last_call == '3S'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 12

RULE B_1C_3S_X_622_1:
  CALL: X
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1C'
  CONDITION: opp_last_call == '3S'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 10
  CONDITION: spade_len <= 2

RULE B_1C_4D_PASS_623_0:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1C'
  CONDITION: opp_last_call == '4D'
  CONDITION: passes_since_last_bid == 0

RULE B_1C_4D_X_631_0:
  CALL: X
  PRIORITY: 90
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1C'
  CONDITION: opp_last_call == '4D'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 13

RULE B_1C_4H_PASS_632_0:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1C'
  CONDITION: opp_last_call == '4H'
  CONDITION: passes_since_last_bid == 0

RULE B_1C_4H_5C_636_0:
  CALL: 5C
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1C'
  CONDITION: opp_last_call == '4H'
  CONDITION: passes_since_last_bid == 0
  CONDITION: club_len >= 5
  CONDITION: hcp >= 12

RULE B_1C_4H_6C_641_0:
  CALL: 6C
  PRIORITY: 35
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1C'
  CONDITION: opp_last_call == '4H'
  CONDITION: passes_since_last_bid == 0
  CONDITION: c_realsolid == True
  CONDITION: losing_trick_count == 1

RULE B_1C_4H_7C_644_0:
  CALL: 7C
  PRIORITY: 36
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1C'
  CONDITION: opp_last_call == '4H'
  CONDITION: passes_since_last_bid == 0
  CONDITION: c_realsolid == True
  CONDITION: losing_trick_count <= 0

RULE B_1C_4S_PASS_648_0:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1C'
  CONDITION: opp_last_call == '4S'
  CONDITION: passes_since_last_bid == 0

RULE B_1C_4S_5C_651_0:
  CALL: 5C
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1C'
  CONDITION: opp_last_call == '4S'
  CONDITION: passes_since_last_bid == 0
  CONDITION: club_len >= 5
  CONDITION: hcp >= 12

RULE B_1C_4S_6C_656_0:
  CALL: 6C
  PRIORITY: 35
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1C'
  CONDITION: opp_last_call == '4S'
  CONDITION: passes_since_last_bid == 0
  CONDITION: c_realsolid == True
  CONDITION: losing_trick_count == 1

RULE B_1C_4S_7C_659_0:
  CALL: 7C
  PRIORITY: 36
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1C'
  CONDITION: opp_last_call == '4S'
  CONDITION: passes_since_last_bid == 0
  CONDITION: c_realsolid == True
  CONDITION: losing_trick_count <= 0

RULE B_1C_6D_PASS_668_0:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1C'
  CONDITION: opp_last_call == '6D'
  CONDITION: passes_since_last_bid == 0

RULE B_1C_6H_PASS_669_0:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1C'
  CONDITION: opp_last_call == '6H'
  CONDITION: passes_since_last_bid == 0

RULE B_1C_7H_PASS_670_0:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1C'
  CONDITION: opp_last_call == '7H'
  CONDITION: passes_since_last_bid == 0

RULE B_1C_1N_PASS_671_0:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1C'
  CONDITION: opp_last_call == '1NT'
  CONDITION: passes_since_last_bid == 0

RULE B_1C_1N_2H_674_0:
  CALL: 2H
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1C'
  CONDITION: opp_last_call == '1NT'
  CONDITION: passes_since_last_bid == 0
  CONDITION: heart_len >= 6
  CONDITION: hcp <= 8
  CONDITION: losing_trick_count <= 9
  CONDITION: hcp >= 3

RULE B_1C_1N_2S_675_0:
  CALL: 2S
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1C'
  CONDITION: opp_last_call == '1NT'
  CONDITION: passes_since_last_bid == 0
  CONDITION: spade_len >= 6
  CONDITION: hcp <= 8
  CONDITION: losing_trick_count <= 9
  CONDITION: hcp >= 3

RULE B_1C_1N_X_679_0:
  CALL: X
  PRIORITY: 50
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1C'
  CONDITION: opp_last_call == '1NT'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 9

RULE B_1C_2N_PASS_680_0:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1C'
  CONDITION: opp_last_call == '2NT'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp <= 10

RULE B_1C_2N_3C_681_0:
  CALL: 3C
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1C'
  CONDITION: opp_last_call == '2NT'
  CONDITION: passes_since_last_bid == 0
  CONDITION: club_len >= 4
  CONDITION: club_hcp >= 7
  CONDITION: club_hcp <= 11

RULE B_1C_2N_3D_682_0:
  CALL: 3D
  PRIORITY: 15
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1C'
  CONDITION: opp_last_call == '2NT'
  CONDITION: passes_since_last_bid == 0
  CONDITION: club_len >= 4
  CONDITION: club_hcp >= 12

RULE B_1C_2N_3H_683_0:
  CALL: 3H
  PRIORITY: 30
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1C'
  CONDITION: opp_last_call == '2NT'
  CONDITION: passes_since_last_bid == 0
  CONDITION: spade_len >= 5
  CONDITION: hcp >= 10

RULE B_1C_2N_3S_684_0:
  CALL: 3S
  PRIORITY: 40
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1C'
  CONDITION: opp_last_call == '2NT'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 7
  CONDITION: spade_len >= 6
  CONDITION: hcp < 10

RULE B_1C_2N_3NT_685_0:
  CALL: 3NT
  PRIORITY: 50
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1C'
  CONDITION: opp_last_call == '2NT'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 13
  CONDITION: d_stopper >= 2
  CONDITION: h_stopper >= 2
  CONDITION: hcp <= 20

RULE B_1C_2N_6C_690_0:
  CALL: 6C
  PRIORITY: 65
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1C'
  CONDITION: opp_last_call == '2NT'
  CONDITION: passes_since_last_bid == 0
  CONDITION: c_realsolid == True
  CONDITION: losing_trick_count == 1

RULE B_1C_2N_7C_692_0:
  CALL: 7C
  PRIORITY: 66
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1C'
  CONDITION: opp_last_call == '2NT'
  CONDITION: passes_since_last_bid == 0
  CONDITION: c_realsolid == True
  CONDITION: losing_trick_count <= 0

RULE B_1C_2N_X_695_0:
  CALL: X
  PRIORITY: 5
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1C'
  CONDITION: opp_last_call == '2NT'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 11

RULE B_1D_P_PASS_696_0:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1D'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 1
  CONDITION: hcp < 6

RULE B_1D_P_1H_697_6:
  CALL: 1H
  PRIORITY: 90
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1D'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 1
  CONDITION: hcp > 4
  CONDITION: heart_len >= 4
  CONDITION: d_is_longest == True

RULE B_1D_P_1S_698_2:
  CALL: 1S
  PRIORITY: 90
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1D'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 1
  CONDITION: hcp > 4
  CONDITION: spade_len >= 4
  CONDITION: d_is_longest == True

RULE B_1D_P_1NT_699_0:
  CALL: 1NT
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1D'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 1
  CONDITION: hcp <= 10
  CONDITION: hcp >= 6
  CONDITION: spade_len < 4
  CONDITION: heart_len < 4
  CONDITION: is_balanced == True

RULE B_1D_P_1NT_700_0:
  CALL: 1NT
  PRIORITY: 20
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1D'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 1
  CONDITION: club_len >= 5
  CONDITION: hcp <= 10
  CONDITION: hcp >= 6
  CONDITION: heart_len < 4
  CONDITION: spade_len < 4

RULE B_1D_P_2C_701_0:
  CALL: 2C
  PRIORITY: 80
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1D'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 1
  CONDITION: hcp > 11
  CONDITION: club_len >= 4
  CONDITION: c_is_longest == True
  CONDITION: h_is_longest == False
  CONDITION: s_is_longest == False

RULE B_1D_P_2D_702_0:
  CALL: 2D
  PRIORITY: 100
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1D'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 1
  CONDITION: diamond_len >= 4
  CONDITION: hcp >= 10
  CONDITION: heart_len < 4
  CONDITION: spade_len < 4
  CONDITION: d_is_longest == True

RULE B_1D_P_2D_702_1:
  CALL: 2D
  PRIORITY: 100
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1D'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 1
  CONDITION: diamond_len >= 4
  CONDITION: hcp >= 10
  CONDITION: heart_len < 4
  CONDITION: spade_len < 4
  CONDITION: hcp < 12

RULE B_1D_P_2H_703_3:
  CALL: 2H
  PRIORITY: 100
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1D'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 1
  CONDITION: heart_len >= 5
  CONDITION: diamond_len >= 4
  CONDITION: hcp > 17
  CONDITION: controls >= 4

RULE B_1D_P_2H_703_4:
  CALL: 2H
  PRIORITY: 100
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1D'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 1
  CONDITION: heart_len >= 6
  CONDITION: is_semi_balanced == True
  CONDITION: hcp >= 17
  CONDITION: controls >= 4

RULE B_1D_P_2S_704_3:
  CALL: 2S
  PRIORITY: 100
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1D'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 1
  CONDITION: spade_len >= 5
  CONDITION: diamond_len >= 4
  CONDITION: hcp > 17
  CONDITION: controls >= 4

RULE B_1D_P_2S_704_4:
  CALL: 2S
  PRIORITY: 100
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1D'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 1
  CONDITION: spade_len >= 6
  CONDITION: is_semi_balanced == True
  CONDITION: hcp >= 17
  CONDITION: controls >= 4

RULE B_1D_P_2NT_705_0:
  CALL: 2NT
  PRIORITY: 65
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1D'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 1
  CONDITION: is_balanced == True
  CONDITION: hcp >= 10
  CONDITION: hcp <= 12
  CONDITION: spade_len < 4
  CONDITION: heart_len < 4

RULE B_1D_P_2NT_705_1:
  CALL: 2NT
  PRIORITY: 65
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1D'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 1
  CONDITION: is_semi_balanced == True
  CONDITION: hcp >= 10
  CONDITION: hcp <= 12
  CONDITION: spade_len < 4
  CONDITION: heart_len < 4

RULE B_1D_P_3C_706_0:
  CALL: 3C
  PRIORITY: 16
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1D'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 1
  CONDITION: club_len >= 6
  CONDITION: hcp >= 9
  CONDITION: hcp <= 11
  CONDITION: heart_len < 4
  CONDITION: spade_len < 4

RULE B_1D_P_3D_707_0:
  CALL: 3D
  PRIORITY: 18
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1D'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 1
  CONDITION: diamond_len >= 5
  CONDITION: hcp >= 4
  CONDITION: hcp < 10
  CONDITION: heart_len < 4
  CONDITION: spade_len < 4
  CONDITION: d_is_longest == True

RULE B_1D_P_3H_708_0:
  CALL: 3H
  PRIORITY: 150
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1D'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 1
  CONDITION: heart_len <= 1
  CONDITION: total_points >= 14
  CONDITION: diamond_len >= 5
  CONDITION: spade_len <= 3

RULE B_1D_P_3S_709_0:
  CALL: 3S
  PRIORITY: 150
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1D'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 1
  CONDITION: spade_len <= 1
  CONDITION: total_points >= 14
  CONDITION: diamond_len >= 5
  CONDITION: heart_len <= 3

RULE B_1D_P_3NT_710_0:
  CALL: 3NT
  PRIORITY: 60
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1D'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 1
  CONDITION: is_balanced == True
  CONDITION: hcp > 12
  CONDITION: hcp < 16
  CONDITION: spade_len < 4
  CONDITION: heart_len < 4

RULE B_1D_P_4H_711_0:
  CALL: 4H
  PRIORITY: 50
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1D'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 1
  CONDITION: heart_len >= 7
  CONDITION: hcp <= 10
  CONDITION: hcp >= 6

RULE B_1D_P_4S_712_0:
  CALL: 4S
  PRIORITY: 50
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1D'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 1
  CONDITION: spade_len >= 7
  CONDITION: hcp <= 10
  CONDITION: hcp >= 6

RULE B_1D_P_5C_714_0:
  CALL: 5C
  PRIORITY: 72
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1D'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 1
  CONDITION: club_len >= 8
  CONDITION: hcp <= 10
  CONDITION: hcp >= 5

RULE B_1D_P_5D_715_0:
  CALL: 5D
  PRIORITY: 51
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1D'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 1
  CONDITION: diamond_len >= 7
  CONDITION: hcp <= 10
  CONDITION: hcp >= 5

RULE B_1D_P_6D_718_0:
  CALL: 6D
  PRIORITY: 5
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1D'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 1
  CONDITION: d_realsolid == True
  CONDITION: losing_trick_count == 1

RULE B_1D_P_7D_720_0:
  CALL: 7D
  PRIORITY: 6
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1D'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 1
  CONDITION: d_realsolid == True
  CONDITION: losing_trick_count <= 0

RULE B_1D_X_PASS_723_0:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1D'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp <= 5

RULE B_1D_X_1H_724_1:
  CALL: 1H
  PRIORITY: 54
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1D'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 0
  CONDITION: h_is_best_major == True
  CONDITION: heart_len >= 5
  CONDITION: hcp >= 10

RULE B_1D_X_1S_725_1:
  CALL: 1S
  PRIORITY: 54
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1D'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 0
  CONDITION: s_is_best_major == True
  CONDITION: spade_len >= 5
  CONDITION: hcp >= 10

RULE B_1D_X_1NT_726_0:
  CALL: 1NT
  PRIORITY: 12
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1D'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp <= 10
  CONDITION: hcp >= 6

RULE B_1D_X_2C_727_0:
  CALL: 2C
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1D'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 9
  CONDITION: c_is_longest == True
  CONDITION: club_len >= 5
  CONDITION: hcp <= 11

RULE B_1D_X_2D_728_0:
  CALL: 2D
  PRIORITY: 40
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1D'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 0
  CONDITION: diamond_len >= 4
  CONDITION: total_points >= 7
  CONDITION: total_points <= 10

RULE B_1D_X_2H_729_0:
  CALL: 2H
  PRIORITY: 95
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1D'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 0
  CONDITION: total_points >= 6
  CONDITION: hcp < 10
  CONDITION: heart_len >= 6

RULE B_1D_X_2S_730_0:
  CALL: 2S
  PRIORITY: 95
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1D'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 0
  CONDITION: total_points >= 6
  CONDITION: hcp < 10
  CONDITION: spade_len >= 6

RULE B_1D_X_2NT_731_0:
  CALL: 2NT
  PRIORITY: 120
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1D'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 0
  CONDITION: diamond_hcp > 12
  CONDITION: hcp >= 9
  CONDITION: diamond_len >= 5
  CONDITION: heart_len <= 4
  CONDITION: spade_len <= 4

RULE B_1D_X_3D_732_0:
  CALL: 3D
  PRIORITY: 90
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1D'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 7
  CONDITION: hcp <= 10
  CONDITION: diamond_len >= 5

RULE B_1D_X_3H_733_0:
  CALL: 3H
  PRIORITY: 94
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1D'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 0
  CONDITION: total_points >= 6
  CONDITION: hcp < 10
  CONDITION: heart_len >= 7

RULE B_1D_X_3S_734_0:
  CALL: 3S
  PRIORITY: 94
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1D'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 0
  CONDITION: total_points >= 6
  CONDITION: hcp < 10
  CONDITION: spade_len >= 7

RULE B_1D_X_4D_735_0:
  CALL: 4D
  PRIORITY: 97
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1D'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 3
  CONDITION: hcp <= 6
  CONDITION: diamond_len >= 7

RULE B_1D_X_4H_736_0:
  CALL: 4H
  PRIORITY: 98
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1D'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 0
  CONDITION: total_points >= 6
  CONDITION: hcp < 10
  CONDITION: heart_len >= 8

RULE B_1D_X_4S_737_0:
  CALL: 4S
  PRIORITY: 98
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1D'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 0
  CONDITION: total_points >= 6
  CONDITION: hcp < 10
  CONDITION: spade_len >= 8

RULE B_1D_X_XX_738_0:
  CALL: XX
  PRIORITY: 42
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1D'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 10
  CONDITION: longest_suit_len <= 5
  CONDITION: controls >= 2

RULE B_1D_X_XX_738_1:
  CALL: XX
  PRIORITY: 42
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1D'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 10
  CONDITION: longest_suit_len <= 5
  CONDITION: controls >= 3

RULE B_1D_X_XX_738_2:
  CALL: XX
  PRIORITY: 42
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1D'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 11
  CONDITION: longest_suit_len <= 5

RULE B_1D_X_XX_738_3:
  CALL: XX
  PRIORITY: 42
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1D'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 12
  CONDITION: club_len >= 5

RULE B_1D_1H_PASS_739_0:
  CALL: PASS
  PRIORITY: 32
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1D'
  CONDITION: opp_last_call == '1H'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp <= 9

RULE B_1D_1H_PASS_739_1:
  CALL: PASS
  PRIORITY: 32
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1D'
  CONDITION: opp_last_call == '1H'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp <= 6

RULE B_1D_1H_PASS_739_2:
  CALL: PASS
  PRIORITY: 32
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1D'
  CONDITION: opp_last_call == '1H'
  CONDITION: passes_since_last_bid == 0
  CONDITION: h_is_longest == True
  CONDITION: heart_len >= 5
  CONDITION: hcp >= 10

RULE B_1D_1H_1S_740_0:
  CALL: 1S
  PRIORITY: 80
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1D'
  CONDITION: opp_last_call == '1H'
  CONDITION: passes_since_last_bid == 0
  CONDITION: spade_hcp >= 6
  CONDITION: spade_len >= 5

RULE B_1D_1H_1NT_741_0:
  CALL: 1NT
  PRIORITY: 21
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1D'
  CONDITION: opp_last_call == '1H'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 7
  CONDITION: heart_len >= 3
  CONDITION: hcp <= 11

RULE B_1D_1H_1NT_741_1:
  CALL: 1NT
  PRIORITY: 21
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1D'
  CONDITION: opp_last_call == '1H'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 7
  CONDITION: h_stopper >= 2
  CONDITION: hcp <= 10

RULE B_1D_1H_2C_742_0:
  CALL: 2C
  PRIORITY: 55
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1D'
  CONDITION: opp_last_call == '1H'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 9
  CONDITION: club_len >= 5

RULE B_1D_1H_2C_742_1_0:
  CALL: 2C
  PRIORITY: 55
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1D'
  CONDITION: opp_last_call == '1H'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 9
  CONDITION: club_len >= 5
  CONDITION: h_has_ace == True
  CONDITION: h_has_king == True

RULE B_1D_1H_2C_742_1_1:
  CALL: 2C
  PRIORITY: 55
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1D'
  CONDITION: opp_last_call == '1H'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 9
  CONDITION: club_len >= 5
  CONDITION: h_has_ace == True
  CONDITION: h_has_queen == True

RULE B_1D_1H_2C_742_1_2:
  CALL: 2C
  PRIORITY: 55
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1D'
  CONDITION: opp_last_call == '1H'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 9
  CONDITION: club_len >= 5
  CONDITION: h_has_ace == True
  CONDITION: h_has_jack == True

RULE B_1D_1H_2C_742_1_3:
  CALL: 2C
  PRIORITY: 55
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1D'
  CONDITION: opp_last_call == '1H'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 9
  CONDITION: club_len >= 5
  CONDITION: h_has_ace == True
  CONDITION: h_has_ten == True

RULE B_1D_1H_2C_742_1_4:
  CALL: 2C
  PRIORITY: 55
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1D'
  CONDITION: opp_last_call == '1H'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 9
  CONDITION: club_len >= 5
  CONDITION: h_has_king == True
  CONDITION: h_has_queen == True

RULE B_1D_1H_2C_742_1_5:
  CALL: 2C
  PRIORITY: 55
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1D'
  CONDITION: opp_last_call == '1H'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 9
  CONDITION: club_len >= 5
  CONDITION: h_has_king == True
  CONDITION: h_has_jack == True

RULE B_1D_1H_2C_742_1_6:
  CALL: 2C
  PRIORITY: 55
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1D'
  CONDITION: opp_last_call == '1H'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 9
  CONDITION: club_len >= 5
  CONDITION: h_has_king == True
  CONDITION: h_has_ten == True

RULE B_1D_1H_2C_742_1_7:
  CALL: 2C
  PRIORITY: 55
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1D'
  CONDITION: opp_last_call == '1H'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 9
  CONDITION: club_len >= 5
  CONDITION: h_has_queen == True
  CONDITION: h_has_jack == True

RULE B_1D_1H_2C_742_1_8:
  CALL: 2C
  PRIORITY: 55
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1D'
  CONDITION: opp_last_call == '1H'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 9
  CONDITION: club_len >= 5
  CONDITION: h_has_queen == True
  CONDITION: h_has_ten == True

RULE B_1D_1H_2C_742_1_9:
  CALL: 2C
  PRIORITY: 55
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1D'
  CONDITION: opp_last_call == '1H'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 9
  CONDITION: club_len >= 5
  CONDITION: h_has_jack == True
  CONDITION: h_has_ten == True

RULE B_1D_1H_2C_742_2:
  CALL: 2C
  PRIORITY: 55
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1D'
  CONDITION: opp_last_call == '1H'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 12
  CONDITION: club_len >= 4

RULE B_1D_1H_2C_742_3:
  CALL: 2C
  PRIORITY: 55
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1D'
  CONDITION: opp_last_call == '1H'
  CONDITION: passes_since_last_bid == 0
  CONDITION: club_len >= 5
  CONDITION: hcp >= 12

RULE B_1D_1H_2D_743_0:
  CALL: 2D
  PRIORITY: 15
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1D'
  CONDITION: opp_last_call == '1H'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp <= 10
  CONDITION: hcp >= 6
  CONDITION: diamond_len >= 4

RULE B_1D_1H_2D_743_1:
  CALL: 2D
  PRIORITY: 15
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1D'
  CONDITION: opp_last_call == '1H'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp <= 9
  CONDITION: diamond_hcp >= 6
  CONDITION: diamond_len >= 4
  CONDITION: hcp >= 5

RULE B_1D_1H_2D_743_2:
  CALL: 2D
  PRIORITY: 15
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1D'
  CONDITION: opp_last_call == '1H'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp <= 9
  CONDITION: hcp >= 6
  CONDITION: diamond_len >= 4

RULE B_1D_1H_2H_744_0:
  CALL: 2H
  PRIORITY: 58
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1D'
  CONDITION: opp_last_call == '1H'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 18
  CONDITION: diamond_len >= 3
  CONDITION: spade_len <= 3

RULE B_1D_1H_2H_744_1:
  CALL: 2H
  PRIORITY: 58
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1D'
  CONDITION: opp_last_call == '1H'
  CONDITION: passes_since_last_bid == 0
  CONDITION: diamond_hcp >= 10
  CONDITION: diamond_len >= 4
  CONDITION: hcp >= 9
  CONDITION: spade_len <= 3

RULE B_1D_1H_2NT_745_0:
  CALL: 2NT
  PRIORITY: 30
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1D'
  CONDITION: opp_last_call == '1H'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 10
  CONDITION: heart_len >= 4
  CONDITION: hcp <= 12

RULE B_1D_1H_2NT_745_1:
  CALL: 2NT
  PRIORITY: 30
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1D'
  CONDITION: opp_last_call == '1H'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 10
  CONDITION: h_stopper >= 2
  CONDITION: hcp <= 11

RULE B_1D_1H_3C_746_0:
  CALL: 3C
  PRIORITY: 45
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1D'
  CONDITION: opp_last_call == '1H'
  CONDITION: passes_since_last_bid == 0
  CONDITION: club_len >= 6
  CONDITION: hcp >= 13
  CONDITION: club_hcp <= 15

RULE B_1D_1H_3D_747_0:
  CALL: 3D
  PRIORITY: 47
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1D'
  CONDITION: opp_last_call == '1H'
  CONDITION: passes_since_last_bid == 0
  CONDITION: diamond_len >= 5
  CONDITION: hcp >= 4
  CONDITION: diamond_hcp <= 9

RULE B_1D_1H_3S_748_0:
  CALL: 3S
  PRIORITY: 60
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1D'
  CONDITION: opp_last_call == '1H'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 15
  CONDITION: spade_len >= 6

RULE B_1D_1H_3NT_749_0:
  CALL: 3NT
  PRIORITY: 75
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1D'
  CONDITION: opp_last_call == '1H'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 12
  CONDITION: heart_len >= 4
  CONDITION: hcp <= 17
  CONDITION: diamond_len <= 3

RULE B_1D_1H_3NT_749_1:
  CALL: 3NT
  PRIORITY: 75
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1D'
  CONDITION: opp_last_call == '1H'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 12
  CONDITION: h_stopper >= 2
  CONDITION: hcp <= 17
  CONDITION: diamond_len <= 3
  CONDITION: is_semi_balanced == True
  CONDITION: spade_len <= 3

RULE B_1D_1H_4D_750_0:
  CALL: 4D
  PRIORITY: 67
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1D'
  CONDITION: opp_last_call == '1H'
  CONDITION: passes_since_last_bid == 0
  CONDITION: diamond_len >= 6
  CONDITION: hcp <= 4
  CONDITION: diamond_hcp >= 7

RULE B_1D_1H_4S_751_0:
  CALL: 4S
  PRIORITY: 100
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1D'
  CONDITION: opp_last_call == '1H'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 6
  CONDITION: hcp <= 10
  CONDITION: spade_len >= 7

RULE B_1D_1H_6D_755_0:
  CALL: 6D
  PRIORITY: 95
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1D'
  CONDITION: opp_last_call == '1H'
  CONDITION: passes_since_last_bid == 0
  CONDITION: diamond_len >= 5
  CONDITION: d_realsolid == True
  CONDITION: losing_trick_count == 1

RULE B_1D_1H_7D_757_0:
  CALL: 7D
  PRIORITY: 96
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1D'
  CONDITION: opp_last_call == '1H'
  CONDITION: passes_since_last_bid == 0
  CONDITION: diamond_len >= 5
  CONDITION: d_realsolid == True
  CONDITION: losing_trick_count <= 0

RULE B_1D_1S_PASS_761_0:
  CALL: PASS
  PRIORITY: 32
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1D'
  CONDITION: opp_last_call == '1S'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp <= 9

RULE B_1D_1S_PASS_761_1:
  CALL: PASS
  PRIORITY: 32
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1D'
  CONDITION: opp_last_call == '1S'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp <= 6

RULE B_1D_1S_PASS_761_2:
  CALL: PASS
  PRIORITY: 32
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1D'
  CONDITION: opp_last_call == '1S'
  CONDITION: passes_since_last_bid == 0
  CONDITION: s_is_longest == True
  CONDITION: spade_len >= 5
  CONDITION: hcp >= 10

RULE B_1D_1S_1NT_762_0:
  CALL: 1NT
  PRIORITY: 21
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1D'
  CONDITION: opp_last_call == '1S'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 7
  CONDITION: spade_len >= 3
  CONDITION: hcp <= 11

RULE B_1D_1S_1NT_762_1:
  CALL: 1NT
  PRIORITY: 21
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1D'
  CONDITION: opp_last_call == '1S'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 7
  CONDITION: s_stopper >= 2
  CONDITION: hcp <= 10

RULE B_1D_1S_2C_763_0:
  CALL: 2C
  PRIORITY: 55
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1D'
  CONDITION: opp_last_call == '1S'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 9
  CONDITION: club_len >= 5

RULE B_1D_1S_2C_763_1_0:
  CALL: 2C
  PRIORITY: 55
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1D'
  CONDITION: opp_last_call == '1S'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 9
  CONDITION: club_len >= 5
  CONDITION: h_has_ace == True
  CONDITION: h_has_king == True

RULE B_1D_1S_2C_763_1_1:
  CALL: 2C
  PRIORITY: 55
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1D'
  CONDITION: opp_last_call == '1S'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 9
  CONDITION: club_len >= 5
  CONDITION: h_has_ace == True
  CONDITION: h_has_queen == True

RULE B_1D_1S_2C_763_1_2:
  CALL: 2C
  PRIORITY: 55
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1D'
  CONDITION: opp_last_call == '1S'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 9
  CONDITION: club_len >= 5
  CONDITION: h_has_ace == True
  CONDITION: h_has_jack == True

RULE B_1D_1S_2C_763_1_3:
  CALL: 2C
  PRIORITY: 55
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1D'
  CONDITION: opp_last_call == '1S'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 9
  CONDITION: club_len >= 5
  CONDITION: h_has_ace == True
  CONDITION: h_has_ten == True

RULE B_1D_1S_2C_763_1_4:
  CALL: 2C
  PRIORITY: 55
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1D'
  CONDITION: opp_last_call == '1S'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 9
  CONDITION: club_len >= 5
  CONDITION: h_has_king == True
  CONDITION: h_has_queen == True

RULE B_1D_1S_2C_763_1_5:
  CALL: 2C
  PRIORITY: 55
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1D'
  CONDITION: opp_last_call == '1S'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 9
  CONDITION: club_len >= 5
  CONDITION: h_has_king == True
  CONDITION: h_has_jack == True

RULE B_1D_1S_2C_763_1_6:
  CALL: 2C
  PRIORITY: 55
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1D'
  CONDITION: opp_last_call == '1S'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 9
  CONDITION: club_len >= 5
  CONDITION: h_has_king == True
  CONDITION: h_has_ten == True

RULE B_1D_1S_2C_763_1_7:
  CALL: 2C
  PRIORITY: 55
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1D'
  CONDITION: opp_last_call == '1S'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 9
  CONDITION: club_len >= 5
  CONDITION: h_has_queen == True
  CONDITION: h_has_jack == True

RULE B_1D_1S_2C_763_1_8:
  CALL: 2C
  PRIORITY: 55
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1D'
  CONDITION: opp_last_call == '1S'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 9
  CONDITION: club_len >= 5
  CONDITION: h_has_queen == True
  CONDITION: h_has_ten == True

RULE B_1D_1S_2C_763_1_9:
  CALL: 2C
  PRIORITY: 55
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1D'
  CONDITION: opp_last_call == '1S'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 9
  CONDITION: club_len >= 5
  CONDITION: h_has_jack == True
  CONDITION: h_has_ten == True

RULE B_1D_1S_2C_763_2:
  CALL: 2C
  PRIORITY: 55
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1D'
  CONDITION: opp_last_call == '1S'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 12
  CONDITION: club_len >= 4

RULE B_1D_1S_2C_763_3:
  CALL: 2C
  PRIORITY: 55
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1D'
  CONDITION: opp_last_call == '1S'
  CONDITION: passes_since_last_bid == 0
  CONDITION: club_len >= 5
  CONDITION: hcp >= 12

RULE B_1D_1S_2D_764_0:
  CALL: 2D
  PRIORITY: 15
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1D'
  CONDITION: opp_last_call == '1S'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp <= 10
  CONDITION: hcp >= 6
  CONDITION: diamond_len >= 4

RULE B_1D_1S_2D_764_1:
  CALL: 2D
  PRIORITY: 15
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1D'
  CONDITION: opp_last_call == '1S'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp <= 9
  CONDITION: diamond_hcp >= 6
  CONDITION: diamond_len >= 4
  CONDITION: hcp >= 5

RULE B_1D_1S_2D_764_2:
  CALL: 2D
  PRIORITY: 15
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1D'
  CONDITION: opp_last_call == '1S'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp <= 9
  CONDITION: hcp >= 6
  CONDITION: diamond_len >= 4

RULE B_1D_1S_2H_765_0:
  CALL: 2H
  PRIORITY: 80
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1D'
  CONDITION: opp_last_call == '1S'
  CONDITION: passes_since_last_bid == 0
  CONDITION: heart_len >= 6
  CONDITION: hcp >= 8

RULE B_1D_1S_2H_765_1:
  CALL: 2H
  PRIORITY: 80
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1D'
  CONDITION: opp_last_call == '1S'
  CONDITION: passes_since_last_bid == 0
  CONDITION: heart_len >= 5
  CONDITION: hcp >= 10

RULE B_1D_1S_2S_766_0:
  CALL: 2S
  PRIORITY: 58
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1D'
  CONDITION: opp_last_call == '1S'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 18
  CONDITION: diamond_len >= 3
  CONDITION: heart_len <= 3

RULE B_1D_1S_2S_766_1:
  CALL: 2S
  PRIORITY: 58
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1D'
  CONDITION: opp_last_call == '1S'
  CONDITION: passes_since_last_bid == 0
  CONDITION: diamond_hcp >= 10
  CONDITION: diamond_len >= 4
  CONDITION: hcp >= 9
  CONDITION: heart_len <= 3

RULE B_1D_1S_2NT_767_0:
  CALL: 2NT
  PRIORITY: 30
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1D'
  CONDITION: opp_last_call == '1S'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 10
  CONDITION: spade_len >= 4
  CONDITION: hcp <= 12

RULE B_1D_1S_2NT_767_1:
  CALL: 2NT
  PRIORITY: 30
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1D'
  CONDITION: opp_last_call == '1S'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 10
  CONDITION: s_stopper >= 2
  CONDITION: hcp <= 11

RULE B_1D_1S_3C_768_0:
  CALL: 3C
  PRIORITY: 45
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1D'
  CONDITION: opp_last_call == '1S'
  CONDITION: passes_since_last_bid == 0
  CONDITION: club_len >= 6
  CONDITION: hcp >= 13
  CONDITION: club_hcp <= 15

RULE B_1D_1S_3D_769_0:
  CALL: 3D
  PRIORITY: 47
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1D'
  CONDITION: opp_last_call == '1S'
  CONDITION: passes_since_last_bid == 0
  CONDITION: diamond_len >= 5
  CONDITION: hcp >= 4
  CONDITION: diamond_hcp <= 9

RULE B_1D_1S_3H_770_0:
  CALL: 3H
  PRIORITY: 60
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1D'
  CONDITION: opp_last_call == '1S'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 15
  CONDITION: heart_len >= 6

RULE B_1D_1S_3NT_771_0:
  CALL: 3NT
  PRIORITY: 75
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1D'
  CONDITION: opp_last_call == '1S'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 12
  CONDITION: spade_len >= 4
  CONDITION: hcp <= 17
  CONDITION: diamond_len <= 3

RULE B_1D_1S_3NT_771_1:
  CALL: 3NT
  PRIORITY: 75
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1D'
  CONDITION: opp_last_call == '1S'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 12
  CONDITION: s_stopper >= 2
  CONDITION: hcp <= 17
  CONDITION: diamond_len <= 3
  CONDITION: is_semi_balanced == True
  CONDITION: heart_len <= 3

RULE B_1D_1S_4D_772_0:
  CALL: 4D
  PRIORITY: 67
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1D'
  CONDITION: opp_last_call == '1S'
  CONDITION: passes_since_last_bid == 0
  CONDITION: diamond_len >= 6
  CONDITION: hcp <= 4
  CONDITION: diamond_hcp >= 7

RULE B_1D_1S_4H_773_0:
  CALL: 4H
  PRIORITY: 80
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1D'
  CONDITION: opp_last_call == '1S'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 6
  CONDITION: hcp <= 10
  CONDITION: heart_len >= 7

RULE B_1D_1S_6D_777_0:
  CALL: 6D
  PRIORITY: 95
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1D'
  CONDITION: opp_last_call == '1S'
  CONDITION: passes_since_last_bid == 0
  CONDITION: diamond_len >= 5
  CONDITION: d_realsolid == True
  CONDITION: losing_trick_count == 1

RULE B_1D_1S_7D_779_0:
  CALL: 7D
  PRIORITY: 96
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1D'
  CONDITION: opp_last_call == '1S'
  CONDITION: passes_since_last_bid == 0
  CONDITION: diamond_len >= 5
  CONDITION: d_realsolid == True
  CONDITION: losing_trick_count <= 0

RULE B_1D_2C_PASS_783_0:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1D'
  CONDITION: opp_last_call == '2C'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp <= 11
  CONDITION: club_len >= 4

RULE B_1D_2C_PASS_783_1:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1D'
  CONDITION: opp_last_call == '2C'
  CONDITION: passes_since_last_bid == 0
  CONDITION: club_len >= 4
  CONDITION: hcp >= 10

RULE B_1D_2C_PASS_783_2:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1D'
  CONDITION: opp_last_call == '2C'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp <= 10

RULE B_1D_2C_PASS_783_3:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1D'
  CONDITION: opp_last_call == '2C'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp <= 8

RULE B_1D_2C_PASS_783_4:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1D'
  CONDITION: opp_last_call == '2C'
  CONDITION: passes_since_last_bid == 0
  CONDITION: club_len >= 5

RULE B_1D_2C_2D_784_0:
  CALL: 2D
  PRIORITY: 52
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1D'
  CONDITION: opp_last_call == '2C'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 6
  CONDITION: diamond_len >= 4

RULE B_1D_2C_2H_785_0:
  CALL: 2H
  PRIORITY: 65
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1D'
  CONDITION: opp_last_call == '2C'
  CONDITION: passes_since_last_bid == 0
  CONDITION: h_is_best_major == True
  CONDITION: heart_len >= 5
  CONDITION: hcp >= 9
  CONDITION: spade_len <= 3

RULE B_1D_2C_2H_785_1:
  CALL: 2H
  PRIORITY: 65
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1D'
  CONDITION: opp_last_call == '2C'
  CONDITION: passes_since_last_bid == 0
  CONDITION: h_is_best_major == True
  CONDITION: heart_len >= 6
  CONDITION: hcp >= 10

RULE B_1D_2C_2H_785_2:
  CALL: 2H
  PRIORITY: 65
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1D'
  CONDITION: opp_last_call == '2C'
  CONDITION: passes_since_last_bid == 0
  CONDITION: h_is_best_major == True
  CONDITION: heart_len >= 5
  CONDITION: hcp >= 12

RULE B_1D_2C_2S_786_0:
  CALL: 2S
  PRIORITY: 65
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1D'
  CONDITION: opp_last_call == '2C'
  CONDITION: passes_since_last_bid == 0
  CONDITION: s_is_best_major == True
  CONDITION: spade_len >= 5
  CONDITION: hcp >= 9
  CONDITION: heart_len <= 3

RULE B_1D_2C_2S_786_1:
  CALL: 2S
  PRIORITY: 65
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1D'
  CONDITION: opp_last_call == '2C'
  CONDITION: passes_since_last_bid == 0
  CONDITION: s_is_best_major == True
  CONDITION: spade_len >= 6
  CONDITION: hcp >= 10

RULE B_1D_2C_2S_786_2:
  CALL: 2S
  PRIORITY: 65
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1D'
  CONDITION: opp_last_call == '2C'
  CONDITION: passes_since_last_bid == 0
  CONDITION: s_is_best_major == True
  CONDITION: spade_len >= 5
  CONDITION: hcp >= 12

RULE B_1D_2C_2NT_787_0:
  CALL: 2NT
  PRIORITY: 32
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1D'
  CONDITION: opp_last_call == '2C'
  CONDITION: passes_since_last_bid == 0
  CONDITION: c_stopper >= 2
  CONDITION: hcp >= 9
  CONDITION: hcp <= 11

RULE B_1D_2C_3C_788_0:
  CALL: 3C
  PRIORITY: 55
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1D'
  CONDITION: opp_last_call == '2C'
  CONDITION: passes_since_last_bid == 0
  CONDITION: diamond_len >= 4
  CONDITION: diamond_hcp >= 10

RULE B_1D_2C_3D_789_0:
  CALL: 3D
  PRIORITY: 58
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1D'
  CONDITION: opp_last_call == '2C'
  CONDITION: passes_since_last_bid == 0
  CONDITION: diamond_len >= 5
  CONDITION: diamond_hcp >= 6
  CONDITION: diamond_hcp <= 9

RULE B_1D_2C_3NT_792_0:
  CALL: 3NT
  PRIORITY: 30
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1D'
  CONDITION: opp_last_call == '2C'
  CONDITION: passes_since_last_bid == 0
  CONDITION: c_stopper >= 2
  CONDITION: hcp >= 12

RULE B_1D_2C_4H_793_0:
  CALL: 4H
  PRIORITY: 64
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1D'
  CONDITION: opp_last_call == '2C'
  CONDITION: passes_since_last_bid == 0
  CONDITION: heart_len >= 7
  CONDITION: hcp <= 10
  CONDITION: hcp >= 6

RULE B_1D_2C_4S_794_0:
  CALL: 4S
  PRIORITY: 64
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1D'
  CONDITION: opp_last_call == '2C'
  CONDITION: passes_since_last_bid == 0
  CONDITION: spade_len >= 7
  CONDITION: hcp <= 10
  CONDITION: hcp >= 6

RULE B_1D_2C_6D_798_0:
  CALL: 6D
  PRIORITY: 65
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1D'
  CONDITION: opp_last_call == '2C'
  CONDITION: passes_since_last_bid == 0
  CONDITION: d_realsolid == True
  CONDITION: losing_trick_count == 1

RULE B_1D_2C_7D_800_0:
  CALL: 7D
  PRIORITY: 66
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1D'
  CONDITION: opp_last_call == '2C'
  CONDITION: passes_since_last_bid == 0
  CONDITION: d_realsolid == True
  CONDITION: losing_trick_count <= 0

RULE B_1D_2C_X_803_0:
  CALL: X
  PRIORITY: 44
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1D'
  CONDITION: opp_last_call == '2C'
  CONDITION: passes_since_last_bid == 0
  CONDITION: heart_len >= 3
  CONDITION: hcp >= 9
  CONDITION: spade_len >= 3

RULE B_1D_2C_X_803_1:
  CALL: X
  PRIORITY: 44
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1D'
  CONDITION: opp_last_call == '2C'
  CONDITION: passes_since_last_bid == 0
  CONDITION: heart_len >= 4
  CONDITION: hcp >= 9
  CONDITION: spade_len >= 4

RULE B_1D_2D_PASS_804_0:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1D'
  CONDITION: opp_last_call == '2D'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp <= 11

RULE B_1D_2D_2H_805_0:
  CALL: 2H
  PRIORITY: 40
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1D'
  CONDITION: opp_last_call == '2D'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 10
  CONDITION: diamond_len >= 4

RULE B_1D_2D_2S_806_0:
  CALL: 2S
  PRIORITY: 45
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1D'
  CONDITION: opp_last_call == '2D'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 10
  CONDITION: club_len >= 5

RULE B_1D_2D_2S_806_1:
  CALL: 2S
  PRIORITY: 45
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1D'
  CONDITION: opp_last_call == '2D'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 10
  CONDITION: club_len >= 5
  CONDITION: diamond_len <= 4

RULE B_1D_2D_2NT_807_0:
  CALL: 2NT
  PRIORITY: 50
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1D'
  CONDITION: opp_last_call == '2D'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 10
  CONDITION: s_stopper >= 2
  CONDITION: h_stopper >= 2
  CONDITION: hcp <= 12

RULE B_1D_2D_3C_808_0:
  CALL: 3C
  PRIORITY: 50
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1D'
  CONDITION: opp_last_call == '2D'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 7
  CONDITION: club_len >= 6
  CONDITION: hcp <= 10

RULE B_1D_2D_3D_809_0:
  CALL: 3D
  PRIORITY: 52
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1D'
  CONDITION: opp_last_call == '2D'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 7
  CONDITION: diamond_len >= 4
  CONDITION: hcp <= 9

RULE B_1D_2D_3H_810_0:
  CALL: 3H
  PRIORITY: 55
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1D'
  CONDITION: opp_last_call == '2D'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 9
  CONDITION: diamond_len >= 4
  CONDITION: hcp <= 9

RULE B_1D_2D_3S_811_0:
  CALL: 3S
  PRIORITY: 56
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1D'
  CONDITION: opp_last_call == '2D'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 11
  CONDITION: diamond_len >= 5

RULE B_1D_2D_3NT_812_0:
  CALL: 3NT
  PRIORITY: 57
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1D'
  CONDITION: opp_last_call == '2D'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 13
  CONDITION: s_stopper >= 2
  CONDITION: h_stopper >= 2
  CONDITION: hcp <= 20

RULE B_1D_2D_4D_813_0:
  CALL: 4D
  PRIORITY: 53
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1D'
  CONDITION: opp_last_call == '2D'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 4
  CONDITION: diamond_len >= 6
  CONDITION: hcp <= 9

RULE B_1D_2D_4H_814_0:
  CALL: 4H
  PRIORITY: 58
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1D'
  CONDITION: opp_last_call == '2D'
  CONDITION: passes_since_last_bid == 0
  CONDITION: diamond_len >= 5
  CONDITION: diamond_hcp >= 17
  CONDITION: heart_len <= 1

RULE B_1D_2D_4S_815_0:
  CALL: 4S
  PRIORITY: 58
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1D'
  CONDITION: opp_last_call == '2D'
  CONDITION: passes_since_last_bid == 0
  CONDITION: diamond_len >= 5
  CONDITION: diamond_hcp >= 17
  CONDITION: spade_len <= 1

RULE B_1D_2D_6D_820_0:
  CALL: 6D
  PRIORITY: 65
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1D'
  CONDITION: opp_last_call == '2D'
  CONDITION: passes_since_last_bid == 0
  CONDITION: diamond_len >= 5
  CONDITION: d_realsolid == True
  CONDITION: losing_trick_count == 1

RULE B_1D_2D_7D_822_0:
  CALL: 7D
  PRIORITY: 66
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1D'
  CONDITION: opp_last_call == '2D'
  CONDITION: passes_since_last_bid == 0
  CONDITION: diamond_len >= 5
  CONDITION: d_realsolid == True
  CONDITION: losing_trick_count <= 0

RULE B_1D_2D_X_825_0:
  CALL: X
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1D'
  CONDITION: opp_last_call == '2D'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 12

RULE B_1D_2H_PASS_826_0:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1D'
  CONDITION: opp_last_call == '2H'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp <= 11

RULE B_1D_2H_PASS_826_2:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1D'
  CONDITION: opp_last_call == '2H'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp <= 9

RULE B_1D_2H_2S_827_0:
  CALL: 2S
  PRIORITY: 70
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1D'
  CONDITION: opp_last_call == '2H'
  CONDITION: passes_since_last_bid == 0
  CONDITION: spade_hcp >= 11
  CONDITION: spade_len >= 5

RULE B_1D_2H_2NT_828_0:
  CALL: 2NT
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1D'
  CONDITION: opp_last_call == '2H'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 10
  CONDITION: h_stopper >= 2
  CONDITION: hcp <= 12

RULE B_1D_2H_3C_829_0:
  CALL: 3C
  PRIORITY: 50
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1D'
  CONDITION: opp_last_call == '2H'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 10
  CONDITION: club_len >= 5

RULE B_1D_2H_3C_829_1:
  CALL: 3C
  PRIORITY: 50
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1D'
  CONDITION: opp_last_call == '2H'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 11
  CONDITION: club_len >= 5

RULE B_1D_2H_3C_829_2:
  CALL: 3C
  PRIORITY: 50
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1D'
  CONDITION: opp_last_call == '2H'
  CONDITION: passes_since_last_bid == 0
  CONDITION: club_len >= 4
  CONDITION: hcp >= 12

RULE B_1D_2H_3D_830_0:
  CALL: 3D
  PRIORITY: 20
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1D'
  CONDITION: opp_last_call == '2H'
  CONDITION: passes_since_last_bid == 0
  CONDITION: diamond_hcp >= 9
  CONDITION: hcp <= 11
  CONDITION: diamond_len >= 5

RULE B_1D_2H_3D_830_1:
  CALL: 3D
  PRIORITY: 20
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1D'
  CONDITION: opp_last_call == '2H'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 9
  CONDITION: hcp <= 11
  CONDITION: diamond_len >= 4

RULE B_1D_2H_3H_832_0:
  CALL: 3H
  PRIORITY: 55
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1D'
  CONDITION: opp_last_call == '2H'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 12
  CONDITION: diamond_len >= 3

RULE B_1D_2H_3H_832_1:
  CALL: 3H
  PRIORITY: 55
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1D'
  CONDITION: opp_last_call == '2H'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 11
  CONDITION: diamond_len >= 4

RULE B_1D_2H_6D_839_0:
  CALL: 6D
  PRIORITY: 75
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1D'
  CONDITION: opp_last_call == '2H'
  CONDITION: passes_since_last_bid == 0
  CONDITION: diamond_len >= 5
  CONDITION: d_realsolid == True
  CONDITION: losing_trick_count == 1

RULE B_1D_2H_7D_841_0:
  CALL: 7D
  PRIORITY: 76
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1D'
  CONDITION: opp_last_call == '2H'
  CONDITION: passes_since_last_bid == 0
  CONDITION: diamond_len >= 5
  CONDITION: d_realsolid == True
  CONDITION: losing_trick_count <= 0

RULE B_1D_2H_X_844_0:
  CALL: X
  PRIORITY: 60
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1D'
  CONDITION: opp_last_call == '2H'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 13
  CONDITION: spade_len >= 3

RULE B_1D_2H_X_844_1:
  CALL: X
  PRIORITY: 60
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1D'
  CONDITION: opp_last_call == '2H'
  CONDITION: passes_since_last_bid == 0
  CONDITION: total_points >= 9
  CONDITION: spade_len >= 4

RULE B_1D_2S_PASS_845_0:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1D'
  CONDITION: opp_last_call == '2S'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp <= 11

RULE B_1D_2S_PASS_845_2:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1D'
  CONDITION: opp_last_call == '2S'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp <= 9

RULE B_1D_2S_2NT_846_0:
  CALL: 2NT
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1D'
  CONDITION: opp_last_call == '2S'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 10
  CONDITION: s_stopper >= 2
  CONDITION: hcp <= 12

RULE B_1D_2S_3C_847_0:
  CALL: 3C
  PRIORITY: 50
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1D'
  CONDITION: opp_last_call == '2S'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 10
  CONDITION: club_len >= 5

RULE B_1D_2S_3C_847_1:
  CALL: 3C
  PRIORITY: 50
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1D'
  CONDITION: opp_last_call == '2S'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 11
  CONDITION: club_len >= 5

RULE B_1D_2S_3C_847_2:
  CALL: 3C
  PRIORITY: 50
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1D'
  CONDITION: opp_last_call == '2S'
  CONDITION: passes_since_last_bid == 0
  CONDITION: club_len >= 4
  CONDITION: hcp >= 12

RULE B_1D_2S_3D_848_0:
  CALL: 3D
  PRIORITY: 20
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1D'
  CONDITION: opp_last_call == '2S'
  CONDITION: passes_since_last_bid == 0
  CONDITION: diamond_hcp >= 9
  CONDITION: hcp <= 11
  CONDITION: diamond_len >= 5

RULE B_1D_2S_3D_848_1:
  CALL: 3D
  PRIORITY: 20
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1D'
  CONDITION: opp_last_call == '2S'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 9
  CONDITION: hcp <= 11
  CONDITION: diamond_len >= 4

RULE B_1D_2S_3H_849_0:
  CALL: 3H
  PRIORITY: 65
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1D'
  CONDITION: opp_last_call == '2S'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 9
  CONDITION: heart_len >= 5
  CONDITION: h_is_longest == True

RULE B_1D_2S_3S_851_0:
  CALL: 3S
  PRIORITY: 55
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1D'
  CONDITION: opp_last_call == '2S'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 12
  CONDITION: diamond_len >= 3

RULE B_1D_2S_3S_851_1:
  CALL: 3S
  PRIORITY: 55
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1D'
  CONDITION: opp_last_call == '2S'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 11
  CONDITION: diamond_len >= 4

RULE B_1D_2S_6D_857_0:
  CALL: 6D
  PRIORITY: 75
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1D'
  CONDITION: opp_last_call == '2S'
  CONDITION: passes_since_last_bid == 0
  CONDITION: diamond_len >= 5
  CONDITION: d_realsolid == True
  CONDITION: losing_trick_count == 1

RULE B_1D_2S_7D_859_0:
  CALL: 7D
  PRIORITY: 76
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1D'
  CONDITION: opp_last_call == '2S'
  CONDITION: passes_since_last_bid == 0
  CONDITION: diamond_len >= 5
  CONDITION: d_realsolid == True
  CONDITION: losing_trick_count <= 0

RULE B_1D_2S_X_862_0:
  CALL: X
  PRIORITY: 60
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1D'
  CONDITION: opp_last_call == '2S'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 13
  CONDITION: heart_len >= 3

RULE B_1D_2S_X_862_1:
  CALL: X
  PRIORITY: 60
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1D'
  CONDITION: opp_last_call == '2S'
  CONDITION: passes_since_last_bid == 0
  CONDITION: total_points >= 9
  CONDITION: heart_len >= 4

RULE B_1D_3C_PASS_863_0:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1D'
  CONDITION: opp_last_call == '3C'
  CONDITION: passes_since_last_bid == 0

RULE B_1D_3C_PASS_863_1:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1D'
  CONDITION: opp_last_call == '3C'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp <= 9

RULE B_1D_3C_3D_864_0:
  CALL: 3D
  PRIORITY: 22
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1D'
  CONDITION: opp_last_call == '3C'
  CONDITION: passes_since_last_bid == 0
  CONDITION: diamond_len >= 5
  CONDITION: diamond_hcp >= 9
  CONDITION: hcp <= 10

RULE B_1D_3C_3H_865_0:
  CALL: 3H
  PRIORITY: 20
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1D'
  CONDITION: opp_last_call == '3C'
  CONDITION: passes_since_last_bid == 0
  CONDITION: h_is_best_major == True
  CONDITION: heart_len >= 6
  CONDITION: hcp >= 10

RULE B_1D_3C_3H_865_1:
  CALL: 3H
  PRIORITY: 20
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1D'
  CONDITION: opp_last_call == '3C'
  CONDITION: passes_since_last_bid == 0
  CONDITION: h_is_best_major == True
  CONDITION: heart_len >= 5
  CONDITION: hcp >= 12

RULE B_1D_3C_3S_866_0:
  CALL: 3S
  PRIORITY: 20
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1D'
  CONDITION: opp_last_call == '3C'
  CONDITION: passes_since_last_bid == 0
  CONDITION: s_is_best_major == True
  CONDITION: spade_len >= 6
  CONDITION: hcp >= 10

RULE B_1D_3C_3S_866_1:
  CALL: 3S
  PRIORITY: 20
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1D'
  CONDITION: opp_last_call == '3C'
  CONDITION: passes_since_last_bid == 0
  CONDITION: s_is_best_major == True
  CONDITION: spade_len >= 5
  CONDITION: hcp >= 12

RULE B_1D_3C_3NT_867_0:
  CALL: 3NT
  PRIORITY: 30
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1D'
  CONDITION: opp_last_call == '3C'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 12
  CONDITION: c_stopper >= 2

RULE B_1D_3C_X_870_0:
  CALL: X
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1D'
  CONDITION: opp_last_call == '3C'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 10

RULE B_1D_3D_PASS_871_0:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1D'
  CONDITION: opp_last_call == '3D'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp <= 9

RULE B_1D_3D_X_873_0:
  CALL: X
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1D'
  CONDITION: opp_last_call == '3D'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 10

RULE B_1D_3H_PASS_874_0:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1D'
  CONDITION: opp_last_call == '3H'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp <= 12

RULE B_1D_3H_PASS_874_1:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1D'
  CONDITION: opp_last_call == '3H'
  CONDITION: passes_since_last_bid == 0
  CONDITION: heart_len >= 4

RULE B_1D_3H_PASS_874_2:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1D'
  CONDITION: opp_last_call == '3H'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp <= 8

RULE B_1D_3H_3S_875_0:
  CALL: 3S
  PRIORITY: 100
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1D'
  CONDITION: opp_last_call == '3H'
  CONDITION: passes_since_last_bid == 0
  CONDITION: spade_len >= 5
  CONDITION: hcp >= 12
  CONDITION: s_top2_honors >= 1

RULE B_1D_3H_3S_875_1:
  CALL: 3S
  PRIORITY: 100
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1D'
  CONDITION: opp_last_call == '3H'
  CONDITION: passes_since_last_bid == 0
  CONDITION: spade_len >= 6
  CONDITION: hcp >= 12

RULE B_1D_3H_4C_877_0:
  CALL: 4C
  PRIORITY: 16
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1D'
  CONDITION: opp_last_call == '3H'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 12
  CONDITION: club_len >= 6

RULE B_1D_3H_4D_878_0:
  CALL: 4D
  PRIORITY: 12
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1D'
  CONDITION: opp_last_call == '3H'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 10
  CONDITION: diamond_len >= 4
  CONDITION: hcp <= 14

RULE B_1D_3H_4H_879_0:
  CALL: 4H
  PRIORITY: 52
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1D'
  CONDITION: opp_last_call == '3H'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 10
  CONDITION: diamond_len >= 4
  CONDITION: diamond_hcp >= 14

RULE B_1D_3H_4S_880_0:
  CALL: 4S
  PRIORITY: 56
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1D'
  CONDITION: opp_last_call == '3H'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 10
  CONDITION: spade_len >= 6
  CONDITION: diamond_hcp >= 14

RULE B_1D_3H_5D_882_0:
  CALL: 5D
  PRIORITY: 27
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1D'
  CONDITION: opp_last_call == '3H'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 15
  CONDITION: diamond_len >= 4
  CONDITION: hcp <= 18

RULE B_1D_3H_6D_885_0:
  CALL: 6D
  PRIORITY: 35
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1D'
  CONDITION: opp_last_call == '3H'
  CONDITION: passes_since_last_bid == 0
  CONDITION: diamond_len >= 4
  CONDITION: d_realsolid == True
  CONDITION: losing_trick_count == 1

RULE B_1D_3H_6S_887_0:
  CALL: 6S
  PRIORITY: 66
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1D'
  CONDITION: opp_last_call == '3H'
  CONDITION: passes_since_last_bid == 0
  CONDITION: spade_len >= 8
  CONDITION: losing_trick_count <= 3

RULE B_1D_3H_7D_888_0:
  CALL: 7D
  PRIORITY: 36
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1D'
  CONDITION: opp_last_call == '3H'
  CONDITION: passes_since_last_bid == 0
  CONDITION: diamond_len >= 4
  CONDITION: d_realsolid == True
  CONDITION: losing_trick_count <= 0

RULE B_1D_3H_X_891_0:
  CALL: X
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1D'
  CONDITION: opp_last_call == '3H'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 12

RULE B_1D_3H_X_891_1:
  CALL: X
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1D'
  CONDITION: opp_last_call == '3H'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 10
  CONDITION: heart_len <= 2

RULE B_1D_3S_PASS_892_0:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1D'
  CONDITION: opp_last_call == '3S'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp <= 12

RULE B_1D_3S_PASS_892_1:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1D'
  CONDITION: opp_last_call == '3S'
  CONDITION: passes_since_last_bid == 0
  CONDITION: spade_len >= 4

RULE B_1D_3S_PASS_892_2:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1D'
  CONDITION: opp_last_call == '3S'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp <= 8

RULE B_1D_3S_4C_894_0:
  CALL: 4C
  PRIORITY: 16
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1D'
  CONDITION: opp_last_call == '3S'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 12
  CONDITION: club_len >= 6

RULE B_1D_3S_4D_895_0:
  CALL: 4D
  PRIORITY: 12
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1D'
  CONDITION: opp_last_call == '3S'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 10
  CONDITION: diamond_len >= 4
  CONDITION: hcp <= 14

RULE B_1D_3S_4H_896_0:
  CALL: 4H
  PRIORITY: 56
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1D'
  CONDITION: opp_last_call == '3S'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 10
  CONDITION: heart_len >= 6
  CONDITION: diamond_hcp >= 14

RULE B_1D_3S_4S_897_0:
  CALL: 4S
  PRIORITY: 52
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1D'
  CONDITION: opp_last_call == '3S'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 10
  CONDITION: diamond_len >= 4
  CONDITION: diamond_hcp >= 14

RULE B_1D_3S_5D_899_0:
  CALL: 5D
  PRIORITY: 27
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1D'
  CONDITION: opp_last_call == '3S'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 15
  CONDITION: diamond_len >= 4
  CONDITION: hcp <= 18

RULE B_1D_3S_6D_902_0:
  CALL: 6D
  PRIORITY: 35
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1D'
  CONDITION: opp_last_call == '3S'
  CONDITION: passes_since_last_bid == 0
  CONDITION: diamond_len >= 4
  CONDITION: d_realsolid == True
  CONDITION: losing_trick_count == 1

RULE B_1D_3S_6H_904_0:
  CALL: 6H
  PRIORITY: 66
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1D'
  CONDITION: opp_last_call == '3S'
  CONDITION: passes_since_last_bid == 0
  CONDITION: heart_len >= 8
  CONDITION: losing_trick_count <= 3

RULE B_1D_3S_7D_905_0:
  CALL: 7D
  PRIORITY: 36
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1D'
  CONDITION: opp_last_call == '3S'
  CONDITION: passes_since_last_bid == 0
  CONDITION: diamond_len >= 4
  CONDITION: d_realsolid == True
  CONDITION: losing_trick_count <= 0

RULE B_1D_3S_X_908_0:
  CALL: X
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1D'
  CONDITION: opp_last_call == '3S'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 12

RULE B_1D_3S_X_908_1:
  CALL: X
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1D'
  CONDITION: opp_last_call == '3S'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 10
  CONDITION: spade_len <= 2

RULE B_1D_4C_PASS_909_0:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1D'
  CONDITION: opp_last_call == '4C'
  CONDITION: passes_since_last_bid == 0

RULE B_1D_4C_X_918_0:
  CALL: X
  PRIORITY: 90
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1D'
  CONDITION: opp_last_call == '4C'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 13

RULE B_1D_4H_PASS_919_0:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1D'
  CONDITION: opp_last_call == '4H'
  CONDITION: passes_since_last_bid == 0

RULE B_1D_4H_5D_924_0:
  CALL: 5D
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1D'
  CONDITION: opp_last_call == '4H'
  CONDITION: passes_since_last_bid == 0
  CONDITION: diamond_len >= 5
  CONDITION: hcp >= 12

RULE B_1D_4H_6D_929_0:
  CALL: 6D
  PRIORITY: 35
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1D'
  CONDITION: opp_last_call == '4H'
  CONDITION: passes_since_last_bid == 0
  CONDITION: d_realsolid == True
  CONDITION: losing_trick_count == 1

RULE B_1D_4H_7D_931_0:
  CALL: 7D
  PRIORITY: 36
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1D'
  CONDITION: opp_last_call == '4H'
  CONDITION: passes_since_last_bid == 0
  CONDITION: d_realsolid == True
  CONDITION: losing_trick_count <= 0

RULE B_1D_4S_PASS_935_0:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1D'
  CONDITION: opp_last_call == '4S'
  CONDITION: passes_since_last_bid == 0

RULE B_1D_4S_5D_939_0:
  CALL: 5D
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1D'
  CONDITION: opp_last_call == '4S'
  CONDITION: passes_since_last_bid == 0
  CONDITION: diamond_len >= 5
  CONDITION: hcp >= 12

RULE B_1D_4S_6D_944_0:
  CALL: 6D
  PRIORITY: 35
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1D'
  CONDITION: opp_last_call == '4S'
  CONDITION: passes_since_last_bid == 0
  CONDITION: d_realsolid == True
  CONDITION: losing_trick_count == 1

RULE B_1D_4S_7D_946_0:
  CALL: 7D
  PRIORITY: 36
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1D'
  CONDITION: opp_last_call == '4S'
  CONDITION: passes_since_last_bid == 0
  CONDITION: d_realsolid == True
  CONDITION: losing_trick_count <= 0

RULE B_1D_5C_PASS_950_0:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1D'
  CONDITION: opp_last_call == '5C'
  CONDITION: passes_since_last_bid == 0

RULE B_1D_1N_PASS_956_0:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1D'
  CONDITION: opp_last_call == '1NT'
  CONDITION: passes_since_last_bid == 0

RULE B_1D_1N_2H_959_0:
  CALL: 2H
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1D'
  CONDITION: opp_last_call == '1NT'
  CONDITION: passes_since_last_bid == 0
  CONDITION: heart_len >= 6
  CONDITION: hcp <= 8
  CONDITION: losing_trick_count <= 9
  CONDITION: hcp >= 3

RULE B_1D_1N_2S_960_0:
  CALL: 2S
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1D'
  CONDITION: opp_last_call == '1NT'
  CONDITION: passes_since_last_bid == 0
  CONDITION: spade_len >= 6
  CONDITION: hcp <= 8
  CONDITION: losing_trick_count <= 9
  CONDITION: hcp >= 3

RULE B_1D_1N_X_964_0:
  CALL: X
  PRIORITY: 50
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1D'
  CONDITION: opp_last_call == '1NT'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 9

RULE B_1D_2N_PASS_965_0:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1D'
  CONDITION: opp_last_call == '2NT'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp <= 10

RULE B_1D_2N_3C_966_0:
  CALL: 3C
  PRIORITY: 15
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1D'
  CONDITION: opp_last_call == '2NT'
  CONDITION: passes_since_last_bid == 0
  CONDITION: diamond_len >= 4
  CONDITION: diamond_hcp >= 12

RULE B_1D_2N_3D_967_0:
  CALL: 3D
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1D'
  CONDITION: opp_last_call == '2NT'
  CONDITION: passes_since_last_bid == 0
  CONDITION: diamond_len >= 4
  CONDITION: diamond_hcp >= 7
  CONDITION: diamond_hcp <= 11

RULE B_1D_2N_3H_968_0:
  CALL: 3H
  PRIORITY: 30
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1D'
  CONDITION: opp_last_call == '2NT'
  CONDITION: passes_since_last_bid == 0
  CONDITION: spade_len >= 5
  CONDITION: hcp >= 10

RULE B_1D_2N_3S_969_0:
  CALL: 3S
  PRIORITY: 40
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1D'
  CONDITION: opp_last_call == '2NT'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 7
  CONDITION: spade_len >= 6
  CONDITION: hcp < 10

RULE B_1D_2N_3NT_970_0:
  CALL: 3NT
  PRIORITY: 50
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1D'
  CONDITION: opp_last_call == '2NT'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 13
  CONDITION: c_stopper >= 2
  CONDITION: h_stopper >= 2
  CONDITION: hcp <= 20

RULE B_1D_2N_6D_975_0:
  CALL: 6D
  PRIORITY: 65
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1D'
  CONDITION: opp_last_call == '2NT'
  CONDITION: passes_since_last_bid == 0
  CONDITION: d_realsolid == True
  CONDITION: losing_trick_count == 1

RULE B_1D_2N_7D_977_0:
  CALL: 7D
  PRIORITY: 66
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1D'
  CONDITION: opp_last_call == '2NT'
  CONDITION: passes_since_last_bid == 0
  CONDITION: d_realsolid == True
  CONDITION: losing_trick_count <= 0

RULE B_1D_2N_X_980_0:
  CALL: X
  PRIORITY: 5
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1D'
  CONDITION: opp_last_call == '2NT'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 11

RULE B_1H_P_PASS_981_0:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1H'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 1
  CONDITION: hcp <= 5

RULE B_1H_P_1S_982_0:
  CALL: 1S
  PRIORITY: 60
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1H'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 1
  CONDITION: total_points >= 6
  CONDITION: spade_len >= 4
  CONDITION: s_is_longest == True

RULE B_1H_P_1S_982_1:
  CALL: 1S
  PRIORITY: 60
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1H'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 1
  CONDITION: total_points >= 6
  CONDITION: spade_len >= 4
  CONDITION: hcp < 12

RULE B_1H_P_1NT_983_0:
  CALL: 1NT
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1H'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 1
  CONDITION: hcp <= 12
  CONDITION: heart_len < 4
  CONDITION: hcp >= 6

RULE B_1H_P_2H_986_0:
  CALL: 2H
  PRIORITY: 70
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1H'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 1
  CONDITION: total_points >= 6
  CONDITION: hcp < 10
  CONDITION: heart_len >= 3

RULE B_1H_P_2H_986_1:
  CALL: 2H
  PRIORITY: 70
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1H'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 1
  CONDITION: hcp >= 5
  CONDITION: hcp < 10
  CONDITION: heart_len >= 4

RULE B_1H_P_2S_987_2:
  CALL: 2S
  PRIORITY: 100
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1H'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 1
  CONDITION: spade_len >= 5
  CONDITION: heart_len >= 4
  CONDITION: hcp > 17
  CONDITION: controls >= 4

RULE B_1H_P_2S_987_3:
  CALL: 2S
  PRIORITY: 100
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1H'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 1
  CONDITION: spade_len >= 6
  CONDITION: is_semi_balanced == True
  CONDITION: hcp >= 17
  CONDITION: controls >= 4
  CONDITION: heart_len <= 2

RULE B_1H_P_2NT_988_0:
  CALL: 2NT
  PRIORITY: 120
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1H'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 1
  CONDITION: heart_hcp >= 12
  CONDITION: hcp >= 12
  CONDITION: heart_len >= 4

RULE B_1H_P_3C_989_0:
  CALL: 3C
  PRIORITY: 90
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1H'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 1
  CONDITION: hcp >= 10
  CONDITION: hcp < 12
  CONDITION: club_len >= 6
  CONDITION: spade_len <= 3
  CONDITION: heart_len <= 2

RULE B_1H_P_3D_990_0:
  CALL: 3D
  PRIORITY: 90
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1H'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 1
  CONDITION: hcp >= 10
  CONDITION: hcp < 12
  CONDITION: diamond_len >= 6
  CONDITION: spade_len <= 3
  CONDITION: heart_len <= 2

RULE B_1H_P_3H_991_0:
  CALL: 3H
  PRIORITY: 100
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1H'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 1
  CONDITION: hcp >= 9
  CONDITION: hcp < 12
  CONDITION: heart_len >= 4

RULE B_1H_P_3S_992_0:
  CALL: 3S
  PRIORITY: 125
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1H'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 1
  CONDITION: hcp >= 10
  CONDITION: hcp <= 14
  CONDITION: spade_len <= 1
  CONDITION: heart_len >= 4

RULE B_1H_P_4C_994_0:
  CALL: 4C
  PRIORITY: 125
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1H'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 1
  CONDITION: hcp >= 10
  CONDITION: hcp <= 14
  CONDITION: club_len <= 1
  CONDITION: heart_len >= 4

RULE B_1H_P_4D_995_0:
  CALL: 4D
  PRIORITY: 125
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1H'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 1
  CONDITION: hcp >= 10
  CONDITION: hcp <= 14
  CONDITION: diamond_len <= 1
  CONDITION: heart_len >= 4

RULE B_1H_P_4H_996_0:
  CALL: 4H
  PRIORITY: 72
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1H'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 1
  CONDITION: hcp <= 8
  CONDITION: heart_len >= 5

RULE B_1H_P_4S_997_0:
  CALL: 4S
  PRIORITY: 74
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1H'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 1
  CONDITION: hcp <= 10
  CONDITION: spade_len >= 7
  CONDITION: hcp >= 6

RULE B_1H_P_6H_1001_0:
  CALL: 6H
  PRIORITY: 5
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1H'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 1
  CONDITION: heart_len >= 3
  CONDITION: h_realsolid == True
  CONDITION: losing_trick_count == 1

RULE B_1H_P_7H_1003_0:
  CALL: 7H
  PRIORITY: 6
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1H'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 1
  CONDITION: heart_len >= 3
  CONDITION: h_realsolid == True
  CONDITION: losing_trick_count <= 0

RULE B_1H_X_PASS_1006_0:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1H'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 0

RULE B_1H_X_1S_1007_0:
  CALL: 1S
  PRIORITY: 35
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1H'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 0
  CONDITION: spade_len >= 4
  CONDITION: hcp <= 9
  CONDITION: hcp >= 6
  CONDITION: heart_len <= 2

RULE B_1H_X_1S_1007_1:
  CALL: 1S
  PRIORITY: 35
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1H'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 0
  CONDITION: spade_len >= 6
  CONDITION: hcp >= 6

RULE B_1H_X_1NT_1008_0:
  CALL: 1NT
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1H'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp < 10
  CONDITION: hcp >= 7

RULE B_1H_X_2C_1009_0:
  CALL: 2C
  PRIORITY: 28
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1H'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 0
  CONDITION: c_is_best_minor == True
  CONDITION: club_len >= 5
  CONDITION: total_points >= 9
  CONDITION: hcp <= 11
  CONDITION: hcp >= 7

RULE B_1H_X_2D_1010_0:
  CALL: 2D
  PRIORITY: 28
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1H'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 0
  CONDITION: d_is_best_minor == True
  CONDITION: diamond_len >= 5
  CONDITION: total_points >= 9
  CONDITION: hcp <= 11
  CONDITION: hcp >= 7

RULE B_1H_X_2H_1011_0:
  CALL: 2H
  PRIORITY: 45
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1H'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 0
  CONDITION: heart_hcp >= 4
  CONDITION: heart_len >= 5

RULE B_1H_X_2H_1011_1:
  CALL: 2H
  PRIORITY: 45
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1H'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 0
  CONDITION: total_points >= 6
  CONDITION: hcp < 10
  CONDITION: heart_len >= 3

RULE B_1H_X_2H_1011_2:
  CALL: 2H
  PRIORITY: 45
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1H'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 5
  CONDITION: hcp < 10
  CONDITION: heart_len >= 4

RULE B_1H_X_2NT_1013_0:
  CALL: 2NT
  PRIORITY: 120
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1H'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 0
  CONDITION: heart_hcp > 12
  CONDITION: heart_len >= 3

RULE B_1H_X_2NT_1013_1:
  CALL: 2NT
  PRIORITY: 120
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1H'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 10
  CONDITION: heart_len >= 3

RULE B_1H_X_3S_1017_0:
  CALL: 3S
  PRIORITY: 125
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1H'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 10
  CONDITION: hcp <= 14
  CONDITION: spade_len <= 1
  CONDITION: heart_len >= 4

RULE B_1H_X_3NT_1018_0:
  CALL: 3NT
  PRIORITY: 70
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1H'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 0
  CONDITION: heart_len == 2
  CONDITION: spade_len == 3
  CONDITION: s_stopper >= 2
  CONDITION: c_stopper >= 2
  CONDITION: d_stopper >= 2
  CONDITION: hcp >= 14
  CONDITION: hcp <= 17

RULE B_1H_X_4C_1019_0:
  CALL: 4C
  PRIORITY: 125
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1H'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 10
  CONDITION: hcp <= 14
  CONDITION: club_len <= 1
  CONDITION: heart_len >= 4

RULE B_1H_X_4D_1020_0:
  CALL: 4D
  PRIORITY: 125
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1H'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 10
  CONDITION: hcp <= 14
  CONDITION: diamond_len <= 1
  CONDITION: heart_len >= 4

RULE B_1H_X_4H_1021_0:
  CALL: 4H
  PRIORITY: 55
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1H'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 0
  CONDITION: heart_hcp >= 7
  CONDITION: hcp < 10
  CONDITION: heart_len >= 5

RULE B_1H_X_XX_1023_0:
  CALL: XX
  PRIORITY: 25
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1H'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 10
  CONDITION: spade_len <= 5

RULE B_1H_X_XX_1023_1:
  CALL: XX
  PRIORITY: 25
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1H'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 10

RULE B_1H_1S_PASS_1024_0:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1H'
  CONDITION: opp_last_call == '1S'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp <= 9

RULE B_1H_1S_PASS_1024_1:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1H'
  CONDITION: opp_last_call == '1S'
  CONDITION: passes_since_last_bid == 0
  CONDITION: spade_len >= 5

RULE B_1H_1S_1NT_1025_0:
  CALL: 1NT
  PRIORITY: 20
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1H'
  CONDITION: opp_last_call == '1S'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp < 10
  CONDITION: spade_len >= 4
  CONDITION: hcp >= 7

RULE B_1H_1S_1NT_1025_1:
  CALL: 1NT
  PRIORITY: 20
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1H'
  CONDITION: opp_last_call == '1S'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp < 10
  CONDITION: s_stopper >= 2
  CONDITION: hcp >= 7

RULE B_1H_1S_2C_1026_0:
  CALL: 2C
  PRIORITY: -1
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1H'
  CONDITION: opp_last_call == '1S'
  CONDITION: passes_since_last_bid == 0
  CONDITION: total_points >= 9
  CONDITION: club_len >= 6

RULE B_1H_1S_2C_1028_0:
  CALL: 2C
  PRIORITY: 39
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1H'
  CONDITION: opp_last_call == '1S'
  CONDITION: passes_since_last_bid == 0
  CONDITION: c_is_best_minor == True
  CONDITION: club_len >= 5
  CONDITION: hcp >= 12

RULE B_1H_1S_2D_1029_0:
  CALL: 2D
  PRIORITY: -1
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1H'
  CONDITION: opp_last_call == '1S'
  CONDITION: passes_since_last_bid == 0
  CONDITION: total_points >= 9
  CONDITION: diamond_len >= 6

RULE B_1H_1S_2D_1031_0:
  CALL: 2D
  PRIORITY: 39
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1H'
  CONDITION: opp_last_call == '1S'
  CONDITION: passes_since_last_bid == 0
  CONDITION: d_is_best_minor == True
  CONDITION: diamond_len >= 5
  CONDITION: hcp >= 12

RULE B_1H_1S_2H_1032_0:
  CALL: 2H
  PRIORITY: 40
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1H'
  CONDITION: opp_last_call == '1S'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 6
  CONDITION: hcp < 10
  CONDITION: heart_len >= 3

RULE B_1H_1S_2S_1033_0:
  CALL: 2S
  PRIORITY: 120
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1H'
  CONDITION: opp_last_call == '1S'
  CONDITION: passes_since_last_bid == 0
  CONDITION: heart_hcp >= 9
  CONDITION: hcp >= 9
  CONDITION: heart_len >= 4

RULE B_1H_1S_2S_1033_1:
  CALL: 2S
  PRIORITY: 120
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1H'
  CONDITION: opp_last_call == '1S'
  CONDITION: passes_since_last_bid == 0
  CONDITION: heart_hcp >= 10
  CONDITION: hcp >= 9
  CONDITION: heart_len >= 3

RULE B_1H_1S_2NT_1034_0:
  CALL: 2NT
  PRIORITY: 35
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1H'
  CONDITION: opp_last_call == '1S'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 10
  CONDITION: hcp <= 12
  CONDITION: s_stopper >= 2

RULE B_1H_1S_3H_1035_0:
  CALL: 3H
  PRIORITY: 100
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1H'
  CONDITION: opp_last_call == '1S'
  CONDITION: passes_since_last_bid == 0
  CONDITION: heart_hcp >= 6
  CONDITION: hcp <= 8
  CONDITION: heart_len >= 4

RULE B_1H_1S_3S_1036_0:
  CALL: 3S
  PRIORITY: 125
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1H'
  CONDITION: opp_last_call == '1S'
  CONDITION: passes_since_last_bid == 0
  CONDITION: heart_hcp >= 13
  CONDITION: hcp >= 11
  CONDITION: heart_len >= 4
  CONDITION: spade_len <= 1

RULE B_1H_1S_3NT_1037_0:
  CALL: 3NT
  PRIORITY: 85
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1H'
  CONDITION: opp_last_call == '1S'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 13
  CONDITION: hcp <= 17
  CONDITION: s_stopper >= 2

RULE B_1H_1S_4H_1038_0:
  CALL: 4H
  PRIORITY: 110
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1H'
  CONDITION: opp_last_call == '1S'
  CONDITION: passes_since_last_bid == 0
  CONDITION: heart_hcp >= 5
  CONDITION: hcp <= 8
  CONDITION: heart_len >= 5

RULE B_1H_1S_X_1039_0:
  CALL: X
  PRIORITY: 38
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1H'
  CONDITION: opp_last_call == '1S'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp > 5
  CONDITION: club_len >= 4
  CONDITION: diamond_len >= 4

RULE B_1H_2C_PASS_1040_0:
  CALL: PASS
  PRIORITY: 20
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1H'
  CONDITION: opp_last_call == '2C'
  CONDITION: passes_since_last_bid == 0

RULE B_1H_2C_PASS_1040_1:
  CALL: PASS
  PRIORITY: 20
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1H'
  CONDITION: opp_last_call == '2C'
  CONDITION: passes_since_last_bid == 0
  CONDITION: club_len >= 4
  CONDITION: hcp >= 10

RULE B_1H_2C_PASS_1040_2:
  CALL: PASS
  PRIORITY: 20
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1H'
  CONDITION: opp_last_call == '2C'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp <= 8

RULE B_1H_2C_PASS_1040_3:
  CALL: PASS
  PRIORITY: 20
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1H'
  CONDITION: opp_last_call == '2C'
  CONDITION: passes_since_last_bid == 0
  CONDITION: club_len >= 5

RULE B_1H_2C_2D_1041_0:
  CALL: 2D
  PRIORITY: 30
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1H'
  CONDITION: opp_last_call == '2C'
  CONDITION: passes_since_last_bid == 0
  CONDITION: diamond_len >= 4
  CONDITION: total_points >= 10
  CONDITION: hcp >= 8

RULE B_1H_2C_2D_1041_1:
  CALL: 2D
  PRIORITY: 30
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1H'
  CONDITION: opp_last_call == '2C'
  CONDITION: passes_since_last_bid == 0
  CONDITION: diamond_len >= 5
  CONDITION: total_points >= 10
  CONDITION: hcp >= 8

RULE B_1H_2C_2D_1041_2:
  CALL: 2D
  PRIORITY: 30
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1H'
  CONDITION: opp_last_call == '2C'
  CONDITION: passes_since_last_bid == 0
  CONDITION: diamond_len >= 5
  CONDITION: hcp >= 9

RULE B_1H_2C_2H_1042_0:
  CALL: 2H
  PRIORITY: 80
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1H'
  CONDITION: opp_last_call == '2C'
  CONDITION: passes_since_last_bid == 0
  CONDITION: heart_len >= 3
  CONDITION: hcp <= 9
  CONDITION: heart_hcp >= 6

RULE B_1H_2C_2S_1043_0:
  CALL: 2S
  PRIORITY: 60
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1H'
  CONDITION: opp_last_call == '2C'
  CONDITION: passes_since_last_bid == 0
  CONDITION: spade_len >= 5
  CONDITION: hcp >= 9

RULE B_1H_2C_2S_1043_1:
  CALL: 2S
  PRIORITY: 60
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1H'
  CONDITION: opp_last_call == '2C'
  CONDITION: passes_since_last_bid == 0
  CONDITION: spade_len >= 5
  CONDITION: total_points >= 10
  CONDITION: hcp >= 8

RULE B_1H_2C_2NT_1044_0:
  CALL: 2NT
  PRIORITY: 32
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1H'
  CONDITION: opp_last_call == '2C'
  CONDITION: passes_since_last_bid == 0
  CONDITION: c_stopper >= 2
  CONDITION: hcp >= 9
  CONDITION: hcp <= 11

RULE B_1H_2C_3C_1045_0:
  CALL: 3C
  PRIORITY: 70
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1H'
  CONDITION: opp_last_call == '2C'
  CONDITION: passes_since_last_bid == 0
  CONDITION: heart_len >= 3
  CONDITION: hcp >= 10

RULE B_1H_2C_3D_1046_0:
  CALL: 3D
  PRIORITY: 20
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1H'
  CONDITION: opp_last_call == '2C'
  CONDITION: passes_since_last_bid == 0
  CONDITION: diamond_len >= 6
  CONDITION: hcp >= 15

RULE B_1H_2C_3H_1047_0:
  CALL: 3H
  PRIORITY: 54
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1H'
  CONDITION: opp_last_call == '2C'
  CONDITION: passes_since_last_bid == 0
  CONDITION: heart_len >= 4
  CONDITION: hcp <= 7
  CONDITION: heart_hcp >= 5

RULE B_1H_2C_4C_1049_0:
  CALL: 4C
  PRIORITY: 125
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1H'
  CONDITION: opp_last_call == '2C'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 10
  CONDITION: hcp <= 14
  CONDITION: club_len <= 1
  CONDITION: heart_len >= 4

RULE B_1H_2C_4H_1050_0:
  CALL: 4H
  PRIORITY: 82
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1H'
  CONDITION: opp_last_call == '2C'
  CONDITION: passes_since_last_bid == 0
  CONDITION: heart_len >= 5
  CONDITION: hcp <= 9
  CONDITION: heart_hcp >= 4

RULE B_1H_2C_6H_1054_0:
  CALL: 6H
  PRIORITY: 95
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1H'
  CONDITION: opp_last_call == '2C'
  CONDITION: passes_since_last_bid == 0
  CONDITION: heart_len >= 3
  CONDITION: h_realsolid == True
  CONDITION: losing_trick_count == 1

RULE B_1H_2C_7H_1056_0:
  CALL: 7H
  PRIORITY: 96
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1H'
  CONDITION: opp_last_call == '2C'
  CONDITION: passes_since_last_bid == 0
  CONDITION: heart_len >= 3
  CONDITION: h_realsolid == True
  CONDITION: losing_trick_count <= 0

RULE B_1H_2C_X_1059_0:
  CALL: X
  PRIORITY: 46
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1H'
  CONDITION: opp_last_call == '2C'
  CONDITION: passes_since_last_bid == 0
  CONDITION: spade_len >= 4
  CONDITION: hcp >= 8

RULE B_1H_2C_X_1059_1:
  CALL: X
  PRIORITY: 46
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1H'
  CONDITION: opp_last_call == '2C'
  CONDITION: passes_since_last_bid == 0
  CONDITION: spade_len >= 5
  CONDITION: hcp >= 7

RULE B_1H_2C_X_1059_2:
  CALL: X
  PRIORITY: 46
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1H'
  CONDITION: opp_last_call == '2C'
  CONDITION: passes_since_last_bid == 0
  CONDITION: spade_len >= 6
  CONDITION: hcp >= 6

RULE B_1H_2D_PASS_1060_0:
  CALL: PASS
  PRIORITY: 20
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1H'
  CONDITION: opp_last_call == '2D'
  CONDITION: passes_since_last_bid == 0

RULE B_1H_2D_PASS_1060_1:
  CALL: PASS
  PRIORITY: 20
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1H'
  CONDITION: opp_last_call == '2D'
  CONDITION: passes_since_last_bid == 0
  CONDITION: diamond_len >= 4
  CONDITION: hcp >= 10

RULE B_1H_2D_PASS_1060_2:
  CALL: PASS
  PRIORITY: 20
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1H'
  CONDITION: opp_last_call == '2D'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp <= 8

RULE B_1H_2D_PASS_1060_3:
  CALL: PASS
  PRIORITY: 20
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1H'
  CONDITION: opp_last_call == '2D'
  CONDITION: passes_since_last_bid == 0
  CONDITION: diamond_len >= 5

RULE B_1H_2D_2H_1061_0:
  CALL: 2H
  PRIORITY: 80
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1H'
  CONDITION: opp_last_call == '2D'
  CONDITION: passes_since_last_bid == 0
  CONDITION: heart_len >= 3
  CONDITION: hcp <= 9
  CONDITION: heart_hcp >= 6

RULE B_1H_2D_2S_1062_0:
  CALL: 2S
  PRIORITY: 60
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1H'
  CONDITION: opp_last_call == '2D'
  CONDITION: passes_since_last_bid == 0
  CONDITION: spade_len >= 5
  CONDITION: total_points >= 10
  CONDITION: hcp >= 8

RULE B_1H_2D_2NT_1063_0:
  CALL: 2NT
  PRIORITY: 32
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1H'
  CONDITION: opp_last_call == '2D'
  CONDITION: passes_since_last_bid == 0
  CONDITION: d_stopper >= 2
  CONDITION: hcp >= 9
  CONDITION: hcp <= 11

RULE B_1H_2D_3C_1064_0:
  CALL: 3C
  PRIORITY: 20
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1H'
  CONDITION: opp_last_call == '2D'
  CONDITION: passes_since_last_bid == 0
  CONDITION: club_len >= 5
  CONDITION: hcp >= 10

RULE B_1H_2D_3D_1065_0:
  CALL: 3D
  PRIORITY: 70
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1H'
  CONDITION: opp_last_call == '2D'
  CONDITION: passes_since_last_bid == 0
  CONDITION: heart_len >= 3
  CONDITION: hcp >= 10

RULE B_1H_2D_3H_1066_0:
  CALL: 3H
  PRIORITY: 54
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1H'
  CONDITION: opp_last_call == '2D'
  CONDITION: passes_since_last_bid == 0
  CONDITION: heart_len >= 4
  CONDITION: hcp <= 7
  CONDITION: heart_hcp >= 5

RULE B_1H_2D_4D_1068_0:
  CALL: 4D
  PRIORITY: 125
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1H'
  CONDITION: opp_last_call == '2D'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 10
  CONDITION: hcp <= 14
  CONDITION: diamond_len <= 1
  CONDITION: heart_len >= 4

RULE B_1H_2D_4H_1069_0:
  CALL: 4H
  PRIORITY: 82
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1H'
  CONDITION: opp_last_call == '2D'
  CONDITION: passes_since_last_bid == 0
  CONDITION: heart_len >= 5
  CONDITION: hcp <= 9
  CONDITION: heart_hcp >= 4

RULE B_1H_2D_6H_1073_0:
  CALL: 6H
  PRIORITY: 95
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1H'
  CONDITION: opp_last_call == '2D'
  CONDITION: passes_since_last_bid == 0
  CONDITION: heart_len >= 3
  CONDITION: h_realsolid == True
  CONDITION: losing_trick_count == 1

RULE B_1H_2D_7H_1075_0:
  CALL: 7H
  PRIORITY: 96
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1H'
  CONDITION: opp_last_call == '2D'
  CONDITION: passes_since_last_bid == 0
  CONDITION: heart_len >= 3
  CONDITION: h_realsolid == True
  CONDITION: losing_trick_count <= 0

RULE B_1H_2D_X_1078_0:
  CALL: X
  PRIORITY: 46
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1H'
  CONDITION: opp_last_call == '2D'
  CONDITION: passes_since_last_bid == 0
  CONDITION: spade_len >= 4
  CONDITION: hcp >= 8

RULE B_1H_2D_X_1078_1:
  CALL: X
  PRIORITY: 46
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1H'
  CONDITION: opp_last_call == '2D'
  CONDITION: passes_since_last_bid == 0
  CONDITION: spade_len >= 5
  CONDITION: hcp >= 7

RULE B_1H_2D_X_1078_2:
  CALL: X
  PRIORITY: 46
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1H'
  CONDITION: opp_last_call == '2D'
  CONDITION: passes_since_last_bid == 0
  CONDITION: spade_len >= 6
  CONDITION: hcp >= 6

RULE B_1H_2H_PASS_1079_0:
  CALL: PASS
  PRIORITY: -1
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1H'
  CONDITION: opp_last_call == '2H'
  CONDITION: passes_since_last_bid == 0
  CONDITION: spade_len >= 4

RULE B_1H_2H_PASS_1080_0:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1H'
  CONDITION: opp_last_call == '2H'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp <= 11
  CONDITION: heart_len <= 3

RULE B_1H_2H_PASS_1080_1:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1H'
  CONDITION: opp_last_call == '2H'
  CONDITION: passes_since_last_bid == 0
  CONDITION: total_points <= 7

RULE B_1H_2H_2S_1081_0:
  CALL: 2S
  PRIORITY: 60
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1H'
  CONDITION: opp_last_call == '2H'
  CONDITION: passes_since_last_bid == 0
  CONDITION: heart_len >= 4
  CONDITION: heart_hcp >= 14

RULE B_1H_2H_2S_1081_1:
  CALL: 2S
  PRIORITY: 60
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1H'
  CONDITION: opp_last_call == '2H'
  CONDITION: passes_since_last_bid == 0
  CONDITION: heart_len >= 3
  CONDITION: hcp >= 10

RULE B_1H_2H_3C_1082_0:
  CALL: 3C
  PRIORITY: 30
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1H'
  CONDITION: opp_last_call == '2H'
  CONDITION: passes_since_last_bid == 0
  CONDITION: club_len >= 5
  CONDITION: hcp <= 10
  CONDITION: hcp >= 7

RULE B_1H_2H_3D_1083_0:
  CALL: 3D
  PRIORITY: 30
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1H'
  CONDITION: opp_last_call == '2H'
  CONDITION: passes_since_last_bid == 0
  CONDITION: diamond_len >= 5
  CONDITION: hcp <= 10
  CONDITION: hcp >= 7

RULE B_1H_2H_3H_1084_0:
  CALL: 3H
  PRIORITY: 35
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1H'
  CONDITION: opp_last_call == '2H'
  CONDITION: passes_since_last_bid == 0
  CONDITION: heart_len >= 3
  CONDITION: total_points <= 10
  CONDITION: total_points >= 8

RULE B_1H_2H_3S_1085_0:
  CALL: 3S
  PRIORITY: 38
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1H'
  CONDITION: opp_last_call == '2H'
  CONDITION: passes_since_last_bid == 0
  CONDITION: heart_len >= 3
  CONDITION: total_points >= 10
  CONDITION: hcp >= 9

RULE B_1H_2H_3NT_1086_0:
  CALL: 3NT
  PRIORITY: 20
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1H'
  CONDITION: opp_last_call == '2H'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 12
  CONDITION: s_stopper >= 2

RULE B_1H_2H_4H_1087_0:
  CALL: 4H
  PRIORITY: 50
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1H'
  CONDITION: opp_last_call == '2H'
  CONDITION: passes_since_last_bid == 0
  CONDITION: heart_len >= 3
  CONDITION: total_points >= 10
  CONDITION: heart_hcp <= 14

RULE B_1H_2H_4H_1087_1:
  CALL: 4H
  PRIORITY: 50
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1H'
  CONDITION: opp_last_call == '2H'
  CONDITION: passes_since_last_bid == 0
  CONDITION: heart_len >= 5
  CONDITION: total_points >= 4
  CONDITION: heart_hcp <= 14

RULE B_1H_2H_4H_1087_2:
  CALL: 4H
  PRIORITY: 50
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1H'
  CONDITION: opp_last_call == '2H'
  CONDITION: passes_since_last_bid == 0
  CONDITION: heart_len >= 4
  CONDITION: total_points >= 10
  CONDITION: heart_hcp <= 14

RULE B_1H_2H_5C_1088_0:
  CALL: 5C
  PRIORITY: 55
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1H'
  CONDITION: opp_last_call == '2H'
  CONDITION: passes_since_last_bid == 0
  CONDITION: club_len >= 8
  CONDITION: losing_trick_count <= 5

RULE B_1H_2H_5D_1089_0:
  CALL: 5D
  PRIORITY: 55
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1H'
  CONDITION: opp_last_call == '2H'
  CONDITION: passes_since_last_bid == 0
  CONDITION: diamond_len >= 8
  CONDITION: losing_trick_count <= 5

RULE B_1H_2H_X_1090_0:
  CALL: X
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1H'
  CONDITION: opp_last_call == '2H'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 12

RULE B_1H_2S_PASS_1091_0:
  CALL: PASS
  PRIORITY: 20
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1H'
  CONDITION: opp_last_call == '2S'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp <= 11

RULE B_1H_2S_PASS_1091_1:
  CALL: PASS
  PRIORITY: 20
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1H'
  CONDITION: opp_last_call == '2S'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp <= 9

RULE B_1H_2S_PASS_1091_2:
  CALL: PASS
  PRIORITY: 20
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1H'
  CONDITION: opp_last_call == '2S'
  CONDITION: passes_since_last_bid == 0
  CONDITION: spade_len >= 5
  CONDITION: hcp >= 8

RULE B_1H_2S_2NT_1092_0:
  CALL: 2NT
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1H'
  CONDITION: opp_last_call == '2S'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 10
  CONDITION: hcp <= 12
  CONDITION: s_stopper >= 2

RULE B_1H_2S_3C_1093_0:
  CALL: 3C
  PRIORITY: 39
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1H'
  CONDITION: opp_last_call == '2S'
  CONDITION: passes_since_last_bid == 0
  CONDITION: c_is_best_minor == True
  CONDITION: club_len >= 5
  CONDITION: hcp >= 11

RULE B_1H_2S_3C_1093_1:
  CALL: 3C
  PRIORITY: 39
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1H'
  CONDITION: opp_last_call == '2S'
  CONDITION: passes_since_last_bid == 0
  CONDITION: c_is_best_minor == True
  CONDITION: club_len >= 6
  CONDITION: hcp >= 12

RULE B_1H_2S_3D_1094_0:
  CALL: 3D
  PRIORITY: 40
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1H'
  CONDITION: opp_last_call == '2S'
  CONDITION: passes_since_last_bid == 0
  CONDITION: d_is_best_minor == True
  CONDITION: diamond_len >= 5
  CONDITION: hcp >= 11

RULE B_1H_2S_3D_1094_1:
  CALL: 3D
  PRIORITY: 40
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1H'
  CONDITION: opp_last_call == '2S'
  CONDITION: passes_since_last_bid == 0
  CONDITION: d_is_best_minor == True
  CONDITION: diamond_len >= 6
  CONDITION: hcp >= 12

RULE B_1H_2S_3H_1096_0:
  CALL: 3H
  PRIORITY: 24
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1H'
  CONDITION: opp_last_call == '2S'
  CONDITION: passes_since_last_bid == 0
  CONDITION: heart_len >= 3
  CONDITION: heart_hcp >= 7
  CONDITION: hcp <= 10

RULE B_1H_2S_3NT_1098_0:
  CALL: 3NT
  PRIORITY: 22
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1H'
  CONDITION: opp_last_call == '2S'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 12
  CONDITION: s_stopper >= 2

RULE B_1H_2S_X_1100_0:
  CALL: X
  PRIORITY: 38
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1H'
  CONDITION: opp_last_call == '2S'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 12
  CONDITION: club_len >= 3
  CONDITION: diamond_len >= 3

RULE B_1H_2S_X_1100_1:
  CALL: X
  PRIORITY: 38
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1H'
  CONDITION: opp_last_call == '2S'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 9
  CONDITION: club_len >= 4
  CONDITION: diamond_len >= 4

RULE B_1H_3C_PASS_1101_0:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1H'
  CONDITION: opp_last_call == '3C'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp <= 11

RULE B_1H_3C_3D_1102_0:
  CALL: 3D
  PRIORITY: 20
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1H'
  CONDITION: opp_last_call == '3C'
  CONDITION: passes_since_last_bid == 0
  CONDITION: total_points >= 12
  CONDITION: diamond_len >= 5

RULE B_1H_3C_3H_1103_0:
  CALL: 3H
  PRIORITY: 41
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1H'
  CONDITION: opp_last_call == '3C'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 7
  CONDITION: hcp <= 10
  CONDITION: heart_len >= 3

RULE B_1H_3C_3S_1104_0:
  CALL: 3S
  PRIORITY: 35
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1H'
  CONDITION: opp_last_call == '3C'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 12
  CONDITION: spade_len >= 5

RULE B_1H_3C_3NT_1105_0:
  CALL: 3NT
  PRIORITY: 20
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1H'
  CONDITION: opp_last_call == '3C'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 12
  CONDITION: c_stopper >= 2
  CONDITION: hcp <= 18

RULE B_1H_3C_4C_1106_0:
  CALL: 4C
  PRIORITY: 56
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1H'
  CONDITION: opp_last_call == '3C'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 13
  CONDITION: heart_len >= 2

RULE B_1H_3C_4C_1106_1:
  CALL: 4C
  PRIORITY: 56
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1H'
  CONDITION: opp_last_call == '3C'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 13
  CONDITION: heart_len >= 3

RULE B_1H_3C_4H_1107_0:
  CALL: 4H
  PRIORITY: 43
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1H'
  CONDITION: opp_last_call == '3C'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 11
  CONDITION: hcp <= 12
  CONDITION: heart_len >= 2

RULE B_1H_3C_4H_1107_1:
  CALL: 4H
  PRIORITY: 43
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1H'
  CONDITION: opp_last_call == '3C'
  CONDITION: passes_since_last_bid == 0
  CONDITION: heart_len >= 4
  CONDITION: heart_hcp >= 10
  CONDITION: hcp < 10

RULE B_1H_3C_4H_1107_2:
  CALL: 4H
  PRIORITY: 43
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1H'
  CONDITION: opp_last_call == '3C'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 11
  CONDITION: hcp <= 12
  CONDITION: heart_len >= 3

RULE B_1H_3C_4H_1107_3:
  CALL: 4H
  PRIORITY: 43
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1H'
  CONDITION: opp_last_call == '3C'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 9
  CONDITION: hcp <= 12
  CONDITION: heart_len >= 4

RULE B_1H_3C_4S_1108_0:
  CALL: 4S
  PRIORITY: 15
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1H'
  CONDITION: opp_last_call == '3C'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 10
  CONDITION: spade_len >= 7

RULE B_1H_3C_6H_1112_0:
  CALL: 6H
  PRIORITY: 65
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1H'
  CONDITION: opp_last_call == '3C'
  CONDITION: passes_since_last_bid == 0
  CONDITION: h_realsolid == True
  CONDITION: losing_trick_count == 1

RULE B_1H_3C_7H_1114_0:
  CALL: 7H
  PRIORITY: 66
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1H'
  CONDITION: opp_last_call == '3C'
  CONDITION: passes_since_last_bid == 0
  CONDITION: h_realsolid == True
  CONDITION: losing_trick_count <= 0

RULE B_1H_3C_X_1117_0:
  CALL: X
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1H'
  CONDITION: opp_last_call == '3C'
  CONDITION: passes_since_last_bid == 0
  CONDITION: spade_len >= 4
  CONDITION: hcp >= 10

RULE B_1H_3D_PASS_1118_0:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1H'
  CONDITION: opp_last_call == '3D'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp <= 11

RULE B_1H_3D_3H_1119_0:
  CALL: 3H
  PRIORITY: 41
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1H'
  CONDITION: opp_last_call == '3D'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 7
  CONDITION: hcp <= 10
  CONDITION: heart_len >= 3

RULE B_1H_3D_3S_1120_0:
  CALL: 3S
  PRIORITY: 35
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1H'
  CONDITION: opp_last_call == '3D'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 12
  CONDITION: spade_len >= 5

RULE B_1H_3D_3NT_1121_0:
  CALL: 3NT
  PRIORITY: 20
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1H'
  CONDITION: opp_last_call == '3D'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 12
  CONDITION: d_stopper >= 2
  CONDITION: hcp <= 18

RULE B_1H_3D_4C_1122_0:
  CALL: 4C
  PRIORITY: 5
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1H'
  CONDITION: opp_last_call == '3D'
  CONDITION: passes_since_last_bid == 0
  CONDITION: club_len >= 6
  CONDITION: hcp >= 10

RULE B_1H_3D_4D_1123_0:
  CALL: 4D
  PRIORITY: 56
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1H'
  CONDITION: opp_last_call == '3D'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 13
  CONDITION: heart_len >= 2

RULE B_1H_3D_4D_1123_1:
  CALL: 4D
  PRIORITY: 56
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1H'
  CONDITION: opp_last_call == '3D'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 13
  CONDITION: heart_len >= 3

RULE B_1H_3D_4H_1124_0:
  CALL: 4H
  PRIORITY: 43
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1H'
  CONDITION: opp_last_call == '3D'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 11
  CONDITION: hcp <= 12
  CONDITION: heart_len >= 2

RULE B_1H_3D_4H_1124_1:
  CALL: 4H
  PRIORITY: 43
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1H'
  CONDITION: opp_last_call == '3D'
  CONDITION: passes_since_last_bid == 0
  CONDITION: heart_len >= 4
  CONDITION: heart_hcp >= 10
  CONDITION: hcp < 10

RULE B_1H_3D_4H_1124_2:
  CALL: 4H
  PRIORITY: 43
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1H'
  CONDITION: opp_last_call == '3D'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 11
  CONDITION: hcp <= 12
  CONDITION: heart_len >= 3

RULE B_1H_3D_4H_1124_3:
  CALL: 4H
  PRIORITY: 43
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1H'
  CONDITION: opp_last_call == '3D'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 9
  CONDITION: hcp <= 12
  CONDITION: heart_len >= 4

RULE B_1H_3D_4S_1125_0:
  CALL: 4S
  PRIORITY: 15
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1H'
  CONDITION: opp_last_call == '3D'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 10
  CONDITION: spade_len >= 7

RULE B_1H_3D_6H_1129_0:
  CALL: 6H
  PRIORITY: 65
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1H'
  CONDITION: opp_last_call == '3D'
  CONDITION: passes_since_last_bid == 0
  CONDITION: h_realsolid == True
  CONDITION: losing_trick_count == 1

RULE B_1H_3D_7H_1131_0:
  CALL: 7H
  PRIORITY: 66
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1H'
  CONDITION: opp_last_call == '3D'
  CONDITION: passes_since_last_bid == 0
  CONDITION: h_realsolid == True
  CONDITION: losing_trick_count <= 0

RULE B_1H_3D_X_1134_0:
  CALL: X
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1H'
  CONDITION: opp_last_call == '3D'
  CONDITION: passes_since_last_bid == 0
  CONDITION: spade_len >= 4
  CONDITION: hcp >= 10

RULE B_1H_3S_PASS_1135_0:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1H'
  CONDITION: opp_last_call == '3S'
  CONDITION: passes_since_last_bid == 0

RULE B_1H_3S_4C_1137_0:
  CALL: 4C
  PRIORITY: 40
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1H'
  CONDITION: opp_last_call == '3S'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 10
  CONDITION: c_is_best_minor == True
  CONDITION: club_len >= 6

RULE B_1H_3S_4C_1137_1:
  CALL: 4C
  PRIORITY: 40
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1H'
  CONDITION: opp_last_call == '3S'
  CONDITION: passes_since_last_bid == 0
  CONDITION: club_len >= 6
  CONDITION: hcp >= 12

RULE B_1H_3S_4D_1138_0:
  CALL: 4D
  PRIORITY: 40
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1H'
  CONDITION: opp_last_call == '3S'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 10
  CONDITION: d_is_best_minor == True
  CONDITION: diamond_len >= 6

RULE B_1H_3S_4D_1138_1:
  CALL: 4D
  PRIORITY: 40
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1H'
  CONDITION: opp_last_call == '3S'
  CONDITION: passes_since_last_bid == 0
  CONDITION: diamond_len >= 6
  CONDITION: hcp >= 12

RULE B_1H_3S_4H_1139_2:
  CALL: 4H
  PRIORITY: 50
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1H'
  CONDITION: opp_last_call == '3S'
  CONDITION: passes_since_last_bid == 0
  CONDITION: heart_len >= 3
  CONDITION: heart_hcp >= 10

RULE B_1H_3S_5C_1142_0:
  CALL: 5C
  PRIORITY: 30
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1H'
  CONDITION: opp_last_call == '3S'
  CONDITION: passes_since_last_bid == 0
  CONDITION: club_len >= 7
  CONDITION: hcp <= 12
  CONDITION: hcp >= 6
  CONDITION: heart_len <= 2

RULE B_1H_3S_5D_1143_0:
  CALL: 5D
  PRIORITY: 30
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1H'
  CONDITION: opp_last_call == '3S'
  CONDITION: passes_since_last_bid == 0
  CONDITION: diamond_len >= 7
  CONDITION: hcp <= 12
  CONDITION: hcp >= 6
  CONDITION: heart_len <= 2

RULE B_1H_3S_6H_1146_0:
  CALL: 6H
  PRIORITY: 65
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1H'
  CONDITION: opp_last_call == '3S'
  CONDITION: passes_since_last_bid == 0
  CONDITION: heart_len >= 3
  CONDITION: h_realsolid == True
  CONDITION: losing_trick_count == 1

RULE B_1H_3S_7H_1148_0:
  CALL: 7H
  PRIORITY: 66
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1H'
  CONDITION: opp_last_call == '3S'
  CONDITION: passes_since_last_bid == 0
  CONDITION: heart_len >= 3
  CONDITION: h_realsolid == True
  CONDITION: losing_trick_count <= 0

RULE B_1H_3S_X_1151_0:
  CALL: X
  PRIORITY: 5
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1H'
  CONDITION: opp_last_call == '3S'
  CONDITION: passes_since_last_bid == 0
  CONDITION: heart_len >= 2
  CONDITION: hcp >= 10

RULE B_1H_3S_X_1152_0:
  CALL: X
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1H'
  CONDITION: opp_last_call == '3S'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 13
  CONDITION: club_len >= 3
  CONDITION: diamond_len >= 3

RULE B_1H_3S_X_1152_1:
  CALL: X
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1H'
  CONDITION: opp_last_call == '3S'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 10
  CONDITION: club_len >= 4
  CONDITION: diamond_len >= 4

RULE B_1H_4C_PASS_1153_0:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1H'
  CONDITION: opp_last_call == '4C'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp <= 11

RULE B_1H_4C_4H_1154_0:
  CALL: 4H
  PRIORITY: 25
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1H'
  CONDITION: opp_last_call == '4C'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 11
  CONDITION: hcp <= 12
  CONDITION: heart_len >= 2

RULE B_1H_4C_4H_1154_1:
  CALL: 4H
  PRIORITY: 25
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1H'
  CONDITION: opp_last_call == '4C'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 9
  CONDITION: hcp <= 16
  CONDITION: heart_len >= 3

RULE B_1H_4C_4S_1155_0:
  CALL: 4S
  PRIORITY: 30
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1H'
  CONDITION: opp_last_call == '4C'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 12
  CONDITION: spade_len >= 6

RULE B_1H_4C_6H_1160_0:
  CALL: 6H
  PRIORITY: 65
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1H'
  CONDITION: opp_last_call == '4C'
  CONDITION: passes_since_last_bid == 0
  CONDITION: h_realsolid == True
  CONDITION: losing_trick_count == 1

RULE B_1H_4C_7H_1162_0:
  CALL: 7H
  PRIORITY: 66
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1H'
  CONDITION: opp_last_call == '4C'
  CONDITION: passes_since_last_bid == 0
  CONDITION: h_realsolid == True
  CONDITION: losing_trick_count <= 0

RULE B_1H_4C_X_1165_0:
  CALL: X
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1H'
  CONDITION: opp_last_call == '4C'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 10

RULE B_1H_4D_PASS_1166_0:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1H'
  CONDITION: opp_last_call == '4D'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp <= 11

RULE B_1H_4D_4H_1167_0:
  CALL: 4H
  PRIORITY: 25
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1H'
  CONDITION: opp_last_call == '4D'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 11
  CONDITION: hcp <= 12
  CONDITION: heart_len >= 2

RULE B_1H_4D_4H_1167_1:
  CALL: 4H
  PRIORITY: 25
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1H'
  CONDITION: opp_last_call == '4D'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 9
  CONDITION: hcp <= 16
  CONDITION: heart_len >= 3

RULE B_1H_4D_4S_1168_0:
  CALL: 4S
  PRIORITY: 30
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1H'
  CONDITION: opp_last_call == '4D'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 12
  CONDITION: spade_len >= 6

RULE B_1H_4D_6H_1173_0:
  CALL: 6H
  PRIORITY: 65
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1H'
  CONDITION: opp_last_call == '4D'
  CONDITION: passes_since_last_bid == 0
  CONDITION: h_realsolid == True
  CONDITION: losing_trick_count == 1

RULE B_1H_4D_7H_1175_0:
  CALL: 7H
  PRIORITY: 66
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1H'
  CONDITION: opp_last_call == '4D'
  CONDITION: passes_since_last_bid == 0
  CONDITION: h_realsolid == True
  CONDITION: losing_trick_count <= 0

RULE B_1H_4D_X_1178_0:
  CALL: X
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1H'
  CONDITION: opp_last_call == '4D'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 10

RULE B_1H_4S_6H_1186_0:
  CALL: 6H
  PRIORITY: 65
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1H'
  CONDITION: opp_last_call == '4S'
  CONDITION: passes_since_last_bid == 0
  CONDITION: h_realsolid == True
  CONDITION: losing_trick_count == 1

RULE B_1H_4S_7H_1188_0:
  CALL: 7H
  PRIORITY: 66
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1H'
  CONDITION: opp_last_call == '4S'
  CONDITION: passes_since_last_bid == 0
  CONDITION: h_realsolid == True
  CONDITION: losing_trick_count <= 0

RULE B_1H_5C_PASS_1192_0:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1H'
  CONDITION: opp_last_call == '5C'
  CONDITION: passes_since_last_bid == 0

RULE B_1H_5D_PASS_1196_1:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1H'
  CONDITION: opp_last_call == '5D'
  CONDITION: passes_since_last_bid == 0

RULE B_1H_5D_5H_1197_0:
  CALL: 5H
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1H'
  CONDITION: opp_last_call == '5D'
  CONDITION: passes_since_last_bid == 0
  CONDITION: heart_len >= 3
  CONDITION: hcp >= 12

RULE B_1H_5D_X_1200_0:
  CALL: X
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1H'
  CONDITION: opp_last_call == '5D'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 13

RULE B_1H_6C_PASS_1201_0:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1H'
  CONDITION: opp_last_call == '6C'
  CONDITION: passes_since_last_bid == 0

RULE B_1H_6S_PASS_1202_0:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1H'
  CONDITION: opp_last_call == '6S'
  CONDITION: passes_since_last_bid == 0

RULE B_1H_1N_PASS_1203_0:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1H'
  CONDITION: opp_last_call == '1NT'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp <= 8

RULE B_1H_1N_2C_1204_0:
  CALL: 2C
  PRIORITY: 20
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1H'
  CONDITION: opp_last_call == '1NT'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp <= 8
  CONDITION: hcp >= 5
  CONDITION: club_len >= 6

RULE B_1H_1N_2D_1205_0:
  CALL: 2D
  PRIORITY: 20
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1H'
  CONDITION: opp_last_call == '1NT'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp <= 8
  CONDITION: hcp >= 5
  CONDITION: diamond_len >= 6

RULE B_1H_1N_2H_1206_0:
  CALL: 2H
  PRIORITY: 40
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1H'
  CONDITION: opp_last_call == '1NT'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp <= 10
  CONDITION: heart_hcp >= 5
  CONDITION: heart_len >= 3

RULE B_1H_1N_2S_1207_0:
  CALL: 2S
  PRIORITY: 30
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1H'
  CONDITION: opp_last_call == '1NT'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp <= 8
  CONDITION: hcp >= 5
  CONDITION: spade_len >= 6

RULE B_1H_1N_3H_1208_0:
  CALL: 3H
  PRIORITY: 60
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1H'
  CONDITION: opp_last_call == '1NT'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp <= 10
  CONDITION: hcp >= 5
  CONDITION: heart_len >= 4

RULE B_1H_1N_3H_1208_1:
  CALL: 3H
  PRIORITY: 60
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1H'
  CONDITION: opp_last_call == '1NT'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp <= 10
  CONDITION: hcp >= 5
  CONDITION: heart_len >= 5

RULE B_1H_1N_4H_1210_0:
  CALL: 4H
  PRIORITY: 65
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1H'
  CONDITION: opp_last_call == '1NT'
  CONDITION: passes_since_last_bid == 0
  CONDITION: heart_hcp >= 11
  CONDITION: heart_len >= 4

RULE B_1H_1N_4S_1211_0:
  CALL: 4S
  PRIORITY: 63
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1H'
  CONDITION: opp_last_call == '1NT'
  CONDITION: passes_since_last_bid == 0
  CONDITION: spade_hcp >= 11
  CONDITION: heart_len >= 7

RULE B_1H_2N_PASS_1213_0:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1H'
  CONDITION: opp_last_call == '2NT'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp <= 8

RULE B_1H_2N_3C_1214_0:
  CALL: 3C
  PRIORITY: 60
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1H'
  CONDITION: opp_last_call == '2NT'
  CONDITION: passes_since_last_bid == 0
  CONDITION: heart_len >= 3
  CONDITION: hcp >= 10

RULE B_1H_2N_3D_1215_0:
  CALL: 3D
  PRIORITY: 50
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1H'
  CONDITION: opp_last_call == '2NT'
  CONDITION: passes_since_last_bid == 0
  CONDITION: spade_len >= 5
  CONDITION: hcp >= 10

RULE B_1H_2N_3H_1216_0:
  CALL: 3H
  PRIORITY: 30
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1H'
  CONDITION: opp_last_call == '2NT'
  CONDITION: passes_since_last_bid == 0
  CONDITION: heart_len >= 3
  CONDITION: hcp <= 9
  CONDITION: hcp >= 7

RULE B_1H_2N_3S_1217_0:
  CALL: 3S
  PRIORITY: 25
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1H'
  CONDITION: opp_last_call == '2NT'
  CONDITION: passes_since_last_bid == 0
  CONDITION: spade_len >= 6
  CONDITION: hcp <= 9
  CONDITION: hcp >= 7

RULE B_1H_2N_3NT_1218_0:
  CALL: 3NT
  PRIORITY: 40
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1H'
  CONDITION: opp_last_call == '2NT'
  CONDITION: passes_since_last_bid == 0
  CONDITION: c_stopper >= 2
  CONDITION: d_stopper >= 2
  CONDITION: hcp >= 12
  CONDITION: heart_len <= 2

RULE B_1H_2N_4H_1219_0:
  CALL: 4H
  PRIORITY: 33
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1H'
  CONDITION: opp_last_call == '2NT'
  CONDITION: passes_since_last_bid == 0
  CONDITION: heart_len >= 4
  CONDITION: hcp <= 9
  CONDITION: heart_hcp >= 6

RULE B_1H_2N_4S_1220_0:
  CALL: 4S
  PRIORITY: 35
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1H'
  CONDITION: opp_last_call == '2NT'
  CONDITION: passes_since_last_bid == 0
  CONDITION: spade_len >= 7
  CONDITION: hcp <= 9
  CONDITION: hcp >= 7

RULE B_1H_2N_6H_1224_0:
  CALL: 6H
  PRIORITY: 65
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1H'
  CONDITION: opp_last_call == '2NT'
  CONDITION: passes_since_last_bid == 0
  CONDITION: h_realsolid == True
  CONDITION: losing_trick_count == 1

RULE B_1H_2N_7H_1226_0:
  CALL: 7H
  PRIORITY: 66
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1H'
  CONDITION: opp_last_call == '2NT'
  CONDITION: passes_since_last_bid == 0
  CONDITION: h_realsolid == True
  CONDITION: losing_trick_count <= 0

RULE B_1H_2N_X_1229_0:
  CALL: X
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1H'
  CONDITION: opp_last_call == '2NT'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 9

RULE B_1S_P_PASS_1230_0:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1S'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 1
  CONDITION: hcp <= 5

RULE B_1S_P_1NT_1231_0:
  CALL: 1NT
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1S'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 1
  CONDITION: hcp <= 12
  CONDITION: spade_len < 4
  CONDITION: hcp >= 6

RULE B_1S_P_2C_1232_1:
  CALL: 2C
  PRIORITY: 20
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1S'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 1
  CONDITION: hcp >= 12
  CONDITION: c_is_longest == True
  CONDITION: club_len == 4

RULE B_1S_P_2C_1232_2:
  CALL: 2C
  PRIORITY: 20
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1S'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 1
  CONDITION: hcp >= 12
  CONDITION: shape_pattern == 4333
  CONDITION: spade_len == 3
  CONDITION: heart_len == 4
  CONDITION: diamond_len == 3
  CONDITION: club_len == 3

RULE B_1S_P_2H_1234_0:
  CALL: 2H
  PRIORITY: 90
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1S'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 1
  CONDITION: heart_hcp >= 14
  CONDITION: hcp >= 10
  CONDITION: h_is_longest == True
  CONDITION: heart_len >= 5

RULE B_1S_P_2S_1235_0:
  CALL: 2S
  PRIORITY: 70
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1S'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 1
  CONDITION: total_points >= 6
  CONDITION: hcp < 10
  CONDITION: spade_len >= 3

RULE B_1S_P_2S_1235_1:
  CALL: 2S
  PRIORITY: 70
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1S'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 1
  CONDITION: hcp >= 5
  CONDITION: hcp < 10
  CONDITION: spade_len >= 4

RULE B_1S_P_2NT_1236_0:
  CALL: 2NT
  PRIORITY: 120
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1S'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 1
  CONDITION: spade_hcp >= 12
  CONDITION: hcp >= 12
  CONDITION: spade_len >= 4

RULE B_1S_P_3C_1237_0:
  CALL: 3C
  PRIORITY: 90
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1S'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 1
  CONDITION: hcp >= 10
  CONDITION: hcp < 12
  CONDITION: club_len >= 6
  CONDITION: heart_len <= 3
  CONDITION: spade_len <= 2

RULE B_1S_P_3D_1238_0:
  CALL: 3D
  PRIORITY: 90
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1S'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 1
  CONDITION: hcp >= 10
  CONDITION: hcp < 12
  CONDITION: diamond_len >= 6
  CONDITION: heart_len <= 3
  CONDITION: spade_len <= 2

RULE B_1S_P_3H_1239_0:
  CALL: 3H
  PRIORITY: 100
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1S'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 1
  CONDITION: hcp >= 10
  CONDITION: hcp < 12
  CONDITION: heart_len >= 6

RULE B_1S_P_3S_1240_0:
  CALL: 3S
  PRIORITY: 100
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1S'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 1
  CONDITION: hcp >= 9
  CONDITION: hcp < 12
  CONDITION: spade_len >= 4

RULE B_1S_P_4C_1242_0:
  CALL: 4C
  PRIORITY: 125
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1S'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 1
  CONDITION: hcp >= 10
  CONDITION: hcp <= 14
  CONDITION: club_len <= 1
  CONDITION: spade_len >= 4

RULE B_1S_P_4D_1243_0:
  CALL: 4D
  PRIORITY: 125
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1S'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 1
  CONDITION: hcp >= 10
  CONDITION: hcp <= 14
  CONDITION: diamond_len <= 1
  CONDITION: spade_len >= 4

RULE B_1S_P_4H_1244_0:
  CALL: 4H
  PRIORITY: 125
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1S'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 1
  CONDITION: hcp >= 10
  CONDITION: hcp <= 14
  CONDITION: heart_len <= 1
  CONDITION: spade_len >= 4

RULE B_1S_P_4S_1245_0:
  CALL: 4S
  PRIORITY: 72
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1S'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 1
  CONDITION: hcp <= 8
  CONDITION: spade_len >= 5

RULE B_1S_P_6S_1249_0:
  CALL: 6S
  PRIORITY: 5
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1S'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 1
  CONDITION: spade_len >= 3
  CONDITION: s_realsolid == True
  CONDITION: losing_trick_count == 1

RULE B_1S_P_7S_1251_0:
  CALL: 7S
  PRIORITY: 6
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1S'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 1
  CONDITION: spade_len >= 3
  CONDITION: s_realsolid == True
  CONDITION: losing_trick_count <= 0

RULE B_1S_X_PASS_1254_0:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1S'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 0

RULE B_1S_X_1NT_1255_0:
  CALL: 1NT
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1S'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp < 10
  CONDITION: hcp >= 7

RULE B_1S_X_2C_1256_0:
  CALL: 2C
  PRIORITY: 28
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1S'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 0
  CONDITION: c_is_best_minor == True
  CONDITION: club_len >= 5
  CONDITION: total_points >= 9
  CONDITION: hcp <= 11
  CONDITION: hcp >= 7

RULE B_1S_X_2D_1257_0:
  CALL: 2D
  PRIORITY: 28
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1S'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 0
  CONDITION: d_is_best_minor == True
  CONDITION: diamond_len >= 5
  CONDITION: total_points >= 9
  CONDITION: hcp <= 11
  CONDITION: hcp >= 7

RULE B_1S_X_2H_1258_0:
  CALL: 2H
  PRIORITY: 40
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1S'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 0
  CONDITION: heart_len >= 5
  CONDITION: total_points >= 9
  CONDITION: total_points <= 11

RULE B_1S_X_2S_1259_0:
  CALL: 2S
  PRIORITY: 45
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1S'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 0
  CONDITION: spade_hcp >= 4
  CONDITION: spade_len >= 5

RULE B_1S_X_2S_1259_1:
  CALL: 2S
  PRIORITY: 45
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1S'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 0
  CONDITION: total_points >= 6
  CONDITION: hcp < 10
  CONDITION: spade_len >= 3

RULE B_1S_X_2S_1259_2:
  CALL: 2S
  PRIORITY: 45
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1S'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 5
  CONDITION: hcp < 10
  CONDITION: spade_len >= 4

RULE B_1S_X_2NT_1260_0:
  CALL: 2NT
  PRIORITY: 120
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1S'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 0
  CONDITION: spade_hcp > 12
  CONDITION: spade_len >= 3

RULE B_1S_X_2NT_1260_1:
  CALL: 2NT
  PRIORITY: 120
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1S'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 10
  CONDITION: spade_len >= 3

RULE B_1S_X_3NT_1264_0:
  CALL: 3NT
  PRIORITY: 70
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1S'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 0
  CONDITION: spade_len == 2
  CONDITION: heart_len == 3
  CONDITION: h_stopper >= 2
  CONDITION: c_stopper >= 2
  CONDITION: d_stopper >= 2
  CONDITION: hcp >= 14
  CONDITION: hcp <= 17

RULE B_1S_X_4C_1265_0:
  CALL: 4C
  PRIORITY: 125
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1S'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 10
  CONDITION: hcp <= 14
  CONDITION: club_len <= 1
  CONDITION: spade_len >= 4

RULE B_1S_X_4D_1266_0:
  CALL: 4D
  PRIORITY: 125
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1S'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 10
  CONDITION: hcp <= 14
  CONDITION: diamond_len <= 1
  CONDITION: spade_len >= 4

RULE B_1S_X_4H_1267_0:
  CALL: 4H
  PRIORITY: 125
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1S'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 10
  CONDITION: hcp <= 14
  CONDITION: heart_len <= 1
  CONDITION: spade_len >= 4

RULE B_1S_X_4S_1268_0:
  CALL: 4S
  PRIORITY: 55
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1S'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 0
  CONDITION: spade_hcp >= 7
  CONDITION: hcp < 10
  CONDITION: spade_len >= 5

RULE B_1S_X_XX_1269_0:
  CALL: XX
  PRIORITY: 25
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1S'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 10

RULE B_1S_2C_PASS_1270_0:
  CALL: PASS
  PRIORITY: 20
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1S'
  CONDITION: opp_last_call == '2C'
  CONDITION: passes_since_last_bid == 0

RULE B_1S_2C_PASS_1270_1:
  CALL: PASS
  PRIORITY: 20
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1S'
  CONDITION: opp_last_call == '2C'
  CONDITION: passes_since_last_bid == 0
  CONDITION: club_len >= 4
  CONDITION: hcp >= 10

RULE B_1S_2C_PASS_1270_2:
  CALL: PASS
  PRIORITY: 20
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1S'
  CONDITION: opp_last_call == '2C'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp <= 8

RULE B_1S_2C_PASS_1270_3:
  CALL: PASS
  PRIORITY: 20
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1S'
  CONDITION: opp_last_call == '2C'
  CONDITION: passes_since_last_bid == 0
  CONDITION: club_len >= 5

RULE B_1S_2C_2D_1271_0:
  CALL: 2D
  PRIORITY: 30
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1S'
  CONDITION: opp_last_call == '2C'
  CONDITION: passes_since_last_bid == 0
  CONDITION: diamond_len >= 4
  CONDITION: total_points >= 10
  CONDITION: hcp >= 8

RULE B_1S_2C_2D_1271_1:
  CALL: 2D
  PRIORITY: 30
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1S'
  CONDITION: opp_last_call == '2C'
  CONDITION: passes_since_last_bid == 0
  CONDITION: diamond_len >= 5
  CONDITION: total_points >= 10
  CONDITION: hcp >= 8

RULE B_1S_2C_2D_1271_2:
  CALL: 2D
  PRIORITY: 30
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1S'
  CONDITION: opp_last_call == '2C'
  CONDITION: passes_since_last_bid == 0
  CONDITION: diamond_len >= 5
  CONDITION: hcp >= 9

RULE B_1S_2C_2H_1272_0:
  CALL: 2H
  PRIORITY: 60
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1S'
  CONDITION: opp_last_call == '2C'
  CONDITION: passes_since_last_bid == 0
  CONDITION: heart_len >= 5
  CONDITION: hcp >= 9

RULE B_1S_2C_2H_1272_1:
  CALL: 2H
  PRIORITY: 60
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1S'
  CONDITION: opp_last_call == '2C'
  CONDITION: passes_since_last_bid == 0
  CONDITION: heart_len >= 5
  CONDITION: total_points >= 10
  CONDITION: hcp >= 8

RULE B_1S_2C_2S_1273_0:
  CALL: 2S
  PRIORITY: 80
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1S'
  CONDITION: opp_last_call == '2C'
  CONDITION: passes_since_last_bid == 0
  CONDITION: spade_len >= 3
  CONDITION: hcp <= 9
  CONDITION: spade_hcp >= 6

RULE B_1S_2C_2NT_1274_0:
  CALL: 2NT
  PRIORITY: 32
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1S'
  CONDITION: opp_last_call == '2C'
  CONDITION: passes_since_last_bid == 0
  CONDITION: c_stopper >= 2
  CONDITION: hcp >= 9
  CONDITION: hcp <= 11

RULE B_1S_2C_3C_1275_0:
  CALL: 3C
  PRIORITY: 70
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1S'
  CONDITION: opp_last_call == '2C'
  CONDITION: passes_since_last_bid == 0
  CONDITION: spade_len >= 3
  CONDITION: hcp >= 10

RULE B_1S_2C_3D_1276_0:
  CALL: 3D
  PRIORITY: 20
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1S'
  CONDITION: opp_last_call == '2C'
  CONDITION: passes_since_last_bid == 0
  CONDITION: diamond_len >= 6
  CONDITION: hcp >= 15

RULE B_1S_2C_3S_1277_0:
  CALL: 3S
  PRIORITY: 54
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1S'
  CONDITION: opp_last_call == '2C'
  CONDITION: passes_since_last_bid == 0
  CONDITION: spade_len >= 4
  CONDITION: hcp <= 7
  CONDITION: spade_hcp >= 5

RULE B_1S_2C_4C_1279_0:
  CALL: 4C
  PRIORITY: 125
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1S'
  CONDITION: opp_last_call == '2C'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 10
  CONDITION: hcp <= 14
  CONDITION: club_len <= 1
  CONDITION: spade_len >= 4

RULE B_1S_2C_4S_1280_0:
  CALL: 4S
  PRIORITY: 82
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1S'
  CONDITION: opp_last_call == '2C'
  CONDITION: passes_since_last_bid == 0
  CONDITION: spade_len >= 5
  CONDITION: hcp <= 9
  CONDITION: spade_hcp >= 4

RULE B_1S_2C_6S_1284_0:
  CALL: 6S
  PRIORITY: 95
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1S'
  CONDITION: opp_last_call == '2C'
  CONDITION: passes_since_last_bid == 0
  CONDITION: spade_len >= 3
  CONDITION: s_realsolid == True
  CONDITION: losing_trick_count == 1

RULE B_1S_2C_7S_1286_0:
  CALL: 7S
  PRIORITY: 96
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1S'
  CONDITION: opp_last_call == '2C'
  CONDITION: passes_since_last_bid == 0
  CONDITION: spade_len >= 3
  CONDITION: s_realsolid == True
  CONDITION: losing_trick_count <= 0

RULE B_1S_2C_X_1289_0:
  CALL: X
  PRIORITY: 46
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1S'
  CONDITION: opp_last_call == '2C'
  CONDITION: passes_since_last_bid == 0
  CONDITION: heart_len >= 4
  CONDITION: hcp >= 8

RULE B_1S_2C_X_1289_1:
  CALL: X
  PRIORITY: 46
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1S'
  CONDITION: opp_last_call == '2C'
  CONDITION: passes_since_last_bid == 0
  CONDITION: heart_len >= 5
  CONDITION: hcp >= 7

RULE B_1S_2C_X_1289_2:
  CALL: X
  PRIORITY: 46
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1S'
  CONDITION: opp_last_call == '2C'
  CONDITION: passes_since_last_bid == 0
  CONDITION: heart_len >= 6
  CONDITION: hcp >= 6

RULE B_1S_2D_PASS_1290_0:
  CALL: PASS
  PRIORITY: 20
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1S'
  CONDITION: opp_last_call == '2D'
  CONDITION: passes_since_last_bid == 0

RULE B_1S_2D_PASS_1290_1:
  CALL: PASS
  PRIORITY: 20
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1S'
  CONDITION: opp_last_call == '2D'
  CONDITION: passes_since_last_bid == 0
  CONDITION: diamond_len >= 4
  CONDITION: hcp >= 10

RULE B_1S_2D_PASS_1290_2:
  CALL: PASS
  PRIORITY: 20
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1S'
  CONDITION: opp_last_call == '2D'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp <= 8

RULE B_1S_2D_PASS_1290_3:
  CALL: PASS
  PRIORITY: 20
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1S'
  CONDITION: opp_last_call == '2D'
  CONDITION: passes_since_last_bid == 0
  CONDITION: diamond_len >= 5

RULE B_1S_2D_2H_1291_0:
  CALL: 2H
  PRIORITY: 60
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1S'
  CONDITION: opp_last_call == '2D'
  CONDITION: passes_since_last_bid == 0
  CONDITION: heart_len >= 5
  CONDITION: total_points >= 10
  CONDITION: hcp >= 8

RULE B_1S_2D_2S_1292_0:
  CALL: 2S
  PRIORITY: 80
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1S'
  CONDITION: opp_last_call == '2D'
  CONDITION: passes_since_last_bid == 0
  CONDITION: spade_len >= 3
  CONDITION: hcp <= 9
  CONDITION: spade_hcp >= 6

RULE B_1S_2D_2NT_1293_0:
  CALL: 2NT
  PRIORITY: 32
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1S'
  CONDITION: opp_last_call == '2D'
  CONDITION: passes_since_last_bid == 0
  CONDITION: d_stopper >= 2
  CONDITION: hcp >= 9
  CONDITION: hcp <= 11

RULE B_1S_2D_3C_1294_0:
  CALL: 3C
  PRIORITY: 20
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1S'
  CONDITION: opp_last_call == '2D'
  CONDITION: passes_since_last_bid == 0
  CONDITION: club_len >= 5
  CONDITION: hcp >= 10

RULE B_1S_2D_3D_1295_0:
  CALL: 3D
  PRIORITY: 70
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1S'
  CONDITION: opp_last_call == '2D'
  CONDITION: passes_since_last_bid == 0
  CONDITION: spade_len >= 3
  CONDITION: hcp >= 10

RULE B_1S_2D_3S_1296_0:
  CALL: 3S
  PRIORITY: 54
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1S'
  CONDITION: opp_last_call == '2D'
  CONDITION: passes_since_last_bid == 0
  CONDITION: spade_len >= 4
  CONDITION: hcp <= 7
  CONDITION: spade_hcp >= 5

RULE B_1S_2D_4D_1298_0:
  CALL: 4D
  PRIORITY: 125
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1S'
  CONDITION: opp_last_call == '2D'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 10
  CONDITION: hcp <= 14
  CONDITION: diamond_len <= 1
  CONDITION: spade_len >= 4

RULE B_1S_2D_4S_1299_0:
  CALL: 4S
  PRIORITY: 82
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1S'
  CONDITION: opp_last_call == '2D'
  CONDITION: passes_since_last_bid == 0
  CONDITION: spade_len >= 5
  CONDITION: hcp <= 9
  CONDITION: spade_hcp >= 4

RULE B_1S_2D_6S_1303_0:
  CALL: 6S
  PRIORITY: 95
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1S'
  CONDITION: opp_last_call == '2D'
  CONDITION: passes_since_last_bid == 0
  CONDITION: spade_len >= 3
  CONDITION: s_realsolid == True
  CONDITION: losing_trick_count == 1

RULE B_1S_2D_7S_1305_0:
  CALL: 7S
  PRIORITY: 96
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1S'
  CONDITION: opp_last_call == '2D'
  CONDITION: passes_since_last_bid == 0
  CONDITION: spade_len >= 3
  CONDITION: s_realsolid == True
  CONDITION: losing_trick_count <= 0

RULE B_1S_2D_X_1308_0:
  CALL: X
  PRIORITY: 46
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1S'
  CONDITION: opp_last_call == '2D'
  CONDITION: passes_since_last_bid == 0
  CONDITION: heart_len >= 4
  CONDITION: hcp >= 8

RULE B_1S_2D_X_1308_1:
  CALL: X
  PRIORITY: 46
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1S'
  CONDITION: opp_last_call == '2D'
  CONDITION: passes_since_last_bid == 0
  CONDITION: heart_len >= 5
  CONDITION: hcp >= 7

RULE B_1S_2D_X_1308_2:
  CALL: X
  PRIORITY: 46
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1S'
  CONDITION: opp_last_call == '2D'
  CONDITION: passes_since_last_bid == 0
  CONDITION: heart_len >= 6
  CONDITION: hcp >= 6

RULE B_1S_2H_PASS_1309_0:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1S'
  CONDITION: opp_last_call == '2H'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp <= 11

RULE B_1S_2H_PASS_1309_1:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1S'
  CONDITION: opp_last_call == '2H'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp <= 8

RULE B_1S_2H_2S_1310_0:
  CALL: 2S
  PRIORITY: 33
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1S'
  CONDITION: opp_last_call == '2H'
  CONDITION: passes_since_last_bid == 0
  CONDITION: spade_len >= 3
  CONDITION: hcp <= 9
  CONDITION: spade_hcp >= 6

RULE B_1S_2H_2NT_1311_0:
  CALL: 2NT
  PRIORITY: 30
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1S'
  CONDITION: opp_last_call == '2H'
  CONDITION: passes_since_last_bid == 0
  CONDITION: h_stopper >= 2
  CONDITION: hcp >= 10
  CONDITION: hcp <= 11

RULE B_1S_2H_3C_1312_0:
  CALL: 3C
  PRIORITY: 29
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1S'
  CONDITION: opp_last_call == '2H'
  CONDITION: passes_since_last_bid == 0
  CONDITION: club_len >= 5
  CONDITION: hcp >= 10

RULE B_1S_2H_3C_1312_1:
  CALL: 3C
  PRIORITY: 29
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1S'
  CONDITION: opp_last_call == '2H'
  CONDITION: passes_since_last_bid == 0
  CONDITION: club_len >= 5
  CONDITION: total_points >= 13

RULE B_1S_2H_3D_1313_0:
  CALL: 3D
  PRIORITY: 29
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1S'
  CONDITION: opp_last_call == '2H'
  CONDITION: passes_since_last_bid == 0
  CONDITION: diamond_len >= 5
  CONDITION: hcp >= 10

RULE B_1S_2H_3D_1313_1:
  CALL: 3D
  PRIORITY: 29
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1S'
  CONDITION: opp_last_call == '2H'
  CONDITION: passes_since_last_bid == 0
  CONDITION: diamond_len >= 5
  CONDITION: total_points >= 13

RULE B_1S_2H_3H_1314_0:
  CALL: 3H
  PRIORITY: 32
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1S'
  CONDITION: opp_last_call == '2H'
  CONDITION: passes_since_last_bid == 0
  CONDITION: spade_len >= 3
  CONDITION: hcp >= 10

RULE B_1S_2H_3H_1314_1:
  CALL: 3H
  PRIORITY: 32
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1S'
  CONDITION: opp_last_call == '2H'
  CONDITION: passes_since_last_bid == 0
  CONDITION: spade_len >= 3
  CONDITION: spade_hcp >= 12

RULE B_1S_2H_3S_1315_0:
  CALL: 3S
  PRIORITY: 34
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1S'
  CONDITION: opp_last_call == '2H'
  CONDITION: passes_since_last_bid == 0
  CONDITION: spade_len >= 4
  CONDITION: hcp <= 8
  CONDITION: hcp >= 4

RULE B_1S_2H_4S_1318_0:
  CALL: 4S
  PRIORITY: 40
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1S'
  CONDITION: opp_last_call == '2H'
  CONDITION: passes_since_last_bid == 0
  CONDITION: spade_len >= 5
  CONDITION: hcp <= 8

RULE B_1S_2H_X_1319_0:
  CALL: X
  PRIORITY: 28
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1S'
  CONDITION: opp_last_call == '2H'
  CONDITION: passes_since_last_bid == 0
  CONDITION: club_len >= 4
  CONDITION: diamond_len >= 4
  CONDITION: hcp >= 9

RULE B_1S_2S_PASS_1320_0:
  CALL: PASS
  PRIORITY: -1
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1S'
  CONDITION: opp_last_call == '2S'
  CONDITION: passes_since_last_bid == 0
  CONDITION: heart_len >= 4

RULE B_1S_2S_PASS_1321_0:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1S'
  CONDITION: opp_last_call == '2S'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp <= 11
  CONDITION: spade_len <= 3

RULE B_1S_2S_PASS_1321_1:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1S'
  CONDITION: opp_last_call == '2S'
  CONDITION: passes_since_last_bid == 0
  CONDITION: total_points <= 7

RULE B_1S_2S_3C_1322_0:
  CALL: 3C
  PRIORITY: 30
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1S'
  CONDITION: opp_last_call == '2S'
  CONDITION: passes_since_last_bid == 0
  CONDITION: club_len >= 5
  CONDITION: hcp <= 10
  CONDITION: hcp >= 7

RULE B_1S_2S_3D_1323_0:
  CALL: 3D
  PRIORITY: 30
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1S'
  CONDITION: opp_last_call == '2S'
  CONDITION: passes_since_last_bid == 0
  CONDITION: diamond_len >= 5
  CONDITION: hcp <= 10
  CONDITION: hcp >= 7

RULE B_1S_2S_3H_1324_0:
  CALL: 3H
  PRIORITY: 38
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1S'
  CONDITION: opp_last_call == '2S'
  CONDITION: passes_since_last_bid == 0
  CONDITION: spade_len >= 3
  CONDITION: spade_hcp >= 10
  CONDITION: hcp >= 8

RULE B_1S_2S_3H_1324_1:
  CALL: 3H
  PRIORITY: 38
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1S'
  CONDITION: opp_last_call == '2S'
  CONDITION: passes_since_last_bid == 0
  CONDITION: spade_len >= 3
  CONDITION: total_points >= 10
  CONDITION: hcp >= 9

RULE B_1S_2S_3S_1325_0:
  CALL: 3S
  PRIORITY: 35
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1S'
  CONDITION: opp_last_call == '2S'
  CONDITION: passes_since_last_bid == 0
  CONDITION: spade_len >= 3
  CONDITION: total_points <= 10
  CONDITION: total_points >= 8

RULE B_1S_2S_3NT_1326_0:
  CALL: 3NT
  PRIORITY: 20
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1S'
  CONDITION: opp_last_call == '2S'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 12
  CONDITION: h_stopper >= 2

RULE B_1S_2S_4S_1327_0:
  CALL: 4S
  PRIORITY: 50
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1S'
  CONDITION: opp_last_call == '2S'
  CONDITION: passes_since_last_bid == 0
  CONDITION: spade_len >= 3
  CONDITION: total_points >= 10
  CONDITION: spade_hcp <= 14

RULE B_1S_2S_4S_1327_1:
  CALL: 4S
  PRIORITY: 50
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1S'
  CONDITION: opp_last_call == '2S'
  CONDITION: passes_since_last_bid == 0
  CONDITION: spade_len >= 5
  CONDITION: total_points >= 4
  CONDITION: spade_hcp <= 14

RULE B_1S_2S_4S_1327_2:
  CALL: 4S
  PRIORITY: 50
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1S'
  CONDITION: opp_last_call == '2S'
  CONDITION: passes_since_last_bid == 0
  CONDITION: spade_len >= 4
  CONDITION: total_points >= 10
  CONDITION: spade_hcp <= 14

RULE B_1S_2S_5C_1328_0:
  CALL: 5C
  PRIORITY: 55
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1S'
  CONDITION: opp_last_call == '2S'
  CONDITION: passes_since_last_bid == 0
  CONDITION: club_len >= 8
  CONDITION: losing_trick_count <= 5

RULE B_1S_2S_5D_1329_0:
  CALL: 5D
  PRIORITY: 55
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1S'
  CONDITION: opp_last_call == '2S'
  CONDITION: passes_since_last_bid == 0
  CONDITION: diamond_len >= 8
  CONDITION: losing_trick_count <= 5

RULE B_1S_2S_X_1330_0:
  CALL: X
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1S'
  CONDITION: opp_last_call == '2S'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 12

RULE B_1S_3C_PASS_1331_0:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1S'
  CONDITION: opp_last_call == '3C'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp <= 11

RULE B_1S_3C_3D_1332_0:
  CALL: 3D
  PRIORITY: 20
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1S'
  CONDITION: opp_last_call == '3C'
  CONDITION: passes_since_last_bid == 0
  CONDITION: total_points >= 12
  CONDITION: diamond_len >= 5

RULE B_1S_3C_3H_1333_0:
  CALL: 3H
  PRIORITY: 35
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1S'
  CONDITION: opp_last_call == '3C'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 12
  CONDITION: heart_len >= 5

RULE B_1S_3C_3S_1334_0:
  CALL: 3S
  PRIORITY: 41
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1S'
  CONDITION: opp_last_call == '3C'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 7
  CONDITION: hcp <= 10
  CONDITION: spade_len >= 3

RULE B_1S_3C_3NT_1335_0:
  CALL: 3NT
  PRIORITY: 20
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1S'
  CONDITION: opp_last_call == '3C'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 12
  CONDITION: c_stopper >= 2
  CONDITION: hcp <= 18

RULE B_1S_3C_4C_1336_0:
  CALL: 4C
  PRIORITY: 56
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1S'
  CONDITION: opp_last_call == '3C'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 13
  CONDITION: spade_len >= 2

RULE B_1S_3C_4C_1336_1:
  CALL: 4C
  PRIORITY: 56
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1S'
  CONDITION: opp_last_call == '3C'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 13
  CONDITION: spade_len >= 3

RULE B_1S_3C_4H_1337_0:
  CALL: 4H
  PRIORITY: 15
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1S'
  CONDITION: opp_last_call == '3C'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 10
  CONDITION: heart_len >= 7

RULE B_1S_3C_4S_1338_0:
  CALL: 4S
  PRIORITY: 43
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1S'
  CONDITION: opp_last_call == '3C'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 11
  CONDITION: hcp <= 12
  CONDITION: spade_len >= 2

RULE B_1S_3C_4S_1338_1:
  CALL: 4S
  PRIORITY: 43
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1S'
  CONDITION: opp_last_call == '3C'
  CONDITION: passes_since_last_bid == 0
  CONDITION: spade_len >= 4
  CONDITION: spade_hcp >= 10
  CONDITION: hcp < 10

RULE B_1S_3C_4S_1338_2:
  CALL: 4S
  PRIORITY: 43
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1S'
  CONDITION: opp_last_call == '3C'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 11
  CONDITION: hcp <= 12
  CONDITION: spade_len >= 3

RULE B_1S_3C_4S_1338_3:
  CALL: 4S
  PRIORITY: 43
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1S'
  CONDITION: opp_last_call == '3C'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 9
  CONDITION: hcp <= 12
  CONDITION: spade_len >= 4

RULE B_1S_3C_6S_1342_0:
  CALL: 6S
  PRIORITY: 65
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1S'
  CONDITION: opp_last_call == '3C'
  CONDITION: passes_since_last_bid == 0
  CONDITION: s_realsolid == True
  CONDITION: losing_trick_count == 1

RULE B_1S_3C_7S_1344_0:
  CALL: 7S
  PRIORITY: 66
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1S'
  CONDITION: opp_last_call == '3C'
  CONDITION: passes_since_last_bid == 0
  CONDITION: s_realsolid == True
  CONDITION: losing_trick_count <= 0

RULE B_1S_3C_X_1347_0:
  CALL: X
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1S'
  CONDITION: opp_last_call == '3C'
  CONDITION: passes_since_last_bid == 0
  CONDITION: heart_len >= 4
  CONDITION: hcp >= 10

RULE B_1S_3D_PASS_1348_0:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1S'
  CONDITION: opp_last_call == '3D'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp <= 11

RULE B_1S_3D_3H_1349_0:
  CALL: 3H
  PRIORITY: 35
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1S'
  CONDITION: opp_last_call == '3D'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 12
  CONDITION: heart_len >= 5

RULE B_1S_3D_3S_1350_0:
  CALL: 3S
  PRIORITY: 41
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1S'
  CONDITION: opp_last_call == '3D'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 7
  CONDITION: hcp <= 10
  CONDITION: spade_len >= 3

RULE B_1S_3D_3NT_1351_0:
  CALL: 3NT
  PRIORITY: 20
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1S'
  CONDITION: opp_last_call == '3D'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 12
  CONDITION: d_stopper >= 2
  CONDITION: hcp <= 18

RULE B_1S_3D_4C_1352_0:
  CALL: 4C
  PRIORITY: 5
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1S'
  CONDITION: opp_last_call == '3D'
  CONDITION: passes_since_last_bid == 0
  CONDITION: club_len >= 6
  CONDITION: hcp >= 10

RULE B_1S_3D_4D_1353_0:
  CALL: 4D
  PRIORITY: 56
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1S'
  CONDITION: opp_last_call == '3D'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 13
  CONDITION: spade_len >= 2

RULE B_1S_3D_4D_1353_1:
  CALL: 4D
  PRIORITY: 56
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1S'
  CONDITION: opp_last_call == '3D'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 13
  CONDITION: spade_len >= 3

RULE B_1S_3D_4H_1354_0:
  CALL: 4H
  PRIORITY: 15
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1S'
  CONDITION: opp_last_call == '3D'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 10
  CONDITION: heart_len >= 7

RULE B_1S_3D_4S_1355_0:
  CALL: 4S
  PRIORITY: 43
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1S'
  CONDITION: opp_last_call == '3D'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 11
  CONDITION: hcp <= 12
  CONDITION: spade_len >= 2

RULE B_1S_3D_4S_1355_1:
  CALL: 4S
  PRIORITY: 43
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1S'
  CONDITION: opp_last_call == '3D'
  CONDITION: passes_since_last_bid == 0
  CONDITION: spade_len >= 4
  CONDITION: spade_hcp >= 10
  CONDITION: hcp < 10

RULE B_1S_3D_4S_1355_2:
  CALL: 4S
  PRIORITY: 43
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1S'
  CONDITION: opp_last_call == '3D'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 11
  CONDITION: hcp <= 12
  CONDITION: spade_len >= 3

RULE B_1S_3D_4S_1355_3:
  CALL: 4S
  PRIORITY: 43
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1S'
  CONDITION: opp_last_call == '3D'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 9
  CONDITION: hcp <= 12
  CONDITION: spade_len >= 4

RULE B_1S_3D_6S_1359_0:
  CALL: 6S
  PRIORITY: 65
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1S'
  CONDITION: opp_last_call == '3D'
  CONDITION: passes_since_last_bid == 0
  CONDITION: s_realsolid == True
  CONDITION: losing_trick_count == 1

RULE B_1S_3D_7S_1361_0:
  CALL: 7S
  PRIORITY: 66
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1S'
  CONDITION: opp_last_call == '3D'
  CONDITION: passes_since_last_bid == 0
  CONDITION: s_realsolid == True
  CONDITION: losing_trick_count <= 0

RULE B_1S_3D_X_1364_0:
  CALL: X
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1S'
  CONDITION: opp_last_call == '3D'
  CONDITION: passes_since_last_bid == 0
  CONDITION: heart_len >= 4
  CONDITION: hcp >= 10

RULE B_1S_3H_PASS_1365_0:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1S'
  CONDITION: opp_last_call == '3H'
  CONDITION: passes_since_last_bid == 0

RULE B_1S_3H_4C_1369_0:
  CALL: 4C
  PRIORITY: 40
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1S'
  CONDITION: opp_last_call == '3H'
  CONDITION: passes_since_last_bid == 0
  CONDITION: club_len >= 6
  CONDITION: hcp >= 12

RULE B_1S_3H_4D_1371_0:
  CALL: 4D
  PRIORITY: 40
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1S'
  CONDITION: opp_last_call == '3H'
  CONDITION: passes_since_last_bid == 0
  CONDITION: diamond_len >= 6
  CONDITION: hcp >= 12

RULE B_1S_3H_4S_1373_1:
  CALL: 4S
  PRIORITY: 50
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1S'
  CONDITION: opp_last_call == '3H'
  CONDITION: passes_since_last_bid == 0
  CONDITION: spade_len >= 3
  CONDITION: spade_hcp >= 10

RULE B_1S_3H_5C_1375_0:
  CALL: 5C
  PRIORITY: 30
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1S'
  CONDITION: opp_last_call == '3H'
  CONDITION: passes_since_last_bid == 0
  CONDITION: club_len >= 7
  CONDITION: hcp <= 12
  CONDITION: hcp >= 6
  CONDITION: spade_len <= 2

RULE B_1S_3H_5D_1376_0:
  CALL: 5D
  PRIORITY: 30
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1S'
  CONDITION: opp_last_call == '3H'
  CONDITION: passes_since_last_bid == 0
  CONDITION: diamond_len >= 7
  CONDITION: hcp <= 12
  CONDITION: hcp >= 6
  CONDITION: spade_len <= 2

RULE B_1S_3H_X_1379_0:
  CALL: X
  PRIORITY: 5
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1S'
  CONDITION: opp_last_call == '3H'
  CONDITION: passes_since_last_bid == 0
  CONDITION: spade_len >= 2
  CONDITION: hcp >= 10

RULE B_1S_4C_PASS_1380_0:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1S'
  CONDITION: opp_last_call == '4C'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp <= 11

RULE B_1S_4C_4H_1381_0:
  CALL: 4H
  PRIORITY: 30
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1S'
  CONDITION: opp_last_call == '4C'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 12
  CONDITION: heart_len >= 6

RULE B_1S_4C_4S_1382_0:
  CALL: 4S
  PRIORITY: 25
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1S'
  CONDITION: opp_last_call == '4C'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 11
  CONDITION: hcp <= 12
  CONDITION: spade_len >= 2

RULE B_1S_4C_4S_1382_1:
  CALL: 4S
  PRIORITY: 25
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1S'
  CONDITION: opp_last_call == '4C'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 9
  CONDITION: hcp <= 16
  CONDITION: spade_len >= 3

RULE B_1S_4C_6S_1387_0:
  CALL: 6S
  PRIORITY: 65
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1S'
  CONDITION: opp_last_call == '4C'
  CONDITION: passes_since_last_bid == 0
  CONDITION: s_realsolid == True
  CONDITION: losing_trick_count == 1

RULE B_1S_4C_7S_1389_0:
  CALL: 7S
  PRIORITY: 66
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1S'
  CONDITION: opp_last_call == '4C'
  CONDITION: passes_since_last_bid == 0
  CONDITION: s_realsolid == True
  CONDITION: losing_trick_count <= 0

RULE B_1S_4C_X_1392_0:
  CALL: X
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1S'
  CONDITION: opp_last_call == '4C'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 10

RULE B_1S_4D_PASS_1393_0:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1S'
  CONDITION: opp_last_call == '4D'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp <= 11

RULE B_1S_4D_4H_1394_0:
  CALL: 4H
  PRIORITY: 30
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1S'
  CONDITION: opp_last_call == '4D'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 12
  CONDITION: heart_len >= 6

RULE B_1S_4D_4S_1395_0:
  CALL: 4S
  PRIORITY: 25
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1S'
  CONDITION: opp_last_call == '4D'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 11
  CONDITION: hcp <= 12
  CONDITION: spade_len >= 2

RULE B_1S_4D_4S_1395_1:
  CALL: 4S
  PRIORITY: 25
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1S'
  CONDITION: opp_last_call == '4D'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 9
  CONDITION: hcp <= 16
  CONDITION: spade_len >= 3

RULE B_1S_4D_6S_1400_0:
  CALL: 6S
  PRIORITY: 65
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1S'
  CONDITION: opp_last_call == '4D'
  CONDITION: passes_since_last_bid == 0
  CONDITION: s_realsolid == True
  CONDITION: losing_trick_count == 1

RULE B_1S_4D_7S_1402_0:
  CALL: 7S
  PRIORITY: 66
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1S'
  CONDITION: opp_last_call == '4D'
  CONDITION: passes_since_last_bid == 0
  CONDITION: s_realsolid == True
  CONDITION: losing_trick_count <= 0

RULE B_1S_4D_X_1405_0:
  CALL: X
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1S'
  CONDITION: opp_last_call == '4D'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 10

RULE B_1S_4H_PASS_1406_0:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1S'
  CONDITION: opp_last_call == '4H'
  CONDITION: passes_since_last_bid == 0

RULE B_1S_4H_4S_1408_0:
  CALL: 4S
  PRIORITY: 20
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1S'
  CONDITION: opp_last_call == '4H'
  CONDITION: passes_since_last_bid == 0
  CONDITION: spade_len >= 3
  CONDITION: spade_hcp >= 10

RULE B_1S_5C_PASS_1412_0:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1S'
  CONDITION: opp_last_call == '5C'
  CONDITION: passes_since_last_bid == 0

RULE B_1S_5D_PASS_1418_1:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1S'
  CONDITION: opp_last_call == '5D'
  CONDITION: passes_since_last_bid == 0

RULE B_1S_5D_5S_1420_0:
  CALL: 5S
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1S'
  CONDITION: opp_last_call == '5D'
  CONDITION: passes_since_last_bid == 0
  CONDITION: spade_len >= 3
  CONDITION: hcp >= 12

RULE B_1S_5D_X_1422_0:
  CALL: X
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1S'
  CONDITION: opp_last_call == '5D'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 13

RULE B_1S_1N_PASS_1423_0:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1S'
  CONDITION: opp_last_call == '1NT'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp <= 8

RULE B_1S_1N_2C_1424_0:
  CALL: 2C
  PRIORITY: 20
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1S'
  CONDITION: opp_last_call == '1NT'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp <= 8
  CONDITION: hcp >= 5
  CONDITION: club_len >= 6

RULE B_1S_1N_2D_1425_0:
  CALL: 2D
  PRIORITY: 20
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1S'
  CONDITION: opp_last_call == '1NT'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp <= 8
  CONDITION: hcp >= 5
  CONDITION: diamond_len >= 6

RULE B_1S_1N_2H_1426_0:
  CALL: 2H
  PRIORITY: 30
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1S'
  CONDITION: opp_last_call == '1NT'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp <= 8
  CONDITION: hcp >= 5
  CONDITION: heart_len >= 6

RULE B_1S_1N_2S_1427_0:
  CALL: 2S
  PRIORITY: 40
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1S'
  CONDITION: opp_last_call == '1NT'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp <= 10
  CONDITION: spade_hcp >= 5
  CONDITION: spade_len >= 3

RULE B_1S_1N_3S_1429_0:
  CALL: 3S
  PRIORITY: 60
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1S'
  CONDITION: opp_last_call == '1NT'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp <= 10
  CONDITION: hcp >= 5
  CONDITION: spade_len >= 4

RULE B_1S_1N_3S_1429_1:
  CALL: 3S
  PRIORITY: 60
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1S'
  CONDITION: opp_last_call == '1NT'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp <= 10
  CONDITION: hcp >= 5
  CONDITION: spade_len >= 5

RULE B_1S_1N_4H_1430_0:
  CALL: 4H
  PRIORITY: 63
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1S'
  CONDITION: opp_last_call == '1NT'
  CONDITION: passes_since_last_bid == 0
  CONDITION: heart_hcp >= 11
  CONDITION: spade_len >= 7

RULE B_1S_1N_4S_1431_0:
  CALL: 4S
  PRIORITY: 65
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1S'
  CONDITION: opp_last_call == '1NT'
  CONDITION: passes_since_last_bid == 0
  CONDITION: spade_hcp >= 11
  CONDITION: spade_len >= 4

RULE B_1S_2N_PASS_1433_0:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1S'
  CONDITION: opp_last_call == '2NT'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp <= 8

RULE B_1S_2N_3C_1434_0:
  CALL: 3C
  PRIORITY: 60
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1S'
  CONDITION: opp_last_call == '2NT'
  CONDITION: passes_since_last_bid == 0
  CONDITION: spade_len >= 3
  CONDITION: hcp >= 10

RULE B_1S_2N_3D_1435_0:
  CALL: 3D
  PRIORITY: 50
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1S'
  CONDITION: opp_last_call == '2NT'
  CONDITION: passes_since_last_bid == 0
  CONDITION: heart_len >= 5
  CONDITION: hcp >= 10

RULE B_1S_2N_3H_1436_0:
  CALL: 3H
  PRIORITY: 25
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1S'
  CONDITION: opp_last_call == '2NT'
  CONDITION: passes_since_last_bid == 0
  CONDITION: heart_len >= 6
  CONDITION: hcp <= 9
  CONDITION: hcp >= 7

RULE B_1S_2N_3S_1437_0:
  CALL: 3S
  PRIORITY: 30
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1S'
  CONDITION: opp_last_call == '2NT'
  CONDITION: passes_since_last_bid == 0
  CONDITION: spade_len >= 3
  CONDITION: hcp <= 9
  CONDITION: hcp >= 7

RULE B_1S_2N_3NT_1438_0:
  CALL: 3NT
  PRIORITY: 40
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1S'
  CONDITION: opp_last_call == '2NT'
  CONDITION: passes_since_last_bid == 0
  CONDITION: c_stopper >= 2
  CONDITION: d_stopper >= 2
  CONDITION: hcp >= 12
  CONDITION: spade_len <= 2

RULE B_1S_2N_4H_1439_0:
  CALL: 4H
  PRIORITY: 35
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1S'
  CONDITION: opp_last_call == '2NT'
  CONDITION: passes_since_last_bid == 0
  CONDITION: heart_len >= 7
  CONDITION: hcp <= 9
  CONDITION: hcp >= 7

RULE B_1S_2N_4S_1440_0:
  CALL: 4S
  PRIORITY: 33
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1S'
  CONDITION: opp_last_call == '2NT'
  CONDITION: passes_since_last_bid == 0
  CONDITION: spade_len >= 4
  CONDITION: hcp <= 9
  CONDITION: spade_hcp >= 6

RULE B_1S_2N_6S_1444_0:
  CALL: 6S
  PRIORITY: 65
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1S'
  CONDITION: opp_last_call == '2NT'
  CONDITION: passes_since_last_bid == 0
  CONDITION: s_realsolid == True
  CONDITION: losing_trick_count == 1

RULE B_1S_2N_7S_1446_0:
  CALL: 7S
  PRIORITY: 66
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1S'
  CONDITION: opp_last_call == '2NT'
  CONDITION: passes_since_last_bid == 0
  CONDITION: s_realsolid == True
  CONDITION: losing_trick_count <= 0

RULE B_1S_2N_X_1449_0:
  CALL: X
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1S'
  CONDITION: opp_last_call == '2NT'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 9

RULE B_2C_P_2D_1450_0:
  CALL: 2D
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '2C'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 1

RULE B_2C_P_2NT_1453_0:
  CALL: 2NT
  PRIORITY: 20
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '2C'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 1
  CONDITION: hcp >= 8
  CONDITION: is_balanced == True

RULE B_2C_P_2NT_1453_1:
  CALL: 2NT
  PRIORITY: 20
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '2C'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 1
  CONDITION: hcp >= 8
  CONDITION: is_semi_balanced == True

RULE B_2C_2D_PASS_1458_0:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '2C'
  CONDITION: opp_last_call == '2D'
  CONDITION: passes_since_last_bid == 0

RULE B_2C_2D_2NT_1461_0:
  CALL: 2NT
  PRIORITY: 20
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '2C'
  CONDITION: opp_last_call == '2D'
  CONDITION: passes_since_last_bid == 0
  CONDITION: d_stopper >= 2
  CONDITION: hcp >= 8

RULE B_2C_2D_3C_1462_0:
  CALL: 3C
  PRIORITY: 21
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '2C'
  CONDITION: opp_last_call == '2D'
  CONDITION: passes_since_last_bid == 0
  CONDITION: club_len >= 6
  CONDITION: hcp >= 8

RULE B_2C_2D_3D_1463_0:
  CALL: 3D
  PRIORITY: 22
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '2C'
  CONDITION: opp_last_call == '2D'
  CONDITION: passes_since_last_bid == 0
  CONDITION: diamond_len <= 1
  CONDITION: hcp >= 6

RULE B_2C_2H_PASS_1465_0:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '2C'
  CONDITION: opp_last_call == '2H'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp <= 7

RULE B_2C_2H_2S_1466_0:
  CALL: 2S
  PRIORITY: 20
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '2C'
  CONDITION: opp_last_call == '2H'
  CONDITION: passes_since_last_bid == 0
  CONDITION: spade_len >= 5
  CONDITION: hcp >= 8

RULE B_2C_2H_2NT_1467_0:
  CALL: 2NT
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '2C'
  CONDITION: opp_last_call == '2H'
  CONDITION: passes_since_last_bid == 0
  CONDITION: h_stopper >= 2
  CONDITION: hcp >= 8

RULE B_2C_2H_3C_1468_0:
  CALL: 3C
  PRIORITY: 20
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '2C'
  CONDITION: opp_last_call == '2H'
  CONDITION: passes_since_last_bid == 0
  CONDITION: c_is_best_minor == True
  CONDITION: club_len >= 6
  CONDITION: hcp >= 7

RULE B_2C_2H_3C_1468_1:
  CALL: 3C
  PRIORITY: 20
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '2C'
  CONDITION: opp_last_call == '2H'
  CONDITION: passes_since_last_bid == 0
  CONDITION: c_is_best_minor == True
  CONDITION: club_len >= 5
  CONDITION: hcp >= 8

RULE B_2C_2H_3D_1469_0:
  CALL: 3D
  PRIORITY: 20
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '2C'
  CONDITION: opp_last_call == '2H'
  CONDITION: passes_since_last_bid == 0
  CONDITION: d_is_best_minor == True
  CONDITION: diamond_len >= 6
  CONDITION: hcp >= 7

RULE B_2C_2H_3D_1469_1:
  CALL: 3D
  PRIORITY: 20
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '2C'
  CONDITION: opp_last_call == '2H'
  CONDITION: passes_since_last_bid == 0
  CONDITION: d_is_best_minor == True
  CONDITION: diamond_len >= 5
  CONDITION: hcp >= 8

RULE B_2C_2H_X_1471_0:
  CALL: X
  PRIORITY: 30
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '2C'
  CONDITION: opp_last_call == '2H'
  CONDITION: passes_since_last_bid == 0
  CONDITION: heart_len >= 5

RULE B_2C_2S_PASS_1472_0:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '2C'
  CONDITION: opp_last_call == '2S'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp <= 7

RULE B_2C_2S_2NT_1473_0:
  CALL: 2NT
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '2C'
  CONDITION: opp_last_call == '2S'
  CONDITION: passes_since_last_bid == 0
  CONDITION: s_stopper >= 2
  CONDITION: hcp >= 8

RULE B_2C_2S_3C_1474_0:
  CALL: 3C
  PRIORITY: 20
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '2C'
  CONDITION: opp_last_call == '2S'
  CONDITION: passes_since_last_bid == 0
  CONDITION: c_is_best_minor == True
  CONDITION: club_len >= 6
  CONDITION: hcp >= 7

RULE B_2C_2S_3C_1474_1:
  CALL: 3C
  PRIORITY: 20
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '2C'
  CONDITION: opp_last_call == '2S'
  CONDITION: passes_since_last_bid == 0
  CONDITION: c_is_best_minor == True
  CONDITION: club_len >= 5
  CONDITION: hcp >= 8

RULE B_2C_2S_3D_1475_0:
  CALL: 3D
  PRIORITY: 20
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '2C'
  CONDITION: opp_last_call == '2S'
  CONDITION: passes_since_last_bid == 0
  CONDITION: d_is_best_minor == True
  CONDITION: diamond_len >= 6
  CONDITION: hcp >= 7

RULE B_2C_2S_3D_1475_1:
  CALL: 3D
  PRIORITY: 20
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '2C'
  CONDITION: opp_last_call == '2S'
  CONDITION: passes_since_last_bid == 0
  CONDITION: d_is_best_minor == True
  CONDITION: diamond_len >= 5
  CONDITION: hcp >= 8

RULE B_2C_2S_3H_1476_0:
  CALL: 3H
  PRIORITY: 70
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '2C'
  CONDITION: opp_last_call == '2S'
  CONDITION: passes_since_last_bid == 0
  CONDITION: heart_len >= 5
  CONDITION: hcp >= 8

RULE B_2C_2S_X_1478_0:
  CALL: X
  PRIORITY: 30
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '2C'
  CONDITION: opp_last_call == '2S'
  CONDITION: passes_since_last_bid == 0
  CONDITION: spade_len >= 5

RULE B_2C_3C_PASS_1479_0:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '2C'
  CONDITION: opp_last_call == '3C'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp <= 7

RULE B_2C_3C_X_1482_0:
  CALL: X
  PRIORITY: 30
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '2C'
  CONDITION: opp_last_call == '3C'
  CONDITION: passes_since_last_bid == 0
  CONDITION: club_len >= 5

RULE B_2C_3H_PASS_1483_0:
  CALL: PASS
  PRIORITY: 90
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '2C'
  CONDITION: opp_last_call == '3H'
  CONDITION: passes_since_last_bid == 0

RULE B_2C_3S_PASS_1488_0:
  CALL: PASS
  PRIORITY: 90
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '2C'
  CONDITION: opp_last_call == '3S'
  CONDITION: passes_since_last_bid == 0

RULE B_2C_4D_PASS_1493_0:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '2C'
  CONDITION: opp_last_call == '4D'
  CONDITION: passes_since_last_bid == 0

RULE B_2C_4H_PASS_1494_0:
  CALL: PASS
  PRIORITY: 20
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '2C'
  CONDITION: opp_last_call == '4H'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 8

RULE B_2C_4H_X_1495_0:
  CALL: X
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '2C'
  CONDITION: opp_last_call == '4H'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp <= 7

RULE B_2C_5D_PASS_1496_0:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '2C'
  CONDITION: opp_last_call == '5D'
  CONDITION: passes_since_last_bid == 0

RULE B_2D_P_PASS_1497_0:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '2D'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 1

RULE B_2D_P_2H_1498_0:
  CALL: 2H
  PRIORITY: 76
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '2D'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 1
  CONDITION: hcp >= 14
  CONDITION: heart_len >= 5

RULE B_2D_P_2S_1499_0:
  CALL: 2S
  PRIORITY: 76
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '2D'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 1
  CONDITION: hcp >= 14
  CONDITION: spade_len >= 5

RULE B_2D_P_2NT_1500_0:
  CALL: 2NT
  PRIORITY: 70
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '2D'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 1
  CONDITION: hcp >= 15

RULE B_2D_P_3D_1502_0:
  CALL: 3D
  PRIORITY: 66
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '2D'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 1
  CONDITION: hcp >= 10
  CONDITION: diamond_len >= 2
  CONDITION: hcp <= 13

RULE B_2D_P_3D_1502_1:
  CALL: 3D
  PRIORITY: 66
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '2D'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 1
  CONDITION: diamond_hcp >= 7
  CONDITION: diamond_len >= 3
  CONDITION: diamond_hcp <= 10

RULE B_2D_P_3NT_1505_0:
  CALL: 3NT
  PRIORITY: 30
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '2D'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 1
  CONDITION: hcp >= 18
  CONDITION: hcp <= 21

RULE B_2D_P_4D_1506_0:
  CALL: 4D
  PRIORITY: 68
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '2D'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 1
  CONDITION: diamond_hcp >= 7
  CONDITION: diamond_len >= 4
  CONDITION: diamond_hcp <= 11

RULE B_2D_P_5D_1516_0:
  CALL: 5D
  PRIORITY: 70
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '2D'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 1
  CONDITION: diamond_hcp >= 7
  CONDITION: diamond_len >= 6

RULE B_2D_P_5D_1516_1:
  CALL: 5D
  PRIORITY: 70
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '2D'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 1
  CONDITION: diamond_len >= 3
  CONDITION: diamond_hcp >= 15

RULE B_2D_P_5D_1516_3:
  CALL: 5D
  PRIORITY: 70
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '2D'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 1
  CONDITION: diamond_hcp >= 7
  CONDITION: diamond_len >= 5
  CONDITION: diamond_hcp <= 13

RULE B_2D_P_6D_1519_0:
  CALL: 6D
  PRIORITY: 45
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '2D'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 1
  CONDITION: diamond_len >= 2
  CONDITION: d_realsolid == True
  CONDITION: losing_trick_count == 1

RULE B_2D_P_7D_1522_0:
  CALL: 7D
  PRIORITY: 46
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '2D'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 1
  CONDITION: diamond_len >= 2
  CONDITION: d_realsolid == True
  CONDITION: losing_trick_count <= 0

RULE B_2D_X_PASS_1525_0:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '2D'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 0

RULE B_2D_X_2H_1526_0:
  CALL: 2H
  PRIORITY: 76
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '2D'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 14
  CONDITION: heart_len >= 5

RULE B_2D_X_2S_1527_0:
  CALL: 2S
  PRIORITY: 76
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '2D'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 14
  CONDITION: spade_len >= 5

RULE B_2D_X_2NT_1528_0:
  CALL: 2NT
  PRIORITY: 70
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '2D'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 15

RULE B_2D_X_3D_1530_0:
  CALL: 3D
  PRIORITY: 66
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '2D'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 10
  CONDITION: diamond_len >= 2
  CONDITION: hcp <= 13

RULE B_2D_X_3D_1530_1:
  CALL: 3D
  PRIORITY: 66
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '2D'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 0
  CONDITION: diamond_hcp >= 7
  CONDITION: diamond_len >= 3
  CONDITION: diamond_hcp <= 10

RULE B_2D_X_3NT_1533_0:
  CALL: 3NT
  PRIORITY: 30
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '2D'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 18
  CONDITION: hcp <= 21

RULE B_2D_X_4D_1535_0:
  CALL: 4D
  PRIORITY: 68
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '2D'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 0
  CONDITION: diamond_hcp >= 7
  CONDITION: diamond_len >= 4
  CONDITION: diamond_hcp <= 11

RULE B_2D_X_5D_1545_0:
  CALL: 5D
  PRIORITY: 70
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '2D'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 0
  CONDITION: diamond_hcp >= 7
  CONDITION: diamond_len >= 6

RULE B_2D_X_5D_1545_1:
  CALL: 5D
  PRIORITY: 70
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '2D'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 0
  CONDITION: diamond_len >= 3
  CONDITION: diamond_hcp >= 15

RULE B_2D_X_5D_1545_5:
  CALL: 5D
  PRIORITY: 70
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '2D'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 0
  CONDITION: diamond_hcp >= 7
  CONDITION: diamond_len >= 5
  CONDITION: diamond_hcp <= 13

RULE B_2D_X_6D_1548_0:
  CALL: 6D
  PRIORITY: 45
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '2D'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 0
  CONDITION: diamond_len >= 2
  CONDITION: d_realsolid == True
  CONDITION: losing_trick_count == 1

RULE B_2D_X_7D_1551_0:
  CALL: 7D
  PRIORITY: 46
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '2D'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 0
  CONDITION: diamond_len >= 2
  CONDITION: d_realsolid == True
  CONDITION: losing_trick_count <= 0

RULE B_2D_2H_PASS_1554_0:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '2D'
  CONDITION: opp_last_call == '2H'
  CONDITION: passes_since_last_bid == 0

RULE B_2D_2H_2NT_1557_0:
  CALL: 2NT
  PRIORITY: 41
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '2D'
  CONDITION: opp_last_call == '2H'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 15
  CONDITION: h_stopper >= 2

RULE B_2D_2H_3D_1559_1:
  CALL: 3D
  PRIORITY: 5
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '2D'
  CONDITION: opp_last_call == '2H'
  CONDITION: passes_since_last_bid == 0
  CONDITION: diamond_len >= 3
  CONDITION: hcp >= 7
  CONDITION: hcp <= 14

RULE B_2D_2H_3H_1560_0:
  CALL: 3H
  PRIORITY: 22
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '2D'
  CONDITION: opp_last_call == '2H'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 17
  CONDITION: diamond_len >= 2

RULE B_2D_2H_3S_1561_0:
  CALL: 3S
  PRIORITY: 20
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '2D'
  CONDITION: opp_last_call == '2H'
  CONDITION: passes_since_last_bid == 0
  CONDITION: total_points >= 20
  CONDITION: spade_len >= 5

RULE B_2D_2H_3NT_1562_0:
  CALL: 3NT
  PRIORITY: 25
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '2D'
  CONDITION: opp_last_call == '2H'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 17
  CONDITION: hcp <= 21
  CONDITION: h_stopper >= 2

RULE B_2D_2H_4D_1563_0:
  CALL: 4D
  PRIORITY: 15
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '2D'
  CONDITION: opp_last_call == '2H'
  CONDITION: passes_since_last_bid == 0
  CONDITION: diamond_len >= 4
  CONDITION: hcp >= 7
  CONDITION: hcp <= 11

RULE B_2D_2H_5D_1569_0:
  CALL: 5D
  PRIORITY: 70
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '2D'
  CONDITION: opp_last_call == '2H'
  CONDITION: passes_since_last_bid == 0
  CONDITION: diamond_len >= 4
  CONDITION: hcp >= 12

RULE B_2D_2H_6D_1572_0:
  CALL: 6D
  PRIORITY: 45
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '2D'
  CONDITION: opp_last_call == '2H'
  CONDITION: passes_since_last_bid == 0
  CONDITION: d_realsolid == True
  CONDITION: losing_trick_count == 1

RULE B_2D_2H_7D_1574_0:
  CALL: 7D
  PRIORITY: 46
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '2D'
  CONDITION: opp_last_call == '2H'
  CONDITION: passes_since_last_bid == 0
  CONDITION: d_realsolid == True
  CONDITION: losing_trick_count <= 0

RULE B_2D_2S_PASS_1578_0:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '2D'
  CONDITION: opp_last_call == '2S'
  CONDITION: passes_since_last_bid == 0

RULE B_2D_2S_2NT_1579_0:
  CALL: 2NT
  PRIORITY: 41
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '2D'
  CONDITION: opp_last_call == '2S'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 15
  CONDITION: s_stopper >= 2

RULE B_2D_2S_3D_1581_1:
  CALL: 3D
  PRIORITY: 5
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '2D'
  CONDITION: opp_last_call == '2S'
  CONDITION: passes_since_last_bid == 0
  CONDITION: diamond_len >= 3
  CONDITION: hcp >= 7
  CONDITION: hcp <= 14

RULE B_2D_2S_3H_1582_0:
  CALL: 3H
  PRIORITY: 20
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '2D'
  CONDITION: opp_last_call == '2S'
  CONDITION: passes_since_last_bid == 0
  CONDITION: total_points >= 20
  CONDITION: heart_len >= 5

RULE B_2D_2S_3S_1583_0:
  CALL: 3S
  PRIORITY: 22
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '2D'
  CONDITION: opp_last_call == '2S'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 17
  CONDITION: diamond_len >= 2

RULE B_2D_2S_3NT_1584_0:
  CALL: 3NT
  PRIORITY: 25
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '2D'
  CONDITION: opp_last_call == '2S'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 17
  CONDITION: hcp <= 21
  CONDITION: s_stopper >= 2

RULE B_2D_2S_4D_1585_0:
  CALL: 4D
  PRIORITY: 15
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '2D'
  CONDITION: opp_last_call == '2S'
  CONDITION: passes_since_last_bid == 0
  CONDITION: diamond_len >= 4
  CONDITION: hcp >= 7
  CONDITION: hcp <= 11

RULE B_2D_2S_5D_1591_0:
  CALL: 5D
  PRIORITY: 70
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '2D'
  CONDITION: opp_last_call == '2S'
  CONDITION: passes_since_last_bid == 0
  CONDITION: diamond_len >= 4
  CONDITION: hcp >= 12

RULE B_2D_2S_6D_1594_0:
  CALL: 6D
  PRIORITY: 45
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '2D'
  CONDITION: opp_last_call == '2S'
  CONDITION: passes_since_last_bid == 0
  CONDITION: d_realsolid == True
  CONDITION: losing_trick_count == 1

RULE B_2D_2S_7D_1596_0:
  CALL: 7D
  PRIORITY: 46
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '2D'
  CONDITION: opp_last_call == '2S'
  CONDITION: passes_since_last_bid == 0
  CONDITION: d_realsolid == True
  CONDITION: losing_trick_count <= 0

RULE B_2D_3C_PASS_1600_0:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '2D'
  CONDITION: opp_last_call == '3C'
  CONDITION: passes_since_last_bid == 0

RULE B_2D_3C_3D_1602_0:
  CALL: 3D
  PRIORITY: 66
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '2D'
  CONDITION: opp_last_call == '3C'
  CONDITION: passes_since_last_bid == 0
  CONDITION: diamond_hcp >= 7
  CONDITION: diamond_len >= 3
  CONDITION: diamond_hcp <= 10

RULE B_2D_3C_3NT_1607_0:
  CALL: 3NT
  PRIORITY: 30
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '2D'
  CONDITION: opp_last_call == '3C'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 18
  CONDITION: hcp <= 21

RULE B_2D_3C_4D_1608_0:
  CALL: 4D
  PRIORITY: 68
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '2D'
  CONDITION: opp_last_call == '3C'
  CONDITION: passes_since_last_bid == 0
  CONDITION: diamond_hcp >= 7
  CONDITION: diamond_len >= 4
  CONDITION: diamond_hcp <= 11

RULE B_2D_3C_5D_1617_2:
  CALL: 5D
  PRIORITY: 70
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '2D'
  CONDITION: opp_last_call == '3C'
  CONDITION: passes_since_last_bid == 0
  CONDITION: diamond_hcp >= 7
  CONDITION: diamond_len >= 5
  CONDITION: diamond_hcp <= 13

RULE B_2D_3C_6D_1620_0:
  CALL: 6D
  PRIORITY: 45
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '2D'
  CONDITION: opp_last_call == '3C'
  CONDITION: passes_since_last_bid == 0
  CONDITION: diamond_len >= 2
  CONDITION: d_realsolid == True
  CONDITION: losing_trick_count == 1

RULE B_2D_3C_7D_1623_0:
  CALL: 7D
  PRIORITY: 46
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '2D'
  CONDITION: opp_last_call == '3C'
  CONDITION: passes_since_last_bid == 0
  CONDITION: diamond_len >= 2
  CONDITION: d_realsolid == True
  CONDITION: losing_trick_count <= 0

RULE B_2D_3D_3NT_1628_0:
  CALL: 3NT
  PRIORITY: 20
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '2D'
  CONDITION: opp_last_call == '3D'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 18
  CONDITION: hcp <= 21
  CONDITION: h_stopper >= 2
  CONDITION: s_stopper >= 2

RULE B_2D_3D_4D_1629_0:
  CALL: 4D
  PRIORITY: 30
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '2D'
  CONDITION: opp_last_call == '3D'
  CONDITION: passes_since_last_bid == 0
  CONDITION: diamond_len >= 3
  CONDITION: hcp <= 10

RULE B_2D_3D_5D_1632_0:
  CALL: 5D
  PRIORITY: 40
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '2D'
  CONDITION: opp_last_call == '3D'
  CONDITION: passes_since_last_bid == 0
  CONDITION: diamond_len >= 2
  CONDITION: hcp >= 18

RULE B_2D_3D_5D_1632_1:
  CALL: 5D
  PRIORITY: 40
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '2D'
  CONDITION: opp_last_call == '3D'
  CONDITION: passes_since_last_bid == 0
  CONDITION: diamond_len >= 4
  CONDITION: hcp >= 10

RULE B_2D_3D_6C_1636_0:
  CALL: 6C
  PRIORITY: 65
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '2D'
  CONDITION: opp_last_call == '3D'
  CONDITION: passes_since_last_bid == 0
  CONDITION: c_realsolid == True
  CONDITION: losing_trick_count == 1

RULE B_2D_3D_6D_1639_0:
  CALL: 6D
  PRIORITY: 65
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '2D'
  CONDITION: opp_last_call == '3D'
  CONDITION: passes_since_last_bid == 0
  CONDITION: d_realsolid == True
  CONDITION: losing_trick_count == 1

RULE B_2D_3D_7C_1641_0:
  CALL: 7C
  PRIORITY: 66
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '2D'
  CONDITION: opp_last_call == '3D'
  CONDITION: passes_since_last_bid == 0
  CONDITION: c_realsolid == True
  CONDITION: losing_trick_count <= 0

RULE B_2D_3D_7D_1643_0:
  CALL: 7D
  PRIORITY: 66
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '2D'
  CONDITION: opp_last_call == '3D'
  CONDITION: passes_since_last_bid == 0
  CONDITION: d_realsolid == True
  CONDITION: losing_trick_count <= 0

RULE B_2D_3H_PASS_1647_0:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '2D'
  CONDITION: opp_last_call == '3H'
  CONDITION: passes_since_last_bid == 0

RULE B_2D_3H_3NT_1648_0:
  CALL: 3NT
  PRIORITY: 30
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '2D'
  CONDITION: opp_last_call == '3H'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 18
  CONDITION: hcp <= 21

RULE B_2D_3H_4D_1649_0:
  CALL: 4D
  PRIORITY: 68
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '2D'
  CONDITION: opp_last_call == '3H'
  CONDITION: passes_since_last_bid == 0
  CONDITION: diamond_hcp >= 7
  CONDITION: diamond_len >= 4
  CONDITION: diamond_hcp <= 11

RULE B_2D_3H_5D_1652_2:
  CALL: 5D
  PRIORITY: 70
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '2D'
  CONDITION: opp_last_call == '3H'
  CONDITION: passes_since_last_bid == 0
  CONDITION: diamond_hcp >= 7
  CONDITION: diamond_len >= 5
  CONDITION: diamond_hcp <= 13

RULE B_2D_3H_6D_1655_0:
  CALL: 6D
  PRIORITY: 45
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '2D'
  CONDITION: opp_last_call == '3H'
  CONDITION: passes_since_last_bid == 0
  CONDITION: diamond_len >= 2
  CONDITION: d_realsolid == True
  CONDITION: losing_trick_count == 1

RULE B_2D_3H_7D_1658_0:
  CALL: 7D
  PRIORITY: 46
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '2D'
  CONDITION: opp_last_call == '3H'
  CONDITION: passes_since_last_bid == 0
  CONDITION: diamond_len >= 2
  CONDITION: d_realsolid == True
  CONDITION: losing_trick_count <= 0

RULE B_2D_3S_PASS_1661_0:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '2D'
  CONDITION: opp_last_call == '3S'
  CONDITION: passes_since_last_bid == 0

RULE B_2D_3S_3NT_1662_0:
  CALL: 3NT
  PRIORITY: 30
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '2D'
  CONDITION: opp_last_call == '3S'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 18
  CONDITION: hcp <= 21

RULE B_2D_3S_4D_1663_0:
  CALL: 4D
  PRIORITY: 68
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '2D'
  CONDITION: opp_last_call == '3S'
  CONDITION: passes_since_last_bid == 0
  CONDITION: diamond_hcp >= 7
  CONDITION: diamond_len >= 4
  CONDITION: diamond_hcp <= 11

RULE B_2D_3S_5D_1666_2:
  CALL: 5D
  PRIORITY: 70
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '2D'
  CONDITION: opp_last_call == '3S'
  CONDITION: passes_since_last_bid == 0
  CONDITION: diamond_hcp >= 7
  CONDITION: diamond_len >= 5
  CONDITION: diamond_hcp <= 13

RULE B_2D_3S_6D_1669_0:
  CALL: 6D
  PRIORITY: 45
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '2D'
  CONDITION: opp_last_call == '3S'
  CONDITION: passes_since_last_bid == 0
  CONDITION: diamond_len >= 2
  CONDITION: d_realsolid == True
  CONDITION: losing_trick_count == 1

RULE B_2D_3S_7D_1672_0:
  CALL: 7D
  PRIORITY: 46
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '2D'
  CONDITION: opp_last_call == '3S'
  CONDITION: passes_since_last_bid == 0
  CONDITION: diamond_len >= 2
  CONDITION: d_realsolid == True
  CONDITION: losing_trick_count <= 0

RULE B_2D_4C_PASS_1675_0:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '2D'
  CONDITION: opp_last_call == '4C'
  CONDITION: passes_since_last_bid == 0

RULE B_2D_4C_4D_1677_0:
  CALL: 4D
  PRIORITY: 68
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '2D'
  CONDITION: opp_last_call == '4C'
  CONDITION: passes_since_last_bid == 0
  CONDITION: diamond_hcp >= 7
  CONDITION: diamond_len >= 4
  CONDITION: diamond_hcp <= 11

RULE B_2D_4C_5D_1681_2:
  CALL: 5D
  PRIORITY: 70
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '2D'
  CONDITION: opp_last_call == '4C'
  CONDITION: passes_since_last_bid == 0
  CONDITION: diamond_hcp >= 7
  CONDITION: diamond_len >= 5
  CONDITION: diamond_hcp <= 13

RULE B_2D_4C_6D_1684_0:
  CALL: 6D
  PRIORITY: 45
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '2D'
  CONDITION: opp_last_call == '4C'
  CONDITION: passes_since_last_bid == 0
  CONDITION: diamond_len >= 2
  CONDITION: d_realsolid == True
  CONDITION: losing_trick_count == 1

RULE B_2D_4C_7D_1687_0:
  CALL: 7D
  PRIORITY: 46
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '2D'
  CONDITION: opp_last_call == '4C'
  CONDITION: passes_since_last_bid == 0
  CONDITION: diamond_len >= 2
  CONDITION: d_realsolid == True
  CONDITION: losing_trick_count <= 0

RULE B_2D_4H_PASS_1690_0:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '2D'
  CONDITION: opp_last_call == '4H'
  CONDITION: passes_since_last_bid == 0

RULE B_2D_4H_5D_1698_2:
  CALL: 5D
  PRIORITY: 70
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '2D'
  CONDITION: opp_last_call == '4H'
  CONDITION: passes_since_last_bid == 0
  CONDITION: diamond_hcp >= 7
  CONDITION: diamond_len >= 5
  CONDITION: diamond_hcp <= 13

RULE B_2D_4H_6D_1702_0:
  CALL: 6D
  PRIORITY: 45
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '2D'
  CONDITION: opp_last_call == '4H'
  CONDITION: passes_since_last_bid == 0
  CONDITION: diamond_len >= 2
  CONDITION: d_realsolid == True
  CONDITION: losing_trick_count == 1

RULE B_2D_4H_7D_1705_0:
  CALL: 7D
  PRIORITY: 46
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '2D'
  CONDITION: opp_last_call == '4H'
  CONDITION: passes_since_last_bid == 0
  CONDITION: diamond_len >= 2
  CONDITION: d_realsolid == True
  CONDITION: losing_trick_count <= 0

RULE B_2D_4S_PASS_1709_0:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '2D'
  CONDITION: opp_last_call == '4S'
  CONDITION: passes_since_last_bid == 0

RULE B_2D_4S_5D_1712_2:
  CALL: 5D
  PRIORITY: 70
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '2D'
  CONDITION: opp_last_call == '4S'
  CONDITION: passes_since_last_bid == 0
  CONDITION: diamond_hcp >= 7
  CONDITION: diamond_len >= 5
  CONDITION: diamond_hcp <= 13

RULE B_2D_4S_6D_1716_0:
  CALL: 6D
  PRIORITY: 45
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '2D'
  CONDITION: opp_last_call == '4S'
  CONDITION: passes_since_last_bid == 0
  CONDITION: diamond_len >= 2
  CONDITION: d_realsolid == True
  CONDITION: losing_trick_count == 1

RULE B_2D_4S_7D_1719_0:
  CALL: 7D
  PRIORITY: 46
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '2D'
  CONDITION: opp_last_call == '4S'
  CONDITION: passes_since_last_bid == 0
  CONDITION: diamond_len >= 2
  CONDITION: d_realsolid == True
  CONDITION: losing_trick_count <= 0

RULE B_2D_6C_PASS_1723_0:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '2D'
  CONDITION: opp_last_call == '6C'
  CONDITION: passes_since_last_bid == 0

RULE B_2D_6H_PASS_1724_0:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '2D'
  CONDITION: opp_last_call == '6H'
  CONDITION: passes_since_last_bid == 0

RULE B_2D_2N_PASS_1725_0:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '2D'
  CONDITION: opp_last_call == '2NT'
  CONDITION: passes_since_last_bid == 0

RULE B_2D_2N_3D_1728_0:
  CALL: 3D
  PRIORITY: 66
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '2D'
  CONDITION: opp_last_call == '2NT'
  CONDITION: passes_since_last_bid == 0
  CONDITION: diamond_hcp >= 7
  CONDITION: diamond_len >= 3
  CONDITION: diamond_hcp <= 10

RULE B_2D_2N_3NT_1735_0:
  CALL: 3NT
  PRIORITY: 30
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '2D'
  CONDITION: opp_last_call == '2NT'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 18
  CONDITION: hcp <= 21

RULE B_2D_2N_4D_1736_0:
  CALL: 4D
  PRIORITY: 68
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '2D'
  CONDITION: opp_last_call == '2NT'
  CONDITION: passes_since_last_bid == 0
  CONDITION: diamond_hcp >= 7
  CONDITION: diamond_len >= 4
  CONDITION: diamond_hcp <= 11

RULE B_2D_2N_5D_1742_0:
  CALL: 5D
  PRIORITY: 70
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '2D'
  CONDITION: opp_last_call == '2NT'
  CONDITION: passes_since_last_bid == 0
  CONDITION: diamond_hcp >= 7
  CONDITION: diamond_len >= 6

RULE B_2D_2N_5D_1742_3:
  CALL: 5D
  PRIORITY: 70
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '2D'
  CONDITION: opp_last_call == '2NT'
  CONDITION: passes_since_last_bid == 0
  CONDITION: diamond_hcp >= 7
  CONDITION: diamond_len >= 5
  CONDITION: diamond_hcp <= 13

RULE B_2D_2N_6D_1745_0:
  CALL: 6D
  PRIORITY: 45
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '2D'
  CONDITION: opp_last_call == '2NT'
  CONDITION: passes_since_last_bid == 0
  CONDITION: diamond_len >= 2
  CONDITION: d_realsolid == True
  CONDITION: losing_trick_count == 1

RULE B_2D_2N_7D_1748_0:
  CALL: 7D
  PRIORITY: 46
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '2D'
  CONDITION: opp_last_call == '2NT'
  CONDITION: passes_since_last_bid == 0
  CONDITION: diamond_len >= 2
  CONDITION: d_realsolid == True
  CONDITION: losing_trick_count <= 0

RULE B_2D_3N_PASS_1752_0:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '2D'
  CONDITION: opp_last_call == '3NT'
  CONDITION: passes_since_last_bid == 0

RULE B_2D_3N_4D_1754_0:
  CALL: 4D
  PRIORITY: 68
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '2D'
  CONDITION: opp_last_call == '3NT'
  CONDITION: passes_since_last_bid == 0
  CONDITION: diamond_hcp >= 7
  CONDITION: diamond_len >= 4
  CONDITION: diamond_hcp <= 11

RULE B_2D_3N_5D_1758_2:
  CALL: 5D
  PRIORITY: 70
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '2D'
  CONDITION: opp_last_call == '3NT'
  CONDITION: passes_since_last_bid == 0
  CONDITION: diamond_hcp >= 7
  CONDITION: diamond_len >= 5
  CONDITION: diamond_hcp <= 13

RULE B_2D_3N_6D_1761_0:
  CALL: 6D
  PRIORITY: 45
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '2D'
  CONDITION: opp_last_call == '3NT'
  CONDITION: passes_since_last_bid == 0
  CONDITION: diamond_len >= 2
  CONDITION: d_realsolid == True
  CONDITION: losing_trick_count == 1

RULE B_2D_3N_7D_1764_0:
  CALL: 7D
  PRIORITY: 46
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '2D'
  CONDITION: opp_last_call == '3NT'
  CONDITION: passes_since_last_bid == 0
  CONDITION: diamond_len >= 2
  CONDITION: d_realsolid == True
  CONDITION: losing_trick_count <= 0

RULE B_2H_P_2S_1769_0:
  CALL: 2S
  PRIORITY: 68
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '2H'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 1
  CONDITION: hcp >= 13
  CONDITION: spade_len >= 5
  CONDITION: s_is_longest == True
  CONDITION: heart_len <= 1

RULE B_2H_P_2NT_1770_0:
  CALL: 2NT
  PRIORITY: 60
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '2H'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 1
  CONDITION: hcp >= 15

RULE B_2H_P_2NT_1770_1:
  CALL: 2NT
  PRIORITY: 60
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '2H'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 1
  CONDITION: hcp >= 13
  CONDITION: controls >= 5

RULE B_2H_P_3C_1771_0:
  CALL: 3C
  PRIORITY: 22
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '2H'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 1
  CONDITION: c_is_best_minor == True
  CONDITION: club_len >= 5
  CONDITION: hcp >= 17

RULE B_2H_P_3D_1772_0:
  CALL: 3D
  PRIORITY: 22
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '2H'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 1
  CONDITION: d_is_best_minor == True
  CONDITION: diamond_len >= 5
  CONDITION: hcp >= 17

RULE B_2H_P_3H_1773_0:
  CALL: 3H
  PRIORITY: 40
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '2H'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 1
  CONDITION: heart_hcp >= 6
  CONDITION: hcp <= 9
  CONDITION: heart_len >= 3

RULE B_2H_P_6H_1782_0:
  CALL: 6H
  PRIORITY: 105
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '2H'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 1
  CONDITION: heart_len >= 2
  CONDITION: h_realsolid == True
  CONDITION: losing_trick_count == 1

RULE B_2H_P_7H_1784_0:
  CALL: 7H
  PRIORITY: 106
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '2H'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 1
  CONDITION: heart_len >= 2
  CONDITION: h_realsolid == True
  CONDITION: losing_trick_count <= 0

RULE B_2H_2S_PASS_1787_0:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '2H'
  CONDITION: opp_last_call == '2S'
  CONDITION: passes_since_last_bid == 0

RULE B_2H_2S_2NT_1788_0:
  CALL: 2NT
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '2H'
  CONDITION: opp_last_call == '2S'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 16
  CONDITION: s_stopper >= 2
  CONDITION: hcp <= 19

RULE B_2H_2S_3H_1793_1:
  CALL: 3H
  PRIORITY: 25
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '2H'
  CONDITION: opp_last_call == '2S'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 3
  CONDITION: hcp <= 11
  CONDITION: heart_len <= 3

RULE B_2H_2S_3H_1793_2:
  CALL: 3H
  PRIORITY: 25
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '2H'
  CONDITION: opp_last_call == '2S'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 7
  CONDITION: hcp <= 11
  CONDITION: heart_len >= 2

RULE B_2H_2S_4H_1795_0:
  CALL: 4H
  PRIORITY: 43
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '2H'
  CONDITION: opp_last_call == '2S'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 12
  CONDITION: heart_len >= 3

RULE B_2H_2S_6H_1802_0:
  CALL: 6H
  PRIORITY: 55
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '2H'
  CONDITION: opp_last_call == '2S'
  CONDITION: passes_since_last_bid == 0
  CONDITION: heart_len >= 2
  CONDITION: h_realsolid == True
  CONDITION: losing_trick_count == 1

RULE B_2H_2S_7H_1804_0:
  CALL: 7H
  PRIORITY: 56
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '2H'
  CONDITION: opp_last_call == '2S'
  CONDITION: passes_since_last_bid == 0
  CONDITION: heart_len >= 2
  CONDITION: h_realsolid == True
  CONDITION: losing_trick_count <= 0

RULE B_2H_3C_PASS_1808_0:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '2H'
  CONDITION: opp_last_call == '3C'
  CONDITION: passes_since_last_bid == 0

RULE B_2H_3C_3H_1811_0:
  CALL: 3H
  PRIORITY: 12
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '2H'
  CONDITION: opp_last_call == '3C'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 3
  CONDITION: hcp <= 9
  CONDITION: heart_len >= 2
  CONDITION: heart_len <= 4

RULE B_2H_3C_3S_1812_0:
  CALL: 3S
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '2H'
  CONDITION: opp_last_call == '3C'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 15
  CONDITION: spade_len >= 5

RULE B_2H_3C_4H_1815_0:
  CALL: 4H
  PRIORITY: 30
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '2H'
  CONDITION: opp_last_call == '3C'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 14
  CONDITION: heart_len >= 2

RULE B_2H_3C_4H_1815_1:
  CALL: 4H
  PRIORITY: 30
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '2H'
  CONDITION: opp_last_call == '3C'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 12
  CONDITION: heart_len >= 3

RULE B_2H_3C_6H_1823_0:
  CALL: 6H
  PRIORITY: 65
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '2H'
  CONDITION: opp_last_call == '3C'
  CONDITION: passes_since_last_bid == 0
  CONDITION: h_realsolid == True
  CONDITION: losing_trick_count == 1

RULE B_2H_3C_7H_1825_0:
  CALL: 7H
  PRIORITY: 66
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '2H'
  CONDITION: opp_last_call == '3C'
  CONDITION: passes_since_last_bid == 0
  CONDITION: h_realsolid == True
  CONDITION: losing_trick_count <= 0

RULE B_2H_3D_PASS_1829_0:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '2H'
  CONDITION: opp_last_call == '3D'
  CONDITION: passes_since_last_bid == 0

RULE B_2H_3D_3H_1831_0:
  CALL: 3H
  PRIORITY: 12
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '2H'
  CONDITION: opp_last_call == '3D'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 3
  CONDITION: hcp <= 9
  CONDITION: heart_len >= 2
  CONDITION: heart_len <= 4

RULE B_2H_3D_3S_1832_0:
  CALL: 3S
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '2H'
  CONDITION: opp_last_call == '3D'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 15
  CONDITION: spade_len >= 5

RULE B_2H_3D_4H_1835_0:
  CALL: 4H
  PRIORITY: 30
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '2H'
  CONDITION: opp_last_call == '3D'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 14
  CONDITION: heart_len >= 2

RULE B_2H_3D_4H_1835_1:
  CALL: 4H
  PRIORITY: 30
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '2H'
  CONDITION: opp_last_call == '3D'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 12
  CONDITION: heart_len >= 3

RULE B_2H_3D_6H_1841_0:
  CALL: 6H
  PRIORITY: 65
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '2H'
  CONDITION: opp_last_call == '3D'
  CONDITION: passes_since_last_bid == 0
  CONDITION: h_realsolid == True
  CONDITION: losing_trick_count == 1

RULE B_2H_3D_7H_1843_0:
  CALL: 7H
  PRIORITY: 66
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '2H'
  CONDITION: opp_last_call == '3D'
  CONDITION: passes_since_last_bid == 0
  CONDITION: h_realsolid == True
  CONDITION: losing_trick_count <= 0

RULE B_2H_3H_4H_1849_0:
  CALL: 4H
  PRIORITY: 70
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '2H'
  CONDITION: opp_last_call == '3H'
  CONDITION: passes_since_last_bid == 0
  CONDITION: heart_len >= 3
  CONDITION: hcp >= 14

RULE B_2H_3H_6D_1853_0:
  CALL: 6D
  PRIORITY: 65
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '2H'
  CONDITION: opp_last_call == '3H'
  CONDITION: passes_since_last_bid == 0
  CONDITION: heart_len >= 2
  CONDITION: d_realsolid == True
  CONDITION: losing_trick_count == 1

RULE B_2H_3H_7D_1855_0:
  CALL: 7D
  PRIORITY: 66
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '2H'
  CONDITION: opp_last_call == '3H'
  CONDITION: passes_since_last_bid == 0
  CONDITION: heart_len >= 2
  CONDITION: d_realsolid == True
  CONDITION: losing_trick_count <= 0

RULE B_2H_3S_PASS_1858_0:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '2H'
  CONDITION: opp_last_call == '3S'
  CONDITION: passes_since_last_bid == 0

RULE B_2H_3S_4H_1861_0:
  CALL: 4H
  PRIORITY: 70
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '2H'
  CONDITION: opp_last_call == '3S'
  CONDITION: passes_since_last_bid == 0
  CONDITION: heart_len >= 4
  CONDITION: hcp >= 6

RULE B_2H_4C_PASS_1863_0:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '2H'
  CONDITION: opp_last_call == '4C'
  CONDITION: passes_since_last_bid == 0

RULE B_2H_4C_4H_1864_0:
  CALL: 4H
  PRIORITY: 70
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '2H'
  CONDITION: opp_last_call == '4C'
  CONDITION: passes_since_last_bid == 0
  CONDITION: heart_len >= 4
  CONDITION: hcp >= 6

RULE B_2H_4H_PASS_1865_0:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '2H'
  CONDITION: opp_last_call == '4H'
  CONDITION: passes_since_last_bid == 0

RULE B_2H_4S_6H_1873_0:
  CALL: 6H
  PRIORITY: 65
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '2H'
  CONDITION: opp_last_call == '4S'
  CONDITION: passes_since_last_bid == 0
  CONDITION: heart_len >= 2
  CONDITION: h_realsolid == True
  CONDITION: losing_trick_count == 1

RULE B_2H_4S_7H_1875_0:
  CALL: 7H
  PRIORITY: 66
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '2H'
  CONDITION: opp_last_call == '4S'
  CONDITION: passes_since_last_bid == 0
  CONDITION: heart_len >= 2
  CONDITION: h_realsolid == True
  CONDITION: losing_trick_count <= 0

RULE B_2H_6C_PASS_1879_0:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '2H'
  CONDITION: opp_last_call == '6C'
  CONDITION: passes_since_last_bid == 0

RULE B_2H_6S_PASS_1880_0:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '2H'
  CONDITION: opp_last_call == '6S'
  CONDITION: passes_since_last_bid == 0

RULE B_2H_7C_PASS_1881_0:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '2H'
  CONDITION: opp_last_call == '7C'
  CONDITION: passes_since_last_bid == 0

RULE B_2H_2N_PASS_1882_0:
  CALL: PASS
  PRIORITY: 20
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '2H'
  CONDITION: opp_last_call == '2NT'
  CONDITION: passes_since_last_bid == 0

RULE B_2H_3N_PASS_1893_0:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '2H'
  CONDITION: opp_last_call == '3NT'
  CONDITION: passes_since_last_bid == 0

RULE B_2H_4N_PASS_1899_0:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '2H'
  CONDITION: opp_last_call == '4NT'
  CONDITION: passes_since_last_bid == 0

RULE B_2S_P_2NT_1903_0:
  CALL: 2NT
  PRIORITY: 60
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '2S'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 1
  CONDITION: hcp >= 15

RULE B_2S_P_2NT_1903_1:
  CALL: 2NT
  PRIORITY: 60
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '2S'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 1
  CONDITION: hcp >= 13
  CONDITION: controls >= 5

RULE B_2S_P_3C_1904_0:
  CALL: 3C
  PRIORITY: 22
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '2S'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 1
  CONDITION: c_is_best_minor == True
  CONDITION: club_len >= 5
  CONDITION: hcp >= 17

RULE B_2S_P_3D_1905_0:
  CALL: 3D
  PRIORITY: 22
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '2S'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 1
  CONDITION: d_is_best_minor == True
  CONDITION: diamond_len >= 5
  CONDITION: hcp >= 17

RULE B_2S_P_3H_1906_0:
  CALL: 3H
  PRIORITY: 69
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '2S'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 1
  CONDITION: hcp >= 17
  CONDITION: heart_len >= 6

RULE B_2S_P_3S_1907_0:
  CALL: 3S
  PRIORITY: 40
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '2S'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 1
  CONDITION: spade_hcp >= 6
  CONDITION: hcp <= 9
  CONDITION: spade_len >= 3

RULE B_2S_P_6S_1915_0:
  CALL: 6S
  PRIORITY: 105
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '2S'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 1
  CONDITION: spade_len >= 2
  CONDITION: s_realsolid == True
  CONDITION: losing_trick_count == 1

RULE B_2S_P_7S_1917_0:
  CALL: 7S
  PRIORITY: 106
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '2S'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 1
  CONDITION: spade_len >= 2
  CONDITION: s_realsolid == True
  CONDITION: losing_trick_count <= 0

RULE B_2S_3C_PASS_1920_0:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '2S'
  CONDITION: opp_last_call == '3C'
  CONDITION: passes_since_last_bid == 0

RULE B_2S_3C_3H_1922_0:
  CALL: 3H
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '2S'
  CONDITION: opp_last_call == '3C'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 15
  CONDITION: heart_len >= 5

RULE B_2S_3C_3S_1924_0:
  CALL: 3S
  PRIORITY: 12
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '2S'
  CONDITION: opp_last_call == '3C'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 3
  CONDITION: hcp <= 9
  CONDITION: spade_len >= 2
  CONDITION: spade_len <= 4

RULE B_2S_3C_4S_1928_0:
  CALL: 4S
  PRIORITY: 30
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '2S'
  CONDITION: opp_last_call == '3C'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 14
  CONDITION: spade_len >= 2

RULE B_2S_3C_4S_1928_1:
  CALL: 4S
  PRIORITY: 30
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '2S'
  CONDITION: opp_last_call == '3C'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 12
  CONDITION: spade_len >= 3

RULE B_2S_3C_6S_1935_0:
  CALL: 6S
  PRIORITY: 65
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '2S'
  CONDITION: opp_last_call == '3C'
  CONDITION: passes_since_last_bid == 0
  CONDITION: s_realsolid == True
  CONDITION: losing_trick_count == 1

RULE B_2S_3C_7S_1937_0:
  CALL: 7S
  PRIORITY: 66
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '2S'
  CONDITION: opp_last_call == '3C'
  CONDITION: passes_since_last_bid == 0
  CONDITION: s_realsolid == True
  CONDITION: losing_trick_count <= 0

RULE B_2S_3D_PASS_1941_0:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '2S'
  CONDITION: opp_last_call == '3D'
  CONDITION: passes_since_last_bid == 0

RULE B_2S_3D_3H_1942_0:
  CALL: 3H
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '2S'
  CONDITION: opp_last_call == '3D'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 15
  CONDITION: heart_len >= 5

RULE B_2S_3D_3S_1944_0:
  CALL: 3S
  PRIORITY: 12
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '2S'
  CONDITION: opp_last_call == '3D'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 3
  CONDITION: hcp <= 9
  CONDITION: spade_len >= 2
  CONDITION: spade_len <= 4

RULE B_2S_3D_4S_1948_0:
  CALL: 4S
  PRIORITY: 30
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '2S'
  CONDITION: opp_last_call == '3D'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 14
  CONDITION: spade_len >= 2

RULE B_2S_3D_4S_1948_1:
  CALL: 4S
  PRIORITY: 30
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '2S'
  CONDITION: opp_last_call == '3D'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 12
  CONDITION: spade_len >= 3

RULE B_2S_3D_6S_1953_0:
  CALL: 6S
  PRIORITY: 65
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '2S'
  CONDITION: opp_last_call == '3D'
  CONDITION: passes_since_last_bid == 0
  CONDITION: s_realsolid == True
  CONDITION: losing_trick_count == 1

RULE B_2S_3D_7S_1955_0:
  CALL: 7S
  PRIORITY: 66
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '2S'
  CONDITION: opp_last_call == '3D'
  CONDITION: passes_since_last_bid == 0
  CONDITION: s_realsolid == True
  CONDITION: losing_trick_count <= 0

RULE B_2S_3H_PASS_1959_0:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '2S'
  CONDITION: opp_last_call == '3H'
  CONDITION: passes_since_last_bid == 0

RULE B_2S_3H_3S_1961_0:
  CALL: 3S
  PRIORITY: 40
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '2S'
  CONDITION: opp_last_call == '3H'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 3
  CONDITION: hcp <= 9
  CONDITION: spade_len >= 2
  CONDITION: spade_len <= 3

RULE B_2S_3H_3S_1961_1:
  CALL: 3S
  PRIORITY: 40
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '2S'
  CONDITION: opp_last_call == '3H'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 3
  CONDITION: hcp <= 12
  CONDITION: spade_len >= 2
  CONDITION: spade_len <= 3

RULE B_2S_3H_4H_1967_0:
  CALL: 4H
  PRIORITY: 43
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '2S'
  CONDITION: opp_last_call == '3H'
  CONDITION: passes_since_last_bid == 0
  CONDITION: spade_len >= 2
  CONDITION: hcp >= 18

RULE B_2S_3H_4S_1969_1:
  CALL: 4S
  PRIORITY: 30
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '2S'
  CONDITION: opp_last_call == '3H'
  CONDITION: passes_since_last_bid == 0
  CONDITION: spade_len >= 2
  CONDITION: hcp >= 13

RULE B_2S_3H_6S_1974_0:
  CALL: 6S
  PRIORITY: 55
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '2S'
  CONDITION: opp_last_call == '3H'
  CONDITION: passes_since_last_bid == 0
  CONDITION: s_realsolid == True
  CONDITION: losing_trick_count == 1

RULE B_2S_3H_7S_1976_0:
  CALL: 7S
  PRIORITY: 56
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '2S'
  CONDITION: opp_last_call == '3H'
  CONDITION: passes_since_last_bid == 0
  CONDITION: s_realsolid == True
  CONDITION: losing_trick_count <= 0

RULE B_2S_3S_4S_1982_0:
  CALL: 4S
  PRIORITY: 70
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '2S'
  CONDITION: opp_last_call == '3S'
  CONDITION: passes_since_last_bid == 0
  CONDITION: spade_len >= 3
  CONDITION: hcp >= 14

RULE B_2S_3S_6D_1986_0:
  CALL: 6D
  PRIORITY: 65
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '2S'
  CONDITION: opp_last_call == '3S'
  CONDITION: passes_since_last_bid == 0
  CONDITION: spade_len >= 2
  CONDITION: d_realsolid == True
  CONDITION: losing_trick_count == 1

RULE B_2S_3S_7D_1988_0:
  CALL: 7D
  PRIORITY: 66
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '2S'
  CONDITION: opp_last_call == '3S'
  CONDITION: passes_since_last_bid == 0
  CONDITION: spade_len >= 2
  CONDITION: d_realsolid == True
  CONDITION: losing_trick_count <= 0

RULE B_2S_4C_PASS_1991_0:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '2S'
  CONDITION: opp_last_call == '4C'
  CONDITION: passes_since_last_bid == 0

RULE B_2S_4C_4S_1992_0:
  CALL: 4S
  PRIORITY: 70
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '2S'
  CONDITION: opp_last_call == '4C'
  CONDITION: passes_since_last_bid == 0
  CONDITION: spade_len >= 4
  CONDITION: hcp >= 6

RULE B_2S_4H_PASS_1993_0:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '2S'
  CONDITION: opp_last_call == '4H'
  CONDITION: passes_since_last_bid == 0

RULE B_2S_4H_4S_1995_1:
  CALL: 4S
  PRIORITY: 30
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '2S'
  CONDITION: opp_last_call == '4H'
  CONDITION: passes_since_last_bid == 0
  CONDITION: spade_len >= 2
  CONDITION: hcp >= 13

RULE B_2S_4H_6S_2002_0:
  CALL: 6S
  PRIORITY: 55
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '2S'
  CONDITION: opp_last_call == '4H'
  CONDITION: passes_since_last_bid == 0
  CONDITION: s_realsolid == True
  CONDITION: losing_trick_count == 1

RULE B_2S_4H_7S_2004_0:
  CALL: 7S
  PRIORITY: 56
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '2S'
  CONDITION: opp_last_call == '4H'
  CONDITION: passes_since_last_bid == 0
  CONDITION: s_realsolid == True
  CONDITION: losing_trick_count <= 0

RULE B_2S_2N_PASS_2008_0:
  CALL: PASS
  PRIORITY: 20
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '2S'
  CONDITION: opp_last_call == '2NT'
  CONDITION: passes_since_last_bid == 0

RULE B_2S_3N_PASS_2019_0:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '2S'
  CONDITION: opp_last_call == '3NT'
  CONDITION: passes_since_last_bid == 0

RULE B_2S_4N_PASS_2025_0:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '2S'
  CONDITION: opp_last_call == '4NT'
  CONDITION: passes_since_last_bid == 0

RULE B_3C_P_PASS_2028_0:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '3C'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 1

RULE B_3C_P_4C_2036_0:
  CALL: 4C
  PRIORITY: 20
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '3C'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 1
  CONDITION: club_len >= 2
  CONDITION: hcp <= 10
  CONDITION: club_hcp >= 6

RULE B_3C_P_5C_2045_0:
  CALL: 5C
  PRIORITY: 70
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '3C'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 1
  CONDITION: hcp >= 18
  CONDITION: club_len >= 1

RULE B_3C_P_6C_2049_0:
  CALL: 6C
  PRIORITY: 45
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '3C'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 1
  CONDITION: c_realsolid == True
  CONDITION: losing_trick_count == 1

RULE B_3C_P_7C_2051_0:
  CALL: 7C
  PRIORITY: 46
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '3C'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 1
  CONDITION: c_realsolid == True
  CONDITION: losing_trick_count <= 0

RULE B_3C_X_PASS_2054_0:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '3C'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 0

RULE B_3C_X_4C_2062_0:
  CALL: 4C
  PRIORITY: 20
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '3C'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 0
  CONDITION: club_len >= 2
  CONDITION: hcp <= 10
  CONDITION: club_hcp >= 6

RULE B_3C_X_5C_2071_0:
  CALL: 5C
  PRIORITY: 70
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '3C'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 18
  CONDITION: club_len >= 1

RULE B_3C_X_6C_2076_0:
  CALL: 6C
  PRIORITY: 45
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '3C'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 0
  CONDITION: c_realsolid == True
  CONDITION: losing_trick_count == 1

RULE B_3C_X_7C_2078_0:
  CALL: 7C
  PRIORITY: 46
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '3C'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 0
  CONDITION: c_realsolid == True
  CONDITION: losing_trick_count <= 0

RULE B_3C_3D_PASS_2081_0:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '3C'
  CONDITION: opp_last_call == '3D'
  CONDITION: passes_since_last_bid == 0
  CONDITION: club_len <= 3

RULE B_3C_3D_PASS_2081_1:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '3C'
  CONDITION: opp_last_call == '3D'
  CONDITION: passes_since_last_bid == 0
  CONDITION: club_hcp <= 5

RULE B_3C_3D_6C_2087_0:
  CALL: 6C
  PRIORITY: 45
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '3C'
  CONDITION: opp_last_call == '3D'
  CONDITION: passes_since_last_bid == 0
  CONDITION: club_len >= 3
  CONDITION: c_realsolid == True
  CONDITION: losing_trick_count == 1

RULE B_3C_3D_7C_2089_0:
  CALL: 7C
  PRIORITY: 46
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '3C'
  CONDITION: opp_last_call == '3D'
  CONDITION: passes_since_last_bid == 0
  CONDITION: club_len >= 3
  CONDITION: c_realsolid == True
  CONDITION: losing_trick_count <= 0

RULE B_3C_3H_PASS_2092_0:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '3C'
  CONDITION: opp_last_call == '3H'
  CONDITION: passes_since_last_bid == 0

RULE B_3C_3H_3NT_2094_0:
  CALL: 3NT
  PRIORITY: 30
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '3C'
  CONDITION: opp_last_call == '3H'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 15
  CONDITION: h_stopper >= 2

RULE B_3C_3H_5C_2098_0:
  CALL: 5C
  PRIORITY: 70
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '3C'
  CONDITION: opp_last_call == '3H'
  CONDITION: passes_since_last_bid == 0
  CONDITION: club_len >= 4
  CONDITION: hcp <= 10

RULE B_3C_3H_6C_2102_0:
  CALL: 6C
  PRIORITY: 45
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '3C'
  CONDITION: opp_last_call == '3H'
  CONDITION: passes_since_last_bid == 0
  CONDITION: c_realsolid == True
  CONDITION: losing_trick_count == 1

RULE B_3C_3H_7C_2104_0:
  CALL: 7C
  PRIORITY: 46
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '3C'
  CONDITION: opp_last_call == '3H'
  CONDITION: passes_since_last_bid == 0
  CONDITION: c_realsolid == True
  CONDITION: losing_trick_count <= 0

RULE B_3C_3S_3NT_2109_0:
  CALL: 3NT
  PRIORITY: 30
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '3C'
  CONDITION: opp_last_call == '3S'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 15
  CONDITION: s_stopper >= 2

RULE B_3C_3S_5C_2113_0:
  CALL: 5C
  PRIORITY: 70
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '3C'
  CONDITION: opp_last_call == '3S'
  CONDITION: passes_since_last_bid == 0
  CONDITION: club_len >= 4
  CONDITION: hcp <= 10

RULE B_3C_3S_6C_2117_0:
  CALL: 6C
  PRIORITY: 45
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '3C'
  CONDITION: opp_last_call == '3S'
  CONDITION: passes_since_last_bid == 0
  CONDITION: c_realsolid == True
  CONDITION: losing_trick_count == 1

RULE B_3C_3S_7C_2119_0:
  CALL: 7C
  PRIORITY: 46
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '3C'
  CONDITION: opp_last_call == '3S'
  CONDITION: passes_since_last_bid == 0
  CONDITION: c_realsolid == True
  CONDITION: losing_trick_count <= 0

RULE B_3C_4C_PASS_2123_0:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '3C'
  CONDITION: opp_last_call == '4C'
  CONDITION: passes_since_last_bid == 0
  CONDITION: club_len <= 3

RULE B_3C_4C_PASS_2123_1:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '3C'
  CONDITION: opp_last_call == '4C'
  CONDITION: passes_since_last_bid == 0
  CONDITION: club_hcp <= 9

RULE B_3C_4C_5C_2126_0:
  CALL: 5C
  PRIORITY: 70
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '3C'
  CONDITION: opp_last_call == '4C'
  CONDITION: passes_since_last_bid == 0
  CONDITION: club_len >= 4
  CONDITION: club_hcp >= 10

RULE B_3C_4H_PASS_2127_0:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '3C'
  CONDITION: opp_last_call == '4H'
  CONDITION: passes_since_last_bid == 0

RULE B_3C_4S_PASS_2135_0:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '3C'
  CONDITION: opp_last_call == '4S'
  CONDITION: passes_since_last_bid == 0

RULE B_3C_6H_PASS_2141_0:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '3C'
  CONDITION: opp_last_call == '6H'
  CONDITION: passes_since_last_bid == 0

RULE B_3C_3N_PASS_2142_0:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '3C'
  CONDITION: opp_last_call == '3NT'
  CONDITION: passes_since_last_bid == 0

RULE B_3D_P_PASS_2149_0:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '3D'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 1

RULE B_3D_P_4D_2157_0:
  CALL: 4D
  PRIORITY: 20
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '3D'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 1
  CONDITION: diamond_len >= 2
  CONDITION: hcp <= 10
  CONDITION: diamond_hcp >= 6

RULE B_3D_P_5D_2166_0:
  CALL: 5D
  PRIORITY: 70
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '3D'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 1
  CONDITION: hcp >= 18
  CONDITION: diamond_len >= 1

RULE B_3D_P_6D_2169_0:
  CALL: 6D
  PRIORITY: 45
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '3D'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 1
  CONDITION: d_realsolid == True
  CONDITION: losing_trick_count == 1

RULE B_3D_P_7D_2171_0:
  CALL: 7D
  PRIORITY: 46
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '3D'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 1
  CONDITION: d_realsolid == True
  CONDITION: losing_trick_count <= 0

RULE B_3D_X_PASS_2174_0:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '3D'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 0

RULE B_3D_X_4D_2183_0:
  CALL: 4D
  PRIORITY: 20
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '3D'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 0
  CONDITION: diamond_len >= 2
  CONDITION: hcp <= 10
  CONDITION: diamond_hcp >= 6

RULE B_3D_X_5D_2192_0:
  CALL: 5D
  PRIORITY: 70
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '3D'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 18
  CONDITION: diamond_len >= 1

RULE B_3D_X_6D_2195_0:
  CALL: 6D
  PRIORITY: 45
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '3D'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 0
  CONDITION: d_realsolid == True
  CONDITION: losing_trick_count == 1

RULE B_3D_X_7D_2197_0:
  CALL: 7D
  PRIORITY: 46
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '3D'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 0
  CONDITION: d_realsolid == True
  CONDITION: losing_trick_count <= 0

RULE B_3D_3H_PASS_2200_0:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '3D'
  CONDITION: opp_last_call == '3H'
  CONDITION: passes_since_last_bid == 0

RULE B_3D_3H_3NT_2203_0:
  CALL: 3NT
  PRIORITY: 30
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '3D'
  CONDITION: opp_last_call == '3H'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 15
  CONDITION: h_stopper >= 2

RULE B_3D_3H_4C_2204_0:
  CALL: 4C
  PRIORITY: 20
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '3D'
  CONDITION: opp_last_call == '3H'
  CONDITION: passes_since_last_bid == 0
  CONDITION: club_len >= 7
  CONDITION: hcp <= 10

RULE B_3D_3H_4D_2205_0:
  CALL: 4D
  PRIORITY: 20
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '3D'
  CONDITION: opp_last_call == '3H'
  CONDITION: passes_since_last_bid == 0
  CONDITION: diamond_len >= 3
  CONDITION: hcp <= 10

RULE B_3D_3H_5D_2209_0:
  CALL: 5D
  PRIORITY: 70
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '3D'
  CONDITION: opp_last_call == '3H'
  CONDITION: passes_since_last_bid == 0
  CONDITION: diamond_len >= 4
  CONDITION: hcp <= 10

RULE B_3D_3H_6C_2212_0:
  CALL: 6C
  PRIORITY: 45
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '3D'
  CONDITION: opp_last_call == '3H'
  CONDITION: passes_since_last_bid == 0
  CONDITION: c_realsolid == True
  CONDITION: losing_trick_count == 1

RULE B_3D_3H_6D_2215_0:
  CALL: 6D
  PRIORITY: 45
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '3D'
  CONDITION: opp_last_call == '3H'
  CONDITION: passes_since_last_bid == 0
  CONDITION: d_realsolid == True
  CONDITION: losing_trick_count == 1

RULE B_3D_3H_7C_2217_0:
  CALL: 7C
  PRIORITY: 46
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '3D'
  CONDITION: opp_last_call == '3H'
  CONDITION: passes_since_last_bid == 0
  CONDITION: c_realsolid == True
  CONDITION: losing_trick_count <= 0

RULE B_3D_3H_7D_2219_0:
  CALL: 7D
  PRIORITY: 46
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '3D'
  CONDITION: opp_last_call == '3H'
  CONDITION: passes_since_last_bid == 0
  CONDITION: d_realsolid == True
  CONDITION: losing_trick_count <= 0

RULE B_3D_3S_PASS_2223_0:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '3D'
  CONDITION: opp_last_call == '3S'
  CONDITION: passes_since_last_bid == 0

RULE B_3D_3S_3NT_2225_0:
  CALL: 3NT
  PRIORITY: 30
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '3D'
  CONDITION: opp_last_call == '3S'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 15
  CONDITION: s_stopper >= 2

RULE B_3D_3S_4C_2226_0:
  CALL: 4C
  PRIORITY: 20
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '3D'
  CONDITION: opp_last_call == '3S'
  CONDITION: passes_since_last_bid == 0
  CONDITION: club_len >= 7
  CONDITION: hcp <= 10

RULE B_3D_3S_4D_2227_0:
  CALL: 4D
  PRIORITY: 20
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '3D'
  CONDITION: opp_last_call == '3S'
  CONDITION: passes_since_last_bid == 0
  CONDITION: diamond_len >= 3
  CONDITION: hcp <= 10

RULE B_3D_3S_5D_2231_0:
  CALL: 5D
  PRIORITY: 70
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '3D'
  CONDITION: opp_last_call == '3S'
  CONDITION: passes_since_last_bid == 0
  CONDITION: diamond_len >= 4
  CONDITION: hcp <= 10

RULE B_3D_3S_6C_2234_0:
  CALL: 6C
  PRIORITY: 45
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '3D'
  CONDITION: opp_last_call == '3S'
  CONDITION: passes_since_last_bid == 0
  CONDITION: c_realsolid == True
  CONDITION: losing_trick_count == 1

RULE B_3D_3S_6D_2237_0:
  CALL: 6D
  PRIORITY: 45
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '3D'
  CONDITION: opp_last_call == '3S'
  CONDITION: passes_since_last_bid == 0
  CONDITION: d_realsolid == True
  CONDITION: losing_trick_count == 1

RULE B_3D_3S_7C_2239_0:
  CALL: 7C
  PRIORITY: 46
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '3D'
  CONDITION: opp_last_call == '3S'
  CONDITION: passes_since_last_bid == 0
  CONDITION: c_realsolid == True
  CONDITION: losing_trick_count <= 0

RULE B_3D_3S_7D_2241_0:
  CALL: 7D
  PRIORITY: 46
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '3D'
  CONDITION: opp_last_call == '3S'
  CONDITION: passes_since_last_bid == 0
  CONDITION: d_realsolid == True
  CONDITION: losing_trick_count <= 0

RULE B_3D_4C_PASS_2245_0:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '3D'
  CONDITION: opp_last_call == '4C'
  CONDITION: passes_since_last_bid == 0

RULE B_3D_4C_4D_2247_0:
  CALL: 4D
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '3D'
  CONDITION: opp_last_call == '4C'
  CONDITION: passes_since_last_bid == 0
  CONDITION: diamond_len >= 3
  CONDITION: hcp <= 10

RULE B_3D_4C_5D_2254_0:
  CALL: 5D
  PRIORITY: 70
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '3D'
  CONDITION: opp_last_call == '4C'
  CONDITION: passes_since_last_bid == 0
  CONDITION: diamond_len >= 4
  CONDITION: hcp <= 10

RULE B_3D_4C_6D_2257_0:
  CALL: 6D
  PRIORITY: 45
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '3D'
  CONDITION: opp_last_call == '4C'
  CONDITION: passes_since_last_bid == 0
  CONDITION: d_realsolid == True
  CONDITION: losing_trick_count == 1

RULE B_3D_4C_7D_2259_0:
  CALL: 7D
  PRIORITY: 46
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '3D'
  CONDITION: opp_last_call == '4C'
  CONDITION: passes_since_last_bid == 0
  CONDITION: d_realsolid == True
  CONDITION: losing_trick_count <= 0

RULE B_3D_4D_PASS_2263_0:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '3D'
  CONDITION: opp_last_call == '4D'
  CONDITION: passes_since_last_bid == 0
  CONDITION: diamond_len <= 3

RULE B_3D_4D_PASS_2263_1:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '3D'
  CONDITION: opp_last_call == '4D'
  CONDITION: passes_since_last_bid == 0
  CONDITION: diamond_hcp <= 9

RULE B_3D_4D_5D_2266_0:
  CALL: 5D
  PRIORITY: 70
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '3D'
  CONDITION: opp_last_call == '4D'
  CONDITION: passes_since_last_bid == 0
  CONDITION: diamond_len >= 4
  CONDITION: diamond_hcp >= 10

RULE B_3D_4H_PASS_2267_0:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '3D'
  CONDITION: opp_last_call == '4H'
  CONDITION: passes_since_last_bid == 0

RULE B_3D_4S_PASS_2277_0:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '3D'
  CONDITION: opp_last_call == '4S'
  CONDITION: passes_since_last_bid == 0

RULE B_3D_5C_PASS_2283_0:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '3D'
  CONDITION: opp_last_call == '5C'
  CONDITION: passes_since_last_bid == 0

RULE B_3D_3N_PASS_2286_0:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '3D'
  CONDITION: opp_last_call == '3NT'
  CONDITION: passes_since_last_bid == 0

RULE B_3H_P_PASS_2293_0:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '3H'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 1

RULE B_3H_P_3NT_2294_0:
  CALL: 3NT
  PRIORITY: 40
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '3H'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 1
  CONDITION: hcp >= 15

RULE B_3H_P_4H_2300_0:
  CALL: 4H
  PRIORITY: 59
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '3H'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 1
  CONDITION: heart_len >= 3
  CONDITION: total_points >= 7

RULE B_3H_P_4H_2301_0:
  CALL: 4H
  PRIORITY: 60
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '3H'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 1
  CONDITION: heart_len >= 2
  CONDITION: total_points >= 9

RULE B_3H_P_4S_2302_1:
  CALL: 4S
  PRIORITY: 47
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '3H'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 1
  CONDITION: losing_trick_count <= 3
  CONDITION: spade_len >= 6

RULE B_3H_P_6H_2313_0:
  CALL: 6H
  PRIORITY: 75
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '3H'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 1
  CONDITION: h_realsolid == True
  CONDITION: losing_trick_count == 1

RULE B_3H_P_7H_2315_0:
  CALL: 7H
  PRIORITY: 76
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '3H'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 1
  CONDITION: h_realsolid == True
  CONDITION: losing_trick_count <= 0

RULE B_3H_3S_PASS_2318_0:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '3H'
  CONDITION: opp_last_call == '3S'
  CONDITION: passes_since_last_bid == 0

RULE B_3H_3S_3NT_2319_0:
  CALL: 3NT
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '3H'
  CONDITION: opp_last_call == '3S'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 15
  CONDITION: s_stopper >= 2

RULE B_3H_3S_4H_2322_0:
  CALL: 4H
  PRIORITY: 70
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '3H'
  CONDITION: opp_last_call == '3S'
  CONDITION: passes_since_last_bid == 0
  CONDITION: heart_len >= 2
  CONDITION: heart_hcp >= 9

RULE B_3H_3S_6H_2326_0:
  CALL: 6H
  PRIORITY: 45
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '3H'
  CONDITION: opp_last_call == '3S'
  CONDITION: passes_since_last_bid == 0
  CONDITION: h_realsolid == True
  CONDITION: losing_trick_count == 1

RULE B_3H_3S_7H_2328_0:
  CALL: 7H
  PRIORITY: 46
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '3H'
  CONDITION: opp_last_call == '3S'
  CONDITION: passes_since_last_bid == 0
  CONDITION: h_realsolid == True
  CONDITION: losing_trick_count <= 0

RULE B_3H_4C_4H_2333_0:
  CALL: 4H
  PRIORITY: 70
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '3H'
  CONDITION: opp_last_call == '4C'
  CONDITION: passes_since_last_bid == 0
  CONDITION: heart_len >= 3
  CONDITION: heart_hcp >= 10

RULE B_3H_4S_PASS_2335_0:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '3H'
  CONDITION: opp_last_call == '4S'
  CONDITION: passes_since_last_bid == 0

RULE B_3H_6C_PASS_2338_0:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '3H'
  CONDITION: opp_last_call == '6C'
  CONDITION: passes_since_last_bid == 0

RULE B_3H_6S_PASS_2339_0:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '3H'
  CONDITION: opp_last_call == '6S'
  CONDITION: passes_since_last_bid == 0

RULE B_3S_P_PASS_2345_0:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '3S'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 1

RULE B_3S_P_3NT_2346_0:
  CALL: 3NT
  PRIORITY: 40
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '3S'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 1
  CONDITION: hcp >= 15

RULE B_3S_P_4H_2351_1:
  CALL: 4H
  PRIORITY: 47
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '3S'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 1
  CONDITION: losing_trick_count <= 3
  CONDITION: heart_len >= 6

RULE B_3S_P_4S_2356_0:
  CALL: 4S
  PRIORITY: 59
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '3S'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 1
  CONDITION: spade_len >= 3
  CONDITION: total_points >= 7

RULE B_3S_P_4S_2357_0:
  CALL: 4S
  PRIORITY: 60
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '3S'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 1
  CONDITION: spade_len >= 2
  CONDITION: total_points >= 9

RULE B_3S_P_6S_2365_0:
  CALL: 6S
  PRIORITY: 75
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '3S'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 1
  CONDITION: s_realsolid == True
  CONDITION: losing_trick_count == 1

RULE B_3S_P_7S_2367_0:
  CALL: 7S
  PRIORITY: 76
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '3S'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 1
  CONDITION: s_realsolid == True
  CONDITION: losing_trick_count <= 0

RULE B_3S_X_PASS_2370_0:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '3S'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 0

RULE B_3S_X_3NT_2371_0:
  CALL: 3NT
  PRIORITY: 40
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '3S'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 15

RULE B_3S_X_4H_2377_1:
  CALL: 4H
  PRIORITY: 47
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '3S'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 0
  CONDITION: losing_trick_count <= 3
  CONDITION: heart_len >= 6

RULE B_3S_X_4S_2382_0:
  CALL: 4S
  PRIORITY: 59
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '3S'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 0
  CONDITION: spade_len >= 3
  CONDITION: total_points >= 7

RULE B_3S_X_4S_2383_1:
  CALL: 4S
  PRIORITY: 70
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '3S'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 0
  CONDITION: spade_len >= 2
  CONDITION: total_points >= 9

RULE B_3S_X_6S_2391_0:
  CALL: 6S
  PRIORITY: 75
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '3S'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 0
  CONDITION: s_realsolid == True
  CONDITION: losing_trick_count == 1

RULE B_3S_X_7S_2393_0:
  CALL: 7S
  PRIORITY: 76
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '3S'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 0
  CONDITION: s_realsolid == True
  CONDITION: losing_trick_count <= 0

RULE B_3S_4C_4S_2397_0:
  CALL: 4S
  PRIORITY: 70
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '3S'
  CONDITION: opp_last_call == '4C'
  CONDITION: passes_since_last_bid == 0
  CONDITION: spade_len >= 3
  CONDITION: spade_hcp >= 10

RULE B_3S_4H_PASS_2398_0:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '3S'
  CONDITION: opp_last_call == '4H'
  CONDITION: passes_since_last_bid == 0

RULE B_3S_4H_4S_2400_0:
  CALL: 4S
  PRIORITY: 70
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '3S'
  CONDITION: opp_last_call == '4H'
  CONDITION: passes_since_last_bid == 0
  CONDITION: spade_len >= 3
  CONDITION: hcp >= 10

RULE B_3S_4H_4S_2400_1:
  CALL: 4S
  PRIORITY: 70
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '3S'
  CONDITION: opp_last_call == '4H'
  CONDITION: passes_since_last_bid == 0
  CONDITION: spade_len >= 2
  CONDITION: hcp >= 14

RULE B_3S_4H_4S_2400_2:
  CALL: 4S
  PRIORITY: 70
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '3S'
  CONDITION: opp_last_call == '4H'
  CONDITION: passes_since_last_bid == 0
  CONDITION: spade_len >= 1
  CONDITION: hcp >= 16

RULE B_4C_P_PASS_2407_0:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '4C'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 1
  CONDITION: hcp <= 16

RULE B_4C_P_PASS_2407_1:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '4C'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 1
  CONDITION: ace_count <= 1

RULE B_4C_P_4H_2408_0:
  CALL: 4H
  PRIORITY: 70
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '4C'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 1
  CONDITION: heart_len >= 7
  CONDITION: total_points >= 17

RULE B_4C_P_4S_2409_0:
  CALL: 4S
  PRIORITY: 70
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '4C'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 1
  CONDITION: spade_len >= 7
  CONDITION: total_points >= 17

RULE B_4C_P_5C_2412_1:
  CALL: 5C
  PRIORITY: 69
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '4C'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 1
  CONDITION: ace_count == 2
  CONDITION: hcp >= 16

RULE B_4C_P_5C_2412_2:
  CALL: 5C
  PRIORITY: 69
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '4C'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 1
  CONDITION: ace_count == 3
  CONDITION: hcp <= 17

RULE B_4C_P_6C_2414_0:
  CALL: 6C
  PRIORITY: 55
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '4C'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 1
  CONDITION: club_len >= 1
  CONDITION: ace_count >= 4

RULE B_4C_P_6C_2414_1:
  CALL: 6C
  PRIORITY: 55
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '4C'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 1
  CONDITION: club_len >= 2
  CONDITION: ace_count >= 4

RULE B_4C_P_6C_2414_2:
  CALL: 6C
  PRIORITY: 55
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '4C'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 1
  CONDITION: club_len >= 2
  CONDITION: hcp >= 20

RULE B_4C_P_6C_2414_3:
  CALL: 6C
  PRIORITY: 55
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '4C'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 1
  CONDITION: ace_count == 3
  CONDITION: hcp >= 18

RULE B_4C_P_6C_2416_0:
  CALL: 6C
  PRIORITY: 65
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '4C'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 1
  CONDITION: c_realsolid == True
  CONDITION: losing_trick_count == 1

RULE B_4C_P_7C_2418_0:
  CALL: 7C
  PRIORITY: 58
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '4C'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 1
  CONDITION: ace_count == 4
  CONDITION: hcp >= 20

RULE B_4C_P_7C_2419_0:
  CALL: 7C
  PRIORITY: 66
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '4C'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 1
  CONDITION: c_realsolid == True
  CONDITION: losing_trick_count <= 0

RULE B_4C_4H_PASS_2422_0:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '4C'
  CONDITION: opp_last_call == '4H'
  CONDITION: passes_since_last_bid == 0

RULE B_4C_4S_PASS_2429_0:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '4C'
  CONDITION: opp_last_call == '4S'
  CONDITION: passes_since_last_bid == 0

RULE B_4C_5C_PASS_2436_0:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '4C'
  CONDITION: opp_last_call == '5C'
  CONDITION: passes_since_last_bid == 0

RULE B_4D_P_PASS_2437_0:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '4D'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 1
  CONDITION: hcp <= 16

RULE B_4D_P_PASS_2437_1:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '4D'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 1
  CONDITION: ace_count <= 1

RULE B_4D_P_4H_2438_0:
  CALL: 4H
  PRIORITY: 70
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '4D'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 1
  CONDITION: heart_len >= 7
  CONDITION: total_points >= 17

RULE B_4D_P_4S_2439_0:
  CALL: 4S
  PRIORITY: 70
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '4D'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 1
  CONDITION: spade_len >= 7
  CONDITION: total_points >= 17

RULE B_4D_P_5D_2442_1:
  CALL: 5D
  PRIORITY: 69
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '4D'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 1
  CONDITION: ace_count == 2
  CONDITION: hcp >= 16

RULE B_4D_P_5D_2442_2:
  CALL: 5D
  PRIORITY: 69
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '4D'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 1
  CONDITION: ace_count == 3
  CONDITION: hcp <= 17

RULE B_4D_P_6D_2444_0:
  CALL: 6D
  PRIORITY: 55
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '4D'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 1
  CONDITION: diamond_len >= 1
  CONDITION: ace_count >= 4

RULE B_4D_P_6D_2444_1:
  CALL: 6D
  PRIORITY: 55
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '4D'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 1
  CONDITION: diamond_len >= 2
  CONDITION: ace_count >= 4

RULE B_4D_P_6D_2444_2:
  CALL: 6D
  PRIORITY: 55
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '4D'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 1
  CONDITION: diamond_len >= 2
  CONDITION: hcp >= 20

RULE B_4D_P_6D_2444_3:
  CALL: 6D
  PRIORITY: 55
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '4D'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 1
  CONDITION: ace_count == 3
  CONDITION: hcp >= 18

RULE B_4D_P_6D_2446_0:
  CALL: 6D
  PRIORITY: 65
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '4D'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 1
  CONDITION: d_realsolid == True
  CONDITION: losing_trick_count == 1

RULE B_4D_P_7D_2448_0:
  CALL: 7D
  PRIORITY: 58
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '4D'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 1
  CONDITION: ace_count == 4
  CONDITION: hcp >= 20

RULE B_4D_P_7D_2449_0:
  CALL: 7D
  PRIORITY: 66
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '4D'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 1
  CONDITION: d_realsolid == True
  CONDITION: losing_trick_count <= 0

RULE B_4D_4H_PASS_2452_0:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '4D'
  CONDITION: opp_last_call == '4H'
  CONDITION: passes_since_last_bid == 0

RULE B_4D_4S_PASS_2461_0:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '4D'
  CONDITION: opp_last_call == '4S'
  CONDITION: passes_since_last_bid == 0

RULE B_4D_5C_PASS_2468_0:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '4D'
  CONDITION: opp_last_call == '5C'
  CONDITION: passes_since_last_bid == 0

RULE B_4H_P_PASS_2471_0:
  CALL: PASS
  PRIORITY: 20
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '4H'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 1
  CONDITION: ace_count <= 2

RULE B_4H_P_PASS_2471_1:
  CALL: PASS
  PRIORITY: 20
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '4H'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 1
  CONDITION: hcp <= 16

RULE B_4H_P_6H_2476_0:
  CALL: 6H
  PRIORITY: 15
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '4H'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 1
  CONDITION: h_realsolid == True
  CONDITION: losing_trick_count == 1

RULE B_4H_P_6H_2477_0:
  CALL: 6H
  PRIORITY: 30
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '4H'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 1
  CONDITION: ace_count >= 3
  CONDITION: hcp >= 17

RULE B_4H_P_7H_2479_0:
  CALL: 7H
  PRIORITY: 16
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '4H'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 1
  CONDITION: h_realsolid == True
  CONDITION: losing_trick_count <= 0

RULE B_4H_P_7H_2480_0:
  CALL: 7H
  PRIORITY: 40
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '4H'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 1
  CONDITION: ace_count == 4
  CONDITION: hcp >= 17

RULE B_4H_4S_PASS_2483_0:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '4H'
  CONDITION: opp_last_call == '4S'
  CONDITION: passes_since_last_bid == 0

RULE B_4H_5C_PASS_2486_0:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '4H'
  CONDITION: opp_last_call == '5C'
  CONDITION: passes_since_last_bid == 0

RULE B_4H_5S_PASS_2489_0:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '4H'
  CONDITION: opp_last_call == '5S'
  CONDITION: passes_since_last_bid == 0

RULE B_4H_4N_PASS_2491_0:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '4H'
  CONDITION: opp_last_call == '4NT'
  CONDITION: passes_since_last_bid == 0

RULE B_4S_P_PASS_2494_0:
  CALL: PASS
  PRIORITY: 20
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '4S'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 1
  CONDITION: ace_count <= 2

RULE B_4S_P_PASS_2494_1:
  CALL: PASS
  PRIORITY: 20
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '4S'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 1
  CONDITION: hcp <= 16

RULE B_4S_P_6S_2499_0:
  CALL: 6S
  PRIORITY: 15
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '4S'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 1
  CONDITION: s_realsolid == True
  CONDITION: losing_trick_count == 1

RULE B_4S_P_6S_2500_0:
  CALL: 6S
  PRIORITY: 30
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '4S'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 1
  CONDITION: ace_count >= 3
  CONDITION: hcp >= 17

RULE B_4S_P_7S_2502_0:
  CALL: 7S
  PRIORITY: 16
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '4S'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 1
  CONDITION: s_realsolid == True
  CONDITION: losing_trick_count <= 0

RULE B_4S_P_7S_2503_0:
  CALL: 7S
  PRIORITY: 40
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '4S'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 1
  CONDITION: ace_count == 4
  CONDITION: hcp >= 17

RULE B_4S_X_PASS_2506_0:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '4S'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 0

RULE B_4S_X_6S_2511_0:
  CALL: 6S
  PRIORITY: 15
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '4S'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 0
  CONDITION: s_realsolid == True
  CONDITION: losing_trick_count == 1

RULE B_4S_X_6S_2512_0:
  CALL: 6S
  PRIORITY: 30
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '4S'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 0
  CONDITION: ace_count >= 3
  CONDITION: hcp >= 17

RULE B_4S_X_7S_2514_0:
  CALL: 7S
  PRIORITY: 16
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '4S'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 0
  CONDITION: s_realsolid == True
  CONDITION: losing_trick_count <= 0

RULE B_4S_X_7S_2515_0:
  CALL: 7S
  PRIORITY: 40
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '4S'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 0
  CONDITION: ace_count == 4
  CONDITION: hcp >= 17

RULE B_4S_5C_PASS_2518_0:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '4S'
  CONDITION: opp_last_call == '5C'
  CONDITION: passes_since_last_bid == 0

RULE B_4S_4N_PASS_2521_0:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '4S'
  CONDITION: opp_last_call == '4NT'
  CONDITION: passes_since_last_bid == 0

RULE B_5C_P_PASS_2524_0:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '5C'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 1

RULE B_5C_5H_PASS_2527_0:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '5C'
  CONDITION: opp_last_call == '5H'
  CONDITION: passes_since_last_bid == 0

RULE B_5D_P_PASS_2529_0:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '5D'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 1

RULE B_5H_P_PASS_2532_0:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '5H'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 1

RULE B_5H_5S_PASS_2535_0:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '5H'
  CONDITION: opp_last_call == '5S'
  CONDITION: passes_since_last_bid == 0

RULE B_6C_P_PASS_2536_0:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '6C'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 1

RULE B_1N_P_PASS_2537_0:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1NT'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 1
  CONDITION: hcp < 8

RULE B_1N_P_2C_2538_2:
  CALL: 2C
  PRIORITY: 80
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1NT'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 1
  CONDITION: hcp >= 8
  CONDITION: hcp <= 9

RULE B_1N_P_2D_2540_0:
  CALL: 2D
  PRIORITY: 95
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1NT'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 1
  CONDITION: heart_len >= 5

RULE B_1N_P_2D_2540_1:
  CALL: 2D
  PRIORITY: 95
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1NT'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 1
  CONDITION: heart_len >= 5
  CONDITION: spade_len >= 5
  CONDITION: hcp < 9
  CONDITION: hcp > 6

RULE B_1N_P_2H_2541_0:
  CALL: 2H
  PRIORITY: 90
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1NT'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 1
  CONDITION: spade_len >= 5

RULE B_1N_P_2S_2542_0:
  CALL: 2S
  PRIORITY: 80
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1NT'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 1
  CONDITION: club_len >= 5
  CONDITION: diamond_len >= 4
  CONDITION: heart_len <= 3
  CONDITION: spade_len <= 3
  CONDITION: total_points >= 10

RULE B_1N_P_2S_2542_1:
  CALL: 2S
  PRIORITY: 80
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1NT'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 1
  CONDITION: diamond_len >= 5
  CONDITION: club_len >= 4
  CONDITION: heart_len <= 3
  CONDITION: spade_len <= 3
  CONDITION: total_points >= 10

RULE B_1N_P_2S_2543_0:
  CALL: 2S
  PRIORITY: 80
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1NT'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 1
  CONDITION: club_len >= 4
  CONDITION: diamond_len >= 4
  CONDITION: heart_len <= 3
  CONDITION: spade_len <= 3
  CONDITION: total_points >= 15

RULE B_1N_P_2NT_2544_0:
  CALL: 2NT
  PRIORITY: 80
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1NT'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 1
  CONDITION: club_len >= 6
  CONDITION: hcp >= 13

RULE B_1N_P_2NT_2544_1:
  CALL: 2NT
  PRIORITY: 80
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1NT'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 1
  CONDITION: club_len >= 6
  CONDITION: hcp <= 7

RULE B_1N_P_3C_2545_0:
  CALL: 3C
  PRIORITY: 80
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1NT'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 1
  CONDITION: diamond_len >= 6
  CONDITION: hcp >= 13

RULE B_1N_P_3C_2545_1:
  CALL: 3C
  PRIORITY: 80
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1NT'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 1
  CONDITION: diamond_len >= 6
  CONDITION: hcp <= 7

RULE B_1N_P_3NT_2549_4_0:
  CALL: 3NT
  PRIORITY: 86
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1NT'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 1
  CONDITION: hcp >= 8
  CONDITION: hcp <= 10
  CONDITION: club_len >= 6
  CONDITION: c_has_ace == True
  CONDITION: c_has_king == True
  CONDITION: c_has_queen == True

RULE B_1N_P_3NT_2549_4_1:
  CALL: 3NT
  PRIORITY: 86
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1NT'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 1
  CONDITION: hcp >= 8
  CONDITION: hcp <= 10
  CONDITION: club_len >= 6
  CONDITION: c_has_ace == True
  CONDITION: c_has_king == True
  CONDITION: c_has_jack == True

RULE B_1N_P_3NT_2549_4_2:
  CALL: 3NT
  PRIORITY: 86
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1NT'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 1
  CONDITION: hcp >= 8
  CONDITION: hcp <= 10
  CONDITION: club_len >= 6
  CONDITION: c_has_ace == True
  CONDITION: c_has_king == True
  CONDITION: c_has_ten == True

RULE B_1N_P_3NT_2549_4_3:
  CALL: 3NT
  PRIORITY: 86
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1NT'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 1
  CONDITION: hcp >= 8
  CONDITION: hcp <= 10
  CONDITION: club_len >= 6
  CONDITION: c_has_ace == True
  CONDITION: c_has_queen == True
  CONDITION: c_has_jack == True

RULE B_1N_P_3NT_2549_4_4:
  CALL: 3NT
  PRIORITY: 86
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1NT'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 1
  CONDITION: hcp >= 8
  CONDITION: hcp <= 10
  CONDITION: club_len >= 6
  CONDITION: c_has_ace == True
  CONDITION: c_has_queen == True
  CONDITION: c_has_ten == True

RULE B_1N_P_3NT_2549_4_5:
  CALL: 3NT
  PRIORITY: 86
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1NT'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 1
  CONDITION: hcp >= 8
  CONDITION: hcp <= 10
  CONDITION: club_len >= 6
  CONDITION: c_has_ace == True
  CONDITION: c_has_jack == True
  CONDITION: c_has_ten == True

RULE B_1N_P_3NT_2549_4_6:
  CALL: 3NT
  PRIORITY: 86
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1NT'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 1
  CONDITION: hcp >= 8
  CONDITION: hcp <= 10
  CONDITION: club_len >= 6
  CONDITION: c_has_king == True
  CONDITION: c_has_queen == True
  CONDITION: c_has_jack == True

RULE B_1N_P_3NT_2549_4_7:
  CALL: 3NT
  PRIORITY: 86
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1NT'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 1
  CONDITION: hcp >= 8
  CONDITION: hcp <= 10
  CONDITION: club_len >= 6
  CONDITION: c_has_king == True
  CONDITION: c_has_queen == True
  CONDITION: c_has_ten == True

RULE B_1N_P_3NT_2549_4_8:
  CALL: 3NT
  PRIORITY: 86
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1NT'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 1
  CONDITION: hcp >= 8
  CONDITION: hcp <= 10
  CONDITION: club_len >= 6
  CONDITION: c_has_king == True
  CONDITION: c_has_jack == True
  CONDITION: c_has_ten == True

RULE B_1N_P_3NT_2549_4_9:
  CALL: 3NT
  PRIORITY: 86
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1NT'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 1
  CONDITION: hcp >= 8
  CONDITION: hcp <= 10
  CONDITION: club_len >= 6
  CONDITION: c_has_queen == True
  CONDITION: c_has_jack == True
  CONDITION: c_has_ten == True

RULE B_1N_P_3NT_2549_6_0:
  CALL: 3NT
  PRIORITY: 86
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1NT'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 1
  CONDITION: hcp >= 8
  CONDITION: hcp <= 10
  CONDITION: diamond_len >= 6
  CONDITION: d_has_ace == True
  CONDITION: d_has_king == True
  CONDITION: d_has_queen == True

RULE B_1N_P_3NT_2549_6_1:
  CALL: 3NT
  PRIORITY: 86
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1NT'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 1
  CONDITION: hcp >= 8
  CONDITION: hcp <= 10
  CONDITION: diamond_len >= 6
  CONDITION: d_has_ace == True
  CONDITION: d_has_king == True
  CONDITION: d_has_jack == True

RULE B_1N_P_3NT_2549_6_2:
  CALL: 3NT
  PRIORITY: 86
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1NT'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 1
  CONDITION: hcp >= 8
  CONDITION: hcp <= 10
  CONDITION: diamond_len >= 6
  CONDITION: d_has_ace == True
  CONDITION: d_has_king == True
  CONDITION: d_has_ten == True

RULE B_1N_P_3NT_2549_6_3:
  CALL: 3NT
  PRIORITY: 86
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1NT'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 1
  CONDITION: hcp >= 8
  CONDITION: hcp <= 10
  CONDITION: diamond_len >= 6
  CONDITION: d_has_ace == True
  CONDITION: d_has_queen == True
  CONDITION: d_has_jack == True

RULE B_1N_P_3NT_2549_6_4:
  CALL: 3NT
  PRIORITY: 86
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1NT'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 1
  CONDITION: hcp >= 8
  CONDITION: hcp <= 10
  CONDITION: diamond_len >= 6
  CONDITION: d_has_ace == True
  CONDITION: d_has_queen == True
  CONDITION: d_has_ten == True

RULE B_1N_P_3NT_2549_6_5:
  CALL: 3NT
  PRIORITY: 86
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1NT'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 1
  CONDITION: hcp >= 8
  CONDITION: hcp <= 10
  CONDITION: diamond_len >= 6
  CONDITION: d_has_ace == True
  CONDITION: d_has_jack == True
  CONDITION: d_has_ten == True

RULE B_1N_P_3NT_2549_6_6:
  CALL: 3NT
  PRIORITY: 86
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1NT'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 1
  CONDITION: hcp >= 8
  CONDITION: hcp <= 10
  CONDITION: diamond_len >= 6
  CONDITION: d_has_king == True
  CONDITION: d_has_queen == True
  CONDITION: d_has_jack == True

RULE B_1N_P_3NT_2549_6_7:
  CALL: 3NT
  PRIORITY: 86
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1NT'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 1
  CONDITION: hcp >= 8
  CONDITION: hcp <= 10
  CONDITION: diamond_len >= 6
  CONDITION: d_has_king == True
  CONDITION: d_has_queen == True
  CONDITION: d_has_ten == True

RULE B_1N_P_3NT_2549_6_8:
  CALL: 3NT
  PRIORITY: 86
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1NT'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 1
  CONDITION: hcp >= 8
  CONDITION: hcp <= 10
  CONDITION: diamond_len >= 6
  CONDITION: d_has_king == True
  CONDITION: d_has_jack == True
  CONDITION: d_has_ten == True

RULE B_1N_P_3NT_2549_6_9:
  CALL: 3NT
  PRIORITY: 86
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1NT'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 1
  CONDITION: hcp >= 8
  CONDITION: hcp <= 10
  CONDITION: diamond_len >= 6
  CONDITION: d_has_queen == True
  CONDITION: d_has_jack == True
  CONDITION: d_has_ten == True

RULE B_2N_P_PASS_2558_0:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '2NT'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 1
  CONDITION: hcp < 4

RULE B_2N_P_3D_2561_0:
  CALL: 3D
  PRIORITY: 90
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '2NT'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 1
  CONDITION: heart_len >= 5

RULE B_2N_P_3H_2562_0:
  CALL: 3H
  PRIORITY: 90
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '2NT'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 1
  CONDITION: spade_len >= 5

RULE B_3N_P_PASS_2572_0:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '3NT'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 1
  CONDITION: hcp <= 7

RULE B_3N_P_4D_2574_0:
  CALL: 4D
  PRIORITY: 120
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '3NT'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 1
  CONDITION: heart_len >= 6

RULE B_3N_P_4H_2575_0:
  CALL: 4H
  PRIORITY: 120
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '3NT'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 1
  CONDITION: spade_len >= 6

RULE B_1N_X_PASS_2582_0:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1NT'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 0

RULE B_1N_X_2C_2583_2:
  CALL: 2C
  PRIORITY: 80
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1NT'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 8
  CONDITION: hcp <= 9

RULE B_1N_X_2D_2585_0:
  CALL: 2D
  PRIORITY: 95
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1NT'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 0
  CONDITION: heart_len >= 5

RULE B_1N_X_2D_2585_1:
  CALL: 2D
  PRIORITY: 95
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1NT'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 0
  CONDITION: heart_len >= 5
  CONDITION: spade_len >= 5
  CONDITION: hcp < 9
  CONDITION: hcp > 6

RULE B_1N_X_2H_2586_0:
  CALL: 2H
  PRIORITY: 90
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1NT'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 0
  CONDITION: spade_len >= 5

RULE B_1N_X_2S_2587_0:
  CALL: 2S
  PRIORITY: 80
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1NT'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 0
  CONDITION: club_len >= 5
  CONDITION: diamond_len >= 4
  CONDITION: heart_len <= 3
  CONDITION: spade_len <= 3
  CONDITION: total_points >= 10

RULE B_1N_X_2S_2587_1:
  CALL: 2S
  PRIORITY: 80
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1NT'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 0
  CONDITION: diamond_len >= 5
  CONDITION: club_len >= 4
  CONDITION: heart_len <= 3
  CONDITION: spade_len <= 3
  CONDITION: total_points >= 10

RULE B_1N_X_2S_2588_0:
  CALL: 2S
  PRIORITY: 80
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1NT'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 0
  CONDITION: club_len >= 4
  CONDITION: diamond_len >= 4
  CONDITION: heart_len <= 3
  CONDITION: spade_len <= 3
  CONDITION: total_points >= 15

RULE B_1N_X_2NT_2589_0:
  CALL: 2NT
  PRIORITY: 80
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1NT'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 0
  CONDITION: club_len >= 6
  CONDITION: hcp >= 13

RULE B_1N_X_2NT_2589_1:
  CALL: 2NT
  PRIORITY: 80
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1NT'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 0
  CONDITION: club_len >= 6
  CONDITION: hcp <= 7

RULE B_1N_X_3C_2590_0:
  CALL: 3C
  PRIORITY: 80
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1NT'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 0
  CONDITION: diamond_len >= 6
  CONDITION: hcp >= 13

RULE B_1N_X_3C_2590_1:
  CALL: 3C
  PRIORITY: 80
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1NT'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 0
  CONDITION: diamond_len >= 6
  CONDITION: hcp <= 7

RULE B_1N_X_3NT_2595_0:
  CALL: 3NT
  PRIORITY: 20
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1NT'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 11

RULE B_1N_X_XX_2603_0:
  CALL: XX
  PRIORITY: 90
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1NT'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 0
  CONDITION: club_len >= 5
  CONDITION: hcp <= 3

RULE B_1N_X_XX_2603_1:
  CALL: XX
  PRIORITY: 90
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1NT'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 0
  CONDITION: diamond_len >= 5
  CONDITION: hcp <= 3

RULE B_7N_X_PASS_2604_0:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '7NT'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 0

RULE B_1N_2C_PASS_2605_0:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1NT'
  CONDITION: opp_last_call == '2C'
  CONDITION: passes_since_last_bid == 0

RULE B_1N_2C_2D_2606_0:
  CALL: 2D
  PRIORITY: 90
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1NT'
  CONDITION: opp_last_call == '2C'
  CONDITION: passes_since_last_bid == 0
  CONDITION: heart_len >= 5
  CONDITION: heart_hcp >= 6

RULE B_1N_2C_2H_2607_0:
  CALL: 2H
  PRIORITY: 90
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1NT'
  CONDITION: opp_last_call == '2C'
  CONDITION: passes_since_last_bid == 0
  CONDITION: spade_len >= 5
  CONDITION: spade_hcp >= 6

RULE B_1N_2C_2S_2608_0:
  CALL: 2S
  PRIORITY: 80
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1NT'
  CONDITION: opp_last_call == '2C'
  CONDITION: passes_since_last_bid == 0
  CONDITION: club_len >= 5
  CONDITION: diamond_len >= 4
  CONDITION: heart_len <= 3
  CONDITION: spade_len <= 3
  CONDITION: total_points >= 10

RULE B_1N_2C_2S_2608_1:
  CALL: 2S
  PRIORITY: 80
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1NT'
  CONDITION: opp_last_call == '2C'
  CONDITION: passes_since_last_bid == 0
  CONDITION: diamond_len >= 5
  CONDITION: club_len >= 4
  CONDITION: heart_len <= 3
  CONDITION: spade_len <= 3
  CONDITION: total_points >= 10

RULE B_1N_2C_2S_2609_0:
  CALL: 2S
  PRIORITY: 80
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1NT'
  CONDITION: opp_last_call == '2C'
  CONDITION: passes_since_last_bid == 0
  CONDITION: club_len >= 4
  CONDITION: diamond_len >= 4
  CONDITION: heart_len <= 3
  CONDITION: spade_len <= 3
  CONDITION: total_points >= 15

RULE B_1N_2C_2NT_2610_0:
  CALL: 2NT
  PRIORITY: 80
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1NT'
  CONDITION: opp_last_call == '2C'
  CONDITION: passes_since_last_bid == 0
  CONDITION: club_len >= 6
  CONDITION: hcp >= 13

RULE B_1N_2C_2NT_2610_1:
  CALL: 2NT
  PRIORITY: 80
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1NT'
  CONDITION: opp_last_call == '2C'
  CONDITION: passes_since_last_bid == 0
  CONDITION: club_len >= 6
  CONDITION: hcp >= 4
  CONDITION: hcp <= 7

RULE B_1N_2C_3C_2611_0:
  CALL: 3C
  PRIORITY: 80
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1NT'
  CONDITION: opp_last_call == '2C'
  CONDITION: passes_since_last_bid == 0
  CONDITION: diamond_len >= 6
  CONDITION: hcp >= 13

RULE B_1N_2C_3C_2611_1:
  CALL: 3C
  PRIORITY: 80
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1NT'
  CONDITION: opp_last_call == '2C'
  CONDITION: passes_since_last_bid == 0
  CONDITION: diamond_len >= 6
  CONDITION: hcp >= 4
  CONDITION: hcp <= 7

RULE B_1N_2C_3NT_2617_0:
  CALL: 3NT
  PRIORITY: 60
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1NT'
  CONDITION: opp_last_call == '2C'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 8
  CONDITION: club_len >= 6

RULE B_1N_2C_3NT_2617_1:
  CALL: 3NT
  PRIORITY: 60
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1NT'
  CONDITION: opp_last_call == '2C'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 8
  CONDITION: diamond_len >= 6

RULE B_1N_2D_PASS_2628_0:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1NT'
  CONDITION: opp_last_call == '2D'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp <= 8

RULE B_1N_2D_2NT_2629_0:
  CALL: 2NT
  PRIORITY: 95
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1NT'
  CONDITION: opp_last_call == '2D'
  CONDITION: passes_since_last_bid == 0
  CONDITION: club_len >= 6
  CONDITION: hcp <= 8
  CONDITION: hcp >= 5

RULE B_1N_2D_2NT_2629_1:
  CALL: 2NT
  PRIORITY: 95
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1NT'
  CONDITION: opp_last_call == '2D'
  CONDITION: passes_since_last_bid == 0
  CONDITION: diamond_len >= 6
  CONDITION: hcp <= 8
  CONDITION: hcp >= 5

RULE B_1N_2D_3H_2630_0:
  CALL: 3H
  PRIORITY: 95
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1NT'
  CONDITION: opp_last_call == '2D'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 9
  CONDITION: h_stopper >= 2
  CONDITION: s_stopper < 2

RULE B_1N_2D_3S_2631_0:
  CALL: 3S
  PRIORITY: 95
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1NT'
  CONDITION: opp_last_call == '2D'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 9
  CONDITION: s_stopper >= 2
  CONDITION: h_stopper < 2

RULE B_1N_2D_3NT_2632_0:
  CALL: 3NT
  PRIORITY: 100
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1NT'
  CONDITION: opp_last_call == '2D'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 9

RULE B_1N_2D_5C_2634_0:
  CALL: 5C
  PRIORITY: 20
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1NT'
  CONDITION: opp_last_call == '2D'
  CONDITION: passes_since_last_bid == 0
  CONDITION: club_len >= 7
  CONDITION: club_hcp >= 10

RULE B_1N_2D_5D_2635_0:
  CALL: 5D
  PRIORITY: 20
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1NT'
  CONDITION: opp_last_call == '2D'
  CONDITION: passes_since_last_bid == 0
  CONDITION: diamond_len >= 7
  CONDITION: diamond_hcp >= 10

RULE B_1N_2H_PASS_2639_0:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1NT'
  CONDITION: opp_last_call == '2H'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp <= 8

RULE B_1N_2H_2S_2640_0:
  CALL: 2S
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1NT'
  CONDITION: opp_last_call == '2H'
  CONDITION: passes_since_last_bid == 0
  CONDITION: spade_len >= 5
  CONDITION: hcp <= 6
  CONDITION: hcp >= 4

RULE B_1N_2H_2NT_2641_0:
  CALL: 2NT
  PRIORITY: 95
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1NT'
  CONDITION: opp_last_call == '2H'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 9
  CONDITION: h_stopper >= 2

RULE B_1N_2H_2NT_2641_1:
  CALL: 2NT
  PRIORITY: 95
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1NT'
  CONDITION: opp_last_call == '2H'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 7
  CONDITION: spade_len >= 5
  CONDITION: hcp <= 8

RULE B_1N_2H_2NT_2641_2:
  CALL: 2NT
  PRIORITY: 95
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1NT'
  CONDITION: opp_last_call == '2H'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 7
  CONDITION: club_len >= 5
  CONDITION: hcp <= 8

RULE B_1N_2H_2NT_2641_3:
  CALL: 2NT
  PRIORITY: 95
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1NT'
  CONDITION: opp_last_call == '2H'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 7
  CONDITION: diamond_len >= 5
  CONDITION: hcp <= 8

RULE B_1N_2H_3C_2642_0:
  CALL: 3C
  PRIORITY: 25
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1NT'
  CONDITION: opp_last_call == '2H'
  CONDITION: passes_since_last_bid == 0
  CONDITION: club_len >= 5
  CONDITION: hcp >= 9

RULE B_1N_2H_3D_2643_0:
  CALL: 3D
  PRIORITY: 25
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1NT'
  CONDITION: opp_last_call == '2H'
  CONDITION: passes_since_last_bid == 0
  CONDITION: diamond_len >= 5
  CONDITION: hcp >= 9

RULE B_1N_2H_3S_2644_0:
  CALL: 3S
  PRIORITY: 35
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1NT'
  CONDITION: opp_last_call == '2H'
  CONDITION: passes_since_last_bid == 0
  CONDITION: spade_len >= 5
  CONDITION: hcp >= 9

RULE B_1N_2H_3NT_2645_0:
  CALL: 3NT
  PRIORITY: 20
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1NT'
  CONDITION: opp_last_call == '2H'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 9
  CONDITION: h_stopper < 2

RULE B_1N_2H_X_2651_0:
  CALL: X
  PRIORITY: 15
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1NT'
  CONDITION: opp_last_call == '2H'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 8
  CONDITION: spade_len >= 4
  CONDITION: club_len >= 2
  CONDITION: diamond_len >= 2

RULE B_1N_2S_PASS_2652_0:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1NT'
  CONDITION: opp_last_call == '2S'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp <= 8

RULE B_1N_2S_2NT_2653_0:
  CALL: 2NT
  PRIORITY: 95
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1NT'
  CONDITION: opp_last_call == '2S'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 9
  CONDITION: s_stopper >= 2

RULE B_1N_2S_2NT_2653_1:
  CALL: 2NT
  PRIORITY: 95
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1NT'
  CONDITION: opp_last_call == '2S'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 7
  CONDITION: heart_len >= 5
  CONDITION: hcp <= 8

RULE B_1N_2S_2NT_2653_2:
  CALL: 2NT
  PRIORITY: 95
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1NT'
  CONDITION: opp_last_call == '2S'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 7
  CONDITION: club_len >= 5
  CONDITION: hcp <= 8

RULE B_1N_2S_2NT_2653_3:
  CALL: 2NT
  PRIORITY: 95
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1NT'
  CONDITION: opp_last_call == '2S'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 7
  CONDITION: diamond_len >= 5
  CONDITION: hcp <= 8

RULE B_1N_2S_3C_2654_0:
  CALL: 3C
  PRIORITY: 25
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1NT'
  CONDITION: opp_last_call == '2S'
  CONDITION: passes_since_last_bid == 0
  CONDITION: club_len >= 5
  CONDITION: hcp >= 9

RULE B_1N_2S_3D_2655_0:
  CALL: 3D
  PRIORITY: 25
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1NT'
  CONDITION: opp_last_call == '2S'
  CONDITION: passes_since_last_bid == 0
  CONDITION: diamond_len >= 5
  CONDITION: hcp >= 9

RULE B_1N_2S_3H_2656_0:
  CALL: 3H
  PRIORITY: 35
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1NT'
  CONDITION: opp_last_call == '2S'
  CONDITION: passes_since_last_bid == 0
  CONDITION: heart_len >= 5
  CONDITION: hcp >= 9

RULE B_1N_2S_3NT_2657_0:
  CALL: 3NT
  PRIORITY: 20
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1NT'
  CONDITION: opp_last_call == '2S'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 9
  CONDITION: s_stopper < 2

RULE B_1N_2S_X_2663_0:
  CALL: X
  PRIORITY: 15
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1NT'
  CONDITION: opp_last_call == '2S'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 8
  CONDITION: heart_len >= 4
  CONDITION: club_len >= 2
  CONDITION: diamond_len >= 2

RULE B_1N_3C_PASS_2664_0:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1NT'
  CONDITION: opp_last_call == '3C'
  CONDITION: passes_since_last_bid == 0

RULE B_1N_3C_PASS_2664_1:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1NT'
  CONDITION: opp_last_call == '3C'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp <= 8

RULE B_1N_3C_3D_2665_0:
  CALL: 3D
  PRIORITY: 30
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1NT'
  CONDITION: opp_last_call == '3C'
  CONDITION: passes_since_last_bid == 0
  CONDITION: diamond_len >= 5
  CONDITION: hcp >= 8

RULE B_1N_3C_3H_2666_0:
  CALL: 3H
  PRIORITY: 38
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1NT'
  CONDITION: opp_last_call == '3C'
  CONDITION: passes_since_last_bid == 0
  CONDITION: heart_len >= 5
  CONDITION: heart_hcp >= 10
  CONDITION: hcp <= 15

RULE B_1N_3C_3S_2667_0:
  CALL: 3S
  PRIORITY: 38
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1NT'
  CONDITION: opp_last_call == '3C'
  CONDITION: passes_since_last_bid == 0
  CONDITION: spade_len >= 5
  CONDITION: spade_hcp >= 10
  CONDITION: hcp <= 15

RULE B_1N_3C_3NT_2668_0:
  CALL: 3NT
  PRIORITY: 32
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1NT'
  CONDITION: opp_last_call == '3C'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 9
  CONDITION: c_stopper >= 2

RULE B_1N_3C_4H_2671_0:
  CALL: 4H
  PRIORITY: 50
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1NT'
  CONDITION: opp_last_call == '3C'
  CONDITION: passes_since_last_bid == 0
  CONDITION: heart_len >= 6
  CONDITION: heart_hcp >= 10
  CONDITION: hcp <= 15

RULE B_1N_3C_4S_2672_0:
  CALL: 4S
  PRIORITY: 50
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1NT'
  CONDITION: opp_last_call == '3C'
  CONDITION: passes_since_last_bid == 0
  CONDITION: spade_len >= 6
  CONDITION: spade_hcp >= 10
  CONDITION: hcp <= 15

RULE B_1N_3C_X_2681_0:
  CALL: X
  PRIORITY: 15
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1NT'
  CONDITION: opp_last_call == '3C'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 9
  CONDITION: spade_len >= 4
  CONDITION: heart_len >= 4
  CONDITION: diamond_len >= 1

RULE B_1N_3C_X_2681_1:
  CALL: X
  PRIORITY: 15
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1NT'
  CONDITION: opp_last_call == '3C'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 9
  CONDITION: spade_len >= 3
  CONDITION: heart_len >= 3
  CONDITION: diamond_len >= 3

RULE B_1N_3C_X_2681_2:
  CALL: X
  PRIORITY: 15
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1NT'
  CONDITION: opp_last_call == '3C'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 9
  CONDITION: spade_len >= 4
  CONDITION: heart_len >= 4
  CONDITION: diamond_len >= 3

RULE B_2N_3C_PASS_2682_0:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '2NT'
  CONDITION: opp_last_call == '3C'
  CONDITION: passes_since_last_bid == 0

RULE B_1N_3D_PASS_2691_0:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1NT'
  CONDITION: opp_last_call == '3D'
  CONDITION: passes_since_last_bid == 0

RULE B_1N_3D_PASS_2691_1:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1NT'
  CONDITION: opp_last_call == '3D'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp <= 8

RULE B_1N_3D_3H_2692_0:
  CALL: 3H
  PRIORITY: 38
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1NT'
  CONDITION: opp_last_call == '3D'
  CONDITION: passes_since_last_bid == 0
  CONDITION: heart_len >= 5
  CONDITION: heart_hcp >= 10
  CONDITION: hcp <= 15

RULE B_1N_3D_3S_2693_0:
  CALL: 3S
  PRIORITY: 38
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1NT'
  CONDITION: opp_last_call == '3D'
  CONDITION: passes_since_last_bid == 0
  CONDITION: spade_len >= 5
  CONDITION: spade_hcp >= 10
  CONDITION: hcp <= 15

RULE B_1N_3D_3NT_2694_0:
  CALL: 3NT
  PRIORITY: 32
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1NT'
  CONDITION: opp_last_call == '3D'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 9
  CONDITION: d_stopper >= 2

RULE B_1N_3D_4H_2697_0:
  CALL: 4H
  PRIORITY: 50
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1NT'
  CONDITION: opp_last_call == '3D'
  CONDITION: passes_since_last_bid == 0
  CONDITION: heart_len >= 6
  CONDITION: heart_hcp >= 10
  CONDITION: hcp <= 15

RULE B_1N_3D_4S_2698_0:
  CALL: 4S
  PRIORITY: 50
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1NT'
  CONDITION: opp_last_call == '3D'
  CONDITION: passes_since_last_bid == 0
  CONDITION: spade_len >= 6
  CONDITION: spade_hcp >= 10
  CONDITION: hcp <= 15

RULE B_1N_3D_X_2707_0:
  CALL: X
  PRIORITY: 15
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1NT'
  CONDITION: opp_last_call == '3D'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 9
  CONDITION: spade_len >= 4
  CONDITION: heart_len >= 4
  CONDITION: club_len >= 1

RULE B_1N_3D_X_2707_1:
  CALL: X
  PRIORITY: 15
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1NT'
  CONDITION: opp_last_call == '3D'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 9
  CONDITION: spade_len >= 3
  CONDITION: heart_len >= 3
  CONDITION: club_len >= 3

RULE B_1N_3D_X_2707_2:
  CALL: X
  PRIORITY: 15
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1NT'
  CONDITION: opp_last_call == '3D'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 9
  CONDITION: spade_len >= 4
  CONDITION: heart_len >= 4
  CONDITION: club_len >= 3

RULE B_2N_3D_PASS_2708_0:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '2NT'
  CONDITION: opp_last_call == '3D'
  CONDITION: passes_since_last_bid == 0

RULE B_1N_3H_PASS_2717_0:
  CALL: PASS
  PRIORITY: -3
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1NT'
  CONDITION: opp_last_call == '3H'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp <= 8

RULE B_1N_3H_3NT_2719_0:
  CALL: 3NT
  PRIORITY: 20
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1NT'
  CONDITION: opp_last_call == '3H'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 9

RULE B_1N_3H_3NT_2719_1:
  CALL: 3NT
  PRIORITY: 20
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1NT'
  CONDITION: opp_last_call == '3H'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 9
  CONDITION: h_stopper >= 2

RULE B_1N_3H_4C_2720_0:
  CALL: 4C
  PRIORITY: 39
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1NT'
  CONDITION: opp_last_call == '3H'
  CONDITION: passes_since_last_bid == 0
  CONDITION: club_len >= 6
  CONDITION: hcp >= 8

RULE B_1N_3H_4D_2722_0:
  CALL: 4D
  PRIORITY: 39
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1NT'
  CONDITION: opp_last_call == '3H'
  CONDITION: passes_since_last_bid == 0
  CONDITION: diamond_len >= 6
  CONDITION: hcp >= 8

RULE B_1N_3H_4S_2725_0:
  CALL: 4S
  PRIORITY: 30
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1NT'
  CONDITION: opp_last_call == '3H'
  CONDITION: passes_since_last_bid == 0
  CONDITION: spade_len >= 6
  CONDITION: hcp >= 8
  CONDITION: hcp <= 15

RULE B_1N_3H_X_2736_1:
  CALL: X
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1NT'
  CONDITION: opp_last_call == '3H'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 9
  CONDITION: spade_len >= 4

RULE B_1N_3H_X_2736_2:
  CALL: X
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1NT'
  CONDITION: opp_last_call == '3H'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 9
  CONDITION: spade_len >= 4
  CONDITION: club_len >= 3
  CONDITION: diamond_len >= 3

RULE B_2N_3H_PASS_2737_0:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '2NT'
  CONDITION: opp_last_call == '3H'
  CONDITION: passes_since_last_bid == 0

RULE B_1N_3S_PASS_2748_0:
  CALL: PASS
  PRIORITY: -3
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1NT'
  CONDITION: opp_last_call == '3S'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp <= 8

RULE B_1N_3S_3NT_2749_0:
  CALL: 3NT
  PRIORITY: 20
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1NT'
  CONDITION: opp_last_call == '3S'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 9

RULE B_1N_3S_3NT_2749_1:
  CALL: 3NT
  PRIORITY: 20
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1NT'
  CONDITION: opp_last_call == '3S'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 9
  CONDITION: s_stopper >= 2

RULE B_1N_3S_4C_2750_0:
  CALL: 4C
  PRIORITY: 39
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1NT'
  CONDITION: opp_last_call == '3S'
  CONDITION: passes_since_last_bid == 0
  CONDITION: club_len >= 6
  CONDITION: hcp >= 8

RULE B_1N_3S_4D_2752_0:
  CALL: 4D
  PRIORITY: 39
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1NT'
  CONDITION: opp_last_call == '3S'
  CONDITION: passes_since_last_bid == 0
  CONDITION: diamond_len >= 6
  CONDITION: hcp >= 8

RULE B_1N_3S_4H_2755_0:
  CALL: 4H
  PRIORITY: 30
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1NT'
  CONDITION: opp_last_call == '3S'
  CONDITION: passes_since_last_bid == 0
  CONDITION: heart_len >= 6
  CONDITION: hcp >= 8
  CONDITION: hcp <= 15

RULE B_1N_3S_X_2765_1:
  CALL: X
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1NT'
  CONDITION: opp_last_call == '3S'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 9
  CONDITION: heart_len >= 4

RULE B_1N_3S_X_2765_2:
  CALL: X
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1NT'
  CONDITION: opp_last_call == '3S'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 9
  CONDITION: heart_len >= 4
  CONDITION: club_len >= 3
  CONDITION: diamond_len >= 3

RULE B_2N_3S_PASS_2766_0:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '2NT'
  CONDITION: opp_last_call == '3S'
  CONDITION: passes_since_last_bid == 0

RULE B_1N_4C_PASS_2773_0:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1NT'
  CONDITION: opp_last_call == '4C'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp <= 9

RULE B_1N_4C_4H_2774_0:
  CALL: 4H
  PRIORITY: 20
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1NT'
  CONDITION: opp_last_call == '4C'
  CONDITION: passes_since_last_bid == 0
  CONDITION: heart_len >= 6
  CONDITION: hcp >= 10
  CONDITION: hcp <= 15

RULE B_1N_4C_4S_2775_0:
  CALL: 4S
  PRIORITY: 20
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1NT'
  CONDITION: opp_last_call == '4C'
  CONDITION: passes_since_last_bid == 0
  CONDITION: spade_len >= 6
  CONDITION: hcp >= 10
  CONDITION: hcp <= 15

RULE B_1N_4C_X_2783_0:
  CALL: X
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1NT'
  CONDITION: opp_last_call == '4C'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 10

RULE B_2N_4C_PASS_2784_0:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '2NT'
  CONDITION: opp_last_call == '4C'
  CONDITION: passes_since_last_bid == 0

RULE B_1N_4D_PASS_2787_0:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1NT'
  CONDITION: opp_last_call == '4D'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp <= 9

RULE B_1N_4D_4H_2788_0:
  CALL: 4H
  PRIORITY: 20
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1NT'
  CONDITION: opp_last_call == '4D'
  CONDITION: passes_since_last_bid == 0
  CONDITION: heart_len >= 6
  CONDITION: hcp >= 10
  CONDITION: hcp <= 15

RULE B_1N_4D_4S_2789_0:
  CALL: 4S
  PRIORITY: 20
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1NT'
  CONDITION: opp_last_call == '4D'
  CONDITION: passes_since_last_bid == 0
  CONDITION: spade_len >= 6
  CONDITION: hcp >= 10
  CONDITION: hcp <= 15

RULE B_1N_4D_X_2797_0:
  CALL: X
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1NT'
  CONDITION: opp_last_call == '4D'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 10

RULE B_1N_4H_PASS_2798_0:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1NT'
  CONDITION: opp_last_call == '4H'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp <= 9

RULE B_1N_4H_X_2806_0:
  CALL: X
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1NT'
  CONDITION: opp_last_call == '4H'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 10

RULE B_2N_4H_PASS_2807_0:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '2NT'
  CONDITION: opp_last_call == '4H'
  CONDITION: passes_since_last_bid == 0

RULE B_3N_4H_PASS_2812_0:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '3NT'
  CONDITION: opp_last_call == '4H'
  CONDITION: passes_since_last_bid == 0

RULE B_1N_4S_PASS_2813_0:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1NT'
  CONDITION: opp_last_call == '4S'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp <= 9

RULE B_1N_4S_X_2821_0:
  CALL: X
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1NT'
  CONDITION: opp_last_call == '4S'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 10

RULE B_2N_4S_PASS_2822_0:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '2NT'
  CONDITION: opp_last_call == '4S'
  CONDITION: passes_since_last_bid == 0

RULE B_1N_2N_3H_2830_0:
  CALL: 3H
  PRIORITY: 20
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1NT'
  CONDITION: opp_last_call == '2NT'
  CONDITION: passes_since_last_bid == 0
  CONDITION: h_is_best_major == True
  CONDITION: heart_len >= 5
  CONDITION: heart_hcp >= 7
  CONDITION: heart_hcp <= 9

RULE B_1N_2N_3S_2831_0:
  CALL: 3S
  PRIORITY: 20
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1NT'
  CONDITION: opp_last_call == '2NT'
  CONDITION: passes_since_last_bid == 0
  CONDITION: s_is_best_major == True
  CONDITION: spade_len >= 5
  CONDITION: spade_hcp >= 7
  CONDITION: spade_hcp <= 9

RULE B_5D_PASS_2835_0:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: opp_last_call == '5D'
  CONDITION: partner_last_call == 'NONE'

RULE B_1C_6S_PASS_2855_0:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1C'
  CONDITION: opp_last_call == '6S'
  CONDITION: passes_since_last_bid == 0

RULE B_1C_7S_PASS_2856_0:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1C'
  CONDITION: opp_last_call == '7S'
  CONDITION: passes_since_last_bid == 0

RULE B_1D_6C_PASS_2857_0:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1D'
  CONDITION: opp_last_call == '6C'
  CONDITION: passes_since_last_bid == 0

RULE B_1D_6H_PASS_2858_0:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1D'
  CONDITION: opp_last_call == '6H'
  CONDITION: passes_since_last_bid == 0

RULE B_1D_6S_PASS_2859_0:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1D'
  CONDITION: opp_last_call == '6S'
  CONDITION: passes_since_last_bid == 0

RULE B_1D_7H_PASS_2860_0:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1D'
  CONDITION: opp_last_call == '7H'
  CONDITION: passes_since_last_bid == 0

RULE B_1D_7S_PASS_2861_0:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1D'
  CONDITION: opp_last_call == '7S'
  CONDITION: passes_since_last_bid == 0

RULE B_1H_6D_PASS_2862_0:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1H'
  CONDITION: opp_last_call == '6D'
  CONDITION: passes_since_last_bid == 0

RULE B_1S_6C_PASS_2863_0:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1S'
  CONDITION: opp_last_call == '6C'
  CONDITION: passes_since_last_bid == 0

RULE B_1S_6D_PASS_2864_0:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1S'
  CONDITION: opp_last_call == '6D'
  CONDITION: passes_since_last_bid == 0

RULE B_1S_6H_PASS_2865_0:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1S'
  CONDITION: opp_last_call == '6H'
  CONDITION: passes_since_last_bid == 0

RULE B_2C_4S_PASS_2866_0:
  CALL: PASS
  PRIORITY: 20
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '2C'
  CONDITION: opp_last_call == '4S'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 8

RULE B_2C_4S_X_2867_0:
  CALL: X
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '2C'
  CONDITION: opp_last_call == '4S'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp <= 7

RULE B_2D_6S_PASS_2868_0:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '2D'
  CONDITION: opp_last_call == '6S'
  CONDITION: passes_since_last_bid == 0

RULE B_2H_X_2S_2870_0:
  CALL: 2S
  PRIORITY: 68
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '2H'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 13
  CONDITION: spade_len >= 5
  CONDITION: s_is_longest == True
  CONDITION: heart_len <= 1

RULE B_2H_X_2NT_2871_0:
  CALL: 2NT
  PRIORITY: 60
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '2H'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 15

RULE B_2H_X_2NT_2871_1:
  CALL: 2NT
  PRIORITY: 60
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '2H'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 13
  CONDITION: controls >= 5

RULE B_2H_X_3C_2872_0:
  CALL: 3C
  PRIORITY: 22
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '2H'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 0
  CONDITION: c_is_best_minor == True
  CONDITION: club_len >= 5
  CONDITION: hcp >= 17

RULE B_2H_X_3D_2873_0:
  CALL: 3D
  PRIORITY: 22
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '2H'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 0
  CONDITION: d_is_best_minor == True
  CONDITION: diamond_len >= 5
  CONDITION: hcp >= 17

RULE B_2H_X_3H_2874_0:
  CALL: 3H
  PRIORITY: 40
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '2H'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 0
  CONDITION: heart_hcp >= 6
  CONDITION: hcp <= 9
  CONDITION: heart_len >= 3

RULE B_2H_X_6H_2883_0:
  CALL: 6H
  PRIORITY: 105
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '2H'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 0
  CONDITION: heart_len >= 2
  CONDITION: h_realsolid == True
  CONDITION: losing_trick_count == 1

RULE B_2H_X_7H_2885_0:
  CALL: 7H
  PRIORITY: 106
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '2H'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 0
  CONDITION: heart_len >= 2
  CONDITION: h_realsolid == True
  CONDITION: losing_trick_count <= 0

RULE B_2H_4D_PASS_2888_0:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '2H'
  CONDITION: opp_last_call == '4D'
  CONDITION: passes_since_last_bid == 0

RULE B_2H_4D_4H_2889_0:
  CALL: 4H
  PRIORITY: 70
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '2H'
  CONDITION: opp_last_call == '4D'
  CONDITION: passes_since_last_bid == 0
  CONDITION: heart_len >= 4
  CONDITION: hcp >= 6

RULE B_2H_6D_PASS_2890_0:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '2H'
  CONDITION: opp_last_call == '6D'
  CONDITION: passes_since_last_bid == 0

RULE B_2H_7D_PASS_2891_0:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '2H'
  CONDITION: opp_last_call == '7D'
  CONDITION: passes_since_last_bid == 0

RULE B_2S_X_2NT_2893_0:
  CALL: 2NT
  PRIORITY: 60
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '2S'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 15

RULE B_2S_X_2NT_2893_1:
  CALL: 2NT
  PRIORITY: 60
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '2S'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 13
  CONDITION: controls >= 5

RULE B_2S_X_3C_2894_0:
  CALL: 3C
  PRIORITY: 22
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '2S'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 0
  CONDITION: c_is_best_minor == True
  CONDITION: club_len >= 5
  CONDITION: hcp >= 17

RULE B_2S_X_3D_2895_0:
  CALL: 3D
  PRIORITY: 22
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '2S'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 0
  CONDITION: d_is_best_minor == True
  CONDITION: diamond_len >= 5
  CONDITION: hcp >= 17

RULE B_2S_X_3H_2896_0:
  CALL: 3H
  PRIORITY: 69
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '2S'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 17
  CONDITION: heart_len >= 6

RULE B_2S_X_3S_2897_0:
  CALL: 3S
  PRIORITY: 40
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '2S'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 0
  CONDITION: spade_hcp >= 6
  CONDITION: hcp <= 9
  CONDITION: spade_len >= 3

RULE B_2S_X_6S_2905_0:
  CALL: 6S
  PRIORITY: 105
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '2S'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 0
  CONDITION: spade_len >= 2
  CONDITION: s_realsolid == True
  CONDITION: losing_trick_count == 1

RULE B_2S_X_7S_2907_0:
  CALL: 7S
  PRIORITY: 106
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '2S'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 0
  CONDITION: spade_len >= 2
  CONDITION: s_realsolid == True
  CONDITION: losing_trick_count <= 0

RULE B_2S_4D_PASS_2910_0:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '2S'
  CONDITION: opp_last_call == '4D'
  CONDITION: passes_since_last_bid == 0

RULE B_2S_4D_4S_2911_0:
  CALL: 4S
  PRIORITY: 70
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '2S'
  CONDITION: opp_last_call == '4D'
  CONDITION: passes_since_last_bid == 0
  CONDITION: spade_len >= 4
  CONDITION: hcp >= 6

RULE B_2S_4S_PASS_2912_0:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '2S'
  CONDITION: opp_last_call == '4S'
  CONDITION: passes_since_last_bid == 0

RULE B_2S_6C_PASS_2913_0:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '2S'
  CONDITION: opp_last_call == '6C'
  CONDITION: passes_since_last_bid == 0

RULE B_2S_6D_PASS_2914_0:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '2S'
  CONDITION: opp_last_call == '6D'
  CONDITION: passes_since_last_bid == 0

RULE B_2S_6H_PASS_2915_0:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '2S'
  CONDITION: opp_last_call == '6H'
  CONDITION: passes_since_last_bid == 0

RULE B_2S_7C_PASS_2916_0:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '2S'
  CONDITION: opp_last_call == '7C'
  CONDITION: passes_since_last_bid == 0

RULE B_2S_7D_PASS_2917_0:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '2S'
  CONDITION: opp_last_call == '7D'
  CONDITION: passes_since_last_bid == 0

RULE B_3C_6S_PASS_2918_0:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '3C'
  CONDITION: opp_last_call == '6S'
  CONDITION: passes_since_last_bid == 0

RULE B_3D_6H_PASS_2919_0:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '3D'
  CONDITION: opp_last_call == '6H'
  CONDITION: passes_since_last_bid == 0

RULE B_3D_6S_PASS_2920_0:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '3D'
  CONDITION: opp_last_call == '6S'
  CONDITION: passes_since_last_bid == 0

RULE B_3H_X_PASS_2921_0:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '3H'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 0

RULE B_3H_X_3NT_2922_0:
  CALL: 3NT
  PRIORITY: 40
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '3H'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 15

RULE B_3H_X_4H_2928_0:
  CALL: 4H
  PRIORITY: 59
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '3H'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 0
  CONDITION: heart_len >= 3
  CONDITION: total_points >= 7

RULE B_3H_X_4H_2929_0:
  CALL: 4H
  PRIORITY: 60
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '3H'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 0
  CONDITION: heart_len >= 2
  CONDITION: total_points >= 9

RULE B_3H_X_4S_2930_1:
  CALL: 4S
  PRIORITY: 47
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '3H'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 0
  CONDITION: losing_trick_count <= 3
  CONDITION: spade_len >= 6

RULE B_3H_X_6H_2941_0:
  CALL: 6H
  PRIORITY: 75
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '3H'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 0
  CONDITION: h_realsolid == True
  CONDITION: losing_trick_count == 1

RULE B_3H_X_7H_2943_0:
  CALL: 7H
  PRIORITY: 76
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '3H'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 0
  CONDITION: h_realsolid == True
  CONDITION: losing_trick_count <= 0

RULE B_3H_4D_4H_2947_0:
  CALL: 4H
  PRIORITY: 70
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '3H'
  CONDITION: opp_last_call == '4D'
  CONDITION: passes_since_last_bid == 0
  CONDITION: heart_len >= 3
  CONDITION: heart_hcp >= 10

RULE B_3H_6D_PASS_2948_0:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '3H'
  CONDITION: opp_last_call == '6D'
  CONDITION: passes_since_last_bid == 0

RULE B_3S_4D_4S_2950_0:
  CALL: 4S
  PRIORITY: 70
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '3S'
  CONDITION: opp_last_call == '4D'
  CONDITION: passes_since_last_bid == 0
  CONDITION: spade_len >= 3
  CONDITION: spade_hcp >= 10

RULE B_3S_6C_PASS_2952_0:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '3S'
  CONDITION: opp_last_call == '6C'
  CONDITION: passes_since_last_bid == 0

RULE B_3S_6D_PASS_2953_0:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '3S'
  CONDITION: opp_last_call == '6D'
  CONDITION: passes_since_last_bid == 0

RULE B_3S_6H_PASS_2954_0:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '3S'
  CONDITION: opp_last_call == '6H'
  CONDITION: passes_since_last_bid == 0

RULE B_4C_X_PASS_2956_0:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '4C'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp <= 16

RULE B_4C_X_PASS_2956_1:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '4C'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 0
  CONDITION: ace_count <= 1

RULE B_4C_X_4H_2957_0:
  CALL: 4H
  PRIORITY: 70
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '4C'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 0
  CONDITION: heart_len >= 7
  CONDITION: total_points >= 17

RULE B_4C_X_4S_2958_0:
  CALL: 4S
  PRIORITY: 70
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '4C'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 0
  CONDITION: spade_len >= 7
  CONDITION: total_points >= 17

RULE B_4C_X_5C_2961_1:
  CALL: 5C
  PRIORITY: 69
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '4C'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 0
  CONDITION: ace_count == 2
  CONDITION: hcp >= 16

RULE B_4C_X_5C_2961_2:
  CALL: 5C
  PRIORITY: 69
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '4C'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 0
  CONDITION: ace_count == 3
  CONDITION: hcp <= 17

RULE B_4C_X_6C_2963_0:
  CALL: 6C
  PRIORITY: 55
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '4C'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 0
  CONDITION: club_len >= 1
  CONDITION: ace_count >= 4

RULE B_4C_X_6C_2963_1:
  CALL: 6C
  PRIORITY: 55
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '4C'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 0
  CONDITION: club_len >= 2
  CONDITION: ace_count >= 4

RULE B_4C_X_6C_2963_2:
  CALL: 6C
  PRIORITY: 55
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '4C'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 0
  CONDITION: club_len >= 2
  CONDITION: hcp >= 20

RULE B_4C_X_6C_2963_3:
  CALL: 6C
  PRIORITY: 55
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '4C'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 0
  CONDITION: ace_count == 3
  CONDITION: hcp >= 18

RULE B_4C_X_6C_2965_0:
  CALL: 6C
  PRIORITY: 65
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '4C'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 0
  CONDITION: c_realsolid == True
  CONDITION: losing_trick_count == 1

RULE B_4C_X_7C_2967_0:
  CALL: 7C
  PRIORITY: 58
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '4C'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 0
  CONDITION: ace_count == 4
  CONDITION: hcp >= 20

RULE B_4C_X_7C_2968_0:
  CALL: 7C
  PRIORITY: 66
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '4C'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 0
  CONDITION: c_realsolid == True
  CONDITION: losing_trick_count <= 0

RULE B_4D_X_PASS_2971_0:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '4D'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp <= 16

RULE B_4D_X_PASS_2971_1:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '4D'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 0
  CONDITION: ace_count <= 1

RULE B_4D_X_4H_2972_0:
  CALL: 4H
  PRIORITY: 70
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '4D'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 0
  CONDITION: heart_len >= 7
  CONDITION: total_points >= 17

RULE B_4D_X_4S_2973_0:
  CALL: 4S
  PRIORITY: 70
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '4D'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 0
  CONDITION: spade_len >= 7
  CONDITION: total_points >= 17

RULE B_4D_X_5D_2976_1:
  CALL: 5D
  PRIORITY: 69
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '4D'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 0
  CONDITION: ace_count == 2
  CONDITION: hcp >= 16

RULE B_4D_X_5D_2976_2:
  CALL: 5D
  PRIORITY: 69
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '4D'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 0
  CONDITION: ace_count == 3
  CONDITION: hcp <= 17

RULE B_4D_X_6D_2978_0:
  CALL: 6D
  PRIORITY: 55
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '4D'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 0
  CONDITION: diamond_len >= 1
  CONDITION: ace_count >= 4

RULE B_4D_X_6D_2978_1:
  CALL: 6D
  PRIORITY: 55
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '4D'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 0
  CONDITION: diamond_len >= 2
  CONDITION: ace_count >= 4

RULE B_4D_X_6D_2978_2:
  CALL: 6D
  PRIORITY: 55
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '4D'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 0
  CONDITION: diamond_len >= 2
  CONDITION: hcp >= 20

RULE B_4D_X_6D_2978_3:
  CALL: 6D
  PRIORITY: 55
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '4D'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 0
  CONDITION: ace_count == 3
  CONDITION: hcp >= 18

RULE B_4D_X_6D_2980_0:
  CALL: 6D
  PRIORITY: 65
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '4D'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 0
  CONDITION: d_realsolid == True
  CONDITION: losing_trick_count == 1

RULE B_4D_X_7D_2982_0:
  CALL: 7D
  PRIORITY: 58
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '4D'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 0
  CONDITION: ace_count == 4
  CONDITION: hcp >= 20

RULE B_4D_X_7D_2983_0:
  CALL: 7D
  PRIORITY: 66
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '4D'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 0
  CONDITION: d_realsolid == True
  CONDITION: losing_trick_count <= 0

RULE B_4D_5D_PASS_2986_0:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '4D'
  CONDITION: opp_last_call == '5D'
  CONDITION: passes_since_last_bid == 0

RULE B_4H_X_PASS_2987_0:
  CALL: PASS
  PRIORITY: 20
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '4H'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 0
  CONDITION: ace_count <= 2

RULE B_4H_X_PASS_2987_1:
  CALL: PASS
  PRIORITY: 20
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '4H'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp <= 16

RULE B_4H_X_6H_2992_0:
  CALL: 6H
  PRIORITY: 15
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '4H'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 0
  CONDITION: h_realsolid == True
  CONDITION: losing_trick_count == 1

RULE B_4H_X_6H_2993_0:
  CALL: 6H
  PRIORITY: 30
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '4H'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 0
  CONDITION: ace_count >= 3
  CONDITION: hcp >= 17

RULE B_4H_X_7H_2995_0:
  CALL: 7H
  PRIORITY: 16
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '4H'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 0
  CONDITION: h_realsolid == True
  CONDITION: losing_trick_count <= 0

RULE B_4H_X_7H_2996_0:
  CALL: 7H
  PRIORITY: 40
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '4H'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 0
  CONDITION: ace_count == 4
  CONDITION: hcp >= 17

RULE B_4H_5D_PASS_2999_0:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '4H'
  CONDITION: opp_last_call == '5D'
  CONDITION: passes_since_last_bid == 0

RULE B_4S_5D_PASS_3002_0:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '4S'
  CONDITION: opp_last_call == '5D'
  CONDITION: passes_since_last_bid == 0

RULE B_4S_5H_PASS_3005_0:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '4S'
  CONDITION: opp_last_call == '5H'
  CONDITION: passes_since_last_bid == 0

RULE B_5C_X_PASS_3007_0:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '5C'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 0

RULE B_5C_5S_PASS_3010_0:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '5C'
  CONDITION: opp_last_call == '5S'
  CONDITION: passes_since_last_bid == 0

RULE B_5D_X_PASS_3012_0:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '5D'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 0

RULE B_5D_5H_PASS_3015_0:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '5D'
  CONDITION: opp_last_call == '5H'
  CONDITION: passes_since_last_bid == 0

RULE B_5D_5S_PASS_3017_0:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '5D'
  CONDITION: opp_last_call == '5S'
  CONDITION: passes_since_last_bid == 0

RULE B_5H_X_PASS_3019_0:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '5H'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 0

RULE B_5S_P_PASS_3022_0:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '5S'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 1

RULE B_5S_X_PASS_3025_0:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '5S'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 0

RULE B_6C_X_PASS_3028_0:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '6C'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 0

RULE B_6D_P_PASS_3029_0:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '6D'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 1

RULE B_6D_X_PASS_3030_0:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '6D'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 0

RULE B_6H_P_PASS_3031_0:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '6H'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 1

RULE B_6H_X_PASS_3032_0:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '6H'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 0

RULE B_6S_P_PASS_3033_0:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '6S'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 1

RULE B_6S_X_PASS_3034_0:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '6S'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 0

RULE B_7C_P_PASS_3035_0:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '7C'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 1

RULE B_7C_X_PASS_3036_0:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '7C'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 0

RULE B_7D_P_PASS_3037_0:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '7D'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 1

RULE B_7D_X_PASS_3038_0:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '7D'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 0

RULE B_7H_P_PASS_3039_0:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '7H'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 1

RULE B_7H_X_PASS_3040_0:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '7H'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 0

RULE B_7S_P_PASS_3041_0:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '7S'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 1

RULE B_7S_X_PASS_3042_0:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '7S'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 0

RULE B_6N_P_PASS_3043_0:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '6NT'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 1

RULE B_7N_P_PASS_3044_0:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '7NT'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 1

RULE B_6N_X_PASS_3045_0:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '6NT'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 0

RULE B_3N_4C_PASS_3046_0:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '3NT'
  CONDITION: opp_last_call == '4C'
  CONDITION: passes_since_last_bid == 0

RULE B_2N_4D_PASS_3047_0:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '2NT'
  CONDITION: opp_last_call == '4D'
  CONDITION: passes_since_last_bid == 0

RULE B_3N_4D_PASS_3050_0:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '3NT'
  CONDITION: opp_last_call == '4D'
  CONDITION: passes_since_last_bid == 0

RULE B_3N_4S_PASS_3051_0:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '3NT'
  CONDITION: opp_last_call == '4S'
  CONDITION: passes_since_last_bid == 0

# ----------------------------------------------------------
# Part 1 supplement — openings taken from brill.md's PROSE
# summary, because every tree rule for them depended on atoms
# the DSL cannot express (Opening1H/1S, ruleof21, loserlevel).
# Quoted verbatim from the '### Openings' table; priorities are
# Brill's own for these calls.  Without these, brill.dsl cannot
# open 1H, 1S, a weak two or a 3-level preempt at all.
# ----------------------------------------------------------

RULE BR_PROSE_OPEN_1H_0:
  CALL: 1H
  PRIORITY: 70
  CONDITION: is_opening == True
  CONDITION: partner_last_call == 'NONE'
  CONDITION: my_last_call == 'NONE'
  CONDITION: hcp >= 12
  CONDITION: hcp <= 21
  CONDITION: heart_len >= 5

RULE BR_PROSE_OPEN_1H_1:
  CALL: 1H
  PRIORITY: 69
  CONDITION: is_opening == True
  CONDITION: partner_last_call == 'NONE'
  CONDITION: my_last_call == 'NONE'
  CONDITION: hcp == 11
  CONDITION: heart_len >= 6

RULE BR_PROSE_OPEN_1H_2:
  CALL: 1H
  PRIORITY: 69
  CONDITION: is_opening == True
  CONDITION: partner_last_call == 'NONE'
  CONDITION: my_last_call == 'NONE'
  CONDITION: hcp == 11
  CONDITION: heart_len >= 5
  CONDITION: spade_len >= 4

RULE BR_PROSE_OPEN_1S_3:
  CALL: 1S
  PRIORITY: 75
  CONDITION: is_opening == True
  CONDITION: partner_last_call == 'NONE'
  CONDITION: my_last_call == 'NONE'
  CONDITION: hcp >= 12
  CONDITION: hcp <= 21
  CONDITION: spade_len >= 5

RULE BR_PROSE_OPEN_1S_4:
  CALL: 1S
  PRIORITY: 74
  CONDITION: is_opening == True
  CONDITION: partner_last_call == 'NONE'
  CONDITION: my_last_call == 'NONE'
  CONDITION: hcp == 11
  CONDITION: spade_len >= 6

RULE BR_PROSE_OPEN_1S_5:
  CALL: 1S
  PRIORITY: 74
  CONDITION: is_opening == True
  CONDITION: partner_last_call == 'NONE'
  CONDITION: my_last_call == 'NONE'
  CONDITION: hcp == 11
  CONDITION: spade_len >= 5
  CONDITION: heart_len >= 4

RULE BR_PROSE_OPEN_2D_6:
  CALL: 2D
  PRIORITY: 60
  CONDITION: is_opening == True
  CONDITION: partner_last_call == 'NONE'
  CONDITION: my_last_call == 'NONE'
  CONDITION: diamond_len == 6
  CONDITION: hcp >= 5
  CONDITION: hcp <= 11
  CONDITION: heart_len <= 3
  CONDITION: spade_len <= 3

RULE BR_PROSE_OPEN_2H_7:
  CALL: 2H
  PRIORITY: 60
  CONDITION: is_opening == True
  CONDITION: partner_last_call == 'NONE'
  CONDITION: my_last_call == 'NONE'
  CONDITION: heart_len == 6
  CONDITION: hcp >= 5
  CONDITION: hcp <= 11
  CONDITION: spade_len <= 3

RULE BR_PROSE_OPEN_2S_8:
  CALL: 2S
  PRIORITY: 60
  CONDITION: is_opening == True
  CONDITION: partner_last_call == 'NONE'
  CONDITION: my_last_call == 'NONE'
  CONDITION: spade_len == 6
  CONDITION: hcp >= 5
  CONDITION: hcp <= 11
  CONDITION: heart_len <= 3

RULE BR_PROSE_OPEN_3C_9:
  CALL: 3C
  PRIORITY: 85
  CONDITION: is_opening == True
  CONDITION: partner_last_call == 'NONE'
  CONDITION: my_last_call == 'NONE'
  CONDITION: club_len >= 7
  CONDITION: hcp >= 5
  CONDITION: hcp <= 11
  CONDITION: heart_len <= 3
  CONDITION: spade_len <= 3

RULE BR_PROSE_OPEN_3D_10:
  CALL: 3D
  PRIORITY: 86
  CONDITION: is_opening == True
  CONDITION: partner_last_call == 'NONE'
  CONDITION: my_last_call == 'NONE'
  CONDITION: diamond_len >= 7
  CONDITION: hcp >= 5
  CONDITION: hcp <= 11
  CONDITION: heart_len <= 3
  CONDITION: spade_len <= 3

RULE BR_PROSE_OPEN_3H_11:
  CALL: 3H
  PRIORITY: 87
  CONDITION: is_opening == True
  CONDITION: partner_last_call == 'NONE'
  CONDITION: my_last_call == 'NONE'
  CONDITION: heart_len >= 7
  CONDITION: hcp >= 5
  CONDITION: hcp <= 11
  CONDITION: spade_len <= 3

RULE BR_PROSE_OPEN_3S_12:
  CALL: 3S
  PRIORITY: 88
  CONDITION: is_opening == True
  CONDITION: partner_last_call == 'NONE'
  CONDITION: my_last_call == 'NONE'
  CONDITION: spade_len >= 7
  CONDITION: hcp >= 5
  CONDITION: hcp <= 11
  CONDITION: heart_len <= 3

