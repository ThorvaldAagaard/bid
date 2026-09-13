# ==========================================================
# BRILL BIDDING SYSTEM — converted from system/brill.md
#
# Source : https://brillsystem.aalborgdata.dk/
#         Brill 0.1.0+20260912.0835.g9eb75e9-dirty
#         (1,037,464 rules in the live engine)
# Convert: python3 research/brill_to_dsl.py
#
# 3515 Brill call definitions -> 1830 DSL rules.
#
# CAVEATS — read before trusting this file:
#   * Only the tree 2 calls deep was captured.
#   * Clauses containing atoms with no DSL equivalent are
#     DROPPED, never relaxed.  Brill's own computed verdicts
#     (game / slammish / CanBid6_* / CanAsk_*_RKC / loserlevel)
#     and its suit-quality tests (realsolid / trump /
#     rebiddable / monsterslam) are NOT reproduced.  The system
#     here is therefore thinner than Brill, especially for
#     slams and sacrifices — it will underbid rather than
#     overbid, which is the safe direction.
#   * Approximations in use:
#       losers        -> losing_trick_count
#       X_points      -> X_hcp
#       balish        -> is_semi_balanced
#       stopper('X')  -> X_stopper >= 2
#   * Dropped entirely (needs a feature-to-feature compare):
#       Xlongest / bestsuit(X) / bestmajor(X) / bestminor(X)
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

RULE B_P_1C_1_5:
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

RULE B_P_1C_1_6:
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

RULE B_P_1C_1_7:
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

RULE B_P_1D_2_3:
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

RULE B_P_1NT_9_3:
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

RULE B_P_2C_10_0:
  CALL: 2C
  PRIORITY: 112
  CONDITION: is_opening == True
  CONDITION: partner_last_call == 'NONE'
  CONDITION: my_last_call == 'NONE'
  CONDITION: losing_trick_count <= 1
  CONDITION: hcp >= 16

RULE B_P_2C_11_0:
  CALL: 2C
  PRIORITY: 113
  CONDITION: is_opening == True
  CONDITION: partner_last_call == 'NONE'
  CONDITION: my_last_call == 'NONE'
  CONDITION: losing_trick_count <= 2
  CONDITION: hcp >= 16
  CONDITION: longest_suit_len >= 5

RULE B_P_2C_12_8:
  CALL: 2C
  PRIORITY: 118
  CONDITION: is_opening == True
  CONDITION: partner_last_call == 'NONE'
  CONDITION: my_last_call == 'NONE'
  CONDITION: hcp >= 22
  CONDITION: is_balanced == True

RULE B_P_2C_12_9:
  CALL: 2C
  PRIORITY: 118
  CONDITION: is_opening == True
  CONDITION: partner_last_call == 'NONE'
  CONDITION: my_last_call == 'NONE'
  CONDITION: hcp >= 22
  CONDITION: is_semi_balanced == True

RULE B_P_2C_12_10:
  CALL: 2C
  PRIORITY: 118
  CONDITION: is_opening == True
  CONDITION: partner_last_call == 'NONE'
  CONDITION: my_last_call == 'NONE'
  CONDITION: hcp >= 22
  CONDITION: losing_trick_count <= 5

RULE B_P_2NT_16_0:
  CALL: 2NT
  PRIORITY: 122
  CONDITION: is_opening == True
  CONDITION: partner_last_call == 'NONE'
  CONDITION: my_last_call == 'NONE'
  CONDITION: is_semi_balanced == True
  CONDITION: hcp >= 20
  CONDITION: hcp <= 21

RULE B_P_3NT_25_0:
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

RULE B_P_6C_34_0:
  CALL: 6C
  PRIORITY: 10
  CONDITION: is_opening == True
  CONDITION: partner_last_call == 'NONE'
  CONDITION: my_last_call == 'NONE'
  CONDITION: club_len >= 9
  CONDITION: total_points >= 32

RULE B_P_6D_35_0:
  CALL: 6D
  PRIORITY: 11
  CONDITION: is_opening == True
  CONDITION: partner_last_call == 'NONE'
  CONDITION: my_last_call == 'NONE'
  CONDITION: diamond_len >= 9
  CONDITION: total_points >= 32

RULE B_P_6H_36_0:
  CALL: 6H
  PRIORITY: 12
  CONDITION: is_opening == True
  CONDITION: partner_last_call == 'NONE'
  CONDITION: my_last_call == 'NONE'
  CONDITION: heart_len >= 9
  CONDITION: total_points >= 32

RULE B_P_6S_37_0:
  CALL: 6S
  PRIORITY: 13
  CONDITION: is_opening == True
  CONDITION: partner_last_call == 'NONE'
  CONDITION: my_last_call == 'NONE'
  CONDITION: spade_len >= 9
  CONDITION: total_points >= 32

RULE B_P_6NT_38_0:
  CALL: 6NT
  PRIORITY: 14
  CONDITION: is_opening == True
  CONDITION: partner_last_call == 'NONE'
  CONDITION: my_last_call == 'NONE'
  CONDITION: is_balanced == True
  CONDITION: hcp >= 33
  CONDITION: hcp <= 34

RULE B_P_7C_39_0:
  CALL: 7C
  PRIORITY: 15
  CONDITION: is_opening == True
  CONDITION: partner_last_call == 'NONE'
  CONDITION: my_last_call == 'NONE'
  CONDITION: club_len >= 9
  CONDITION: hcp >= 31
  CONDITION: total_points >= 35

RULE B_P_7D_40_0:
  CALL: 7D
  PRIORITY: 23
  CONDITION: is_opening == True
  CONDITION: partner_last_call == 'NONE'
  CONDITION: my_last_call == 'NONE'
  CONDITION: diamond_len >= 9
  CONDITION: hcp >= 31
  CONDITION: total_points >= 35

RULE B_P_7H_41_0:
  CALL: 7H
  PRIORITY: 24
  CONDITION: is_opening == True
  CONDITION: partner_last_call == 'NONE'
  CONDITION: my_last_call == 'NONE'
  CONDITION: heart_len >= 9
  CONDITION: hcp >= 31
  CONDITION: total_points >= 35

RULE B_P_7S_42_0:
  CALL: 7S
  PRIORITY: 25
  CONDITION: is_opening == True
  CONDITION: partner_last_call == 'NONE'
  CONDITION: my_last_call == 'NONE'
  CONDITION: spade_len >= 9
  CONDITION: hcp >= 31
  CONDITION: total_points >= 35

RULE B_P_7NT_43_0:
  CALL: 7NT
  PRIORITY: 26
  CONDITION: is_opening == True
  CONDITION: partner_last_call == 'NONE'
  CONDITION: my_last_call == 'NONE'
  CONDITION: is_balanced == True
  CONDITION: hcp >= 36
  CONDITION: total_points >= 35

RULE B_1C_PASS_44_0:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: opp_last_call == '1C'
  CONDITION: partner_last_call == 'NONE'

RULE B_1C_PASS_44_1:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: opp_last_call == '1C'
  CONDITION: partner_last_call == 'NONE'
  CONDITION: club_len >= 7

RULE B_1C_1NT_48_0:
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

RULE B_1C_1NT_48_1:
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

RULE B_1C_1NT_48_2:
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

RULE B_1C_1NT_48_3:
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

RULE B_1C_1NT_48_4:
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

RULE B_1C_1NT_48_5:
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

RULE B_1C_4H_64_0_0:
  CALL: 4H
  PRIORITY: 91
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: opp_last_call == '1C'
  CONDITION: partner_last_call == 'NONE'
  CONDITION: heart_len >= 8
  CONDITION: hcp <= 10
  CONDITION: h_has_ace == True

RULE B_1C_4H_64_0_1:
  CALL: 4H
  PRIORITY: 91
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: opp_last_call == '1C'
  CONDITION: partner_last_call == 'NONE'
  CONDITION: heart_len >= 8
  CONDITION: hcp <= 10
  CONDITION: h_has_king == True

RULE B_1C_4H_64_0_2:
  CALL: 4H
  PRIORITY: 91
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: opp_last_call == '1C'
  CONDITION: partner_last_call == 'NONE'
  CONDITION: heart_len >= 8
  CONDITION: hcp <= 10
  CONDITION: h_has_queen == True

RULE B_1C_4H_64_0_3:
  CALL: 4H
  PRIORITY: 91
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: opp_last_call == '1C'
  CONDITION: partner_last_call == 'NONE'
  CONDITION: heart_len >= 8
  CONDITION: hcp <= 10
  CONDITION: h_has_jack == True

RULE B_1C_4H_64_0_4:
  CALL: 4H
  PRIORITY: 91
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: opp_last_call == '1C'
  CONDITION: partner_last_call == 'NONE'
  CONDITION: heart_len >= 8
  CONDITION: hcp <= 10
  CONDITION: h_has_ten == True

RULE B_1C_4S_68_0_0:
  CALL: 4S
  PRIORITY: 91
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: opp_last_call == '1C'
  CONDITION: partner_last_call == 'NONE'
  CONDITION: spade_len >= 8
  CONDITION: hcp <= 10
  CONDITION: s_has_ace == True

RULE B_1C_4S_68_0_1:
  CALL: 4S
  PRIORITY: 91
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: opp_last_call == '1C'
  CONDITION: partner_last_call == 'NONE'
  CONDITION: spade_len >= 8
  CONDITION: hcp <= 10
  CONDITION: s_has_king == True

RULE B_1C_4S_68_0_2:
  CALL: 4S
  PRIORITY: 91
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: opp_last_call == '1C'
  CONDITION: partner_last_call == 'NONE'
  CONDITION: spade_len >= 8
  CONDITION: hcp <= 10
  CONDITION: s_has_queen == True

RULE B_1C_4S_68_0_3:
  CALL: 4S
  PRIORITY: 91
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: opp_last_call == '1C'
  CONDITION: partner_last_call == 'NONE'
  CONDITION: spade_len >= 8
  CONDITION: hcp <= 10
  CONDITION: s_has_jack == True

RULE B_1C_4S_68_0_4:
  CALL: 4S
  PRIORITY: 91
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: opp_last_call == '1C'
  CONDITION: partner_last_call == 'NONE'
  CONDITION: spade_len >= 8
  CONDITION: hcp <= 10
  CONDITION: s_has_ten == True

RULE B_1C_X_78_1:
  CALL: X
  PRIORITY: 74
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: opp_last_call == '1C'
  CONDITION: partner_last_call == 'NONE'
  CONDITION: hcp >= 18

RULE B_1C_X_78_3:
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

RULE B_1D_PASS_79_0:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: opp_last_call == '1D'
  CONDITION: partner_last_call == 'NONE'

RULE B_1D_PASS_79_1:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: opp_last_call == '1D'
  CONDITION: partner_last_call == 'NONE'
  CONDITION: diamond_len >= 7

RULE B_1D_1NT_82_0:
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

RULE B_1D_1NT_82_1:
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

RULE B_1D_1NT_82_2:
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

RULE B_1D_1NT_82_3:
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

RULE B_1D_1NT_82_4:
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

RULE B_1D_1NT_82_5:
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

RULE B_1D_4H_98_0_0:
  CALL: 4H
  PRIORITY: 91
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: opp_last_call == '1D'
  CONDITION: partner_last_call == 'NONE'
  CONDITION: heart_len >= 8
  CONDITION: hcp <= 10
  CONDITION: h_has_ace == True

RULE B_1D_4H_98_0_1:
  CALL: 4H
  PRIORITY: 91
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: opp_last_call == '1D'
  CONDITION: partner_last_call == 'NONE'
  CONDITION: heart_len >= 8
  CONDITION: hcp <= 10
  CONDITION: h_has_king == True

RULE B_1D_4H_98_0_2:
  CALL: 4H
  PRIORITY: 91
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: opp_last_call == '1D'
  CONDITION: partner_last_call == 'NONE'
  CONDITION: heart_len >= 8
  CONDITION: hcp <= 10
  CONDITION: h_has_queen == True

RULE B_1D_4H_98_0_3:
  CALL: 4H
  PRIORITY: 91
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: opp_last_call == '1D'
  CONDITION: partner_last_call == 'NONE'
  CONDITION: heart_len >= 8
  CONDITION: hcp <= 10
  CONDITION: h_has_jack == True

RULE B_1D_4H_98_0_4:
  CALL: 4H
  PRIORITY: 91
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: opp_last_call == '1D'
  CONDITION: partner_last_call == 'NONE'
  CONDITION: heart_len >= 8
  CONDITION: hcp <= 10
  CONDITION: h_has_ten == True

RULE B_1D_4S_102_0_0:
  CALL: 4S
  PRIORITY: 91
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: opp_last_call == '1D'
  CONDITION: partner_last_call == 'NONE'
  CONDITION: spade_len >= 8
  CONDITION: hcp <= 10
  CONDITION: s_has_ace == True

RULE B_1D_4S_102_0_1:
  CALL: 4S
  PRIORITY: 91
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: opp_last_call == '1D'
  CONDITION: partner_last_call == 'NONE'
  CONDITION: spade_len >= 8
  CONDITION: hcp <= 10
  CONDITION: s_has_king == True

RULE B_1D_4S_102_0_2:
  CALL: 4S
  PRIORITY: 91
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: opp_last_call == '1D'
  CONDITION: partner_last_call == 'NONE'
  CONDITION: spade_len >= 8
  CONDITION: hcp <= 10
  CONDITION: s_has_queen == True

RULE B_1D_4S_102_0_3:
  CALL: 4S
  PRIORITY: 91
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: opp_last_call == '1D'
  CONDITION: partner_last_call == 'NONE'
  CONDITION: spade_len >= 8
  CONDITION: hcp <= 10
  CONDITION: s_has_jack == True

RULE B_1D_4S_102_0_4:
  CALL: 4S
  PRIORITY: 91
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: opp_last_call == '1D'
  CONDITION: partner_last_call == 'NONE'
  CONDITION: spade_len >= 8
  CONDITION: hcp <= 10
  CONDITION: s_has_ten == True

RULE B_1D_X_112_1:
  CALL: X
  PRIORITY: 74
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: opp_last_call == '1D'
  CONDITION: partner_last_call == 'NONE'
  CONDITION: hcp >= 18

RULE B_1D_X_112_3:
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

RULE B_1H_PASS_113_0:
  CALL: PASS
  PRIORITY: 1
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: opp_last_call == '1H'
  CONDITION: partner_last_call == 'NONE'

RULE B_1H_PASS_113_1:
  CALL: PASS
  PRIORITY: 1
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: opp_last_call == '1H'
  CONDITION: partner_last_call == 'NONE'
  CONDITION: heart_len >= 6

RULE B_1H_1S_114_0:
  CALL: 1S
  PRIORITY: 60
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: opp_last_call == '1H'
  CONDITION: partner_last_call == 'NONE'
  CONDITION: spade_len >= 5
  CONDITION: hcp >= 8
  CONDITION: hcp <= 17

RULE B_1H_1NT_115_0:
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

RULE B_1H_1NT_115_1:
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

RULE B_1H_X_143_0:
  CALL: X
  PRIORITY: 76
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: opp_last_call == '1H'
  CONDITION: partner_last_call == 'NONE'
  CONDITION: hcp >= 18
  CONDITION: heart_len <= 4

RULE B_1H_X_143_1:
  CALL: X
  PRIORITY: 76
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: opp_last_call == '1H'
  CONDITION: partner_last_call == 'NONE'
  CONDITION: hcp >= 18
  CONDITION: is_balanced == True

RULE B_1H_X_143_2:
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

RULE B_1S_PASS_144_0:
  CALL: PASS
  PRIORITY: 1
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: opp_last_call == '1S'
  CONDITION: partner_last_call == 'NONE'

RULE B_1S_PASS_144_1:
  CALL: PASS
  PRIORITY: 1
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: opp_last_call == '1S'
  CONDITION: partner_last_call == 'NONE'
  CONDITION: spade_len >= 6

RULE B_1S_1NT_145_0:
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

RULE B_1S_1NT_145_1:
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

RULE B_1S_X_173_0:
  CALL: X
  PRIORITY: 76
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: opp_last_call == '1S'
  CONDITION: partner_last_call == 'NONE'
  CONDITION: hcp >= 18
  CONDITION: spade_len <= 4

RULE B_1S_X_173_1:
  CALL: X
  PRIORITY: 76
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: opp_last_call == '1S'
  CONDITION: partner_last_call == 'NONE'
  CONDITION: hcp >= 18
  CONDITION: is_balanced == True

RULE B_1S_X_173_2:
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

RULE B_2C_PASS_174_0:
  CALL: PASS
  PRIORITY: -1
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: opp_last_call == '2C'
  CONDITION: partner_last_call == 'NONE'

RULE B_2D_PASS_189_0:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: opp_last_call == '2D'
  CONDITION: partner_last_call == 'NONE'
  CONDITION: hcp <= 15

RULE B_2D_PASS_189_1:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: opp_last_call == '2D'
  CONDITION: partner_last_call == 'NONE'
  CONDITION: diamond_len >= 5

RULE B_2D_2NT_192_0:
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

RULE B_2D_3H_195_0:
  CALL: 3H
  PRIORITY: 93
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: opp_last_call == '2D'
  CONDITION: partner_last_call == 'NONE'
  CONDITION: heart_len >= 7
  CONDITION: hcp >= 19

RULE B_2D_3S_196_0:
  CALL: 3S
  PRIORITY: 93
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: opp_last_call == '2D'
  CONDITION: partner_last_call == 'NONE'
  CONDITION: spade_len >= 7
  CONDITION: hcp >= 19

RULE B_2D_3NT_197_0:
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

RULE B_2D_4C_198_0:
  CALL: 4C
  PRIORITY: 95
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: opp_last_call == '2D'
  CONDITION: partner_last_call == 'NONE'
  CONDITION: club_len >= 7
  CONDITION: hcp >= 19
  CONDITION: hcp <= 24

RULE B_2D_4H_199_0:
  CALL: 4H
  PRIORITY: 97
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: opp_last_call == '2D'
  CONDITION: partner_last_call == 'NONE'
  CONDITION: heart_len >= 7
  CONDITION: hcp >= 12
  CONDITION: hcp <= 14

RULE B_2D_4H_199_1:
  CALL: 4H
  PRIORITY: 97
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: opp_last_call == '2D'
  CONDITION: partner_last_call == 'NONE'
  CONDITION: heart_len >= 7
  CONDITION: losing_trick_count <= 3
  CONDITION: hcp <= 15

RULE B_2D_4S_200_0:
  CALL: 4S
  PRIORITY: 97
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: opp_last_call == '2D'
  CONDITION: partner_last_call == 'NONE'
  CONDITION: spade_len >= 7
  CONDITION: hcp >= 12
  CONDITION: hcp <= 14

RULE B_2D_4S_200_1:
  CALL: 4S
  PRIORITY: 97
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: opp_last_call == '2D'
  CONDITION: partner_last_call == 'NONE'
  CONDITION: spade_len >= 7
  CONDITION: losing_trick_count <= 3
  CONDITION: hcp <= 15

RULE B_2D_X_207_0:
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

RULE B_2D_X_207_1:
  CALL: X
  PRIORITY: 105
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: opp_last_call == '2D'
  CONDITION: partner_last_call == 'NONE'
  CONDITION: hcp >= 13
  CONDITION: spade_len >= 3
  CONDITION: heart_len >= 4

RULE B_2D_X_207_2:
  CALL: X
  PRIORITY: 105
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: opp_last_call == '2D'
  CONDITION: partner_last_call == 'NONE'
  CONDITION: hcp >= 13
  CONDITION: spade_len >= 4
  CONDITION: heart_len >= 3

RULE B_2D_X_207_3:
  CALL: X
  PRIORITY: 105
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: opp_last_call == '2D'
  CONDITION: partner_last_call == 'NONE'
  CONDITION: hcp >= 16

RULE B_2D_X_207_4:
  CALL: X
  PRIORITY: 105
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: opp_last_call == '2D'
  CONDITION: partner_last_call == 'NONE'
  CONDITION: heart_len >= 6
  CONDITION: hcp >= 18
  CONDITION: losing_trick_count <= 4

RULE B_2D_X_207_5:
  CALL: X
  PRIORITY: 105
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: opp_last_call == '2D'
  CONDITION: partner_last_call == 'NONE'
  CONDITION: spade_len >= 6
  CONDITION: hcp >= 18
  CONDITION: losing_trick_count <= 4

RULE B_2H_PASS_208_0:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: opp_last_call == '2H'
  CONDITION: partner_last_call == 'NONE'
  CONDITION: hcp <= 17

RULE B_2H_2S_209_0:
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

RULE B_2H_2S_210_0:
  CALL: 2S
  PRIORITY: 20
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: opp_last_call == '2H'
  CONDITION: partner_last_call == 'NONE'
  CONDITION: spade_len >= 5
  CONDITION: hcp >= 13
  CONDITION: hcp <= 19

RULE B_2H_2NT_211_0:
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

RULE B_2H_2NT_211_1:
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

RULE B_2H_3S_215_0:
  CALL: 3S
  PRIORITY: 30
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: opp_last_call == '2H'
  CONDITION: partner_last_call == 'NONE'
  CONDITION: spade_len >= 6
  CONDITION: hcp >= 19
  CONDITION: losing_trick_count >= 4

RULE B_2H_3NT_216_0:
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

RULE B_2H_3NT_216_1:
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

RULE B_2H_4H_219_0:
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

RULE B_2H_4S_220_0:
  CALL: 4S
  PRIORITY: 29
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: opp_last_call == '2H'
  CONDITION: partner_last_call == 'NONE'
  CONDITION: spade_len >= 7
  CONDITION: spade_hcp >= 18
  CONDITION: losing_trick_count <= 4

RULE B_2H_X_228_0:
  CALL: X
  PRIORITY: 24
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: opp_last_call == '2H'
  CONDITION: partner_last_call == 'NONE'
  CONDITION: hcp >= 15
  CONDITION: spade_len >= 3
  CONDITION: heart_len <= 3

RULE B_2H_X_228_1:
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

RULE B_2H_X_228_2:
  CALL: X
  PRIORITY: 24
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: opp_last_call == '2H'
  CONDITION: partner_last_call == 'NONE'
  CONDITION: hcp >= 18

RULE B_2S_PASS_229_0:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: opp_last_call == '2S'
  CONDITION: partner_last_call == 'NONE'
  CONDITION: hcp <= 17

RULE B_2S_2NT_230_0:
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

RULE B_2S_2NT_230_1:
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

RULE B_2S_3H_233_0:
  CALL: 3H
  PRIORITY: 20
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: opp_last_call == '2S'
  CONDITION: partner_last_call == 'NONE'
  CONDITION: heart_len >= 6
  CONDITION: hcp >= 13
  CONDITION: hcp <= 19

RULE B_2S_3NT_235_0:
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

RULE B_2S_3NT_235_1:
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

RULE B_2S_4H_238_0:
  CALL: 4H
  PRIORITY: 30
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: opp_last_call == '2S'
  CONDITION: partner_last_call == 'NONE'
  CONDITION: heart_len >= 7
  CONDITION: heart_hcp >= 18
  CONDITION: losing_trick_count <= 4

RULE B_2S_4H_238_1_0:
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

RULE B_2S_4H_238_1_1:
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

RULE B_2S_4H_238_1_2:
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

RULE B_2S_4H_238_1_3:
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

RULE B_2S_4H_238_1_4:
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

RULE B_2S_4H_238_1_5:
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

RULE B_2S_4H_238_1_6:
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

RULE B_2S_4H_238_1_7:
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

RULE B_2S_4H_238_1_8:
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

RULE B_2S_4H_238_1_9:
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

RULE B_2S_4S_239_0:
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

RULE B_2S_X_247_0:
  CALL: X
  PRIORITY: 24
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: opp_last_call == '2S'
  CONDITION: partner_last_call == 'NONE'
  CONDITION: hcp >= 15
  CONDITION: heart_len >= 3
  CONDITION: spade_len <= 3

RULE B_2S_X_247_1:
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

RULE B_2S_X_247_2:
  CALL: X
  PRIORITY: 24
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: opp_last_call == '2S'
  CONDITION: partner_last_call == 'NONE'
  CONDITION: hcp >= 18

RULE B_3C_PASS_248_0:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: opp_last_call == '3C'
  CONDITION: partner_last_call == 'NONE'
  CONDITION: hcp <= 20
  CONDITION: club_len >= 4

RULE B_3C_PASS_248_1:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: opp_last_call == '3C'
  CONDITION: partner_last_call == 'NONE'
  CONDITION: hcp <= 17
  CONDITION: spade_len <= 2

RULE B_3C_PASS_248_2:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: opp_last_call == '3C'
  CONDITION: partner_last_call == 'NONE'
  CONDITION: hcp <= 17
  CONDITION: heart_len <= 2

RULE B_3C_PASS_248_3:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: opp_last_call == '3C'
  CONDITION: partner_last_call == 'NONE'
  CONDITION: hcp <= 16
  CONDITION: club_len >= 3

RULE B_3C_PASS_248_4:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: opp_last_call == '3C'
  CONDITION: partner_last_call == 'NONE'
  CONDITION: hcp <= 14

RULE B_3C_3D_249_0:
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

RULE B_3C_3D_249_1:
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

RULE B_3C_3H_250_0:
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

RULE B_3C_3H_251_0:
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

RULE B_3C_3H_252_0:
  CALL: 3H
  PRIORITY: 60
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: opp_last_call == '3C'
  CONDITION: partner_last_call == 'NONE'
  CONDITION: heart_len >= 5
  CONDITION: hcp >= 14
  CONDITION: hcp <= 19

RULE B_3C_3H_252_1:
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

RULE B_3C_3H_252_2:
  CALL: 3H
  PRIORITY: 60
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: opp_last_call == '3C'
  CONDITION: partner_last_call == 'NONE'
  CONDITION: heart_len >= 6
  CONDITION: hcp >= 14
  CONDITION: hcp <= 19

RULE B_3C_3S_253_0:
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

RULE B_3C_3S_254_0:
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

RULE B_3C_3S_255_0:
  CALL: 3S
  PRIORITY: 60
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: opp_last_call == '3C'
  CONDITION: partner_last_call == 'NONE'
  CONDITION: spade_len >= 5
  CONDITION: hcp >= 14
  CONDITION: hcp <= 19

RULE B_3C_3S_255_1:
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

RULE B_3C_3S_255_2:
  CALL: 3S
  PRIORITY: 60
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: opp_last_call == '3C'
  CONDITION: partner_last_call == 'NONE'
  CONDITION: spade_len >= 6
  CONDITION: hcp >= 14
  CONDITION: hcp <= 19

RULE B_3C_3NT_256_0:
  CALL: 3NT
  PRIORITY: 50
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: opp_last_call == '3C'
  CONDITION: partner_last_call == 'NONE'
  CONDITION: hcp >= 16
  CONDITION: c_stopper >= 2

RULE B_3C_3NT_256_1:
  CALL: 3NT
  PRIORITY: 50
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: opp_last_call == '3C'
  CONDITION: partner_last_call == 'NONE'
  CONDITION: hcp >= 17
  CONDITION: c_stopper >= 2

RULE B_3C_4C_257_0:
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

RULE B_3C_4H_258_0:
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

RULE B_3C_4H_259_0:
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

RULE B_3C_4H_260_0:
  CALL: 4H
  PRIORITY: 74
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: opp_last_call == '3C'
  CONDITION: partner_last_call == 'NONE'
  CONDITION: heart_len >= 6
  CONDITION: hcp >= 17

RULE B_3C_4S_261_0:
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

RULE B_3C_4S_262_0:
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

RULE B_3C_4S_263_0:
  CALL: 4S
  PRIORITY: 74
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: opp_last_call == '3C'
  CONDITION: partner_last_call == 'NONE'
  CONDITION: spade_len >= 6
  CONDITION: hcp >= 17

RULE B_3C_X_271_1:
  CALL: X
  PRIORITY: 32
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: opp_last_call == '3C'
  CONDITION: partner_last_call == 'NONE'
  CONDITION: hcp >= 14
  CONDITION: heart_len >= 4
  CONDITION: spade_len >= 4

RULE B_3C_X_271_3:
  CALL: X
  PRIORITY: 32
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: opp_last_call == '3C'
  CONDITION: partner_last_call == 'NONE'
  CONDITION: hcp >= 20

RULE B_3D_PASS_272_0:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: opp_last_call == '3D'
  CONDITION: partner_last_call == 'NONE'
  CONDITION: hcp <= 20
  CONDITION: diamond_len >= 4

RULE B_3D_PASS_272_1:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: opp_last_call == '3D'
  CONDITION: partner_last_call == 'NONE'
  CONDITION: hcp <= 17
  CONDITION: spade_len <= 2

RULE B_3D_PASS_272_2:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: opp_last_call == '3D'
  CONDITION: partner_last_call == 'NONE'
  CONDITION: hcp <= 17
  CONDITION: heart_len <= 2

RULE B_3D_PASS_272_3:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: opp_last_call == '3D'
  CONDITION: partner_last_call == 'NONE'
  CONDITION: hcp <= 16
  CONDITION: diamond_len >= 3

RULE B_3D_PASS_272_4:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: opp_last_call == '3D'
  CONDITION: partner_last_call == 'NONE'
  CONDITION: hcp <= 14

RULE B_3D_3H_273_0:
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

RULE B_3D_3H_274_0:
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

RULE B_3D_3H_275_0:
  CALL: 3H
  PRIORITY: 60
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: opp_last_call == '3D'
  CONDITION: partner_last_call == 'NONE'
  CONDITION: heart_len >= 5
  CONDITION: hcp >= 14
  CONDITION: hcp <= 19

RULE B_3D_3H_275_1:
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

RULE B_3D_3H_275_2:
  CALL: 3H
  PRIORITY: 60
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: opp_last_call == '3D'
  CONDITION: partner_last_call == 'NONE'
  CONDITION: heart_len >= 6
  CONDITION: hcp >= 14
  CONDITION: hcp <= 19

RULE B_3D_3S_276_0:
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

RULE B_3D_3S_277_0:
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

RULE B_3D_3S_278_0:
  CALL: 3S
  PRIORITY: 60
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: opp_last_call == '3D'
  CONDITION: partner_last_call == 'NONE'
  CONDITION: spade_len >= 5
  CONDITION: hcp >= 14
  CONDITION: hcp <= 19

RULE B_3D_3S_278_1:
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

RULE B_3D_3S_278_2:
  CALL: 3S
  PRIORITY: 60
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: opp_last_call == '3D'
  CONDITION: partner_last_call == 'NONE'
  CONDITION: spade_len >= 6
  CONDITION: hcp >= 14
  CONDITION: hcp <= 19

RULE B_3D_3NT_279_0:
  CALL: 3NT
  PRIORITY: 50
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: opp_last_call == '3D'
  CONDITION: partner_last_call == 'NONE'
  CONDITION: hcp >= 16
  CONDITION: d_stopper >= 2

RULE B_3D_3NT_279_1:
  CALL: 3NT
  PRIORITY: 50
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: opp_last_call == '3D'
  CONDITION: partner_last_call == 'NONE'
  CONDITION: hcp >= 17
  CONDITION: d_stopper >= 2

RULE B_3D_4C_280_0:
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

RULE B_3D_4C_280_1:
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

RULE B_3D_4D_281_0:
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

RULE B_3D_4H_282_0:
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

RULE B_3D_4H_283_0:
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

RULE B_3D_4H_284_0:
  CALL: 4H
  PRIORITY: 74
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: opp_last_call == '3D'
  CONDITION: partner_last_call == 'NONE'
  CONDITION: heart_len >= 6
  CONDITION: hcp >= 17

RULE B_3D_4S_285_0:
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

RULE B_3D_4S_286_0:
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

RULE B_3D_4S_287_0:
  CALL: 4S
  PRIORITY: 74
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: opp_last_call == '3D'
  CONDITION: partner_last_call == 'NONE'
  CONDITION: spade_len >= 6
  CONDITION: hcp >= 17

RULE B_3D_X_295_1:
  CALL: X
  PRIORITY: 32
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: opp_last_call == '3D'
  CONDITION: partner_last_call == 'NONE'
  CONDITION: hcp >= 14
  CONDITION: heart_len >= 4
  CONDITION: spade_len >= 4

RULE B_3D_X_295_3:
  CALL: X
  PRIORITY: 32
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: opp_last_call == '3D'
  CONDITION: partner_last_call == 'NONE'
  CONDITION: hcp >= 20

RULE B_3H_PASS_296_0:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: opp_last_call == '3H'
  CONDITION: partner_last_call == 'NONE'
  CONDITION: hcp <= 20
  CONDITION: heart_len >= 4

RULE B_3H_PASS_296_1:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: opp_last_call == '3H'
  CONDITION: partner_last_call == 'NONE'
  CONDITION: hcp <= 17

RULE B_3H_3S_297_0:
  CALL: 3S
  PRIORITY: 25
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: opp_last_call == '3H'
  CONDITION: partner_last_call == 'NONE'
  CONDITION: spade_len >= 5
  CONDITION: hcp >= 12

RULE B_3H_3S_297_1:
  CALL: 3S
  PRIORITY: 25
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: opp_last_call == '3H'
  CONDITION: partner_last_call == 'NONE'
  CONDITION: spade_len >= 6
  CONDITION: hcp >= 14
  CONDITION: hcp <= 19

RULE B_3H_3NT_298_0:
  CALL: 3NT
  PRIORITY: 60
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: opp_last_call == '3H'
  CONDITION: partner_last_call == 'NONE'
  CONDITION: hcp >= 17
  CONDITION: h_stopper >= 2

RULE B_3H_3NT_298_1:
  CALL: 3NT
  PRIORITY: 60
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: opp_last_call == '3H'
  CONDITION: partner_last_call == 'NONE'
  CONDITION: hcp >= 17
  CONDITION: h_stopper >= 3

RULE B_3H_4C_299_0:
  CALL: 4C
  PRIORITY: 22
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: opp_last_call == '3H'
  CONDITION: partner_last_call == 'NONE'
  CONDITION: club_len >= 5
  CONDITION: hcp >= 16
  CONDITION: hcp <= 19

RULE B_3H_4C_299_1:
  CALL: 4C
  PRIORITY: 22
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: opp_last_call == '3H'
  CONDITION: partner_last_call == 'NONE'
  CONDITION: club_len >= 6
  CONDITION: hcp >= 14
  CONDITION: hcp <= 19

RULE B_3H_4D_300_0:
  CALL: 4D
  PRIORITY: 22
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: opp_last_call == '3H'
  CONDITION: partner_last_call == 'NONE'
  CONDITION: diamond_len >= 5
  CONDITION: hcp >= 16
  CONDITION: hcp <= 19

RULE B_3H_4D_300_1:
  CALL: 4D
  PRIORITY: 22
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: opp_last_call == '3H'
  CONDITION: partner_last_call == 'NONE'
  CONDITION: diamond_len >= 6
  CONDITION: hcp >= 14
  CONDITION: hcp <= 19

RULE B_3H_4H_301_0:
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

RULE B_3H_4H_301_1:
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

RULE B_3H_4S_302_0:
  CALL: 4S
  PRIORITY: 75
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: opp_last_call == '3H'
  CONDITION: partner_last_call == 'NONE'
  CONDITION: spade_len >= 6
  CONDITION: hcp >= 14
  CONDITION: hcp <= 19

RULE B_3H_4S_302_1:
  CALL: 4S
  PRIORITY: 75
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: opp_last_call == '3H'
  CONDITION: partner_last_call == 'NONE'
  CONDITION: spade_len >= 6
  CONDITION: losing_trick_count <= 4

RULE B_3H_4S_302_2:
  CALL: 4S
  PRIORITY: 75
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: opp_last_call == '3H'
  CONDITION: partner_last_call == 'NONE'
  CONDITION: spade_len >= 7
  CONDITION: losing_trick_count <= 3

RULE B_3H_X_310_0:
  CALL: X
  PRIORITY: 18
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: opp_last_call == '3H'
  CONDITION: partner_last_call == 'NONE'
  CONDITION: hcp >= 18

RULE B_3H_X_310_1:
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

RULE B_3H_X_310_2:
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

RULE B_3S_PASS_311_0:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: opp_last_call == '3S'
  CONDITION: partner_last_call == 'NONE'
  CONDITION: hcp <= 20
  CONDITION: spade_len >= 4

RULE B_3S_PASS_311_1:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: opp_last_call == '3S'
  CONDITION: partner_last_call == 'NONE'
  CONDITION: hcp <= 17

RULE B_3S_3NT_312_0:
  CALL: 3NT
  PRIORITY: 60
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: opp_last_call == '3S'
  CONDITION: partner_last_call == 'NONE'
  CONDITION: hcp >= 17
  CONDITION: s_stopper >= 2

RULE B_3S_3NT_312_1:
  CALL: 3NT
  PRIORITY: 60
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: opp_last_call == '3S'
  CONDITION: partner_last_call == 'NONE'
  CONDITION: hcp >= 17
  CONDITION: s_stopper >= 3

RULE B_3S_4C_313_0:
  CALL: 4C
  PRIORITY: 22
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: opp_last_call == '3S'
  CONDITION: partner_last_call == 'NONE'
  CONDITION: club_len >= 5
  CONDITION: hcp >= 16
  CONDITION: hcp <= 19

RULE B_3S_4C_313_1:
  CALL: 4C
  PRIORITY: 22
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: opp_last_call == '3S'
  CONDITION: partner_last_call == 'NONE'
  CONDITION: club_len >= 6
  CONDITION: hcp >= 14
  CONDITION: hcp <= 19

RULE B_3S_4D_314_0:
  CALL: 4D
  PRIORITY: 22
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: opp_last_call == '3S'
  CONDITION: partner_last_call == 'NONE'
  CONDITION: diamond_len >= 5
  CONDITION: hcp >= 16
  CONDITION: hcp <= 19

RULE B_3S_4D_314_1:
  CALL: 4D
  PRIORITY: 22
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: opp_last_call == '3S'
  CONDITION: partner_last_call == 'NONE'
  CONDITION: diamond_len >= 6
  CONDITION: hcp >= 14
  CONDITION: hcp <= 19

RULE B_3S_4H_315_0:
  CALL: 4H
  PRIORITY: 75
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: opp_last_call == '3S'
  CONDITION: partner_last_call == 'NONE'
  CONDITION: heart_len >= 6
  CONDITION: hcp >= 14
  CONDITION: hcp <= 19

RULE B_3S_4H_315_1:
  CALL: 4H
  PRIORITY: 75
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: opp_last_call == '3S'
  CONDITION: partner_last_call == 'NONE'
  CONDITION: heart_len >= 6
  CONDITION: losing_trick_count <= 4

RULE B_3S_4H_315_2:
  CALL: 4H
  PRIORITY: 75
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: opp_last_call == '3S'
  CONDITION: partner_last_call == 'NONE'
  CONDITION: heart_len >= 7
  CONDITION: losing_trick_count <= 3

RULE B_3S_4S_316_0:
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

RULE B_3S_4S_316_1:
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

RULE B_3S_X_324_0:
  CALL: X
  PRIORITY: 18
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: opp_last_call == '3S'
  CONDITION: partner_last_call == 'NONE'
  CONDITION: hcp >= 18

RULE B_3S_X_324_1:
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

RULE B_3S_X_324_2:
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

RULE B_4C_PASS_325_0:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: opp_last_call == '4C'
  CONDITION: partner_last_call == 'NONE'
  CONDITION: hcp <= 16
  CONDITION: spade_len <= 2

RULE B_4C_PASS_325_1:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: opp_last_call == '4C'
  CONDITION: partner_last_call == 'NONE'
  CONDITION: hcp <= 16
  CONDITION: heart_len <= 2

RULE B_4C_PASS_325_2:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: opp_last_call == '4C'
  CONDITION: partner_last_call == 'NONE'
  CONDITION: hcp <= 18

RULE B_4C_4D_326_0:
  CALL: 4D
  PRIORITY: -1
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: opp_last_call == '4C'
  CONDITION: partner_last_call == 'NONE'
  CONDITION: diamond_len >= 6
  CONDITION: hcp >= 14
  CONDITION: hcp <= 19

RULE B_4C_5C_329_0:
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

RULE B_4C_X_330_2:
  CALL: X
  PRIORITY: 30
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: opp_last_call == '4C'
  CONDITION: partner_last_call == 'NONE'
  CONDITION: hcp >= 16
  CONDITION: heart_len >= 2
  CONDITION: spade_len >= 2

RULE B_4C_X_330_3:
  CALL: X
  PRIORITY: 30
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: opp_last_call == '4C'
  CONDITION: partner_last_call == 'NONE'
  CONDITION: hcp >= 19

RULE B_4D_PASS_331_0:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: opp_last_call == '4D'
  CONDITION: partner_last_call == 'NONE'
  CONDITION: hcp <= 16
  CONDITION: spade_len <= 2

RULE B_4D_PASS_331_1:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: opp_last_call == '4D'
  CONDITION: partner_last_call == 'NONE'
  CONDITION: hcp <= 16
  CONDITION: heart_len <= 2

RULE B_4D_PASS_331_2:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: opp_last_call == '4D'
  CONDITION: partner_last_call == 'NONE'
  CONDITION: hcp <= 18

RULE B_4D_5C_334_0:
  CALL: 5C
  PRIORITY: 20
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: opp_last_call == '4D'
  CONDITION: partner_last_call == 'NONE'
  CONDITION: club_len >= 7
  CONDITION: losing_trick_count <= 4
  CONDITION: hcp >= 14

RULE B_4D_5D_335_0:
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

RULE B_4D_X_336_2:
  CALL: X
  PRIORITY: 30
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: opp_last_call == '4D'
  CONDITION: partner_last_call == 'NONE'
  CONDITION: hcp >= 16
  CONDITION: heart_len >= 2
  CONDITION: spade_len >= 2

RULE B_4D_X_336_3:
  CALL: X
  PRIORITY: 30
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: opp_last_call == '4D'
  CONDITION: partner_last_call == 'NONE'
  CONDITION: hcp >= 19

RULE B_4H_4S_338_0:
  CALL: 4S
  PRIORITY: 25
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: opp_last_call == '4H'
  CONDITION: partner_last_call == 'NONE'
  CONDITION: hcp >= 12
  CONDITION: spade_len >= 5
  CONDITION: losing_trick_count <= 4

RULE B_4H_4S_338_1:
  CALL: 4S
  PRIORITY: 25
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: opp_last_call == '4H'
  CONDITION: partner_last_call == 'NONE'
  CONDITION: hcp >= 10
  CONDITION: spade_len >= 6
  CONDITION: losing_trick_count <= 5

RULE B_4H_4S_338_2:
  CALL: 4S
  PRIORITY: 25
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: opp_last_call == '4H'
  CONDITION: partner_last_call == 'NONE'
  CONDITION: hcp >= 14
  CONDITION: spade_len >= 6

RULE B_4H_5C_341_0:
  CALL: 5C
  PRIORITY: 30
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: opp_last_call == '4H'
  CONDITION: partner_last_call == 'NONE'
  CONDITION: club_len >= 7
  CONDITION: hcp >= 16

RULE B_4H_5D_343_0:
  CALL: 5D
  PRIORITY: 30
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: opp_last_call == '4H'
  CONDITION: partner_last_call == 'NONE'
  CONDITION: diamond_len >= 7
  CONDITION: hcp >= 16

RULE B_4H_X_345_0:
  CALL: X
  PRIORITY: 24
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: opp_last_call == '4H'
  CONDITION: partner_last_call == 'NONE'
  CONDITION: hcp >= 14
  CONDITION: heart_len <= 2
  CONDITION: spade_len >= 4

RULE B_4H_X_345_1:
  CALL: X
  PRIORITY: 24
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: opp_last_call == '4H'
  CONDITION: partner_last_call == 'NONE'
  CONDITION: hcp >= 15
  CONDITION: heart_len <= 1
  CONDITION: spade_len >= 3

RULE B_4H_X_345_2:
  CALL: X
  PRIORITY: 24
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: opp_last_call == '4H'
  CONDITION: partner_last_call == 'NONE'
  CONDITION: hcp >= 18

RULE B_4S_4NT_347_1:
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

RULE B_4S_5C_349_0:
  CALL: 5C
  PRIORITY: 30
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: opp_last_call == '4S'
  CONDITION: partner_last_call == 'NONE'
  CONDITION: club_len >= 7
  CONDITION: hcp >= 16

RULE B_4S_5D_351_0:
  CALL: 5D
  PRIORITY: 30
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: opp_last_call == '4S'
  CONDITION: partner_last_call == 'NONE'
  CONDITION: diamond_len >= 7
  CONDITION: hcp >= 16

RULE B_4S_X_354_0:
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

RULE B_5C_PASS_355_0:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: opp_last_call == '5C'
  CONDITION: partner_last_call == 'NONE'

RULE B_5D_PASS_359_0:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: opp_last_call == '5D'
  CONDITION: partner_last_call == 'NONE'

RULE B_5H_PASS_363_0:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: opp_last_call == '5H'
  CONDITION: partner_last_call == 'NONE'

RULE B_5S_PASS_366_0:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: opp_last_call == '5S'
  CONDITION: partner_last_call == 'NONE'

RULE B___1C_385_5:
  CALL: 1C
  PRIORITY: 60
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: opp_last_call == ''
  CONDITION: partner_last_call == 'NONE'
  CONDITION: hcp >= 12
  CONDITION: hcp <= 21
  CONDITION: shape_pattern == 4333
  CONDITION: spade_len == 4
  CONDITION: heart_len == 3
  CONDITION: diamond_len == 3
  CONDITION: club_len == 3

RULE B___1C_385_6:
  CALL: 1C
  PRIORITY: 60
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: opp_last_call == ''
  CONDITION: partner_last_call == 'NONE'
  CONDITION: hcp >= 12
  CONDITION: hcp <= 21
  CONDITION: shape_pattern == 4333
  CONDITION: spade_len == 3
  CONDITION: heart_len == 4
  CONDITION: diamond_len == 3
  CONDITION: club_len == 3

RULE B___1C_385_7:
  CALL: 1C
  PRIORITY: 60
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: opp_last_call == ''
  CONDITION: partner_last_call == 'NONE'
  CONDITION: hcp >= 12
  CONDITION: hcp <= 21
  CONDITION: shape_pattern == 4432
  CONDITION: spade_len == 4
  CONDITION: heart_len == 4
  CONDITION: diamond_len == 2
  CONDITION: club_len == 3

RULE B___1D_386_3:
  CALL: 1D
  PRIORITY: 65
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: opp_last_call == ''
  CONDITION: partner_last_call == 'NONE'
  CONDITION: hcp >= 12
  CONDITION: hcp <= 21
  CONDITION: shape_pattern == 4432
  CONDITION: spade_len == 4
  CONDITION: heart_len == 4
  CONDITION: diamond_len == 3
  CONDITION: club_len == 2

RULE B___1NT_393_3:
  CALL: 1NT
  PRIORITY: 120
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: opp_last_call == ''
  CONDITION: partner_last_call == 'NONE'
  CONDITION: is_semi_balanced == True
  CONDITION: hcp >= 15
  CONDITION: hcp <= 17
  CONDITION: spade_len <= 4
  CONDITION: heart_len <= 4

RULE B___2C_394_0:
  CALL: 2C
  PRIORITY: 112
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: opp_last_call == ''
  CONDITION: partner_last_call == 'NONE'
  CONDITION: losing_trick_count <= 1
  CONDITION: hcp >= 16

RULE B___2C_395_0:
  CALL: 2C
  PRIORITY: 113
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: opp_last_call == ''
  CONDITION: partner_last_call == 'NONE'
  CONDITION: losing_trick_count <= 2
  CONDITION: hcp >= 16
  CONDITION: longest_suit_len >= 5

RULE B___2C_396_8:
  CALL: 2C
  PRIORITY: 118
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: opp_last_call == ''
  CONDITION: partner_last_call == 'NONE'
  CONDITION: hcp >= 22
  CONDITION: is_balanced == True

RULE B___2C_396_9:
  CALL: 2C
  PRIORITY: 118
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: opp_last_call == ''
  CONDITION: partner_last_call == 'NONE'
  CONDITION: hcp >= 22
  CONDITION: is_semi_balanced == True

RULE B___2C_396_10:
  CALL: 2C
  PRIORITY: 118
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: opp_last_call == ''
  CONDITION: partner_last_call == 'NONE'
  CONDITION: hcp >= 22
  CONDITION: losing_trick_count <= 5

RULE B___2NT_400_0:
  CALL: 2NT
  PRIORITY: 122
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: opp_last_call == ''
  CONDITION: partner_last_call == 'NONE'
  CONDITION: is_semi_balanced == True
  CONDITION: hcp >= 20
  CONDITION: hcp <= 21

RULE B___3NT_409_0:
  CALL: 3NT
  PRIORITY: 130
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: opp_last_call == ''
  CONDITION: partner_last_call == 'NONE'
  CONDITION: is_semi_balanced == True
  CONDITION: hcp >= 25
  CONDITION: hcp <= 27
  CONDITION: heart_len <= 4
  CONDITION: spade_len <= 4

RULE B___6C_418_0:
  CALL: 6C
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: opp_last_call == ''
  CONDITION: partner_last_call == 'NONE'
  CONDITION: club_len >= 9
  CONDITION: total_points >= 32

RULE B___6D_419_0:
  CALL: 6D
  PRIORITY: 11
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: opp_last_call == ''
  CONDITION: partner_last_call == 'NONE'
  CONDITION: diamond_len >= 9
  CONDITION: total_points >= 32

RULE B___6H_420_0:
  CALL: 6H
  PRIORITY: 12
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: opp_last_call == ''
  CONDITION: partner_last_call == 'NONE'
  CONDITION: heart_len >= 9
  CONDITION: total_points >= 32

RULE B___6S_421_0:
  CALL: 6S
  PRIORITY: 13
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: opp_last_call == ''
  CONDITION: partner_last_call == 'NONE'
  CONDITION: spade_len >= 9
  CONDITION: total_points >= 32

RULE B___6NT_422_0:
  CALL: 6NT
  PRIORITY: 14
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: opp_last_call == ''
  CONDITION: partner_last_call == 'NONE'
  CONDITION: is_balanced == True
  CONDITION: hcp >= 33
  CONDITION: hcp <= 34

RULE B___7C_423_0:
  CALL: 7C
  PRIORITY: 15
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: opp_last_call == ''
  CONDITION: partner_last_call == 'NONE'
  CONDITION: club_len >= 9
  CONDITION: hcp >= 31
  CONDITION: total_points >= 35

RULE B___7D_424_0:
  CALL: 7D
  PRIORITY: 23
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: opp_last_call == ''
  CONDITION: partner_last_call == 'NONE'
  CONDITION: diamond_len >= 9
  CONDITION: hcp >= 31
  CONDITION: total_points >= 35

RULE B___7H_425_0:
  CALL: 7H
  PRIORITY: 24
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: opp_last_call == ''
  CONDITION: partner_last_call == 'NONE'
  CONDITION: heart_len >= 9
  CONDITION: hcp >= 31
  CONDITION: total_points >= 35

RULE B___7S_426_0:
  CALL: 7S
  PRIORITY: 25
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: opp_last_call == ''
  CONDITION: partner_last_call == 'NONE'
  CONDITION: spade_len >= 9
  CONDITION: hcp >= 31
  CONDITION: total_points >= 35

RULE B___7NT_427_0:
  CALL: 7NT
  PRIORITY: 26
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: opp_last_call == ''
  CONDITION: partner_last_call == 'NONE'
  CONDITION: is_balanced == True
  CONDITION: hcp >= 36
  CONDITION: total_points >= 35

RULE B_1N_PASS_428_0:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: opp_last_call == '1NT'
  CONDITION: partner_last_call == 'NONE'

RULE B_1N_2C_429_1:
  CALL: 2C
  PRIORITY: 50
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: opp_last_call == '1NT'
  CONDITION: partner_last_call == 'NONE'
  CONDITION: total_points >= 10
  CONDITION: longest_suit_len >= 7
  CONDITION: hcp >= 10

RULE B_1N_2D_430_0:
  CALL: 2D
  PRIORITY: 90
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: opp_last_call == '1NT'
  CONDITION: partner_last_call == 'NONE'
  CONDITION: heart_len >= 5
  CONDITION: spade_len >= 5
  CONDITION: hcp >= 10

RULE B_1N_2NT_433_0:
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

RULE B_2N_PASS_443_0:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: opp_last_call == '2NT'
  CONDITION: partner_last_call == 'NONE'

RULE B_3N_PASS_454_0:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: opp_last_call == '3NT'
  CONDITION: partner_last_call == 'NONE'

RULE B_7N_PASS_461_0:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: opp_last_call == '7NT'
  CONDITION: partner_last_call == 'NONE'

RULE B_P_P_1C_464_5:
  CALL: 1C
  PRIORITY: 60
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == 'PASS'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 1
  CONDITION: hcp >= 12
  CONDITION: hcp <= 21
  CONDITION: shape_pattern == 4333
  CONDITION: spade_len == 4
  CONDITION: heart_len == 3
  CONDITION: diamond_len == 3
  CONDITION: club_len == 3

RULE B_P_P_1C_464_6:
  CALL: 1C
  PRIORITY: 60
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == 'PASS'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 1
  CONDITION: hcp >= 12
  CONDITION: hcp <= 21
  CONDITION: shape_pattern == 4333
  CONDITION: spade_len == 3
  CONDITION: heart_len == 4
  CONDITION: diamond_len == 3
  CONDITION: club_len == 3

RULE B_P_P_1C_464_7:
  CALL: 1C
  PRIORITY: 60
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == 'PASS'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 1
  CONDITION: hcp >= 12
  CONDITION: hcp <= 21
  CONDITION: shape_pattern == 4432
  CONDITION: spade_len == 4
  CONDITION: heart_len == 4
  CONDITION: diamond_len == 2
  CONDITION: club_len == 3

RULE B_P_P_1D_465_3:
  CALL: 1D
  PRIORITY: 65
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == 'PASS'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 1
  CONDITION: hcp >= 12
  CONDITION: hcp <= 21
  CONDITION: shape_pattern == 4432
  CONDITION: spade_len == 4
  CONDITION: heart_len == 4
  CONDITION: diamond_len == 3
  CONDITION: club_len == 2

RULE B_P_P_1NT_472_3:
  CALL: 1NT
  PRIORITY: 120
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == 'PASS'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 1
  CONDITION: is_semi_balanced == True
  CONDITION: hcp >= 15
  CONDITION: hcp <= 17
  CONDITION: spade_len <= 4
  CONDITION: heart_len <= 4

RULE B_P_P_2C_473_0:
  CALL: 2C
  PRIORITY: 112
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == 'PASS'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 1
  CONDITION: losing_trick_count <= 1
  CONDITION: hcp >= 16

RULE B_P_P_2C_474_0:
  CALL: 2C
  PRIORITY: 113
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == 'PASS'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 1
  CONDITION: losing_trick_count <= 2
  CONDITION: hcp >= 16
  CONDITION: longest_suit_len >= 5

RULE B_P_P_2C_475_8:
  CALL: 2C
  PRIORITY: 118
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == 'PASS'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 1
  CONDITION: hcp >= 22
  CONDITION: is_balanced == True

RULE B_P_P_2C_475_9:
  CALL: 2C
  PRIORITY: 118
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == 'PASS'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 1
  CONDITION: hcp >= 22
  CONDITION: is_semi_balanced == True

RULE B_P_P_2C_475_10:
  CALL: 2C
  PRIORITY: 118
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == 'PASS'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 1
  CONDITION: hcp >= 22
  CONDITION: losing_trick_count <= 5

RULE B_P_P_2NT_479_0:
  CALL: 2NT
  PRIORITY: 122
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == 'PASS'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 1
  CONDITION: is_semi_balanced == True
  CONDITION: hcp >= 20
  CONDITION: hcp <= 21

RULE B_P_P_3NT_488_0:
  CALL: 3NT
  PRIORITY: 130
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == 'PASS'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 1
  CONDITION: is_semi_balanced == True
  CONDITION: hcp >= 25
  CONDITION: hcp <= 27
  CONDITION: heart_len <= 4
  CONDITION: spade_len <= 4

RULE B_P_P_6C_497_0:
  CALL: 6C
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == 'PASS'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 1
  CONDITION: club_len >= 9
  CONDITION: total_points >= 32

RULE B_P_P_6D_498_0:
  CALL: 6D
  PRIORITY: 11
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == 'PASS'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 1
  CONDITION: diamond_len >= 9
  CONDITION: total_points >= 32

RULE B_P_P_6H_499_0:
  CALL: 6H
  PRIORITY: 12
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == 'PASS'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 1
  CONDITION: heart_len >= 9
  CONDITION: total_points >= 32

RULE B_P_P_6S_500_0:
  CALL: 6S
  PRIORITY: 13
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == 'PASS'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 1
  CONDITION: spade_len >= 9
  CONDITION: total_points >= 32

RULE B_P_P_6NT_501_0:
  CALL: 6NT
  PRIORITY: 14
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == 'PASS'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 1
  CONDITION: is_balanced == True
  CONDITION: hcp >= 33
  CONDITION: hcp <= 34

RULE B_P_P_7C_502_0:
  CALL: 7C
  PRIORITY: 15
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == 'PASS'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 1
  CONDITION: club_len >= 9
  CONDITION: hcp >= 31
  CONDITION: total_points >= 35

RULE B_P_P_7D_503_0:
  CALL: 7D
  PRIORITY: 23
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == 'PASS'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 1
  CONDITION: diamond_len >= 9
  CONDITION: hcp >= 31
  CONDITION: total_points >= 35

RULE B_P_P_7H_504_0:
  CALL: 7H
  PRIORITY: 24
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == 'PASS'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 1
  CONDITION: heart_len >= 9
  CONDITION: hcp >= 31
  CONDITION: total_points >= 35

RULE B_P_P_7S_505_0:
  CALL: 7S
  PRIORITY: 25
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == 'PASS'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 1
  CONDITION: spade_len >= 9
  CONDITION: hcp >= 31
  CONDITION: total_points >= 35

RULE B_P_P_7NT_506_0:
  CALL: 7NT
  PRIORITY: 26
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == 'PASS'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 1
  CONDITION: is_balanced == True
  CONDITION: hcp >= 36
  CONDITION: total_points >= 35

RULE B_P_1C_PASS_507_0:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == 'PASS'
  CONDITION: opp_last_call == '1C'
  CONDITION: passes_since_last_bid == 0

RULE B_P_1C_PASS_507_1:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == 'PASS'
  CONDITION: opp_last_call == '1C'
  CONDITION: passes_since_last_bid == 0
  CONDITION: club_len >= 7

RULE B_P_1C_1NT_511_0:
  CALL: 1NT
  PRIORITY: 60
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == 'PASS'
  CONDITION: opp_last_call == '1C'
  CONDITION: passes_since_last_bid == 0
  CONDITION: club_len >= 4
  CONDITION: hcp >= 15
  CONDITION: hcp <= 17
  CONDITION: is_balanced == True

RULE B_P_1C_1NT_511_1:
  CALL: 1NT
  PRIORITY: 60
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == 'PASS'
  CONDITION: opp_last_call == '1C'
  CONDITION: passes_since_last_bid == 0
  CONDITION: club_len >= 4
  CONDITION: hcp >= 15
  CONDITION: hcp <= 17
  CONDITION: is_semi_balanced == True

RULE B_P_1C_1NT_511_2:
  CALL: 1NT
  PRIORITY: 60
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == 'PASS'
  CONDITION: opp_last_call == '1C'
  CONDITION: passes_since_last_bid == 0
  CONDITION: club_len >= 5
  CONDITION: hcp >= 15
  CONDITION: hcp <= 18
  CONDITION: is_balanced == True

RULE B_P_1C_1NT_511_3:
  CALL: 1NT
  PRIORITY: 60
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == 'PASS'
  CONDITION: opp_last_call == '1C'
  CONDITION: passes_since_last_bid == 0
  CONDITION: club_len >= 5
  CONDITION: hcp >= 15
  CONDITION: hcp <= 18
  CONDITION: is_semi_balanced == True

RULE B_P_1C_1NT_511_4:
  CALL: 1NT
  PRIORITY: 60
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == 'PASS'
  CONDITION: opp_last_call == '1C'
  CONDITION: passes_since_last_bid == 0
  CONDITION: c_stopper >= 2
  CONDITION: hcp >= 15
  CONDITION: hcp <= 17
  CONDITION: is_balanced == True

RULE B_P_1C_1NT_511_5:
  CALL: 1NT
  PRIORITY: 60
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == 'PASS'
  CONDITION: opp_last_call == '1C'
  CONDITION: passes_since_last_bid == 0
  CONDITION: c_stopper >= 2
  CONDITION: hcp >= 15
  CONDITION: hcp <= 17
  CONDITION: is_semi_balanced == True

RULE B_P_1C_4H_527_0_0:
  CALL: 4H
  PRIORITY: 91
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == 'PASS'
  CONDITION: opp_last_call == '1C'
  CONDITION: passes_since_last_bid == 0
  CONDITION: heart_len >= 8
  CONDITION: hcp <= 10
  CONDITION: h_has_ace == True

RULE B_P_1C_4H_527_0_1:
  CALL: 4H
  PRIORITY: 91
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == 'PASS'
  CONDITION: opp_last_call == '1C'
  CONDITION: passes_since_last_bid == 0
  CONDITION: heart_len >= 8
  CONDITION: hcp <= 10
  CONDITION: h_has_king == True

RULE B_P_1C_4H_527_0_2:
  CALL: 4H
  PRIORITY: 91
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == 'PASS'
  CONDITION: opp_last_call == '1C'
  CONDITION: passes_since_last_bid == 0
  CONDITION: heart_len >= 8
  CONDITION: hcp <= 10
  CONDITION: h_has_queen == True

RULE B_P_1C_4H_527_0_3:
  CALL: 4H
  PRIORITY: 91
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == 'PASS'
  CONDITION: opp_last_call == '1C'
  CONDITION: passes_since_last_bid == 0
  CONDITION: heart_len >= 8
  CONDITION: hcp <= 10
  CONDITION: h_has_jack == True

RULE B_P_1C_4H_527_0_4:
  CALL: 4H
  PRIORITY: 91
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == 'PASS'
  CONDITION: opp_last_call == '1C'
  CONDITION: passes_since_last_bid == 0
  CONDITION: heart_len >= 8
  CONDITION: hcp <= 10
  CONDITION: h_has_ten == True

RULE B_P_1C_4S_531_0_0:
  CALL: 4S
  PRIORITY: 91
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == 'PASS'
  CONDITION: opp_last_call == '1C'
  CONDITION: passes_since_last_bid == 0
  CONDITION: spade_len >= 8
  CONDITION: hcp <= 10
  CONDITION: s_has_ace == True

RULE B_P_1C_4S_531_0_1:
  CALL: 4S
  PRIORITY: 91
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == 'PASS'
  CONDITION: opp_last_call == '1C'
  CONDITION: passes_since_last_bid == 0
  CONDITION: spade_len >= 8
  CONDITION: hcp <= 10
  CONDITION: s_has_king == True

RULE B_P_1C_4S_531_0_2:
  CALL: 4S
  PRIORITY: 91
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == 'PASS'
  CONDITION: opp_last_call == '1C'
  CONDITION: passes_since_last_bid == 0
  CONDITION: spade_len >= 8
  CONDITION: hcp <= 10
  CONDITION: s_has_queen == True

RULE B_P_1C_4S_531_0_3:
  CALL: 4S
  PRIORITY: 91
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == 'PASS'
  CONDITION: opp_last_call == '1C'
  CONDITION: passes_since_last_bid == 0
  CONDITION: spade_len >= 8
  CONDITION: hcp <= 10
  CONDITION: s_has_jack == True

RULE B_P_1C_4S_531_0_4:
  CALL: 4S
  PRIORITY: 91
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == 'PASS'
  CONDITION: opp_last_call == '1C'
  CONDITION: passes_since_last_bid == 0
  CONDITION: spade_len >= 8
  CONDITION: hcp <= 10
  CONDITION: s_has_ten == True

RULE B_P_1C_X_541_1:
  CALL: X
  PRIORITY: 74
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == 'PASS'
  CONDITION: opp_last_call == '1C'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 18

RULE B_P_1C_X_541_3:
  CALL: X
  PRIORITY: 74
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == 'PASS'
  CONDITION: opp_last_call == '1C'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 10
  CONDITION: spade_len >= 4
  CONDITION: heart_len >= 4
  CONDITION: diamond_len >= 3
  CONDITION: club_len <= 1

RULE B_P_1D_PASS_542_0:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == 'PASS'
  CONDITION: opp_last_call == '1D'
  CONDITION: passes_since_last_bid == 0

RULE B_P_1D_PASS_542_1:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == 'PASS'
  CONDITION: opp_last_call == '1D'
  CONDITION: passes_since_last_bid == 0
  CONDITION: diamond_len >= 7

RULE B_P_1D_1NT_545_0:
  CALL: 1NT
  PRIORITY: 60
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == 'PASS'
  CONDITION: opp_last_call == '1D'
  CONDITION: passes_since_last_bid == 0
  CONDITION: diamond_len >= 4
  CONDITION: hcp >= 15
  CONDITION: hcp <= 17
  CONDITION: is_balanced == True

RULE B_P_1D_1NT_545_1:
  CALL: 1NT
  PRIORITY: 60
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == 'PASS'
  CONDITION: opp_last_call == '1D'
  CONDITION: passes_since_last_bid == 0
  CONDITION: diamond_len >= 4
  CONDITION: hcp >= 15
  CONDITION: hcp <= 17
  CONDITION: is_semi_balanced == True

RULE B_P_1D_1NT_545_2:
  CALL: 1NT
  PRIORITY: 60
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == 'PASS'
  CONDITION: opp_last_call == '1D'
  CONDITION: passes_since_last_bid == 0
  CONDITION: diamond_len >= 5
  CONDITION: hcp >= 15
  CONDITION: hcp <= 18
  CONDITION: is_balanced == True

RULE B_P_1D_1NT_545_3:
  CALL: 1NT
  PRIORITY: 60
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == 'PASS'
  CONDITION: opp_last_call == '1D'
  CONDITION: passes_since_last_bid == 0
  CONDITION: diamond_len >= 5
  CONDITION: hcp >= 15
  CONDITION: hcp <= 18
  CONDITION: is_semi_balanced == True

RULE B_P_1D_1NT_545_4:
  CALL: 1NT
  PRIORITY: 60
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == 'PASS'
  CONDITION: opp_last_call == '1D'
  CONDITION: passes_since_last_bid == 0
  CONDITION: d_stopper >= 2
  CONDITION: hcp >= 15
  CONDITION: hcp <= 17
  CONDITION: is_balanced == True

RULE B_P_1D_1NT_545_5:
  CALL: 1NT
  PRIORITY: 60
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == 'PASS'
  CONDITION: opp_last_call == '1D'
  CONDITION: passes_since_last_bid == 0
  CONDITION: d_stopper >= 2
  CONDITION: hcp >= 15
  CONDITION: hcp <= 17
  CONDITION: is_semi_balanced == True

RULE B_P_1D_4H_561_0_0:
  CALL: 4H
  PRIORITY: 91
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == 'PASS'
  CONDITION: opp_last_call == '1D'
  CONDITION: passes_since_last_bid == 0
  CONDITION: heart_len >= 8
  CONDITION: hcp <= 10
  CONDITION: h_has_ace == True

RULE B_P_1D_4H_561_0_1:
  CALL: 4H
  PRIORITY: 91
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == 'PASS'
  CONDITION: opp_last_call == '1D'
  CONDITION: passes_since_last_bid == 0
  CONDITION: heart_len >= 8
  CONDITION: hcp <= 10
  CONDITION: h_has_king == True

RULE B_P_1D_4H_561_0_2:
  CALL: 4H
  PRIORITY: 91
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == 'PASS'
  CONDITION: opp_last_call == '1D'
  CONDITION: passes_since_last_bid == 0
  CONDITION: heart_len >= 8
  CONDITION: hcp <= 10
  CONDITION: h_has_queen == True

RULE B_P_1D_4H_561_0_3:
  CALL: 4H
  PRIORITY: 91
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == 'PASS'
  CONDITION: opp_last_call == '1D'
  CONDITION: passes_since_last_bid == 0
  CONDITION: heart_len >= 8
  CONDITION: hcp <= 10
  CONDITION: h_has_jack == True

RULE B_P_1D_4H_561_0_4:
  CALL: 4H
  PRIORITY: 91
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == 'PASS'
  CONDITION: opp_last_call == '1D'
  CONDITION: passes_since_last_bid == 0
  CONDITION: heart_len >= 8
  CONDITION: hcp <= 10
  CONDITION: h_has_ten == True

RULE B_P_1D_4S_565_0_0:
  CALL: 4S
  PRIORITY: 91
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == 'PASS'
  CONDITION: opp_last_call == '1D'
  CONDITION: passes_since_last_bid == 0
  CONDITION: spade_len >= 8
  CONDITION: hcp <= 10
  CONDITION: s_has_ace == True

RULE B_P_1D_4S_565_0_1:
  CALL: 4S
  PRIORITY: 91
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == 'PASS'
  CONDITION: opp_last_call == '1D'
  CONDITION: passes_since_last_bid == 0
  CONDITION: spade_len >= 8
  CONDITION: hcp <= 10
  CONDITION: s_has_king == True

RULE B_P_1D_4S_565_0_2:
  CALL: 4S
  PRIORITY: 91
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == 'PASS'
  CONDITION: opp_last_call == '1D'
  CONDITION: passes_since_last_bid == 0
  CONDITION: spade_len >= 8
  CONDITION: hcp <= 10
  CONDITION: s_has_queen == True

RULE B_P_1D_4S_565_0_3:
  CALL: 4S
  PRIORITY: 91
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == 'PASS'
  CONDITION: opp_last_call == '1D'
  CONDITION: passes_since_last_bid == 0
  CONDITION: spade_len >= 8
  CONDITION: hcp <= 10
  CONDITION: s_has_jack == True

RULE B_P_1D_4S_565_0_4:
  CALL: 4S
  PRIORITY: 91
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == 'PASS'
  CONDITION: opp_last_call == '1D'
  CONDITION: passes_since_last_bid == 0
  CONDITION: spade_len >= 8
  CONDITION: hcp <= 10
  CONDITION: s_has_ten == True

RULE B_P_1D_X_575_1:
  CALL: X
  PRIORITY: 74
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == 'PASS'
  CONDITION: opp_last_call == '1D'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 18

RULE B_P_1D_X_575_3:
  CALL: X
  PRIORITY: 74
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == 'PASS'
  CONDITION: opp_last_call == '1D'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 10
  CONDITION: spade_len >= 4
  CONDITION: heart_len >= 4
  CONDITION: club_len >= 3
  CONDITION: diamond_len <= 1

RULE B_P_1H_PASS_576_0:
  CALL: PASS
  PRIORITY: 1
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == 'PASS'
  CONDITION: opp_last_call == '1H'
  CONDITION: passes_since_last_bid == 0

RULE B_P_1H_PASS_576_1:
  CALL: PASS
  PRIORITY: 1
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == 'PASS'
  CONDITION: opp_last_call == '1H'
  CONDITION: passes_since_last_bid == 0
  CONDITION: heart_len >= 6

RULE B_P_1H_1S_577_0:
  CALL: 1S
  PRIORITY: 60
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == 'PASS'
  CONDITION: opp_last_call == '1H'
  CONDITION: passes_since_last_bid == 0
  CONDITION: spade_len >= 5
  CONDITION: hcp >= 8
  CONDITION: hcp <= 17

RULE B_P_1H_1NT_578_0:
  CALL: 1NT
  PRIORITY: 60
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == 'PASS'
  CONDITION: opp_last_call == '1H'
  CONDITION: passes_since_last_bid == 0
  CONDITION: h_stopper >= 2
  CONDITION: hcp >= 15
  CONDITION: hcp <= 17
  CONDITION: is_balanced == True

RULE B_P_1H_1NT_578_1:
  CALL: 1NT
  PRIORITY: 60
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == 'PASS'
  CONDITION: opp_last_call == '1H'
  CONDITION: passes_since_last_bid == 0
  CONDITION: h_stopper >= 2
  CONDITION: hcp >= 15
  CONDITION: hcp <= 17
  CONDITION: is_semi_balanced == True

RULE B_P_1H_X_606_0:
  CALL: X
  PRIORITY: 76
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == 'PASS'
  CONDITION: opp_last_call == '1H'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 18
  CONDITION: heart_len <= 4

RULE B_P_1H_X_606_1:
  CALL: X
  PRIORITY: 76
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == 'PASS'
  CONDITION: opp_last_call == '1H'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 18
  CONDITION: is_balanced == True

RULE B_P_1H_X_606_2:
  CALL: X
  PRIORITY: 76
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == 'PASS'
  CONDITION: opp_last_call == '1H'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 10
  CONDITION: hcp <= 17
  CONDITION: heart_len <= 1
  CONDITION: spade_len >= 3
  CONDITION: club_len >= 3
  CONDITION: diamond_len >= 3

RULE B_P_1S_PASS_607_0:
  CALL: PASS
  PRIORITY: 1
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == 'PASS'
  CONDITION: opp_last_call == '1S'
  CONDITION: passes_since_last_bid == 0

RULE B_P_1S_PASS_607_1:
  CALL: PASS
  PRIORITY: 1
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == 'PASS'
  CONDITION: opp_last_call == '1S'
  CONDITION: passes_since_last_bid == 0
  CONDITION: spade_len >= 6

RULE B_P_1S_1NT_608_0:
  CALL: 1NT
  PRIORITY: 60
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == 'PASS'
  CONDITION: opp_last_call == '1S'
  CONDITION: passes_since_last_bid == 0
  CONDITION: s_stopper >= 2
  CONDITION: hcp >= 15
  CONDITION: hcp <= 17
  CONDITION: is_balanced == True

RULE B_P_1S_1NT_608_1:
  CALL: 1NT
  PRIORITY: 60
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == 'PASS'
  CONDITION: opp_last_call == '1S'
  CONDITION: passes_since_last_bid == 0
  CONDITION: s_stopper >= 2
  CONDITION: hcp >= 15
  CONDITION: hcp <= 17
  CONDITION: is_semi_balanced == True

RULE B_P_1S_X_636_0:
  CALL: X
  PRIORITY: 76
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == 'PASS'
  CONDITION: opp_last_call == '1S'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 18
  CONDITION: spade_len <= 4

RULE B_P_1S_X_636_1:
  CALL: X
  PRIORITY: 76
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == 'PASS'
  CONDITION: opp_last_call == '1S'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 18
  CONDITION: is_balanced == True

RULE B_P_1S_X_636_2:
  CALL: X
  PRIORITY: 76
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == 'PASS'
  CONDITION: opp_last_call == '1S'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 10
  CONDITION: hcp <= 17
  CONDITION: spade_len <= 1
  CONDITION: heart_len >= 3
  CONDITION: club_len >= 3
  CONDITION: diamond_len >= 3

RULE B_P_2C_PASS_637_0:
  CALL: PASS
  PRIORITY: -1
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == 'PASS'
  CONDITION: opp_last_call == '2C'
  CONDITION: passes_since_last_bid == 0

RULE B_P_2D_PASS_652_0:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == 'PASS'
  CONDITION: opp_last_call == '2D'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp <= 15

RULE B_P_2D_PASS_652_1:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == 'PASS'
  CONDITION: opp_last_call == '2D'
  CONDITION: passes_since_last_bid == 0
  CONDITION: diamond_len >= 5

RULE B_P_2D_2NT_655_0:
  CALL: 2NT
  PRIORITY: 80
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == 'PASS'
  CONDITION: opp_last_call == '2D'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 15
  CONDITION: hcp <= 18
  CONDITION: is_semi_balanced == True
  CONDITION: d_stopper >= 2

RULE B_P_2D_3H_658_0:
  CALL: 3H
  PRIORITY: 93
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == 'PASS'
  CONDITION: opp_last_call == '2D'
  CONDITION: passes_since_last_bid == 0
  CONDITION: heart_len >= 7
  CONDITION: hcp >= 19

RULE B_P_2D_3S_659_0:
  CALL: 3S
  PRIORITY: 93
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == 'PASS'
  CONDITION: opp_last_call == '2D'
  CONDITION: passes_since_last_bid == 0
  CONDITION: spade_len >= 7
  CONDITION: hcp >= 19

RULE B_P_2D_3NT_660_0:
  CALL: 3NT
  PRIORITY: 82
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == 'PASS'
  CONDITION: opp_last_call == '2D'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 19
  CONDITION: hcp <= 24
  CONDITION: is_semi_balanced == True
  CONDITION: d_stopper >= 2

RULE B_P_2D_4C_661_0:
  CALL: 4C
  PRIORITY: 95
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == 'PASS'
  CONDITION: opp_last_call == '2D'
  CONDITION: passes_since_last_bid == 0
  CONDITION: club_len >= 7
  CONDITION: hcp >= 19
  CONDITION: hcp <= 24

RULE B_P_2D_4H_662_0:
  CALL: 4H
  PRIORITY: 97
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == 'PASS'
  CONDITION: opp_last_call == '2D'
  CONDITION: passes_since_last_bid == 0
  CONDITION: heart_len >= 7
  CONDITION: hcp >= 12
  CONDITION: hcp <= 14

RULE B_P_2D_4H_662_1:
  CALL: 4H
  PRIORITY: 97
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == 'PASS'
  CONDITION: opp_last_call == '2D'
  CONDITION: passes_since_last_bid == 0
  CONDITION: heart_len >= 7
  CONDITION: losing_trick_count <= 3
  CONDITION: hcp <= 15

RULE B_P_2D_4S_663_0:
  CALL: 4S
  PRIORITY: 97
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == 'PASS'
  CONDITION: opp_last_call == '2D'
  CONDITION: passes_since_last_bid == 0
  CONDITION: spade_len >= 7
  CONDITION: hcp >= 12
  CONDITION: hcp <= 14

RULE B_P_2D_4S_663_1:
  CALL: 4S
  PRIORITY: 97
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == 'PASS'
  CONDITION: opp_last_call == '2D'
  CONDITION: passes_since_last_bid == 0
  CONDITION: spade_len >= 7
  CONDITION: losing_trick_count <= 3
  CONDITION: hcp <= 15

RULE B_P_2D_X_670_0:
  CALL: X
  PRIORITY: 105
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == 'PASS'
  CONDITION: opp_last_call == '2D'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 12
  CONDITION: diamond_len <= 1
  CONDITION: spade_len >= 3
  CONDITION: heart_len >= 3
  CONDITION: club_len <= 5

RULE B_P_2D_X_670_1:
  CALL: X
  PRIORITY: 105
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == 'PASS'
  CONDITION: opp_last_call == '2D'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 13
  CONDITION: spade_len >= 3
  CONDITION: heart_len >= 4

RULE B_P_2D_X_670_2:
  CALL: X
  PRIORITY: 105
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == 'PASS'
  CONDITION: opp_last_call == '2D'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 13
  CONDITION: spade_len >= 4
  CONDITION: heart_len >= 3

RULE B_P_2D_X_670_3:
  CALL: X
  PRIORITY: 105
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == 'PASS'
  CONDITION: opp_last_call == '2D'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 16

RULE B_P_2D_X_670_4:
  CALL: X
  PRIORITY: 105
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == 'PASS'
  CONDITION: opp_last_call == '2D'
  CONDITION: passes_since_last_bid == 0
  CONDITION: heart_len >= 6
  CONDITION: hcp >= 18
  CONDITION: losing_trick_count <= 4

RULE B_P_2D_X_670_5:
  CALL: X
  PRIORITY: 105
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == 'PASS'
  CONDITION: opp_last_call == '2D'
  CONDITION: passes_since_last_bid == 0
  CONDITION: spade_len >= 6
  CONDITION: hcp >= 18
  CONDITION: losing_trick_count <= 4

RULE B_P_2H_PASS_671_0:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == 'PASS'
  CONDITION: opp_last_call == '2H'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp <= 17

RULE B_P_2H_2S_672_0:
  CALL: 2S
  PRIORITY: 18
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == 'PASS'
  CONDITION: opp_last_call == '2H'
  CONDITION: passes_since_last_bid == 0
  CONDITION: spade_len >= 6
  CONDITION: hcp >= 10
  CONDITION: hcp <= 12
  CONDITION: s_top3_honors >= 2

RULE B_P_2H_2S_673_0:
  CALL: 2S
  PRIORITY: 20
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == 'PASS'
  CONDITION: opp_last_call == '2H'
  CONDITION: passes_since_last_bid == 0
  CONDITION: spade_len >= 5
  CONDITION: hcp >= 13
  CONDITION: hcp <= 19

RULE B_P_2H_2NT_674_0:
  CALL: 2NT
  PRIORITY: 100
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == 'PASS'
  CONDITION: opp_last_call == '2H'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 15
  CONDITION: hcp <= 18
  CONDITION: is_semi_balanced == True
  CONDITION: h_stopper >= 3

RULE B_P_2H_2NT_674_1:
  CALL: 2NT
  PRIORITY: 100
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == 'PASS'
  CONDITION: opp_last_call == '2H'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 16
  CONDITION: hcp <= 18
  CONDITION: is_semi_balanced == True
  CONDITION: h_stopper >= 2

RULE B_P_2H_3S_678_0:
  CALL: 3S
  PRIORITY: 30
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == 'PASS'
  CONDITION: opp_last_call == '2H'
  CONDITION: passes_since_last_bid == 0
  CONDITION: spade_len >= 6
  CONDITION: hcp >= 19
  CONDITION: losing_trick_count >= 4

RULE B_P_2H_3NT_679_0:
  CALL: 3NT
  PRIORITY: 50
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == 'PASS'
  CONDITION: opp_last_call == '2H'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 19
  CONDITION: hcp <= 24
  CONDITION: is_semi_balanced == True
  CONDITION: h_stopper >= 2

RULE B_P_2H_3NT_679_1:
  CALL: 3NT
  PRIORITY: 50
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == 'PASS'
  CONDITION: opp_last_call == '2H'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 20
  CONDITION: hcp <= 24
  CONDITION: heart_len >= 4
  CONDITION: h_stopper >= 2

RULE B_P_2H_4H_682_0:
  CALL: 4H
  PRIORITY: 120
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == 'PASS'
  CONDITION: opp_last_call == '2H'
  CONDITION: passes_since_last_bid == 0
  CONDITION: diamond_len >= 5
  CONDITION: club_len >= 5
  CONDITION: losing_trick_count <= 4
  CONDITION: hcp >= 17

RULE B_P_2H_4S_683_0:
  CALL: 4S
  PRIORITY: 29
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == 'PASS'
  CONDITION: opp_last_call == '2H'
  CONDITION: passes_since_last_bid == 0
  CONDITION: spade_len >= 7
  CONDITION: spade_hcp >= 18
  CONDITION: losing_trick_count <= 4

RULE B_P_2H_X_691_0:
  CALL: X
  PRIORITY: 24
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == 'PASS'
  CONDITION: opp_last_call == '2H'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 15
  CONDITION: spade_len >= 3
  CONDITION: heart_len <= 3

RULE B_P_2H_X_691_1:
  CALL: X
  PRIORITY: 24
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == 'PASS'
  CONDITION: opp_last_call == '2H'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 13
  CONDITION: spade_len >= 4
  CONDITION: club_len >= 2
  CONDITION: diamond_len >= 2
  CONDITION: heart_len <= 3

RULE B_P_2H_X_691_2:
  CALL: X
  PRIORITY: 24
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == 'PASS'
  CONDITION: opp_last_call == '2H'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 18

RULE B_P_2S_PASS_692_0:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == 'PASS'
  CONDITION: opp_last_call == '2S'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp <= 17

RULE B_P_2S_2NT_693_0:
  CALL: 2NT
  PRIORITY: 100
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == 'PASS'
  CONDITION: opp_last_call == '2S'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 15
  CONDITION: hcp <= 18
  CONDITION: is_semi_balanced == True
  CONDITION: s_stopper >= 3

RULE B_P_2S_2NT_693_1:
  CALL: 2NT
  PRIORITY: 100
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == 'PASS'
  CONDITION: opp_last_call == '2S'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 16
  CONDITION: hcp <= 18
  CONDITION: is_semi_balanced == True
  CONDITION: s_stopper >= 2

RULE B_P_2S_3H_696_0:
  CALL: 3H
  PRIORITY: 20
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == 'PASS'
  CONDITION: opp_last_call == '2S'
  CONDITION: passes_since_last_bid == 0
  CONDITION: heart_len >= 6
  CONDITION: hcp >= 13
  CONDITION: hcp <= 19

RULE B_P_2S_3NT_698_0:
  CALL: 3NT
  PRIORITY: 50
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == 'PASS'
  CONDITION: opp_last_call == '2S'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 19
  CONDITION: hcp <= 24
  CONDITION: is_semi_balanced == True
  CONDITION: s_stopper >= 2

RULE B_P_2S_3NT_698_1:
  CALL: 3NT
  PRIORITY: 50
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == 'PASS'
  CONDITION: opp_last_call == '2S'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 20
  CONDITION: hcp <= 24
  CONDITION: spade_len >= 4
  CONDITION: s_stopper >= 2

RULE B_P_2S_4H_701_0:
  CALL: 4H
  PRIORITY: 30
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == 'PASS'
  CONDITION: opp_last_call == '2S'
  CONDITION: passes_since_last_bid == 0
  CONDITION: heart_len >= 7
  CONDITION: heart_hcp >= 18
  CONDITION: losing_trick_count <= 4

RULE B_P_2S_4H_701_1_0:
  CALL: 4H
  PRIORITY: 30
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == 'PASS'
  CONDITION: opp_last_call == '2S'
  CONDITION: passes_since_last_bid == 0
  CONDITION: heart_len >= 6
  CONDITION: losing_trick_count <= 4
  CONDITION: hcp >= 15
  CONDITION: h_has_ace == True
  CONDITION: h_has_king == True
  CONDITION: h_has_queen == True

RULE B_P_2S_4H_701_1_1:
  CALL: 4H
  PRIORITY: 30
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == 'PASS'
  CONDITION: opp_last_call == '2S'
  CONDITION: passes_since_last_bid == 0
  CONDITION: heart_len >= 6
  CONDITION: losing_trick_count <= 4
  CONDITION: hcp >= 15
  CONDITION: h_has_ace == True
  CONDITION: h_has_king == True
  CONDITION: h_has_jack == True

RULE B_P_2S_4H_701_1_2:
  CALL: 4H
  PRIORITY: 30
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == 'PASS'
  CONDITION: opp_last_call == '2S'
  CONDITION: passes_since_last_bid == 0
  CONDITION: heart_len >= 6
  CONDITION: losing_trick_count <= 4
  CONDITION: hcp >= 15
  CONDITION: h_has_ace == True
  CONDITION: h_has_king == True
  CONDITION: h_has_ten == True

RULE B_P_2S_4H_701_1_3:
  CALL: 4H
  PRIORITY: 30
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == 'PASS'
  CONDITION: opp_last_call == '2S'
  CONDITION: passes_since_last_bid == 0
  CONDITION: heart_len >= 6
  CONDITION: losing_trick_count <= 4
  CONDITION: hcp >= 15
  CONDITION: h_has_ace == True
  CONDITION: h_has_queen == True
  CONDITION: h_has_jack == True

RULE B_P_2S_4H_701_1_4:
  CALL: 4H
  PRIORITY: 30
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == 'PASS'
  CONDITION: opp_last_call == '2S'
  CONDITION: passes_since_last_bid == 0
  CONDITION: heart_len >= 6
  CONDITION: losing_trick_count <= 4
  CONDITION: hcp >= 15
  CONDITION: h_has_ace == True
  CONDITION: h_has_queen == True
  CONDITION: h_has_ten == True

RULE B_P_2S_4H_701_1_5:
  CALL: 4H
  PRIORITY: 30
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == 'PASS'
  CONDITION: opp_last_call == '2S'
  CONDITION: passes_since_last_bid == 0
  CONDITION: heart_len >= 6
  CONDITION: losing_trick_count <= 4
  CONDITION: hcp >= 15
  CONDITION: h_has_ace == True
  CONDITION: h_has_jack == True
  CONDITION: h_has_ten == True

RULE B_P_2S_4H_701_1_6:
  CALL: 4H
  PRIORITY: 30
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == 'PASS'
  CONDITION: opp_last_call == '2S'
  CONDITION: passes_since_last_bid == 0
  CONDITION: heart_len >= 6
  CONDITION: losing_trick_count <= 4
  CONDITION: hcp >= 15
  CONDITION: h_has_king == True
  CONDITION: h_has_queen == True
  CONDITION: h_has_jack == True

RULE B_P_2S_4H_701_1_7:
  CALL: 4H
  PRIORITY: 30
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == 'PASS'
  CONDITION: opp_last_call == '2S'
  CONDITION: passes_since_last_bid == 0
  CONDITION: heart_len >= 6
  CONDITION: losing_trick_count <= 4
  CONDITION: hcp >= 15
  CONDITION: h_has_king == True
  CONDITION: h_has_queen == True
  CONDITION: h_has_ten == True

RULE B_P_2S_4H_701_1_8:
  CALL: 4H
  PRIORITY: 30
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == 'PASS'
  CONDITION: opp_last_call == '2S'
  CONDITION: passes_since_last_bid == 0
  CONDITION: heart_len >= 6
  CONDITION: losing_trick_count <= 4
  CONDITION: hcp >= 15
  CONDITION: h_has_king == True
  CONDITION: h_has_jack == True
  CONDITION: h_has_ten == True

RULE B_P_2S_4H_701_1_9:
  CALL: 4H
  PRIORITY: 30
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == 'PASS'
  CONDITION: opp_last_call == '2S'
  CONDITION: passes_since_last_bid == 0
  CONDITION: heart_len >= 6
  CONDITION: losing_trick_count <= 4
  CONDITION: hcp >= 15
  CONDITION: h_has_queen == True
  CONDITION: h_has_jack == True
  CONDITION: h_has_ten == True

RULE B_P_2S_4S_702_0:
  CALL: 4S
  PRIORITY: 120
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == 'PASS'
  CONDITION: opp_last_call == '2S'
  CONDITION: passes_since_last_bid == 0
  CONDITION: diamond_len >= 5
  CONDITION: club_len >= 5
  CONDITION: losing_trick_count <= 4
  CONDITION: hcp >= 17

RULE B_P_2S_X_710_0:
  CALL: X
  PRIORITY: 24
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == 'PASS'
  CONDITION: opp_last_call == '2S'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 15
  CONDITION: heart_len >= 3
  CONDITION: spade_len <= 3

RULE B_P_2S_X_710_1:
  CALL: X
  PRIORITY: 24
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == 'PASS'
  CONDITION: opp_last_call == '2S'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 13
  CONDITION: heart_len >= 4
  CONDITION: club_len >= 2
  CONDITION: diamond_len >= 2
  CONDITION: spade_len <= 3

RULE B_P_2S_X_710_2:
  CALL: X
  PRIORITY: 24
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == 'PASS'
  CONDITION: opp_last_call == '2S'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 18

RULE B_P_3C_PASS_711_0:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == 'PASS'
  CONDITION: opp_last_call == '3C'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp <= 20
  CONDITION: club_len >= 4

RULE B_P_3C_PASS_711_1:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == 'PASS'
  CONDITION: opp_last_call == '3C'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp <= 17
  CONDITION: spade_len <= 2

RULE B_P_3C_PASS_711_2:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == 'PASS'
  CONDITION: opp_last_call == '3C'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp <= 17
  CONDITION: heart_len <= 2

RULE B_P_3C_PASS_711_3:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == 'PASS'
  CONDITION: opp_last_call == '3C'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp <= 16
  CONDITION: club_len >= 3

RULE B_P_3C_PASS_711_4:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == 'PASS'
  CONDITION: opp_last_call == '3C'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp <= 14

RULE B_P_3C_3D_712_0:
  CALL: 3D
  PRIORITY: 31
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == 'PASS'
  CONDITION: opp_last_call == '3C'
  CONDITION: passes_since_last_bid == 0
  CONDITION: diamond_len >= 5
  CONDITION: diamond_hcp >= 13
  CONDITION: hcp >= 11
  CONDITION: hcp <= 19
  CONDITION: spade_len <= 4
  CONDITION: heart_len <= 4

RULE B_P_3C_3D_712_1:
  CALL: 3D
  PRIORITY: 31
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == 'PASS'
  CONDITION: opp_last_call == '3C'
  CONDITION: passes_since_last_bid == 0
  CONDITION: diamond_len >= 6
  CONDITION: diamond_hcp >= 14
  CONDITION: hcp >= 12
  CONDITION: hcp <= 19
  CONDITION: spade_len <= 5
  CONDITION: heart_len <= 5

RULE B_P_3C_3H_713_0:
  CALL: 3H
  PRIORITY: 55
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == 'PASS'
  CONDITION: opp_last_call == '3C'
  CONDITION: passes_since_last_bid == 0
  CONDITION: heart_len >= 7
  CONDITION: losing_trick_count <= 5
  CONDITION: hcp >= 10
  CONDITION: h_top2_honors >= 1

RULE B_P_3C_3H_714_0:
  CALL: 3H
  PRIORITY: 57
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == 'PASS'
  CONDITION: opp_last_call == '3C'
  CONDITION: passes_since_last_bid == 0
  CONDITION: heart_len >= 6
  CONDITION: losing_trick_count <= 5
  CONDITION: hcp >= 11
  CONDITION: h_top3_honors >= 2

RULE B_P_3C_3H_715_0:
  CALL: 3H
  PRIORITY: 60
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == 'PASS'
  CONDITION: opp_last_call == '3C'
  CONDITION: passes_since_last_bid == 0
  CONDITION: heart_len >= 5
  CONDITION: hcp >= 14
  CONDITION: hcp <= 19

RULE B_P_3C_3H_715_1:
  CALL: 3H
  PRIORITY: 60
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == 'PASS'
  CONDITION: opp_last_call == '3C'
  CONDITION: passes_since_last_bid == 0
  CONDITION: heart_len >= 5
  CONDITION: spade_len <= 1
  CONDITION: hcp >= 14
  CONDITION: hcp <= 20

RULE B_P_3C_3H_715_2:
  CALL: 3H
  PRIORITY: 60
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == 'PASS'
  CONDITION: opp_last_call == '3C'
  CONDITION: passes_since_last_bid == 0
  CONDITION: heart_len >= 6
  CONDITION: hcp >= 14
  CONDITION: hcp <= 19

RULE B_P_3C_3S_716_0:
  CALL: 3S
  PRIORITY: 55
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == 'PASS'
  CONDITION: opp_last_call == '3C'
  CONDITION: passes_since_last_bid == 0
  CONDITION: spade_len >= 7
  CONDITION: losing_trick_count <= 5
  CONDITION: hcp >= 10
  CONDITION: s_top2_honors >= 1

RULE B_P_3C_3S_717_0:
  CALL: 3S
  PRIORITY: 57
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == 'PASS'
  CONDITION: opp_last_call == '3C'
  CONDITION: passes_since_last_bid == 0
  CONDITION: spade_len >= 6
  CONDITION: losing_trick_count <= 5
  CONDITION: hcp >= 11
  CONDITION: s_top3_honors >= 2

RULE B_P_3C_3S_718_0:
  CALL: 3S
  PRIORITY: 60
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == 'PASS'
  CONDITION: opp_last_call == '3C'
  CONDITION: passes_since_last_bid == 0
  CONDITION: spade_len >= 5
  CONDITION: hcp >= 14
  CONDITION: hcp <= 19

RULE B_P_3C_3S_718_1:
  CALL: 3S
  PRIORITY: 60
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == 'PASS'
  CONDITION: opp_last_call == '3C'
  CONDITION: passes_since_last_bid == 0
  CONDITION: spade_len >= 5
  CONDITION: heart_len <= 1
  CONDITION: hcp >= 14
  CONDITION: hcp <= 20

RULE B_P_3C_3S_718_2:
  CALL: 3S
  PRIORITY: 60
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == 'PASS'
  CONDITION: opp_last_call == '3C'
  CONDITION: passes_since_last_bid == 0
  CONDITION: spade_len >= 6
  CONDITION: hcp >= 14
  CONDITION: hcp <= 19

RULE B_P_3C_3NT_719_0:
  CALL: 3NT
  PRIORITY: 50
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == 'PASS'
  CONDITION: opp_last_call == '3C'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 16
  CONDITION: c_stopper >= 2

RULE B_P_3C_3NT_719_1:
  CALL: 3NT
  PRIORITY: 50
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == 'PASS'
  CONDITION: opp_last_call == '3C'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 17
  CONDITION: c_stopper >= 2

RULE B_P_3C_4C_720_0:
  CALL: 4C
  PRIORITY: 70
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == 'PASS'
  CONDITION: opp_last_call == '3C'
  CONDITION: passes_since_last_bid == 0
  CONDITION: heart_len >= 5
  CONDITION: spade_len >= 5
  CONDITION: losing_trick_count <= 5
  CONDITION: club_len <= 4
  CONDITION: controls >= 5

RULE B_P_3C_4H_721_0:
  CALL: 4H
  PRIORITY: 72
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == 'PASS'
  CONDITION: opp_last_call == '3C'
  CONDITION: passes_since_last_bid == 0
  CONDITION: heart_len >= 7
  CONDITION: losing_trick_count <= 4
  CONDITION: hcp >= 12
  CONDITION: h_top3_honors >= 2

RULE B_P_3C_4H_722_0:
  CALL: 4H
  PRIORITY: 73
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == 'PASS'
  CONDITION: opp_last_call == '3C'
  CONDITION: passes_since_last_bid == 0
  CONDITION: heart_len >= 6
  CONDITION: losing_trick_count <= 4
  CONDITION: hcp >= 14
  CONDITION: h_top3_honors >= 2

RULE B_P_3C_4H_723_0:
  CALL: 4H
  PRIORITY: 74
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == 'PASS'
  CONDITION: opp_last_call == '3C'
  CONDITION: passes_since_last_bid == 0
  CONDITION: heart_len >= 6
  CONDITION: hcp >= 17

RULE B_P_3C_4S_724_0:
  CALL: 4S
  PRIORITY: 72
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == 'PASS'
  CONDITION: opp_last_call == '3C'
  CONDITION: passes_since_last_bid == 0
  CONDITION: spade_len >= 7
  CONDITION: losing_trick_count <= 4
  CONDITION: hcp >= 12
  CONDITION: s_top3_honors >= 2

RULE B_P_3C_4S_725_0:
  CALL: 4S
  PRIORITY: 73
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == 'PASS'
  CONDITION: opp_last_call == '3C'
  CONDITION: passes_since_last_bid == 0
  CONDITION: spade_len >= 6
  CONDITION: losing_trick_count <= 4
  CONDITION: hcp >= 14
  CONDITION: s_top3_honors >= 2

RULE B_P_3C_4S_726_0:
  CALL: 4S
  PRIORITY: 74
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == 'PASS'
  CONDITION: opp_last_call == '3C'
  CONDITION: passes_since_last_bid == 0
  CONDITION: spade_len >= 6
  CONDITION: hcp >= 17

RULE B_P_3C_X_734_1:
  CALL: X
  PRIORITY: 32
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == 'PASS'
  CONDITION: opp_last_call == '3C'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 14
  CONDITION: heart_len >= 4
  CONDITION: spade_len >= 4

RULE B_P_3C_X_734_3:
  CALL: X
  PRIORITY: 32
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == 'PASS'
  CONDITION: opp_last_call == '3C'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 20

RULE B_P_3D_PASS_735_0:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == 'PASS'
  CONDITION: opp_last_call == '3D'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp <= 20
  CONDITION: diamond_len >= 4

RULE B_P_3D_PASS_735_1:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == 'PASS'
  CONDITION: opp_last_call == '3D'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp <= 17
  CONDITION: spade_len <= 2

RULE B_P_3D_PASS_735_2:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == 'PASS'
  CONDITION: opp_last_call == '3D'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp <= 17
  CONDITION: heart_len <= 2

RULE B_P_3D_PASS_735_3:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == 'PASS'
  CONDITION: opp_last_call == '3D'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp <= 16
  CONDITION: diamond_len >= 3

RULE B_P_3D_PASS_735_4:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == 'PASS'
  CONDITION: opp_last_call == '3D'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp <= 14

RULE B_P_3D_3H_736_0:
  CALL: 3H
  PRIORITY: 55
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == 'PASS'
  CONDITION: opp_last_call == '3D'
  CONDITION: passes_since_last_bid == 0
  CONDITION: heart_len >= 7
  CONDITION: losing_trick_count <= 5
  CONDITION: hcp >= 10
  CONDITION: h_top2_honors >= 1

RULE B_P_3D_3H_737_0:
  CALL: 3H
  PRIORITY: 57
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == 'PASS'
  CONDITION: opp_last_call == '3D'
  CONDITION: passes_since_last_bid == 0
  CONDITION: heart_len >= 6
  CONDITION: losing_trick_count <= 5
  CONDITION: hcp >= 11
  CONDITION: h_top3_honors >= 2

RULE B_P_3D_3H_738_0:
  CALL: 3H
  PRIORITY: 60
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == 'PASS'
  CONDITION: opp_last_call == '3D'
  CONDITION: passes_since_last_bid == 0
  CONDITION: heart_len >= 5
  CONDITION: hcp >= 14
  CONDITION: hcp <= 19

RULE B_P_3D_3H_738_1:
  CALL: 3H
  PRIORITY: 60
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == 'PASS'
  CONDITION: opp_last_call == '3D'
  CONDITION: passes_since_last_bid == 0
  CONDITION: heart_len >= 5
  CONDITION: spade_len <= 1
  CONDITION: hcp >= 14
  CONDITION: hcp <= 20

RULE B_P_3D_3H_738_2:
  CALL: 3H
  PRIORITY: 60
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == 'PASS'
  CONDITION: opp_last_call == '3D'
  CONDITION: passes_since_last_bid == 0
  CONDITION: heart_len >= 6
  CONDITION: hcp >= 14
  CONDITION: hcp <= 19

RULE B_P_3D_3S_739_0:
  CALL: 3S
  PRIORITY: 55
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == 'PASS'
  CONDITION: opp_last_call == '3D'
  CONDITION: passes_since_last_bid == 0
  CONDITION: spade_len >= 7
  CONDITION: losing_trick_count <= 5
  CONDITION: hcp >= 10
  CONDITION: s_top2_honors >= 1

RULE B_P_3D_3S_740_0:
  CALL: 3S
  PRIORITY: 57
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == 'PASS'
  CONDITION: opp_last_call == '3D'
  CONDITION: passes_since_last_bid == 0
  CONDITION: spade_len >= 6
  CONDITION: losing_trick_count <= 5
  CONDITION: hcp >= 11
  CONDITION: s_top3_honors >= 2

RULE B_P_3D_3S_741_0:
  CALL: 3S
  PRIORITY: 60
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == 'PASS'
  CONDITION: opp_last_call == '3D'
  CONDITION: passes_since_last_bid == 0
  CONDITION: spade_len >= 5
  CONDITION: hcp >= 14
  CONDITION: hcp <= 19

RULE B_P_3D_3S_741_1:
  CALL: 3S
  PRIORITY: 60
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == 'PASS'
  CONDITION: opp_last_call == '3D'
  CONDITION: passes_since_last_bid == 0
  CONDITION: spade_len >= 5
  CONDITION: heart_len <= 1
  CONDITION: hcp >= 14
  CONDITION: hcp <= 20

RULE B_P_3D_3S_741_2:
  CALL: 3S
  PRIORITY: 60
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == 'PASS'
  CONDITION: opp_last_call == '3D'
  CONDITION: passes_since_last_bid == 0
  CONDITION: spade_len >= 6
  CONDITION: hcp >= 14
  CONDITION: hcp <= 19

RULE B_P_3D_3NT_742_0:
  CALL: 3NT
  PRIORITY: 50
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == 'PASS'
  CONDITION: opp_last_call == '3D'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 16
  CONDITION: d_stopper >= 2

RULE B_P_3D_3NT_742_1:
  CALL: 3NT
  PRIORITY: 50
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == 'PASS'
  CONDITION: opp_last_call == '3D'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 17
  CONDITION: d_stopper >= 2

RULE B_P_3D_4C_743_0:
  CALL: 4C
  PRIORITY: 20
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == 'PASS'
  CONDITION: opp_last_call == '3D'
  CONDITION: passes_since_last_bid == 0
  CONDITION: club_len >= 5
  CONDITION: club_hcp >= 14
  CONDITION: hcp <= 19
  CONDITION: hcp >= 14
  CONDITION: spade_len <= 4
  CONDITION: heart_len <= 4

RULE B_P_3D_4C_743_1:
  CALL: 4C
  PRIORITY: 20
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == 'PASS'
  CONDITION: opp_last_call == '3D'
  CONDITION: passes_since_last_bid == 0
  CONDITION: club_len >= 6
  CONDITION: club_hcp >= 14
  CONDITION: hcp <= 19
  CONDITION: hcp >= 10
  CONDITION: spade_len <= 5
  CONDITION: heart_len <= 5

RULE B_P_3D_4D_744_0:
  CALL: 4D
  PRIORITY: 70
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == 'PASS'
  CONDITION: opp_last_call == '3D'
  CONDITION: passes_since_last_bid == 0
  CONDITION: heart_len >= 5
  CONDITION: spade_len >= 5
  CONDITION: losing_trick_count <= 5
  CONDITION: diamond_len <= 4
  CONDITION: controls >= 5

RULE B_P_3D_4H_745_0:
  CALL: 4H
  PRIORITY: 72
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == 'PASS'
  CONDITION: opp_last_call == '3D'
  CONDITION: passes_since_last_bid == 0
  CONDITION: heart_len >= 7
  CONDITION: losing_trick_count <= 4
  CONDITION: hcp >= 12
  CONDITION: h_top3_honors >= 2

RULE B_P_3D_4H_746_0:
  CALL: 4H
  PRIORITY: 73
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == 'PASS'
  CONDITION: opp_last_call == '3D'
  CONDITION: passes_since_last_bid == 0
  CONDITION: heart_len >= 6
  CONDITION: losing_trick_count <= 4
  CONDITION: hcp >= 14
  CONDITION: h_top3_honors >= 2

RULE B_P_3D_4H_747_0:
  CALL: 4H
  PRIORITY: 74
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == 'PASS'
  CONDITION: opp_last_call == '3D'
  CONDITION: passes_since_last_bid == 0
  CONDITION: heart_len >= 6
  CONDITION: hcp >= 17

RULE B_P_3D_4S_748_0:
  CALL: 4S
  PRIORITY: 72
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == 'PASS'
  CONDITION: opp_last_call == '3D'
  CONDITION: passes_since_last_bid == 0
  CONDITION: spade_len >= 7
  CONDITION: losing_trick_count <= 4
  CONDITION: hcp >= 12
  CONDITION: s_top3_honors >= 2

RULE B_P_3D_4S_749_0:
  CALL: 4S
  PRIORITY: 73
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == 'PASS'
  CONDITION: opp_last_call == '3D'
  CONDITION: passes_since_last_bid == 0
  CONDITION: spade_len >= 6
  CONDITION: losing_trick_count <= 4
  CONDITION: hcp >= 14
  CONDITION: s_top3_honors >= 2

RULE B_P_3D_4S_750_0:
  CALL: 4S
  PRIORITY: 74
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == 'PASS'
  CONDITION: opp_last_call == '3D'
  CONDITION: passes_since_last_bid == 0
  CONDITION: spade_len >= 6
  CONDITION: hcp >= 17

RULE B_P_3D_X_758_1:
  CALL: X
  PRIORITY: 32
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == 'PASS'
  CONDITION: opp_last_call == '3D'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 14
  CONDITION: heart_len >= 4
  CONDITION: spade_len >= 4

RULE B_P_3D_X_758_3:
  CALL: X
  PRIORITY: 32
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == 'PASS'
  CONDITION: opp_last_call == '3D'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 20

RULE B_P_3H_PASS_759_0:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == 'PASS'
  CONDITION: opp_last_call == '3H'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp <= 20
  CONDITION: heart_len >= 4

RULE B_P_3H_PASS_759_1:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == 'PASS'
  CONDITION: opp_last_call == '3H'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp <= 17

RULE B_P_3H_3S_760_0:
  CALL: 3S
  PRIORITY: 25
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == 'PASS'
  CONDITION: opp_last_call == '3H'
  CONDITION: passes_since_last_bid == 0
  CONDITION: spade_len >= 5
  CONDITION: hcp >= 12

RULE B_P_3H_3S_760_1:
  CALL: 3S
  PRIORITY: 25
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == 'PASS'
  CONDITION: opp_last_call == '3H'
  CONDITION: passes_since_last_bid == 0
  CONDITION: spade_len >= 6
  CONDITION: hcp >= 14
  CONDITION: hcp <= 19

RULE B_P_3H_3NT_761_0:
  CALL: 3NT
  PRIORITY: 60
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == 'PASS'
  CONDITION: opp_last_call == '3H'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 17
  CONDITION: h_stopper >= 2

RULE B_P_3H_3NT_761_1:
  CALL: 3NT
  PRIORITY: 60
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == 'PASS'
  CONDITION: opp_last_call == '3H'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 17
  CONDITION: h_stopper >= 3

RULE B_P_3H_4C_762_0:
  CALL: 4C
  PRIORITY: 22
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == 'PASS'
  CONDITION: opp_last_call == '3H'
  CONDITION: passes_since_last_bid == 0
  CONDITION: club_len >= 5
  CONDITION: hcp >= 16
  CONDITION: hcp <= 19

RULE B_P_3H_4C_762_1:
  CALL: 4C
  PRIORITY: 22
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == 'PASS'
  CONDITION: opp_last_call == '3H'
  CONDITION: passes_since_last_bid == 0
  CONDITION: club_len >= 6
  CONDITION: hcp >= 14
  CONDITION: hcp <= 19

RULE B_P_3H_4D_763_0:
  CALL: 4D
  PRIORITY: 22
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == 'PASS'
  CONDITION: opp_last_call == '3H'
  CONDITION: passes_since_last_bid == 0
  CONDITION: diamond_len >= 5
  CONDITION: hcp >= 16
  CONDITION: hcp <= 19

RULE B_P_3H_4D_763_1:
  CALL: 4D
  PRIORITY: 22
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == 'PASS'
  CONDITION: opp_last_call == '3H'
  CONDITION: passes_since_last_bid == 0
  CONDITION: diamond_len >= 6
  CONDITION: hcp >= 14
  CONDITION: hcp <= 19

RULE B_P_3H_4H_764_0:
  CALL: 4H
  PRIORITY: 70
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == 'PASS'
  CONDITION: opp_last_call == '3H'
  CONDITION: passes_since_last_bid == 0
  CONDITION: spade_len >= 5
  CONDITION: diamond_len >= 5
  CONDITION: losing_trick_count <= 5
  CONDITION: heart_len <= 3
  CONDITION: hcp >= 15

RULE B_P_3H_4H_764_1:
  CALL: 4H
  PRIORITY: 70
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == 'PASS'
  CONDITION: opp_last_call == '3H'
  CONDITION: passes_since_last_bid == 0
  CONDITION: spade_len >= 5
  CONDITION: club_len >= 5
  CONDITION: losing_trick_count <= 5
  CONDITION: heart_len <= 3
  CONDITION: hcp >= 15

RULE B_P_3H_4S_765_0:
  CALL: 4S
  PRIORITY: 75
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == 'PASS'
  CONDITION: opp_last_call == '3H'
  CONDITION: passes_since_last_bid == 0
  CONDITION: spade_len >= 6
  CONDITION: hcp >= 14
  CONDITION: hcp <= 19

RULE B_P_3H_4S_765_1:
  CALL: 4S
  PRIORITY: 75
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == 'PASS'
  CONDITION: opp_last_call == '3H'
  CONDITION: passes_since_last_bid == 0
  CONDITION: spade_len >= 6
  CONDITION: losing_trick_count <= 4

RULE B_P_3H_4S_765_2:
  CALL: 4S
  PRIORITY: 75
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == 'PASS'
  CONDITION: opp_last_call == '3H'
  CONDITION: passes_since_last_bid == 0
  CONDITION: spade_len >= 7
  CONDITION: losing_trick_count <= 3

RULE B_P_3H_X_773_0:
  CALL: X
  PRIORITY: 18
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == 'PASS'
  CONDITION: opp_last_call == '3H'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 18

RULE B_P_3H_X_773_1:
  CALL: X
  PRIORITY: 18
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == 'PASS'
  CONDITION: opp_last_call == '3H'
  CONDITION: passes_since_last_bid == 0
  CONDITION: spade_len >= 4
  CONDITION: hcp >= 14
  CONDITION: club_len >= 3
  CONDITION: diamond_len >= 3

RULE B_P_3H_X_773_2:
  CALL: X
  PRIORITY: 18
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == 'PASS'
  CONDITION: opp_last_call == '3H'
  CONDITION: passes_since_last_bid == 0
  CONDITION: spade_len >= 3
  CONDITION: hcp >= 17
  CONDITION: club_len >= 3
  CONDITION: diamond_len >= 3

RULE B_P_3S_PASS_774_0:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == 'PASS'
  CONDITION: opp_last_call == '3S'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp <= 20
  CONDITION: spade_len >= 4

RULE B_P_3S_PASS_774_1:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == 'PASS'
  CONDITION: opp_last_call == '3S'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp <= 17

RULE B_P_3S_3NT_775_0:
  CALL: 3NT
  PRIORITY: 60
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == 'PASS'
  CONDITION: opp_last_call == '3S'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 17
  CONDITION: s_stopper >= 2

RULE B_P_3S_3NT_775_1:
  CALL: 3NT
  PRIORITY: 60
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == 'PASS'
  CONDITION: opp_last_call == '3S'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 17
  CONDITION: s_stopper >= 3

RULE B_P_3S_4C_776_0:
  CALL: 4C
  PRIORITY: 22
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == 'PASS'
  CONDITION: opp_last_call == '3S'
  CONDITION: passes_since_last_bid == 0
  CONDITION: club_len >= 5
  CONDITION: hcp >= 16
  CONDITION: hcp <= 19

RULE B_P_3S_4C_776_1:
  CALL: 4C
  PRIORITY: 22
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == 'PASS'
  CONDITION: opp_last_call == '3S'
  CONDITION: passes_since_last_bid == 0
  CONDITION: club_len >= 6
  CONDITION: hcp >= 14
  CONDITION: hcp <= 19

RULE B_P_3S_4D_777_0:
  CALL: 4D
  PRIORITY: 22
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == 'PASS'
  CONDITION: opp_last_call == '3S'
  CONDITION: passes_since_last_bid == 0
  CONDITION: diamond_len >= 5
  CONDITION: hcp >= 16
  CONDITION: hcp <= 19

RULE B_P_3S_4D_777_1:
  CALL: 4D
  PRIORITY: 22
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == 'PASS'
  CONDITION: opp_last_call == '3S'
  CONDITION: passes_since_last_bid == 0
  CONDITION: diamond_len >= 6
  CONDITION: hcp >= 14
  CONDITION: hcp <= 19

RULE B_P_3S_4H_778_0:
  CALL: 4H
  PRIORITY: 75
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == 'PASS'
  CONDITION: opp_last_call == '3S'
  CONDITION: passes_since_last_bid == 0
  CONDITION: heart_len >= 6
  CONDITION: hcp >= 14
  CONDITION: hcp <= 19

RULE B_P_3S_4H_778_1:
  CALL: 4H
  PRIORITY: 75
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == 'PASS'
  CONDITION: opp_last_call == '3S'
  CONDITION: passes_since_last_bid == 0
  CONDITION: heart_len >= 6
  CONDITION: losing_trick_count <= 4

RULE B_P_3S_4H_778_2:
  CALL: 4H
  PRIORITY: 75
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == 'PASS'
  CONDITION: opp_last_call == '3S'
  CONDITION: passes_since_last_bid == 0
  CONDITION: heart_len >= 7
  CONDITION: losing_trick_count <= 3

RULE B_P_3S_4S_779_0:
  CALL: 4S
  PRIORITY: 70
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == 'PASS'
  CONDITION: opp_last_call == '3S'
  CONDITION: passes_since_last_bid == 0
  CONDITION: heart_len >= 5
  CONDITION: diamond_len >= 5
  CONDITION: losing_trick_count <= 5
  CONDITION: spade_len <= 3
  CONDITION: hcp >= 15

RULE B_P_3S_4S_779_1:
  CALL: 4S
  PRIORITY: 70
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == 'PASS'
  CONDITION: opp_last_call == '3S'
  CONDITION: passes_since_last_bid == 0
  CONDITION: heart_len >= 5
  CONDITION: club_len >= 5
  CONDITION: losing_trick_count <= 5
  CONDITION: spade_len <= 3
  CONDITION: hcp >= 15

RULE B_P_3S_X_787_0:
  CALL: X
  PRIORITY: 18
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == 'PASS'
  CONDITION: opp_last_call == '3S'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 18

RULE B_P_3S_X_787_1:
  CALL: X
  PRIORITY: 18
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == 'PASS'
  CONDITION: opp_last_call == '3S'
  CONDITION: passes_since_last_bid == 0
  CONDITION: heart_len >= 4
  CONDITION: hcp >= 14
  CONDITION: club_len >= 3
  CONDITION: diamond_len >= 3

RULE B_P_3S_X_787_2:
  CALL: X
  PRIORITY: 18
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == 'PASS'
  CONDITION: opp_last_call == '3S'
  CONDITION: passes_since_last_bid == 0
  CONDITION: heart_len >= 3
  CONDITION: hcp >= 17
  CONDITION: club_len >= 3
  CONDITION: diamond_len >= 3

RULE B_P_4C_PASS_788_0:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == 'PASS'
  CONDITION: opp_last_call == '4C'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp <= 16
  CONDITION: spade_len <= 2

RULE B_P_4C_PASS_788_1:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == 'PASS'
  CONDITION: opp_last_call == '4C'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp <= 16
  CONDITION: heart_len <= 2

RULE B_P_4C_PASS_788_2:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == 'PASS'
  CONDITION: opp_last_call == '4C'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp <= 18

RULE B_P_4C_4D_789_0:
  CALL: 4D
  PRIORITY: -1
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == 'PASS'
  CONDITION: opp_last_call == '4C'
  CONDITION: passes_since_last_bid == 0
  CONDITION: diamond_len >= 6
  CONDITION: hcp >= 14
  CONDITION: hcp <= 19

RULE B_P_4C_5C_792_0:
  CALL: 5C
  PRIORITY: 70
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == 'PASS'
  CONDITION: opp_last_call == '4C'
  CONDITION: passes_since_last_bid == 0
  CONDITION: heart_len >= 5
  CONDITION: spade_len >= 5
  CONDITION: losing_trick_count <= 2
  CONDITION: club_len <= 4

RULE B_P_4C_X_793_2:
  CALL: X
  PRIORITY: 30
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == 'PASS'
  CONDITION: opp_last_call == '4C'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 16
  CONDITION: heart_len >= 2
  CONDITION: spade_len >= 2

RULE B_P_4C_X_793_3:
  CALL: X
  PRIORITY: 30
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == 'PASS'
  CONDITION: opp_last_call == '4C'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 19

RULE B_P_4D_PASS_794_0:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == 'PASS'
  CONDITION: opp_last_call == '4D'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp <= 16
  CONDITION: spade_len <= 2

RULE B_P_4D_PASS_794_1:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == 'PASS'
  CONDITION: opp_last_call == '4D'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp <= 16
  CONDITION: heart_len <= 2

RULE B_P_4D_PASS_794_2:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == 'PASS'
  CONDITION: opp_last_call == '4D'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp <= 18

RULE B_P_4D_5C_797_0:
  CALL: 5C
  PRIORITY: 20
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == 'PASS'
  CONDITION: opp_last_call == '4D'
  CONDITION: passes_since_last_bid == 0
  CONDITION: club_len >= 7
  CONDITION: losing_trick_count <= 4
  CONDITION: hcp >= 14

RULE B_P_4D_5D_798_0:
  CALL: 5D
  PRIORITY: 70
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == 'PASS'
  CONDITION: opp_last_call == '4D'
  CONDITION: passes_since_last_bid == 0
  CONDITION: heart_len >= 5
  CONDITION: spade_len >= 5
  CONDITION: losing_trick_count <= 2
  CONDITION: diamond_len <= 4

RULE B_P_4D_X_799_2:
  CALL: X
  PRIORITY: 30
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == 'PASS'
  CONDITION: opp_last_call == '4D'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 16
  CONDITION: heart_len >= 2
  CONDITION: spade_len >= 2

RULE B_P_4D_X_799_3:
  CALL: X
  PRIORITY: 30
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == 'PASS'
  CONDITION: opp_last_call == '4D'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 19

RULE B_P_4H_4S_801_0:
  CALL: 4S
  PRIORITY: 25
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == 'PASS'
  CONDITION: opp_last_call == '4H'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 12
  CONDITION: spade_len >= 5
  CONDITION: losing_trick_count <= 4

RULE B_P_4H_4S_801_1:
  CALL: 4S
  PRIORITY: 25
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == 'PASS'
  CONDITION: opp_last_call == '4H'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 10
  CONDITION: spade_len >= 6
  CONDITION: losing_trick_count <= 5

RULE B_P_4H_4S_801_2:
  CALL: 4S
  PRIORITY: 25
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == 'PASS'
  CONDITION: opp_last_call == '4H'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 14
  CONDITION: spade_len >= 6

RULE B_P_4H_5C_804_0:
  CALL: 5C
  PRIORITY: 30
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == 'PASS'
  CONDITION: opp_last_call == '4H'
  CONDITION: passes_since_last_bid == 0
  CONDITION: club_len >= 7
  CONDITION: hcp >= 16

RULE B_P_4H_5D_806_0:
  CALL: 5D
  PRIORITY: 30
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == 'PASS'
  CONDITION: opp_last_call == '4H'
  CONDITION: passes_since_last_bid == 0
  CONDITION: diamond_len >= 7
  CONDITION: hcp >= 16

RULE B_P_4H_X_808_0:
  CALL: X
  PRIORITY: 24
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == 'PASS'
  CONDITION: opp_last_call == '4H'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 14
  CONDITION: heart_len <= 2
  CONDITION: spade_len >= 4

RULE B_P_4H_X_808_1:
  CALL: X
  PRIORITY: 24
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == 'PASS'
  CONDITION: opp_last_call == '4H'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 15
  CONDITION: heart_len <= 1
  CONDITION: spade_len >= 3

RULE B_P_4H_X_808_2:
  CALL: X
  PRIORITY: 24
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == 'PASS'
  CONDITION: opp_last_call == '4H'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 18

RULE B_P_4S_4NT_810_1:
  CALL: 4NT
  PRIORITY: 120
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == 'PASS'
  CONDITION: opp_last_call == '4S'
  CONDITION: passes_since_last_bid == 0
  CONDITION: spade_len <= 1
  CONDITION: hcp >= 13
  CONDITION: heart_len >= 3
  CONDITION: diamond_len >= 3
  CONDITION: club_len >= 3

RULE B_P_4S_5C_812_0:
  CALL: 5C
  PRIORITY: 30
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == 'PASS'
  CONDITION: opp_last_call == '4S'
  CONDITION: passes_since_last_bid == 0
  CONDITION: club_len >= 7
  CONDITION: hcp >= 16

RULE B_P_4S_5D_814_0:
  CALL: 5D
  PRIORITY: 30
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == 'PASS'
  CONDITION: opp_last_call == '4S'
  CONDITION: passes_since_last_bid == 0
  CONDITION: diamond_len >= 7
  CONDITION: hcp >= 16

RULE B_P_4S_X_817_0:
  CALL: X
  PRIORITY: 120
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == 'PASS'
  CONDITION: opp_last_call == '4S'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 16
  CONDITION: spade_len >= 2
  CONDITION: spade_len <= 3
  CONDITION: is_balanced == True

RULE B_P_5C_PASS_818_0:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == 'PASS'
  CONDITION: opp_last_call == '5C'
  CONDITION: passes_since_last_bid == 0

RULE B_P_5D_PASS_822_0:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == 'PASS'
  CONDITION: opp_last_call == '5D'
  CONDITION: passes_since_last_bid == 0

RULE B_P_5H_PASS_826_0:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == 'PASS'
  CONDITION: opp_last_call == '5H'
  CONDITION: passes_since_last_bid == 0

RULE B_P_5S_PASS_829_0:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == 'PASS'
  CONDITION: opp_last_call == '5S'
  CONDITION: passes_since_last_bid == 0

RULE B_P_1N_PASS_847_0:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == 'PASS'
  CONDITION: opp_last_call == '1NT'
  CONDITION: passes_since_last_bid == 0

RULE B_P_1N_2C_848_1:
  CALL: 2C
  PRIORITY: 50
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == 'PASS'
  CONDITION: opp_last_call == '1NT'
  CONDITION: passes_since_last_bid == 0
  CONDITION: total_points >= 10
  CONDITION: longest_suit_len >= 7
  CONDITION: hcp >= 10

RULE B_P_1N_2D_849_0:
  CALL: 2D
  PRIORITY: 90
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == 'PASS'
  CONDITION: opp_last_call == '1NT'
  CONDITION: passes_since_last_bid == 0
  CONDITION: heart_len >= 5
  CONDITION: spade_len >= 5
  CONDITION: hcp >= 10

RULE B_P_1N_2NT_852_0:
  CALL: 2NT
  PRIORITY: 80
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == 'PASS'
  CONDITION: opp_last_call == '1NT'
  CONDITION: passes_since_last_bid == 0
  CONDITION: club_len >= 5
  CONDITION: diamond_len >= 5
  CONDITION: total_points >= 15
  CONDITION: hcp >= 10

RULE B_P_2N_PASS_862_0:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == 'PASS'
  CONDITION: opp_last_call == '2NT'
  CONDITION: passes_since_last_bid == 0

RULE B_P_3N_PASS_873_0:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == 'PASS'
  CONDITION: opp_last_call == '3NT'
  CONDITION: passes_since_last_bid == 0

RULE B_P_7N_PASS_880_0:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == 'PASS'
  CONDITION: opp_last_call == '7NT'
  CONDITION: passes_since_last_bid == 0

RULE B_1C_P_PASS_882_0:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1C'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 1
  CONDITION: hcp < 6

RULE B_1C_P_1NT_886_0:
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

RULE B_1C_P_2D_888_4:
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

RULE B_1C_P_2D_888_5:
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

RULE B_1C_P_2H_889_3:
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

RULE B_1C_P_2H_889_4:
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

RULE B_1C_P_2S_890_3:
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

RULE B_1C_P_2S_890_4:
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

RULE B_1C_P_2NT_891_0:
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

RULE B_1C_P_2NT_891_1:
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

RULE B_1C_P_3D_893_0:
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

RULE B_1C_P_3H_894_0:
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

RULE B_1C_P_3S_895_0:
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

RULE B_1C_P_3NT_896_0:
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

RULE B_1C_P_4H_897_0:
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

RULE B_1C_P_4S_898_0:
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

RULE B_1C_P_5C_900_0:
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

RULE B_1C_P_5D_901_0:
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

RULE B_1C_X_PASS_909_0:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1C'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp <= 5

RULE B_1C_X_1NT_913_0:
  CALL: 1NT
  PRIORITY: 12
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1C'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp <= 10
  CONDITION: hcp >= 6

RULE B_1C_X_2C_914_0:
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

RULE B_1C_X_2H_915_0:
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

RULE B_1C_X_2S_916_0:
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

RULE B_1C_X_2NT_917_0:
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

RULE B_1C_X_3C_918_0:
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

RULE B_1C_X_3H_919_0:
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

RULE B_1C_X_3S_920_0:
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

RULE B_1C_X_4C_921_0:
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

RULE B_1C_X_4H_922_0:
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

RULE B_1C_X_4S_923_0:
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

RULE B_1C_X_XX_924_0:
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

RULE B_1C_X_XX_924_1:
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

RULE B_1C_X_XX_924_2:
  CALL: XX
  PRIORITY: 42
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1C'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 11
  CONDITION: longest_suit_len <= 5

RULE B_1C_X_XX_924_3:
  CALL: XX
  PRIORITY: 42
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1C'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 12
  CONDITION: diamond_len >= 5

RULE B_1C_1D_PASS_925_0:
  CALL: PASS
  PRIORITY: 50
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1C'
  CONDITION: opp_last_call == '1D'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp <= 9

RULE B_1C_1D_1H_926_0:
  CALL: 1H
  PRIORITY: 65
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1C'
  CONDITION: opp_last_call == '1D'
  CONDITION: passes_since_last_bid == 0
  CONDITION: heart_len == 4
  CONDITION: hcp >= 6

RULE B_1C_1D_1S_927_0:
  CALL: 1S
  PRIORITY: 65
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1C'
  CONDITION: opp_last_call == '1D'
  CONDITION: passes_since_last_bid == 0
  CONDITION: spade_len == 4
  CONDITION: hcp >= 6

RULE B_1C_1D_1NT_928_0:
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

RULE B_1C_1D_1NT_928_1:
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

RULE B_1C_1D_2C_929_0:
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

RULE B_1C_1D_2D_930_0:
  CALL: 2D
  PRIORITY: 22
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1C'
  CONDITION: opp_last_call == '1D'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 10
  CONDITION: club_len >= 4

RULE B_1C_1D_2H_931_0:
  CALL: 2H
  PRIORITY: 25
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1C'
  CONDITION: opp_last_call == '1D'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 12
  CONDITION: heart_len >= 6

RULE B_1C_1D_2S_932_0:
  CALL: 2S
  PRIORITY: 25
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1C'
  CONDITION: opp_last_call == '1D'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 12
  CONDITION: spade_len >= 6

RULE B_1C_1D_2NT_933_0:
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

RULE B_1C_1D_2NT_933_1:
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

RULE B_1C_1D_3C_934_0:
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

RULE B_1C_1D_3NT_938_0:
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

RULE B_1C_1D_3NT_938_1:
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

RULE B_1C_1D_4H_939_0:
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

RULE B_1C_1D_4S_940_0:
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

RULE B_1C_1D_X_949_0:
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

RULE B_1C_1H_PASS_950_0:
  CALL: PASS
  PRIORITY: 32
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1C'
  CONDITION: opp_last_call == '1H'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp <= 9

RULE B_1C_1H_PASS_950_1:
  CALL: PASS
  PRIORITY: 32
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1C'
  CONDITION: opp_last_call == '1H'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp <= 6

RULE B_1C_1H_PASS_950_2:
  CALL: PASS
  PRIORITY: 32
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1C'
  CONDITION: opp_last_call == '1H'
  CONDITION: passes_since_last_bid == 0
  CONDITION: heart_len >= 5
  CONDITION: hcp >= 10

RULE B_1C_1H_1S_951_0:
  CALL: 1S
  PRIORITY: 80
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1C'
  CONDITION: opp_last_call == '1H'
  CONDITION: passes_since_last_bid == 0
  CONDITION: spade_hcp >= 6
  CONDITION: spade_len >= 5

RULE B_1C_1H_1NT_952_0:
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

RULE B_1C_1H_1NT_952_1:
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

RULE B_1C_1H_2C_953_0:
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

RULE B_1C_1H_2C_953_1:
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

RULE B_1C_1H_2C_953_2:
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

RULE B_1C_1H_2D_954_0:
  CALL: 2D
  PRIORITY: 55
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1C'
  CONDITION: opp_last_call == '1H'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 9
  CONDITION: diamond_len >= 5

RULE B_1C_1H_2D_954_1_0:
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

RULE B_1C_1H_2D_954_1_1:
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

RULE B_1C_1H_2D_954_1_2:
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

RULE B_1C_1H_2D_954_1_3:
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

RULE B_1C_1H_2D_954_1_4:
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

RULE B_1C_1H_2D_954_1_5:
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

RULE B_1C_1H_2D_954_1_6:
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

RULE B_1C_1H_2D_954_1_7:
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

RULE B_1C_1H_2D_954_1_8:
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

RULE B_1C_1H_2D_954_1_9:
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

RULE B_1C_1H_2D_954_2:
  CALL: 2D
  PRIORITY: 55
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1C'
  CONDITION: opp_last_call == '1H'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 12
  CONDITION: diamond_len >= 4

RULE B_1C_1H_2D_954_3:
  CALL: 2D
  PRIORITY: 55
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1C'
  CONDITION: opp_last_call == '1H'
  CONDITION: passes_since_last_bid == 0
  CONDITION: diamond_len >= 5
  CONDITION: hcp >= 12

RULE B_1C_1H_2H_955_0:
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

RULE B_1C_1H_2H_955_1:
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

RULE B_1C_1H_2NT_956_0:
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

RULE B_1C_1H_2NT_956_1:
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

RULE B_1C_1H_3C_957_0:
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

RULE B_1C_1H_3D_958_0:
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

RULE B_1C_1H_3S_959_0:
  CALL: 3S
  PRIORITY: 60
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1C'
  CONDITION: opp_last_call == '1H'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 15
  CONDITION: spade_len >= 6

RULE B_1C_1H_3NT_960_0:
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

RULE B_1C_1H_3NT_960_1:
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

RULE B_1C_1H_4C_961_0:
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

RULE B_1C_1H_4S_962_0:
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

RULE B_1C_1S_PASS_972_0:
  CALL: PASS
  PRIORITY: 32
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1C'
  CONDITION: opp_last_call == '1S'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp <= 9

RULE B_1C_1S_PASS_972_1:
  CALL: PASS
  PRIORITY: 32
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1C'
  CONDITION: opp_last_call == '1S'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp <= 6

RULE B_1C_1S_PASS_972_2:
  CALL: PASS
  PRIORITY: 32
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1C'
  CONDITION: opp_last_call == '1S'
  CONDITION: passes_since_last_bid == 0
  CONDITION: spade_len >= 5
  CONDITION: hcp >= 10

RULE B_1C_1S_1NT_973_0:
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

RULE B_1C_1S_1NT_973_1:
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

RULE B_1C_1S_2C_974_0:
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

RULE B_1C_1S_2C_974_1:
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

RULE B_1C_1S_2C_974_2:
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

RULE B_1C_1S_2D_975_0:
  CALL: 2D
  PRIORITY: 55
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1C'
  CONDITION: opp_last_call == '1S'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 9
  CONDITION: diamond_len >= 5

RULE B_1C_1S_2D_975_1_0:
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

RULE B_1C_1S_2D_975_1_1:
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

RULE B_1C_1S_2D_975_1_2:
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

RULE B_1C_1S_2D_975_1_3:
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

RULE B_1C_1S_2D_975_1_4:
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

RULE B_1C_1S_2D_975_1_5:
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

RULE B_1C_1S_2D_975_1_6:
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

RULE B_1C_1S_2D_975_1_7:
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

RULE B_1C_1S_2D_975_1_8:
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

RULE B_1C_1S_2D_975_1_9:
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

RULE B_1C_1S_2D_975_2:
  CALL: 2D
  PRIORITY: 55
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1C'
  CONDITION: opp_last_call == '1S'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 12
  CONDITION: diamond_len >= 4

RULE B_1C_1S_2D_975_3:
  CALL: 2D
  PRIORITY: 55
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1C'
  CONDITION: opp_last_call == '1S'
  CONDITION: passes_since_last_bid == 0
  CONDITION: diamond_len >= 5
  CONDITION: hcp >= 12

RULE B_1C_1S_2H_976_0:
  CALL: 2H
  PRIORITY: 80
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1C'
  CONDITION: opp_last_call == '1S'
  CONDITION: passes_since_last_bid == 0
  CONDITION: heart_len >= 6
  CONDITION: hcp >= 8

RULE B_1C_1S_2H_976_1:
  CALL: 2H
  PRIORITY: 80
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1C'
  CONDITION: opp_last_call == '1S'
  CONDITION: passes_since_last_bid == 0
  CONDITION: heart_len >= 5
  CONDITION: hcp >= 10

RULE B_1C_1S_2S_977_0:
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

RULE B_1C_1S_2S_977_1:
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

RULE B_1C_1S_2NT_978_0:
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

RULE B_1C_1S_2NT_978_1:
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

RULE B_1C_1S_3C_979_0:
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

RULE B_1C_1S_3D_980_0:
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

RULE B_1C_1S_3H_981_0:
  CALL: 3H
  PRIORITY: 60
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1C'
  CONDITION: opp_last_call == '1S'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 15
  CONDITION: heart_len >= 6

RULE B_1C_1S_3NT_982_0:
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

RULE B_1C_1S_3NT_982_1:
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

RULE B_1C_1S_4C_983_0:
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

RULE B_1C_1S_4H_984_0:
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

RULE B_1C_2C_PASS_994_0:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1C'
  CONDITION: opp_last_call == '2C'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp <= 11

RULE B_1C_2C_2D_995_0:
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

RULE B_1C_2C_2H_996_0:
  CALL: 2H
  PRIORITY: 40
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1C'
  CONDITION: opp_last_call == '2C'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 10
  CONDITION: club_len >= 4

RULE B_1C_2C_2S_997_0:
  CALL: 2S
  PRIORITY: 45
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1C'
  CONDITION: opp_last_call == '2C'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 10
  CONDITION: diamond_len >= 5

RULE B_1C_2C_2S_997_1:
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

RULE B_1C_2C_2NT_998_0:
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

RULE B_1C_2C_3C_999_0:
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

RULE B_1C_2C_3H_1000_0:
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

RULE B_1C_2C_3S_1001_0:
  CALL: 3S
  PRIORITY: 56
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1C'
  CONDITION: opp_last_call == '2C'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 11
  CONDITION: club_len >= 5

RULE B_1C_2C_3NT_1002_0:
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

RULE B_1C_2C_4C_1003_0:
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

RULE B_1C_2C_4H_1004_0:
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

RULE B_1C_2C_4S_1005_0:
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

RULE B_1C_2C_X_1015_0:
  CALL: X
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1C'
  CONDITION: opp_last_call == '2C'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 12

RULE B_1C_2D_PASS_1016_0:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1C'
  CONDITION: opp_last_call == '2D'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp <= 11

RULE B_1C_2D_PASS_1016_1:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1C'
  CONDITION: opp_last_call == '2D'
  CONDITION: passes_since_last_bid == 0
  CONDITION: diamond_len >= 4

RULE B_1C_2D_PASS_1016_2:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1C'
  CONDITION: opp_last_call == '2D'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp <= 8

RULE B_1C_2D_2NT_1019_0:
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

RULE B_1C_2D_3C_1020_0:
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

RULE B_1C_2D_3D_1021_0:
  CALL: 3D
  PRIORITY: 20
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1C'
  CONDITION: opp_last_call == '2D'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 12
  CONDITION: club_len >= 4

RULE B_1C_2D_3D_1021_1:
  CALL: 3D
  PRIORITY: 20
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1C'
  CONDITION: opp_last_call == '2D'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 11
  CONDITION: club_len >= 5

RULE B_1C_2D_3NT_1022_0:
  CALL: 3NT
  PRIORITY: 50
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1C'
  CONDITION: opp_last_call == '2D'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 12
  CONDITION: d_stopper >= 2

RULE B_1C_2D_X_1023_0:
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

RULE B_1C_2D_X_1023_1:
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

RULE B_1C_2D_X_1023_2:
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

RULE B_1C_2D_X_1023_3:
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

RULE B_1C_2D_X_1023_4:
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

RULE B_1C_2H_PASS_1024_0:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1C'
  CONDITION: opp_last_call == '2H'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp <= 11

RULE B_1C_2H_PASS_1024_2:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1C'
  CONDITION: opp_last_call == '2H'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp <= 9

RULE B_1C_2H_2S_1025_0:
  CALL: 2S
  PRIORITY: 70
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1C'
  CONDITION: opp_last_call == '2H'
  CONDITION: passes_since_last_bid == 0
  CONDITION: spade_hcp >= 11
  CONDITION: spade_len >= 5

RULE B_1C_2H_2NT_1026_0:
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

RULE B_1C_2H_3C_1027_0:
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

RULE B_1C_2H_3C_1027_1:
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

RULE B_1C_2H_3D_1028_0:
  CALL: 3D
  PRIORITY: 30
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1C'
  CONDITION: opp_last_call == '2H'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 10
  CONDITION: diamond_len >= 5

RULE B_1C_2H_3D_1028_1:
  CALL: 3D
  PRIORITY: 30
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1C'
  CONDITION: opp_last_call == '2H'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 11
  CONDITION: diamond_len >= 5

RULE B_1C_2H_3H_1030_0:
  CALL: 3H
  PRIORITY: 55
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1C'
  CONDITION: opp_last_call == '2H'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 12
  CONDITION: club_len >= 3

RULE B_1C_2H_3H_1030_1:
  CALL: 3H
  PRIORITY: 55
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1C'
  CONDITION: opp_last_call == '2H'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 11
  CONDITION: club_len >= 4

RULE B_1C_2H_X_1042_0:
  CALL: X
  PRIORITY: 60
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1C'
  CONDITION: opp_last_call == '2H'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 13
  CONDITION: spade_len >= 3

RULE B_1C_2H_X_1042_1:
  CALL: X
  PRIORITY: 60
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1C'
  CONDITION: opp_last_call == '2H'
  CONDITION: passes_since_last_bid == 0
  CONDITION: total_points >= 9
  CONDITION: spade_len >= 4

RULE B_1C_2S_PASS_1043_0:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1C'
  CONDITION: opp_last_call == '2S'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp <= 11

RULE B_1C_2S_PASS_1043_2:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1C'
  CONDITION: opp_last_call == '2S'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp <= 9

RULE B_1C_2S_2NT_1044_0:
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

RULE B_1C_2S_3C_1045_0:
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

RULE B_1C_2S_3C_1045_1:
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

RULE B_1C_2S_3D_1046_0:
  CALL: 3D
  PRIORITY: 30
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1C'
  CONDITION: opp_last_call == '2S'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 10
  CONDITION: diamond_len >= 5

RULE B_1C_2S_3D_1046_1:
  CALL: 3D
  PRIORITY: 30
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1C'
  CONDITION: opp_last_call == '2S'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 11
  CONDITION: diamond_len >= 5

RULE B_1C_2S_3S_1049_0:
  CALL: 3S
  PRIORITY: 55
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1C'
  CONDITION: opp_last_call == '2S'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 12
  CONDITION: club_len >= 3

RULE B_1C_2S_3S_1049_1:
  CALL: 3S
  PRIORITY: 55
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1C'
  CONDITION: opp_last_call == '2S'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 11
  CONDITION: club_len >= 4

RULE B_1C_2S_X_1060_0:
  CALL: X
  PRIORITY: 60
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1C'
  CONDITION: opp_last_call == '2S'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 13
  CONDITION: heart_len >= 3

RULE B_1C_2S_X_1060_1:
  CALL: X
  PRIORITY: 60
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1C'
  CONDITION: opp_last_call == '2S'
  CONDITION: passes_since_last_bid == 0
  CONDITION: total_points >= 9
  CONDITION: heart_len >= 4

RULE B_1C_3C_PASS_1061_0:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1C'
  CONDITION: opp_last_call == '3C'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp <= 9

RULE B_1C_3C_X_1063_0:
  CALL: X
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1C'
  CONDITION: opp_last_call == '3C'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 10

RULE B_1C_3D_PASS_1064_0:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1C'
  CONDITION: opp_last_call == '3D'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp <= 9

RULE B_1C_3D_3NT_1067_0:
  CALL: 3NT
  PRIORITY: 30
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1C'
  CONDITION: opp_last_call == '3D'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 12
  CONDITION: d_stopper >= 2

RULE B_1C_3D_X_1070_0:
  CALL: X
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1C'
  CONDITION: opp_last_call == '3D'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 10

RULE B_1C_3H_PASS_1071_0:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1C'
  CONDITION: opp_last_call == '3H'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp <= 12

RULE B_1C_3H_PASS_1071_1:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1C'
  CONDITION: opp_last_call == '3H'
  CONDITION: passes_since_last_bid == 0
  CONDITION: heart_len >= 4

RULE B_1C_3H_PASS_1071_2:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1C'
  CONDITION: opp_last_call == '3H'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp <= 8

RULE B_1C_3H_3S_1072_0:
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

RULE B_1C_3H_3S_1072_1:
  CALL: 3S
  PRIORITY: 100
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1C'
  CONDITION: opp_last_call == '3H'
  CONDITION: passes_since_last_bid == 0
  CONDITION: spade_len >= 6
  CONDITION: hcp >= 12

RULE B_1C_3H_4C_1074_0:
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

RULE B_1C_3H_4D_1075_0:
  CALL: 4D
  PRIORITY: 16
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1C'
  CONDITION: opp_last_call == '3H'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 12
  CONDITION: diamond_len >= 6

RULE B_1C_3H_4H_1076_0:
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

RULE B_1C_3H_4S_1077_0:
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

RULE B_1C_3H_5C_1079_0:
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

RULE B_1C_3H_6S_1084_0:
  CALL: 6S
  PRIORITY: 66
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1C'
  CONDITION: opp_last_call == '3H'
  CONDITION: passes_since_last_bid == 0
  CONDITION: spade_len >= 8
  CONDITION: losing_trick_count <= 3

RULE B_1C_3H_X_1088_0:
  CALL: X
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1C'
  CONDITION: opp_last_call == '3H'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 12

RULE B_1C_3H_X_1088_1:
  CALL: X
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1C'
  CONDITION: opp_last_call == '3H'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 10
  CONDITION: heart_len <= 2

RULE B_1C_3S_PASS_1089_0:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1C'
  CONDITION: opp_last_call == '3S'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp <= 12

RULE B_1C_3S_PASS_1089_1:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1C'
  CONDITION: opp_last_call == '3S'
  CONDITION: passes_since_last_bid == 0
  CONDITION: spade_len >= 4

RULE B_1C_3S_PASS_1089_2:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1C'
  CONDITION: opp_last_call == '3S'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp <= 8

RULE B_1C_3S_4C_1091_0:
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

RULE B_1C_3S_4D_1092_0:
  CALL: 4D
  PRIORITY: 16
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1C'
  CONDITION: opp_last_call == '3S'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 12
  CONDITION: diamond_len >= 6

RULE B_1C_3S_4H_1093_0:
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

RULE B_1C_3S_4S_1094_0:
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

RULE B_1C_3S_5C_1096_0:
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

RULE B_1C_3S_6H_1101_0:
  CALL: 6H
  PRIORITY: 66
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1C'
  CONDITION: opp_last_call == '3S'
  CONDITION: passes_since_last_bid == 0
  CONDITION: heart_len >= 8
  CONDITION: losing_trick_count <= 3

RULE B_1C_3S_X_1105_0:
  CALL: X
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1C'
  CONDITION: opp_last_call == '3S'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 12

RULE B_1C_3S_X_1105_1:
  CALL: X
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1C'
  CONDITION: opp_last_call == '3S'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 10
  CONDITION: spade_len <= 2

RULE B_1C_4D_PASS_1106_0:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1C'
  CONDITION: opp_last_call == '4D'
  CONDITION: passes_since_last_bid == 0

RULE B_1C_4D_X_1114_0:
  CALL: X
  PRIORITY: 90
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1C'
  CONDITION: opp_last_call == '4D'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 13

RULE B_1C_4H_PASS_1115_0:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1C'
  CONDITION: opp_last_call == '4H'
  CONDITION: passes_since_last_bid == 0

RULE B_1C_4H_5C_1119_0:
  CALL: 5C
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1C'
  CONDITION: opp_last_call == '4H'
  CONDITION: passes_since_last_bid == 0
  CONDITION: club_len >= 5
  CONDITION: hcp >= 12

RULE B_1C_4S_PASS_1131_0:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1C'
  CONDITION: opp_last_call == '4S'
  CONDITION: passes_since_last_bid == 0

RULE B_1C_4S_5C_1134_0:
  CALL: 5C
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1C'
  CONDITION: opp_last_call == '4S'
  CONDITION: passes_since_last_bid == 0
  CONDITION: club_len >= 5
  CONDITION: hcp >= 12

RULE B_1C_6D_PASS_1151_0:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1C'
  CONDITION: opp_last_call == '6D'
  CONDITION: passes_since_last_bid == 0

RULE B_1C_6H_PASS_1152_0:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1C'
  CONDITION: opp_last_call == '6H'
  CONDITION: passes_since_last_bid == 0

RULE B_1C_6S_PASS_1153_0:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1C'
  CONDITION: opp_last_call == '6S'
  CONDITION: passes_since_last_bid == 0

RULE B_1C_7H_PASS_1154_0:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1C'
  CONDITION: opp_last_call == '7H'
  CONDITION: passes_since_last_bid == 0

RULE B_1C_7S_PASS_1155_0:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1C'
  CONDITION: opp_last_call == '7S'
  CONDITION: passes_since_last_bid == 0

RULE B_1C_1N_PASS_1156_0:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1C'
  CONDITION: opp_last_call == '1NT'
  CONDITION: passes_since_last_bid == 0

RULE B_1C_1N_2H_1159_0:
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

RULE B_1C_1N_2S_1160_0:
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

RULE B_1C_1N_X_1164_0:
  CALL: X
  PRIORITY: 50
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1C'
  CONDITION: opp_last_call == '1NT'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 9

RULE B_1C_2N_PASS_1165_0:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1C'
  CONDITION: opp_last_call == '2NT'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp <= 10

RULE B_1C_2N_3C_1166_0:
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

RULE B_1C_2N_3D_1167_0:
  CALL: 3D
  PRIORITY: 15
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1C'
  CONDITION: opp_last_call == '2NT'
  CONDITION: passes_since_last_bid == 0
  CONDITION: club_len >= 4
  CONDITION: club_hcp >= 12

RULE B_1C_2N_3H_1168_0:
  CALL: 3H
  PRIORITY: 30
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1C'
  CONDITION: opp_last_call == '2NT'
  CONDITION: passes_since_last_bid == 0
  CONDITION: spade_len >= 5
  CONDITION: hcp >= 10

RULE B_1C_2N_3S_1169_0:
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

RULE B_1C_2N_3NT_1170_0:
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

RULE B_1C_2N_X_1180_0:
  CALL: X
  PRIORITY: 5
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1C'
  CONDITION: opp_last_call == '2NT'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 11

RULE B_1D_P_PASS_1181_0:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1D'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 1
  CONDITION: hcp < 6

RULE B_1D_P_1NT_1184_0:
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

RULE B_1D_P_1NT_1185_0:
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

RULE B_1D_P_2D_1187_1:
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

RULE B_1D_P_2H_1188_3:
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

RULE B_1D_P_2H_1188_4:
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

RULE B_1D_P_2S_1189_3:
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

RULE B_1D_P_2S_1189_4:
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

RULE B_1D_P_2NT_1190_0:
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

RULE B_1D_P_2NT_1190_1:
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

RULE B_1D_P_3C_1191_0:
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

RULE B_1D_P_3H_1193_0:
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

RULE B_1D_P_3S_1194_0:
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

RULE B_1D_P_3NT_1195_0:
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

RULE B_1D_P_4H_1196_0:
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

RULE B_1D_P_4S_1197_0:
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

RULE B_1D_P_5C_1199_0:
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

RULE B_1D_P_5D_1200_0:
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

RULE B_1D_X_PASS_1208_0:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1D'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp <= 5

RULE B_1D_X_1NT_1211_0:
  CALL: 1NT
  PRIORITY: 12
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1D'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp <= 10
  CONDITION: hcp >= 6

RULE B_1D_X_2D_1213_0:
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

RULE B_1D_X_2H_1214_0:
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

RULE B_1D_X_2S_1215_0:
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

RULE B_1D_X_2NT_1216_0:
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

RULE B_1D_X_3D_1217_0:
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

RULE B_1D_X_3H_1218_0:
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

RULE B_1D_X_3S_1219_0:
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

RULE B_1D_X_4D_1220_0:
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

RULE B_1D_X_4H_1221_0:
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

RULE B_1D_X_4S_1222_0:
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

RULE B_1D_X_XX_1223_0:
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

RULE B_1D_X_XX_1223_1:
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

RULE B_1D_X_XX_1223_2:
  CALL: XX
  PRIORITY: 42
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1D'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 11
  CONDITION: longest_suit_len <= 5

RULE B_1D_X_XX_1223_3:
  CALL: XX
  PRIORITY: 42
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1D'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 12
  CONDITION: club_len >= 5

RULE B_1D_1H_PASS_1224_0:
  CALL: PASS
  PRIORITY: 32
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1D'
  CONDITION: opp_last_call == '1H'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp <= 9

RULE B_1D_1H_PASS_1224_1:
  CALL: PASS
  PRIORITY: 32
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1D'
  CONDITION: opp_last_call == '1H'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp <= 6

RULE B_1D_1H_PASS_1224_2:
  CALL: PASS
  PRIORITY: 32
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1D'
  CONDITION: opp_last_call == '1H'
  CONDITION: passes_since_last_bid == 0
  CONDITION: heart_len >= 5
  CONDITION: hcp >= 10

RULE B_1D_1H_1S_1225_0:
  CALL: 1S
  PRIORITY: 80
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1D'
  CONDITION: opp_last_call == '1H'
  CONDITION: passes_since_last_bid == 0
  CONDITION: spade_hcp >= 6
  CONDITION: spade_len >= 5

RULE B_1D_1H_1NT_1226_0:
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

RULE B_1D_1H_1NT_1226_1:
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

RULE B_1D_1H_2C_1227_0:
  CALL: 2C
  PRIORITY: 55
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1D'
  CONDITION: opp_last_call == '1H'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 9
  CONDITION: club_len >= 5

RULE B_1D_1H_2C_1227_1_0:
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

RULE B_1D_1H_2C_1227_1_1:
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

RULE B_1D_1H_2C_1227_1_2:
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

RULE B_1D_1H_2C_1227_1_3:
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

RULE B_1D_1H_2C_1227_1_4:
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

RULE B_1D_1H_2C_1227_1_5:
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

RULE B_1D_1H_2C_1227_1_6:
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

RULE B_1D_1H_2C_1227_1_7:
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

RULE B_1D_1H_2C_1227_1_8:
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

RULE B_1D_1H_2C_1227_1_9:
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

RULE B_1D_1H_2C_1227_2:
  CALL: 2C
  PRIORITY: 55
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1D'
  CONDITION: opp_last_call == '1H'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 12
  CONDITION: club_len >= 4

RULE B_1D_1H_2C_1227_3:
  CALL: 2C
  PRIORITY: 55
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1D'
  CONDITION: opp_last_call == '1H'
  CONDITION: passes_since_last_bid == 0
  CONDITION: club_len >= 5
  CONDITION: hcp >= 12

RULE B_1D_1H_2D_1228_0:
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

RULE B_1D_1H_2D_1228_1:
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

RULE B_1D_1H_2D_1228_2:
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

RULE B_1D_1H_2H_1229_0:
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

RULE B_1D_1H_2H_1229_1:
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

RULE B_1D_1H_2NT_1230_0:
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

RULE B_1D_1H_2NT_1230_1:
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

RULE B_1D_1H_3C_1231_0:
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

RULE B_1D_1H_3D_1232_0:
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

RULE B_1D_1H_3S_1233_0:
  CALL: 3S
  PRIORITY: 60
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1D'
  CONDITION: opp_last_call == '1H'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 15
  CONDITION: spade_len >= 6

RULE B_1D_1H_3NT_1234_0:
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

RULE B_1D_1H_3NT_1234_1:
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

RULE B_1D_1H_4D_1235_0:
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

RULE B_1D_1H_4S_1236_0:
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

RULE B_1D_1S_PASS_1246_0:
  CALL: PASS
  PRIORITY: 32
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1D'
  CONDITION: opp_last_call == '1S'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp <= 9

RULE B_1D_1S_PASS_1246_1:
  CALL: PASS
  PRIORITY: 32
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1D'
  CONDITION: opp_last_call == '1S'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp <= 6

RULE B_1D_1S_PASS_1246_2:
  CALL: PASS
  PRIORITY: 32
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1D'
  CONDITION: opp_last_call == '1S'
  CONDITION: passes_since_last_bid == 0
  CONDITION: spade_len >= 5
  CONDITION: hcp >= 10

RULE B_1D_1S_1NT_1247_0:
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

RULE B_1D_1S_1NT_1247_1:
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

RULE B_1D_1S_2C_1248_0:
  CALL: 2C
  PRIORITY: 55
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1D'
  CONDITION: opp_last_call == '1S'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 9
  CONDITION: club_len >= 5

RULE B_1D_1S_2C_1248_1_0:
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

RULE B_1D_1S_2C_1248_1_1:
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

RULE B_1D_1S_2C_1248_1_2:
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

RULE B_1D_1S_2C_1248_1_3:
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

RULE B_1D_1S_2C_1248_1_4:
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

RULE B_1D_1S_2C_1248_1_5:
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

RULE B_1D_1S_2C_1248_1_6:
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

RULE B_1D_1S_2C_1248_1_7:
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

RULE B_1D_1S_2C_1248_1_8:
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

RULE B_1D_1S_2C_1248_1_9:
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

RULE B_1D_1S_2C_1248_2:
  CALL: 2C
  PRIORITY: 55
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1D'
  CONDITION: opp_last_call == '1S'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 12
  CONDITION: club_len >= 4

RULE B_1D_1S_2C_1248_3:
  CALL: 2C
  PRIORITY: 55
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1D'
  CONDITION: opp_last_call == '1S'
  CONDITION: passes_since_last_bid == 0
  CONDITION: club_len >= 5
  CONDITION: hcp >= 12

RULE B_1D_1S_2D_1249_0:
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

RULE B_1D_1S_2D_1249_1:
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

RULE B_1D_1S_2D_1249_2:
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

RULE B_1D_1S_2H_1250_0:
  CALL: 2H
  PRIORITY: 80
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1D'
  CONDITION: opp_last_call == '1S'
  CONDITION: passes_since_last_bid == 0
  CONDITION: heart_len >= 6
  CONDITION: hcp >= 8

RULE B_1D_1S_2H_1250_1:
  CALL: 2H
  PRIORITY: 80
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1D'
  CONDITION: opp_last_call == '1S'
  CONDITION: passes_since_last_bid == 0
  CONDITION: heart_len >= 5
  CONDITION: hcp >= 10

RULE B_1D_1S_2S_1251_0:
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

RULE B_1D_1S_2S_1251_1:
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

RULE B_1D_1S_2NT_1252_0:
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

RULE B_1D_1S_2NT_1252_1:
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

RULE B_1D_1S_3C_1253_0:
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

RULE B_1D_1S_3D_1254_0:
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

RULE B_1D_1S_3H_1255_0:
  CALL: 3H
  PRIORITY: 60
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1D'
  CONDITION: opp_last_call == '1S'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 15
  CONDITION: heart_len >= 6

RULE B_1D_1S_3NT_1256_0:
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

RULE B_1D_1S_3NT_1256_1:
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

RULE B_1D_1S_4D_1257_0:
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

RULE B_1D_1S_4H_1258_0:
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

RULE B_1D_2C_PASS_1268_0:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1D'
  CONDITION: opp_last_call == '2C'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp <= 11
  CONDITION: club_len >= 4

RULE B_1D_2C_PASS_1268_1:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1D'
  CONDITION: opp_last_call == '2C'
  CONDITION: passes_since_last_bid == 0
  CONDITION: club_len >= 4
  CONDITION: hcp >= 10

RULE B_1D_2C_PASS_1268_2:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1D'
  CONDITION: opp_last_call == '2C'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp <= 10

RULE B_1D_2C_PASS_1268_3:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1D'
  CONDITION: opp_last_call == '2C'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp <= 8

RULE B_1D_2C_PASS_1268_4:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1D'
  CONDITION: opp_last_call == '2C'
  CONDITION: passes_since_last_bid == 0
  CONDITION: club_len >= 5

RULE B_1D_2C_2D_1269_0:
  CALL: 2D
  PRIORITY: 52
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1D'
  CONDITION: opp_last_call == '2C'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 6
  CONDITION: diamond_len >= 4

RULE B_1D_2C_2NT_1272_0:
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

RULE B_1D_2C_3C_1273_0:
  CALL: 3C
  PRIORITY: 55
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1D'
  CONDITION: opp_last_call == '2C'
  CONDITION: passes_since_last_bid == 0
  CONDITION: diamond_len >= 4
  CONDITION: diamond_hcp >= 10

RULE B_1D_2C_3D_1274_0:
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

RULE B_1D_2C_3NT_1277_0:
  CALL: 3NT
  PRIORITY: 30
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1D'
  CONDITION: opp_last_call == '2C'
  CONDITION: passes_since_last_bid == 0
  CONDITION: c_stopper >= 2
  CONDITION: hcp >= 12

RULE B_1D_2C_4H_1278_0:
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

RULE B_1D_2C_4S_1279_0:
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

RULE B_1D_2C_X_1288_0:
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

RULE B_1D_2C_X_1288_1:
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

RULE B_1D_2D_PASS_1289_0:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1D'
  CONDITION: opp_last_call == '2D'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp <= 11

RULE B_1D_2D_2H_1290_0:
  CALL: 2H
  PRIORITY: 40
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1D'
  CONDITION: opp_last_call == '2D'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 10
  CONDITION: diamond_len >= 4

RULE B_1D_2D_2S_1291_0:
  CALL: 2S
  PRIORITY: 45
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1D'
  CONDITION: opp_last_call == '2D'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 10
  CONDITION: club_len >= 5

RULE B_1D_2D_2S_1291_1:
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

RULE B_1D_2D_2NT_1292_0:
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

RULE B_1D_2D_3C_1293_0:
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

RULE B_1D_2D_3D_1294_0:
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

RULE B_1D_2D_3H_1295_0:
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

RULE B_1D_2D_3S_1296_0:
  CALL: 3S
  PRIORITY: 56
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1D'
  CONDITION: opp_last_call == '2D'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 11
  CONDITION: diamond_len >= 5

RULE B_1D_2D_3NT_1297_0:
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

RULE B_1D_2D_4D_1298_0:
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

RULE B_1D_2D_4H_1299_0:
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

RULE B_1D_2D_4S_1300_0:
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

RULE B_1D_2D_X_1310_0:
  CALL: X
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1D'
  CONDITION: opp_last_call == '2D'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 12

RULE B_1D_2H_PASS_1311_0:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1D'
  CONDITION: opp_last_call == '2H'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp <= 11

RULE B_1D_2H_PASS_1311_2:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1D'
  CONDITION: opp_last_call == '2H'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp <= 9

RULE B_1D_2H_2S_1312_0:
  CALL: 2S
  PRIORITY: 70
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1D'
  CONDITION: opp_last_call == '2H'
  CONDITION: passes_since_last_bid == 0
  CONDITION: spade_hcp >= 11
  CONDITION: spade_len >= 5

RULE B_1D_2H_2NT_1313_0:
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

RULE B_1D_2H_3C_1314_0:
  CALL: 3C
  PRIORITY: 50
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1D'
  CONDITION: opp_last_call == '2H'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 10
  CONDITION: club_len >= 5

RULE B_1D_2H_3C_1314_1:
  CALL: 3C
  PRIORITY: 50
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1D'
  CONDITION: opp_last_call == '2H'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 11
  CONDITION: club_len >= 5

RULE B_1D_2H_3C_1314_2:
  CALL: 3C
  PRIORITY: 50
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1D'
  CONDITION: opp_last_call == '2H'
  CONDITION: passes_since_last_bid == 0
  CONDITION: club_len >= 4
  CONDITION: hcp >= 12

RULE B_1D_2H_3D_1315_0:
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

RULE B_1D_2H_3D_1315_1:
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

RULE B_1D_2H_3H_1317_0:
  CALL: 3H
  PRIORITY: 55
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1D'
  CONDITION: opp_last_call == '2H'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 12
  CONDITION: diamond_len >= 3

RULE B_1D_2H_3H_1317_1:
  CALL: 3H
  PRIORITY: 55
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1D'
  CONDITION: opp_last_call == '2H'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 11
  CONDITION: diamond_len >= 4

RULE B_1D_2H_X_1329_0:
  CALL: X
  PRIORITY: 60
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1D'
  CONDITION: opp_last_call == '2H'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 13
  CONDITION: spade_len >= 3

RULE B_1D_2H_X_1329_1:
  CALL: X
  PRIORITY: 60
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1D'
  CONDITION: opp_last_call == '2H'
  CONDITION: passes_since_last_bid == 0
  CONDITION: total_points >= 9
  CONDITION: spade_len >= 4

RULE B_1D_2S_PASS_1330_0:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1D'
  CONDITION: opp_last_call == '2S'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp <= 11

RULE B_1D_2S_PASS_1330_2:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1D'
  CONDITION: opp_last_call == '2S'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp <= 9

RULE B_1D_2S_2NT_1331_0:
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

RULE B_1D_2S_3C_1332_0:
  CALL: 3C
  PRIORITY: 50
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1D'
  CONDITION: opp_last_call == '2S'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 10
  CONDITION: club_len >= 5

RULE B_1D_2S_3C_1332_1:
  CALL: 3C
  PRIORITY: 50
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1D'
  CONDITION: opp_last_call == '2S'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 11
  CONDITION: club_len >= 5

RULE B_1D_2S_3C_1332_2:
  CALL: 3C
  PRIORITY: 50
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1D'
  CONDITION: opp_last_call == '2S'
  CONDITION: passes_since_last_bid == 0
  CONDITION: club_len >= 4
  CONDITION: hcp >= 12

RULE B_1D_2S_3D_1333_0:
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

RULE B_1D_2S_3D_1333_1:
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

RULE B_1D_2S_3S_1336_0:
  CALL: 3S
  PRIORITY: 55
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1D'
  CONDITION: opp_last_call == '2S'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 12
  CONDITION: diamond_len >= 3

RULE B_1D_2S_3S_1336_1:
  CALL: 3S
  PRIORITY: 55
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1D'
  CONDITION: opp_last_call == '2S'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 11
  CONDITION: diamond_len >= 4

RULE B_1D_2S_X_1347_0:
  CALL: X
  PRIORITY: 60
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1D'
  CONDITION: opp_last_call == '2S'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 13
  CONDITION: heart_len >= 3

RULE B_1D_2S_X_1347_1:
  CALL: X
  PRIORITY: 60
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1D'
  CONDITION: opp_last_call == '2S'
  CONDITION: passes_since_last_bid == 0
  CONDITION: total_points >= 9
  CONDITION: heart_len >= 4

RULE B_1D_3C_PASS_1348_0:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1D'
  CONDITION: opp_last_call == '3C'
  CONDITION: passes_since_last_bid == 0

RULE B_1D_3C_PASS_1348_1:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1D'
  CONDITION: opp_last_call == '3C'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp <= 9

RULE B_1D_3C_3D_1349_0:
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

RULE B_1D_3C_3NT_1352_0:
  CALL: 3NT
  PRIORITY: 30
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1D'
  CONDITION: opp_last_call == '3C'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 12
  CONDITION: c_stopper >= 2

RULE B_1D_3C_X_1355_0:
  CALL: X
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1D'
  CONDITION: opp_last_call == '3C'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 10

RULE B_1D_3D_PASS_1356_0:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1D'
  CONDITION: opp_last_call == '3D'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp <= 9

RULE B_1D_3D_X_1358_0:
  CALL: X
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1D'
  CONDITION: opp_last_call == '3D'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 10

RULE B_1D_3H_PASS_1359_0:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1D'
  CONDITION: opp_last_call == '3H'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp <= 12

RULE B_1D_3H_PASS_1359_1:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1D'
  CONDITION: opp_last_call == '3H'
  CONDITION: passes_since_last_bid == 0
  CONDITION: heart_len >= 4

RULE B_1D_3H_PASS_1359_2:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1D'
  CONDITION: opp_last_call == '3H'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp <= 8

RULE B_1D_3H_3S_1360_0:
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

RULE B_1D_3H_3S_1360_1:
  CALL: 3S
  PRIORITY: 100
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1D'
  CONDITION: opp_last_call == '3H'
  CONDITION: passes_since_last_bid == 0
  CONDITION: spade_len >= 6
  CONDITION: hcp >= 12

RULE B_1D_3H_4C_1362_0:
  CALL: 4C
  PRIORITY: 16
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1D'
  CONDITION: opp_last_call == '3H'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 12
  CONDITION: club_len >= 6

RULE B_1D_3H_4D_1363_0:
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

RULE B_1D_3H_4H_1364_0:
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

RULE B_1D_3H_4S_1365_0:
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

RULE B_1D_3H_5D_1367_0:
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

RULE B_1D_3H_6S_1372_0:
  CALL: 6S
  PRIORITY: 66
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1D'
  CONDITION: opp_last_call == '3H'
  CONDITION: passes_since_last_bid == 0
  CONDITION: spade_len >= 8
  CONDITION: losing_trick_count <= 3

RULE B_1D_3H_X_1376_0:
  CALL: X
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1D'
  CONDITION: opp_last_call == '3H'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 12

RULE B_1D_3H_X_1376_1:
  CALL: X
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1D'
  CONDITION: opp_last_call == '3H'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 10
  CONDITION: heart_len <= 2

RULE B_1D_3S_PASS_1377_0:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1D'
  CONDITION: opp_last_call == '3S'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp <= 12

RULE B_1D_3S_PASS_1377_1:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1D'
  CONDITION: opp_last_call == '3S'
  CONDITION: passes_since_last_bid == 0
  CONDITION: spade_len >= 4

RULE B_1D_3S_PASS_1377_2:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1D'
  CONDITION: opp_last_call == '3S'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp <= 8

RULE B_1D_3S_4C_1379_0:
  CALL: 4C
  PRIORITY: 16
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1D'
  CONDITION: opp_last_call == '3S'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 12
  CONDITION: club_len >= 6

RULE B_1D_3S_4D_1380_0:
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

RULE B_1D_3S_4H_1381_0:
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

RULE B_1D_3S_4S_1382_0:
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

RULE B_1D_3S_5D_1384_0:
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

RULE B_1D_3S_6H_1389_0:
  CALL: 6H
  PRIORITY: 66
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1D'
  CONDITION: opp_last_call == '3S'
  CONDITION: passes_since_last_bid == 0
  CONDITION: heart_len >= 8
  CONDITION: losing_trick_count <= 3

RULE B_1D_3S_X_1393_0:
  CALL: X
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1D'
  CONDITION: opp_last_call == '3S'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 12

RULE B_1D_3S_X_1393_1:
  CALL: X
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1D'
  CONDITION: opp_last_call == '3S'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 10
  CONDITION: spade_len <= 2

RULE B_1D_4C_PASS_1394_0:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1D'
  CONDITION: opp_last_call == '4C'
  CONDITION: passes_since_last_bid == 0

RULE B_1D_4C_X_1403_0:
  CALL: X
  PRIORITY: 90
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1D'
  CONDITION: opp_last_call == '4C'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 13

RULE B_1D_4H_PASS_1404_0:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1D'
  CONDITION: opp_last_call == '4H'
  CONDITION: passes_since_last_bid == 0

RULE B_1D_4H_5D_1409_0:
  CALL: 5D
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1D'
  CONDITION: opp_last_call == '4H'
  CONDITION: passes_since_last_bid == 0
  CONDITION: diamond_len >= 5
  CONDITION: hcp >= 12

RULE B_1D_4S_PASS_1420_0:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1D'
  CONDITION: opp_last_call == '4S'
  CONDITION: passes_since_last_bid == 0

RULE B_1D_4S_5D_1424_0:
  CALL: 5D
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1D'
  CONDITION: opp_last_call == '4S'
  CONDITION: passes_since_last_bid == 0
  CONDITION: diamond_len >= 5
  CONDITION: hcp >= 12

RULE B_1D_5C_PASS_1435_0:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1D'
  CONDITION: opp_last_call == '5C'
  CONDITION: passes_since_last_bid == 0

RULE B_1D_6C_PASS_1441_0:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1D'
  CONDITION: opp_last_call == '6C'
  CONDITION: passes_since_last_bid == 0

RULE B_1D_6H_PASS_1442_0:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1D'
  CONDITION: opp_last_call == '6H'
  CONDITION: passes_since_last_bid == 0

RULE B_1D_6S_PASS_1443_0:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1D'
  CONDITION: opp_last_call == '6S'
  CONDITION: passes_since_last_bid == 0

RULE B_1D_7H_PASS_1444_0:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1D'
  CONDITION: opp_last_call == '7H'
  CONDITION: passes_since_last_bid == 0

RULE B_1D_7S_PASS_1445_0:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1D'
  CONDITION: opp_last_call == '7S'
  CONDITION: passes_since_last_bid == 0

RULE B_1D_1N_PASS_1446_0:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1D'
  CONDITION: opp_last_call == '1NT'
  CONDITION: passes_since_last_bid == 0

RULE B_1D_1N_2H_1449_0:
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

RULE B_1D_1N_2S_1450_0:
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

RULE B_1D_1N_X_1454_0:
  CALL: X
  PRIORITY: 50
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1D'
  CONDITION: opp_last_call == '1NT'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 9

RULE B_1D_2N_PASS_1455_0:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1D'
  CONDITION: opp_last_call == '2NT'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp <= 10

RULE B_1D_2N_3C_1456_0:
  CALL: 3C
  PRIORITY: 15
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1D'
  CONDITION: opp_last_call == '2NT'
  CONDITION: passes_since_last_bid == 0
  CONDITION: diamond_len >= 4
  CONDITION: diamond_hcp >= 12

RULE B_1D_2N_3D_1457_0:
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

RULE B_1D_2N_3H_1458_0:
  CALL: 3H
  PRIORITY: 30
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1D'
  CONDITION: opp_last_call == '2NT'
  CONDITION: passes_since_last_bid == 0
  CONDITION: spade_len >= 5
  CONDITION: hcp >= 10

RULE B_1D_2N_3S_1459_0:
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

RULE B_1D_2N_3NT_1460_0:
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

RULE B_1D_2N_X_1470_0:
  CALL: X
  PRIORITY: 5
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1D'
  CONDITION: opp_last_call == '2NT'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 11

RULE B_1H_P_PASS_1471_0:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1H'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 1
  CONDITION: hcp <= 5

RULE B_1H_P_1S_1472_1:
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

RULE B_1H_P_1NT_1473_0:
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

RULE B_1H_P_2H_1476_0:
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

RULE B_1H_P_2H_1476_1:
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

RULE B_1H_P_2S_1477_2:
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

RULE B_1H_P_2S_1477_3:
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

RULE B_1H_P_2NT_1478_0:
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

RULE B_1H_P_3C_1479_0:
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

RULE B_1H_P_3D_1480_0:
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

RULE B_1H_P_3H_1481_0:
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

RULE B_1H_P_3S_1482_0:
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

RULE B_1H_P_4C_1484_0:
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

RULE B_1H_P_4D_1485_0:
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

RULE B_1H_P_4H_1486_0:
  CALL: 4H
  PRIORITY: 72
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1H'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 1
  CONDITION: hcp <= 8
  CONDITION: heart_len >= 5

RULE B_1H_P_4S_1487_0:
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

RULE B_1H_X_PASS_1496_0:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1H'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 0

RULE B_1H_X_1S_1497_0:
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

RULE B_1H_X_1S_1497_1:
  CALL: 1S
  PRIORITY: 35
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1H'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 0
  CONDITION: spade_len >= 6
  CONDITION: hcp >= 6

RULE B_1H_X_1NT_1498_0:
  CALL: 1NT
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1H'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp < 10
  CONDITION: hcp >= 7

RULE B_1H_X_2H_1501_0:
  CALL: 2H
  PRIORITY: 45
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1H'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 0
  CONDITION: heart_hcp >= 4
  CONDITION: heart_len >= 5

RULE B_1H_X_2H_1501_1:
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

RULE B_1H_X_2H_1501_2:
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

RULE B_1H_X_2NT_1503_0:
  CALL: 2NT
  PRIORITY: 120
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1H'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 0
  CONDITION: heart_hcp > 12
  CONDITION: heart_len >= 3

RULE B_1H_X_2NT_1503_1:
  CALL: 2NT
  PRIORITY: 120
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1H'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 10
  CONDITION: heart_len >= 3

RULE B_1H_X_3S_1507_0:
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

RULE B_1H_X_3NT_1508_0:
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

RULE B_1H_X_4C_1509_0:
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

RULE B_1H_X_4D_1510_0:
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

RULE B_1H_X_4H_1511_0:
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

RULE B_1H_X_XX_1513_0:
  CALL: XX
  PRIORITY: 25
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1H'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 10
  CONDITION: spade_len <= 5

RULE B_1H_X_XX_1513_1:
  CALL: XX
  PRIORITY: 25
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1H'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 10

RULE B_1H_1S_PASS_1514_0:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1H'
  CONDITION: opp_last_call == '1S'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp <= 9

RULE B_1H_1S_PASS_1514_1:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1H'
  CONDITION: opp_last_call == '1S'
  CONDITION: passes_since_last_bid == 0
  CONDITION: spade_len >= 5

RULE B_1H_1S_1NT_1515_0:
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

RULE B_1H_1S_1NT_1515_1:
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

RULE B_1H_1S_2C_1516_0:
  CALL: 2C
  PRIORITY: -1
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1H'
  CONDITION: opp_last_call == '1S'
  CONDITION: passes_since_last_bid == 0
  CONDITION: total_points >= 9
  CONDITION: club_len >= 6

RULE B_1H_1S_2D_1519_0:
  CALL: 2D
  PRIORITY: -1
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1H'
  CONDITION: opp_last_call == '1S'
  CONDITION: passes_since_last_bid == 0
  CONDITION: total_points >= 9
  CONDITION: diamond_len >= 6

RULE B_1H_1S_2H_1522_0:
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

RULE B_1H_1S_2S_1523_0:
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

RULE B_1H_1S_2S_1523_1:
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

RULE B_1H_1S_2NT_1524_0:
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

RULE B_1H_1S_3H_1525_0:
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

RULE B_1H_1S_3S_1526_0:
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

RULE B_1H_1S_3NT_1527_0:
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

RULE B_1H_1S_4H_1528_0:
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

RULE B_1H_1S_X_1529_0:
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

RULE B_1H_2C_PASS_1530_0:
  CALL: PASS
  PRIORITY: 20
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1H'
  CONDITION: opp_last_call == '2C'
  CONDITION: passes_since_last_bid == 0

RULE B_1H_2C_PASS_1530_1:
  CALL: PASS
  PRIORITY: 20
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1H'
  CONDITION: opp_last_call == '2C'
  CONDITION: passes_since_last_bid == 0
  CONDITION: club_len >= 4
  CONDITION: hcp >= 10

RULE B_1H_2C_PASS_1530_2:
  CALL: PASS
  PRIORITY: 20
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1H'
  CONDITION: opp_last_call == '2C'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp <= 8

RULE B_1H_2C_PASS_1530_3:
  CALL: PASS
  PRIORITY: 20
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1H'
  CONDITION: opp_last_call == '2C'
  CONDITION: passes_since_last_bid == 0
  CONDITION: club_len >= 5

RULE B_1H_2C_2D_1531_0:
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

RULE B_1H_2C_2D_1531_1:
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

RULE B_1H_2C_2D_1531_2:
  CALL: 2D
  PRIORITY: 30
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1H'
  CONDITION: opp_last_call == '2C'
  CONDITION: passes_since_last_bid == 0
  CONDITION: diamond_len >= 5
  CONDITION: hcp >= 9

RULE B_1H_2C_2H_1532_0:
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

RULE B_1H_2C_2S_1533_0:
  CALL: 2S
  PRIORITY: 60
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1H'
  CONDITION: opp_last_call == '2C'
  CONDITION: passes_since_last_bid == 0
  CONDITION: spade_len >= 5
  CONDITION: hcp >= 9

RULE B_1H_2C_2S_1533_1:
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

RULE B_1H_2C_2NT_1534_0:
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

RULE B_1H_2C_3C_1535_0:
  CALL: 3C
  PRIORITY: 70
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1H'
  CONDITION: opp_last_call == '2C'
  CONDITION: passes_since_last_bid == 0
  CONDITION: heart_len >= 3
  CONDITION: hcp >= 10

RULE B_1H_2C_3D_1536_0:
  CALL: 3D
  PRIORITY: 20
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1H'
  CONDITION: opp_last_call == '2C'
  CONDITION: passes_since_last_bid == 0
  CONDITION: diamond_len >= 6
  CONDITION: hcp >= 15

RULE B_1H_2C_3H_1537_0:
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

RULE B_1H_2C_4C_1539_0:
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

RULE B_1H_2C_4H_1540_0:
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

RULE B_1H_2C_X_1549_0:
  CALL: X
  PRIORITY: 46
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1H'
  CONDITION: opp_last_call == '2C'
  CONDITION: passes_since_last_bid == 0
  CONDITION: spade_len >= 4
  CONDITION: hcp >= 8

RULE B_1H_2C_X_1549_1:
  CALL: X
  PRIORITY: 46
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1H'
  CONDITION: opp_last_call == '2C'
  CONDITION: passes_since_last_bid == 0
  CONDITION: spade_len >= 5
  CONDITION: hcp >= 7

RULE B_1H_2C_X_1549_2:
  CALL: X
  PRIORITY: 46
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1H'
  CONDITION: opp_last_call == '2C'
  CONDITION: passes_since_last_bid == 0
  CONDITION: spade_len >= 6
  CONDITION: hcp >= 6

RULE B_1H_2D_PASS_1550_0:
  CALL: PASS
  PRIORITY: 20
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1H'
  CONDITION: opp_last_call == '2D'
  CONDITION: passes_since_last_bid == 0

RULE B_1H_2D_PASS_1550_1:
  CALL: PASS
  PRIORITY: 20
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1H'
  CONDITION: opp_last_call == '2D'
  CONDITION: passes_since_last_bid == 0
  CONDITION: diamond_len >= 4
  CONDITION: hcp >= 10

RULE B_1H_2D_PASS_1550_2:
  CALL: PASS
  PRIORITY: 20
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1H'
  CONDITION: opp_last_call == '2D'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp <= 8

RULE B_1H_2D_PASS_1550_3:
  CALL: PASS
  PRIORITY: 20
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1H'
  CONDITION: opp_last_call == '2D'
  CONDITION: passes_since_last_bid == 0
  CONDITION: diamond_len >= 5

RULE B_1H_2D_2H_1551_0:
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

RULE B_1H_2D_2S_1552_0:
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

RULE B_1H_2D_2NT_1553_0:
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

RULE B_1H_2D_3C_1554_0:
  CALL: 3C
  PRIORITY: 20
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1H'
  CONDITION: opp_last_call == '2D'
  CONDITION: passes_since_last_bid == 0
  CONDITION: club_len >= 5
  CONDITION: hcp >= 10

RULE B_1H_2D_3D_1555_0:
  CALL: 3D
  PRIORITY: 70
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1H'
  CONDITION: opp_last_call == '2D'
  CONDITION: passes_since_last_bid == 0
  CONDITION: heart_len >= 3
  CONDITION: hcp >= 10

RULE B_1H_2D_3H_1556_0:
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

RULE B_1H_2D_4D_1558_0:
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

RULE B_1H_2D_4H_1559_0:
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

RULE B_1H_2D_X_1568_0:
  CALL: X
  PRIORITY: 46
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1H'
  CONDITION: opp_last_call == '2D'
  CONDITION: passes_since_last_bid == 0
  CONDITION: spade_len >= 4
  CONDITION: hcp >= 8

RULE B_1H_2D_X_1568_1:
  CALL: X
  PRIORITY: 46
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1H'
  CONDITION: opp_last_call == '2D'
  CONDITION: passes_since_last_bid == 0
  CONDITION: spade_len >= 5
  CONDITION: hcp >= 7

RULE B_1H_2D_X_1568_2:
  CALL: X
  PRIORITY: 46
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1H'
  CONDITION: opp_last_call == '2D'
  CONDITION: passes_since_last_bid == 0
  CONDITION: spade_len >= 6
  CONDITION: hcp >= 6

RULE B_1H_2H_PASS_1569_0:
  CALL: PASS
  PRIORITY: -1
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1H'
  CONDITION: opp_last_call == '2H'
  CONDITION: passes_since_last_bid == 0
  CONDITION: spade_len >= 4

RULE B_1H_2H_PASS_1570_0:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1H'
  CONDITION: opp_last_call == '2H'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp <= 11
  CONDITION: heart_len <= 3

RULE B_1H_2H_PASS_1570_1:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1H'
  CONDITION: opp_last_call == '2H'
  CONDITION: passes_since_last_bid == 0
  CONDITION: total_points <= 7

RULE B_1H_2H_2S_1571_0:
  CALL: 2S
  PRIORITY: 60
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1H'
  CONDITION: opp_last_call == '2H'
  CONDITION: passes_since_last_bid == 0
  CONDITION: heart_len >= 4
  CONDITION: heart_hcp >= 14

RULE B_1H_2H_2S_1571_1:
  CALL: 2S
  PRIORITY: 60
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1H'
  CONDITION: opp_last_call == '2H'
  CONDITION: passes_since_last_bid == 0
  CONDITION: heart_len >= 3
  CONDITION: hcp >= 10

RULE B_1H_2H_3C_1572_0:
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

RULE B_1H_2H_3D_1573_0:
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

RULE B_1H_2H_3H_1574_0:
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

RULE B_1H_2H_3S_1575_0:
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

RULE B_1H_2H_3NT_1576_0:
  CALL: 3NT
  PRIORITY: 20
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1H'
  CONDITION: opp_last_call == '2H'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 12
  CONDITION: s_stopper >= 2

RULE B_1H_2H_4H_1577_0:
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

RULE B_1H_2H_4H_1577_1:
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

RULE B_1H_2H_4H_1577_2:
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

RULE B_1H_2H_5C_1578_0:
  CALL: 5C
  PRIORITY: 55
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1H'
  CONDITION: opp_last_call == '2H'
  CONDITION: passes_since_last_bid == 0
  CONDITION: club_len >= 8
  CONDITION: losing_trick_count <= 5

RULE B_1H_2H_5D_1579_0:
  CALL: 5D
  PRIORITY: 55
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1H'
  CONDITION: opp_last_call == '2H'
  CONDITION: passes_since_last_bid == 0
  CONDITION: diamond_len >= 8
  CONDITION: losing_trick_count <= 5

RULE B_1H_2H_X_1580_0:
  CALL: X
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1H'
  CONDITION: opp_last_call == '2H'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 12

RULE B_1H_2S_PASS_1581_0:
  CALL: PASS
  PRIORITY: 20
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1H'
  CONDITION: opp_last_call == '2S'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp <= 11

RULE B_1H_2S_PASS_1581_1:
  CALL: PASS
  PRIORITY: 20
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1H'
  CONDITION: opp_last_call == '2S'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp <= 9

RULE B_1H_2S_PASS_1581_2:
  CALL: PASS
  PRIORITY: 20
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1H'
  CONDITION: opp_last_call == '2S'
  CONDITION: passes_since_last_bid == 0
  CONDITION: spade_len >= 5
  CONDITION: hcp >= 8

RULE B_1H_2S_2NT_1582_0:
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

RULE B_1H_2S_3H_1586_0:
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

RULE B_1H_2S_3NT_1588_0:
  CALL: 3NT
  PRIORITY: 22
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1H'
  CONDITION: opp_last_call == '2S'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 12
  CONDITION: s_stopper >= 2

RULE B_1H_2S_X_1590_0:
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

RULE B_1H_2S_X_1590_1:
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

RULE B_1H_3C_PASS_1591_0:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1H'
  CONDITION: opp_last_call == '3C'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp <= 11

RULE B_1H_3C_3D_1592_0:
  CALL: 3D
  PRIORITY: 20
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1H'
  CONDITION: opp_last_call == '3C'
  CONDITION: passes_since_last_bid == 0
  CONDITION: total_points >= 12
  CONDITION: diamond_len >= 5

RULE B_1H_3C_3H_1593_0:
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

RULE B_1H_3C_3S_1594_0:
  CALL: 3S
  PRIORITY: 35
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1H'
  CONDITION: opp_last_call == '3C'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 12
  CONDITION: spade_len >= 5

RULE B_1H_3C_3NT_1595_0:
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

RULE B_1H_3C_4C_1596_0:
  CALL: 4C
  PRIORITY: 56
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1H'
  CONDITION: opp_last_call == '3C'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 13
  CONDITION: heart_len >= 2

RULE B_1H_3C_4C_1596_1:
  CALL: 4C
  PRIORITY: 56
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1H'
  CONDITION: opp_last_call == '3C'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 13
  CONDITION: heart_len >= 3

RULE B_1H_3C_4H_1597_0:
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

RULE B_1H_3C_4H_1597_1:
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

RULE B_1H_3C_4H_1597_2:
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

RULE B_1H_3C_4H_1597_3:
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

RULE B_1H_3C_4S_1598_0:
  CALL: 4S
  PRIORITY: 15
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1H'
  CONDITION: opp_last_call == '3C'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 10
  CONDITION: spade_len >= 7

RULE B_1H_3C_X_1607_0:
  CALL: X
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1H'
  CONDITION: opp_last_call == '3C'
  CONDITION: passes_since_last_bid == 0
  CONDITION: spade_len >= 4
  CONDITION: hcp >= 10

RULE B_1H_3D_PASS_1608_0:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1H'
  CONDITION: opp_last_call == '3D'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp <= 11

RULE B_1H_3D_3H_1609_0:
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

RULE B_1H_3D_3S_1610_0:
  CALL: 3S
  PRIORITY: 35
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1H'
  CONDITION: opp_last_call == '3D'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 12
  CONDITION: spade_len >= 5

RULE B_1H_3D_3NT_1611_0:
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

RULE B_1H_3D_4C_1612_0:
  CALL: 4C
  PRIORITY: 5
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1H'
  CONDITION: opp_last_call == '3D'
  CONDITION: passes_since_last_bid == 0
  CONDITION: club_len >= 6
  CONDITION: hcp >= 10

RULE B_1H_3D_4D_1613_0:
  CALL: 4D
  PRIORITY: 56
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1H'
  CONDITION: opp_last_call == '3D'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 13
  CONDITION: heart_len >= 2

RULE B_1H_3D_4D_1613_1:
  CALL: 4D
  PRIORITY: 56
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1H'
  CONDITION: opp_last_call == '3D'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 13
  CONDITION: heart_len >= 3

RULE B_1H_3D_4H_1614_0:
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

RULE B_1H_3D_4H_1614_1:
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

RULE B_1H_3D_4H_1614_2:
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

RULE B_1H_3D_4H_1614_3:
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

RULE B_1H_3D_4S_1615_0:
  CALL: 4S
  PRIORITY: 15
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1H'
  CONDITION: opp_last_call == '3D'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 10
  CONDITION: spade_len >= 7

RULE B_1H_3D_X_1624_0:
  CALL: X
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1H'
  CONDITION: opp_last_call == '3D'
  CONDITION: passes_since_last_bid == 0
  CONDITION: spade_len >= 4
  CONDITION: hcp >= 10

RULE B_1H_3S_PASS_1625_0:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1H'
  CONDITION: opp_last_call == '3S'
  CONDITION: passes_since_last_bid == 0

RULE B_1H_3S_4C_1627_1:
  CALL: 4C
  PRIORITY: 40
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1H'
  CONDITION: opp_last_call == '3S'
  CONDITION: passes_since_last_bid == 0
  CONDITION: club_len >= 6
  CONDITION: hcp >= 12

RULE B_1H_3S_4D_1628_1:
  CALL: 4D
  PRIORITY: 40
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1H'
  CONDITION: opp_last_call == '3S'
  CONDITION: passes_since_last_bid == 0
  CONDITION: diamond_len >= 6
  CONDITION: hcp >= 12

RULE B_1H_3S_4H_1629_2:
  CALL: 4H
  PRIORITY: 50
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1H'
  CONDITION: opp_last_call == '3S'
  CONDITION: passes_since_last_bid == 0
  CONDITION: heart_len >= 3
  CONDITION: heart_hcp >= 10

RULE B_1H_3S_5C_1632_0:
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

RULE B_1H_3S_5D_1633_0:
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

RULE B_1H_3S_X_1641_0:
  CALL: X
  PRIORITY: 5
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1H'
  CONDITION: opp_last_call == '3S'
  CONDITION: passes_since_last_bid == 0
  CONDITION: heart_len >= 2
  CONDITION: hcp >= 10

RULE B_1H_3S_X_1642_0:
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

RULE B_1H_3S_X_1642_1:
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

RULE B_1H_4C_PASS_1643_0:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1H'
  CONDITION: opp_last_call == '4C'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp <= 11

RULE B_1H_4C_4H_1644_0:
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

RULE B_1H_4C_4H_1644_1:
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

RULE B_1H_4C_4S_1645_0:
  CALL: 4S
  PRIORITY: 30
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1H'
  CONDITION: opp_last_call == '4C'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 12
  CONDITION: spade_len >= 6

RULE B_1H_4C_X_1655_0:
  CALL: X
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1H'
  CONDITION: opp_last_call == '4C'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 10

RULE B_1H_4D_PASS_1656_0:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1H'
  CONDITION: opp_last_call == '4D'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp <= 11

RULE B_1H_4D_4H_1657_0:
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

RULE B_1H_4D_4H_1657_1:
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

RULE B_1H_4D_4S_1658_0:
  CALL: 4S
  PRIORITY: 30
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1H'
  CONDITION: opp_last_call == '4D'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 12
  CONDITION: spade_len >= 6

RULE B_1H_4D_X_1668_0:
  CALL: X
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1H'
  CONDITION: opp_last_call == '4D'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 10

RULE B_1H_5C_PASS_1682_0:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1H'
  CONDITION: opp_last_call == '5C'
  CONDITION: passes_since_last_bid == 0

RULE B_1H_5D_PASS_1686_1:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1H'
  CONDITION: opp_last_call == '5D'
  CONDITION: passes_since_last_bid == 0

RULE B_1H_5D_5H_1687_0:
  CALL: 5H
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1H'
  CONDITION: opp_last_call == '5D'
  CONDITION: passes_since_last_bid == 0
  CONDITION: heart_len >= 3
  CONDITION: hcp >= 12

RULE B_1H_5D_X_1690_0:
  CALL: X
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1H'
  CONDITION: opp_last_call == '5D'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 13

RULE B_1H_6C_PASS_1691_0:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1H'
  CONDITION: opp_last_call == '6C'
  CONDITION: passes_since_last_bid == 0

RULE B_1H_6D_PASS_1692_0:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1H'
  CONDITION: opp_last_call == '6D'
  CONDITION: passes_since_last_bid == 0

RULE B_1H_6S_PASS_1693_0:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1H'
  CONDITION: opp_last_call == '6S'
  CONDITION: passes_since_last_bid == 0

RULE B_1H_1N_PASS_1694_0:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1H'
  CONDITION: opp_last_call == '1NT'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp <= 8

RULE B_1H_1N_2C_1695_0:
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

RULE B_1H_1N_2D_1696_0:
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

RULE B_1H_1N_2H_1697_0:
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

RULE B_1H_1N_2S_1698_0:
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

RULE B_1H_1N_3H_1699_0:
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

RULE B_1H_1N_3H_1699_1:
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

RULE B_1H_1N_4H_1701_0:
  CALL: 4H
  PRIORITY: 65
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1H'
  CONDITION: opp_last_call == '1NT'
  CONDITION: passes_since_last_bid == 0
  CONDITION: heart_hcp >= 11
  CONDITION: heart_len >= 4

RULE B_1H_1N_4S_1702_0:
  CALL: 4S
  PRIORITY: 63
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1H'
  CONDITION: opp_last_call == '1NT'
  CONDITION: passes_since_last_bid == 0
  CONDITION: spade_hcp >= 11
  CONDITION: heart_len >= 7

RULE B_1H_2N_PASS_1704_0:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1H'
  CONDITION: opp_last_call == '2NT'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp <= 8

RULE B_1H_2N_3C_1705_0:
  CALL: 3C
  PRIORITY: 60
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1H'
  CONDITION: opp_last_call == '2NT'
  CONDITION: passes_since_last_bid == 0
  CONDITION: heart_len >= 3
  CONDITION: hcp >= 10

RULE B_1H_2N_3D_1706_0:
  CALL: 3D
  PRIORITY: 50
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1H'
  CONDITION: opp_last_call == '2NT'
  CONDITION: passes_since_last_bid == 0
  CONDITION: spade_len >= 5
  CONDITION: hcp >= 10

RULE B_1H_2N_3H_1707_0:
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

RULE B_1H_2N_3S_1708_0:
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

RULE B_1H_2N_3NT_1709_0:
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

RULE B_1H_2N_4H_1710_0:
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

RULE B_1H_2N_4S_1711_0:
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

RULE B_1H_2N_X_1720_0:
  CALL: X
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1H'
  CONDITION: opp_last_call == '2NT'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 9

RULE B_1S_P_PASS_1721_0:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1S'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 1
  CONDITION: hcp <= 5

RULE B_1S_P_1NT_1722_0:
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

RULE B_1S_P_2C_1723_2:
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

RULE B_1S_P_2S_1726_0:
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

RULE B_1S_P_2S_1726_1:
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

RULE B_1S_P_2NT_1727_0:
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

RULE B_1S_P_3C_1728_0:
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

RULE B_1S_P_3D_1729_0:
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

RULE B_1S_P_3H_1730_0:
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

RULE B_1S_P_3S_1731_0:
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

RULE B_1S_P_4C_1733_0:
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

RULE B_1S_P_4D_1734_0:
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

RULE B_1S_P_4H_1735_0:
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

RULE B_1S_P_4S_1736_0:
  CALL: 4S
  PRIORITY: 72
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1S'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 1
  CONDITION: hcp <= 8
  CONDITION: spade_len >= 5

RULE B_1S_X_PASS_1745_0:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1S'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 0

RULE B_1S_X_1NT_1746_0:
  CALL: 1NT
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1S'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp < 10
  CONDITION: hcp >= 7

RULE B_1S_X_2H_1749_0:
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

RULE B_1S_X_2S_1750_0:
  CALL: 2S
  PRIORITY: 45
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1S'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 0
  CONDITION: spade_hcp >= 4
  CONDITION: spade_len >= 5

RULE B_1S_X_2S_1750_1:
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

RULE B_1S_X_2S_1750_2:
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

RULE B_1S_X_2NT_1751_0:
  CALL: 2NT
  PRIORITY: 120
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1S'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 0
  CONDITION: spade_hcp > 12
  CONDITION: spade_len >= 3

RULE B_1S_X_2NT_1751_1:
  CALL: 2NT
  PRIORITY: 120
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1S'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 10
  CONDITION: spade_len >= 3

RULE B_1S_X_3NT_1755_0:
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

RULE B_1S_X_4C_1756_0:
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

RULE B_1S_X_4D_1757_0:
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

RULE B_1S_X_4H_1758_0:
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

RULE B_1S_X_4S_1759_0:
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

RULE B_1S_X_XX_1760_0:
  CALL: XX
  PRIORITY: 25
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1S'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 10

RULE B_1S_2C_PASS_1761_0:
  CALL: PASS
  PRIORITY: 20
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1S'
  CONDITION: opp_last_call == '2C'
  CONDITION: passes_since_last_bid == 0

RULE B_1S_2C_PASS_1761_1:
  CALL: PASS
  PRIORITY: 20
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1S'
  CONDITION: opp_last_call == '2C'
  CONDITION: passes_since_last_bid == 0
  CONDITION: club_len >= 4
  CONDITION: hcp >= 10

RULE B_1S_2C_PASS_1761_2:
  CALL: PASS
  PRIORITY: 20
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1S'
  CONDITION: opp_last_call == '2C'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp <= 8

RULE B_1S_2C_PASS_1761_3:
  CALL: PASS
  PRIORITY: 20
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1S'
  CONDITION: opp_last_call == '2C'
  CONDITION: passes_since_last_bid == 0
  CONDITION: club_len >= 5

RULE B_1S_2C_2D_1762_0:
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

RULE B_1S_2C_2D_1762_1:
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

RULE B_1S_2C_2D_1762_2:
  CALL: 2D
  PRIORITY: 30
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1S'
  CONDITION: opp_last_call == '2C'
  CONDITION: passes_since_last_bid == 0
  CONDITION: diamond_len >= 5
  CONDITION: hcp >= 9

RULE B_1S_2C_2H_1763_0:
  CALL: 2H
  PRIORITY: 60
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1S'
  CONDITION: opp_last_call == '2C'
  CONDITION: passes_since_last_bid == 0
  CONDITION: heart_len >= 5
  CONDITION: hcp >= 9

RULE B_1S_2C_2H_1763_1:
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

RULE B_1S_2C_2S_1764_0:
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

RULE B_1S_2C_2NT_1765_0:
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

RULE B_1S_2C_3C_1766_0:
  CALL: 3C
  PRIORITY: 70
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1S'
  CONDITION: opp_last_call == '2C'
  CONDITION: passes_since_last_bid == 0
  CONDITION: spade_len >= 3
  CONDITION: hcp >= 10

RULE B_1S_2C_3D_1767_0:
  CALL: 3D
  PRIORITY: 20
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1S'
  CONDITION: opp_last_call == '2C'
  CONDITION: passes_since_last_bid == 0
  CONDITION: diamond_len >= 6
  CONDITION: hcp >= 15

RULE B_1S_2C_3S_1768_0:
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

RULE B_1S_2C_4C_1770_0:
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

RULE B_1S_2C_4S_1771_0:
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

RULE B_1S_2C_X_1780_0:
  CALL: X
  PRIORITY: 46
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1S'
  CONDITION: opp_last_call == '2C'
  CONDITION: passes_since_last_bid == 0
  CONDITION: heart_len >= 4
  CONDITION: hcp >= 8

RULE B_1S_2C_X_1780_1:
  CALL: X
  PRIORITY: 46
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1S'
  CONDITION: opp_last_call == '2C'
  CONDITION: passes_since_last_bid == 0
  CONDITION: heart_len >= 5
  CONDITION: hcp >= 7

RULE B_1S_2C_X_1780_2:
  CALL: X
  PRIORITY: 46
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1S'
  CONDITION: opp_last_call == '2C'
  CONDITION: passes_since_last_bid == 0
  CONDITION: heart_len >= 6
  CONDITION: hcp >= 6

RULE B_1S_2D_PASS_1781_0:
  CALL: PASS
  PRIORITY: 20
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1S'
  CONDITION: opp_last_call == '2D'
  CONDITION: passes_since_last_bid == 0

RULE B_1S_2D_PASS_1781_1:
  CALL: PASS
  PRIORITY: 20
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1S'
  CONDITION: opp_last_call == '2D'
  CONDITION: passes_since_last_bid == 0
  CONDITION: diamond_len >= 4
  CONDITION: hcp >= 10

RULE B_1S_2D_PASS_1781_2:
  CALL: PASS
  PRIORITY: 20
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1S'
  CONDITION: opp_last_call == '2D'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp <= 8

RULE B_1S_2D_PASS_1781_3:
  CALL: PASS
  PRIORITY: 20
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1S'
  CONDITION: opp_last_call == '2D'
  CONDITION: passes_since_last_bid == 0
  CONDITION: diamond_len >= 5

RULE B_1S_2D_2H_1782_0:
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

RULE B_1S_2D_2S_1783_0:
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

RULE B_1S_2D_2NT_1784_0:
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

RULE B_1S_2D_3C_1785_0:
  CALL: 3C
  PRIORITY: 20
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1S'
  CONDITION: opp_last_call == '2D'
  CONDITION: passes_since_last_bid == 0
  CONDITION: club_len >= 5
  CONDITION: hcp >= 10

RULE B_1S_2D_3D_1786_0:
  CALL: 3D
  PRIORITY: 70
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1S'
  CONDITION: opp_last_call == '2D'
  CONDITION: passes_since_last_bid == 0
  CONDITION: spade_len >= 3
  CONDITION: hcp >= 10

RULE B_1S_2D_3S_1787_0:
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

RULE B_1S_2D_4D_1789_0:
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

RULE B_1S_2D_4S_1790_0:
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

RULE B_1S_2D_X_1799_0:
  CALL: X
  PRIORITY: 46
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1S'
  CONDITION: opp_last_call == '2D'
  CONDITION: passes_since_last_bid == 0
  CONDITION: heart_len >= 4
  CONDITION: hcp >= 8

RULE B_1S_2D_X_1799_1:
  CALL: X
  PRIORITY: 46
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1S'
  CONDITION: opp_last_call == '2D'
  CONDITION: passes_since_last_bid == 0
  CONDITION: heart_len >= 5
  CONDITION: hcp >= 7

RULE B_1S_2D_X_1799_2:
  CALL: X
  PRIORITY: 46
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1S'
  CONDITION: opp_last_call == '2D'
  CONDITION: passes_since_last_bid == 0
  CONDITION: heart_len >= 6
  CONDITION: hcp >= 6

RULE B_1S_2H_PASS_1800_0:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1S'
  CONDITION: opp_last_call == '2H'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp <= 11

RULE B_1S_2H_PASS_1800_1:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1S'
  CONDITION: opp_last_call == '2H'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp <= 8

RULE B_1S_2H_2S_1801_0:
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

RULE B_1S_2H_2NT_1802_0:
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

RULE B_1S_2H_3C_1803_0:
  CALL: 3C
  PRIORITY: 29
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1S'
  CONDITION: opp_last_call == '2H'
  CONDITION: passes_since_last_bid == 0
  CONDITION: club_len >= 5
  CONDITION: hcp >= 10

RULE B_1S_2H_3C_1803_1:
  CALL: 3C
  PRIORITY: 29
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1S'
  CONDITION: opp_last_call == '2H'
  CONDITION: passes_since_last_bid == 0
  CONDITION: club_len >= 5
  CONDITION: total_points >= 13

RULE B_1S_2H_3D_1804_0:
  CALL: 3D
  PRIORITY: 29
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1S'
  CONDITION: opp_last_call == '2H'
  CONDITION: passes_since_last_bid == 0
  CONDITION: diamond_len >= 5
  CONDITION: hcp >= 10

RULE B_1S_2H_3D_1804_1:
  CALL: 3D
  PRIORITY: 29
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1S'
  CONDITION: opp_last_call == '2H'
  CONDITION: passes_since_last_bid == 0
  CONDITION: diamond_len >= 5
  CONDITION: total_points >= 13

RULE B_1S_2H_3H_1805_0:
  CALL: 3H
  PRIORITY: 32
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1S'
  CONDITION: opp_last_call == '2H'
  CONDITION: passes_since_last_bid == 0
  CONDITION: spade_len >= 3
  CONDITION: hcp >= 10

RULE B_1S_2H_3H_1805_1:
  CALL: 3H
  PRIORITY: 32
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1S'
  CONDITION: opp_last_call == '2H'
  CONDITION: passes_since_last_bid == 0
  CONDITION: spade_len >= 3
  CONDITION: spade_hcp >= 12

RULE B_1S_2H_3S_1806_0:
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

RULE B_1S_2H_4S_1809_0:
  CALL: 4S
  PRIORITY: 40
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1S'
  CONDITION: opp_last_call == '2H'
  CONDITION: passes_since_last_bid == 0
  CONDITION: spade_len >= 5
  CONDITION: hcp <= 8

RULE B_1S_2H_X_1810_0:
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

RULE B_1S_2S_PASS_1811_0:
  CALL: PASS
  PRIORITY: -1
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1S'
  CONDITION: opp_last_call == '2S'
  CONDITION: passes_since_last_bid == 0
  CONDITION: heart_len >= 4

RULE B_1S_2S_PASS_1812_0:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1S'
  CONDITION: opp_last_call == '2S'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp <= 11
  CONDITION: spade_len <= 3

RULE B_1S_2S_PASS_1812_1:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1S'
  CONDITION: opp_last_call == '2S'
  CONDITION: passes_since_last_bid == 0
  CONDITION: total_points <= 7

RULE B_1S_2S_3C_1813_0:
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

RULE B_1S_2S_3D_1814_0:
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

RULE B_1S_2S_3H_1815_0:
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

RULE B_1S_2S_3H_1815_1:
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

RULE B_1S_2S_3S_1816_0:
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

RULE B_1S_2S_3NT_1817_0:
  CALL: 3NT
  PRIORITY: 20
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1S'
  CONDITION: opp_last_call == '2S'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 12
  CONDITION: h_stopper >= 2

RULE B_1S_2S_4S_1818_0:
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

RULE B_1S_2S_4S_1818_1:
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

RULE B_1S_2S_4S_1818_2:
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

RULE B_1S_2S_5C_1819_0:
  CALL: 5C
  PRIORITY: 55
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1S'
  CONDITION: opp_last_call == '2S'
  CONDITION: passes_since_last_bid == 0
  CONDITION: club_len >= 8
  CONDITION: losing_trick_count <= 5

RULE B_1S_2S_5D_1820_0:
  CALL: 5D
  PRIORITY: 55
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1S'
  CONDITION: opp_last_call == '2S'
  CONDITION: passes_since_last_bid == 0
  CONDITION: diamond_len >= 8
  CONDITION: losing_trick_count <= 5

RULE B_1S_2S_X_1821_0:
  CALL: X
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1S'
  CONDITION: opp_last_call == '2S'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 12

RULE B_1S_3C_PASS_1822_0:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1S'
  CONDITION: opp_last_call == '3C'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp <= 11

RULE B_1S_3C_3D_1823_0:
  CALL: 3D
  PRIORITY: 20
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1S'
  CONDITION: opp_last_call == '3C'
  CONDITION: passes_since_last_bid == 0
  CONDITION: total_points >= 12
  CONDITION: diamond_len >= 5

RULE B_1S_3C_3H_1824_0:
  CALL: 3H
  PRIORITY: 35
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1S'
  CONDITION: opp_last_call == '3C'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 12
  CONDITION: heart_len >= 5

RULE B_1S_3C_3S_1825_0:
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

RULE B_1S_3C_3NT_1826_0:
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

RULE B_1S_3C_4C_1827_0:
  CALL: 4C
  PRIORITY: 56
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1S'
  CONDITION: opp_last_call == '3C'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 13
  CONDITION: spade_len >= 2

RULE B_1S_3C_4C_1827_1:
  CALL: 4C
  PRIORITY: 56
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1S'
  CONDITION: opp_last_call == '3C'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 13
  CONDITION: spade_len >= 3

RULE B_1S_3C_4H_1828_0:
  CALL: 4H
  PRIORITY: 15
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1S'
  CONDITION: opp_last_call == '3C'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 10
  CONDITION: heart_len >= 7

RULE B_1S_3C_4S_1829_0:
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

RULE B_1S_3C_4S_1829_1:
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

RULE B_1S_3C_4S_1829_2:
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

RULE B_1S_3C_4S_1829_3:
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

RULE B_1S_3C_X_1838_0:
  CALL: X
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1S'
  CONDITION: opp_last_call == '3C'
  CONDITION: passes_since_last_bid == 0
  CONDITION: heart_len >= 4
  CONDITION: hcp >= 10

RULE B_1S_3D_PASS_1839_0:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1S'
  CONDITION: opp_last_call == '3D'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp <= 11

RULE B_1S_3D_3H_1840_0:
  CALL: 3H
  PRIORITY: 35
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1S'
  CONDITION: opp_last_call == '3D'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 12
  CONDITION: heart_len >= 5

RULE B_1S_3D_3S_1841_0:
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

RULE B_1S_3D_3NT_1842_0:
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

RULE B_1S_3D_4C_1843_0:
  CALL: 4C
  PRIORITY: 5
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1S'
  CONDITION: opp_last_call == '3D'
  CONDITION: passes_since_last_bid == 0
  CONDITION: club_len >= 6
  CONDITION: hcp >= 10

RULE B_1S_3D_4D_1844_0:
  CALL: 4D
  PRIORITY: 56
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1S'
  CONDITION: opp_last_call == '3D'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 13
  CONDITION: spade_len >= 2

RULE B_1S_3D_4D_1844_1:
  CALL: 4D
  PRIORITY: 56
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1S'
  CONDITION: opp_last_call == '3D'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 13
  CONDITION: spade_len >= 3

RULE B_1S_3D_4H_1845_0:
  CALL: 4H
  PRIORITY: 15
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1S'
  CONDITION: opp_last_call == '3D'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 10
  CONDITION: heart_len >= 7

RULE B_1S_3D_4S_1846_0:
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

RULE B_1S_3D_4S_1846_1:
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

RULE B_1S_3D_4S_1846_2:
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

RULE B_1S_3D_4S_1846_3:
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

RULE B_1S_3D_X_1855_0:
  CALL: X
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1S'
  CONDITION: opp_last_call == '3D'
  CONDITION: passes_since_last_bid == 0
  CONDITION: heart_len >= 4
  CONDITION: hcp >= 10

RULE B_1S_3H_PASS_1856_0:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1S'
  CONDITION: opp_last_call == '3H'
  CONDITION: passes_since_last_bid == 0

RULE B_1S_3H_4C_1860_0:
  CALL: 4C
  PRIORITY: 40
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1S'
  CONDITION: opp_last_call == '3H'
  CONDITION: passes_since_last_bid == 0
  CONDITION: club_len >= 6
  CONDITION: hcp >= 12

RULE B_1S_3H_4D_1862_0:
  CALL: 4D
  PRIORITY: 40
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1S'
  CONDITION: opp_last_call == '3H'
  CONDITION: passes_since_last_bid == 0
  CONDITION: diamond_len >= 6
  CONDITION: hcp >= 12

RULE B_1S_3H_4S_1864_1:
  CALL: 4S
  PRIORITY: 50
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1S'
  CONDITION: opp_last_call == '3H'
  CONDITION: passes_since_last_bid == 0
  CONDITION: spade_len >= 3
  CONDITION: spade_hcp >= 10

RULE B_1S_3H_5C_1866_0:
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

RULE B_1S_3H_5D_1867_0:
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

RULE B_1S_3H_X_1870_0:
  CALL: X
  PRIORITY: 5
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1S'
  CONDITION: opp_last_call == '3H'
  CONDITION: passes_since_last_bid == 0
  CONDITION: spade_len >= 2
  CONDITION: hcp >= 10

RULE B_1S_4C_PASS_1871_0:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1S'
  CONDITION: opp_last_call == '4C'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp <= 11

RULE B_1S_4C_4H_1872_0:
  CALL: 4H
  PRIORITY: 30
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1S'
  CONDITION: opp_last_call == '4C'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 12
  CONDITION: heart_len >= 6

RULE B_1S_4C_4S_1873_0:
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

RULE B_1S_4C_4S_1873_1:
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

RULE B_1S_4C_X_1883_0:
  CALL: X
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1S'
  CONDITION: opp_last_call == '4C'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 10

RULE B_1S_4D_PASS_1884_0:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1S'
  CONDITION: opp_last_call == '4D'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp <= 11

RULE B_1S_4D_4H_1885_0:
  CALL: 4H
  PRIORITY: 30
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1S'
  CONDITION: opp_last_call == '4D'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 12
  CONDITION: heart_len >= 6

RULE B_1S_4D_4S_1886_0:
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

RULE B_1S_4D_4S_1886_1:
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

RULE B_1S_4D_X_1896_0:
  CALL: X
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1S'
  CONDITION: opp_last_call == '4D'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 10

RULE B_1S_4H_PASS_1897_0:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1S'
  CONDITION: opp_last_call == '4H'
  CONDITION: passes_since_last_bid == 0

RULE B_1S_4H_4S_1899_0:
  CALL: 4S
  PRIORITY: 20
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1S'
  CONDITION: opp_last_call == '4H'
  CONDITION: passes_since_last_bid == 0
  CONDITION: spade_len >= 3
  CONDITION: spade_hcp >= 10

RULE B_1S_5C_PASS_1903_0:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1S'
  CONDITION: opp_last_call == '5C'
  CONDITION: passes_since_last_bid == 0

RULE B_1S_5D_PASS_1909_1:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1S'
  CONDITION: opp_last_call == '5D'
  CONDITION: passes_since_last_bid == 0

RULE B_1S_5D_5S_1911_0:
  CALL: 5S
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1S'
  CONDITION: opp_last_call == '5D'
  CONDITION: passes_since_last_bid == 0
  CONDITION: spade_len >= 3
  CONDITION: hcp >= 12

RULE B_1S_5D_X_1913_0:
  CALL: X
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1S'
  CONDITION: opp_last_call == '5D'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 13

RULE B_1S_6C_PASS_1914_0:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1S'
  CONDITION: opp_last_call == '6C'
  CONDITION: passes_since_last_bid == 0

RULE B_1S_6D_PASS_1915_0:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1S'
  CONDITION: opp_last_call == '6D'
  CONDITION: passes_since_last_bid == 0

RULE B_1S_6H_PASS_1916_0:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1S'
  CONDITION: opp_last_call == '6H'
  CONDITION: passes_since_last_bid == 0

RULE B_1S_1N_PASS_1917_0:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1S'
  CONDITION: opp_last_call == '1NT'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp <= 8

RULE B_1S_1N_2C_1918_0:
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

RULE B_1S_1N_2D_1919_0:
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

RULE B_1S_1N_2H_1920_0:
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

RULE B_1S_1N_2S_1921_0:
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

RULE B_1S_1N_3S_1923_0:
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

RULE B_1S_1N_3S_1923_1:
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

RULE B_1S_1N_4H_1924_0:
  CALL: 4H
  PRIORITY: 63
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1S'
  CONDITION: opp_last_call == '1NT'
  CONDITION: passes_since_last_bid == 0
  CONDITION: heart_hcp >= 11
  CONDITION: spade_len >= 7

RULE B_1S_1N_4S_1925_0:
  CALL: 4S
  PRIORITY: 65
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1S'
  CONDITION: opp_last_call == '1NT'
  CONDITION: passes_since_last_bid == 0
  CONDITION: spade_hcp >= 11
  CONDITION: spade_len >= 4

RULE B_1S_2N_PASS_1927_0:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1S'
  CONDITION: opp_last_call == '2NT'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp <= 8

RULE B_1S_2N_3C_1928_0:
  CALL: 3C
  PRIORITY: 60
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1S'
  CONDITION: opp_last_call == '2NT'
  CONDITION: passes_since_last_bid == 0
  CONDITION: spade_len >= 3
  CONDITION: hcp >= 10

RULE B_1S_2N_3D_1929_0:
  CALL: 3D
  PRIORITY: 50
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1S'
  CONDITION: opp_last_call == '2NT'
  CONDITION: passes_since_last_bid == 0
  CONDITION: heart_len >= 5
  CONDITION: hcp >= 10

RULE B_1S_2N_3H_1930_0:
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

RULE B_1S_2N_3S_1931_0:
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

RULE B_1S_2N_3NT_1932_0:
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

RULE B_1S_2N_4H_1933_0:
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

RULE B_1S_2N_4S_1934_0:
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

RULE B_1S_2N_X_1943_0:
  CALL: X
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1S'
  CONDITION: opp_last_call == '2NT'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 9

RULE B_2C_P_2D_1944_0:
  CALL: 2D
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '2C'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 1

RULE B_2C_P_2NT_1947_0:
  CALL: 2NT
  PRIORITY: 20
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '2C'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 1
  CONDITION: hcp >= 8
  CONDITION: is_balanced == True

RULE B_2C_P_2NT_1947_1:
  CALL: 2NT
  PRIORITY: 20
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '2C'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 1
  CONDITION: hcp >= 8
  CONDITION: is_semi_balanced == True

RULE B_2C_2D_PASS_1952_0:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '2C'
  CONDITION: opp_last_call == '2D'
  CONDITION: passes_since_last_bid == 0

RULE B_2C_2D_2NT_1955_0:
  CALL: 2NT
  PRIORITY: 20
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '2C'
  CONDITION: opp_last_call == '2D'
  CONDITION: passes_since_last_bid == 0
  CONDITION: d_stopper >= 2
  CONDITION: hcp >= 8

RULE B_2C_2D_3C_1956_0:
  CALL: 3C
  PRIORITY: 21
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '2C'
  CONDITION: opp_last_call == '2D'
  CONDITION: passes_since_last_bid == 0
  CONDITION: club_len >= 6
  CONDITION: hcp >= 8

RULE B_2C_2D_3D_1957_0:
  CALL: 3D
  PRIORITY: 22
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '2C'
  CONDITION: opp_last_call == '2D'
  CONDITION: passes_since_last_bid == 0
  CONDITION: diamond_len <= 1
  CONDITION: hcp >= 6

RULE B_2C_2H_PASS_1959_0:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '2C'
  CONDITION: opp_last_call == '2H'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp <= 7

RULE B_2C_2H_2S_1960_0:
  CALL: 2S
  PRIORITY: 20
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '2C'
  CONDITION: opp_last_call == '2H'
  CONDITION: passes_since_last_bid == 0
  CONDITION: spade_len >= 5
  CONDITION: hcp >= 8

RULE B_2C_2H_2NT_1961_0:
  CALL: 2NT
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '2C'
  CONDITION: opp_last_call == '2H'
  CONDITION: passes_since_last_bid == 0
  CONDITION: h_stopper >= 2
  CONDITION: hcp >= 8

RULE B_2C_2H_X_1965_0:
  CALL: X
  PRIORITY: 30
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '2C'
  CONDITION: opp_last_call == '2H'
  CONDITION: passes_since_last_bid == 0
  CONDITION: heart_len >= 5

RULE B_2C_2S_PASS_1966_0:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '2C'
  CONDITION: opp_last_call == '2S'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp <= 7

RULE B_2C_2S_2NT_1967_0:
  CALL: 2NT
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '2C'
  CONDITION: opp_last_call == '2S'
  CONDITION: passes_since_last_bid == 0
  CONDITION: s_stopper >= 2
  CONDITION: hcp >= 8

RULE B_2C_2S_3H_1970_0:
  CALL: 3H
  PRIORITY: 70
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '2C'
  CONDITION: opp_last_call == '2S'
  CONDITION: passes_since_last_bid == 0
  CONDITION: heart_len >= 5
  CONDITION: hcp >= 8

RULE B_2C_2S_X_1972_0:
  CALL: X
  PRIORITY: 30
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '2C'
  CONDITION: opp_last_call == '2S'
  CONDITION: passes_since_last_bid == 0
  CONDITION: spade_len >= 5

RULE B_2C_3C_PASS_1973_0:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '2C'
  CONDITION: opp_last_call == '3C'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp <= 7

RULE B_2C_3C_X_1976_0:
  CALL: X
  PRIORITY: 30
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '2C'
  CONDITION: opp_last_call == '3C'
  CONDITION: passes_since_last_bid == 0
  CONDITION: club_len >= 5

RULE B_2C_3H_PASS_1977_0:
  CALL: PASS
  PRIORITY: 90
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '2C'
  CONDITION: opp_last_call == '3H'
  CONDITION: passes_since_last_bid == 0

RULE B_2C_3S_PASS_1982_0:
  CALL: PASS
  PRIORITY: 90
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '2C'
  CONDITION: opp_last_call == '3S'
  CONDITION: passes_since_last_bid == 0

RULE B_2C_4D_PASS_1987_0:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '2C'
  CONDITION: opp_last_call == '4D'
  CONDITION: passes_since_last_bid == 0

RULE B_2C_4H_PASS_1988_0:
  CALL: PASS
  PRIORITY: 20
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '2C'
  CONDITION: opp_last_call == '4H'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 8

RULE B_2C_4H_X_1989_0:
  CALL: X
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '2C'
  CONDITION: opp_last_call == '4H'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp <= 7

RULE B_2C_4S_PASS_1990_0:
  CALL: PASS
  PRIORITY: 20
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '2C'
  CONDITION: opp_last_call == '4S'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 8

RULE B_2C_4S_X_1991_0:
  CALL: X
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '2C'
  CONDITION: opp_last_call == '4S'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp <= 7

RULE B_2C_5D_PASS_1992_0:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '2C'
  CONDITION: opp_last_call == '5D'
  CONDITION: passes_since_last_bid == 0

RULE B_2D_P_PASS_1993_0:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '2D'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 1

RULE B_2D_P_2H_1994_0:
  CALL: 2H
  PRIORITY: 76
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '2D'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 1
  CONDITION: hcp >= 14
  CONDITION: heart_len >= 5

RULE B_2D_P_2S_1995_0:
  CALL: 2S
  PRIORITY: 76
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '2D'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 1
  CONDITION: hcp >= 14
  CONDITION: spade_len >= 5

RULE B_2D_P_2NT_1996_0:
  CALL: 2NT
  PRIORITY: 70
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '2D'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 1
  CONDITION: hcp >= 15

RULE B_2D_P_3D_1998_0:
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

RULE B_2D_P_3D_1998_1:
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

RULE B_2D_P_3NT_2001_0:
  CALL: 3NT
  PRIORITY: 30
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '2D'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 1
  CONDITION: hcp >= 18
  CONDITION: hcp <= 21

RULE B_2D_P_4D_2002_0:
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

RULE B_2D_P_5D_2012_0:
  CALL: 5D
  PRIORITY: 70
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '2D'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 1
  CONDITION: diamond_hcp >= 7
  CONDITION: diamond_len >= 6

RULE B_2D_P_5D_2012_1:
  CALL: 5D
  PRIORITY: 70
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '2D'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 1
  CONDITION: diamond_len >= 3
  CONDITION: diamond_hcp >= 15

RULE B_2D_P_5D_2012_3:
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

RULE B_2D_X_PASS_2021_0:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '2D'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 0

RULE B_2D_X_2H_2022_0:
  CALL: 2H
  PRIORITY: 76
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '2D'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 14
  CONDITION: heart_len >= 5

RULE B_2D_X_2S_2023_0:
  CALL: 2S
  PRIORITY: 76
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '2D'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 14
  CONDITION: spade_len >= 5

RULE B_2D_X_2NT_2024_0:
  CALL: 2NT
  PRIORITY: 70
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '2D'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 15

RULE B_2D_X_3D_2026_0:
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

RULE B_2D_X_3D_2026_1:
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

RULE B_2D_X_3NT_2029_0:
  CALL: 3NT
  PRIORITY: 30
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '2D'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 18
  CONDITION: hcp <= 21

RULE B_2D_X_4D_2031_0:
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

RULE B_2D_X_5D_2041_0:
  CALL: 5D
  PRIORITY: 70
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '2D'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 0
  CONDITION: diamond_hcp >= 7
  CONDITION: diamond_len >= 6

RULE B_2D_X_5D_2041_1:
  CALL: 5D
  PRIORITY: 70
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '2D'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 0
  CONDITION: diamond_len >= 3
  CONDITION: diamond_hcp >= 15

RULE B_2D_X_5D_2041_5:
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

RULE B_2D_2H_PASS_2050_0:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '2D'
  CONDITION: opp_last_call == '2H'
  CONDITION: passes_since_last_bid == 0

RULE B_2D_2H_2NT_2053_0:
  CALL: 2NT
  PRIORITY: 41
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '2D'
  CONDITION: opp_last_call == '2H'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 15
  CONDITION: h_stopper >= 2

RULE B_2D_2H_3D_2055_1:
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

RULE B_2D_2H_3H_2056_0:
  CALL: 3H
  PRIORITY: 22
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '2D'
  CONDITION: opp_last_call == '2H'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 17
  CONDITION: diamond_len >= 2

RULE B_2D_2H_3S_2057_0:
  CALL: 3S
  PRIORITY: 20
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '2D'
  CONDITION: opp_last_call == '2H'
  CONDITION: passes_since_last_bid == 0
  CONDITION: total_points >= 20
  CONDITION: spade_len >= 5

RULE B_2D_2H_3NT_2058_0:
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

RULE B_2D_2H_4D_2059_0:
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

RULE B_2D_2H_5D_2065_0:
  CALL: 5D
  PRIORITY: 70
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '2D'
  CONDITION: opp_last_call == '2H'
  CONDITION: passes_since_last_bid == 0
  CONDITION: diamond_len >= 4
  CONDITION: hcp >= 12

RULE B_2D_2S_PASS_2074_0:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '2D'
  CONDITION: opp_last_call == '2S'
  CONDITION: passes_since_last_bid == 0

RULE B_2D_2S_2NT_2075_0:
  CALL: 2NT
  PRIORITY: 41
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '2D'
  CONDITION: opp_last_call == '2S'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 15
  CONDITION: s_stopper >= 2

RULE B_2D_2S_3D_2077_1:
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

RULE B_2D_2S_3H_2078_0:
  CALL: 3H
  PRIORITY: 20
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '2D'
  CONDITION: opp_last_call == '2S'
  CONDITION: passes_since_last_bid == 0
  CONDITION: total_points >= 20
  CONDITION: heart_len >= 5

RULE B_2D_2S_3S_2079_0:
  CALL: 3S
  PRIORITY: 22
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '2D'
  CONDITION: opp_last_call == '2S'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 17
  CONDITION: diamond_len >= 2

RULE B_2D_2S_3NT_2080_0:
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

RULE B_2D_2S_4D_2081_0:
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

RULE B_2D_2S_5D_2087_0:
  CALL: 5D
  PRIORITY: 70
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '2D'
  CONDITION: opp_last_call == '2S'
  CONDITION: passes_since_last_bid == 0
  CONDITION: diamond_len >= 4
  CONDITION: hcp >= 12

RULE B_2D_3C_PASS_2096_0:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '2D'
  CONDITION: opp_last_call == '3C'
  CONDITION: passes_since_last_bid == 0

RULE B_2D_3C_3D_2098_0:
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

RULE B_2D_3C_3NT_2103_0:
  CALL: 3NT
  PRIORITY: 30
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '2D'
  CONDITION: opp_last_call == '3C'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 18
  CONDITION: hcp <= 21

RULE B_2D_3C_4D_2104_0:
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

RULE B_2D_3C_5D_2113_2:
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

RULE B_2D_3D_3NT_2124_0:
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

RULE B_2D_3D_4D_2125_0:
  CALL: 4D
  PRIORITY: 30
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '2D'
  CONDITION: opp_last_call == '3D'
  CONDITION: passes_since_last_bid == 0
  CONDITION: diamond_len >= 3
  CONDITION: hcp <= 10

RULE B_2D_3D_5D_2128_0:
  CALL: 5D
  PRIORITY: 40
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '2D'
  CONDITION: opp_last_call == '3D'
  CONDITION: passes_since_last_bid == 0
  CONDITION: diamond_len >= 2
  CONDITION: hcp >= 18

RULE B_2D_3D_5D_2128_1:
  CALL: 5D
  PRIORITY: 40
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '2D'
  CONDITION: opp_last_call == '3D'
  CONDITION: passes_since_last_bid == 0
  CONDITION: diamond_len >= 4
  CONDITION: hcp >= 10

RULE B_2D_3H_PASS_2143_0:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '2D'
  CONDITION: opp_last_call == '3H'
  CONDITION: passes_since_last_bid == 0

RULE B_2D_3H_3NT_2144_0:
  CALL: 3NT
  PRIORITY: 30
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '2D'
  CONDITION: opp_last_call == '3H'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 18
  CONDITION: hcp <= 21

RULE B_2D_3H_4D_2145_0:
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

RULE B_2D_3H_5D_2148_2:
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

RULE B_2D_3S_PASS_2157_0:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '2D'
  CONDITION: opp_last_call == '3S'
  CONDITION: passes_since_last_bid == 0

RULE B_2D_3S_3NT_2158_0:
  CALL: 3NT
  PRIORITY: 30
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '2D'
  CONDITION: opp_last_call == '3S'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 18
  CONDITION: hcp <= 21

RULE B_2D_3S_4D_2159_0:
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

RULE B_2D_3S_5D_2162_2:
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

RULE B_2D_4C_PASS_2171_0:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '2D'
  CONDITION: opp_last_call == '4C'
  CONDITION: passes_since_last_bid == 0

RULE B_2D_4C_4D_2173_0:
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

RULE B_2D_4C_5D_2177_2:
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

RULE B_2D_4H_PASS_2186_0:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '2D'
  CONDITION: opp_last_call == '4H'
  CONDITION: passes_since_last_bid == 0

RULE B_2D_4H_5D_2194_2:
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

RULE B_2D_4S_PASS_2205_0:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '2D'
  CONDITION: opp_last_call == '4S'
  CONDITION: passes_since_last_bid == 0

RULE B_2D_4S_5D_2208_2:
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

RULE B_2D_6C_PASS_2219_0:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '2D'
  CONDITION: opp_last_call == '6C'
  CONDITION: passes_since_last_bid == 0

RULE B_2D_6H_PASS_2220_0:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '2D'
  CONDITION: opp_last_call == '6H'
  CONDITION: passes_since_last_bid == 0

RULE B_2D_6S_PASS_2221_0:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '2D'
  CONDITION: opp_last_call == '6S'
  CONDITION: passes_since_last_bid == 0

RULE B_2D_2N_PASS_2222_0:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '2D'
  CONDITION: opp_last_call == '2NT'
  CONDITION: passes_since_last_bid == 0

RULE B_2D_2N_3D_2225_0:
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

RULE B_2D_2N_3NT_2232_0:
  CALL: 3NT
  PRIORITY: 30
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '2D'
  CONDITION: opp_last_call == '2NT'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 18
  CONDITION: hcp <= 21

RULE B_2D_2N_4D_2233_0:
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

RULE B_2D_2N_5D_2239_0:
  CALL: 5D
  PRIORITY: 70
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '2D'
  CONDITION: opp_last_call == '2NT'
  CONDITION: passes_since_last_bid == 0
  CONDITION: diamond_hcp >= 7
  CONDITION: diamond_len >= 6

RULE B_2D_2N_5D_2239_3:
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

RULE B_2D_3N_PASS_2249_0:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '2D'
  CONDITION: opp_last_call == '3NT'
  CONDITION: passes_since_last_bid == 0

RULE B_2D_3N_4D_2251_0:
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

RULE B_2D_3N_5D_2255_2:
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

RULE B_2H_P_2NT_2267_0:
  CALL: 2NT
  PRIORITY: 60
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '2H'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 1
  CONDITION: hcp >= 15

RULE B_2H_P_3H_2270_0:
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

RULE B_2H_X_2NT_2286_0:
  CALL: 2NT
  PRIORITY: 60
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '2H'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 15

RULE B_2H_X_3H_2289_0:
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

RULE B_2H_2S_PASS_2303_0:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '2H'
  CONDITION: opp_last_call == '2S'
  CONDITION: passes_since_last_bid == 0

RULE B_2H_2S_2NT_2304_0:
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

RULE B_2H_2S_3H_2309_1:
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

RULE B_2H_2S_3H_2309_2:
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

RULE B_2H_2S_4H_2311_0:
  CALL: 4H
  PRIORITY: 43
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '2H'
  CONDITION: opp_last_call == '2S'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 12
  CONDITION: heart_len >= 3

RULE B_2H_3C_PASS_2324_0:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '2H'
  CONDITION: opp_last_call == '3C'
  CONDITION: passes_since_last_bid == 0

RULE B_2H_3C_3H_2327_0:
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

RULE B_2H_3C_3S_2328_0:
  CALL: 3S
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '2H'
  CONDITION: opp_last_call == '3C'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 15
  CONDITION: spade_len >= 5

RULE B_2H_3C_4H_2331_0:
  CALL: 4H
  PRIORITY: 30
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '2H'
  CONDITION: opp_last_call == '3C'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 14
  CONDITION: heart_len >= 2

RULE B_2H_3C_4H_2331_1:
  CALL: 4H
  PRIORITY: 30
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '2H'
  CONDITION: opp_last_call == '3C'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 12
  CONDITION: heart_len >= 3

RULE B_2H_3D_PASS_2345_0:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '2H'
  CONDITION: opp_last_call == '3D'
  CONDITION: passes_since_last_bid == 0

RULE B_2H_3D_3H_2347_0:
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

RULE B_2H_3D_3S_2348_0:
  CALL: 3S
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '2H'
  CONDITION: opp_last_call == '3D'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 15
  CONDITION: spade_len >= 5

RULE B_2H_3D_4H_2351_0:
  CALL: 4H
  PRIORITY: 30
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '2H'
  CONDITION: opp_last_call == '3D'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 14
  CONDITION: heart_len >= 2

RULE B_2H_3D_4H_2351_1:
  CALL: 4H
  PRIORITY: 30
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '2H'
  CONDITION: opp_last_call == '3D'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 12
  CONDITION: heart_len >= 3

RULE B_2H_3H_4H_2365_0:
  CALL: 4H
  PRIORITY: 70
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '2H'
  CONDITION: opp_last_call == '3H'
  CONDITION: passes_since_last_bid == 0
  CONDITION: heart_len >= 3
  CONDITION: hcp >= 14

RULE B_2H_3S_PASS_2374_0:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '2H'
  CONDITION: opp_last_call == '3S'
  CONDITION: passes_since_last_bid == 0

RULE B_2H_3S_4H_2377_0:
  CALL: 4H
  PRIORITY: 70
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '2H'
  CONDITION: opp_last_call == '3S'
  CONDITION: passes_since_last_bid == 0
  CONDITION: heart_len >= 4
  CONDITION: hcp >= 6

RULE B_2H_4C_PASS_2379_0:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '2H'
  CONDITION: opp_last_call == '4C'
  CONDITION: passes_since_last_bid == 0

RULE B_2H_4C_4H_2380_0:
  CALL: 4H
  PRIORITY: 70
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '2H'
  CONDITION: opp_last_call == '4C'
  CONDITION: passes_since_last_bid == 0
  CONDITION: heart_len >= 4
  CONDITION: hcp >= 6

RULE B_2H_4D_PASS_2381_0:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '2H'
  CONDITION: opp_last_call == '4D'
  CONDITION: passes_since_last_bid == 0

RULE B_2H_4D_4H_2382_0:
  CALL: 4H
  PRIORITY: 70
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '2H'
  CONDITION: opp_last_call == '4D'
  CONDITION: passes_since_last_bid == 0
  CONDITION: heart_len >= 4
  CONDITION: hcp >= 6

RULE B_2H_4H_PASS_2383_0:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '2H'
  CONDITION: opp_last_call == '4H'
  CONDITION: passes_since_last_bid == 0

RULE B_2H_6C_PASS_2397_0:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '2H'
  CONDITION: opp_last_call == '6C'
  CONDITION: passes_since_last_bid == 0

RULE B_2H_6D_PASS_2398_0:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '2H'
  CONDITION: opp_last_call == '6D'
  CONDITION: passes_since_last_bid == 0

RULE B_2H_6S_PASS_2399_0:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '2H'
  CONDITION: opp_last_call == '6S'
  CONDITION: passes_since_last_bid == 0

RULE B_2H_7C_PASS_2400_0:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '2H'
  CONDITION: opp_last_call == '7C'
  CONDITION: passes_since_last_bid == 0

RULE B_2H_7D_PASS_2401_0:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '2H'
  CONDITION: opp_last_call == '7D'
  CONDITION: passes_since_last_bid == 0

RULE B_2H_2N_PASS_2402_0:
  CALL: PASS
  PRIORITY: 20
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '2H'
  CONDITION: opp_last_call == '2NT'
  CONDITION: passes_since_last_bid == 0

RULE B_2H_3N_PASS_2413_0:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '2H'
  CONDITION: opp_last_call == '3NT'
  CONDITION: passes_since_last_bid == 0

RULE B_2H_4N_PASS_2419_0:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '2H'
  CONDITION: opp_last_call == '4NT'
  CONDITION: passes_since_last_bid == 0

RULE B_2S_P_2NT_2423_0:
  CALL: 2NT
  PRIORITY: 60
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '2S'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 1
  CONDITION: hcp >= 15

RULE B_2S_P_3H_2426_0:
  CALL: 3H
  PRIORITY: 69
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '2S'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 1
  CONDITION: hcp >= 17
  CONDITION: heart_len >= 6

RULE B_2S_P_3S_2427_0:
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

RULE B_2S_X_2NT_2441_0:
  CALL: 2NT
  PRIORITY: 60
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '2S'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 15

RULE B_2S_X_3H_2444_0:
  CALL: 3H
  PRIORITY: 69
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '2S'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 17
  CONDITION: heart_len >= 6

RULE B_2S_X_3S_2445_0:
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

RULE B_2S_3C_PASS_2458_0:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '2S'
  CONDITION: opp_last_call == '3C'
  CONDITION: passes_since_last_bid == 0

RULE B_2S_3C_3H_2460_0:
  CALL: 3H
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '2S'
  CONDITION: opp_last_call == '3C'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 15
  CONDITION: heart_len >= 5

RULE B_2S_3C_3S_2462_0:
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

RULE B_2S_3C_4S_2466_0:
  CALL: 4S
  PRIORITY: 30
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '2S'
  CONDITION: opp_last_call == '3C'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 14
  CONDITION: spade_len >= 2

RULE B_2S_3C_4S_2466_1:
  CALL: 4S
  PRIORITY: 30
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '2S'
  CONDITION: opp_last_call == '3C'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 12
  CONDITION: spade_len >= 3

RULE B_2S_3D_PASS_2479_0:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '2S'
  CONDITION: opp_last_call == '3D'
  CONDITION: passes_since_last_bid == 0

RULE B_2S_3D_3H_2480_0:
  CALL: 3H
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '2S'
  CONDITION: opp_last_call == '3D'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 15
  CONDITION: heart_len >= 5

RULE B_2S_3D_3S_2482_0:
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

RULE B_2S_3D_4S_2486_0:
  CALL: 4S
  PRIORITY: 30
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '2S'
  CONDITION: opp_last_call == '3D'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 14
  CONDITION: spade_len >= 2

RULE B_2S_3D_4S_2486_1:
  CALL: 4S
  PRIORITY: 30
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '2S'
  CONDITION: opp_last_call == '3D'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 12
  CONDITION: spade_len >= 3

RULE B_2S_3H_PASS_2497_0:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '2S'
  CONDITION: opp_last_call == '3H'
  CONDITION: passes_since_last_bid == 0

RULE B_2S_3H_3S_2499_0:
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

RULE B_2S_3H_3S_2499_1:
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

RULE B_2S_3H_4H_2505_0:
  CALL: 4H
  PRIORITY: 43
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '2S'
  CONDITION: opp_last_call == '3H'
  CONDITION: passes_since_last_bid == 0
  CONDITION: spade_len >= 2
  CONDITION: hcp >= 18

RULE B_2S_3H_4S_2507_1:
  CALL: 4S
  PRIORITY: 30
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '2S'
  CONDITION: opp_last_call == '3H'
  CONDITION: passes_since_last_bid == 0
  CONDITION: spade_len >= 2
  CONDITION: hcp >= 13

RULE B_2S_3S_4S_2520_0:
  CALL: 4S
  PRIORITY: 70
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '2S'
  CONDITION: opp_last_call == '3S'
  CONDITION: passes_since_last_bid == 0
  CONDITION: spade_len >= 3
  CONDITION: hcp >= 14

RULE B_2S_4C_PASS_2529_0:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '2S'
  CONDITION: opp_last_call == '4C'
  CONDITION: passes_since_last_bid == 0

RULE B_2S_4C_4S_2530_0:
  CALL: 4S
  PRIORITY: 70
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '2S'
  CONDITION: opp_last_call == '4C'
  CONDITION: passes_since_last_bid == 0
  CONDITION: spade_len >= 4
  CONDITION: hcp >= 6

RULE B_2S_4D_PASS_2531_0:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '2S'
  CONDITION: opp_last_call == '4D'
  CONDITION: passes_since_last_bid == 0

RULE B_2S_4D_4S_2532_0:
  CALL: 4S
  PRIORITY: 70
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '2S'
  CONDITION: opp_last_call == '4D'
  CONDITION: passes_since_last_bid == 0
  CONDITION: spade_len >= 4
  CONDITION: hcp >= 6

RULE B_2S_4H_PASS_2533_0:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '2S'
  CONDITION: opp_last_call == '4H'
  CONDITION: passes_since_last_bid == 0

RULE B_2S_4H_4S_2535_1:
  CALL: 4S
  PRIORITY: 30
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '2S'
  CONDITION: opp_last_call == '4H'
  CONDITION: passes_since_last_bid == 0
  CONDITION: spade_len >= 2
  CONDITION: hcp >= 13

RULE B_2S_4S_PASS_2548_0:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '2S'
  CONDITION: opp_last_call == '4S'
  CONDITION: passes_since_last_bid == 0

RULE B_2S_6C_PASS_2549_0:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '2S'
  CONDITION: opp_last_call == '6C'
  CONDITION: passes_since_last_bid == 0

RULE B_2S_6D_PASS_2550_0:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '2S'
  CONDITION: opp_last_call == '6D'
  CONDITION: passes_since_last_bid == 0

RULE B_2S_6H_PASS_2551_0:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '2S'
  CONDITION: opp_last_call == '6H'
  CONDITION: passes_since_last_bid == 0

RULE B_2S_7C_PASS_2552_0:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '2S'
  CONDITION: opp_last_call == '7C'
  CONDITION: passes_since_last_bid == 0

RULE B_2S_7D_PASS_2553_0:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '2S'
  CONDITION: opp_last_call == '7D'
  CONDITION: passes_since_last_bid == 0

RULE B_2S_2N_PASS_2554_0:
  CALL: PASS
  PRIORITY: 20
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '2S'
  CONDITION: opp_last_call == '2NT'
  CONDITION: passes_since_last_bid == 0

RULE B_2S_3N_PASS_2565_0:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '2S'
  CONDITION: opp_last_call == '3NT'
  CONDITION: passes_since_last_bid == 0

RULE B_2S_4N_PASS_2571_0:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '2S'
  CONDITION: opp_last_call == '4NT'
  CONDITION: passes_since_last_bid == 0

RULE B_3C_P_PASS_2574_0:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '3C'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 1

RULE B_3C_P_4C_2582_0:
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

RULE B_3C_P_5C_2591_0:
  CALL: 5C
  PRIORITY: 70
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '3C'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 1
  CONDITION: hcp >= 18
  CONDITION: club_len >= 1

RULE B_3C_X_PASS_2600_0:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '3C'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 0

RULE B_3C_X_4C_2608_0:
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

RULE B_3C_X_5C_2617_0:
  CALL: 5C
  PRIORITY: 70
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '3C'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 18
  CONDITION: club_len >= 1

RULE B_3C_3D_PASS_2627_0:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '3C'
  CONDITION: opp_last_call == '3D'
  CONDITION: passes_since_last_bid == 0
  CONDITION: club_len <= 3

RULE B_3C_3D_PASS_2627_1:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '3C'
  CONDITION: opp_last_call == '3D'
  CONDITION: passes_since_last_bid == 0
  CONDITION: club_hcp <= 5

RULE B_3C_3H_PASS_2638_0:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '3C'
  CONDITION: opp_last_call == '3H'
  CONDITION: passes_since_last_bid == 0

RULE B_3C_3H_3NT_2640_0:
  CALL: 3NT
  PRIORITY: 30
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '3C'
  CONDITION: opp_last_call == '3H'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 15
  CONDITION: h_stopper >= 2

RULE B_3C_3H_5C_2644_0:
  CALL: 5C
  PRIORITY: 70
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '3C'
  CONDITION: opp_last_call == '3H'
  CONDITION: passes_since_last_bid == 0
  CONDITION: club_len >= 4
  CONDITION: hcp <= 10

RULE B_3C_3S_3NT_2655_0:
  CALL: 3NT
  PRIORITY: 30
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '3C'
  CONDITION: opp_last_call == '3S'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 15
  CONDITION: s_stopper >= 2

RULE B_3C_3S_5C_2659_0:
  CALL: 5C
  PRIORITY: 70
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '3C'
  CONDITION: opp_last_call == '3S'
  CONDITION: passes_since_last_bid == 0
  CONDITION: club_len >= 4
  CONDITION: hcp <= 10

RULE B_3C_4C_PASS_2669_0:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '3C'
  CONDITION: opp_last_call == '4C'
  CONDITION: passes_since_last_bid == 0
  CONDITION: club_len <= 3

RULE B_3C_4C_PASS_2669_1:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '3C'
  CONDITION: opp_last_call == '4C'
  CONDITION: passes_since_last_bid == 0
  CONDITION: club_hcp <= 9

RULE B_3C_4C_5C_2672_0:
  CALL: 5C
  PRIORITY: 70
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '3C'
  CONDITION: opp_last_call == '4C'
  CONDITION: passes_since_last_bid == 0
  CONDITION: club_len >= 4
  CONDITION: club_hcp >= 10

RULE B_3C_4H_PASS_2673_0:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '3C'
  CONDITION: opp_last_call == '4H'
  CONDITION: passes_since_last_bid == 0

RULE B_3C_4S_PASS_2681_0:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '3C'
  CONDITION: opp_last_call == '4S'
  CONDITION: passes_since_last_bid == 0

RULE B_3C_6H_PASS_2687_0:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '3C'
  CONDITION: opp_last_call == '6H'
  CONDITION: passes_since_last_bid == 0

RULE B_3C_6S_PASS_2688_0:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '3C'
  CONDITION: opp_last_call == '6S'
  CONDITION: passes_since_last_bid == 0

RULE B_3C_3N_PASS_2689_0:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '3C'
  CONDITION: opp_last_call == '3NT'
  CONDITION: passes_since_last_bid == 0

RULE B_3D_P_PASS_2696_0:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '3D'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 1

RULE B_3D_P_4D_2704_0:
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

RULE B_3D_P_5D_2713_0:
  CALL: 5D
  PRIORITY: 70
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '3D'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 1
  CONDITION: hcp >= 18
  CONDITION: diamond_len >= 1

RULE B_3D_X_PASS_2721_0:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '3D'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 0

RULE B_3D_X_4D_2730_0:
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

RULE B_3D_X_5D_2739_0:
  CALL: 5D
  PRIORITY: 70
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '3D'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 18
  CONDITION: diamond_len >= 1

RULE B_3D_3H_PASS_2747_0:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '3D'
  CONDITION: opp_last_call == '3H'
  CONDITION: passes_since_last_bid == 0

RULE B_3D_3H_3NT_2750_0:
  CALL: 3NT
  PRIORITY: 30
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '3D'
  CONDITION: opp_last_call == '3H'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 15
  CONDITION: h_stopper >= 2

RULE B_3D_3H_4C_2751_0:
  CALL: 4C
  PRIORITY: 20
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '3D'
  CONDITION: opp_last_call == '3H'
  CONDITION: passes_since_last_bid == 0
  CONDITION: club_len >= 7
  CONDITION: hcp <= 10

RULE B_3D_3H_4D_2752_0:
  CALL: 4D
  PRIORITY: 20
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '3D'
  CONDITION: opp_last_call == '3H'
  CONDITION: passes_since_last_bid == 0
  CONDITION: diamond_len >= 3
  CONDITION: hcp <= 10

RULE B_3D_3H_5D_2756_0:
  CALL: 5D
  PRIORITY: 70
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '3D'
  CONDITION: opp_last_call == '3H'
  CONDITION: passes_since_last_bid == 0
  CONDITION: diamond_len >= 4
  CONDITION: hcp <= 10

RULE B_3D_3S_PASS_2770_0:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '3D'
  CONDITION: opp_last_call == '3S'
  CONDITION: passes_since_last_bid == 0

RULE B_3D_3S_3NT_2772_0:
  CALL: 3NT
  PRIORITY: 30
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '3D'
  CONDITION: opp_last_call == '3S'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 15
  CONDITION: s_stopper >= 2

RULE B_3D_3S_4C_2773_0:
  CALL: 4C
  PRIORITY: 20
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '3D'
  CONDITION: opp_last_call == '3S'
  CONDITION: passes_since_last_bid == 0
  CONDITION: club_len >= 7
  CONDITION: hcp <= 10

RULE B_3D_3S_4D_2774_0:
  CALL: 4D
  PRIORITY: 20
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '3D'
  CONDITION: opp_last_call == '3S'
  CONDITION: passes_since_last_bid == 0
  CONDITION: diamond_len >= 3
  CONDITION: hcp <= 10

RULE B_3D_3S_5D_2778_0:
  CALL: 5D
  PRIORITY: 70
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '3D'
  CONDITION: opp_last_call == '3S'
  CONDITION: passes_since_last_bid == 0
  CONDITION: diamond_len >= 4
  CONDITION: hcp <= 10

RULE B_3D_4C_PASS_2792_0:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '3D'
  CONDITION: opp_last_call == '4C'
  CONDITION: passes_since_last_bid == 0

RULE B_3D_4C_4D_2794_0:
  CALL: 4D
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '3D'
  CONDITION: opp_last_call == '4C'
  CONDITION: passes_since_last_bid == 0
  CONDITION: diamond_len >= 3
  CONDITION: hcp <= 10

RULE B_3D_4C_5D_2801_0:
  CALL: 5D
  PRIORITY: 70
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '3D'
  CONDITION: opp_last_call == '4C'
  CONDITION: passes_since_last_bid == 0
  CONDITION: diamond_len >= 4
  CONDITION: hcp <= 10

RULE B_3D_4D_PASS_2810_0:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '3D'
  CONDITION: opp_last_call == '4D'
  CONDITION: passes_since_last_bid == 0
  CONDITION: diamond_len <= 3

RULE B_3D_4D_PASS_2810_1:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '3D'
  CONDITION: opp_last_call == '4D'
  CONDITION: passes_since_last_bid == 0
  CONDITION: diamond_hcp <= 9

RULE B_3D_4D_5D_2813_0:
  CALL: 5D
  PRIORITY: 70
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '3D'
  CONDITION: opp_last_call == '4D'
  CONDITION: passes_since_last_bid == 0
  CONDITION: diamond_len >= 4
  CONDITION: diamond_hcp >= 10

RULE B_3D_4H_PASS_2814_0:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '3D'
  CONDITION: opp_last_call == '4H'
  CONDITION: passes_since_last_bid == 0

RULE B_3D_4S_PASS_2824_0:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '3D'
  CONDITION: opp_last_call == '4S'
  CONDITION: passes_since_last_bid == 0

RULE B_3D_5C_PASS_2830_0:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '3D'
  CONDITION: opp_last_call == '5C'
  CONDITION: passes_since_last_bid == 0

RULE B_3D_6H_PASS_2833_0:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '3D'
  CONDITION: opp_last_call == '6H'
  CONDITION: passes_since_last_bid == 0

RULE B_3D_6S_PASS_2834_0:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '3D'
  CONDITION: opp_last_call == '6S'
  CONDITION: passes_since_last_bid == 0

RULE B_3D_3N_PASS_2835_0:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '3D'
  CONDITION: opp_last_call == '3NT'
  CONDITION: passes_since_last_bid == 0

RULE B_3H_P_PASS_2842_0:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '3H'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 1

RULE B_3H_P_3NT_2843_0:
  CALL: 3NT
  PRIORITY: 40
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '3H'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 1
  CONDITION: hcp >= 15

RULE B_3H_P_4H_2849_0:
  CALL: 4H
  PRIORITY: 59
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '3H'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 1
  CONDITION: heart_len >= 3
  CONDITION: total_points >= 7

RULE B_3H_P_4H_2850_0:
  CALL: 4H
  PRIORITY: 60
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '3H'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 1
  CONDITION: heart_len >= 2
  CONDITION: total_points >= 9

RULE B_3H_P_4S_2851_1:
  CALL: 4S
  PRIORITY: 47
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '3H'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 1
  CONDITION: losing_trick_count <= 3
  CONDITION: spade_len >= 6

RULE B_3H_X_PASS_2867_0:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '3H'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 0

RULE B_3H_X_3NT_2868_0:
  CALL: 3NT
  PRIORITY: 40
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '3H'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 15

RULE B_3H_X_4H_2874_0:
  CALL: 4H
  PRIORITY: 59
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '3H'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 0
  CONDITION: heart_len >= 3
  CONDITION: total_points >= 7

RULE B_3H_X_4H_2875_0:
  CALL: 4H
  PRIORITY: 60
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '3H'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 0
  CONDITION: heart_len >= 2
  CONDITION: total_points >= 9

RULE B_3H_X_4S_2876_1:
  CALL: 4S
  PRIORITY: 47
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '3H'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 0
  CONDITION: losing_trick_count <= 3
  CONDITION: spade_len >= 6

RULE B_3H_3S_PASS_2892_0:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '3H'
  CONDITION: opp_last_call == '3S'
  CONDITION: passes_since_last_bid == 0

RULE B_3H_3S_3NT_2893_0:
  CALL: 3NT
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '3H'
  CONDITION: opp_last_call == '3S'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 15
  CONDITION: s_stopper >= 2

RULE B_3H_3S_4H_2896_0:
  CALL: 4H
  PRIORITY: 70
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '3H'
  CONDITION: opp_last_call == '3S'
  CONDITION: passes_since_last_bid == 0
  CONDITION: heart_len >= 2
  CONDITION: heart_hcp >= 9

RULE B_3H_4C_4H_2907_0:
  CALL: 4H
  PRIORITY: 70
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '3H'
  CONDITION: opp_last_call == '4C'
  CONDITION: passes_since_last_bid == 0
  CONDITION: heart_len >= 3
  CONDITION: heart_hcp >= 10

RULE B_3H_4D_4H_2909_0:
  CALL: 4H
  PRIORITY: 70
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '3H'
  CONDITION: opp_last_call == '4D'
  CONDITION: passes_since_last_bid == 0
  CONDITION: heart_len >= 3
  CONDITION: heart_hcp >= 10

RULE B_3H_4S_PASS_2911_0:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '3H'
  CONDITION: opp_last_call == '4S'
  CONDITION: passes_since_last_bid == 0

RULE B_3H_6C_PASS_2914_0:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '3H'
  CONDITION: opp_last_call == '6C'
  CONDITION: passes_since_last_bid == 0

RULE B_3H_6D_PASS_2915_0:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '3H'
  CONDITION: opp_last_call == '6D'
  CONDITION: passes_since_last_bid == 0

RULE B_3H_6S_PASS_2916_0:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '3H'
  CONDITION: opp_last_call == '6S'
  CONDITION: passes_since_last_bid == 0

RULE B_3S_P_PASS_2922_0:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '3S'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 1

RULE B_3S_P_3NT_2923_0:
  CALL: 3NT
  PRIORITY: 40
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '3S'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 1
  CONDITION: hcp >= 15

RULE B_3S_P_4H_2928_1:
  CALL: 4H
  PRIORITY: 47
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '3S'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 1
  CONDITION: losing_trick_count <= 3
  CONDITION: heart_len >= 6

RULE B_3S_P_4S_2933_0:
  CALL: 4S
  PRIORITY: 59
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '3S'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 1
  CONDITION: spade_len >= 3
  CONDITION: total_points >= 7

RULE B_3S_P_4S_2934_0:
  CALL: 4S
  PRIORITY: 60
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '3S'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 1
  CONDITION: spade_len >= 2
  CONDITION: total_points >= 9

RULE B_3S_X_PASS_2947_0:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '3S'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 0

RULE B_3S_X_3NT_2948_0:
  CALL: 3NT
  PRIORITY: 40
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '3S'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 15

RULE B_3S_X_4H_2954_1:
  CALL: 4H
  PRIORITY: 47
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '3S'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 0
  CONDITION: losing_trick_count <= 3
  CONDITION: heart_len >= 6

RULE B_3S_X_4S_2959_0:
  CALL: 4S
  PRIORITY: 59
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '3S'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 0
  CONDITION: spade_len >= 3
  CONDITION: total_points >= 7

RULE B_3S_X_4S_2960_1:
  CALL: 4S
  PRIORITY: 70
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '3S'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 0
  CONDITION: spade_len >= 2
  CONDITION: total_points >= 9

RULE B_3S_4C_4S_2974_0:
  CALL: 4S
  PRIORITY: 70
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '3S'
  CONDITION: opp_last_call == '4C'
  CONDITION: passes_since_last_bid == 0
  CONDITION: spade_len >= 3
  CONDITION: spade_hcp >= 10

RULE B_3S_4D_4S_2976_0:
  CALL: 4S
  PRIORITY: 70
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '3S'
  CONDITION: opp_last_call == '4D'
  CONDITION: passes_since_last_bid == 0
  CONDITION: spade_len >= 3
  CONDITION: spade_hcp >= 10

RULE B_3S_4H_PASS_2977_0:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '3S'
  CONDITION: opp_last_call == '4H'
  CONDITION: passes_since_last_bid == 0

RULE B_3S_4H_4S_2979_0:
  CALL: 4S
  PRIORITY: 70
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '3S'
  CONDITION: opp_last_call == '4H'
  CONDITION: passes_since_last_bid == 0
  CONDITION: spade_len >= 3
  CONDITION: hcp >= 10

RULE B_3S_4H_4S_2979_1:
  CALL: 4S
  PRIORITY: 70
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '3S'
  CONDITION: opp_last_call == '4H'
  CONDITION: passes_since_last_bid == 0
  CONDITION: spade_len >= 2
  CONDITION: hcp >= 14

RULE B_3S_4H_4S_2979_2:
  CALL: 4S
  PRIORITY: 70
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '3S'
  CONDITION: opp_last_call == '4H'
  CONDITION: passes_since_last_bid == 0
  CONDITION: spade_len >= 1
  CONDITION: hcp >= 16

RULE B_3S_6C_PASS_2983_0:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '3S'
  CONDITION: opp_last_call == '6C'
  CONDITION: passes_since_last_bid == 0

RULE B_3S_6D_PASS_2984_0:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '3S'
  CONDITION: opp_last_call == '6D'
  CONDITION: passes_since_last_bid == 0

RULE B_3S_6H_PASS_2985_0:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '3S'
  CONDITION: opp_last_call == '6H'
  CONDITION: passes_since_last_bid == 0

RULE B_4C_P_PASS_2991_0:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '4C'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 1
  CONDITION: hcp <= 16

RULE B_4C_P_PASS_2991_1:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '4C'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 1
  CONDITION: ace_count <= 1

RULE B_4C_P_4H_2992_0:
  CALL: 4H
  PRIORITY: 70
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '4C'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 1
  CONDITION: heart_len >= 7
  CONDITION: total_points >= 17

RULE B_4C_P_4S_2993_0:
  CALL: 4S
  PRIORITY: 70
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '4C'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 1
  CONDITION: spade_len >= 7
  CONDITION: total_points >= 17

RULE B_4C_P_5C_2996_1:
  CALL: 5C
  PRIORITY: 69
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '4C'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 1
  CONDITION: ace_count == 2
  CONDITION: hcp >= 16

RULE B_4C_P_5C_2996_2:
  CALL: 5C
  PRIORITY: 69
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '4C'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 1
  CONDITION: ace_count == 3
  CONDITION: hcp <= 17

RULE B_4C_P_6C_2998_0:
  CALL: 6C
  PRIORITY: 55
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '4C'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 1
  CONDITION: club_len >= 1
  CONDITION: ace_count >= 4

RULE B_4C_P_6C_2998_1:
  CALL: 6C
  PRIORITY: 55
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '4C'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 1
  CONDITION: club_len >= 2
  CONDITION: ace_count >= 4

RULE B_4C_P_6C_2998_2:
  CALL: 6C
  PRIORITY: 55
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '4C'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 1
  CONDITION: club_len >= 2
  CONDITION: hcp >= 20

RULE B_4C_P_6C_2998_3:
  CALL: 6C
  PRIORITY: 55
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '4C'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 1
  CONDITION: ace_count == 3
  CONDITION: hcp >= 18

RULE B_4C_P_7C_3002_0:
  CALL: 7C
  PRIORITY: 58
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '4C'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 1
  CONDITION: ace_count == 4
  CONDITION: hcp >= 20

RULE B_4C_X_PASS_3006_0:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '4C'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp <= 16

RULE B_4C_X_PASS_3006_1:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '4C'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 0
  CONDITION: ace_count <= 1

RULE B_4C_X_4H_3007_0:
  CALL: 4H
  PRIORITY: 70
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '4C'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 0
  CONDITION: heart_len >= 7
  CONDITION: total_points >= 17

RULE B_4C_X_4S_3008_0:
  CALL: 4S
  PRIORITY: 70
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '4C'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 0
  CONDITION: spade_len >= 7
  CONDITION: total_points >= 17

RULE B_4C_X_5C_3011_1:
  CALL: 5C
  PRIORITY: 69
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '4C'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 0
  CONDITION: ace_count == 2
  CONDITION: hcp >= 16

RULE B_4C_X_5C_3011_2:
  CALL: 5C
  PRIORITY: 69
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '4C'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 0
  CONDITION: ace_count == 3
  CONDITION: hcp <= 17

RULE B_4C_X_6C_3013_0:
  CALL: 6C
  PRIORITY: 55
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '4C'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 0
  CONDITION: club_len >= 1
  CONDITION: ace_count >= 4

RULE B_4C_X_6C_3013_1:
  CALL: 6C
  PRIORITY: 55
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '4C'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 0
  CONDITION: club_len >= 2
  CONDITION: ace_count >= 4

RULE B_4C_X_6C_3013_2:
  CALL: 6C
  PRIORITY: 55
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '4C'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 0
  CONDITION: club_len >= 2
  CONDITION: hcp >= 20

RULE B_4C_X_6C_3013_3:
  CALL: 6C
  PRIORITY: 55
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '4C'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 0
  CONDITION: ace_count == 3
  CONDITION: hcp >= 18

RULE B_4C_X_7C_3017_0:
  CALL: 7C
  PRIORITY: 58
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '4C'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 0
  CONDITION: ace_count == 4
  CONDITION: hcp >= 20

RULE B_4C_4H_PASS_3021_0:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '4C'
  CONDITION: opp_last_call == '4H'
  CONDITION: passes_since_last_bid == 0

RULE B_4C_4S_PASS_3028_0:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '4C'
  CONDITION: opp_last_call == '4S'
  CONDITION: passes_since_last_bid == 0

RULE B_4C_5C_PASS_3035_0:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '4C'
  CONDITION: opp_last_call == '5C'
  CONDITION: passes_since_last_bid == 0

RULE B_4D_P_PASS_3036_0:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '4D'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 1
  CONDITION: hcp <= 16

RULE B_4D_P_PASS_3036_1:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '4D'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 1
  CONDITION: ace_count <= 1

RULE B_4D_P_4H_3037_0:
  CALL: 4H
  PRIORITY: 70
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '4D'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 1
  CONDITION: heart_len >= 7
  CONDITION: total_points >= 17

RULE B_4D_P_4S_3038_0:
  CALL: 4S
  PRIORITY: 70
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '4D'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 1
  CONDITION: spade_len >= 7
  CONDITION: total_points >= 17

RULE B_4D_P_5D_3041_1:
  CALL: 5D
  PRIORITY: 69
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '4D'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 1
  CONDITION: ace_count == 2
  CONDITION: hcp >= 16

RULE B_4D_P_5D_3041_2:
  CALL: 5D
  PRIORITY: 69
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '4D'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 1
  CONDITION: ace_count == 3
  CONDITION: hcp <= 17

RULE B_4D_P_6D_3043_0:
  CALL: 6D
  PRIORITY: 55
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '4D'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 1
  CONDITION: diamond_len >= 1
  CONDITION: ace_count >= 4

RULE B_4D_P_6D_3043_1:
  CALL: 6D
  PRIORITY: 55
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '4D'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 1
  CONDITION: diamond_len >= 2
  CONDITION: ace_count >= 4

RULE B_4D_P_6D_3043_2:
  CALL: 6D
  PRIORITY: 55
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '4D'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 1
  CONDITION: diamond_len >= 2
  CONDITION: hcp >= 20

RULE B_4D_P_6D_3043_3:
  CALL: 6D
  PRIORITY: 55
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '4D'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 1
  CONDITION: ace_count == 3
  CONDITION: hcp >= 18

RULE B_4D_P_7D_3047_0:
  CALL: 7D
  PRIORITY: 58
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '4D'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 1
  CONDITION: ace_count == 4
  CONDITION: hcp >= 20

RULE B_4D_X_PASS_3051_0:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '4D'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp <= 16

RULE B_4D_X_PASS_3051_1:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '4D'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 0
  CONDITION: ace_count <= 1

RULE B_4D_X_4H_3052_0:
  CALL: 4H
  PRIORITY: 70
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '4D'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 0
  CONDITION: heart_len >= 7
  CONDITION: total_points >= 17

RULE B_4D_X_4S_3053_0:
  CALL: 4S
  PRIORITY: 70
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '4D'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 0
  CONDITION: spade_len >= 7
  CONDITION: total_points >= 17

RULE B_4D_X_5D_3056_1:
  CALL: 5D
  PRIORITY: 69
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '4D'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 0
  CONDITION: ace_count == 2
  CONDITION: hcp >= 16

RULE B_4D_X_5D_3056_2:
  CALL: 5D
  PRIORITY: 69
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '4D'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 0
  CONDITION: ace_count == 3
  CONDITION: hcp <= 17

RULE B_4D_X_6D_3058_0:
  CALL: 6D
  PRIORITY: 55
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '4D'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 0
  CONDITION: diamond_len >= 1
  CONDITION: ace_count >= 4

RULE B_4D_X_6D_3058_1:
  CALL: 6D
  PRIORITY: 55
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '4D'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 0
  CONDITION: diamond_len >= 2
  CONDITION: ace_count >= 4

RULE B_4D_X_6D_3058_2:
  CALL: 6D
  PRIORITY: 55
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '4D'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 0
  CONDITION: diamond_len >= 2
  CONDITION: hcp >= 20

RULE B_4D_X_6D_3058_3:
  CALL: 6D
  PRIORITY: 55
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '4D'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 0
  CONDITION: ace_count == 3
  CONDITION: hcp >= 18

RULE B_4D_X_7D_3062_0:
  CALL: 7D
  PRIORITY: 58
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '4D'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 0
  CONDITION: ace_count == 4
  CONDITION: hcp >= 20

RULE B_4D_4H_PASS_3066_0:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '4D'
  CONDITION: opp_last_call == '4H'
  CONDITION: passes_since_last_bid == 0

RULE B_4D_4S_PASS_3075_0:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '4D'
  CONDITION: opp_last_call == '4S'
  CONDITION: passes_since_last_bid == 0

RULE B_4D_5C_PASS_3082_0:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '4D'
  CONDITION: opp_last_call == '5C'
  CONDITION: passes_since_last_bid == 0

RULE B_4D_5D_PASS_3085_0:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '4D'
  CONDITION: opp_last_call == '5D'
  CONDITION: passes_since_last_bid == 0

RULE B_4H_P_PASS_3086_0:
  CALL: PASS
  PRIORITY: 20
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '4H'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 1
  CONDITION: ace_count <= 2

RULE B_4H_P_PASS_3086_1:
  CALL: PASS
  PRIORITY: 20
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '4H'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 1
  CONDITION: hcp <= 16

RULE B_4H_P_6H_3092_0:
  CALL: 6H
  PRIORITY: 30
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '4H'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 1
  CONDITION: ace_count >= 3
  CONDITION: hcp >= 17

RULE B_4H_P_7H_3095_0:
  CALL: 7H
  PRIORITY: 40
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '4H'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 1
  CONDITION: ace_count == 4
  CONDITION: hcp >= 17

RULE B_4H_X_PASS_3098_0:
  CALL: PASS
  PRIORITY: 20
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '4H'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 0
  CONDITION: ace_count <= 2

RULE B_4H_X_PASS_3098_1:
  CALL: PASS
  PRIORITY: 20
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '4H'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp <= 16

RULE B_4H_X_6H_3104_0:
  CALL: 6H
  PRIORITY: 30
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '4H'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 0
  CONDITION: ace_count >= 3
  CONDITION: hcp >= 17

RULE B_4H_X_7H_3107_0:
  CALL: 7H
  PRIORITY: 40
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '4H'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 0
  CONDITION: ace_count == 4
  CONDITION: hcp >= 17

RULE B_4H_4S_PASS_3110_0:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '4H'
  CONDITION: opp_last_call == '4S'
  CONDITION: passes_since_last_bid == 0

RULE B_4H_5C_PASS_3113_0:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '4H'
  CONDITION: opp_last_call == '5C'
  CONDITION: passes_since_last_bid == 0

RULE B_4H_5D_PASS_3116_0:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '4H'
  CONDITION: opp_last_call == '5D'
  CONDITION: passes_since_last_bid == 0

RULE B_4H_5S_PASS_3119_0:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '4H'
  CONDITION: opp_last_call == '5S'
  CONDITION: passes_since_last_bid == 0

RULE B_4H_4N_PASS_3121_0:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '4H'
  CONDITION: opp_last_call == '4NT'
  CONDITION: passes_since_last_bid == 0

RULE B_4S_P_PASS_3124_0:
  CALL: PASS
  PRIORITY: 20
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '4S'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 1
  CONDITION: ace_count <= 2

RULE B_4S_P_PASS_3124_1:
  CALL: PASS
  PRIORITY: 20
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '4S'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 1
  CONDITION: hcp <= 16

RULE B_4S_P_6S_3130_0:
  CALL: 6S
  PRIORITY: 30
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '4S'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 1
  CONDITION: ace_count >= 3
  CONDITION: hcp >= 17

RULE B_4S_P_7S_3133_0:
  CALL: 7S
  PRIORITY: 40
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '4S'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 1
  CONDITION: ace_count == 4
  CONDITION: hcp >= 17

RULE B_4S_X_PASS_3136_0:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '4S'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 0

RULE B_4S_X_6S_3142_0:
  CALL: 6S
  PRIORITY: 30
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '4S'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 0
  CONDITION: ace_count >= 3
  CONDITION: hcp >= 17

RULE B_4S_X_7S_3145_0:
  CALL: 7S
  PRIORITY: 40
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '4S'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 0
  CONDITION: ace_count == 4
  CONDITION: hcp >= 17

RULE B_4S_5C_PASS_3148_0:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '4S'
  CONDITION: opp_last_call == '5C'
  CONDITION: passes_since_last_bid == 0

RULE B_4S_5D_PASS_3151_0:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '4S'
  CONDITION: opp_last_call == '5D'
  CONDITION: passes_since_last_bid == 0

RULE B_4S_5H_PASS_3154_0:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '4S'
  CONDITION: opp_last_call == '5H'
  CONDITION: passes_since_last_bid == 0

RULE B_4S_4N_PASS_3156_0:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '4S'
  CONDITION: opp_last_call == '4NT'
  CONDITION: passes_since_last_bid == 0

RULE B_5C_P_PASS_3159_0:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '5C'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 1

RULE B_5C_X_PASS_3162_0:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '5C'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 0

RULE B_5C_5H_PASS_3165_0:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '5C'
  CONDITION: opp_last_call == '5H'
  CONDITION: passes_since_last_bid == 0

RULE B_5C_5S_PASS_3167_0:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '5C'
  CONDITION: opp_last_call == '5S'
  CONDITION: passes_since_last_bid == 0

RULE B_5D_P_PASS_3169_0:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '5D'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 1

RULE B_5D_X_PASS_3172_0:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '5D'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 0

RULE B_5D_5H_PASS_3175_0:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '5D'
  CONDITION: opp_last_call == '5H'
  CONDITION: passes_since_last_bid == 0

RULE B_5D_5S_PASS_3177_0:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '5D'
  CONDITION: opp_last_call == '5S'
  CONDITION: passes_since_last_bid == 0

RULE B_5H_P_PASS_3179_0:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '5H'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 1

RULE B_5H_X_PASS_3182_0:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '5H'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 0

RULE B_5H_5S_PASS_3185_0:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '5H'
  CONDITION: opp_last_call == '5S'
  CONDITION: passes_since_last_bid == 0

RULE B_5S_P_PASS_3186_0:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '5S'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 1

RULE B_5S_X_PASS_3189_0:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '5S'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 0

RULE B_6C_P_PASS_3192_0:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '6C'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 1

RULE B_6C_X_PASS_3193_0:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '6C'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 0

RULE B_6D_P_PASS_3194_0:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '6D'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 1

RULE B_6D_X_PASS_3195_0:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '6D'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 0

RULE B_6H_P_PASS_3196_0:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '6H'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 1

RULE B_6H_X_PASS_3197_0:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '6H'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 0

RULE B_6S_P_PASS_3198_0:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '6S'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 1

RULE B_6S_X_PASS_3199_0:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '6S'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 0

RULE B_7C_P_PASS_3200_0:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '7C'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 1

RULE B_7C_X_PASS_3201_0:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '7C'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 0

RULE B_7D_P_PASS_3202_0:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '7D'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 1

RULE B_7D_X_PASS_3203_0:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '7D'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 0

RULE B_7H_P_PASS_3204_0:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '7H'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 1

RULE B_7H_X_PASS_3205_0:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '7H'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 0

RULE B_7S_P_PASS_3206_0:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '7S'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 1

RULE B_7S_X_PASS_3207_0:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '7S'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 0

RULE B_1N_P_PASS_3208_0:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1NT'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 1
  CONDITION: hcp < 8

RULE B_1N_P_2C_3209_2:
  CALL: 2C
  PRIORITY: 80
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1NT'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 1
  CONDITION: hcp >= 8
  CONDITION: hcp <= 9

RULE B_1N_P_2D_3211_0:
  CALL: 2D
  PRIORITY: 95
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1NT'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 1
  CONDITION: heart_len >= 5

RULE B_1N_P_2D_3211_1:
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

RULE B_1N_P_2H_3212_0:
  CALL: 2H
  PRIORITY: 90
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1NT'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 1
  CONDITION: spade_len >= 5

RULE B_1N_P_2S_3213_0:
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

RULE B_1N_P_2S_3213_1:
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

RULE B_1N_P_2S_3214_0:
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

RULE B_1N_P_2NT_3215_0:
  CALL: 2NT
  PRIORITY: 80
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1NT'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 1
  CONDITION: club_len >= 6
  CONDITION: hcp >= 13

RULE B_1N_P_2NT_3215_1:
  CALL: 2NT
  PRIORITY: 80
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1NT'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 1
  CONDITION: club_len >= 6
  CONDITION: hcp <= 7

RULE B_1N_P_3C_3216_0:
  CALL: 3C
  PRIORITY: 80
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1NT'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 1
  CONDITION: diamond_len >= 6
  CONDITION: hcp >= 13

RULE B_1N_P_3C_3216_1:
  CALL: 3C
  PRIORITY: 80
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1NT'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 1
  CONDITION: diamond_len >= 6
  CONDITION: hcp <= 7

RULE B_1N_P_3NT_3220_4_0:
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

RULE B_1N_P_3NT_3220_4_1:
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

RULE B_1N_P_3NT_3220_4_2:
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

RULE B_1N_P_3NT_3220_4_3:
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

RULE B_1N_P_3NT_3220_4_4:
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

RULE B_1N_P_3NT_3220_4_5:
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

RULE B_1N_P_3NT_3220_4_6:
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

RULE B_1N_P_3NT_3220_4_7:
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

RULE B_1N_P_3NT_3220_4_8:
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

RULE B_1N_P_3NT_3220_4_9:
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

RULE B_1N_P_3NT_3220_6_0:
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

RULE B_1N_P_3NT_3220_6_1:
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

RULE B_1N_P_3NT_3220_6_2:
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

RULE B_1N_P_3NT_3220_6_3:
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

RULE B_1N_P_3NT_3220_6_4:
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

RULE B_1N_P_3NT_3220_6_5:
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

RULE B_1N_P_3NT_3220_6_6:
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

RULE B_1N_P_3NT_3220_6_7:
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

RULE B_1N_P_3NT_3220_6_8:
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

RULE B_1N_P_3NT_3220_6_9:
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

RULE B_2N_P_PASS_3229_0:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '2NT'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 1
  CONDITION: hcp < 4

RULE B_2N_P_3D_3232_0:
  CALL: 3D
  PRIORITY: 90
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '2NT'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 1
  CONDITION: heart_len >= 5

RULE B_2N_P_3H_3233_0:
  CALL: 3H
  PRIORITY: 90
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '2NT'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 1
  CONDITION: spade_len >= 5

RULE B_3N_P_PASS_3243_0:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '3NT'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 1
  CONDITION: hcp <= 7

RULE B_3N_P_4D_3245_0:
  CALL: 4D
  PRIORITY: 120
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '3NT'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 1
  CONDITION: heart_len >= 6

RULE B_3N_P_4H_3246_0:
  CALL: 4H
  PRIORITY: 120
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '3NT'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 1
  CONDITION: spade_len >= 6

RULE B_6N_P_PASS_3253_0:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '6NT'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 1

RULE B_7N_P_PASS_3254_0:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '7NT'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 1

RULE B_1N_X_PASS_3255_0:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1NT'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 0

RULE B_1N_X_2C_3256_2:
  CALL: 2C
  PRIORITY: 80
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1NT'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 8
  CONDITION: hcp <= 9

RULE B_1N_X_2D_3258_0:
  CALL: 2D
  PRIORITY: 95
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1NT'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 0
  CONDITION: heart_len >= 5

RULE B_1N_X_2D_3258_1:
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

RULE B_1N_X_2H_3259_0:
  CALL: 2H
  PRIORITY: 90
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1NT'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 0
  CONDITION: spade_len >= 5

RULE B_1N_X_2S_3260_0:
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

RULE B_1N_X_2S_3260_1:
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

RULE B_1N_X_2S_3261_0:
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

RULE B_1N_X_2NT_3262_0:
  CALL: 2NT
  PRIORITY: 80
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1NT'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 0
  CONDITION: club_len >= 6
  CONDITION: hcp >= 13

RULE B_1N_X_2NT_3262_1:
  CALL: 2NT
  PRIORITY: 80
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1NT'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 0
  CONDITION: club_len >= 6
  CONDITION: hcp <= 7

RULE B_1N_X_3C_3263_0:
  CALL: 3C
  PRIORITY: 80
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1NT'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 0
  CONDITION: diamond_len >= 6
  CONDITION: hcp >= 13

RULE B_1N_X_3C_3263_1:
  CALL: 3C
  PRIORITY: 80
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1NT'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 0
  CONDITION: diamond_len >= 6
  CONDITION: hcp <= 7

RULE B_1N_X_3NT_3268_0:
  CALL: 3NT
  PRIORITY: 20
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1NT'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 11

RULE B_1N_X_XX_3276_0:
  CALL: XX
  PRIORITY: 90
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1NT'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 0
  CONDITION: club_len >= 5
  CONDITION: hcp <= 3

RULE B_1N_X_XX_3276_1:
  CALL: XX
  PRIORITY: 90
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1NT'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 0
  CONDITION: diamond_len >= 5
  CONDITION: hcp <= 3

RULE B_6N_X_PASS_3277_0:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '6NT'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 0

RULE B_7N_X_PASS_3278_0:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '7NT'
  CONDITION: opp_last_call == 'NONE'
  CONDITION: passes_since_last_bid == 0

RULE B_1N_2C_PASS_3279_0:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1NT'
  CONDITION: opp_last_call == '2C'
  CONDITION: passes_since_last_bid == 0

RULE B_1N_2C_2D_3280_0:
  CALL: 2D
  PRIORITY: 90
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1NT'
  CONDITION: opp_last_call == '2C'
  CONDITION: passes_since_last_bid == 0
  CONDITION: heart_len >= 5
  CONDITION: heart_hcp >= 6

RULE B_1N_2C_2H_3281_0:
  CALL: 2H
  PRIORITY: 90
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1NT'
  CONDITION: opp_last_call == '2C'
  CONDITION: passes_since_last_bid == 0
  CONDITION: spade_len >= 5
  CONDITION: spade_hcp >= 6

RULE B_1N_2C_2S_3282_0:
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

RULE B_1N_2C_2S_3282_1:
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

RULE B_1N_2C_2S_3283_0:
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

RULE B_1N_2C_2NT_3284_0:
  CALL: 2NT
  PRIORITY: 80
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1NT'
  CONDITION: opp_last_call == '2C'
  CONDITION: passes_since_last_bid == 0
  CONDITION: club_len >= 6
  CONDITION: hcp >= 13

RULE B_1N_2C_2NT_3284_1:
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

RULE B_1N_2C_3C_3285_0:
  CALL: 3C
  PRIORITY: 80
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1NT'
  CONDITION: opp_last_call == '2C'
  CONDITION: passes_since_last_bid == 0
  CONDITION: diamond_len >= 6
  CONDITION: hcp >= 13

RULE B_1N_2C_3C_3285_1:
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

RULE B_1N_2C_3NT_3291_0:
  CALL: 3NT
  PRIORITY: 60
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1NT'
  CONDITION: opp_last_call == '2C'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 8
  CONDITION: club_len >= 6

RULE B_1N_2C_3NT_3291_1:
  CALL: 3NT
  PRIORITY: 60
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1NT'
  CONDITION: opp_last_call == '2C'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 8
  CONDITION: diamond_len >= 6

RULE B_1N_2D_PASS_3302_0:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1NT'
  CONDITION: opp_last_call == '2D'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp <= 8

RULE B_1N_2D_2NT_3303_0:
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

RULE B_1N_2D_2NT_3303_1:
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

RULE B_1N_2D_3H_3304_0:
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

RULE B_1N_2D_3S_3305_0:
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

RULE B_1N_2D_3NT_3306_0:
  CALL: 3NT
  PRIORITY: 100
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1NT'
  CONDITION: opp_last_call == '2D'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 9

RULE B_1N_2D_5C_3308_0:
  CALL: 5C
  PRIORITY: 20
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1NT'
  CONDITION: opp_last_call == '2D'
  CONDITION: passes_since_last_bid == 0
  CONDITION: club_len >= 7
  CONDITION: club_hcp >= 10

RULE B_1N_2D_5D_3309_0:
  CALL: 5D
  PRIORITY: 20
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1NT'
  CONDITION: opp_last_call == '2D'
  CONDITION: passes_since_last_bid == 0
  CONDITION: diamond_len >= 7
  CONDITION: diamond_hcp >= 10

RULE B_1N_2H_PASS_3313_0:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1NT'
  CONDITION: opp_last_call == '2H'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp <= 8

RULE B_1N_2H_2S_3314_0:
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

RULE B_1N_2H_2NT_3315_0:
  CALL: 2NT
  PRIORITY: 95
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1NT'
  CONDITION: opp_last_call == '2H'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 9
  CONDITION: h_stopper >= 2

RULE B_1N_2H_2NT_3315_1:
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

RULE B_1N_2H_2NT_3315_2:
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

RULE B_1N_2H_2NT_3315_3:
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

RULE B_1N_2H_3C_3316_0:
  CALL: 3C
  PRIORITY: 25
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1NT'
  CONDITION: opp_last_call == '2H'
  CONDITION: passes_since_last_bid == 0
  CONDITION: club_len >= 5
  CONDITION: hcp >= 9

RULE B_1N_2H_3D_3317_0:
  CALL: 3D
  PRIORITY: 25
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1NT'
  CONDITION: opp_last_call == '2H'
  CONDITION: passes_since_last_bid == 0
  CONDITION: diamond_len >= 5
  CONDITION: hcp >= 9

RULE B_1N_2H_3S_3318_0:
  CALL: 3S
  PRIORITY: 35
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1NT'
  CONDITION: opp_last_call == '2H'
  CONDITION: passes_since_last_bid == 0
  CONDITION: spade_len >= 5
  CONDITION: hcp >= 9

RULE B_1N_2H_3NT_3319_0:
  CALL: 3NT
  PRIORITY: 20
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1NT'
  CONDITION: opp_last_call == '2H'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 9
  CONDITION: h_stopper < 2

RULE B_1N_2H_X_3325_0:
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

RULE B_1N_2S_PASS_3326_0:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1NT'
  CONDITION: opp_last_call == '2S'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp <= 8

RULE B_1N_2S_2NT_3327_0:
  CALL: 2NT
  PRIORITY: 95
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1NT'
  CONDITION: opp_last_call == '2S'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 9
  CONDITION: s_stopper >= 2

RULE B_1N_2S_2NT_3327_1:
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

RULE B_1N_2S_2NT_3327_2:
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

RULE B_1N_2S_2NT_3327_3:
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

RULE B_1N_2S_3C_3328_0:
  CALL: 3C
  PRIORITY: 25
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1NT'
  CONDITION: opp_last_call == '2S'
  CONDITION: passes_since_last_bid == 0
  CONDITION: club_len >= 5
  CONDITION: hcp >= 9

RULE B_1N_2S_3D_3329_0:
  CALL: 3D
  PRIORITY: 25
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1NT'
  CONDITION: opp_last_call == '2S'
  CONDITION: passes_since_last_bid == 0
  CONDITION: diamond_len >= 5
  CONDITION: hcp >= 9

RULE B_1N_2S_3H_3330_0:
  CALL: 3H
  PRIORITY: 35
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1NT'
  CONDITION: opp_last_call == '2S'
  CONDITION: passes_since_last_bid == 0
  CONDITION: heart_len >= 5
  CONDITION: hcp >= 9

RULE B_1N_2S_3NT_3331_0:
  CALL: 3NT
  PRIORITY: 20
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1NT'
  CONDITION: opp_last_call == '2S'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 9
  CONDITION: s_stopper < 2

RULE B_1N_2S_X_3337_0:
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

RULE B_1N_3C_PASS_3338_0:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1NT'
  CONDITION: opp_last_call == '3C'
  CONDITION: passes_since_last_bid == 0

RULE B_1N_3C_PASS_3338_1:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1NT'
  CONDITION: opp_last_call == '3C'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp <= 8

RULE B_1N_3C_3D_3339_0:
  CALL: 3D
  PRIORITY: 30
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1NT'
  CONDITION: opp_last_call == '3C'
  CONDITION: passes_since_last_bid == 0
  CONDITION: diamond_len >= 5
  CONDITION: hcp >= 8

RULE B_1N_3C_3H_3340_0:
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

RULE B_1N_3C_3S_3341_0:
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

RULE B_1N_3C_3NT_3342_0:
  CALL: 3NT
  PRIORITY: 32
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1NT'
  CONDITION: opp_last_call == '3C'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 9
  CONDITION: c_stopper >= 2

RULE B_1N_3C_4H_3345_0:
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

RULE B_1N_3C_4S_3346_0:
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

RULE B_1N_3C_X_3355_0:
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

RULE B_1N_3C_X_3355_1:
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

RULE B_1N_3C_X_3355_2:
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

RULE B_2N_3C_PASS_3356_0:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '2NT'
  CONDITION: opp_last_call == '3C'
  CONDITION: passes_since_last_bid == 0

RULE B_1N_3D_PASS_3365_0:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1NT'
  CONDITION: opp_last_call == '3D'
  CONDITION: passes_since_last_bid == 0

RULE B_1N_3D_PASS_3365_1:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1NT'
  CONDITION: opp_last_call == '3D'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp <= 8

RULE B_1N_3D_3H_3366_0:
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

RULE B_1N_3D_3S_3367_0:
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

RULE B_1N_3D_3NT_3368_0:
  CALL: 3NT
  PRIORITY: 32
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1NT'
  CONDITION: opp_last_call == '3D'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 9
  CONDITION: d_stopper >= 2

RULE B_1N_3D_4H_3371_0:
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

RULE B_1N_3D_4S_3372_0:
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

RULE B_1N_3D_X_3381_0:
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

RULE B_1N_3D_X_3381_1:
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

RULE B_1N_3D_X_3381_2:
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

RULE B_2N_3D_PASS_3382_0:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '2NT'
  CONDITION: opp_last_call == '3D'
  CONDITION: passes_since_last_bid == 0

RULE B_1N_3H_PASS_3391_0:
  CALL: PASS
  PRIORITY: -3
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1NT'
  CONDITION: opp_last_call == '3H'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp <= 8

RULE B_1N_3H_3NT_3393_0:
  CALL: 3NT
  PRIORITY: 20
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1NT'
  CONDITION: opp_last_call == '3H'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 9

RULE B_1N_3H_3NT_3393_1:
  CALL: 3NT
  PRIORITY: 20
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1NT'
  CONDITION: opp_last_call == '3H'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 9
  CONDITION: h_stopper >= 2

RULE B_1N_3H_4C_3394_0:
  CALL: 4C
  PRIORITY: 39
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1NT'
  CONDITION: opp_last_call == '3H'
  CONDITION: passes_since_last_bid == 0
  CONDITION: club_len >= 6
  CONDITION: hcp >= 8

RULE B_1N_3H_4D_3396_0:
  CALL: 4D
  PRIORITY: 39
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1NT'
  CONDITION: opp_last_call == '3H'
  CONDITION: passes_since_last_bid == 0
  CONDITION: diamond_len >= 6
  CONDITION: hcp >= 8

RULE B_1N_3H_4S_3399_0:
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

RULE B_1N_3H_X_3410_1:
  CALL: X
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1NT'
  CONDITION: opp_last_call == '3H'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 9
  CONDITION: spade_len >= 4

RULE B_1N_3H_X_3410_2:
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

RULE B_2N_3H_PASS_3411_0:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '2NT'
  CONDITION: opp_last_call == '3H'
  CONDITION: passes_since_last_bid == 0

RULE B_1N_3S_PASS_3422_0:
  CALL: PASS
  PRIORITY: -3
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1NT'
  CONDITION: opp_last_call == '3S'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp <= 8

RULE B_1N_3S_3NT_3423_0:
  CALL: 3NT
  PRIORITY: 20
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1NT'
  CONDITION: opp_last_call == '3S'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 9

RULE B_1N_3S_3NT_3423_1:
  CALL: 3NT
  PRIORITY: 20
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1NT'
  CONDITION: opp_last_call == '3S'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 9
  CONDITION: s_stopper >= 2

RULE B_1N_3S_4C_3424_0:
  CALL: 4C
  PRIORITY: 39
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1NT'
  CONDITION: opp_last_call == '3S'
  CONDITION: passes_since_last_bid == 0
  CONDITION: club_len >= 6
  CONDITION: hcp >= 8

RULE B_1N_3S_4D_3426_0:
  CALL: 4D
  PRIORITY: 39
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1NT'
  CONDITION: opp_last_call == '3S'
  CONDITION: passes_since_last_bid == 0
  CONDITION: diamond_len >= 6
  CONDITION: hcp >= 8

RULE B_1N_3S_4H_3429_0:
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

RULE B_1N_3S_X_3439_1:
  CALL: X
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1NT'
  CONDITION: opp_last_call == '3S'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 9
  CONDITION: heart_len >= 4

RULE B_1N_3S_X_3439_2:
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

RULE B_2N_3S_PASS_3440_0:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '2NT'
  CONDITION: opp_last_call == '3S'
  CONDITION: passes_since_last_bid == 0

RULE B_1N_4C_PASS_3447_0:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1NT'
  CONDITION: opp_last_call == '4C'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp <= 9

RULE B_1N_4C_4H_3448_0:
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

RULE B_1N_4C_4S_3449_0:
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

RULE B_1N_4C_X_3457_0:
  CALL: X
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1NT'
  CONDITION: opp_last_call == '4C'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 10

RULE B_2N_4C_PASS_3458_0:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '2NT'
  CONDITION: opp_last_call == '4C'
  CONDITION: passes_since_last_bid == 0

RULE B_3N_4C_PASS_3461_0:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '3NT'
  CONDITION: opp_last_call == '4C'
  CONDITION: passes_since_last_bid == 0

RULE B_1N_4D_PASS_3462_0:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1NT'
  CONDITION: opp_last_call == '4D'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp <= 9

RULE B_1N_4D_4H_3463_0:
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

RULE B_1N_4D_4S_3464_0:
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

RULE B_1N_4D_X_3472_0:
  CALL: X
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1NT'
  CONDITION: opp_last_call == '4D'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 10

RULE B_2N_4D_PASS_3473_0:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '2NT'
  CONDITION: opp_last_call == '4D'
  CONDITION: passes_since_last_bid == 0

RULE B_3N_4D_PASS_3476_0:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '3NT'
  CONDITION: opp_last_call == '4D'
  CONDITION: passes_since_last_bid == 0

RULE B_1N_4H_PASS_3477_0:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1NT'
  CONDITION: opp_last_call == '4H'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp <= 9

RULE B_1N_4H_X_3485_0:
  CALL: X
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1NT'
  CONDITION: opp_last_call == '4H'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 10

RULE B_2N_4H_PASS_3486_0:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '2NT'
  CONDITION: opp_last_call == '4H'
  CONDITION: passes_since_last_bid == 0

RULE B_3N_4H_PASS_3491_0:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '3NT'
  CONDITION: opp_last_call == '4H'
  CONDITION: passes_since_last_bid == 0

RULE B_1N_4S_PASS_3492_0:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1NT'
  CONDITION: opp_last_call == '4S'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp <= 9

RULE B_1N_4S_X_3500_0:
  CALL: X
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '1NT'
  CONDITION: opp_last_call == '4S'
  CONDITION: passes_since_last_bid == 0
  CONDITION: hcp >= 10

RULE B_2N_4S_PASS_3501_0:
  CALL: PASS
  PRIORITY: 0
  CONDITION: is_opening == False
  CONDITION: my_last_call == 'NONE'
  CONDITION: partner_last_call == '2NT'
  CONDITION: opp_last_call == '4S'
  CONDITION: passes_since_last_bid == 0

RULE B_3N_4S_PASS_3506_0:
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

