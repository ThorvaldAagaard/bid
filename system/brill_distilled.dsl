# ==========================================
# IMPROVED BIDDING SYSTEM: brill_distilled
# Generated via Continuous Self-Improvement Pipeline
# ==========================================

# --- Active Rules & Conventions ---

RULE BD_False_P0:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid <= 0.5
  CONDITION: spade_len <= 3.5
  CONDITION: hcp <= 7.5
  CONDITION: partner_last_bid_strain == 'NONE'
  CONDITION: heart_len <= 4.5
  CONDITION: longest_suit_len <= 5.5
  CONDITION: competition_level <= 1.5
  # distilled from Brill /bid

RULE BD_False_P1:
  CALL: XX
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid <= 0.5
  CONDITION: spade_len <= 3.5
  CONDITION: hcp <= 7.5
  CONDITION: partner_last_bid_strain == 'NONE'
  CONDITION: heart_len <= 4.5
  CONDITION: longest_suit_len <= 5.5
  CONDITION: competition_level > 1.5
  CONDITION: hcp <= 5.5
  CONDITION: hcp <= 4.0
  # distilled from Brill /bid

RULE BD_False_P2:
  CALL: 2D
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid <= 0.5
  CONDITION: spade_len <= 3.5
  CONDITION: hcp <= 7.5
  CONDITION: partner_last_bid_strain == 'NONE'
  CONDITION: heart_len <= 4.5
  CONDITION: longest_suit_len <= 5.5
  CONDITION: competition_level > 1.5
  CONDITION: hcp <= 5.5
  CONDITION: hcp > 4.0
  # distilled from Brill /bid

RULE BD_False_P3:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid <= 0.5
  CONDITION: spade_len <= 3.5
  CONDITION: hcp <= 7.5
  CONDITION: partner_last_bid_strain == 'NONE'
  CONDITION: heart_len <= 4.5
  CONDITION: longest_suit_len <= 5.5
  CONDITION: competition_level > 1.5
  CONDITION: hcp > 5.5
  # distilled from Brill /bid

RULE BD_False_P4:
  CALL: 3C
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid <= 0.5
  CONDITION: spade_len <= 3.5
  CONDITION: hcp <= 7.5
  CONDITION: partner_last_bid_strain == 'NONE'
  CONDITION: heart_len <= 4.5
  CONDITION: longest_suit_len > 5.5
  CONDITION: hcp <= 6.5
  # distilled from Brill /bid

RULE BD_False_P5:
  CALL: 2NT
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid <= 0.5
  CONDITION: spade_len <= 3.5
  CONDITION: hcp <= 7.5
  CONDITION: partner_last_bid_strain == 'NONE'
  CONDITION: heart_len <= 4.5
  CONDITION: longest_suit_len > 5.5
  CONDITION: hcp > 6.5
  # distilled from Brill /bid

RULE BD_False_P6:
  CALL: 2D
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid <= 0.5
  CONDITION: spade_len <= 3.5
  CONDITION: hcp <= 7.5
  CONDITION: partner_last_bid_strain == 'NONE'
  CONDITION: heart_len > 4.5
  CONDITION: heart_len <= 5.5
  # distilled from Brill /bid

RULE BD_False_P7:
  CALL: 4D
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid <= 0.5
  CONDITION: spade_len <= 3.5
  CONDITION: hcp <= 7.5
  CONDITION: partner_last_bid_strain == 'NONE'
  CONDITION: heart_len > 4.5
  CONDITION: heart_len > 5.5
  # distilled from Brill /bid

RULE BD_False_P8:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid <= 0.5
  CONDITION: spade_len <= 3.5
  CONDITION: hcp <= 7.5
  CONDITION: partner_last_bid_strain != 'NONE'
  CONDITION: hcp <= 4.5
  CONDITION: minor_hcp <= 3.5
  CONDITION: diamond_len <= 1.5
  CONDITION: hcp <= 3.5
  # distilled from Brill /bid

RULE BD_False_P9:
  CALL: 1H
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid <= 0.5
  CONDITION: spade_len <= 3.5
  CONDITION: hcp <= 7.5
  CONDITION: partner_last_bid_strain != 'NONE'
  CONDITION: hcp <= 4.5
  CONDITION: minor_hcp <= 3.5
  CONDITION: diamond_len <= 1.5
  CONDITION: hcp > 3.5
  # distilled from Brill /bid

RULE BD_False_P10:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid <= 0.5
  CONDITION: spade_len <= 3.5
  CONDITION: hcp <= 7.5
  CONDITION: partner_last_bid_strain != 'NONE'
  CONDITION: hcp <= 4.5
  CONDITION: minor_hcp <= 3.5
  CONDITION: diamond_len > 1.5
  # distilled from Brill /bid

RULE BD_False_P11:
  CALL: 3D
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid <= 0.5
  CONDITION: spade_len <= 3.5
  CONDITION: hcp <= 7.5
  CONDITION: partner_last_bid_strain != 'NONE'
  CONDITION: hcp <= 4.5
  CONDITION: minor_hcp > 3.5
  CONDITION: shape_pattern == '5332'
  # distilled from Brill /bid

RULE BD_False_P12:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid <= 0.5
  CONDITION: spade_len <= 3.5
  CONDITION: hcp <= 7.5
  CONDITION: partner_last_bid_strain != 'NONE'
  CONDITION: hcp <= 4.5
  CONDITION: minor_hcp > 3.5
  CONDITION: shape_pattern != '5332'
  # distilled from Brill /bid

RULE BD_False_P13:
  CALL: 1NT
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid <= 0.5
  CONDITION: spade_len <= 3.5
  CONDITION: hcp <= 7.5
  CONDITION: partner_last_bid_strain != 'NONE'
  CONDITION: hcp > 4.5
  CONDITION: partner_last_bid_strain == 'S'
  CONDITION: spade_len <= 2.5
  CONDITION: losing_trick_count <= 9.5
  CONDITION: passes_since_last_bid <= 1.5
  # distilled from Brill /bid

RULE BD_False_P14:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid <= 0.5
  CONDITION: spade_len <= 3.5
  CONDITION: hcp <= 7.5
  CONDITION: partner_last_bid_strain != 'NONE'
  CONDITION: hcp > 4.5
  CONDITION: partner_last_bid_strain == 'S'
  CONDITION: spade_len <= 2.5
  CONDITION: losing_trick_count <= 9.5
  CONDITION: passes_since_last_bid > 1.5
  # distilled from Brill /bid

RULE BD_False_P15:
  CALL: 2D
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid <= 0.5
  CONDITION: spade_len <= 3.5
  CONDITION: hcp <= 7.5
  CONDITION: partner_last_bid_strain != 'NONE'
  CONDITION: hcp > 4.5
  CONDITION: partner_last_bid_strain == 'S'
  CONDITION: spade_len <= 2.5
  CONDITION: losing_trick_count > 9.5
  # distilled from Brill /bid

RULE BD_False_P16:
  CALL: 2S
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid <= 0.5
  CONDITION: spade_len <= 3.5
  CONDITION: hcp <= 7.5
  CONDITION: partner_last_bid_strain != 'NONE'
  CONDITION: hcp > 4.5
  CONDITION: partner_last_bid_strain == 'S'
  CONDITION: spade_len > 2.5
  CONDITION: competition_level <= 1.5
  # distilled from Brill /bid

RULE BD_False_P17:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid <= 0.5
  CONDITION: spade_len <= 3.5
  CONDITION: hcp <= 7.5
  CONDITION: partner_last_bid_strain != 'NONE'
  CONDITION: hcp > 4.5
  CONDITION: partner_last_bid_strain == 'S'
  CONDITION: spade_len > 2.5
  CONDITION: competition_level > 1.5
  CONDITION: hcp <= 5.5
  # distilled from Brill /bid

RULE BD_False_P18:
  CALL: 1NT
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid <= 0.5
  CONDITION: spade_len <= 3.5
  CONDITION: hcp <= 7.5
  CONDITION: partner_last_bid_strain != 'NONE'
  CONDITION: hcp > 4.5
  CONDITION: partner_last_bid_strain == 'S'
  CONDITION: spade_len > 2.5
  CONDITION: competition_level > 1.5
  CONDITION: hcp > 5.5
  # distilled from Brill /bid

RULE BD_False_P19:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid <= 0.5
  CONDITION: spade_len <= 3.5
  CONDITION: hcp <= 7.5
  CONDITION: partner_last_bid_strain != 'NONE'
  CONDITION: hcp > 4.5
  CONDITION: partner_last_bid_strain != 'S'
  CONDITION: heart_len <= 3.5
  CONDITION: last_bid_strain == 'C'
  CONDITION: hcp <= 6.5
  # distilled from Brill /bid

RULE BD_False_P20:
  CALL: 1D
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid <= 0.5
  CONDITION: spade_len <= 3.5
  CONDITION: hcp <= 7.5
  CONDITION: partner_last_bid_strain != 'NONE'
  CONDITION: hcp > 4.5
  CONDITION: partner_last_bid_strain != 'S'
  CONDITION: heart_len <= 3.5
  CONDITION: last_bid_strain == 'C'
  CONDITION: hcp > 6.5
  # distilled from Brill /bid

RULE BD_False_P21:
  CALL: 1NT
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid <= 0.5
  CONDITION: spade_len <= 3.5
  CONDITION: hcp <= 7.5
  CONDITION: partner_last_bid_strain != 'NONE'
  CONDITION: hcp > 4.5
  CONDITION: partner_last_bid_strain != 'S'
  CONDITION: heart_len <= 3.5
  CONDITION: last_bid_strain != 'C'
  CONDITION: support_in_partner_suit <= 4.5
  # distilled from Brill /bid

RULE BD_False_P22:
  CALL: 3D
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid <= 0.5
  CONDITION: spade_len <= 3.5
  CONDITION: hcp <= 7.5
  CONDITION: partner_last_bid_strain != 'NONE'
  CONDITION: hcp > 4.5
  CONDITION: partner_last_bid_strain != 'S'
  CONDITION: heart_len <= 3.5
  CONDITION: last_bid_strain != 'C'
  CONDITION: support_in_partner_suit > 4.5
  # distilled from Brill /bid

RULE BD_False_P23:
  CALL: 2H
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid <= 0.5
  CONDITION: spade_len <= 3.5
  CONDITION: hcp <= 7.5
  CONDITION: partner_last_bid_strain != 'NONE'
  CONDITION: hcp > 4.5
  CONDITION: partner_last_bid_strain != 'S'
  CONDITION: heart_len > 3.5
  CONDITION: last_bid_strain == 'H'
  CONDITION: heart_len <= 4.5
  # distilled from Brill /bid

RULE BD_False_P24:
  CALL: 4H
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid <= 0.5
  CONDITION: spade_len <= 3.5
  CONDITION: hcp <= 7.5
  CONDITION: partner_last_bid_strain != 'NONE'
  CONDITION: hcp > 4.5
  CONDITION: partner_last_bid_strain != 'S'
  CONDITION: heart_len > 3.5
  CONDITION: last_bid_strain == 'H'
  CONDITION: heart_len > 4.5
  # distilled from Brill /bid

RULE BD_False_P25:
  CALL: 1H
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid <= 0.5
  CONDITION: spade_len <= 3.5
  CONDITION: hcp <= 7.5
  CONDITION: partner_last_bid_strain != 'NONE'
  CONDITION: hcp > 4.5
  CONDITION: partner_last_bid_strain != 'S'
  CONDITION: heart_len > 3.5
  CONDITION: last_bid_strain != 'H'
  CONDITION: d_is_longest <= 0.5
  # distilled from Brill /bid

RULE BD_False_P26:
  CALL: 1D
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid <= 0.5
  CONDITION: spade_len <= 3.5
  CONDITION: hcp <= 7.5
  CONDITION: partner_last_bid_strain != 'NONE'
  CONDITION: hcp > 4.5
  CONDITION: partner_last_bid_strain != 'S'
  CONDITION: heart_len > 3.5
  CONDITION: last_bid_strain != 'H'
  CONDITION: d_is_longest > 0.5
  # distilled from Brill /bid

RULE BD_False_P27:
  CALL: 2C
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid <= 0.5
  CONDITION: spade_len <= 3.5
  CONDITION: hcp > 7.5
  CONDITION: heart_len <= 3.5
  CONDITION: partner_last_bid_strain == 'NONE'
  CONDITION: hcp <= 9.5
  CONDITION: club_len <= 5.5
  # distilled from Brill /bid

RULE BD_False_P28:
  CALL: 2C
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid <= 0.5
  CONDITION: spade_len <= 3.5
  CONDITION: hcp > 7.5
  CONDITION: heart_len <= 3.5
  CONDITION: partner_last_bid_strain == 'NONE'
  CONDITION: hcp <= 9.5
  CONDITION: club_len > 5.5
  CONDITION: hcp <= 8.5
  # distilled from Brill /bid

RULE BD_False_P29:
  CALL: 3NT
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid <= 0.5
  CONDITION: spade_len <= 3.5
  CONDITION: hcp > 7.5
  CONDITION: heart_len <= 3.5
  CONDITION: partner_last_bid_strain == 'NONE'
  CONDITION: hcp <= 9.5
  CONDITION: club_len > 5.5
  CONDITION: hcp > 8.5
  # distilled from Brill /bid

RULE BD_False_P30:
  CALL: 3NT
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid <= 0.5
  CONDITION: spade_len <= 3.5
  CONDITION: hcp > 7.5
  CONDITION: heart_len <= 3.5
  CONDITION: partner_last_bid_strain == 'NONE'
  CONDITION: hcp > 9.5
  CONDITION: competition_level <= 1.5
  CONDITION: controls <= 4.5
  CONDITION: hcp <= 15.5
  # distilled from Brill /bid

RULE BD_False_P31:
  CALL: 4NT
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid <= 0.5
  CONDITION: spade_len <= 3.5
  CONDITION: hcp > 7.5
  CONDITION: heart_len <= 3.5
  CONDITION: partner_last_bid_strain == 'NONE'
  CONDITION: hcp > 9.5
  CONDITION: competition_level <= 1.5
  CONDITION: controls <= 4.5
  CONDITION: hcp > 15.5
  # distilled from Brill /bid

RULE BD_False_P32:
  CALL: 2NT
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid <= 0.5
  CONDITION: spade_len <= 3.5
  CONDITION: hcp > 7.5
  CONDITION: heart_len <= 3.5
  CONDITION: partner_last_bid_strain == 'NONE'
  CONDITION: hcp > 9.5
  CONDITION: competition_level <= 1.5
  CONDITION: controls > 4.5
  CONDITION: diamond_hcp <= 2.0
  # distilled from Brill /bid

RULE BD_False_P33:
  CALL: 2S
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid <= 0.5
  CONDITION: spade_len <= 3.5
  CONDITION: hcp > 7.5
  CONDITION: heart_len <= 3.5
  CONDITION: partner_last_bid_strain == 'NONE'
  CONDITION: hcp > 9.5
  CONDITION: competition_level <= 1.5
  CONDITION: controls > 4.5
  CONDITION: diamond_hcp > 2.0
  # distilled from Brill /bid

RULE BD_False_P34:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid <= 0.5
  CONDITION: spade_len <= 3.5
  CONDITION: hcp > 7.5
  CONDITION: heart_len <= 3.5
  CONDITION: partner_last_bid_strain == 'NONE'
  CONDITION: hcp > 9.5
  CONDITION: competition_level > 1.5
  CONDITION: hcp <= 18.0
  # distilled from Brill /bid

RULE BD_False_P35:
  CALL: 3NT
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid <= 0.5
  CONDITION: spade_len <= 3.5
  CONDITION: hcp > 7.5
  CONDITION: heart_len <= 3.5
  CONDITION: partner_last_bid_strain == 'NONE'
  CONDITION: hcp > 9.5
  CONDITION: competition_level > 1.5
  CONDITION: hcp > 18.0
  # distilled from Brill /bid

RULE BD_False_P36:
  CALL: 1D
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid <= 0.5
  CONDITION: spade_len <= 3.5
  CONDITION: hcp > 7.5
  CONDITION: heart_len <= 3.5
  CONDITION: partner_last_bid_strain != 'NONE'
  CONDITION: hcp <= 9.5
  CONDITION: partner_last_bid_strain == 'C'
  CONDITION: club_hcp <= 3.5
  CONDITION: auction_len <= 4.5
  # distilled from Brill /bid

RULE BD_False_P37:
  CALL: 2D
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid <= 0.5
  CONDITION: spade_len <= 3.5
  CONDITION: hcp > 7.5
  CONDITION: heart_len <= 3.5
  CONDITION: partner_last_bid_strain != 'NONE'
  CONDITION: hcp <= 9.5
  CONDITION: partner_last_bid_strain == 'C'
  CONDITION: club_hcp <= 3.5
  CONDITION: auction_len > 4.5
  # distilled from Brill /bid

RULE BD_False_P38:
  CALL: 3C
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid <= 0.5
  CONDITION: spade_len <= 3.5
  CONDITION: hcp > 7.5
  CONDITION: heart_len <= 3.5
  CONDITION: partner_last_bid_strain != 'NONE'
  CONDITION: hcp <= 9.5
  CONDITION: partner_last_bid_strain == 'C'
  CONDITION: club_hcp > 3.5
  CONDITION: hcp <= 8.5
  # distilled from Brill /bid

RULE BD_False_P39:
  CALL: 2NT
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid <= 0.5
  CONDITION: spade_len <= 3.5
  CONDITION: hcp > 7.5
  CONDITION: heart_len <= 3.5
  CONDITION: partner_last_bid_strain != 'NONE'
  CONDITION: hcp <= 9.5
  CONDITION: partner_last_bid_strain == 'C'
  CONDITION: club_hcp > 3.5
  CONDITION: hcp > 8.5
  # distilled from Brill /bid

RULE BD_False_P40:
  CALL: 1NT
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid <= 0.5
  CONDITION: spade_len <= 3.5
  CONDITION: hcp > 7.5
  CONDITION: heart_len <= 3.5
  CONDITION: partner_last_bid_strain != 'NONE'
  CONDITION: hcp <= 9.5
  CONDITION: partner_last_bid_strain != 'C'
  CONDITION: last_bid_strain == 'S'
  CONDITION: spade_len <= 2.5
  # distilled from Brill /bid

RULE BD_False_P41:
  CALL: 2S
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid <= 0.5
  CONDITION: spade_len <= 3.5
  CONDITION: hcp > 7.5
  CONDITION: heart_len <= 3.5
  CONDITION: partner_last_bid_strain != 'NONE'
  CONDITION: hcp <= 9.5
  CONDITION: partner_last_bid_strain != 'C'
  CONDITION: last_bid_strain == 'S'
  CONDITION: spade_len > 2.5
  # distilled from Brill /bid

RULE BD_False_P42:
  CALL: 1NT
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid <= 0.5
  CONDITION: spade_len <= 3.5
  CONDITION: hcp > 7.5
  CONDITION: heart_len <= 3.5
  CONDITION: partner_last_bid_strain != 'NONE'
  CONDITION: hcp <= 9.5
  CONDITION: partner_last_bid_strain != 'C'
  CONDITION: last_bid_strain != 'S'
  CONDITION: support_in_partner_suit <= 4.5
  # distilled from Brill /bid

RULE BD_False_P43:
  CALL: 3D
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid <= 0.5
  CONDITION: spade_len <= 3.5
  CONDITION: hcp > 7.5
  CONDITION: heart_len <= 3.5
  CONDITION: partner_last_bid_strain != 'NONE'
  CONDITION: hcp <= 9.5
  CONDITION: partner_last_bid_strain != 'C'
  CONDITION: last_bid_strain != 'S'
  CONDITION: support_in_partner_suit > 4.5
  # distilled from Brill /bid

RULE BD_False_P44:
  CALL: 3C
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid <= 0.5
  CONDITION: spade_len <= 3.5
  CONDITION: hcp > 7.5
  CONDITION: heart_len <= 3.5
  CONDITION: partner_last_bid_strain != 'NONE'
  CONDITION: hcp > 9.5
  CONDITION: is_balanced <= 0.5
  CONDITION: hcp <= 11.5
  CONDITION: diamond_len <= 3.5
  # distilled from Brill /bid

RULE BD_False_P45:
  CALL: 1NT
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid <= 0.5
  CONDITION: spade_len <= 3.5
  CONDITION: hcp > 7.5
  CONDITION: heart_len <= 3.5
  CONDITION: partner_last_bid_strain != 'NONE'
  CONDITION: hcp > 9.5
  CONDITION: is_balanced <= 0.5
  CONDITION: hcp <= 11.5
  CONDITION: diamond_len > 3.5
  # distilled from Brill /bid

RULE BD_False_P46:
  CALL: 2D
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid <= 0.5
  CONDITION: spade_len <= 3.5
  CONDITION: hcp > 7.5
  CONDITION: heart_len <= 3.5
  CONDITION: partner_last_bid_strain != 'NONE'
  CONDITION: hcp > 9.5
  CONDITION: is_balanced <= 0.5
  CONDITION: hcp > 11.5
  CONDITION: club_len <= 3.5
  # distilled from Brill /bid

RULE BD_False_P47:
  CALL: 2C
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid <= 0.5
  CONDITION: spade_len <= 3.5
  CONDITION: hcp > 7.5
  CONDITION: heart_len <= 3.5
  CONDITION: partner_last_bid_strain != 'NONE'
  CONDITION: hcp > 9.5
  CONDITION: is_balanced <= 0.5
  CONDITION: hcp > 11.5
  CONDITION: club_len > 3.5
  # distilled from Brill /bid

RULE BD_False_P48:
  CALL: 2NT
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid <= 0.5
  CONDITION: spade_len <= 3.5
  CONDITION: hcp > 7.5
  CONDITION: heart_len <= 3.5
  CONDITION: partner_last_bid_strain != 'NONE'
  CONDITION: hcp > 9.5
  CONDITION: is_balanced > 0.5
  CONDITION: last_bid_strain == 'C'
  CONDITION: club_len <= 3.5
  # distilled from Brill /bid

RULE BD_False_P49:
  CALL: 2C
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid <= 0.5
  CONDITION: spade_len <= 3.5
  CONDITION: hcp > 7.5
  CONDITION: heart_len <= 3.5
  CONDITION: partner_last_bid_strain != 'NONE'
  CONDITION: hcp > 9.5
  CONDITION: is_balanced > 0.5
  CONDITION: last_bid_strain == 'C'
  CONDITION: club_len > 3.5
  # distilled from Brill /bid

RULE BD_False_P50:
  CALL: XX
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid <= 0.5
  CONDITION: spade_len <= 3.5
  CONDITION: hcp > 7.5
  CONDITION: heart_len <= 3.5
  CONDITION: partner_last_bid_strain != 'NONE'
  CONDITION: hcp > 9.5
  CONDITION: is_balanced > 0.5
  CONDITION: last_bid_strain != 'C'
  CONDITION: passes_since_last_bid <= 0.5
  # distilled from Brill /bid

RULE BD_False_P51:
  CALL: 1NT
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid <= 0.5
  CONDITION: spade_len <= 3.5
  CONDITION: hcp > 7.5
  CONDITION: heart_len <= 3.5
  CONDITION: partner_last_bid_strain != 'NONE'
  CONDITION: hcp > 9.5
  CONDITION: is_balanced > 0.5
  CONDITION: last_bid_strain != 'C'
  CONDITION: passes_since_last_bid > 0.5
  # distilled from Brill /bid

RULE BD_False_P52:
  CALL: 2D
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid <= 0.5
  CONDITION: spade_len <= 3.5
  CONDITION: hcp > 7.5
  CONDITION: heart_len > 3.5
  CONDITION: last_bid_strain == 'S'
  CONDITION: losing_trick_count <= 6.5
  CONDITION: club_len <= 3.5
  CONDITION: total_points <= 17.5
  CONDITION: heart_len <= 5.5
  # distilled from Brill /bid

RULE BD_False_P53:
  CALL: 2H
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid <= 0.5
  CONDITION: spade_len <= 3.5
  CONDITION: hcp > 7.5
  CONDITION: heart_len > 3.5
  CONDITION: last_bid_strain == 'S'
  CONDITION: losing_trick_count <= 6.5
  CONDITION: club_len <= 3.5
  CONDITION: total_points <= 17.5
  CONDITION: heart_len > 5.5
  # distilled from Brill /bid

RULE BD_False_P54:
  CALL: 3D
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid <= 0.5
  CONDITION: spade_len <= 3.5
  CONDITION: hcp > 7.5
  CONDITION: heart_len > 3.5
  CONDITION: last_bid_strain == 'S'
  CONDITION: losing_trick_count <= 6.5
  CONDITION: club_len <= 3.5
  CONDITION: total_points > 17.5
  CONDITION: spade_len <= 1.5
  # distilled from Brill /bid

RULE BD_False_P55:
  CALL: 2NT
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid <= 0.5
  CONDITION: spade_len <= 3.5
  CONDITION: hcp > 7.5
  CONDITION: heart_len > 3.5
  CONDITION: last_bid_strain == 'S'
  CONDITION: losing_trick_count <= 6.5
  CONDITION: club_len <= 3.5
  CONDITION: total_points > 17.5
  CONDITION: spade_len > 1.5
  # distilled from Brill /bid

RULE BD_False_P56:
  CALL: 2C
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid <= 0.5
  CONDITION: spade_len <= 3.5
  CONDITION: hcp > 7.5
  CONDITION: heart_len > 3.5
  CONDITION: last_bid_strain == 'S'
  CONDITION: losing_trick_count <= 6.5
  CONDITION: club_len > 3.5
  CONDITION: hcp <= 16.5
  CONDITION: heart_hcp <= 4.5
  # distilled from Brill /bid

RULE BD_False_P57:
  CALL: 2C
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid <= 0.5
  CONDITION: spade_len <= 3.5
  CONDITION: hcp > 7.5
  CONDITION: heart_len > 3.5
  CONDITION: last_bid_strain == 'S'
  CONDITION: losing_trick_count <= 6.5
  CONDITION: club_len > 3.5
  CONDITION: hcp <= 16.5
  CONDITION: heart_hcp > 4.5
  # distilled from Brill /bid

RULE BD_False_P58:
  CALL: 2H
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid <= 0.5
  CONDITION: spade_len <= 3.5
  CONDITION: hcp > 7.5
  CONDITION: heart_len > 3.5
  CONDITION: last_bid_strain == 'S'
  CONDITION: losing_trick_count <= 6.5
  CONDITION: club_len > 3.5
  CONDITION: hcp > 16.5
  CONDITION: shortest_suit_len <= 1.5
  # distilled from Brill /bid

RULE BD_False_P59:
  CALL: 2NT
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid <= 0.5
  CONDITION: spade_len <= 3.5
  CONDITION: hcp > 7.5
  CONDITION: heart_len > 3.5
  CONDITION: last_bid_strain == 'S'
  CONDITION: losing_trick_count <= 6.5
  CONDITION: club_len > 3.5
  CONDITION: hcp > 16.5
  CONDITION: shortest_suit_len > 1.5
  # distilled from Brill /bid

RULE BD_False_P60:
  CALL: 1NT
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid <= 0.5
  CONDITION: spade_len <= 3.5
  CONDITION: hcp > 7.5
  CONDITION: heart_len > 3.5
  CONDITION: last_bid_strain == 'S'
  CONDITION: losing_trick_count > 6.5
  CONDITION: c_is_best_minor <= 0.5
  CONDITION: my_side_bid_count <= 2.5
  CONDITION: total_points <= 11.5
  # distilled from Brill /bid

RULE BD_False_P61:
  CALL: 1NT
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid <= 0.5
  CONDITION: spade_len <= 3.5
  CONDITION: hcp > 7.5
  CONDITION: heart_len > 3.5
  CONDITION: last_bid_strain == 'S'
  CONDITION: losing_trick_count > 6.5
  CONDITION: c_is_best_minor <= 0.5
  CONDITION: my_side_bid_count <= 2.5
  CONDITION: total_points > 11.5
  # distilled from Brill /bid

RULE BD_False_P62:
  CALL: 2H
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid <= 0.5
  CONDITION: spade_len <= 3.5
  CONDITION: hcp > 7.5
  CONDITION: heart_len > 3.5
  CONDITION: last_bid_strain == 'S'
  CONDITION: losing_trick_count > 6.5
  CONDITION: c_is_best_minor <= 0.5
  CONDITION: my_side_bid_count > 2.5
  CONDITION: hcp <= 9.5
  # distilled from Brill /bid

RULE BD_False_P63:
  CALL: 2NT
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid <= 0.5
  CONDITION: spade_len <= 3.5
  CONDITION: hcp > 7.5
  CONDITION: heart_len > 3.5
  CONDITION: last_bid_strain == 'S'
  CONDITION: losing_trick_count > 6.5
  CONDITION: c_is_best_minor <= 0.5
  CONDITION: my_side_bid_count > 2.5
  CONDITION: hcp > 9.5
  # distilled from Brill /bid

RULE BD_False_P64:
  CALL: 1NT
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid <= 0.5
  CONDITION: spade_len <= 3.5
  CONDITION: hcp > 7.5
  CONDITION: heart_len > 3.5
  CONDITION: last_bid_strain == 'S'
  CONDITION: losing_trick_count > 6.5
  CONDITION: c_is_best_minor > 0.5
  CONDITION: hcp <= 9.5
  CONDITION: spade_len <= 2.5
  # distilled from Brill /bid

RULE BD_False_P65:
  CALL: 2S
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid <= 0.5
  CONDITION: spade_len <= 3.5
  CONDITION: hcp > 7.5
  CONDITION: heart_len > 3.5
  CONDITION: last_bid_strain == 'S'
  CONDITION: losing_trick_count > 6.5
  CONDITION: c_is_best_minor > 0.5
  CONDITION: hcp <= 9.5
  CONDITION: spade_len > 2.5
  # distilled from Brill /bid

RULE BD_False_P66:
  CALL: 2C
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid <= 0.5
  CONDITION: spade_len <= 3.5
  CONDITION: hcp > 7.5
  CONDITION: heart_len > 3.5
  CONDITION: last_bid_strain == 'S'
  CONDITION: losing_trick_count > 6.5
  CONDITION: c_is_best_minor > 0.5
  CONDITION: hcp > 9.5
  CONDITION: my_side_bid_count <= 2.5
  # distilled from Brill /bid

RULE BD_False_P67:
  CALL: 2NT
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid <= 0.5
  CONDITION: spade_len <= 3.5
  CONDITION: hcp > 7.5
  CONDITION: heart_len > 3.5
  CONDITION: last_bid_strain == 'S'
  CONDITION: losing_trick_count > 6.5
  CONDITION: c_is_best_minor > 0.5
  CONDITION: hcp > 9.5
  CONDITION: my_side_bid_count > 2.5
  # distilled from Brill /bid

RULE BD_False_P68:
  CALL: 3S
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid <= 0.5
  CONDITION: spade_len <= 3.5
  CONDITION: hcp > 7.5
  CONDITION: heart_len > 3.5
  CONDITION: last_bid_strain != 'S'
  CONDITION: last_bid_strain == 'NT'
  CONDITION: heart_len <= 4.5
  CONDITION: my_side_bid_count <= 2.0
  CONDITION: shortest_suit_len <= 1.5
  # distilled from Brill /bid

RULE BD_False_P69:
  CALL: 2C
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid <= 0.5
  CONDITION: spade_len <= 3.5
  CONDITION: hcp > 7.5
  CONDITION: heart_len > 3.5
  CONDITION: last_bid_strain != 'S'
  CONDITION: last_bid_strain == 'NT'
  CONDITION: heart_len <= 4.5
  CONDITION: my_side_bid_count <= 2.0
  CONDITION: shortest_suit_len > 1.5
  # distilled from Brill /bid

RULE BD_False_P70:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid <= 0.5
  CONDITION: spade_len <= 3.5
  CONDITION: hcp > 7.5
  CONDITION: heart_len > 3.5
  CONDITION: last_bid_strain != 'S'
  CONDITION: last_bid_strain == 'NT'
  CONDITION: heart_len <= 4.5
  CONDITION: my_side_bid_count > 2.0
  CONDITION: quick_tricks <= 2.25
  # distilled from Brill /bid

RULE BD_False_P71:
  CALL: 2NT
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid <= 0.5
  CONDITION: spade_len <= 3.5
  CONDITION: hcp > 7.5
  CONDITION: heart_len > 3.5
  CONDITION: last_bid_strain != 'S'
  CONDITION: last_bid_strain == 'NT'
  CONDITION: heart_len <= 4.5
  CONDITION: my_side_bid_count > 2.0
  CONDITION: quick_tricks > 2.25
  # distilled from Brill /bid

RULE BD_False_P72:
  CALL: 2D
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid <= 0.5
  CONDITION: spade_len <= 3.5
  CONDITION: hcp > 7.5
  CONDITION: heart_len > 3.5
  CONDITION: last_bid_strain != 'S'
  CONDITION: last_bid_strain == 'NT'
  CONDITION: heart_len > 4.5
  CONDITION: heart_len <= 5.5
  CONDITION: total_points <= 15.5
  # distilled from Brill /bid

RULE BD_False_P73:
  CALL: 3NT
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid <= 0.5
  CONDITION: spade_len <= 3.5
  CONDITION: hcp > 7.5
  CONDITION: heart_len > 3.5
  CONDITION: last_bid_strain != 'S'
  CONDITION: last_bid_strain == 'NT'
  CONDITION: heart_len > 4.5
  CONDITION: heart_len <= 5.5
  CONDITION: total_points > 15.5
  # distilled from Brill /bid

RULE BD_False_P74:
  CALL: 4D
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid <= 0.5
  CONDITION: spade_len <= 3.5
  CONDITION: hcp > 7.5
  CONDITION: heart_len > 3.5
  CONDITION: last_bid_strain != 'S'
  CONDITION: last_bid_strain == 'NT'
  CONDITION: heart_len > 4.5
  CONDITION: heart_len > 5.5
  CONDITION: auction_len <= 4.5
  # distilled from Brill /bid

RULE BD_False_P75:
  CALL: 2H
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid <= 0.5
  CONDITION: spade_len <= 3.5
  CONDITION: hcp > 7.5
  CONDITION: heart_len > 3.5
  CONDITION: last_bid_strain != 'S'
  CONDITION: last_bid_strain == 'NT'
  CONDITION: heart_len > 4.5
  CONDITION: heart_len > 5.5
  CONDITION: auction_len > 4.5
  # distilled from Brill /bid

RULE BD_False_P76:
  CALL: 3S
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid <= 0.5
  CONDITION: spade_len <= 3.5
  CONDITION: hcp > 7.5
  CONDITION: heart_len > 3.5
  CONDITION: last_bid_strain != 'S'
  CONDITION: last_bid_strain != 'NT'
  CONDITION: last_bid_strain == 'H'
  CONDITION: shortest_suit_len <= 1.5
  CONDITION: d_has_jack <= 0.5
  # distilled from Brill /bid

RULE BD_False_P77:
  CALL: 3H
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid <= 0.5
  CONDITION: spade_len <= 3.5
  CONDITION: hcp > 7.5
  CONDITION: heart_len > 3.5
  CONDITION: last_bid_strain != 'S'
  CONDITION: last_bid_strain != 'NT'
  CONDITION: last_bid_strain == 'H'
  CONDITION: shortest_suit_len <= 1.5
  CONDITION: d_has_jack > 0.5
  # distilled from Brill /bid

RULE BD_False_P78:
  CALL: 2NT
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid <= 0.5
  CONDITION: spade_len <= 3.5
  CONDITION: hcp > 7.5
  CONDITION: heart_len > 3.5
  CONDITION: last_bid_strain != 'S'
  CONDITION: last_bid_strain != 'NT'
  CONDITION: last_bid_strain == 'H'
  CONDITION: shortest_suit_len > 1.5
  CONDITION: auction_len <= 3.5
  # distilled from Brill /bid

RULE BD_False_P79:
  CALL: 2H
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid <= 0.5
  CONDITION: spade_len <= 3.5
  CONDITION: hcp > 7.5
  CONDITION: heart_len > 3.5
  CONDITION: last_bid_strain != 'S'
  CONDITION: last_bid_strain != 'NT'
  CONDITION: last_bid_strain == 'H'
  CONDITION: shortest_suit_len > 1.5
  CONDITION: auction_len > 3.5
  # distilled from Brill /bid

RULE BD_False_P80:
  CALL: 1H
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid <= 0.5
  CONDITION: spade_len <= 3.5
  CONDITION: hcp > 7.5
  CONDITION: heart_len > 3.5
  CONDITION: last_bid_strain != 'S'
  CONDITION: last_bid_strain != 'NT'
  CONDITION: last_bid_strain != 'H'
  CONDITION: d_is_longest <= 0.5
  CONDITION: rule20_total <= 24.5
  # distilled from Brill /bid

RULE BD_False_P81:
  CALL: 2H
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid <= 0.5
  CONDITION: spade_len <= 3.5
  CONDITION: hcp > 7.5
  CONDITION: heart_len > 3.5
  CONDITION: last_bid_strain != 'S'
  CONDITION: last_bid_strain != 'NT'
  CONDITION: last_bid_strain != 'H'
  CONDITION: d_is_longest <= 0.5
  CONDITION: rule20_total > 24.5
  # distilled from Brill /bid

RULE BD_False_P82:
  CALL: 1D
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid <= 0.5
  CONDITION: spade_len <= 3.5
  CONDITION: hcp > 7.5
  CONDITION: heart_len > 3.5
  CONDITION: last_bid_strain != 'S'
  CONDITION: last_bid_strain != 'NT'
  CONDITION: last_bid_strain != 'H'
  CONDITION: d_is_longest > 0.5
  CONDITION: last_bid_strain == 'C'
  # distilled from Brill /bid

RULE BD_False_P83:
  CALL: 1H
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid <= 0.5
  CONDITION: spade_len <= 3.5
  CONDITION: hcp > 7.5
  CONDITION: heart_len > 3.5
  CONDITION: last_bid_strain != 'S'
  CONDITION: last_bid_strain != 'NT'
  CONDITION: last_bid_strain != 'H'
  CONDITION: d_is_longest > 0.5
  CONDITION: last_bid_strain != 'C'
  # distilled from Brill /bid

RULE BD_False_P84:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid <= 0.5
  CONDITION: spade_len > 3.5
  CONDITION: last_bid_strain == 'NT'
  CONDITION: spade_len <= 4.5
  CONDITION: competition_level <= 1.5
  CONDITION: hcp <= 7.5
  CONDITION: longest_suit_len <= 5.5
  # distilled from Brill /bid

RULE BD_False_P85:
  CALL: 3C
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid <= 0.5
  CONDITION: spade_len > 3.5
  CONDITION: last_bid_strain == 'NT'
  CONDITION: spade_len <= 4.5
  CONDITION: competition_level <= 1.5
  CONDITION: hcp <= 7.5
  CONDITION: longest_suit_len > 5.5
  CONDITION: hcp <= 4.5
  # distilled from Brill /bid

RULE BD_False_P86:
  CALL: 4D
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid <= 0.5
  CONDITION: spade_len > 3.5
  CONDITION: last_bid_strain == 'NT'
  CONDITION: spade_len <= 4.5
  CONDITION: competition_level <= 1.5
  CONDITION: hcp <= 7.5
  CONDITION: longest_suit_len > 5.5
  CONDITION: hcp > 4.5
  # distilled from Brill /bid

RULE BD_False_P87:
  CALL: 3D
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid <= 0.5
  CONDITION: spade_len > 3.5
  CONDITION: last_bid_strain == 'NT'
  CONDITION: spade_len <= 4.5
  CONDITION: competition_level <= 1.5
  CONDITION: hcp > 7.5
  CONDITION: shortest_suit_len <= 1.5
  CONDITION: minor_hcp <= 1.5
  CONDITION: hcp <= 8.5
  # distilled from Brill /bid

RULE BD_False_P88:
  CALL: 4D
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid <= 0.5
  CONDITION: spade_len > 3.5
  CONDITION: last_bid_strain == 'NT'
  CONDITION: spade_len <= 4.5
  CONDITION: competition_level <= 1.5
  CONDITION: hcp > 7.5
  CONDITION: shortest_suit_len <= 1.5
  CONDITION: minor_hcp <= 1.5
  CONDITION: hcp > 8.5
  # distilled from Brill /bid

RULE BD_False_P89:
  CALL: 2C
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid <= 0.5
  CONDITION: spade_len > 3.5
  CONDITION: last_bid_strain == 'NT'
  CONDITION: spade_len <= 4.5
  CONDITION: competition_level <= 1.5
  CONDITION: hcp > 7.5
  CONDITION: shortest_suit_len <= 1.5
  CONDITION: minor_hcp > 1.5
  CONDITION: spade_hcp <= 3.5
  # distilled from Brill /bid

RULE BD_False_P90:
  CALL: 3H
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid <= 0.5
  CONDITION: spade_len > 3.5
  CONDITION: last_bid_strain == 'NT'
  CONDITION: spade_len <= 4.5
  CONDITION: competition_level <= 1.5
  CONDITION: hcp > 7.5
  CONDITION: shortest_suit_len <= 1.5
  CONDITION: minor_hcp > 1.5
  CONDITION: spade_hcp > 3.5
  # distilled from Brill /bid

RULE BD_False_P91:
  CALL: 2C
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid <= 0.5
  CONDITION: spade_len > 3.5
  CONDITION: last_bid_strain == 'NT'
  CONDITION: spade_len <= 4.5
  CONDITION: competition_level <= 1.5
  CONDITION: hcp > 7.5
  CONDITION: shortest_suit_len > 1.5
  # distilled from Brill /bid

RULE BD_False_P92:
  CALL: 2NT
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid <= 0.5
  CONDITION: spade_len > 3.5
  CONDITION: last_bid_strain == 'NT'
  CONDITION: spade_len <= 4.5
  CONDITION: competition_level > 1.5
  CONDITION: controls <= 4.5
  CONDITION: queen_count <= 2.5
  CONDITION: second_longest_len <= 3.5
  # distilled from Brill /bid

RULE BD_False_P93:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid <= 0.5
  CONDITION: spade_len > 3.5
  CONDITION: last_bid_strain == 'NT'
  CONDITION: spade_len <= 4.5
  CONDITION: competition_level > 1.5
  CONDITION: controls <= 4.5
  CONDITION: queen_count <= 2.5
  CONDITION: second_longest_len > 3.5
  CONDITION: support_in_partner_suit <= 4.0
  # distilled from Brill /bid

RULE BD_False_P94:
  CALL: 3D
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid <= 0.5
  CONDITION: spade_len > 3.5
  CONDITION: last_bid_strain == 'NT'
  CONDITION: spade_len <= 4.5
  CONDITION: competition_level > 1.5
  CONDITION: controls <= 4.5
  CONDITION: queen_count <= 2.5
  CONDITION: second_longest_len > 3.5
  CONDITION: support_in_partner_suit > 4.0
  # distilled from Brill /bid

RULE BD_False_P95:
  CALL: 2H
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid <= 0.5
  CONDITION: spade_len > 3.5
  CONDITION: last_bid_strain == 'NT'
  CONDITION: spade_len <= 4.5
  CONDITION: competition_level > 1.5
  CONDITION: controls <= 4.5
  CONDITION: queen_count > 2.5
  CONDITION: minor_hcp <= 4.0
  # distilled from Brill /bid

RULE BD_False_P96:
  CALL: 2S
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid <= 0.5
  CONDITION: spade_len > 3.5
  CONDITION: last_bid_strain == 'NT'
  CONDITION: spade_len <= 4.5
  CONDITION: competition_level > 1.5
  CONDITION: controls <= 4.5
  CONDITION: queen_count > 2.5
  CONDITION: minor_hcp > 4.0
  # distilled from Brill /bid

RULE BD_False_P97:
  CALL: 2D
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid <= 0.5
  CONDITION: spade_len > 3.5
  CONDITION: last_bid_strain == 'NT'
  CONDITION: spade_len <= 4.5
  CONDITION: competition_level > 1.5
  CONDITION: controls > 4.5
  CONDITION: club_len <= 1.5
  CONDITION: heart_hcp <= 5.5
  # distilled from Brill /bid

RULE BD_False_P98:
  CALL: 4H
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid <= 0.5
  CONDITION: spade_len > 3.5
  CONDITION: last_bid_strain == 'NT'
  CONDITION: spade_len <= 4.5
  CONDITION: competition_level > 1.5
  CONDITION: controls > 4.5
  CONDITION: club_len <= 1.5
  CONDITION: heart_hcp > 5.5
  CONDITION: hcp <= 16.0
  # distilled from Brill /bid

RULE BD_False_P99:
  CALL: 2S
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid <= 0.5
  CONDITION: spade_len > 3.5
  CONDITION: last_bid_strain == 'NT'
  CONDITION: spade_len <= 4.5
  CONDITION: competition_level > 1.5
  CONDITION: controls > 4.5
  CONDITION: club_len <= 1.5
  CONDITION: heart_hcp > 5.5
  CONDITION: hcp > 16.0
  # distilled from Brill /bid

RULE BD_False_P100:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid <= 0.5
  CONDITION: spade_len > 3.5
  CONDITION: last_bid_strain == 'NT'
  CONDITION: spade_len <= 4.5
  CONDITION: competition_level > 1.5
  CONDITION: controls > 4.5
  CONDITION: club_len > 1.5
  CONDITION: shortest_suit_len <= 1.5
  CONDITION: queen_count <= 0.5
  # distilled from Brill /bid

RULE BD_False_P101:
  CALL: 2C
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid <= 0.5
  CONDITION: spade_len > 3.5
  CONDITION: last_bid_strain == 'NT'
  CONDITION: spade_len <= 4.5
  CONDITION: competition_level > 1.5
  CONDITION: controls > 4.5
  CONDITION: club_len > 1.5
  CONDITION: shortest_suit_len <= 1.5
  CONDITION: queen_count > 0.5
  # distilled from Brill /bid

RULE BD_False_P102:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid <= 0.5
  CONDITION: spade_len > 3.5
  CONDITION: last_bid_strain == 'NT'
  CONDITION: spade_len <= 4.5
  CONDITION: competition_level > 1.5
  CONDITION: controls > 4.5
  CONDITION: club_len > 1.5
  CONDITION: shortest_suit_len > 1.5
  CONDITION: d_is_best_minor <= 0.5
  # distilled from Brill /bid

RULE BD_False_P103:
  CALL: 3NT
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid <= 0.5
  CONDITION: spade_len > 3.5
  CONDITION: last_bid_strain == 'NT'
  CONDITION: spade_len <= 4.5
  CONDITION: competition_level > 1.5
  CONDITION: controls > 4.5
  CONDITION: club_len > 1.5
  CONDITION: shortest_suit_len > 1.5
  CONDITION: d_is_best_minor > 0.5
  # distilled from Brill /bid

RULE BD_False_P104:
  CALL: 2H
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid <= 0.5
  CONDITION: spade_len > 3.5
  CONDITION: last_bid_strain == 'NT'
  CONDITION: spade_len > 4.5
  CONDITION: competition_level <= 1.5
  CONDITION: heart_len <= 3.5
  CONDITION: spade_len <= 5.5
  # distilled from Brill /bid

RULE BD_False_P105:
  CALL: 2H
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid <= 0.5
  CONDITION: spade_len > 3.5
  CONDITION: last_bid_strain == 'NT'
  CONDITION: spade_len > 4.5
  CONDITION: competition_level <= 1.5
  CONDITION: heart_len <= 3.5
  CONDITION: spade_len > 5.5
  CONDITION: major_hcp <= 2.5
  # distilled from Brill /bid

RULE BD_False_P106:
  CALL: 4H
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid <= 0.5
  CONDITION: spade_len > 3.5
  CONDITION: last_bid_strain == 'NT'
  CONDITION: spade_len > 4.5
  CONDITION: competition_level <= 1.5
  CONDITION: heart_len <= 3.5
  CONDITION: spade_len > 5.5
  CONDITION: major_hcp > 2.5
  # distilled from Brill /bid

RULE BD_False_P107:
  CALL: 2D
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid <= 0.5
  CONDITION: spade_len > 3.5
  CONDITION: last_bid_strain == 'NT'
  CONDITION: spade_len > 4.5
  CONDITION: competition_level <= 1.5
  CONDITION: heart_len > 3.5
  CONDITION: hcp <= 9.5
  CONDITION: hcp <= 4.5
  # distilled from Brill /bid

RULE BD_False_P108:
  CALL: 2H
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid <= 0.5
  CONDITION: spade_len > 3.5
  CONDITION: last_bid_strain == 'NT'
  CONDITION: spade_len > 4.5
  CONDITION: competition_level <= 1.5
  CONDITION: heart_len > 3.5
  CONDITION: hcp <= 9.5
  CONDITION: hcp > 4.5
  # distilled from Brill /bid

RULE BD_False_P109:
  CALL: 2C
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid <= 0.5
  CONDITION: spade_len > 3.5
  CONDITION: last_bid_strain == 'NT'
  CONDITION: spade_len > 4.5
  CONDITION: competition_level <= 1.5
  CONDITION: heart_len > 3.5
  CONDITION: hcp > 9.5
  # distilled from Brill /bid

RULE BD_False_P110:
  CALL: 2D
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid <= 0.5
  CONDITION: spade_len > 3.5
  CONDITION: last_bid_strain == 'NT'
  CONDITION: spade_len > 4.5
  CONDITION: competition_level > 1.5
  CONDITION: heart_len <= 3.5
  CONDITION: spade_len <= 5.5
  CONDITION: c_is_best_minor <= 0.5
  CONDITION: s_top2_honors <= 1.5
  # distilled from Brill /bid

RULE BD_False_P111:
  CALL: 2C
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid <= 0.5
  CONDITION: spade_len > 3.5
  CONDITION: last_bid_strain == 'NT'
  CONDITION: spade_len > 4.5
  CONDITION: competition_level > 1.5
  CONDITION: heart_len <= 3.5
  CONDITION: spade_len <= 5.5
  CONDITION: c_is_best_minor <= 0.5
  CONDITION: s_top2_honors > 1.5
  # distilled from Brill /bid

RULE BD_False_P112:
  CALL: 2C
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid <= 0.5
  CONDITION: spade_len > 3.5
  CONDITION: last_bid_strain == 'NT'
  CONDITION: spade_len > 4.5
  CONDITION: competition_level > 1.5
  CONDITION: heart_len <= 3.5
  CONDITION: spade_len <= 5.5
  CONDITION: c_is_best_minor > 0.5
  CONDITION: hcp <= 17.0
  # distilled from Brill /bid

RULE BD_False_P113:
  CALL: 3NT
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid <= 0.5
  CONDITION: spade_len > 3.5
  CONDITION: last_bid_strain == 'NT'
  CONDITION: spade_len > 4.5
  CONDITION: competition_level > 1.5
  CONDITION: heart_len <= 3.5
  CONDITION: spade_len <= 5.5
  CONDITION: c_is_best_minor > 0.5
  CONDITION: hcp > 17.0
  # distilled from Brill /bid

RULE BD_False_P114:
  CALL: 2H
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid <= 0.5
  CONDITION: spade_len > 3.5
  CONDITION: last_bid_strain == 'NT'
  CONDITION: spade_len > 4.5
  CONDITION: competition_level > 1.5
  CONDITION: heart_len <= 3.5
  CONDITION: spade_len > 5.5
  CONDITION: major_hcp <= 6.0
  CONDITION: king_count <= 1.5
  # distilled from Brill /bid

RULE BD_False_P115:
  CALL: 2S
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid <= 0.5
  CONDITION: spade_len > 3.5
  CONDITION: last_bid_strain == 'NT'
  CONDITION: spade_len > 4.5
  CONDITION: competition_level > 1.5
  CONDITION: heart_len <= 3.5
  CONDITION: spade_len > 5.5
  CONDITION: major_hcp <= 6.0
  CONDITION: king_count > 1.5
  # distilled from Brill /bid

RULE BD_False_P116:
  CALL: 4S
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid <= 0.5
  CONDITION: spade_len > 3.5
  CONDITION: last_bid_strain == 'NT'
  CONDITION: spade_len > 4.5
  CONDITION: competition_level > 1.5
  CONDITION: heart_len <= 3.5
  CONDITION: spade_len > 5.5
  CONDITION: major_hcp > 6.0
  CONDITION: my_seat == 'S'
  # distilled from Brill /bid

RULE BD_False_P117:
  CALL: 3S
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid <= 0.5
  CONDITION: spade_len > 3.5
  CONDITION: last_bid_strain == 'NT'
  CONDITION: spade_len > 4.5
  CONDITION: competition_level > 1.5
  CONDITION: heart_len <= 3.5
  CONDITION: spade_len > 5.5
  CONDITION: major_hcp > 6.0
  CONDITION: my_seat != 'S'
  # distilled from Brill /bid

RULE BD_False_P118:
  CALL: 2S
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid <= 0.5
  CONDITION: spade_len > 3.5
  CONDITION: last_bid_strain == 'NT'
  CONDITION: spade_len > 4.5
  CONDITION: competition_level > 1.5
  CONDITION: heart_len > 3.5
  CONDITION: hcp <= 10.5
  # distilled from Brill /bid

RULE BD_False_P119:
  CALL: 2H
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid <= 0.5
  CONDITION: spade_len > 3.5
  CONDITION: last_bid_strain == 'NT'
  CONDITION: spade_len > 4.5
  CONDITION: competition_level > 1.5
  CONDITION: heart_len > 3.5
  CONDITION: hcp > 10.5
  CONDITION: hcp <= 17.5
  # distilled from Brill /bid

RULE BD_False_P120:
  CALL: 3NT
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid <= 0.5
  CONDITION: spade_len > 3.5
  CONDITION: last_bid_strain == 'NT'
  CONDITION: spade_len > 4.5
  CONDITION: competition_level > 1.5
  CONDITION: heart_len > 3.5
  CONDITION: hcp > 10.5
  CONDITION: hcp > 17.5
  # distilled from Brill /bid

RULE BD_False_P121:
  CALL: 4S
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid <= 0.5
  CONDITION: spade_len > 3.5
  CONDITION: last_bid_strain != 'NT'
  CONDITION: partner_last_call == '1S'
  CONDITION: shortest_suit_len <= 1.5
  CONDITION: my_side_bid_count <= 1.5
  CONDITION: club_len <= 2.0
  CONDITION: hcp <= 9.0
  CONDITION: hcp <= 6.5
  # distilled from Brill /bid

RULE BD_False_P122:
  CALL: 2S
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid <= 0.5
  CONDITION: spade_len > 3.5
  CONDITION: last_bid_strain != 'NT'
  CONDITION: partner_last_call == '1S'
  CONDITION: shortest_suit_len <= 1.5
  CONDITION: my_side_bid_count <= 1.5
  CONDITION: club_len <= 2.0
  CONDITION: hcp <= 9.0
  CONDITION: hcp > 6.5
  # distilled from Brill /bid

RULE BD_False_P123:
  CALL: 4C
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid <= 0.5
  CONDITION: spade_len > 3.5
  CONDITION: last_bid_strain != 'NT'
  CONDITION: partner_last_call == '1S'
  CONDITION: shortest_suit_len <= 1.5
  CONDITION: my_side_bid_count <= 1.5
  CONDITION: club_len <= 2.0
  CONDITION: hcp > 9.0
  # distilled from Brill /bid

RULE BD_False_P124:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid <= 0.5
  CONDITION: spade_len > 3.5
  CONDITION: last_bid_strain != 'NT'
  CONDITION: partner_last_call == '1S'
  CONDITION: shortest_suit_len <= 1.5
  CONDITION: my_side_bid_count <= 1.5
  CONDITION: club_len > 2.0
  CONDITION: total_points <= 12.5
  CONDITION: hcp <= 6.5
  # distilled from Brill /bid

RULE BD_False_P125:
  CALL: 4H
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid <= 0.5
  CONDITION: spade_len > 3.5
  CONDITION: last_bid_strain != 'NT'
  CONDITION: partner_last_call == '1S'
  CONDITION: shortest_suit_len <= 1.5
  CONDITION: my_side_bid_count <= 1.5
  CONDITION: club_len > 2.0
  CONDITION: total_points <= 12.5
  CONDITION: hcp > 6.5
  # distilled from Brill /bid

RULE BD_False_P126:
  CALL: 4D
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid <= 0.5
  CONDITION: spade_len > 3.5
  CONDITION: last_bid_strain != 'NT'
  CONDITION: partner_last_call == '1S'
  CONDITION: shortest_suit_len <= 1.5
  CONDITION: my_side_bid_count <= 1.5
  CONDITION: club_len > 2.0
  CONDITION: total_points > 12.5
  # distilled from Brill /bid

RULE BD_False_P127:
  CALL: 3S
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid <= 0.5
  CONDITION: spade_len > 3.5
  CONDITION: last_bid_strain != 'NT'
  CONDITION: partner_last_call == '1S'
  CONDITION: shortest_suit_len <= 1.5
  CONDITION: my_side_bid_count > 1.5
  CONDITION: jack_count <= 0.5
  CONDITION: major_hcp <= 8.0
  # distilled from Brill /bid

RULE BD_False_P128:
  CALL: 2S
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid <= 0.5
  CONDITION: spade_len > 3.5
  CONDITION: last_bid_strain != 'NT'
  CONDITION: partner_last_call == '1S'
  CONDITION: shortest_suit_len <= 1.5
  CONDITION: my_side_bid_count > 1.5
  CONDITION: jack_count <= 0.5
  CONDITION: major_hcp > 8.0
  # distilled from Brill /bid

RULE BD_False_P129:
  CALL: 4S
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid <= 0.5
  CONDITION: spade_len > 3.5
  CONDITION: last_bid_strain != 'NT'
  CONDITION: partner_last_call == '1S'
  CONDITION: shortest_suit_len <= 1.5
  CONDITION: my_side_bid_count > 1.5
  CONDITION: jack_count > 0.5
  CONDITION: spade_hcp <= 7.5
  # distilled from Brill /bid

RULE BD_False_P130:
  CALL: 2S
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid <= 0.5
  CONDITION: spade_len > 3.5
  CONDITION: last_bid_strain != 'NT'
  CONDITION: partner_last_call == '1S'
  CONDITION: shortest_suit_len <= 1.5
  CONDITION: my_side_bid_count > 1.5
  CONDITION: jack_count > 0.5
  CONDITION: spade_hcp > 7.5
  # distilled from Brill /bid

RULE BD_False_P131:
  CALL: 2S
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid <= 0.5
  CONDITION: spade_len > 3.5
  CONDITION: last_bid_strain != 'NT'
  CONDITION: partner_last_call == '1S'
  CONDITION: shortest_suit_len > 1.5
  CONDITION: s_has_ace <= 0.5
  CONDITION: spade_len <= 4.5
  CONDITION: hcp <= 11.5
  CONDITION: hcp <= 8.5
  # distilled from Brill /bid

RULE BD_False_P132:
  CALL: 3S
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid <= 0.5
  CONDITION: spade_len > 3.5
  CONDITION: last_bid_strain != 'NT'
  CONDITION: partner_last_call == '1S'
  CONDITION: shortest_suit_len > 1.5
  CONDITION: s_has_ace <= 0.5
  CONDITION: spade_len <= 4.5
  CONDITION: hcp <= 11.5
  CONDITION: hcp > 8.5
  # distilled from Brill /bid

RULE BD_False_P133:
  CALL: 3S
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid <= 0.5
  CONDITION: spade_len > 3.5
  CONDITION: last_bid_strain != 'NT'
  CONDITION: partner_last_call == '1S'
  CONDITION: shortest_suit_len > 1.5
  CONDITION: s_has_ace <= 0.5
  CONDITION: spade_len <= 4.5
  CONDITION: hcp > 11.5
  CONDITION: heart_len <= 2.5
  # distilled from Brill /bid

RULE BD_False_P134:
  CALL: 2S
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid <= 0.5
  CONDITION: spade_len > 3.5
  CONDITION: last_bid_strain != 'NT'
  CONDITION: partner_last_call == '1S'
  CONDITION: shortest_suit_len > 1.5
  CONDITION: s_has_ace <= 0.5
  CONDITION: spade_len <= 4.5
  CONDITION: hcp > 11.5
  CONDITION: heart_len > 2.5
  # distilled from Brill /bid

RULE BD_False_P135:
  CALL: 4S
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid <= 0.5
  CONDITION: spade_len > 3.5
  CONDITION: last_bid_strain != 'NT'
  CONDITION: partner_last_call == '1S'
  CONDITION: shortest_suit_len > 1.5
  CONDITION: s_has_ace <= 0.5
  CONDITION: spade_len > 4.5
  # distilled from Brill /bid

RULE BD_False_P136:
  CALL: 3S
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid <= 0.5
  CONDITION: spade_len > 3.5
  CONDITION: last_bid_strain != 'NT'
  CONDITION: partner_last_call == '1S'
  CONDITION: shortest_suit_len > 1.5
  CONDITION: s_has_ace > 0.5
  CONDITION: major_hcp <= 8.5
  CONDITION: hcp <= 10.5
  CONDITION: hcp <= 9.5
  # distilled from Brill /bid

RULE BD_False_P137:
  CALL: 2C
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid <= 0.5
  CONDITION: spade_len > 3.5
  CONDITION: last_bid_strain != 'NT'
  CONDITION: partner_last_call == '1S'
  CONDITION: shortest_suit_len > 1.5
  CONDITION: s_has_ace > 0.5
  CONDITION: major_hcp <= 8.5
  CONDITION: hcp <= 10.5
  CONDITION: hcp > 9.5
  # distilled from Brill /bid

RULE BD_False_P138:
  CALL: 2NT
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid <= 0.5
  CONDITION: spade_len > 3.5
  CONDITION: last_bid_strain != 'NT'
  CONDITION: partner_last_call == '1S'
  CONDITION: shortest_suit_len > 1.5
  CONDITION: s_has_ace > 0.5
  CONDITION: major_hcp <= 8.5
  CONDITION: hcp > 10.5
  # distilled from Brill /bid

RULE BD_False_P139:
  CALL: 2S
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid <= 0.5
  CONDITION: spade_len > 3.5
  CONDITION: last_bid_strain != 'NT'
  CONDITION: partner_last_call == '1S'
  CONDITION: shortest_suit_len > 1.5
  CONDITION: s_has_ace > 0.5
  CONDITION: major_hcp > 8.5
  CONDITION: hcp <= 13.5
  # distilled from Brill /bid

RULE BD_False_P140:
  CALL: 4S
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid <= 0.5
  CONDITION: spade_len > 3.5
  CONDITION: last_bid_strain != 'NT'
  CONDITION: partner_last_call == '1S'
  CONDITION: shortest_suit_len > 1.5
  CONDITION: s_has_ace > 0.5
  CONDITION: major_hcp > 8.5
  CONDITION: hcp > 13.5
  # distilled from Brill /bid

RULE BD_False_P141:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid <= 0.5
  CONDITION: spade_len > 3.5
  CONDITION: last_bid_strain != 'NT'
  CONDITION: partner_last_call != '1S'
  CONDITION: h_is_best_major <= 0.5
  CONDITION: hcp <= 4.5
  CONDITION: s_has_king <= 0.5
  CONDITION: singleton_count <= 0.5
  # distilled from Brill /bid

RULE BD_False_P142:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid <= 0.5
  CONDITION: spade_len > 3.5
  CONDITION: last_bid_strain != 'NT'
  CONDITION: partner_last_call != '1S'
  CONDITION: h_is_best_major <= 0.5
  CONDITION: hcp <= 4.5
  CONDITION: s_has_king <= 0.5
  CONDITION: singleton_count > 0.5
  CONDITION: club_hcp <= 1.5
  # distilled from Brill /bid

RULE BD_False_P143:
  CALL: 1S
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid <= 0.5
  CONDITION: spade_len > 3.5
  CONDITION: last_bid_strain != 'NT'
  CONDITION: partner_last_call != '1S'
  CONDITION: h_is_best_major <= 0.5
  CONDITION: hcp <= 4.5
  CONDITION: s_has_king <= 0.5
  CONDITION: singleton_count > 0.5
  CONDITION: club_hcp > 1.5
  # distilled from Brill /bid

RULE BD_False_P144:
  CALL: 2S
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid <= 0.5
  CONDITION: spade_len > 3.5
  CONDITION: last_bid_strain != 'NT'
  CONDITION: partner_last_call != '1S'
  CONDITION: h_is_best_major <= 0.5
  CONDITION: hcp <= 4.5
  CONDITION: s_has_king > 0.5
  CONDITION: hcp <= 3.5
  # distilled from Brill /bid

RULE BD_False_P145:
  CALL: 2H
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid <= 0.5
  CONDITION: spade_len > 3.5
  CONDITION: last_bid_strain != 'NT'
  CONDITION: partner_last_call != '1S'
  CONDITION: h_is_best_major <= 0.5
  CONDITION: hcp <= 4.5
  CONDITION: s_has_king > 0.5
  CONDITION: hcp > 3.5
  # distilled from Brill /bid

RULE BD_False_P146:
  CALL: 2H
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid <= 0.5
  CONDITION: spade_len > 3.5
  CONDITION: last_bid_strain != 'NT'
  CONDITION: partner_last_call != '1S'
  CONDITION: h_is_best_major <= 0.5
  CONDITION: hcp > 4.5
  CONDITION: hcp <= 18.5
  CONDITION: last_bid_strain == 'H'
  CONDITION: rule20_total <= 17.5
  # distilled from Brill /bid

RULE BD_False_P147:
  CALL: 1S
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid <= 0.5
  CONDITION: spade_len > 3.5
  CONDITION: last_bid_strain != 'NT'
  CONDITION: partner_last_call != '1S'
  CONDITION: h_is_best_major <= 0.5
  CONDITION: hcp > 4.5
  CONDITION: hcp <= 18.5
  CONDITION: last_bid_strain == 'H'
  CONDITION: rule20_total > 17.5
  # distilled from Brill /bid

RULE BD_False_P148:
  CALL: 1S
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid <= 0.5
  CONDITION: spade_len > 3.5
  CONDITION: last_bid_strain != 'NT'
  CONDITION: partner_last_call != '1S'
  CONDITION: h_is_best_major <= 0.5
  CONDITION: hcp > 4.5
  CONDITION: hcp <= 18.5
  CONDITION: last_bid_strain != 'H'
  CONDITION: d_is_longest <= 0.5
  # distilled from Brill /bid

RULE BD_False_P149:
  CALL: 1D
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid <= 0.5
  CONDITION: spade_len > 3.5
  CONDITION: last_bid_strain != 'NT'
  CONDITION: partner_last_call != '1S'
  CONDITION: h_is_best_major <= 0.5
  CONDITION: hcp > 4.5
  CONDITION: hcp <= 18.5
  CONDITION: last_bid_strain != 'H'
  CONDITION: d_is_longest > 0.5
  # distilled from Brill /bid

RULE BD_False_P150:
  CALL: 1D
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid <= 0.5
  CONDITION: spade_len > 3.5
  CONDITION: last_bid_strain != 'NT'
  CONDITION: partner_last_call != '1S'
  CONDITION: h_is_best_major <= 0.5
  CONDITION: hcp > 4.5
  CONDITION: hcp > 18.5
  CONDITION: heart_hcp <= 1.5
  CONDITION: auction_len <= 3.0
  # distilled from Brill /bid

RULE BD_False_P151:
  CALL: 2S
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid <= 0.5
  CONDITION: spade_len > 3.5
  CONDITION: last_bid_strain != 'NT'
  CONDITION: partner_last_call != '1S'
  CONDITION: h_is_best_major <= 0.5
  CONDITION: hcp > 4.5
  CONDITION: hcp > 18.5
  CONDITION: heart_hcp <= 1.5
  CONDITION: auction_len > 3.0
  # distilled from Brill /bid

RULE BD_False_P152:
  CALL: 2NT
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid <= 0.5
  CONDITION: spade_len > 3.5
  CONDITION: last_bid_strain != 'NT'
  CONDITION: partner_last_call != '1S'
  CONDITION: h_is_best_major <= 0.5
  CONDITION: hcp > 4.5
  CONDITION: hcp > 18.5
  CONDITION: heart_hcp > 1.5
  # distilled from Brill /bid

RULE BD_False_P153:
  CALL: 4D
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid <= 0.5
  CONDITION: spade_len > 3.5
  CONDITION: last_bid_strain != 'NT'
  CONDITION: partner_last_call != '1S'
  CONDITION: h_is_best_major > 0.5
  CONDITION: partner_last_call == '1H'
  CONDITION: diamond_len <= 3.5
  CONDITION: spade_hcp <= 3.5
  CONDITION: hcp <= 12.0
  # distilled from Brill /bid

RULE BD_False_P154:
  CALL: 2NT
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid <= 0.5
  CONDITION: spade_len > 3.5
  CONDITION: last_bid_strain != 'NT'
  CONDITION: partner_last_call != '1S'
  CONDITION: h_is_best_major > 0.5
  CONDITION: partner_last_call == '1H'
  CONDITION: diamond_len <= 3.5
  CONDITION: spade_hcp <= 3.5
  CONDITION: hcp > 12.0
  # distilled from Brill /bid

RULE BD_False_P155:
  CALL: 2H
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid <= 0.5
  CONDITION: spade_len > 3.5
  CONDITION: last_bid_strain != 'NT'
  CONDITION: partner_last_call != '1S'
  CONDITION: h_is_best_major > 0.5
  CONDITION: partner_last_call == '1H'
  CONDITION: diamond_len <= 3.5
  CONDITION: spade_hcp > 3.5
  # distilled from Brill /bid

RULE BD_False_P156:
  CALL: 3H
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid <= 0.5
  CONDITION: spade_len > 3.5
  CONDITION: last_bid_strain != 'NT'
  CONDITION: partner_last_call != '1S'
  CONDITION: h_is_best_major > 0.5
  CONDITION: partner_last_call == '1H'
  CONDITION: diamond_len > 3.5
  CONDITION: hcp <= 17.5
  # distilled from Brill /bid

RULE BD_False_P157:
  CALL: 4H
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid <= 0.5
  CONDITION: spade_len > 3.5
  CONDITION: last_bid_strain != 'NT'
  CONDITION: partner_last_call != '1S'
  CONDITION: h_is_best_major > 0.5
  CONDITION: partner_last_call == '1H'
  CONDITION: diamond_len > 3.5
  CONDITION: hcp > 17.5
  # distilled from Brill /bid

RULE BD_False_P158:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid <= 0.5
  CONDITION: spade_len > 3.5
  CONDITION: last_bid_strain != 'NT'
  CONDITION: partner_last_call != '1S'
  CONDITION: h_is_best_major > 0.5
  CONDITION: partner_last_call != '1H'
  CONDITION: hcp <= 5.5
  # distilled from Brill /bid

RULE BD_False_P159:
  CALL: 1H
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid <= 0.5
  CONDITION: spade_len > 3.5
  CONDITION: last_bid_strain != 'NT'
  CONDITION: partner_last_call != '1S'
  CONDITION: h_is_best_major > 0.5
  CONDITION: partner_last_call != '1H'
  CONDITION: hcp > 5.5
  CONDITION: diamond_len <= 3.5
  CONDITION: spade_len <= 4.5
  # distilled from Brill /bid

RULE BD_False_P160:
  CALL: 1S
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid <= 0.5
  CONDITION: spade_len > 3.5
  CONDITION: last_bid_strain != 'NT'
  CONDITION: partner_last_call != '1S'
  CONDITION: h_is_best_major > 0.5
  CONDITION: partner_last_call != '1H'
  CONDITION: hcp > 5.5
  CONDITION: diamond_len <= 3.5
  CONDITION: spade_len > 4.5
  # distilled from Brill /bid

RULE BD_False_P161:
  CALL: XX
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid <= 0.5
  CONDITION: spade_len > 3.5
  CONDITION: last_bid_strain != 'NT'
  CONDITION: partner_last_call != '1S'
  CONDITION: h_is_best_major > 0.5
  CONDITION: partner_last_call != '1H'
  CONDITION: hcp > 5.5
  CONDITION: diamond_len > 3.5
  CONDITION: major_hcp <= 5.5
  # distilled from Brill /bid

RULE BD_False_P162:
  CALL: 1D
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid <= 0.5
  CONDITION: spade_len > 3.5
  CONDITION: last_bid_strain != 'NT'
  CONDITION: partner_last_call != '1S'
  CONDITION: h_is_best_major > 0.5
  CONDITION: partner_last_call != '1H'
  CONDITION: hcp > 5.5
  CONDITION: diamond_len > 3.5
  CONDITION: major_hcp > 5.5
  # distilled from Brill /bid

RULE BD_False_P163:
  CALL: 2H
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid > 0.5
  CONDITION: rule20_total <= 17.5
  CONDITION: my_side_bid_count <= 0.5
  CONDITION: partner_last_call == 'X'
  CONDITION: spade_len <= 3.5
  CONDITION: c_is_best_minor <= 0.5
  CONDITION: club_len <= 1.5
  # distilled from Brill /bid

RULE BD_False_P164:
  CALL: 1H
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid > 0.5
  CONDITION: rule20_total <= 17.5
  CONDITION: my_side_bid_count <= 0.5
  CONDITION: partner_last_call == 'X'
  CONDITION: spade_len <= 3.5
  CONDITION: c_is_best_minor <= 0.5
  CONDITION: club_len > 1.5
  CONDITION: opp_suit_stoppers <= 0.25
  CONDITION: minor_hcp <= 3.0
  # distilled from Brill /bid

RULE BD_False_P165:
  CALL: 2D
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid > 0.5
  CONDITION: rule20_total <= 17.5
  CONDITION: my_side_bid_count <= 0.5
  CONDITION: partner_last_call == 'X'
  CONDITION: spade_len <= 3.5
  CONDITION: c_is_best_minor <= 0.5
  CONDITION: club_len > 1.5
  CONDITION: opp_suit_stoppers <= 0.25
  CONDITION: minor_hcp > 3.0
  # distilled from Brill /bid

RULE BD_False_P166:
  CALL: 2D
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid > 0.5
  CONDITION: rule20_total <= 17.5
  CONDITION: my_side_bid_count <= 0.5
  CONDITION: partner_last_call == 'X'
  CONDITION: spade_len <= 3.5
  CONDITION: c_is_best_minor <= 0.5
  CONDITION: club_len > 1.5
  CONDITION: opp_suit_stoppers > 0.25
  CONDITION: my_seat == 'W'
  # distilled from Brill /bid

RULE BD_False_P167:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid > 0.5
  CONDITION: rule20_total <= 17.5
  CONDITION: my_side_bid_count <= 0.5
  CONDITION: partner_last_call == 'X'
  CONDITION: spade_len <= 3.5
  CONDITION: c_is_best_minor <= 0.5
  CONDITION: club_len > 1.5
  CONDITION: opp_suit_stoppers > 0.25
  CONDITION: my_seat != 'W'
  # distilled from Brill /bid

RULE BD_False_P168:
  CALL: 2H
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid > 0.5
  CONDITION: rule20_total <= 17.5
  CONDITION: my_side_bid_count <= 0.5
  CONDITION: partner_last_call == 'X'
  CONDITION: spade_len <= 3.5
  CONDITION: c_is_best_minor > 0.5
  CONDITION: s_top2_honors <= 0.5
  CONDITION: passes_since_last_bid <= 0.5
  CONDITION: vuln_pressure == 'equal'
  # distilled from Brill /bid

RULE BD_False_P169:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid > 0.5
  CONDITION: rule20_total <= 17.5
  CONDITION: my_side_bid_count <= 0.5
  CONDITION: partner_last_call == 'X'
  CONDITION: spade_len <= 3.5
  CONDITION: c_is_best_minor > 0.5
  CONDITION: s_top2_honors <= 0.5
  CONDITION: passes_since_last_bid <= 0.5
  CONDITION: vuln_pressure != 'equal'
  # distilled from Brill /bid

RULE BD_False_P170:
  CALL: 2C
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid > 0.5
  CONDITION: rule20_total <= 17.5
  CONDITION: my_side_bid_count <= 0.5
  CONDITION: partner_last_call == 'X'
  CONDITION: spade_len <= 3.5
  CONDITION: c_is_best_minor > 0.5
  CONDITION: s_top2_honors <= 0.5
  CONDITION: passes_since_last_bid > 0.5
  CONDITION: controls <= 1.5
  # distilled from Brill /bid

RULE BD_False_P171:
  CALL: 1NT
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid > 0.5
  CONDITION: rule20_total <= 17.5
  CONDITION: my_side_bid_count <= 0.5
  CONDITION: partner_last_call == 'X'
  CONDITION: spade_len <= 3.5
  CONDITION: c_is_best_minor > 0.5
  CONDITION: s_top2_honors <= 0.5
  CONDITION: passes_since_last_bid > 0.5
  CONDITION: controls > 1.5
  # distilled from Brill /bid

RULE BD_False_P172:
  CALL: 1H
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid > 0.5
  CONDITION: rule20_total <= 17.5
  CONDITION: my_side_bid_count <= 0.5
  CONDITION: partner_last_call == 'X'
  CONDITION: spade_len <= 3.5
  CONDITION: c_is_best_minor > 0.5
  CONDITION: s_top2_honors > 0.5
  CONDITION: hcp <= 8.0
  # distilled from Brill /bid

RULE BD_False_P173:
  CALL: 2C
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid > 0.5
  CONDITION: rule20_total <= 17.5
  CONDITION: my_side_bid_count <= 0.5
  CONDITION: partner_last_call == 'X'
  CONDITION: spade_len <= 3.5
  CONDITION: c_is_best_minor > 0.5
  CONDITION: s_top2_honors > 0.5
  CONDITION: hcp > 8.0
  # distilled from Brill /bid

RULE BD_False_P174:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid > 0.5
  CONDITION: rule20_total <= 17.5
  CONDITION: my_side_bid_count <= 0.5
  CONDITION: partner_last_call == 'X'
  CONDITION: spade_len > 3.5
  CONDITION: heart_hcp <= 1.5
  CONDITION: club_hcp <= 2.0
  CONDITION: h_is_longest <= 0.5
  # distilled from Brill /bid

RULE BD_False_P175:
  CALL: 2S
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid > 0.5
  CONDITION: rule20_total <= 17.5
  CONDITION: my_side_bid_count <= 0.5
  CONDITION: partner_last_call == 'X'
  CONDITION: spade_len > 3.5
  CONDITION: heart_hcp <= 1.5
  CONDITION: club_hcp <= 2.0
  CONDITION: h_is_longest > 0.5
  CONDITION: hcp <= 5.0
  # distilled from Brill /bid

RULE BD_False_P176:
  CALL: 1H
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid > 0.5
  CONDITION: rule20_total <= 17.5
  CONDITION: my_side_bid_count <= 0.5
  CONDITION: partner_last_call == 'X'
  CONDITION: spade_len > 3.5
  CONDITION: heart_hcp <= 1.5
  CONDITION: club_hcp <= 2.0
  CONDITION: h_is_longest > 0.5
  CONDITION: hcp > 5.0
  # distilled from Brill /bid

RULE BD_False_P177:
  CALL: 1S
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid > 0.5
  CONDITION: rule20_total <= 17.5
  CONDITION: my_side_bid_count <= 0.5
  CONDITION: partner_last_call == 'X'
  CONDITION: spade_len > 3.5
  CONDITION: heart_hcp <= 1.5
  CONDITION: club_hcp > 2.0
  # distilled from Brill /bid

RULE BD_False_P178:
  CALL: 1S
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid > 0.5
  CONDITION: rule20_total <= 17.5
  CONDITION: my_side_bid_count <= 0.5
  CONDITION: partner_last_call == 'X'
  CONDITION: spade_len > 3.5
  CONDITION: heart_hcp > 1.5
  CONDITION: major_hcp <= 5.0
  CONDITION: s_has_ten <= 0.5
  # distilled from Brill /bid

RULE BD_False_P179:
  CALL: 1NT
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid > 0.5
  CONDITION: rule20_total <= 17.5
  CONDITION: my_side_bid_count <= 0.5
  CONDITION: partner_last_call == 'X'
  CONDITION: spade_len > 3.5
  CONDITION: heart_hcp > 1.5
  CONDITION: major_hcp <= 5.0
  CONDITION: s_has_ten > 0.5
  CONDITION: hcp <= 5.5
  # distilled from Brill /bid

RULE BD_False_P180:
  CALL: 2D
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid > 0.5
  CONDITION: rule20_total <= 17.5
  CONDITION: my_side_bid_count <= 0.5
  CONDITION: partner_last_call == 'X'
  CONDITION: spade_len > 3.5
  CONDITION: heart_hcp > 1.5
  CONDITION: major_hcp <= 5.0
  CONDITION: s_has_ten > 0.5
  CONDITION: hcp > 5.5
  # distilled from Brill /bid

RULE BD_False_P181:
  CALL: 2S
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid > 0.5
  CONDITION: rule20_total <= 17.5
  CONDITION: my_side_bid_count <= 0.5
  CONDITION: partner_last_call == 'X'
  CONDITION: spade_len > 3.5
  CONDITION: heart_hcp > 1.5
  CONDITION: major_hcp > 5.0
  CONDITION: major_hcp <= 7.5
  # distilled from Brill /bid

RULE BD_False_P182:
  CALL: 2D
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid > 0.5
  CONDITION: rule20_total <= 17.5
  CONDITION: my_side_bid_count <= 0.5
  CONDITION: partner_last_call == 'X'
  CONDITION: spade_len > 3.5
  CONDITION: heart_hcp > 1.5
  CONDITION: major_hcp > 5.0
  CONDITION: major_hcp > 7.5
  # distilled from Brill /bid

RULE BD_False_P183:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid > 0.5
  CONDITION: rule20_total <= 17.5
  CONDITION: my_side_bid_count <= 0.5
  CONDITION: partner_last_call != 'X'
  CONDITION: spade_len <= 4.5
  CONDITION: heart_len <= 4.5
  CONDITION: diamond_hcp <= 4.5
  CONDITION: third_longest_len <= 3.5
  CONDITION: hcp <= 9.5
  # distilled from Brill /bid

RULE BD_False_P184:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid > 0.5
  CONDITION: rule20_total <= 17.5
  CONDITION: my_side_bid_count <= 0.5
  CONDITION: partner_last_call != 'X'
  CONDITION: spade_len <= 4.5
  CONDITION: heart_len <= 4.5
  CONDITION: diamond_hcp <= 4.5
  CONDITION: third_longest_len <= 3.5
  CONDITION: hcp > 9.5
  # distilled from Brill /bid

RULE BD_False_P185:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid > 0.5
  CONDITION: rule20_total <= 17.5
  CONDITION: my_side_bid_count <= 0.5
  CONDITION: partner_last_call != 'X'
  CONDITION: spade_len <= 4.5
  CONDITION: heart_len <= 4.5
  CONDITION: diamond_hcp <= 4.5
  CONDITION: third_longest_len > 3.5
  CONDITION: rule20_total <= 16.5
  # distilled from Brill /bid

RULE BD_False_P186:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid > 0.5
  CONDITION: rule20_total <= 17.5
  CONDITION: my_side_bid_count <= 0.5
  CONDITION: partner_last_call != 'X'
  CONDITION: spade_len <= 4.5
  CONDITION: heart_len <= 4.5
  CONDITION: diamond_hcp <= 4.5
  CONDITION: third_longest_len > 3.5
  CONDITION: rule20_total > 16.5
  # distilled from Brill /bid

RULE BD_False_P187:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid > 0.5
  CONDITION: rule20_total <= 17.5
  CONDITION: my_side_bid_count <= 0.5
  CONDITION: partner_last_call != 'X'
  CONDITION: spade_len <= 4.5
  CONDITION: heart_len <= 4.5
  CONDITION: diamond_hcp > 4.5
  CONDITION: last_bid_strain == 'C'
  CONDITION: diamond_len <= 4.5
  # distilled from Brill /bid

RULE BD_False_P188:
  CALL: 1D
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid > 0.5
  CONDITION: rule20_total <= 17.5
  CONDITION: my_side_bid_count <= 0.5
  CONDITION: partner_last_call != 'X'
  CONDITION: spade_len <= 4.5
  CONDITION: heart_len <= 4.5
  CONDITION: diamond_hcp > 4.5
  CONDITION: last_bid_strain == 'C'
  CONDITION: diamond_len > 4.5
  # distilled from Brill /bid

RULE BD_False_P189:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid > 0.5
  CONDITION: rule20_total <= 17.5
  CONDITION: my_side_bid_count <= 0.5
  CONDITION: partner_last_call != 'X'
  CONDITION: spade_len <= 4.5
  CONDITION: heart_len <= 4.5
  CONDITION: diamond_hcp > 4.5
  CONDITION: last_bid_strain != 'C'
  # distilled from Brill /bid

RULE BD_False_P190:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid > 0.5
  CONDITION: rule20_total <= 17.5
  CONDITION: my_side_bid_count <= 0.5
  CONDITION: partner_last_call != 'X'
  CONDITION: spade_len <= 4.5
  CONDITION: heart_len > 4.5
  CONDITION: heart_len <= 5.5
  CONDITION: hcp <= 7.5
  # distilled from Brill /bid

RULE BD_False_P191:
  CALL: 1H
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid > 0.5
  CONDITION: rule20_total <= 17.5
  CONDITION: my_side_bid_count <= 0.5
  CONDITION: partner_last_call != 'X'
  CONDITION: spade_len <= 4.5
  CONDITION: heart_len > 4.5
  CONDITION: heart_len <= 5.5
  CONDITION: hcp > 7.5
  CONDITION: last_bid_strain == 'D'
  # distilled from Brill /bid

RULE BD_False_P192:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid > 0.5
  CONDITION: rule20_total <= 17.5
  CONDITION: my_side_bid_count <= 0.5
  CONDITION: partner_last_call != 'X'
  CONDITION: spade_len <= 4.5
  CONDITION: heart_len > 4.5
  CONDITION: heart_len <= 5.5
  CONDITION: hcp > 7.5
  CONDITION: last_bid_strain != 'D'
  # distilled from Brill /bid

RULE BD_False_P193:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid > 0.5
  CONDITION: rule20_total <= 17.5
  CONDITION: my_side_bid_count <= 0.5
  CONDITION: partner_last_call != 'X'
  CONDITION: spade_len <= 4.5
  CONDITION: heart_len > 4.5
  CONDITION: heart_len > 5.5
  CONDITION: last_bid_strain == 'D'
  CONDITION: hcp <= 5.0
  # distilled from Brill /bid

RULE BD_False_P194:
  CALL: 2H
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid > 0.5
  CONDITION: rule20_total <= 17.5
  CONDITION: my_side_bid_count <= 0.5
  CONDITION: partner_last_call != 'X'
  CONDITION: spade_len <= 4.5
  CONDITION: heart_len > 4.5
  CONDITION: heart_len > 5.5
  CONDITION: last_bid_strain == 'D'
  CONDITION: hcp > 5.0
  # distilled from Brill /bid

RULE BD_False_P195:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid > 0.5
  CONDITION: rule20_total <= 17.5
  CONDITION: my_side_bid_count <= 0.5
  CONDITION: partner_last_call != 'X'
  CONDITION: spade_len <= 4.5
  CONDITION: heart_len > 4.5
  CONDITION: heart_len > 5.5
  CONDITION: last_bid_strain != 'D'
  CONDITION: last_bid_strain == 'C'
  # distilled from Brill /bid

RULE BD_False_P196:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid > 0.5
  CONDITION: rule20_total <= 17.5
  CONDITION: my_side_bid_count <= 0.5
  CONDITION: partner_last_call != 'X'
  CONDITION: spade_len <= 4.5
  CONDITION: heart_len > 4.5
  CONDITION: heart_len > 5.5
  CONDITION: last_bid_strain != 'D'
  CONDITION: last_bid_strain != 'C'
  # distilled from Brill /bid

RULE BD_False_P197:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid > 0.5
  CONDITION: rule20_total <= 17.5
  CONDITION: my_side_bid_count <= 0.5
  CONDITION: partner_last_call != 'X'
  CONDITION: spade_len > 4.5
  CONDITION: hcp <= 7.5
  CONDITION: losing_trick_count <= 7.5
  CONDITION: heart_len <= 5.5
  CONDITION: heart_len <= 3.0
  # distilled from Brill /bid

RULE BD_False_P198:
  CALL: 2S
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid > 0.5
  CONDITION: rule20_total <= 17.5
  CONDITION: my_side_bid_count <= 0.5
  CONDITION: partner_last_call != 'X'
  CONDITION: spade_len > 4.5
  CONDITION: hcp <= 7.5
  CONDITION: losing_trick_count <= 7.5
  CONDITION: heart_len <= 5.5
  CONDITION: heart_len > 3.0
  # distilled from Brill /bid

RULE BD_False_P199:
  CALL: 3H
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid > 0.5
  CONDITION: rule20_total <= 17.5
  CONDITION: my_side_bid_count <= 0.5
  CONDITION: partner_last_call != 'X'
  CONDITION: spade_len > 4.5
  CONDITION: hcp <= 7.5
  CONDITION: losing_trick_count <= 7.5
  CONDITION: heart_len > 5.5
  CONDITION: major_hcp <= 4.5
  # distilled from Brill /bid

RULE BD_False_P200:
  CALL: 2D
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid > 0.5
  CONDITION: rule20_total <= 17.5
  CONDITION: my_side_bid_count <= 0.5
  CONDITION: partner_last_call != 'X'
  CONDITION: spade_len > 4.5
  CONDITION: hcp <= 7.5
  CONDITION: losing_trick_count <= 7.5
  CONDITION: heart_len > 5.5
  CONDITION: major_hcp > 4.5
  # distilled from Brill /bid

RULE BD_False_P201:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid > 0.5
  CONDITION: rule20_total <= 17.5
  CONDITION: my_side_bid_count <= 0.5
  CONDITION: partner_last_call != 'X'
  CONDITION: spade_len > 4.5
  CONDITION: hcp <= 7.5
  CONDITION: losing_trick_count > 7.5
  CONDITION: spade_len <= 5.5
  # distilled from Brill /bid

RULE BD_False_P202:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid > 0.5
  CONDITION: rule20_total <= 17.5
  CONDITION: my_side_bid_count <= 0.5
  CONDITION: partner_last_call != 'X'
  CONDITION: spade_len > 4.5
  CONDITION: hcp <= 7.5
  CONDITION: losing_trick_count > 7.5
  CONDITION: spade_len > 5.5
  CONDITION: hcp <= 5.5
  # distilled from Brill /bid

RULE BD_False_P203:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid > 0.5
  CONDITION: rule20_total <= 17.5
  CONDITION: my_side_bid_count <= 0.5
  CONDITION: partner_last_call != 'X'
  CONDITION: spade_len > 4.5
  CONDITION: hcp <= 7.5
  CONDITION: losing_trick_count > 7.5
  CONDITION: spade_len > 5.5
  CONDITION: hcp > 5.5
  # distilled from Brill /bid

RULE BD_False_P204:
  CALL: 1S
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid > 0.5
  CONDITION: rule20_total <= 17.5
  CONDITION: my_side_bid_count <= 0.5
  CONDITION: partner_last_call != 'X'
  CONDITION: spade_len > 4.5
  CONDITION: hcp > 7.5
  CONDITION: opp_suit_stoppers <= 0.25
  CONDITION: major_hcp <= 5.5
  # distilled from Brill /bid

RULE BD_False_P205:
  CALL: 3S
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid > 0.5
  CONDITION: rule20_total <= 17.5
  CONDITION: my_side_bid_count <= 0.5
  CONDITION: partner_last_call != 'X'
  CONDITION: spade_len > 4.5
  CONDITION: hcp > 7.5
  CONDITION: opp_suit_stoppers <= 0.25
  CONDITION: major_hcp > 5.5
  CONDITION: major_hcp <= 6.5
  # distilled from Brill /bid

RULE BD_False_P206:
  CALL: 2S
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid > 0.5
  CONDITION: rule20_total <= 17.5
  CONDITION: my_side_bid_count <= 0.5
  CONDITION: partner_last_call != 'X'
  CONDITION: spade_len > 4.5
  CONDITION: hcp > 7.5
  CONDITION: opp_suit_stoppers <= 0.25
  CONDITION: major_hcp > 5.5
  CONDITION: major_hcp > 6.5
  # distilled from Brill /bid

RULE BD_False_P207:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid > 0.5
  CONDITION: rule20_total <= 17.5
  CONDITION: my_side_bid_count <= 0.5
  CONDITION: partner_last_call != 'X'
  CONDITION: spade_len > 4.5
  CONDITION: hcp > 7.5
  CONDITION: opp_suit_stoppers > 0.25
  CONDITION: queen_count <= 0.5
  CONDITION: spade_hcp <= 2.0
  # distilled from Brill /bid

RULE BD_False_P208:
  CALL: 1S
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid > 0.5
  CONDITION: rule20_total <= 17.5
  CONDITION: my_side_bid_count <= 0.5
  CONDITION: partner_last_call != 'X'
  CONDITION: spade_len > 4.5
  CONDITION: hcp > 7.5
  CONDITION: opp_suit_stoppers > 0.25
  CONDITION: queen_count <= 0.5
  CONDITION: spade_hcp > 2.0
  # distilled from Brill /bid

RULE BD_False_P209:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid > 0.5
  CONDITION: rule20_total <= 17.5
  CONDITION: my_side_bid_count <= 0.5
  CONDITION: partner_last_call != 'X'
  CONDITION: spade_len > 4.5
  CONDITION: hcp > 7.5
  CONDITION: opp_suit_stoppers > 0.25
  CONDITION: queen_count > 0.5
  # distilled from Brill /bid

RULE BD_False_P210:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid > 0.5
  CONDITION: rule20_total <= 17.5
  CONDITION: my_side_bid_count > 0.5
  CONDITION: last_bid_strain == 'NT'
  CONDITION: partner_last_bid_strain == 'NONE'
  CONDITION: spade_len <= 4.5
  CONDITION: controls <= 2.5
  CONDITION: s_is_best_major <= 0.5
  CONDITION: longest_suit_len <= 4.5
  # distilled from Brill /bid

RULE BD_False_P211:
  CALL: 2D
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid > 0.5
  CONDITION: rule20_total <= 17.5
  CONDITION: my_side_bid_count > 0.5
  CONDITION: last_bid_strain == 'NT'
  CONDITION: partner_last_bid_strain == 'NONE'
  CONDITION: spade_len <= 4.5
  CONDITION: controls <= 2.5
  CONDITION: s_is_best_major <= 0.5
  CONDITION: longest_suit_len > 4.5
  # distilled from Brill /bid

RULE BD_False_P212:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid > 0.5
  CONDITION: rule20_total <= 17.5
  CONDITION: my_side_bid_count > 0.5
  CONDITION: last_bid_strain == 'NT'
  CONDITION: partner_last_bid_strain == 'NONE'
  CONDITION: spade_len <= 4.5
  CONDITION: controls <= 2.5
  CONDITION: s_is_best_major > 0.5
  CONDITION: club_len <= 5.5
  # distilled from Brill /bid

RULE BD_False_P213:
  CALL: 2NT
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid > 0.5
  CONDITION: rule20_total <= 17.5
  CONDITION: my_side_bid_count > 0.5
  CONDITION: last_bid_strain == 'NT'
  CONDITION: partner_last_bid_strain == 'NONE'
  CONDITION: spade_len <= 4.5
  CONDITION: controls <= 2.5
  CONDITION: s_is_best_major > 0.5
  CONDITION: club_len > 5.5
  # distilled from Brill /bid

RULE BD_False_P214:
  CALL: 2C
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid > 0.5
  CONDITION: rule20_total <= 17.5
  CONDITION: my_side_bid_count > 0.5
  CONDITION: last_bid_strain == 'NT'
  CONDITION: partner_last_bid_strain == 'NONE'
  CONDITION: spade_len <= 4.5
  CONDITION: controls > 2.5
  CONDITION: diamond_len <= 4.5
  # distilled from Brill /bid

RULE BD_False_P215:
  CALL: XX
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid > 0.5
  CONDITION: rule20_total <= 17.5
  CONDITION: my_side_bid_count > 0.5
  CONDITION: last_bid_strain == 'NT'
  CONDITION: partner_last_bid_strain == 'NONE'
  CONDITION: spade_len <= 4.5
  CONDITION: controls > 2.5
  CONDITION: diamond_len > 4.5
  CONDITION: hcp <= 7.5
  # distilled from Brill /bid

RULE BD_False_P216:
  CALL: 3S
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid > 0.5
  CONDITION: rule20_total <= 17.5
  CONDITION: my_side_bid_count > 0.5
  CONDITION: last_bid_strain == 'NT'
  CONDITION: partner_last_bid_strain == 'NONE'
  CONDITION: spade_len <= 4.5
  CONDITION: controls > 2.5
  CONDITION: diamond_len > 4.5
  CONDITION: hcp > 7.5
  # distilled from Brill /bid

RULE BD_False_P217:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid > 0.5
  CONDITION: rule20_total <= 17.5
  CONDITION: my_side_bid_count > 0.5
  CONDITION: last_bid_strain == 'NT'
  CONDITION: partner_last_bid_strain == 'NONE'
  CONDITION: spade_len > 4.5
  CONDITION: partner_opened <= 0.5
  # distilled from Brill /bid

RULE BD_False_P218:
  CALL: XX
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid > 0.5
  CONDITION: rule20_total <= 17.5
  CONDITION: my_side_bid_count > 0.5
  CONDITION: last_bid_strain == 'NT'
  CONDITION: partner_last_bid_strain == 'NONE'
  CONDITION: spade_len > 4.5
  CONDITION: partner_opened > 0.5
  CONDITION: heart_len <= 1.5
  # distilled from Brill /bid

RULE BD_False_P219:
  CALL: 2H
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid > 0.5
  CONDITION: rule20_total <= 17.5
  CONDITION: my_side_bid_count > 0.5
  CONDITION: last_bid_strain == 'NT'
  CONDITION: partner_last_bid_strain == 'NONE'
  CONDITION: spade_len > 4.5
  CONDITION: partner_opened > 0.5
  CONDITION: heart_len > 1.5
  # distilled from Brill /bid

RULE BD_False_P220:
  CALL: 2C
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid > 0.5
  CONDITION: rule20_total <= 17.5
  CONDITION: my_side_bid_count > 0.5
  CONDITION: last_bid_strain == 'NT'
  CONDITION: partner_last_bid_strain != 'NONE'
  CONDITION: partner_last_call == 'X'
  # distilled from Brill /bid

RULE BD_False_P221:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid > 0.5
  CONDITION: rule20_total <= 17.5
  CONDITION: my_side_bid_count > 0.5
  CONDITION: last_bid_strain == 'NT'
  CONDITION: partner_last_bid_strain != 'NONE'
  CONDITION: partner_last_call != 'X'
  CONDITION: doubleton_count <= 0.5
  CONDITION: major_hcp <= 5.5
  CONDITION: competition_level <= 3.5
  # distilled from Brill /bid

RULE BD_False_P222:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid > 0.5
  CONDITION: rule20_total <= 17.5
  CONDITION: my_side_bid_count > 0.5
  CONDITION: last_bid_strain == 'NT'
  CONDITION: partner_last_bid_strain != 'NONE'
  CONDITION: partner_last_call != 'X'
  CONDITION: doubleton_count <= 0.5
  CONDITION: major_hcp <= 5.5
  CONDITION: competition_level > 3.5
  # distilled from Brill /bid

RULE BD_False_P223:
  CALL: 4H
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid > 0.5
  CONDITION: rule20_total <= 17.5
  CONDITION: my_side_bid_count > 0.5
  CONDITION: last_bid_strain == 'NT'
  CONDITION: partner_last_bid_strain != 'NONE'
  CONDITION: partner_last_call != 'X'
  CONDITION: doubleton_count <= 0.5
  CONDITION: major_hcp > 5.5
  CONDITION: hcp <= 9.0
  # distilled from Brill /bid

RULE BD_False_P224:
  CALL: X
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid > 0.5
  CONDITION: rule20_total <= 17.5
  CONDITION: my_side_bid_count > 0.5
  CONDITION: last_bid_strain == 'NT'
  CONDITION: partner_last_bid_strain != 'NONE'
  CONDITION: partner_last_call != 'X'
  CONDITION: doubleton_count <= 0.5
  CONDITION: major_hcp > 5.5
  CONDITION: hcp > 9.0
  # distilled from Brill /bid

RULE BD_False_P225:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid > 0.5
  CONDITION: rule20_total <= 17.5
  CONDITION: my_side_bid_count > 0.5
  CONDITION: last_bid_strain == 'NT'
  CONDITION: partner_last_bid_strain != 'NONE'
  CONDITION: partner_last_call != 'X'
  CONDITION: doubleton_count > 0.5
  CONDITION: is_equal_non_vuln <= 0.5
  CONDITION: partner_last_call == '1S'
  # distilled from Brill /bid

RULE BD_False_P226:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid > 0.5
  CONDITION: rule20_total <= 17.5
  CONDITION: my_side_bid_count > 0.5
  CONDITION: last_bid_strain == 'NT'
  CONDITION: partner_last_bid_strain != 'NONE'
  CONDITION: partner_last_call != 'X'
  CONDITION: doubleton_count > 0.5
  CONDITION: is_equal_non_vuln <= 0.5
  CONDITION: partner_last_call != '1S'
  # distilled from Brill /bid

RULE BD_False_P227:
  CALL: 2S
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid > 0.5
  CONDITION: rule20_total <= 17.5
  CONDITION: my_side_bid_count > 0.5
  CONDITION: last_bid_strain == 'NT'
  CONDITION: partner_last_bid_strain != 'NONE'
  CONDITION: partner_last_call != 'X'
  CONDITION: doubleton_count > 0.5
  CONDITION: is_equal_non_vuln > 0.5
  CONDITION: hcp <= 5.5
  # distilled from Brill /bid

RULE BD_False_P228:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid > 0.5
  CONDITION: rule20_total <= 17.5
  CONDITION: my_side_bid_count > 0.5
  CONDITION: last_bid_strain == 'NT'
  CONDITION: partner_last_bid_strain != 'NONE'
  CONDITION: partner_last_call != 'X'
  CONDITION: doubleton_count > 0.5
  CONDITION: is_equal_non_vuln > 0.5
  CONDITION: hcp > 5.5
  # distilled from Brill /bid

RULE BD_False_P229:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid > 0.5
  CONDITION: rule20_total <= 17.5
  CONDITION: my_side_bid_count > 0.5
  CONDITION: last_bid_strain != 'NT'
  CONDITION: hcp <= 6.5
  CONDITION: support_in_partner_suit <= 3.5
  CONDITION: spade_len <= 4.5
  CONDITION: heart_len <= 3.5
  CONDITION: controls <= 1.5
  # distilled from Brill /bid

RULE BD_False_P230:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid > 0.5
  CONDITION: rule20_total <= 17.5
  CONDITION: my_side_bid_count > 0.5
  CONDITION: last_bid_strain != 'NT'
  CONDITION: hcp <= 6.5
  CONDITION: support_in_partner_suit <= 3.5
  CONDITION: spade_len <= 4.5
  CONDITION: heart_len <= 3.5
  CONDITION: controls > 1.5
  # distilled from Brill /bid

RULE BD_False_P231:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid > 0.5
  CONDITION: rule20_total <= 17.5
  CONDITION: my_side_bid_count > 0.5
  CONDITION: last_bid_strain != 'NT'
  CONDITION: hcp <= 6.5
  CONDITION: support_in_partner_suit <= 3.5
  CONDITION: spade_len <= 4.5
  CONDITION: heart_len > 3.5
  CONDITION: total_points <= 5.5
  # distilled from Brill /bid

RULE BD_False_P232:
  CALL: X
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid > 0.5
  CONDITION: rule20_total <= 17.5
  CONDITION: my_side_bid_count > 0.5
  CONDITION: last_bid_strain != 'NT'
  CONDITION: hcp <= 6.5
  CONDITION: support_in_partner_suit <= 3.5
  CONDITION: spade_len <= 4.5
  CONDITION: heart_len > 3.5
  CONDITION: total_points > 5.5
  # distilled from Brill /bid

RULE BD_False_P233:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid > 0.5
  CONDITION: rule20_total <= 17.5
  CONDITION: my_side_bid_count > 0.5
  CONDITION: last_bid_strain != 'NT'
  CONDITION: hcp <= 6.5
  CONDITION: support_in_partner_suit <= 3.5
  CONDITION: spade_len > 4.5
  CONDITION: partner_last_bid_strain == 'H'
  CONDITION: auction_len <= 5.5
  # distilled from Brill /bid

RULE BD_False_P234:
  CALL: 2H
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid > 0.5
  CONDITION: rule20_total <= 17.5
  CONDITION: my_side_bid_count > 0.5
  CONDITION: last_bid_strain != 'NT'
  CONDITION: hcp <= 6.5
  CONDITION: support_in_partner_suit <= 3.5
  CONDITION: spade_len > 4.5
  CONDITION: partner_last_bid_strain == 'H'
  CONDITION: auction_len > 5.5
  # distilled from Brill /bid

RULE BD_False_P235:
  CALL: 1S
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid > 0.5
  CONDITION: rule20_total <= 17.5
  CONDITION: my_side_bid_count > 0.5
  CONDITION: last_bid_strain != 'NT'
  CONDITION: hcp <= 6.5
  CONDITION: support_in_partner_suit <= 3.5
  CONDITION: spade_len > 4.5
  CONDITION: partner_last_bid_strain != 'H'
  CONDITION: opp_suit_stoppers <= 0.25
  # distilled from Brill /bid

RULE BD_False_P236:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid > 0.5
  CONDITION: rule20_total <= 17.5
  CONDITION: my_side_bid_count > 0.5
  CONDITION: last_bid_strain != 'NT'
  CONDITION: hcp <= 6.5
  CONDITION: support_in_partner_suit <= 3.5
  CONDITION: spade_len > 4.5
  CONDITION: partner_last_bid_strain != 'H'
  CONDITION: opp_suit_stoppers > 0.25
  # distilled from Brill /bid

RULE BD_False_P237:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid > 0.5
  CONDITION: rule20_total <= 17.5
  CONDITION: my_side_bid_count > 0.5
  CONDITION: last_bid_strain != 'NT'
  CONDITION: hcp <= 6.5
  CONDITION: support_in_partner_suit > 3.5
  CONDITION: heart_hcp <= 1.5
  CONDITION: club_hcp <= 3.5
  CONDITION: hcp <= 5.5
  # distilled from Brill /bid

RULE BD_False_P238:
  CALL: 2C
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid > 0.5
  CONDITION: rule20_total <= 17.5
  CONDITION: my_side_bid_count > 0.5
  CONDITION: last_bid_strain != 'NT'
  CONDITION: hcp <= 6.5
  CONDITION: support_in_partner_suit > 3.5
  CONDITION: heart_hcp <= 1.5
  CONDITION: club_hcp <= 3.5
  CONDITION: hcp > 5.5
  # distilled from Brill /bid

RULE BD_False_P239:
  CALL: 1H
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid > 0.5
  CONDITION: rule20_total <= 17.5
  CONDITION: my_side_bid_count > 0.5
  CONDITION: last_bid_strain != 'NT'
  CONDITION: hcp <= 6.5
  CONDITION: support_in_partner_suit > 3.5
  CONDITION: heart_hcp <= 1.5
  CONDITION: club_hcp > 3.5
  CONDITION: diamond_len <= 2.0
  # distilled from Brill /bid

RULE BD_False_P240:
  CALL: 3C
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid > 0.5
  CONDITION: rule20_total <= 17.5
  CONDITION: my_side_bid_count > 0.5
  CONDITION: last_bid_strain != 'NT'
  CONDITION: hcp <= 6.5
  CONDITION: support_in_partner_suit > 3.5
  CONDITION: heart_hcp <= 1.5
  CONDITION: club_hcp > 3.5
  CONDITION: diamond_len > 2.0
  # distilled from Brill /bid

RULE BD_False_P241:
  CALL: 3D
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid > 0.5
  CONDITION: rule20_total <= 17.5
  CONDITION: my_side_bid_count > 0.5
  CONDITION: last_bid_strain != 'NT'
  CONDITION: hcp <= 6.5
  CONDITION: support_in_partner_suit > 3.5
  CONDITION: heart_hcp > 1.5
  CONDITION: hcp <= 5.5
  CONDITION: spade_hcp <= 1.0
  # distilled from Brill /bid

RULE BD_False_P242:
  CALL: 1S
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid > 0.5
  CONDITION: rule20_total <= 17.5
  CONDITION: my_side_bid_count > 0.5
  CONDITION: last_bid_strain != 'NT'
  CONDITION: hcp <= 6.5
  CONDITION: support_in_partner_suit > 3.5
  CONDITION: heart_hcp > 1.5
  CONDITION: hcp <= 5.5
  CONDITION: spade_hcp > 1.0
  # distilled from Brill /bid

RULE BD_False_P243:
  CALL: 2C
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid > 0.5
  CONDITION: rule20_total <= 17.5
  CONDITION: my_side_bid_count > 0.5
  CONDITION: last_bid_strain != 'NT'
  CONDITION: hcp <= 6.5
  CONDITION: support_in_partner_suit > 3.5
  CONDITION: heart_hcp > 1.5
  CONDITION: hcp > 5.5
  CONDITION: spade_len <= 3.5
  # distilled from Brill /bid

RULE BD_False_P244:
  CALL: 3H
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid > 0.5
  CONDITION: rule20_total <= 17.5
  CONDITION: my_side_bid_count > 0.5
  CONDITION: last_bid_strain != 'NT'
  CONDITION: hcp <= 6.5
  CONDITION: support_in_partner_suit > 3.5
  CONDITION: heart_hcp > 1.5
  CONDITION: hcp > 5.5
  CONDITION: spade_len > 3.5
  # distilled from Brill /bid

RULE BD_False_P245:
  CALL: 1S
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid > 0.5
  CONDITION: rule20_total <= 17.5
  CONDITION: my_side_bid_count > 0.5
  CONDITION: last_bid_strain != 'NT'
  CONDITION: hcp > 6.5
  CONDITION: support_in_partner_suit <= 2.5
  CONDITION: partner_last_call == '1C'
  CONDITION: h_is_longest <= 0.5
  CONDITION: hcp <= 8.5
  # distilled from Brill /bid

RULE BD_False_P246:
  CALL: 1NT
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid > 0.5
  CONDITION: rule20_total <= 17.5
  CONDITION: my_side_bid_count > 0.5
  CONDITION: last_bid_strain != 'NT'
  CONDITION: hcp > 6.5
  CONDITION: support_in_partner_suit <= 2.5
  CONDITION: partner_last_call == '1C'
  CONDITION: h_is_longest <= 0.5
  CONDITION: hcp > 8.5
  # distilled from Brill /bid

RULE BD_False_P247:
  CALL: 1H
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid > 0.5
  CONDITION: rule20_total <= 17.5
  CONDITION: my_side_bid_count > 0.5
  CONDITION: last_bid_strain != 'NT'
  CONDITION: hcp > 6.5
  CONDITION: support_in_partner_suit <= 2.5
  CONDITION: partner_last_call == '1C'
  CONDITION: h_is_longest > 0.5
  CONDITION: diamond_len <= 2.5
  # distilled from Brill /bid

RULE BD_False_P248:
  CALL: X
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid > 0.5
  CONDITION: rule20_total <= 17.5
  CONDITION: my_side_bid_count > 0.5
  CONDITION: last_bid_strain != 'NT'
  CONDITION: hcp > 6.5
  CONDITION: support_in_partner_suit <= 2.5
  CONDITION: partner_last_call == '1C'
  CONDITION: h_is_longest > 0.5
  CONDITION: diamond_len > 2.5
  # distilled from Brill /bid

RULE BD_False_P249:
  CALL: X
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid > 0.5
  CONDITION: rule20_total <= 17.5
  CONDITION: my_side_bid_count > 0.5
  CONDITION: last_bid_strain != 'NT'
  CONDITION: hcp > 6.5
  CONDITION: support_in_partner_suit <= 2.5
  CONDITION: partner_last_call != '1C'
  CONDITION: longest_suit_len <= 4.5
  CONDITION: opp_last_call == '1S'
  # distilled from Brill /bid

RULE BD_False_P250:
  CALL: 1NT
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid > 0.5
  CONDITION: rule20_total <= 17.5
  CONDITION: my_side_bid_count > 0.5
  CONDITION: last_bid_strain != 'NT'
  CONDITION: hcp > 6.5
  CONDITION: support_in_partner_suit <= 2.5
  CONDITION: partner_last_call != '1C'
  CONDITION: longest_suit_len <= 4.5
  CONDITION: opp_last_call != '1S'
  # distilled from Brill /bid

RULE BD_False_P251:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid > 0.5
  CONDITION: rule20_total <= 17.5
  CONDITION: my_side_bid_count > 0.5
  CONDITION: last_bid_strain != 'NT'
  CONDITION: hcp > 6.5
  CONDITION: support_in_partner_suit <= 2.5
  CONDITION: partner_last_call != '1C'
  CONDITION: longest_suit_len > 4.5
  CONDITION: spade_hcp <= 4.5
  # distilled from Brill /bid

RULE BD_False_P252:
  CALL: 1S
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid > 0.5
  CONDITION: rule20_total <= 17.5
  CONDITION: my_side_bid_count > 0.5
  CONDITION: last_bid_strain != 'NT'
  CONDITION: hcp > 6.5
  CONDITION: support_in_partner_suit <= 2.5
  CONDITION: partner_last_call != '1C'
  CONDITION: longest_suit_len > 4.5
  CONDITION: spade_hcp > 4.5
  # distilled from Brill /bid

RULE BD_False_P253:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid > 0.5
  CONDITION: rule20_total <= 17.5
  CONDITION: my_side_bid_count > 0.5
  CONDITION: last_bid_strain != 'NT'
  CONDITION: hcp > 6.5
  CONDITION: support_in_partner_suit > 2.5
  CONDITION: partner_last_call == '1S'
  CONDITION: minor_hcp <= 3.5
  CONDITION: hcp <= 7.5
  # distilled from Brill /bid

RULE BD_False_P254:
  CALL: 2S
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid > 0.5
  CONDITION: rule20_total <= 17.5
  CONDITION: my_side_bid_count > 0.5
  CONDITION: last_bid_strain != 'NT'
  CONDITION: hcp > 6.5
  CONDITION: support_in_partner_suit > 2.5
  CONDITION: partner_last_call == '1S'
  CONDITION: minor_hcp <= 3.5
  CONDITION: hcp > 7.5
  # distilled from Brill /bid

RULE BD_False_P255:
  CALL: 2S
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid > 0.5
  CONDITION: rule20_total <= 17.5
  CONDITION: my_side_bid_count > 0.5
  CONDITION: last_bid_strain != 'NT'
  CONDITION: hcp > 6.5
  CONDITION: support_in_partner_suit > 2.5
  CONDITION: partner_last_call == '1S'
  CONDITION: minor_hcp > 3.5
  # distilled from Brill /bid

RULE BD_False_P256:
  CALL: 1NT
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid > 0.5
  CONDITION: rule20_total <= 17.5
  CONDITION: my_side_bid_count > 0.5
  CONDITION: last_bid_strain != 'NT'
  CONDITION: hcp > 6.5
  CONDITION: support_in_partner_suit > 2.5
  CONDITION: partner_last_call != '1S'
  CONDITION: competition_level <= 2.5
  CONDITION: s_is_longest <= 0.5
  # distilled from Brill /bid

RULE BD_False_P257:
  CALL: X
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid > 0.5
  CONDITION: rule20_total <= 17.5
  CONDITION: my_side_bid_count > 0.5
  CONDITION: last_bid_strain != 'NT'
  CONDITION: hcp > 6.5
  CONDITION: support_in_partner_suit > 2.5
  CONDITION: partner_last_call != '1S'
  CONDITION: competition_level <= 2.5
  CONDITION: s_is_longest > 0.5
  # distilled from Brill /bid

RULE BD_False_P258:
  CALL: 2H
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid > 0.5
  CONDITION: rule20_total <= 17.5
  CONDITION: my_side_bid_count > 0.5
  CONDITION: last_bid_strain != 'NT'
  CONDITION: hcp > 6.5
  CONDITION: support_in_partner_suit > 2.5
  CONDITION: partner_last_call != '1S'
  CONDITION: competition_level > 2.5
  CONDITION: my_seat == 'N'
  # distilled from Brill /bid

RULE BD_False_P259:
  CALL: 2D
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid > 0.5
  CONDITION: rule20_total <= 17.5
  CONDITION: my_side_bid_count > 0.5
  CONDITION: last_bid_strain != 'NT'
  CONDITION: hcp > 6.5
  CONDITION: support_in_partner_suit > 2.5
  CONDITION: partner_last_call != '1S'
  CONDITION: competition_level > 2.5
  CONDITION: my_seat != 'N'
  # distilled from Brill /bid

RULE BD_False_P260:
  CALL: 2H
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid > 0.5
  CONDITION: rule20_total > 17.5
  CONDITION: spade_len <= 4.5
  CONDITION: heart_len <= 4.5
  CONDITION: partner_last_bid_strain == 'NONE'
  CONDITION: longest_suit_len <= 5.5
  CONDITION: hcp <= 14.5
  CONDITION: partner_last_call == 'X'
  CONDITION: diamond_len <= 2.5
  # distilled from Brill /bid

RULE BD_False_P261:
  CALL: 1NT
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid > 0.5
  CONDITION: rule20_total > 17.5
  CONDITION: spade_len <= 4.5
  CONDITION: heart_len <= 4.5
  CONDITION: partner_last_bid_strain == 'NONE'
  CONDITION: longest_suit_len <= 5.5
  CONDITION: hcp <= 14.5
  CONDITION: partner_last_call == 'X'
  CONDITION: diamond_len > 2.5
  # distilled from Brill /bid

RULE BD_False_P262:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid > 0.5
  CONDITION: rule20_total > 17.5
  CONDITION: spade_len <= 4.5
  CONDITION: heart_len <= 4.5
  CONDITION: partner_last_bid_strain == 'NONE'
  CONDITION: longest_suit_len <= 5.5
  CONDITION: hcp <= 14.5
  CONDITION: partner_last_call != 'X'
  CONDITION: diamond_len <= 4.5
  # distilled from Brill /bid

RULE BD_False_P263:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid > 0.5
  CONDITION: rule20_total > 17.5
  CONDITION: spade_len <= 4.5
  CONDITION: heart_len <= 4.5
  CONDITION: partner_last_bid_strain == 'NONE'
  CONDITION: longest_suit_len <= 5.5
  CONDITION: hcp <= 14.5
  CONDITION: partner_last_call != 'X'
  CONDITION: diamond_len > 4.5
  # distilled from Brill /bid

RULE BD_False_P264:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid > 0.5
  CONDITION: rule20_total > 17.5
  CONDITION: spade_len <= 4.5
  CONDITION: heart_len <= 4.5
  CONDITION: partner_last_bid_strain == 'NONE'
  CONDITION: longest_suit_len <= 5.5
  CONDITION: hcp > 14.5
  CONDITION: last_bid_strain == 'NT'
  CONDITION: hcp <= 15.5
  # distilled from Brill /bid

RULE BD_False_P265:
  CALL: X
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid > 0.5
  CONDITION: rule20_total > 17.5
  CONDITION: spade_len <= 4.5
  CONDITION: heart_len <= 4.5
  CONDITION: partner_last_bid_strain == 'NONE'
  CONDITION: longest_suit_len <= 5.5
  CONDITION: hcp > 14.5
  CONDITION: last_bid_strain == 'NT'
  CONDITION: hcp > 15.5
  # distilled from Brill /bid

RULE BD_False_P266:
  CALL: 1NT
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid > 0.5
  CONDITION: rule20_total > 17.5
  CONDITION: spade_len <= 4.5
  CONDITION: heart_len <= 4.5
  CONDITION: partner_last_bid_strain == 'NONE'
  CONDITION: longest_suit_len <= 5.5
  CONDITION: hcp > 14.5
  CONDITION: last_bid_strain != 'NT'
  CONDITION: rule20_total <= 24.5
  # distilled from Brill /bid

RULE BD_False_P267:
  CALL: X
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid > 0.5
  CONDITION: rule20_total > 17.5
  CONDITION: spade_len <= 4.5
  CONDITION: heart_len <= 4.5
  CONDITION: partner_last_bid_strain == 'NONE'
  CONDITION: longest_suit_len <= 5.5
  CONDITION: hcp > 14.5
  CONDITION: last_bid_strain != 'NT'
  CONDITION: rule20_total > 24.5
  # distilled from Brill /bid

RULE BD_False_P268:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid > 0.5
  CONDITION: rule20_total > 17.5
  CONDITION: spade_len <= 4.5
  CONDITION: heart_len <= 4.5
  CONDITION: partner_last_bid_strain == 'NONE'
  CONDITION: longest_suit_len > 5.5
  CONDITION: diamond_hcp <= 4.5
  CONDITION: total_points <= 13.5
  CONDITION: club_hcp <= 3.5
  # distilled from Brill /bid

RULE BD_False_P269:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid > 0.5
  CONDITION: rule20_total > 17.5
  CONDITION: spade_len <= 4.5
  CONDITION: heart_len <= 4.5
  CONDITION: partner_last_bid_strain == 'NONE'
  CONDITION: longest_suit_len > 5.5
  CONDITION: diamond_hcp <= 4.5
  CONDITION: total_points <= 13.5
  CONDITION: club_hcp > 3.5
  # distilled from Brill /bid

RULE BD_False_P270:
  CALL: 2C
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid > 0.5
  CONDITION: rule20_total > 17.5
  CONDITION: spade_len <= 4.5
  CONDITION: heart_len <= 4.5
  CONDITION: partner_last_bid_strain == 'NONE'
  CONDITION: longest_suit_len > 5.5
  CONDITION: diamond_hcp <= 4.5
  CONDITION: total_points > 13.5
  CONDITION: hcp <= 15.0
  # distilled from Brill /bid

RULE BD_False_P271:
  CALL: 3C
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid > 0.5
  CONDITION: rule20_total > 17.5
  CONDITION: spade_len <= 4.5
  CONDITION: heart_len <= 4.5
  CONDITION: partner_last_bid_strain == 'NONE'
  CONDITION: longest_suit_len > 5.5
  CONDITION: diamond_hcp <= 4.5
  CONDITION: total_points > 13.5
  CONDITION: hcp > 15.0
  # distilled from Brill /bid

RULE BD_False_P272:
  CALL: 3D
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid > 0.5
  CONDITION: rule20_total > 17.5
  CONDITION: spade_len <= 4.5
  CONDITION: heart_len <= 4.5
  CONDITION: partner_last_bid_strain == 'NONE'
  CONDITION: longest_suit_len > 5.5
  CONDITION: diamond_hcp > 4.5
  CONDITION: controls <= 3.5
  CONDITION: is_vulnerable <= 0.5
  # distilled from Brill /bid

RULE BD_False_P273:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid > 0.5
  CONDITION: rule20_total > 17.5
  CONDITION: spade_len <= 4.5
  CONDITION: heart_len <= 4.5
  CONDITION: partner_last_bid_strain == 'NONE'
  CONDITION: longest_suit_len > 5.5
  CONDITION: diamond_hcp > 4.5
  CONDITION: controls <= 3.5
  CONDITION: is_vulnerable > 0.5
  # distilled from Brill /bid

RULE BD_False_P274:
  CALL: 2D
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid > 0.5
  CONDITION: rule20_total > 17.5
  CONDITION: spade_len <= 4.5
  CONDITION: heart_len <= 4.5
  CONDITION: partner_last_bid_strain == 'NONE'
  CONDITION: longest_suit_len > 5.5
  CONDITION: diamond_hcp > 4.5
  CONDITION: controls > 3.5
  CONDITION: hcp <= 15.5
  # distilled from Brill /bid

RULE BD_False_P275:
  CALL: X
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid > 0.5
  CONDITION: rule20_total > 17.5
  CONDITION: spade_len <= 4.5
  CONDITION: heart_len <= 4.5
  CONDITION: partner_last_bid_strain == 'NONE'
  CONDITION: longest_suit_len > 5.5
  CONDITION: diamond_hcp > 4.5
  CONDITION: controls > 3.5
  CONDITION: hcp > 15.5
  # distilled from Brill /bid

RULE BD_False_P276:
  CALL: X
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid > 0.5
  CONDITION: rule20_total > 17.5
  CONDITION: spade_len <= 4.5
  CONDITION: heart_len <= 4.5
  CONDITION: partner_last_bid_strain != 'NONE'
  CONDITION: support_in_partner_suit <= 3.5
  CONDITION: club_len <= 5.5
  CONDITION: passes_since_last_bid <= 0.5
  CONDITION: doubleton_count <= 0.5
  # distilled from Brill /bid

RULE BD_False_P277:
  CALL: 2NT
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid > 0.5
  CONDITION: rule20_total > 17.5
  CONDITION: spade_len <= 4.5
  CONDITION: heart_len <= 4.5
  CONDITION: partner_last_bid_strain != 'NONE'
  CONDITION: support_in_partner_suit <= 3.5
  CONDITION: club_len <= 5.5
  CONDITION: passes_since_last_bid <= 0.5
  CONDITION: doubleton_count > 0.5
  # distilled from Brill /bid

RULE BD_False_P278:
  CALL: 1NT
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid > 0.5
  CONDITION: rule20_total > 17.5
  CONDITION: spade_len <= 4.5
  CONDITION: heart_len <= 4.5
  CONDITION: partner_last_bid_strain != 'NONE'
  CONDITION: support_in_partner_suit <= 3.5
  CONDITION: club_len <= 5.5
  CONDITION: passes_since_last_bid > 0.5
  CONDITION: support_in_partner_suit <= 2.5
  # distilled from Brill /bid

RULE BD_False_P279:
  CALL: 2H
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid > 0.5
  CONDITION: rule20_total > 17.5
  CONDITION: spade_len <= 4.5
  CONDITION: heart_len <= 4.5
  CONDITION: partner_last_bid_strain != 'NONE'
  CONDITION: support_in_partner_suit <= 3.5
  CONDITION: club_len <= 5.5
  CONDITION: passes_since_last_bid > 0.5
  CONDITION: support_in_partner_suit > 2.5
  # distilled from Brill /bid

RULE BD_False_P280:
  CALL: 3S
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid > 0.5
  CONDITION: rule20_total > 17.5
  CONDITION: spade_len <= 4.5
  CONDITION: heart_len <= 4.5
  CONDITION: partner_last_bid_strain != 'NONE'
  CONDITION: support_in_partner_suit <= 3.5
  CONDITION: club_len > 5.5
  CONDITION: minor_hcp <= 3.5
  CONDITION: hcp <= 9.5
  # distilled from Brill /bid

RULE BD_False_P281:
  CALL: 1NT
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid > 0.5
  CONDITION: rule20_total > 17.5
  CONDITION: spade_len <= 4.5
  CONDITION: heart_len <= 4.5
  CONDITION: partner_last_bid_strain != 'NONE'
  CONDITION: support_in_partner_suit <= 3.5
  CONDITION: club_len > 5.5
  CONDITION: minor_hcp <= 3.5
  CONDITION: hcp > 9.5
  # distilled from Brill /bid

RULE BD_False_P282:
  CALL: 2C
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid > 0.5
  CONDITION: rule20_total > 17.5
  CONDITION: spade_len <= 4.5
  CONDITION: heart_len <= 4.5
  CONDITION: partner_last_bid_strain != 'NONE'
  CONDITION: support_in_partner_suit <= 3.5
  CONDITION: club_len > 5.5
  CONDITION: minor_hcp > 3.5
  CONDITION: auction_len <= 6.0
  # distilled from Brill /bid

RULE BD_False_P283:
  CALL: 5C
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid > 0.5
  CONDITION: rule20_total > 17.5
  CONDITION: spade_len <= 4.5
  CONDITION: heart_len <= 4.5
  CONDITION: partner_last_bid_strain != 'NONE'
  CONDITION: support_in_partner_suit <= 3.5
  CONDITION: club_len > 5.5
  CONDITION: minor_hcp > 3.5
  CONDITION: auction_len > 6.0
  # distilled from Brill /bid

RULE BD_False_P284:
  CALL: 2H
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid > 0.5
  CONDITION: rule20_total > 17.5
  CONDITION: spade_len <= 4.5
  CONDITION: heart_len <= 4.5
  CONDITION: partner_last_bid_strain != 'NONE'
  CONDITION: support_in_partner_suit > 3.5
  CONDITION: rule20_total <= 22.5
  CONDITION: opp_last_call == '1H'
  CONDITION: d_has_queen <= 0.5
  # distilled from Brill /bid

RULE BD_False_P285:
  CALL: X
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid > 0.5
  CONDITION: rule20_total > 17.5
  CONDITION: spade_len <= 4.5
  CONDITION: heart_len <= 4.5
  CONDITION: partner_last_bid_strain != 'NONE'
  CONDITION: support_in_partner_suit > 3.5
  CONDITION: rule20_total <= 22.5
  CONDITION: opp_last_call == '1H'
  CONDITION: d_has_queen > 0.5
  # distilled from Brill /bid

RULE BD_False_P286:
  CALL: 2C
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid > 0.5
  CONDITION: rule20_total > 17.5
  CONDITION: spade_len <= 4.5
  CONDITION: heart_len <= 4.5
  CONDITION: partner_last_bid_strain != 'NONE'
  CONDITION: support_in_partner_suit > 3.5
  CONDITION: rule20_total <= 22.5
  CONDITION: opp_last_call != '1H'
  CONDITION: auction_len <= 5.5
  # distilled from Brill /bid

RULE BD_False_P287:
  CALL: 2S
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid > 0.5
  CONDITION: rule20_total > 17.5
  CONDITION: spade_len <= 4.5
  CONDITION: heart_len <= 4.5
  CONDITION: partner_last_bid_strain != 'NONE'
  CONDITION: support_in_partner_suit > 3.5
  CONDITION: rule20_total <= 22.5
  CONDITION: opp_last_call != '1H'
  CONDITION: auction_len > 5.5
  # distilled from Brill /bid

RULE BD_False_P288:
  CALL: 2D
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid > 0.5
  CONDITION: rule20_total > 17.5
  CONDITION: spade_len <= 4.5
  CONDITION: heart_len <= 4.5
  CONDITION: partner_last_bid_strain != 'NONE'
  CONDITION: support_in_partner_suit > 3.5
  CONDITION: rule20_total > 22.5
  CONDITION: minor_hcp <= 12.5
  CONDITION: spade_len <= 3.5
  # distilled from Brill /bid

RULE BD_False_P289:
  CALL: 3S
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid > 0.5
  CONDITION: rule20_total > 17.5
  CONDITION: spade_len <= 4.5
  CONDITION: heart_len <= 4.5
  CONDITION: partner_last_bid_strain != 'NONE'
  CONDITION: support_in_partner_suit > 3.5
  CONDITION: rule20_total > 22.5
  CONDITION: minor_hcp <= 12.5
  CONDITION: spade_len > 3.5
  # distilled from Brill /bid

RULE BD_False_P290:
  CALL: 4S
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid > 0.5
  CONDITION: rule20_total > 17.5
  CONDITION: spade_len <= 4.5
  CONDITION: heart_len <= 4.5
  CONDITION: partner_last_bid_strain != 'NONE'
  CONDITION: support_in_partner_suit > 3.5
  CONDITION: rule20_total > 22.5
  CONDITION: minor_hcp > 12.5
  # distilled from Brill /bid

RULE BD_False_P291:
  CALL: X
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid > 0.5
  CONDITION: rule20_total > 17.5
  CONDITION: spade_len <= 4.5
  CONDITION: heart_len > 4.5
  CONDITION: last_bid_strain == 'D'
  CONDITION: hcp <= 16.5
  CONDITION: heart_len <= 5.5
  CONDITION: diamond_len <= 1.5
  # distilled from Brill /bid

RULE BD_False_P292:
  CALL: 1H
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid > 0.5
  CONDITION: rule20_total > 17.5
  CONDITION: spade_len <= 4.5
  CONDITION: heart_len > 4.5
  CONDITION: last_bid_strain == 'D'
  CONDITION: hcp <= 16.5
  CONDITION: heart_len <= 5.5
  CONDITION: diamond_len > 1.5
  # distilled from Brill /bid

RULE BD_False_P293:
  CALL: 2H
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid > 0.5
  CONDITION: rule20_total > 17.5
  CONDITION: spade_len <= 4.5
  CONDITION: heart_len > 4.5
  CONDITION: last_bid_strain == 'D'
  CONDITION: hcp <= 16.5
  CONDITION: heart_len > 5.5
  CONDITION: hcp <= 11.0
  CONDITION: diamond_hcp <= 1.5
  # distilled from Brill /bid

RULE BD_False_P294:
  CALL: 1H
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid > 0.5
  CONDITION: rule20_total > 17.5
  CONDITION: spade_len <= 4.5
  CONDITION: heart_len > 4.5
  CONDITION: last_bid_strain == 'D'
  CONDITION: hcp <= 16.5
  CONDITION: heart_len > 5.5
  CONDITION: hcp <= 11.0
  CONDITION: diamond_hcp > 1.5
  # distilled from Brill /bid

RULE BD_False_P295:
  CALL: 4H
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid > 0.5
  CONDITION: rule20_total > 17.5
  CONDITION: spade_len <= 4.5
  CONDITION: heart_len > 4.5
  CONDITION: last_bid_strain == 'D'
  CONDITION: hcp <= 16.5
  CONDITION: heart_len > 5.5
  CONDITION: hcp > 11.0
  CONDITION: hcp <= 13.0
  # distilled from Brill /bid

RULE BD_False_P296:
  CALL: 1H
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid > 0.5
  CONDITION: rule20_total > 17.5
  CONDITION: spade_len <= 4.5
  CONDITION: heart_len > 4.5
  CONDITION: last_bid_strain == 'D'
  CONDITION: hcp <= 16.5
  CONDITION: heart_len > 5.5
  CONDITION: hcp > 11.0
  CONDITION: hcp > 13.0
  # distilled from Brill /bid

RULE BD_False_P297:
  CALL: 2NT
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid > 0.5
  CONDITION: rule20_total > 17.5
  CONDITION: spade_len <= 4.5
  CONDITION: heart_len > 4.5
  CONDITION: last_bid_strain == 'D'
  CONDITION: hcp > 16.5
  CONDITION: hcp <= 17.5
  # distilled from Brill /bid

RULE BD_False_P298:
  CALL: X
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid > 0.5
  CONDITION: rule20_total > 17.5
  CONDITION: spade_len <= 4.5
  CONDITION: heart_len > 4.5
  CONDITION: last_bid_strain == 'D'
  CONDITION: hcp > 16.5
  CONDITION: hcp > 17.5
  # distilled from Brill /bid

RULE BD_False_P299:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid > 0.5
  CONDITION: rule20_total > 17.5
  CONDITION: spade_len <= 4.5
  CONDITION: heart_len > 4.5
  CONDITION: last_bid_strain != 'D'
  CONDITION: last_bid_strain == 'C'
  CONDITION: h_top2_honors <= 0.5
  CONDITION: shortest_suit_len <= 0.5
  CONDITION: hcp <= 10.5
  # distilled from Brill /bid

RULE BD_False_P300:
  CALL: 2NT
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid > 0.5
  CONDITION: rule20_total > 17.5
  CONDITION: spade_len <= 4.5
  CONDITION: heart_len > 4.5
  CONDITION: last_bid_strain != 'D'
  CONDITION: last_bid_strain == 'C'
  CONDITION: h_top2_honors <= 0.5
  CONDITION: shortest_suit_len <= 0.5
  CONDITION: hcp > 10.5
  # distilled from Brill /bid

RULE BD_False_P301:
  CALL: 1H
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid > 0.5
  CONDITION: rule20_total > 17.5
  CONDITION: spade_len <= 4.5
  CONDITION: heart_len > 4.5
  CONDITION: last_bid_strain != 'D'
  CONDITION: last_bid_strain == 'C'
  CONDITION: h_top2_honors <= 0.5
  CONDITION: shortest_suit_len > 0.5
  CONDITION: auction_len <= 2.0
  # distilled from Brill /bid

RULE BD_False_P302:
  CALL: 3H
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid > 0.5
  CONDITION: rule20_total > 17.5
  CONDITION: spade_len <= 4.5
  CONDITION: heart_len > 4.5
  CONDITION: last_bid_strain != 'D'
  CONDITION: last_bid_strain == 'C'
  CONDITION: h_top2_honors <= 0.5
  CONDITION: shortest_suit_len > 0.5
  CONDITION: auction_len > 2.0
  # distilled from Brill /bid

RULE BD_False_P303:
  CALL: 2H
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid > 0.5
  CONDITION: rule20_total > 17.5
  CONDITION: spade_len <= 4.5
  CONDITION: heart_len > 4.5
  CONDITION: last_bid_strain != 'D'
  CONDITION: last_bid_strain == 'C'
  CONDITION: h_top2_honors > 0.5
  CONDITION: hcp <= 9.5
  CONDITION: major_hcp <= 6.5
  # distilled from Brill /bid

RULE BD_False_P304:
  CALL: 4H
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid > 0.5
  CONDITION: rule20_total > 17.5
  CONDITION: spade_len <= 4.5
  CONDITION: heart_len > 4.5
  CONDITION: last_bid_strain != 'D'
  CONDITION: last_bid_strain == 'C'
  CONDITION: h_top2_honors > 0.5
  CONDITION: hcp <= 9.5
  CONDITION: major_hcp > 6.5
  # distilled from Brill /bid

RULE BD_False_P305:
  CALL: 1H
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid > 0.5
  CONDITION: rule20_total > 17.5
  CONDITION: spade_len <= 4.5
  CONDITION: heart_len > 4.5
  CONDITION: last_bid_strain != 'D'
  CONDITION: last_bid_strain == 'C'
  CONDITION: h_top2_honors > 0.5
  CONDITION: hcp > 9.5
  CONDITION: hcp <= 17.0
  # distilled from Brill /bid

RULE BD_False_P306:
  CALL: X
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid > 0.5
  CONDITION: rule20_total > 17.5
  CONDITION: spade_len <= 4.5
  CONDITION: heart_len > 4.5
  CONDITION: last_bid_strain != 'D'
  CONDITION: last_bid_strain == 'C'
  CONDITION: h_top2_honors > 0.5
  CONDITION: hcp > 9.5
  CONDITION: hcp > 17.0
  # distilled from Brill /bid

RULE BD_False_P307:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid > 0.5
  CONDITION: rule20_total > 17.5
  CONDITION: spade_len <= 4.5
  CONDITION: heart_len > 4.5
  CONDITION: last_bid_strain != 'D'
  CONDITION: last_bid_strain != 'C'
  CONDITION: second_longest_len <= 4.5
  CONDITION: support_in_partner_suit <= 2.5
  CONDITION: minor_hcp <= 5.5
  # distilled from Brill /bid

RULE BD_False_P308:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid > 0.5
  CONDITION: rule20_total > 17.5
  CONDITION: spade_len <= 4.5
  CONDITION: heart_len > 4.5
  CONDITION: last_bid_strain != 'D'
  CONDITION: last_bid_strain != 'C'
  CONDITION: second_longest_len <= 4.5
  CONDITION: support_in_partner_suit <= 2.5
  CONDITION: minor_hcp > 5.5
  # distilled from Brill /bid

RULE BD_False_P309:
  CALL: 2H
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid > 0.5
  CONDITION: rule20_total > 17.5
  CONDITION: spade_len <= 4.5
  CONDITION: heart_len > 4.5
  CONDITION: last_bid_strain != 'D'
  CONDITION: last_bid_strain != 'C'
  CONDITION: second_longest_len <= 4.5
  CONDITION: support_in_partner_suit > 2.5
  CONDITION: h_has_king <= 0.5
  # distilled from Brill /bid

RULE BD_False_P310:
  CALL: 2D
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid > 0.5
  CONDITION: rule20_total > 17.5
  CONDITION: spade_len <= 4.5
  CONDITION: heart_len > 4.5
  CONDITION: last_bid_strain != 'D'
  CONDITION: last_bid_strain != 'C'
  CONDITION: second_longest_len <= 4.5
  CONDITION: support_in_partner_suit > 2.5
  CONDITION: h_has_king > 0.5
  # distilled from Brill /bid

RULE BD_False_P311:
  CALL: 2C
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid > 0.5
  CONDITION: rule20_total > 17.5
  CONDITION: spade_len <= 4.5
  CONDITION: heart_len > 4.5
  CONDITION: last_bid_strain != 'D'
  CONDITION: last_bid_strain != 'C'
  CONDITION: second_longest_len > 4.5
  CONDITION: auction_len <= 3.5
  CONDITION: last_bid_strain == 'H'
  # distilled from Brill /bid

RULE BD_False_P312:
  CALL: 2S
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid > 0.5
  CONDITION: rule20_total > 17.5
  CONDITION: spade_len <= 4.5
  CONDITION: heart_len > 4.5
  CONDITION: last_bid_strain != 'D'
  CONDITION: last_bid_strain != 'C'
  CONDITION: second_longest_len > 4.5
  CONDITION: auction_len <= 3.5
  CONDITION: last_bid_strain != 'H'
  # distilled from Brill /bid

RULE BD_False_P313:
  CALL: 2NT
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid > 0.5
  CONDITION: rule20_total > 17.5
  CONDITION: spade_len <= 4.5
  CONDITION: heart_len > 4.5
  CONDITION: last_bid_strain != 'D'
  CONDITION: last_bid_strain != 'C'
  CONDITION: second_longest_len > 4.5
  CONDITION: auction_len > 3.5
  CONDITION: jack_count <= 1.5
  # distilled from Brill /bid

RULE BD_False_P314:
  CALL: X
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid > 0.5
  CONDITION: rule20_total > 17.5
  CONDITION: spade_len <= 4.5
  CONDITION: heart_len > 4.5
  CONDITION: last_bid_strain != 'D'
  CONDITION: last_bid_strain != 'C'
  CONDITION: second_longest_len > 4.5
  CONDITION: auction_len > 3.5
  CONDITION: jack_count > 1.5
  # distilled from Brill /bid

RULE BD_False_P315:
  CALL: 3NT
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid > 0.5
  CONDITION: rule20_total > 17.5
  CONDITION: spade_len > 4.5
  CONDITION: last_bid_strain == 'NT'
  CONDITION: partner_last_call == '1NT'
  CONDITION: major_hcp <= 13.5
  CONDITION: shortest_suit_len <= 1.5
  # distilled from Brill /bid

RULE BD_False_P316:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid > 0.5
  CONDITION: rule20_total > 17.5
  CONDITION: spade_len > 4.5
  CONDITION: last_bid_strain == 'NT'
  CONDITION: partner_last_call == '1NT'
  CONDITION: major_hcp <= 13.5
  CONDITION: shortest_suit_len > 1.5
  # distilled from Brill /bid

RULE BD_False_P317:
  CALL: 4H
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid > 0.5
  CONDITION: rule20_total > 17.5
  CONDITION: spade_len > 4.5
  CONDITION: last_bid_strain == 'NT'
  CONDITION: partner_last_call == '1NT'
  CONDITION: major_hcp > 13.5
  # distilled from Brill /bid

RULE BD_False_P318:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid > 0.5
  CONDITION: rule20_total > 17.5
  CONDITION: spade_len > 4.5
  CONDITION: last_bid_strain == 'NT'
  CONDITION: partner_last_call != '1NT'
  CONDITION: partner_last_call == 'PASS'
  CONDITION: s_has_queen <= 0.5
  CONDITION: major_hcp <= 4.5
  CONDITION: spade_len <= 6.5
  # distilled from Brill /bid

RULE BD_False_P319:
  CALL: 3S
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid > 0.5
  CONDITION: rule20_total > 17.5
  CONDITION: spade_len > 4.5
  CONDITION: last_bid_strain == 'NT'
  CONDITION: partner_last_call != '1NT'
  CONDITION: partner_last_call == 'PASS'
  CONDITION: s_has_queen <= 0.5
  CONDITION: major_hcp <= 4.5
  CONDITION: spade_len > 6.5
  # distilled from Brill /bid

RULE BD_False_P320:
  CALL: 2S
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid > 0.5
  CONDITION: rule20_total > 17.5
  CONDITION: spade_len > 4.5
  CONDITION: last_bid_strain == 'NT'
  CONDITION: partner_last_call != '1NT'
  CONDITION: partner_last_call == 'PASS'
  CONDITION: s_has_queen <= 0.5
  CONDITION: major_hcp > 4.5
  CONDITION: is_equal_non_vuln <= 0.5
  # distilled from Brill /bid

RULE BD_False_P321:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid > 0.5
  CONDITION: rule20_total > 17.5
  CONDITION: spade_len > 4.5
  CONDITION: last_bid_strain == 'NT'
  CONDITION: partner_last_call != '1NT'
  CONDITION: partner_last_call == 'PASS'
  CONDITION: s_has_queen <= 0.5
  CONDITION: major_hcp > 4.5
  CONDITION: is_equal_non_vuln > 0.5
  # distilled from Brill /bid

RULE BD_False_P322:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid > 0.5
  CONDITION: rule20_total > 17.5
  CONDITION: spade_len > 4.5
  CONDITION: last_bid_strain == 'NT'
  CONDITION: partner_last_call != '1NT'
  CONDITION: partner_last_call == 'PASS'
  CONDITION: s_has_queen > 0.5
  # distilled from Brill /bid

RULE BD_False_P323:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid > 0.5
  CONDITION: rule20_total > 17.5
  CONDITION: spade_len > 4.5
  CONDITION: last_bid_strain == 'NT'
  CONDITION: partner_last_call != '1NT'
  CONDITION: partner_last_call != 'PASS'
  CONDITION: rule20_total <= 19.5
  CONDITION: spade_hcp <= 2.5
  # distilled from Brill /bid

RULE BD_False_P324:
  CALL: 3S
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid > 0.5
  CONDITION: rule20_total > 17.5
  CONDITION: spade_len > 4.5
  CONDITION: last_bid_strain == 'NT'
  CONDITION: partner_last_call != '1NT'
  CONDITION: partner_last_call != 'PASS'
  CONDITION: rule20_total <= 19.5
  CONDITION: spade_hcp > 2.5
  # distilled from Brill /bid

RULE BD_False_P325:
  CALL: 2S
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid > 0.5
  CONDITION: rule20_total > 17.5
  CONDITION: spade_len > 4.5
  CONDITION: last_bid_strain == 'NT'
  CONDITION: partner_last_call != '1NT'
  CONDITION: partner_last_call != 'PASS'
  CONDITION: rule20_total > 19.5
  CONDITION: major_hcp <= 6.5
  CONDITION: hcp <= 13.0
  # distilled from Brill /bid

RULE BD_False_P326:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid > 0.5
  CONDITION: rule20_total > 17.5
  CONDITION: spade_len > 4.5
  CONDITION: last_bid_strain == 'NT'
  CONDITION: partner_last_call != '1NT'
  CONDITION: partner_last_call != 'PASS'
  CONDITION: rule20_total > 19.5
  CONDITION: major_hcp <= 6.5
  CONDITION: hcp > 13.0
  # distilled from Brill /bid

RULE BD_False_P327:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid > 0.5
  CONDITION: rule20_total > 17.5
  CONDITION: spade_len > 4.5
  CONDITION: last_bid_strain == 'NT'
  CONDITION: partner_last_call != '1NT'
  CONDITION: partner_last_call != 'PASS'
  CONDITION: rule20_total > 19.5
  CONDITION: major_hcp > 6.5
  CONDITION: spade_hcp <= 5.5
  # distilled from Brill /bid

RULE BD_False_P328:
  CALL: 2C
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid > 0.5
  CONDITION: rule20_total > 17.5
  CONDITION: spade_len > 4.5
  CONDITION: last_bid_strain == 'NT'
  CONDITION: partner_last_call != '1NT'
  CONDITION: partner_last_call != 'PASS'
  CONDITION: rule20_total > 19.5
  CONDITION: major_hcp > 6.5
  CONDITION: spade_hcp > 5.5
  # distilled from Brill /bid

RULE BD_False_P329:
  CALL: 1NT
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid > 0.5
  CONDITION: rule20_total > 17.5
  CONDITION: spade_len > 4.5
  CONDITION: last_bid_strain != 'NT'
  CONDITION: last_bid_strain == 'S'
  CONDITION: minor_hcp <= 0.5
  # distilled from Brill /bid

RULE BD_False_P330:
  CALL: 2H
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid > 0.5
  CONDITION: rule20_total > 17.5
  CONDITION: spade_len > 4.5
  CONDITION: last_bid_strain != 'NT'
  CONDITION: last_bid_strain == 'S'
  CONDITION: minor_hcp > 0.5
  CONDITION: spade_hcp <= 1.0
  # distilled from Brill /bid

RULE BD_False_P331:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid > 0.5
  CONDITION: rule20_total > 17.5
  CONDITION: spade_len > 4.5
  CONDITION: last_bid_strain != 'NT'
  CONDITION: last_bid_strain == 'S'
  CONDITION: minor_hcp > 0.5
  CONDITION: spade_hcp > 1.0
  # distilled from Brill /bid

RULE BD_False_P332:
  CALL: 4S
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid > 0.5
  CONDITION: rule20_total > 17.5
  CONDITION: spade_len > 4.5
  CONDITION: last_bid_strain != 'NT'
  CONDITION: last_bid_strain != 'S'
  CONDITION: rule20_total <= 26.5
  CONDITION: heart_len <= 4.5
  CONDITION: losing_trick_count <= 5.5
  CONDITION: hcp <= 13.5
  # distilled from Brill /bid

RULE BD_False_P333:
  CALL: 1S
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid > 0.5
  CONDITION: rule20_total > 17.5
  CONDITION: spade_len > 4.5
  CONDITION: last_bid_strain != 'NT'
  CONDITION: last_bid_strain != 'S'
  CONDITION: rule20_total <= 26.5
  CONDITION: heart_len <= 4.5
  CONDITION: losing_trick_count <= 5.5
  CONDITION: hcp > 13.5
  # distilled from Brill /bid

RULE BD_False_P334:
  CALL: 1S
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid > 0.5
  CONDITION: rule20_total > 17.5
  CONDITION: spade_len > 4.5
  CONDITION: last_bid_strain != 'NT'
  CONDITION: last_bid_strain != 'S'
  CONDITION: rule20_total <= 26.5
  CONDITION: heart_len <= 4.5
  CONDITION: losing_trick_count > 5.5
  CONDITION: support_in_partner_suit <= 2.5
  # distilled from Brill /bid

RULE BD_False_P335:
  CALL: 2D
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid > 0.5
  CONDITION: rule20_total > 17.5
  CONDITION: spade_len > 4.5
  CONDITION: last_bid_strain != 'NT'
  CONDITION: last_bid_strain != 'S'
  CONDITION: rule20_total <= 26.5
  CONDITION: heart_len <= 4.5
  CONDITION: losing_trick_count > 5.5
  CONDITION: support_in_partner_suit > 2.5
  # distilled from Brill /bid

RULE BD_False_P336:
  CALL: 2D
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid > 0.5
  CONDITION: rule20_total > 17.5
  CONDITION: spade_len > 4.5
  CONDITION: last_bid_strain != 'NT'
  CONDITION: last_bid_strain != 'S'
  CONDITION: rule20_total <= 26.5
  CONDITION: heart_len > 4.5
  CONDITION: h_has_jack <= 0.5
  CONDITION: queen_count <= 1.5
  # distilled from Brill /bid

RULE BD_False_P337:
  CALL: 2C
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid > 0.5
  CONDITION: rule20_total > 17.5
  CONDITION: spade_len > 4.5
  CONDITION: last_bid_strain != 'NT'
  CONDITION: last_bid_strain != 'S'
  CONDITION: rule20_total <= 26.5
  CONDITION: heart_len > 4.5
  CONDITION: h_has_jack <= 0.5
  CONDITION: queen_count > 1.5
  # distilled from Brill /bid

RULE BD_False_P338:
  CALL: 2NT
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid > 0.5
  CONDITION: rule20_total > 17.5
  CONDITION: spade_len > 4.5
  CONDITION: last_bid_strain != 'NT'
  CONDITION: last_bid_strain != 'S'
  CONDITION: rule20_total <= 26.5
  CONDITION: heart_len > 4.5
  CONDITION: h_has_jack > 0.5
  # distilled from Brill /bid

RULE BD_False_P339:
  CALL: 1S
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid > 0.5
  CONDITION: rule20_total > 17.5
  CONDITION: spade_len > 4.5
  CONDITION: last_bid_strain != 'NT'
  CONDITION: last_bid_strain != 'S'
  CONDITION: rule20_total > 26.5
  CONDITION: auction_len <= 4.0
  CONDITION: major_hcp <= 8.0
  # distilled from Brill /bid

RULE BD_False_P340:
  CALL: X
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid > 0.5
  CONDITION: rule20_total > 17.5
  CONDITION: spade_len > 4.5
  CONDITION: last_bid_strain != 'NT'
  CONDITION: last_bid_strain != 'S'
  CONDITION: rule20_total > 26.5
  CONDITION: auction_len <= 4.0
  CONDITION: major_hcp > 8.0
  # distilled from Brill /bid

RULE BD_False_P341:
  CALL: 5C
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid > 0.5
  CONDITION: rule20_total > 17.5
  CONDITION: spade_len > 4.5
  CONDITION: last_bid_strain != 'NT'
  CONDITION: last_bid_strain != 'S'
  CONDITION: rule20_total > 26.5
  CONDITION: auction_len > 4.0
  CONDITION: hcp <= 17.5
  # distilled from Brill /bid

RULE BD_False_P342:
  CALL: 1NT
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid > 0.5
  CONDITION: rule20_total > 17.5
  CONDITION: spade_len > 4.5
  CONDITION: last_bid_strain != 'NT'
  CONDITION: last_bid_strain != 'S'
  CONDITION: rule20_total > 26.5
  CONDITION: auction_len > 4.0
  CONDITION: hcp > 17.5
  CONDITION: hcp <= 20.0
  # distilled from Brill /bid

RULE BD_False_P343:
  CALL: 2NT
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid > 0.5
  CONDITION: rule20_total > 17.5
  CONDITION: spade_len > 4.5
  CONDITION: last_bid_strain != 'NT'
  CONDITION: last_bid_strain != 'S'
  CONDITION: rule20_total > 26.5
  CONDITION: auction_len > 4.0
  CONDITION: hcp > 17.5
  CONDITION: hcp > 20.0
  # distilled from Brill /bid

RULE BD_False_P344:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call == 'PASS'
  CONDITION: my_last_call == 'PASS'
  CONDITION: support_in_partner_suit <= 2.5
  CONDITION: total_points <= 11.5
  CONDITION: partner_opened <= 0.5
  CONDITION: diamond_len <= 4.5
  CONDITION: opp_last_call == '5C'
  CONDITION: minor_hcp <= 5.0
  # distilled from Brill /bid

RULE BD_False_P345:
  CALL: X
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call == 'PASS'
  CONDITION: my_last_call == 'PASS'
  CONDITION: support_in_partner_suit <= 2.5
  CONDITION: total_points <= 11.5
  CONDITION: partner_opened <= 0.5
  CONDITION: diamond_len <= 4.5
  CONDITION: opp_last_call == '5C'
  CONDITION: minor_hcp > 5.0
  # distilled from Brill /bid

RULE BD_False_P346:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call == 'PASS'
  CONDITION: my_last_call == 'PASS'
  CONDITION: support_in_partner_suit <= 2.5
  CONDITION: total_points <= 11.5
  CONDITION: partner_opened <= 0.5
  CONDITION: diamond_len <= 4.5
  CONDITION: opp_last_call != '5C'
  # distilled from Brill /bid

RULE BD_False_P347:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call == 'PASS'
  CONDITION: my_last_call == 'PASS'
  CONDITION: support_in_partner_suit <= 2.5
  CONDITION: total_points <= 11.5
  CONDITION: partner_opened <= 0.5
  CONDITION: diamond_len > 4.5
  CONDITION: last_bid_strain == 'D'
  CONDITION: d_has_king <= 0.5
  # distilled from Brill /bid

RULE BD_False_P348:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call == 'PASS'
  CONDITION: my_last_call == 'PASS'
  CONDITION: support_in_partner_suit <= 2.5
  CONDITION: total_points <= 11.5
  CONDITION: partner_opened <= 0.5
  CONDITION: diamond_len > 4.5
  CONDITION: last_bid_strain == 'D'
  CONDITION: d_has_king > 0.5
  CONDITION: opp_first_bid_level <= 1.5
  # distilled from Brill /bid

RULE BD_False_P349:
  CALL: X
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call == 'PASS'
  CONDITION: my_last_call == 'PASS'
  CONDITION: support_in_partner_suit <= 2.5
  CONDITION: total_points <= 11.5
  CONDITION: partner_opened <= 0.5
  CONDITION: diamond_len > 4.5
  CONDITION: last_bid_strain == 'D'
  CONDITION: d_has_king > 0.5
  CONDITION: opp_first_bid_level > 1.5
  # distilled from Brill /bid

RULE BD_False_P350:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call == 'PASS'
  CONDITION: my_last_call == 'PASS'
  CONDITION: support_in_partner_suit <= 2.5
  CONDITION: total_points <= 11.5
  CONDITION: partner_opened <= 0.5
  CONDITION: diamond_len > 4.5
  CONDITION: last_bid_strain != 'D'
  CONDITION: jack_count <= 2.5
  # distilled from Brill /bid

RULE BD_False_P351:
  CALL: X
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call == 'PASS'
  CONDITION: my_last_call == 'PASS'
  CONDITION: support_in_partner_suit <= 2.5
  CONDITION: total_points <= 11.5
  CONDITION: partner_opened <= 0.5
  CONDITION: diamond_len > 4.5
  CONDITION: last_bid_strain != 'D'
  CONDITION: jack_count > 2.5
  CONDITION: shape_pattern == '5431'
  # distilled from Brill /bid

RULE BD_False_P352:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call == 'PASS'
  CONDITION: my_last_call == 'PASS'
  CONDITION: support_in_partner_suit <= 2.5
  CONDITION: total_points <= 11.5
  CONDITION: partner_opened <= 0.5
  CONDITION: diamond_len > 4.5
  CONDITION: last_bid_strain != 'D'
  CONDITION: jack_count > 2.5
  CONDITION: shape_pattern != '5431'
  # distilled from Brill /bid

RULE BD_False_P353:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call == 'PASS'
  CONDITION: my_last_call == 'PASS'
  CONDITION: support_in_partner_suit <= 2.5
  CONDITION: total_points <= 11.5
  CONDITION: partner_opened > 0.5
  CONDITION: opp_last_call == '2D'
  CONDITION: c_has_ten <= 0.5
  # distilled from Brill /bid

RULE BD_False_P354:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call == 'PASS'
  CONDITION: my_last_call == 'PASS'
  CONDITION: support_in_partner_suit <= 2.5
  CONDITION: total_points <= 11.5
  CONDITION: partner_opened > 0.5
  CONDITION: opp_last_call == '2D'
  CONDITION: c_has_ten > 0.5
  CONDITION: major_hcp <= 2.5
  # distilled from Brill /bid

RULE BD_False_P355:
  CALL: 2H
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call == 'PASS'
  CONDITION: my_last_call == 'PASS'
  CONDITION: support_in_partner_suit <= 2.5
  CONDITION: total_points <= 11.5
  CONDITION: partner_opened > 0.5
  CONDITION: opp_last_call == '2D'
  CONDITION: c_has_ten > 0.5
  CONDITION: major_hcp > 2.5
  # distilled from Brill /bid

RULE BD_False_P356:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call == 'PASS'
  CONDITION: my_last_call == 'PASS'
  CONDITION: support_in_partner_suit <= 2.5
  CONDITION: total_points <= 11.5
  CONDITION: partner_opened > 0.5
  CONDITION: opp_last_call != '2D'
  CONDITION: diamond_hcp <= 4.5
  # distilled from Brill /bid

RULE BD_False_P357:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call == 'PASS'
  CONDITION: my_last_call == 'PASS'
  CONDITION: support_in_partner_suit <= 2.5
  CONDITION: total_points <= 11.5
  CONDITION: partner_opened > 0.5
  CONDITION: opp_last_call != '2D'
  CONDITION: diamond_hcp > 4.5
  CONDITION: hcp <= 8.5
  # distilled from Brill /bid

RULE BD_False_P358:
  CALL: X
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call == 'PASS'
  CONDITION: my_last_call == 'PASS'
  CONDITION: support_in_partner_suit <= 2.5
  CONDITION: total_points <= 11.5
  CONDITION: partner_opened > 0.5
  CONDITION: opp_last_call != '2D'
  CONDITION: diamond_hcp > 4.5
  CONDITION: hcp > 8.5
  # distilled from Brill /bid

RULE BD_False_P359:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call == 'PASS'
  CONDITION: my_last_call == 'PASS'
  CONDITION: support_in_partner_suit <= 2.5
  CONDITION: total_points > 11.5
  CONDITION: opp_suit_stoppers <= 1.5
  CONDITION: third_longest_len <= 3.5
  CONDITION: diamond_hcp <= 1.5
  CONDITION: shape_pattern == '6322'
  CONDITION: auction_len <= 8.0
  # distilled from Brill /bid

RULE BD_False_P360:
  CALL: 3C
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call == 'PASS'
  CONDITION: my_last_call == 'PASS'
  CONDITION: support_in_partner_suit <= 2.5
  CONDITION: total_points > 11.5
  CONDITION: opp_suit_stoppers <= 1.5
  CONDITION: third_longest_len <= 3.5
  CONDITION: diamond_hcp <= 1.5
  CONDITION: shape_pattern == '6322'
  CONDITION: auction_len > 8.0
  # distilled from Brill /bid

RULE BD_False_P361:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call == 'PASS'
  CONDITION: my_last_call == 'PASS'
  CONDITION: support_in_partner_suit <= 2.5
  CONDITION: total_points > 11.5
  CONDITION: opp_suit_stoppers <= 1.5
  CONDITION: third_longest_len <= 3.5
  CONDITION: diamond_hcp <= 1.5
  CONDITION: shape_pattern != '6322'
  # distilled from Brill /bid

RULE BD_False_P362:
  CALL: X
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call == 'PASS'
  CONDITION: my_last_call == 'PASS'
  CONDITION: support_in_partner_suit <= 2.5
  CONDITION: total_points > 11.5
  CONDITION: opp_suit_stoppers <= 1.5
  CONDITION: third_longest_len <= 3.5
  CONDITION: diamond_hcp > 1.5
  CONDITION: h_has_ten <= 0.5
  CONDITION: partner_last_bid_strain == 'H'
  # distilled from Brill /bid

RULE BD_False_P363:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call == 'PASS'
  CONDITION: my_last_call == 'PASS'
  CONDITION: support_in_partner_suit <= 2.5
  CONDITION: total_points > 11.5
  CONDITION: opp_suit_stoppers <= 1.5
  CONDITION: third_longest_len <= 3.5
  CONDITION: diamond_hcp > 1.5
  CONDITION: h_has_ten <= 0.5
  CONDITION: partner_last_bid_strain != 'H'
  # distilled from Brill /bid

RULE BD_False_P364:
  CALL: X
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call == 'PASS'
  CONDITION: my_last_call == 'PASS'
  CONDITION: support_in_partner_suit <= 2.5
  CONDITION: total_points > 11.5
  CONDITION: opp_suit_stoppers <= 1.5
  CONDITION: third_longest_len <= 3.5
  CONDITION: diamond_hcp > 1.5
  CONDITION: h_has_ten > 0.5
  CONDITION: club_len <= 1.5
  # distilled from Brill /bid

RULE BD_False_P365:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call == 'PASS'
  CONDITION: my_last_call == 'PASS'
  CONDITION: support_in_partner_suit <= 2.5
  CONDITION: total_points > 11.5
  CONDITION: opp_suit_stoppers <= 1.5
  CONDITION: third_longest_len <= 3.5
  CONDITION: diamond_hcp > 1.5
  CONDITION: h_has_ten > 0.5
  CONDITION: club_len > 1.5
  # distilled from Brill /bid

RULE BD_False_P366:
  CALL: X
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call == 'PASS'
  CONDITION: my_last_call == 'PASS'
  CONDITION: support_in_partner_suit <= 2.5
  CONDITION: total_points > 11.5
  CONDITION: opp_suit_stoppers <= 1.5
  CONDITION: third_longest_len > 3.5
  CONDITION: last_bid_level <= 3.5
  CONDITION: d_has_ten <= 0.5
  # distilled from Brill /bid

RULE BD_False_P367:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call == 'PASS'
  CONDITION: my_last_call == 'PASS'
  CONDITION: support_in_partner_suit <= 2.5
  CONDITION: total_points > 11.5
  CONDITION: opp_suit_stoppers <= 1.5
  CONDITION: third_longest_len > 3.5
  CONDITION: last_bid_level <= 3.5
  CONDITION: d_has_ten > 0.5
  # distilled from Brill /bid

RULE BD_False_P368:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call == 'PASS'
  CONDITION: my_last_call == 'PASS'
  CONDITION: support_in_partner_suit <= 2.5
  CONDITION: total_points > 11.5
  CONDITION: opp_suit_stoppers <= 1.5
  CONDITION: third_longest_len > 3.5
  CONDITION: last_bid_level > 3.5
  # distilled from Brill /bid

RULE BD_False_P369:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call == 'PASS'
  CONDITION: my_last_call == 'PASS'
  CONDITION: support_in_partner_suit <= 2.5
  CONDITION: total_points > 11.5
  CONDITION: opp_suit_stoppers > 1.5
  CONDITION: opp_bid_count <= 6.5
  CONDITION: shape_pattern == '6331'
  CONDITION: hcp <= 14.5
  # distilled from Brill /bid

RULE BD_False_P370:
  CALL: 3D
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call == 'PASS'
  CONDITION: my_last_call == 'PASS'
  CONDITION: support_in_partner_suit <= 2.5
  CONDITION: total_points > 11.5
  CONDITION: opp_suit_stoppers > 1.5
  CONDITION: opp_bid_count <= 6.5
  CONDITION: shape_pattern == '6331'
  CONDITION: hcp > 14.5
  # distilled from Brill /bid

RULE BD_False_P371:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call == 'PASS'
  CONDITION: my_last_call == 'PASS'
  CONDITION: support_in_partner_suit <= 2.5
  CONDITION: total_points > 11.5
  CONDITION: opp_suit_stoppers > 1.5
  CONDITION: opp_bid_count <= 6.5
  CONDITION: shape_pattern != '6331'
  # distilled from Brill /bid

RULE BD_False_P372:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call == 'PASS'
  CONDITION: my_last_call == 'PASS'
  CONDITION: support_in_partner_suit <= 2.5
  CONDITION: total_points > 11.5
  CONDITION: opp_suit_stoppers > 1.5
  CONDITION: opp_bid_count > 6.5
  CONDITION: hcp <= 12.5
  # distilled from Brill /bid

RULE BD_False_P373:
  CALL: X
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call == 'PASS'
  CONDITION: my_last_call == 'PASS'
  CONDITION: support_in_partner_suit <= 2.5
  CONDITION: total_points > 11.5
  CONDITION: opp_suit_stoppers > 1.5
  CONDITION: opp_bid_count > 6.5
  CONDITION: hcp > 12.5
  # distilled from Brill /bid

RULE BD_False_P374:
  CALL: 2S
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call == 'PASS'
  CONDITION: my_last_call == 'PASS'
  CONDITION: support_in_partner_suit > 2.5
  CONDITION: auction_len <= 10.5
  CONDITION: controls <= 2.5
  CONDITION: opp_last_call == '2H'
  CONDITION: third_longest_len <= 2.5
  # distilled from Brill /bid

RULE BD_False_P375:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call == 'PASS'
  CONDITION: my_last_call == 'PASS'
  CONDITION: support_in_partner_suit > 2.5
  CONDITION: auction_len <= 10.5
  CONDITION: controls <= 2.5
  CONDITION: opp_last_call == '2H'
  CONDITION: third_longest_len > 2.5
  # distilled from Brill /bid

RULE BD_False_P376:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call == 'PASS'
  CONDITION: my_last_call == 'PASS'
  CONDITION: support_in_partner_suit > 2.5
  CONDITION: auction_len <= 10.5
  CONDITION: controls <= 2.5
  CONDITION: opp_last_call != '2H'
  CONDITION: heart_len <= 1.5
  CONDITION: minor_hcp <= 5.5
  # distilled from Brill /bid

RULE BD_False_P377:
  CALL: 5D
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call == 'PASS'
  CONDITION: my_last_call == 'PASS'
  CONDITION: support_in_partner_suit > 2.5
  CONDITION: auction_len <= 10.5
  CONDITION: controls <= 2.5
  CONDITION: opp_last_call != '2H'
  CONDITION: heart_len <= 1.5
  CONDITION: minor_hcp > 5.5
  # distilled from Brill /bid

RULE BD_False_P378:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call == 'PASS'
  CONDITION: my_last_call == 'PASS'
  CONDITION: support_in_partner_suit > 2.5
  CONDITION: auction_len <= 10.5
  CONDITION: controls <= 2.5
  CONDITION: opp_last_call != '2H'
  CONDITION: heart_len > 1.5
  # distilled from Brill /bid

RULE BD_False_P379:
  CALL: 3H
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call == 'PASS'
  CONDITION: my_last_call == 'PASS'
  CONDITION: support_in_partner_suit > 2.5
  CONDITION: auction_len <= 10.5
  CONDITION: controls > 2.5
  CONDITION: my_side_bid_count <= 2.5
  CONDITION: opp_last_call == '3C'
  # distilled from Brill /bid

RULE BD_False_P380:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call == 'PASS'
  CONDITION: my_last_call == 'PASS'
  CONDITION: support_in_partner_suit > 2.5
  CONDITION: auction_len <= 10.5
  CONDITION: controls > 2.5
  CONDITION: my_side_bid_count <= 2.5
  CONDITION: opp_last_call != '3C'
  CONDITION: minor_hcp <= 10.5
  # distilled from Brill /bid

RULE BD_False_P381:
  CALL: 3H
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call == 'PASS'
  CONDITION: my_last_call == 'PASS'
  CONDITION: support_in_partner_suit > 2.5
  CONDITION: auction_len <= 10.5
  CONDITION: controls > 2.5
  CONDITION: my_side_bid_count <= 2.5
  CONDITION: opp_last_call != '3C'
  CONDITION: minor_hcp > 10.5
  CONDITION: hcp <= 13.5
  # distilled from Brill /bid

RULE BD_False_P382:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call == 'PASS'
  CONDITION: my_last_call == 'PASS'
  CONDITION: support_in_partner_suit > 2.5
  CONDITION: auction_len <= 10.5
  CONDITION: controls > 2.5
  CONDITION: my_side_bid_count <= 2.5
  CONDITION: opp_last_call != '3C'
  CONDITION: minor_hcp > 10.5
  CONDITION: hcp > 13.5
  # distilled from Brill /bid

RULE BD_False_P383:
  CALL: X
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call == 'PASS'
  CONDITION: my_last_call == 'PASS'
  CONDITION: support_in_partner_suit > 2.5
  CONDITION: auction_len <= 10.5
  CONDITION: controls > 2.5
  CONDITION: my_side_bid_count > 2.5
  # distilled from Brill /bid

RULE BD_False_P384:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call == 'PASS'
  CONDITION: my_last_call == 'PASS'
  CONDITION: support_in_partner_suit > 2.5
  CONDITION: auction_len > 10.5
  CONDITION: partner_last_bid_strain == 'S'
  CONDITION: last_bid_level <= 3.5
  CONDITION: hcp <= 4.5
  # distilled from Brill /bid

RULE BD_False_P385:
  CALL: 3S
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call == 'PASS'
  CONDITION: my_last_call == 'PASS'
  CONDITION: support_in_partner_suit > 2.5
  CONDITION: auction_len > 10.5
  CONDITION: partner_last_bid_strain == 'S'
  CONDITION: last_bid_level <= 3.5
  CONDITION: hcp > 4.5
  # distilled from Brill /bid

RULE BD_False_P386:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call == 'PASS'
  CONDITION: my_last_call == 'PASS'
  CONDITION: support_in_partner_suit > 2.5
  CONDITION: auction_len > 10.5
  CONDITION: partner_last_bid_strain == 'S'
  CONDITION: last_bid_level > 3.5
  # distilled from Brill /bid

RULE BD_False_P387:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call == 'PASS'
  CONDITION: my_last_call == 'PASS'
  CONDITION: support_in_partner_suit > 2.5
  CONDITION: auction_len > 10.5
  CONDITION: partner_last_bid_strain != 'S'
  CONDITION: spade_hcp <= 4.5
  # distilled from Brill /bid

RULE BD_False_P388:
  CALL: 3D
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call == 'PASS'
  CONDITION: my_last_call == 'PASS'
  CONDITION: support_in_partner_suit > 2.5
  CONDITION: auction_len > 10.5
  CONDITION: partner_last_bid_strain != 'S'
  CONDITION: spade_hcp > 4.5
  # distilled from Brill /bid

RULE BD_False_P389:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call == 'PASS'
  CONDITION: my_last_call != 'PASS'
  CONDITION: total_points <= 14.5
  CONDITION: last_bid_level <= 2.5
  CONDITION: spade_len <= 4.5
  CONDITION: total_points <= 9.5
  CONDITION: support_in_partner_suit <= 3.5
  # distilled from Brill /bid

RULE BD_False_P390:
  CALL: 3D
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call == 'PASS'
  CONDITION: my_last_call != 'PASS'
  CONDITION: total_points <= 14.5
  CONDITION: last_bid_level <= 2.5
  CONDITION: spade_len <= 4.5
  CONDITION: total_points <= 9.5
  CONDITION: support_in_partner_suit > 3.5
  CONDITION: my_seat == 'W'
  # distilled from Brill /bid

RULE BD_False_P391:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call == 'PASS'
  CONDITION: my_last_call != 'PASS'
  CONDITION: total_points <= 14.5
  CONDITION: last_bid_level <= 2.5
  CONDITION: spade_len <= 4.5
  CONDITION: total_points <= 9.5
  CONDITION: support_in_partner_suit > 3.5
  CONDITION: my_seat != 'W'
  # distilled from Brill /bid

RULE BD_False_P392:
  CALL: 3D
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call == 'PASS'
  CONDITION: my_last_call != 'PASS'
  CONDITION: total_points <= 14.5
  CONDITION: last_bid_level <= 2.5
  CONDITION: spade_len <= 4.5
  CONDITION: total_points > 9.5
  CONDITION: partner_last_bid_strain == 'C'
  CONDITION: hcp <= 9.5
  # distilled from Brill /bid

RULE BD_False_P393:
  CALL: 3C
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call == 'PASS'
  CONDITION: my_last_call != 'PASS'
  CONDITION: total_points <= 14.5
  CONDITION: last_bid_level <= 2.5
  CONDITION: spade_len <= 4.5
  CONDITION: total_points > 9.5
  CONDITION: partner_last_bid_strain == 'C'
  CONDITION: hcp > 9.5
  # distilled from Brill /bid

RULE BD_False_P394:
  CALL: X
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call == 'PASS'
  CONDITION: my_last_call != 'PASS'
  CONDITION: total_points <= 14.5
  CONDITION: last_bid_level <= 2.5
  CONDITION: spade_len <= 4.5
  CONDITION: total_points > 9.5
  CONDITION: partner_last_bid_strain != 'C'
  CONDITION: is_vulnerable <= 0.5
  CONDITION: losing_trick_count <= 5.5
  # distilled from Brill /bid

RULE BD_False_P395:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call == 'PASS'
  CONDITION: my_last_call != 'PASS'
  CONDITION: total_points <= 14.5
  CONDITION: last_bid_level <= 2.5
  CONDITION: spade_len <= 4.5
  CONDITION: total_points > 9.5
  CONDITION: partner_last_bid_strain != 'C'
  CONDITION: is_vulnerable <= 0.5
  CONDITION: losing_trick_count > 5.5
  # distilled from Brill /bid

RULE BD_False_P396:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call == 'PASS'
  CONDITION: my_last_call != 'PASS'
  CONDITION: total_points <= 14.5
  CONDITION: last_bid_level <= 2.5
  CONDITION: spade_len <= 4.5
  CONDITION: total_points > 9.5
  CONDITION: partner_last_bid_strain != 'C'
  CONDITION: is_vulnerable > 0.5
  CONDITION: last_bid_strain == 'D'
  # distilled from Brill /bid

RULE BD_False_P397:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call == 'PASS'
  CONDITION: my_last_call != 'PASS'
  CONDITION: total_points <= 14.5
  CONDITION: last_bid_level <= 2.5
  CONDITION: spade_len <= 4.5
  CONDITION: total_points > 9.5
  CONDITION: partner_last_bid_strain != 'C'
  CONDITION: is_vulnerable > 0.5
  CONDITION: last_bid_strain != 'D'
  # distilled from Brill /bid

RULE BD_False_P398:
  CALL: 2S
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call == 'PASS'
  CONDITION: my_last_call != 'PASS'
  CONDITION: total_points <= 14.5
  CONDITION: last_bid_level <= 2.5
  CONDITION: spade_len > 4.5
  CONDITION: partner_last_bid_strain == 'D'
  CONDITION: hcp <= 10.0
  # distilled from Brill /bid

RULE BD_False_P399:
  CALL: X
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call == 'PASS'
  CONDITION: my_last_call != 'PASS'
  CONDITION: total_points <= 14.5
  CONDITION: last_bid_level <= 2.5
  CONDITION: spade_len > 4.5
  CONDITION: partner_last_bid_strain == 'D'
  CONDITION: hcp > 10.0
  # distilled from Brill /bid

RULE BD_False_P400:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call == 'PASS'
  CONDITION: my_last_call != 'PASS'
  CONDITION: total_points <= 14.5
  CONDITION: last_bid_level <= 2.5
  CONDITION: spade_len > 4.5
  CONDITION: partner_last_bid_strain != 'D'
  CONDITION: last_bid_strain == 'NT'
  # distilled from Brill /bid

RULE BD_False_P401:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call == 'PASS'
  CONDITION: my_last_call != 'PASS'
  CONDITION: total_points <= 14.5
  CONDITION: last_bid_level <= 2.5
  CONDITION: spade_len > 4.5
  CONDITION: partner_last_bid_strain != 'D'
  CONDITION: last_bid_strain != 'NT'
  CONDITION: heart_hcp <= 3.5
  CONDITION: heart_len <= 2.5
  # distilled from Brill /bid

RULE BD_False_P402:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call == 'PASS'
  CONDITION: my_last_call != 'PASS'
  CONDITION: total_points <= 14.5
  CONDITION: last_bid_level <= 2.5
  CONDITION: spade_len > 4.5
  CONDITION: partner_last_bid_strain != 'D'
  CONDITION: last_bid_strain != 'NT'
  CONDITION: heart_hcp <= 3.5
  CONDITION: heart_len > 2.5
  # distilled from Brill /bid

RULE BD_False_P403:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call == 'PASS'
  CONDITION: my_last_call != 'PASS'
  CONDITION: total_points <= 14.5
  CONDITION: last_bid_level <= 2.5
  CONDITION: spade_len > 4.5
  CONDITION: partner_last_bid_strain != 'D'
  CONDITION: last_bid_strain != 'NT'
  CONDITION: heart_hcp > 3.5
  CONDITION: hcp <= 9.5
  # distilled from Brill /bid

RULE BD_False_P404:
  CALL: 2S
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call == 'PASS'
  CONDITION: my_last_call != 'PASS'
  CONDITION: total_points <= 14.5
  CONDITION: last_bid_level <= 2.5
  CONDITION: spade_len > 4.5
  CONDITION: partner_last_bid_strain != 'D'
  CONDITION: last_bid_strain != 'NT'
  CONDITION: heart_hcp > 3.5
  CONDITION: hcp > 9.5
  # distilled from Brill /bid

RULE BD_False_P405:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call == 'PASS'
  CONDITION: my_last_call != 'PASS'
  CONDITION: total_points <= 14.5
  CONDITION: last_bid_level > 2.5
  CONDITION: partner_last_bid_strain == 'NONE'
  CONDITION: c_has_ace <= 0.5
  CONDITION: hcp <= 4.5
  CONDITION: diamond_hcp <= 2.0
  # distilled from Brill /bid

RULE BD_False_P406:
  CALL: 3S
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call == 'PASS'
  CONDITION: my_last_call != 'PASS'
  CONDITION: total_points <= 14.5
  CONDITION: last_bid_level > 2.5
  CONDITION: partner_last_bid_strain == 'NONE'
  CONDITION: c_has_ace <= 0.5
  CONDITION: hcp <= 4.5
  CONDITION: diamond_hcp > 2.0
  # distilled from Brill /bid

RULE BD_False_P407:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call == 'PASS'
  CONDITION: my_last_call != 'PASS'
  CONDITION: total_points <= 14.5
  CONDITION: last_bid_level > 2.5
  CONDITION: partner_last_bid_strain == 'NONE'
  CONDITION: c_has_ace <= 0.5
  CONDITION: hcp > 4.5
  # distilled from Brill /bid

RULE BD_False_P408:
  CALL: 4NT
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call == 'PASS'
  CONDITION: my_last_call != 'PASS'
  CONDITION: total_points <= 14.5
  CONDITION: last_bid_level > 2.5
  CONDITION: partner_last_bid_strain == 'NONE'
  CONDITION: c_has_ace > 0.5
  CONDITION: auction_len <= 3.5
  CONDITION: losing_trick_count <= 6.5
  CONDITION: major_hcp <= 2.5
  # distilled from Brill /bid

RULE BD_False_P409:
  CALL: 3D
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call == 'PASS'
  CONDITION: my_last_call != 'PASS'
  CONDITION: total_points <= 14.5
  CONDITION: last_bid_level > 2.5
  CONDITION: partner_last_bid_strain == 'NONE'
  CONDITION: c_has_ace > 0.5
  CONDITION: auction_len <= 3.5
  CONDITION: losing_trick_count <= 6.5
  CONDITION: major_hcp > 2.5
  # distilled from Brill /bid

RULE BD_False_P410:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call == 'PASS'
  CONDITION: my_last_call != 'PASS'
  CONDITION: total_points <= 14.5
  CONDITION: last_bid_level > 2.5
  CONDITION: partner_last_bid_strain == 'NONE'
  CONDITION: c_has_ace > 0.5
  CONDITION: auction_len <= 3.5
  CONDITION: losing_trick_count > 6.5
  # distilled from Brill /bid

RULE BD_False_P411:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call == 'PASS'
  CONDITION: my_last_call != 'PASS'
  CONDITION: total_points <= 14.5
  CONDITION: last_bid_level > 2.5
  CONDITION: partner_last_bid_strain == 'NONE'
  CONDITION: c_has_ace > 0.5
  CONDITION: auction_len > 3.5
  # distilled from Brill /bid

RULE BD_False_P412:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call == 'PASS'
  CONDITION: my_last_call != 'PASS'
  CONDITION: total_points <= 14.5
  CONDITION: last_bid_level > 2.5
  CONDITION: partner_last_bid_strain != 'NONE'
  CONDITION: h_top2_honors <= 0.5
  CONDITION: d_has_queen <= 0.5
  CONDITION: my_last_call == '2S'
  CONDITION: losing_trick_count <= 8.5
  # distilled from Brill /bid

RULE BD_False_P413:
  CALL: 3S
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call == 'PASS'
  CONDITION: my_last_call != 'PASS'
  CONDITION: total_points <= 14.5
  CONDITION: last_bid_level > 2.5
  CONDITION: partner_last_bid_strain != 'NONE'
  CONDITION: h_top2_honors <= 0.5
  CONDITION: d_has_queen <= 0.5
  CONDITION: my_last_call == '2S'
  CONDITION: losing_trick_count > 8.5
  # distilled from Brill /bid

RULE BD_False_P414:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call == 'PASS'
  CONDITION: my_last_call != 'PASS'
  CONDITION: total_points <= 14.5
  CONDITION: last_bid_level > 2.5
  CONDITION: partner_last_bid_strain != 'NONE'
  CONDITION: h_top2_honors <= 0.5
  CONDITION: d_has_queen <= 0.5
  CONDITION: my_last_call != '2S'
  CONDITION: s_has_jack <= 0.5
  # distilled from Brill /bid

RULE BD_False_P415:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call == 'PASS'
  CONDITION: my_last_call != 'PASS'
  CONDITION: total_points <= 14.5
  CONDITION: last_bid_level > 2.5
  CONDITION: partner_last_bid_strain != 'NONE'
  CONDITION: h_top2_honors <= 0.5
  CONDITION: d_has_queen <= 0.5
  CONDITION: my_last_call != '2S'
  CONDITION: s_has_jack > 0.5
  # distilled from Brill /bid

RULE BD_False_P416:
  CALL: 3H
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call == 'PASS'
  CONDITION: my_last_call != 'PASS'
  CONDITION: total_points <= 14.5
  CONDITION: last_bid_level > 2.5
  CONDITION: partner_last_bid_strain != 'NONE'
  CONDITION: h_top2_honors <= 0.5
  CONDITION: d_has_queen > 0.5
  CONDITION: partner_last_bid_strain == 'H'
  CONDITION: hcp <= 9.5
  # distilled from Brill /bid

RULE BD_False_P417:
  CALL: 3D
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call == 'PASS'
  CONDITION: my_last_call != 'PASS'
  CONDITION: total_points <= 14.5
  CONDITION: last_bid_level > 2.5
  CONDITION: partner_last_bid_strain != 'NONE'
  CONDITION: h_top2_honors <= 0.5
  CONDITION: d_has_queen > 0.5
  CONDITION: partner_last_bid_strain == 'H'
  CONDITION: hcp > 9.5
  # distilled from Brill /bid

RULE BD_False_P418:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call == 'PASS'
  CONDITION: my_last_call != 'PASS'
  CONDITION: total_points <= 14.5
  CONDITION: last_bid_level > 2.5
  CONDITION: partner_last_bid_strain != 'NONE'
  CONDITION: h_top2_honors <= 0.5
  CONDITION: d_has_queen > 0.5
  CONDITION: partner_last_bid_strain != 'H'
  CONDITION: support_in_partner_suit <= 3.5
  # distilled from Brill /bid

RULE BD_False_P419:
  CALL: 3S
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call == 'PASS'
  CONDITION: my_last_call != 'PASS'
  CONDITION: total_points <= 14.5
  CONDITION: last_bid_level > 2.5
  CONDITION: partner_last_bid_strain != 'NONE'
  CONDITION: h_top2_honors <= 0.5
  CONDITION: d_has_queen > 0.5
  CONDITION: partner_last_bid_strain != 'H'
  CONDITION: support_in_partner_suit > 3.5
  # distilled from Brill /bid

RULE BD_False_P420:
  CALL: 3NT
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call == 'PASS'
  CONDITION: my_last_call != 'PASS'
  CONDITION: total_points <= 14.5
  CONDITION: last_bid_level > 2.5
  CONDITION: partner_last_bid_strain != 'NONE'
  CONDITION: h_top2_honors > 0.5
  CONDITION: jack_count <= 0.5
  CONDITION: shape_pattern == '5422'
  # distilled from Brill /bid

RULE BD_False_P421:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call == 'PASS'
  CONDITION: my_last_call != 'PASS'
  CONDITION: total_points <= 14.5
  CONDITION: last_bid_level > 2.5
  CONDITION: partner_last_bid_strain != 'NONE'
  CONDITION: h_top2_honors > 0.5
  CONDITION: jack_count <= 0.5
  CONDITION: shape_pattern != '5422'
  # distilled from Brill /bid

RULE BD_False_P422:
  CALL: 5H
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call == 'PASS'
  CONDITION: my_last_call != 'PASS'
  CONDITION: total_points <= 14.5
  CONDITION: last_bid_level > 2.5
  CONDITION: partner_last_bid_strain != 'NONE'
  CONDITION: h_top2_honors > 0.5
  CONDITION: jack_count > 0.5
  CONDITION: opp_last_call == '4S'
  CONDITION: last_bid_seat == 'N'
  # distilled from Brill /bid

RULE BD_False_P423:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call == 'PASS'
  CONDITION: my_last_call != 'PASS'
  CONDITION: total_points <= 14.5
  CONDITION: last_bid_level > 2.5
  CONDITION: partner_last_bid_strain != 'NONE'
  CONDITION: h_top2_honors > 0.5
  CONDITION: jack_count > 0.5
  CONDITION: opp_last_call == '4S'
  CONDITION: last_bid_seat != 'N'
  # distilled from Brill /bid

RULE BD_False_P424:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call == 'PASS'
  CONDITION: my_last_call != 'PASS'
  CONDITION: total_points <= 14.5
  CONDITION: last_bid_level > 2.5
  CONDITION: partner_last_bid_strain != 'NONE'
  CONDITION: h_top2_honors > 0.5
  CONDITION: jack_count > 0.5
  CONDITION: opp_last_call != '4S'
  CONDITION: my_last_call == '3D'
  # distilled from Brill /bid

RULE BD_False_P425:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call == 'PASS'
  CONDITION: my_last_call != 'PASS'
  CONDITION: total_points <= 14.5
  CONDITION: last_bid_level > 2.5
  CONDITION: partner_last_bid_strain != 'NONE'
  CONDITION: h_top2_honors > 0.5
  CONDITION: jack_count > 0.5
  CONDITION: opp_last_call != '4S'
  CONDITION: my_last_call != '3D'
  # distilled from Brill /bid

RULE BD_False_P426:
  CALL: 2H
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call == 'PASS'
  CONDITION: my_last_call != 'PASS'
  CONDITION: total_points > 14.5
  CONDITION: spade_len <= 5.5
  CONDITION: longest_suit_len <= 5.5
  CONDITION: competition_level <= 1.5
  CONDITION: opp_last_call == '2D'
  CONDITION: diamond_hcp <= 2.5
  # distilled from Brill /bid

RULE BD_False_P427:
  CALL: 2S
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call == 'PASS'
  CONDITION: my_last_call != 'PASS'
  CONDITION: total_points > 14.5
  CONDITION: spade_len <= 5.5
  CONDITION: longest_suit_len <= 5.5
  CONDITION: competition_level <= 1.5
  CONDITION: opp_last_call == '2D'
  CONDITION: diamond_hcp > 2.5
  CONDITION: hcp <= 14.5
  # distilled from Brill /bid

RULE BD_False_P428:
  CALL: 2NT
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call == 'PASS'
  CONDITION: my_last_call != 'PASS'
  CONDITION: total_points > 14.5
  CONDITION: spade_len <= 5.5
  CONDITION: longest_suit_len <= 5.5
  CONDITION: competition_level <= 1.5
  CONDITION: opp_last_call == '2D'
  CONDITION: diamond_hcp > 2.5
  CONDITION: hcp > 14.5
  # distilled from Brill /bid

RULE BD_False_P429:
  CALL: X
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call == 'PASS'
  CONDITION: my_last_call != 'PASS'
  CONDITION: total_points > 14.5
  CONDITION: spade_len <= 5.5
  CONDITION: longest_suit_len <= 5.5
  CONDITION: competition_level <= 1.5
  CONDITION: opp_last_call != '2D'
  CONDITION: major_hcp <= 7.5
  CONDITION: spade_len <= 2.5
  # distilled from Brill /bid

RULE BD_False_P430:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call == 'PASS'
  CONDITION: my_last_call != 'PASS'
  CONDITION: total_points > 14.5
  CONDITION: spade_len <= 5.5
  CONDITION: longest_suit_len <= 5.5
  CONDITION: competition_level <= 1.5
  CONDITION: opp_last_call != '2D'
  CONDITION: major_hcp <= 7.5
  CONDITION: spade_len > 2.5
  # distilled from Brill /bid

RULE BD_False_P431:
  CALL: 2NT
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call == 'PASS'
  CONDITION: my_last_call != 'PASS'
  CONDITION: total_points > 14.5
  CONDITION: spade_len <= 5.5
  CONDITION: longest_suit_len <= 5.5
  CONDITION: competition_level <= 1.5
  CONDITION: opp_last_call != '2D'
  CONDITION: major_hcp > 7.5
  CONDITION: s_has_ace <= 0.5
  # distilled from Brill /bid

RULE BD_False_P432:
  CALL: X
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call == 'PASS'
  CONDITION: my_last_call != 'PASS'
  CONDITION: total_points > 14.5
  CONDITION: spade_len <= 5.5
  CONDITION: longest_suit_len <= 5.5
  CONDITION: competition_level <= 1.5
  CONDITION: opp_last_call != '2D'
  CONDITION: major_hcp > 7.5
  CONDITION: s_has_ace > 0.5
  # distilled from Brill /bid

RULE BD_False_P433:
  CALL: 3NT
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call == 'PASS'
  CONDITION: my_last_call != 'PASS'
  CONDITION: total_points > 14.5
  CONDITION: spade_len <= 5.5
  CONDITION: longest_suit_len <= 5.5
  CONDITION: competition_level > 1.5
  CONDITION: rule20_total <= 25.5
  CONDITION: competition_level <= 4.5
  CONDITION: partner_last_bid_strain == 'C'
  # distilled from Brill /bid

RULE BD_False_P434:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call == 'PASS'
  CONDITION: my_last_call != 'PASS'
  CONDITION: total_points > 14.5
  CONDITION: spade_len <= 5.5
  CONDITION: longest_suit_len <= 5.5
  CONDITION: competition_level > 1.5
  CONDITION: rule20_total <= 25.5
  CONDITION: competition_level <= 4.5
  CONDITION: partner_last_bid_strain != 'C'
  # distilled from Brill /bid

RULE BD_False_P435:
  CALL: 2NT
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call == 'PASS'
  CONDITION: my_last_call != 'PASS'
  CONDITION: total_points > 14.5
  CONDITION: spade_len <= 5.5
  CONDITION: longest_suit_len <= 5.5
  CONDITION: competition_level > 1.5
  CONDITION: rule20_total <= 25.5
  CONDITION: competition_level > 4.5
  CONDITION: last_bid_level <= 2.5
  # distilled from Brill /bid

RULE BD_False_P436:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call == 'PASS'
  CONDITION: my_last_call != 'PASS'
  CONDITION: total_points > 14.5
  CONDITION: spade_len <= 5.5
  CONDITION: longest_suit_len <= 5.5
  CONDITION: competition_level > 1.5
  CONDITION: rule20_total <= 25.5
  CONDITION: competition_level > 4.5
  CONDITION: last_bid_level > 2.5
  # distilled from Brill /bid

RULE BD_False_P437:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call == 'PASS'
  CONDITION: my_last_call != 'PASS'
  CONDITION: total_points > 14.5
  CONDITION: spade_len <= 5.5
  CONDITION: longest_suit_len <= 5.5
  CONDITION: competition_level > 1.5
  CONDITION: rule20_total > 25.5
  CONDITION: s_is_best_major <= 0.5
  CONDITION: opp_last_call == '2S'
  # distilled from Brill /bid

RULE BD_False_P438:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call == 'PASS'
  CONDITION: my_last_call != 'PASS'
  CONDITION: total_points > 14.5
  CONDITION: spade_len <= 5.5
  CONDITION: longest_suit_len <= 5.5
  CONDITION: competition_level > 1.5
  CONDITION: rule20_total > 25.5
  CONDITION: s_is_best_major <= 0.5
  CONDITION: opp_last_call != '2S'
  # distilled from Brill /bid

RULE BD_False_P439:
  CALL: 2S
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call == 'PASS'
  CONDITION: my_last_call != 'PASS'
  CONDITION: total_points > 14.5
  CONDITION: spade_len <= 5.5
  CONDITION: longest_suit_len <= 5.5
  CONDITION: competition_level > 1.5
  CONDITION: rule20_total > 25.5
  CONDITION: s_is_best_major > 0.5
  CONDITION: last_bid_level <= 2.5
  # distilled from Brill /bid

RULE BD_False_P440:
  CALL: X
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call == 'PASS'
  CONDITION: my_last_call != 'PASS'
  CONDITION: total_points > 14.5
  CONDITION: spade_len <= 5.5
  CONDITION: longest_suit_len <= 5.5
  CONDITION: competition_level > 1.5
  CONDITION: rule20_total > 25.5
  CONDITION: s_is_best_major > 0.5
  CONDITION: last_bid_level > 2.5
  # distilled from Brill /bid

RULE BD_False_P441:
  CALL: 4C
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call == 'PASS'
  CONDITION: my_last_call != 'PASS'
  CONDITION: total_points > 14.5
  CONDITION: spade_len <= 5.5
  CONDITION: longest_suit_len > 5.5
  CONDITION: diamond_len <= 4.5
  CONDITION: losing_trick_count <= 4.5
  CONDITION: is_balancing <= 0.5
  CONDITION: heart_len <= 5.0
  # distilled from Brill /bid

RULE BD_False_P442:
  CALL: 4H
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call == 'PASS'
  CONDITION: my_last_call != 'PASS'
  CONDITION: total_points > 14.5
  CONDITION: spade_len <= 5.5
  CONDITION: longest_suit_len > 5.5
  CONDITION: diamond_len <= 4.5
  CONDITION: losing_trick_count <= 4.5
  CONDITION: is_balancing <= 0.5
  CONDITION: heart_len > 5.0
  # distilled from Brill /bid

RULE BD_False_P443:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call == 'PASS'
  CONDITION: my_last_call != 'PASS'
  CONDITION: total_points > 14.5
  CONDITION: spade_len <= 5.5
  CONDITION: longest_suit_len > 5.5
  CONDITION: diamond_len <= 4.5
  CONDITION: losing_trick_count <= 4.5
  CONDITION: is_balancing > 0.5
  CONDITION: hcp <= 17.5
  # distilled from Brill /bid

RULE BD_False_P444:
  CALL: 4H
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call == 'PASS'
  CONDITION: my_last_call != 'PASS'
  CONDITION: total_points > 14.5
  CONDITION: spade_len <= 5.5
  CONDITION: longest_suit_len > 5.5
  CONDITION: diamond_len <= 4.5
  CONDITION: losing_trick_count <= 4.5
  CONDITION: is_balancing > 0.5
  CONDITION: hcp > 17.5
  # distilled from Brill /bid

RULE BD_False_P445:
  CALL: 3H
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call == 'PASS'
  CONDITION: my_last_call != 'PASS'
  CONDITION: total_points > 14.5
  CONDITION: spade_len <= 5.5
  CONDITION: longest_suit_len > 5.5
  CONDITION: diamond_len <= 4.5
  CONDITION: losing_trick_count > 4.5
  CONDITION: club_len <= 3.5
  CONDITION: competition_level <= 3.5
  # distilled from Brill /bid

RULE BD_False_P446:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call == 'PASS'
  CONDITION: my_last_call != 'PASS'
  CONDITION: total_points > 14.5
  CONDITION: spade_len <= 5.5
  CONDITION: longest_suit_len > 5.5
  CONDITION: diamond_len <= 4.5
  CONDITION: losing_trick_count > 4.5
  CONDITION: club_len <= 3.5
  CONDITION: competition_level > 3.5
  # distilled from Brill /bid

RULE BD_False_P447:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call == 'PASS'
  CONDITION: my_last_call != 'PASS'
  CONDITION: total_points > 14.5
  CONDITION: spade_len <= 5.5
  CONDITION: longest_suit_len > 5.5
  CONDITION: diamond_len <= 4.5
  CONDITION: losing_trick_count > 4.5
  CONDITION: club_len > 3.5
  CONDITION: queen_count <= 1.5
  # distilled from Brill /bid

RULE BD_False_P448:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call == 'PASS'
  CONDITION: my_last_call != 'PASS'
  CONDITION: total_points > 14.5
  CONDITION: spade_len <= 5.5
  CONDITION: longest_suit_len > 5.5
  CONDITION: diamond_len <= 4.5
  CONDITION: losing_trick_count > 4.5
  CONDITION: club_len > 3.5
  CONDITION: queen_count > 1.5
  # distilled from Brill /bid

RULE BD_False_P449:
  CALL: 4D
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call == 'PASS'
  CONDITION: my_last_call != 'PASS'
  CONDITION: total_points > 14.5
  CONDITION: spade_len <= 5.5
  CONDITION: longest_suit_len > 5.5
  CONDITION: diamond_len > 4.5
  CONDITION: opp_last_call == '3S'
  CONDITION: king_count <= 2.5
  # distilled from Brill /bid

RULE BD_False_P450:
  CALL: 4S
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call == 'PASS'
  CONDITION: my_last_call != 'PASS'
  CONDITION: total_points > 14.5
  CONDITION: spade_len <= 5.5
  CONDITION: longest_suit_len > 5.5
  CONDITION: diamond_len > 4.5
  CONDITION: opp_last_call == '3S'
  CONDITION: king_count > 2.5
  CONDITION: hcp <= 17.0
  # distilled from Brill /bid

RULE BD_False_P451:
  CALL: X
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call == 'PASS'
  CONDITION: my_last_call != 'PASS'
  CONDITION: total_points > 14.5
  CONDITION: spade_len <= 5.5
  CONDITION: longest_suit_len > 5.5
  CONDITION: diamond_len > 4.5
  CONDITION: opp_last_call == '3S'
  CONDITION: king_count > 2.5
  CONDITION: hcp > 17.0
  # distilled from Brill /bid

RULE BD_False_P452:
  CALL: X
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call == 'PASS'
  CONDITION: my_last_call != 'PASS'
  CONDITION: total_points > 14.5
  CONDITION: spade_len <= 5.5
  CONDITION: longest_suit_len > 5.5
  CONDITION: diamond_len > 4.5
  CONDITION: opp_last_call != '3S'
  CONDITION: losing_trick_count <= 4.5
  CONDITION: last_bid_level <= 3.5
  # distilled from Brill /bid

RULE BD_False_P453:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call == 'PASS'
  CONDITION: my_last_call != 'PASS'
  CONDITION: total_points > 14.5
  CONDITION: spade_len <= 5.5
  CONDITION: longest_suit_len > 5.5
  CONDITION: diamond_len > 4.5
  CONDITION: opp_last_call != '3S'
  CONDITION: losing_trick_count <= 4.5
  CONDITION: last_bid_level > 3.5
  # distilled from Brill /bid

RULE BD_False_P454:
  CALL: 3D
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call == 'PASS'
  CONDITION: my_last_call != 'PASS'
  CONDITION: total_points > 14.5
  CONDITION: spade_len <= 5.5
  CONDITION: longest_suit_len > 5.5
  CONDITION: diamond_len > 4.5
  CONDITION: opp_last_call != '3S'
  CONDITION: losing_trick_count > 4.5
  CONDITION: major_hcp <= 5.5
  # distilled from Brill /bid

RULE BD_False_P455:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call == 'PASS'
  CONDITION: my_last_call != 'PASS'
  CONDITION: total_points > 14.5
  CONDITION: spade_len <= 5.5
  CONDITION: longest_suit_len > 5.5
  CONDITION: diamond_len > 4.5
  CONDITION: opp_last_call != '3S'
  CONDITION: losing_trick_count > 4.5
  CONDITION: major_hcp > 5.5
  # distilled from Brill /bid

RULE BD_False_P456:
  CALL: 4S
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call == 'PASS'
  CONDITION: my_last_call != 'PASS'
  CONDITION: total_points > 14.5
  CONDITION: spade_len > 5.5
  CONDITION: last_bid_level <= 2.5
  CONDITION: auction_len <= 3.5
  # distilled from Brill /bid

RULE BD_False_P457:
  CALL: 2S
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call == 'PASS'
  CONDITION: my_last_call != 'PASS'
  CONDITION: total_points > 14.5
  CONDITION: spade_len > 5.5
  CONDITION: last_bid_level <= 2.5
  CONDITION: auction_len > 3.5
  # distilled from Brill /bid

RULE BD_False_P458:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call == 'PASS'
  CONDITION: my_last_call != 'PASS'
  CONDITION: total_points > 14.5
  CONDITION: spade_len > 5.5
  CONDITION: last_bid_level > 2.5
  CONDITION: competition_level <= 3.5
  CONDITION: diamond_len <= 0.5
  # distilled from Brill /bid

RULE BD_False_P459:
  CALL: 3S
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call == 'PASS'
  CONDITION: my_last_call != 'PASS'
  CONDITION: total_points > 14.5
  CONDITION: spade_len > 5.5
  CONDITION: last_bid_level > 2.5
  CONDITION: competition_level <= 3.5
  CONDITION: diamond_len > 0.5
  CONDITION: auction_len <= 4.5
  CONDITION: hcp <= 13.5
  # distilled from Brill /bid

RULE BD_False_P460:
  CALL: 4S
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call == 'PASS'
  CONDITION: my_last_call != 'PASS'
  CONDITION: total_points > 14.5
  CONDITION: spade_len > 5.5
  CONDITION: last_bid_level > 2.5
  CONDITION: competition_level <= 3.5
  CONDITION: diamond_len > 0.5
  CONDITION: auction_len <= 4.5
  CONDITION: hcp > 13.5
  # distilled from Brill /bid

RULE BD_False_P461:
  CALL: 3S
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call == 'PASS'
  CONDITION: my_last_call != 'PASS'
  CONDITION: total_points > 14.5
  CONDITION: spade_len > 5.5
  CONDITION: last_bid_level > 2.5
  CONDITION: competition_level <= 3.5
  CONDITION: diamond_len > 0.5
  CONDITION: auction_len > 4.5
  # distilled from Brill /bid

RULE BD_False_P462:
  CALL: X
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call == 'PASS'
  CONDITION: my_last_call != 'PASS'
  CONDITION: total_points > 14.5
  CONDITION: spade_len > 5.5
  CONDITION: last_bid_level > 2.5
  CONDITION: competition_level > 3.5
  CONDITION: minor_hcp <= 4.5
  # distilled from Brill /bid

RULE BD_False_P463:
  CALL: 5S
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call == 'PASS'
  CONDITION: my_last_call != 'PASS'
  CONDITION: total_points > 14.5
  CONDITION: spade_len > 5.5
  CONDITION: last_bid_level > 2.5
  CONDITION: competition_level > 3.5
  CONDITION: minor_hcp > 4.5
  CONDITION: major_hcp <= 6.5
  CONDITION: auction_len <= 10.0
  # distilled from Brill /bid

RULE BD_False_P464:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call == 'PASS'
  CONDITION: my_last_call != 'PASS'
  CONDITION: total_points > 14.5
  CONDITION: spade_len > 5.5
  CONDITION: last_bid_level > 2.5
  CONDITION: competition_level > 3.5
  CONDITION: minor_hcp > 4.5
  CONDITION: major_hcp <= 6.5
  CONDITION: auction_len > 10.0
  # distilled from Brill /bid

RULE BD_False_P465:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call == 'PASS'
  CONDITION: my_last_call != 'PASS'
  CONDITION: total_points > 14.5
  CONDITION: spade_len > 5.5
  CONDITION: last_bid_level > 2.5
  CONDITION: competition_level > 3.5
  CONDITION: minor_hcp > 4.5
  CONDITION: major_hcp > 6.5
  # distilled from Brill /bid

RULE BD_False_P466:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call != 'PASS'
  CONDITION: last_bid_level <= 2.5
  CONDITION: last_bid_strain == 'C'
  CONDITION: hcp <= 7.5
  CONDITION: competition_level <= 1.5
  CONDITION: auction_len <= 1.5
  # distilled from Brill /bid

RULE BD_False_P467:
  CALL: 2D
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call != 'PASS'
  CONDITION: last_bid_level <= 2.5
  CONDITION: last_bid_strain == 'C'
  CONDITION: hcp <= 7.5
  CONDITION: competition_level <= 1.5
  CONDITION: auction_len > 1.5
  # distilled from Brill /bid

RULE BD_False_P468:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call != 'PASS'
  CONDITION: last_bid_level <= 2.5
  CONDITION: last_bid_strain == 'C'
  CONDITION: hcp <= 7.5
  CONDITION: competition_level > 1.5
  CONDITION: partner_last_call == '1S'
  CONDITION: spade_len <= 2.5
  # distilled from Brill /bid

RULE BD_False_P469:
  CALL: 3S
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call != 'PASS'
  CONDITION: last_bid_level <= 2.5
  CONDITION: last_bid_strain == 'C'
  CONDITION: hcp <= 7.5
  CONDITION: competition_level > 1.5
  CONDITION: partner_last_call == '1S'
  CONDITION: spade_len > 2.5
  CONDITION: minor_hcp <= 0.5
  CONDITION: hcp <= 4.0
  # distilled from Brill /bid

RULE BD_False_P470:
  CALL: 4S
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call != 'PASS'
  CONDITION: last_bid_level <= 2.5
  CONDITION: last_bid_strain == 'C'
  CONDITION: hcp <= 7.5
  CONDITION: competition_level > 1.5
  CONDITION: partner_last_call == '1S'
  CONDITION: spade_len > 2.5
  CONDITION: minor_hcp <= 0.5
  CONDITION: hcp > 4.0
  # distilled from Brill /bid

RULE BD_False_P471:
  CALL: 2S
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call != 'PASS'
  CONDITION: last_bid_level <= 2.5
  CONDITION: last_bid_strain == 'C'
  CONDITION: hcp <= 7.5
  CONDITION: competition_level > 1.5
  CONDITION: partner_last_call == '1S'
  CONDITION: spade_len > 2.5
  CONDITION: minor_hcp > 0.5
  # distilled from Brill /bid

RULE BD_False_P472:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call != 'PASS'
  CONDITION: last_bid_level <= 2.5
  CONDITION: last_bid_strain == 'C'
  CONDITION: hcp <= 7.5
  CONDITION: competition_level > 1.5
  CONDITION: partner_last_call != '1S'
  CONDITION: spade_len <= 5.5
  CONDITION: partner_last_call == '2C'
  CONDITION: diamond_len <= 4.5
  # distilled from Brill /bid

RULE BD_False_P473:
  CALL: 2D
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call != 'PASS'
  CONDITION: last_bid_level <= 2.5
  CONDITION: last_bid_strain == 'C'
  CONDITION: hcp <= 7.5
  CONDITION: competition_level > 1.5
  CONDITION: partner_last_call != '1S'
  CONDITION: spade_len <= 5.5
  CONDITION: partner_last_call == '2C'
  CONDITION: diamond_len > 4.5
  # distilled from Brill /bid

RULE BD_False_P474:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call != 'PASS'
  CONDITION: last_bid_level <= 2.5
  CONDITION: last_bid_strain == 'C'
  CONDITION: hcp <= 7.5
  CONDITION: competition_level > 1.5
  CONDITION: partner_last_call != '1S'
  CONDITION: spade_len <= 5.5
  CONDITION: partner_last_call != '2C'
  CONDITION: controls <= 1.5
  # distilled from Brill /bid

RULE BD_False_P475:
  CALL: 2H
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call != 'PASS'
  CONDITION: last_bid_level <= 2.5
  CONDITION: last_bid_strain == 'C'
  CONDITION: hcp <= 7.5
  CONDITION: competition_level > 1.5
  CONDITION: partner_last_call != '1S'
  CONDITION: spade_len <= 5.5
  CONDITION: partner_last_call != '2C'
  CONDITION: controls > 1.5
  # distilled from Brill /bid

RULE BD_False_P476:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call != 'PASS'
  CONDITION: last_bid_level <= 2.5
  CONDITION: last_bid_strain == 'C'
  CONDITION: hcp <= 7.5
  CONDITION: competition_level > 1.5
  CONDITION: partner_last_call != '1S'
  CONDITION: spade_len > 5.5
  CONDITION: hcp <= 4.5
  # distilled from Brill /bid

RULE BD_False_P477:
  CALL: 2S
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call != 'PASS'
  CONDITION: last_bid_level <= 2.5
  CONDITION: last_bid_strain == 'C'
  CONDITION: hcp <= 7.5
  CONDITION: competition_level > 1.5
  CONDITION: partner_last_call != '1S'
  CONDITION: spade_len > 5.5
  CONDITION: hcp > 4.5
  # distilled from Brill /bid

RULE BD_False_P478:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call != 'PASS'
  CONDITION: last_bid_level <= 2.5
  CONDITION: last_bid_strain == 'C'
  CONDITION: hcp > 7.5
  CONDITION: total_points <= 14.5
  CONDITION: spade_len <= 4.5
  CONDITION: partner_opened <= 0.5
  CONDITION: diamond_len <= 2.5
  CONDITION: d_has_ten <= 0.5
  # distilled from Brill /bid

RULE BD_False_P479:
  CALL: 2H
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call != 'PASS'
  CONDITION: last_bid_level <= 2.5
  CONDITION: last_bid_strain == 'C'
  CONDITION: hcp > 7.5
  CONDITION: total_points <= 14.5
  CONDITION: spade_len <= 4.5
  CONDITION: partner_opened <= 0.5
  CONDITION: diamond_len <= 2.5
  CONDITION: d_has_ten > 0.5
  # distilled from Brill /bid

RULE BD_False_P480:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call != 'PASS'
  CONDITION: last_bid_level <= 2.5
  CONDITION: last_bid_strain == 'C'
  CONDITION: hcp > 7.5
  CONDITION: total_points <= 14.5
  CONDITION: spade_len <= 4.5
  CONDITION: partner_opened <= 0.5
  CONDITION: diamond_len > 2.5
  CONDITION: auction_contested <= 0.5
  # distilled from Brill /bid

RULE BD_False_P481:
  CALL: 2D
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call != 'PASS'
  CONDITION: last_bid_level <= 2.5
  CONDITION: last_bid_strain == 'C'
  CONDITION: hcp > 7.5
  CONDITION: total_points <= 14.5
  CONDITION: spade_len <= 4.5
  CONDITION: partner_opened <= 0.5
  CONDITION: diamond_len > 2.5
  CONDITION: auction_contested > 0.5
  # distilled from Brill /bid

RULE BD_False_P482:
  CALL: 2NT
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call != 'PASS'
  CONDITION: last_bid_level <= 2.5
  CONDITION: last_bid_strain == 'C'
  CONDITION: hcp > 7.5
  CONDITION: total_points <= 14.5
  CONDITION: spade_len <= 4.5
  CONDITION: partner_opened > 0.5
  CONDITION: auction_len <= 5.5
  CONDITION: heart_len <= 4.5
  # distilled from Brill /bid

RULE BD_False_P483:
  CALL: 2H
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call != 'PASS'
  CONDITION: last_bid_level <= 2.5
  CONDITION: last_bid_strain == 'C'
  CONDITION: hcp > 7.5
  CONDITION: total_points <= 14.5
  CONDITION: spade_len <= 4.5
  CONDITION: partner_opened > 0.5
  CONDITION: auction_len <= 5.5
  CONDITION: heart_len > 4.5
  # distilled from Brill /bid

RULE BD_False_P484:
  CALL: 2NT
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call != 'PASS'
  CONDITION: last_bid_level <= 2.5
  CONDITION: last_bid_strain == 'C'
  CONDITION: hcp > 7.5
  CONDITION: total_points <= 14.5
  CONDITION: spade_len <= 4.5
  CONDITION: partner_opened > 0.5
  CONDITION: auction_len > 5.5
  CONDITION: c_is_best_minor <= 0.5
  # distilled from Brill /bid

RULE BD_False_P485:
  CALL: 3C
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call != 'PASS'
  CONDITION: last_bid_level <= 2.5
  CONDITION: last_bid_strain == 'C'
  CONDITION: hcp > 7.5
  CONDITION: total_points <= 14.5
  CONDITION: spade_len <= 4.5
  CONDITION: partner_opened > 0.5
  CONDITION: auction_len > 5.5
  CONDITION: c_is_best_minor > 0.5
  # distilled from Brill /bid

RULE BD_False_P486:
  CALL: 2S
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call != 'PASS'
  CONDITION: last_bid_level <= 2.5
  CONDITION: last_bid_strain == 'C'
  CONDITION: hcp > 7.5
  CONDITION: total_points <= 14.5
  CONDITION: spade_len > 4.5
  CONDITION: my_side_bid_count <= 2.5
  CONDITION: last_bid_seat == 'E'
  CONDITION: major_hcp <= 4.5
  # distilled from Brill /bid

RULE BD_False_P487:
  CALL: 4S
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call != 'PASS'
  CONDITION: last_bid_level <= 2.5
  CONDITION: last_bid_strain == 'C'
  CONDITION: hcp > 7.5
  CONDITION: total_points <= 14.5
  CONDITION: spade_len > 4.5
  CONDITION: my_side_bid_count <= 2.5
  CONDITION: last_bid_seat == 'E'
  CONDITION: major_hcp > 4.5
  # distilled from Brill /bid

RULE BD_False_P488:
  CALL: 2S
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call != 'PASS'
  CONDITION: last_bid_level <= 2.5
  CONDITION: last_bid_strain == 'C'
  CONDITION: hcp > 7.5
  CONDITION: total_points <= 14.5
  CONDITION: spade_len > 4.5
  CONDITION: my_side_bid_count <= 2.5
  CONDITION: last_bid_seat != 'E'
  CONDITION: second_longest_len <= 3.5
  # distilled from Brill /bid

RULE BD_False_P489:
  CALL: 2D
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call != 'PASS'
  CONDITION: last_bid_level <= 2.5
  CONDITION: last_bid_strain == 'C'
  CONDITION: hcp > 7.5
  CONDITION: total_points <= 14.5
  CONDITION: spade_len > 4.5
  CONDITION: my_side_bid_count <= 2.5
  CONDITION: last_bid_seat != 'E'
  CONDITION: second_longest_len > 3.5
  # distilled from Brill /bid

RULE BD_False_P490:
  CALL: 2NT
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call != 'PASS'
  CONDITION: last_bid_level <= 2.5
  CONDITION: last_bid_strain == 'C'
  CONDITION: hcp > 7.5
  CONDITION: total_points <= 14.5
  CONDITION: spade_len > 4.5
  CONDITION: my_side_bid_count > 2.5
  CONDITION: club_len <= 2.5
  CONDITION: heart_len <= 2.5
  # distilled from Brill /bid

RULE BD_False_P491:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call != 'PASS'
  CONDITION: last_bid_level <= 2.5
  CONDITION: last_bid_strain == 'C'
  CONDITION: hcp > 7.5
  CONDITION: total_points <= 14.5
  CONDITION: spade_len > 4.5
  CONDITION: my_side_bid_count > 2.5
  CONDITION: club_len <= 2.5
  CONDITION: heart_len > 2.5
  # distilled from Brill /bid

RULE BD_False_P492:
  CALL: 2NT
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call != 'PASS'
  CONDITION: last_bid_level <= 2.5
  CONDITION: last_bid_strain == 'C'
  CONDITION: hcp > 7.5
  CONDITION: total_points <= 14.5
  CONDITION: spade_len > 4.5
  CONDITION: my_side_bid_count > 2.5
  CONDITION: club_len > 2.5
  CONDITION: minor_hcp <= 6.5
  # distilled from Brill /bid

RULE BD_False_P493:
  CALL: 2H
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call != 'PASS'
  CONDITION: last_bid_level <= 2.5
  CONDITION: last_bid_strain == 'C'
  CONDITION: hcp > 7.5
  CONDITION: total_points <= 14.5
  CONDITION: spade_len > 4.5
  CONDITION: my_side_bid_count > 2.5
  CONDITION: club_len > 2.5
  CONDITION: minor_hcp > 6.5
  # distilled from Brill /bid

RULE BD_False_P494:
  CALL: 2D
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call != 'PASS'
  CONDITION: last_bid_level <= 2.5
  CONDITION: last_bid_strain == 'C'
  CONDITION: hcp > 7.5
  CONDITION: total_points > 14.5
  CONDITION: heart_len <= 3.5
  CONDITION: spade_len <= 3.5
  CONDITION: my_last_call == '1NT'
  # distilled from Brill /bid

RULE BD_False_P495:
  CALL: 2D
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call != 'PASS'
  CONDITION: last_bid_level <= 2.5
  CONDITION: last_bid_strain == 'C'
  CONDITION: hcp > 7.5
  CONDITION: total_points > 14.5
  CONDITION: heart_len <= 3.5
  CONDITION: spade_len <= 3.5
  CONDITION: my_last_call != '1NT'
  CONDITION: losing_trick_count <= 6.5
  # distilled from Brill /bid

RULE BD_False_P496:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call != 'PASS'
  CONDITION: last_bid_level <= 2.5
  CONDITION: last_bid_strain == 'C'
  CONDITION: hcp > 7.5
  CONDITION: total_points > 14.5
  CONDITION: heart_len <= 3.5
  CONDITION: spade_len <= 3.5
  CONDITION: my_last_call != '1NT'
  CONDITION: losing_trick_count > 6.5
  # distilled from Brill /bid

RULE BD_False_P497:
  CALL: 4S
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call != 'PASS'
  CONDITION: last_bid_level <= 2.5
  CONDITION: last_bid_strain == 'C'
  CONDITION: hcp > 7.5
  CONDITION: total_points > 14.5
  CONDITION: heart_len <= 3.5
  CONDITION: spade_len > 3.5
  CONDITION: my_last_call == '1S'
  CONDITION: d_has_ace <= 0.5
  # distilled from Brill /bid

RULE BD_False_P498:
  CALL: 2D
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call != 'PASS'
  CONDITION: last_bid_level <= 2.5
  CONDITION: last_bid_strain == 'C'
  CONDITION: hcp > 7.5
  CONDITION: total_points > 14.5
  CONDITION: heart_len <= 3.5
  CONDITION: spade_len > 3.5
  CONDITION: my_last_call == '1S'
  CONDITION: d_has_ace > 0.5
  # distilled from Brill /bid

RULE BD_False_P499:
  CALL: 2S
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call != 'PASS'
  CONDITION: last_bid_level <= 2.5
  CONDITION: last_bid_strain == 'C'
  CONDITION: hcp > 7.5
  CONDITION: total_points > 14.5
  CONDITION: heart_len <= 3.5
  CONDITION: spade_len > 3.5
  CONDITION: my_last_call != '1S'
  CONDITION: hcp <= 17.5
  # distilled from Brill /bid

RULE BD_False_P500:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call != 'PASS'
  CONDITION: last_bid_level <= 2.5
  CONDITION: last_bid_strain == 'C'
  CONDITION: hcp > 7.5
  CONDITION: total_points > 14.5
  CONDITION: heart_len <= 3.5
  CONDITION: spade_len > 3.5
  CONDITION: my_last_call != '1S'
  CONDITION: hcp > 17.5
  # distilled from Brill /bid

RULE BD_False_P501:
  CALL: 2H
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call != 'PASS'
  CONDITION: last_bid_level <= 2.5
  CONDITION: last_bid_strain == 'C'
  CONDITION: hcp > 7.5
  CONDITION: total_points > 14.5
  CONDITION: heart_len > 3.5
  CONDITION: my_last_call == '1NT'
  # distilled from Brill /bid

RULE BD_False_P502:
  CALL: 2H
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call != 'PASS'
  CONDITION: last_bid_level <= 2.5
  CONDITION: last_bid_strain == 'C'
  CONDITION: hcp > 7.5
  CONDITION: total_points > 14.5
  CONDITION: heart_len > 3.5
  CONDITION: my_last_call != '1NT'
  CONDITION: h_is_longest <= 0.5
  CONDITION: club_hcp <= 3.5
  # distilled from Brill /bid

RULE BD_False_P503:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call != 'PASS'
  CONDITION: last_bid_level <= 2.5
  CONDITION: last_bid_strain == 'C'
  CONDITION: hcp > 7.5
  CONDITION: total_points > 14.5
  CONDITION: heart_len > 3.5
  CONDITION: my_last_call != '1NT'
  CONDITION: h_is_longest <= 0.5
  CONDITION: club_hcp > 3.5
  # distilled from Brill /bid

RULE BD_False_P504:
  CALL: 2D
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call != 'PASS'
  CONDITION: last_bid_level <= 2.5
  CONDITION: last_bid_strain == 'C'
  CONDITION: hcp > 7.5
  CONDITION: total_points > 14.5
  CONDITION: heart_len > 3.5
  CONDITION: my_last_call != '1NT'
  CONDITION: h_is_longest > 0.5
  CONDITION: auction_len <= 6.5
  # distilled from Brill /bid

RULE BD_False_P505:
  CALL: 2S
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call != 'PASS'
  CONDITION: last_bid_level <= 2.5
  CONDITION: last_bid_strain == 'C'
  CONDITION: hcp > 7.5
  CONDITION: total_points > 14.5
  CONDITION: heart_len > 3.5
  CONDITION: my_last_call != '1NT'
  CONDITION: h_is_longest > 0.5
  CONDITION: auction_len > 6.5
  # distilled from Brill /bid

RULE BD_False_P506:
  CALL: 3C
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call != 'PASS'
  CONDITION: last_bid_level <= 2.5
  CONDITION: last_bid_strain != 'C'
  CONDITION: partner_last_call == '2NT'
  CONDITION: competition_level <= 3.5
  CONDITION: heart_len <= 4.5
  CONDITION: spade_len <= 4.5
  CONDITION: total_points <= 19.5
  CONDITION: my_side_bid_count <= 2.5
  # distilled from Brill /bid

RULE BD_False_P507:
  CALL: 3NT
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call != 'PASS'
  CONDITION: last_bid_level <= 2.5
  CONDITION: last_bid_strain != 'C'
  CONDITION: partner_last_call == '2NT'
  CONDITION: competition_level <= 3.5
  CONDITION: heart_len <= 4.5
  CONDITION: spade_len <= 4.5
  CONDITION: total_points <= 19.5
  CONDITION: my_side_bid_count > 2.5
  # distilled from Brill /bid

RULE BD_False_P508:
  CALL: 6NT
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call != 'PASS'
  CONDITION: last_bid_level <= 2.5
  CONDITION: last_bid_strain != 'C'
  CONDITION: partner_last_call == '2NT'
  CONDITION: competition_level <= 3.5
  CONDITION: heart_len <= 4.5
  CONDITION: spade_len <= 4.5
  CONDITION: total_points > 19.5
  CONDITION: hcp <= 19.0
  # distilled from Brill /bid

RULE BD_False_P509:
  CALL: 4NT
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call != 'PASS'
  CONDITION: last_bid_level <= 2.5
  CONDITION: last_bid_strain != 'C'
  CONDITION: partner_last_call == '2NT'
  CONDITION: competition_level <= 3.5
  CONDITION: heart_len <= 4.5
  CONDITION: spade_len <= 4.5
  CONDITION: total_points > 19.5
  CONDITION: hcp > 19.0
  # distilled from Brill /bid

RULE BD_False_P510:
  CALL: 3H
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call != 'PASS'
  CONDITION: last_bid_level <= 2.5
  CONDITION: last_bid_strain != 'C'
  CONDITION: partner_last_call == '2NT'
  CONDITION: competition_level <= 3.5
  CONDITION: heart_len <= 4.5
  CONDITION: spade_len > 4.5
  CONDITION: club_hcp <= 3.5
  CONDITION: s_has_ace <= 0.5
  # distilled from Brill /bid

RULE BD_False_P511:
  CALL: 3S
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call != 'PASS'
  CONDITION: last_bid_level <= 2.5
  CONDITION: last_bid_strain != 'C'
  CONDITION: partner_last_call == '2NT'
  CONDITION: competition_level <= 3.5
  CONDITION: heart_len <= 4.5
  CONDITION: spade_len > 4.5
  CONDITION: club_hcp <= 3.5
  CONDITION: s_has_ace > 0.5
  # distilled from Brill /bid

RULE BD_False_P512:
  CALL: 3D
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call != 'PASS'
  CONDITION: last_bid_level <= 2.5
  CONDITION: last_bid_strain != 'C'
  CONDITION: partner_last_call == '2NT'
  CONDITION: competition_level <= 3.5
  CONDITION: heart_len <= 4.5
  CONDITION: spade_len > 4.5
  CONDITION: club_hcp > 3.5
  CONDITION: heart_len <= 1.5
  # distilled from Brill /bid

RULE BD_False_P513:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call != 'PASS'
  CONDITION: last_bid_level <= 2.5
  CONDITION: last_bid_strain != 'C'
  CONDITION: partner_last_call == '2NT'
  CONDITION: competition_level <= 3.5
  CONDITION: heart_len <= 4.5
  CONDITION: spade_len > 4.5
  CONDITION: club_hcp > 3.5
  CONDITION: heart_len > 1.5
  # distilled from Brill /bid

RULE BD_False_P514:
  CALL: 3D
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call != 'PASS'
  CONDITION: last_bid_level <= 2.5
  CONDITION: last_bid_strain != 'C'
  CONDITION: partner_last_call == '2NT'
  CONDITION: competition_level <= 3.5
  CONDITION: heart_len > 4.5
  CONDITION: heart_len <= 5.5
  CONDITION: minor_hcp <= 7.5
  CONDITION: heart_hcp <= 4.5
  # distilled from Brill /bid

RULE BD_False_P515:
  CALL: 3C
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call != 'PASS'
  CONDITION: last_bid_level <= 2.5
  CONDITION: last_bid_strain != 'C'
  CONDITION: partner_last_call == '2NT'
  CONDITION: competition_level <= 3.5
  CONDITION: heart_len > 4.5
  CONDITION: heart_len <= 5.5
  CONDITION: minor_hcp <= 7.5
  CONDITION: heart_hcp > 4.5
  # distilled from Brill /bid

RULE BD_False_P516:
  CALL: 3S
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call != 'PASS'
  CONDITION: last_bid_level <= 2.5
  CONDITION: last_bid_strain != 'C'
  CONDITION: partner_last_call == '2NT'
  CONDITION: competition_level <= 3.5
  CONDITION: heart_len > 4.5
  CONDITION: heart_len <= 5.5
  CONDITION: minor_hcp > 7.5
  # distilled from Brill /bid

RULE BD_False_P517:
  CALL: 4D
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call != 'PASS'
  CONDITION: last_bid_level <= 2.5
  CONDITION: last_bid_strain != 'C'
  CONDITION: partner_last_call == '2NT'
  CONDITION: competition_level <= 3.5
  CONDITION: heart_len > 4.5
  CONDITION: heart_len > 5.5
  CONDITION: auction_len <= 3.5
  # distilled from Brill /bid

RULE BD_False_P518:
  CALL: 3D
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call != 'PASS'
  CONDITION: last_bid_level <= 2.5
  CONDITION: last_bid_strain != 'C'
  CONDITION: partner_last_call == '2NT'
  CONDITION: competition_level <= 3.5
  CONDITION: heart_len > 4.5
  CONDITION: heart_len > 5.5
  CONDITION: auction_len > 3.5
  CONDITION: shape_pattern == '6421'
  # distilled from Brill /bid

RULE BD_False_P519:
  CALL: 3NT
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call != 'PASS'
  CONDITION: last_bid_level <= 2.5
  CONDITION: last_bid_strain != 'C'
  CONDITION: partner_last_call == '2NT'
  CONDITION: competition_level <= 3.5
  CONDITION: heart_len > 4.5
  CONDITION: heart_len > 5.5
  CONDITION: auction_len > 3.5
  CONDITION: shape_pattern != '6421'
  # distilled from Brill /bid

RULE BD_False_P520:
  CALL: 3NT
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call != 'PASS'
  CONDITION: last_bid_level <= 2.5
  CONDITION: last_bid_strain != 'C'
  CONDITION: partner_last_call == '2NT'
  CONDITION: competition_level > 3.5
  CONDITION: rule20_total <= 23.5
  CONDITION: heart_len <= 1.5
  # distilled from Brill /bid

RULE BD_False_P521:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call != 'PASS'
  CONDITION: last_bid_level <= 2.5
  CONDITION: last_bid_strain != 'C'
  CONDITION: partner_last_call == '2NT'
  CONDITION: competition_level > 3.5
  CONDITION: rule20_total <= 23.5
  CONDITION: heart_len > 1.5
  CONDITION: is_semi_balanced <= 0.5
  CONDITION: rule_of_21 <= 0.5
  # distilled from Brill /bid

RULE BD_False_P522:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call != 'PASS'
  CONDITION: last_bid_level <= 2.5
  CONDITION: last_bid_strain != 'C'
  CONDITION: partner_last_call == '2NT'
  CONDITION: competition_level > 3.5
  CONDITION: rule20_total <= 23.5
  CONDITION: heart_len > 1.5
  CONDITION: is_semi_balanced <= 0.5
  CONDITION: rule_of_21 > 0.5
  # distilled from Brill /bid

RULE BD_False_P523:
  CALL: 3H
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call != 'PASS'
  CONDITION: last_bid_level <= 2.5
  CONDITION: last_bid_strain != 'C'
  CONDITION: partner_last_call == '2NT'
  CONDITION: competition_level > 3.5
  CONDITION: rule20_total <= 23.5
  CONDITION: heart_len > 1.5
  CONDITION: is_semi_balanced > 0.5
  CONDITION: partner_last_bid_strain == 'D'
  # distilled from Brill /bid

RULE BD_False_P524:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call != 'PASS'
  CONDITION: last_bid_level <= 2.5
  CONDITION: last_bid_strain != 'C'
  CONDITION: partner_last_call == '2NT'
  CONDITION: competition_level > 3.5
  CONDITION: rule20_total <= 23.5
  CONDITION: heart_len > 1.5
  CONDITION: is_semi_balanced > 0.5
  CONDITION: partner_last_bid_strain != 'D'
  # distilled from Brill /bid

RULE BD_False_P525:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call != 'PASS'
  CONDITION: last_bid_level <= 2.5
  CONDITION: last_bid_strain != 'C'
  CONDITION: partner_last_call == '2NT'
  CONDITION: competition_level > 3.5
  CONDITION: rule20_total > 23.5
  CONDITION: club_len <= 2.5
  CONDITION: heart_len <= 4.5
  CONDITION: hcp <= 15.5
  # distilled from Brill /bid

RULE BD_False_P526:
  CALL: 3NT
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call != 'PASS'
  CONDITION: last_bid_level <= 2.5
  CONDITION: last_bid_strain != 'C'
  CONDITION: partner_last_call == '2NT'
  CONDITION: competition_level > 3.5
  CONDITION: rule20_total > 23.5
  CONDITION: club_len <= 2.5
  CONDITION: heart_len <= 4.5
  CONDITION: hcp > 15.5
  # distilled from Brill /bid

RULE BD_False_P527:
  CALL: 3D
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call != 'PASS'
  CONDITION: last_bid_level <= 2.5
  CONDITION: last_bid_strain != 'C'
  CONDITION: partner_last_call == '2NT'
  CONDITION: competition_level > 3.5
  CONDITION: rule20_total > 23.5
  CONDITION: club_len <= 2.5
  CONDITION: heart_len > 4.5
  CONDITION: hcp <= 19.5
  # distilled from Brill /bid

RULE BD_False_P528:
  CALL: 3H
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call != 'PASS'
  CONDITION: last_bid_level <= 2.5
  CONDITION: last_bid_strain != 'C'
  CONDITION: partner_last_call == '2NT'
  CONDITION: competition_level > 3.5
  CONDITION: rule20_total > 23.5
  CONDITION: club_len <= 2.5
  CONDITION: heart_len > 4.5
  CONDITION: hcp > 19.5
  # distilled from Brill /bid

RULE BD_False_P529:
  CALL: 4S
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call != 'PASS'
  CONDITION: last_bid_level <= 2.5
  CONDITION: last_bid_strain != 'C'
  CONDITION: partner_last_call == '2NT'
  CONDITION: competition_level > 3.5
  CONDITION: rule20_total > 23.5
  CONDITION: club_len > 2.5
  CONDITION: partner_last_bid_strain == 'H'
  CONDITION: d_top2_honors <= 1.5
  # distilled from Brill /bid

RULE BD_False_P530:
  CALL: 3NT
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call != 'PASS'
  CONDITION: last_bid_level <= 2.5
  CONDITION: last_bid_strain != 'C'
  CONDITION: partner_last_call == '2NT'
  CONDITION: competition_level > 3.5
  CONDITION: rule20_total > 23.5
  CONDITION: club_len > 2.5
  CONDITION: partner_last_bid_strain == 'H'
  CONDITION: d_top2_honors > 1.5
  # distilled from Brill /bid

RULE BD_False_P531:
  CALL: 3NT
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call != 'PASS'
  CONDITION: last_bid_level <= 2.5
  CONDITION: last_bid_strain != 'C'
  CONDITION: partner_last_call == '2NT'
  CONDITION: competition_level > 3.5
  CONDITION: rule20_total > 23.5
  CONDITION: club_len > 2.5
  CONDITION: partner_last_bid_strain != 'H'
  CONDITION: diamond_hcp <= 6.5
  # distilled from Brill /bid

RULE BD_False_P532:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call != 'PASS'
  CONDITION: last_bid_level <= 2.5
  CONDITION: last_bid_strain != 'C'
  CONDITION: partner_last_call == '2NT'
  CONDITION: competition_level > 3.5
  CONDITION: rule20_total > 23.5
  CONDITION: club_len > 2.5
  CONDITION: partner_last_bid_strain != 'H'
  CONDITION: diamond_hcp > 6.5
  # distilled from Brill /bid

RULE BD_False_P533:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call != 'PASS'
  CONDITION: last_bid_level <= 2.5
  CONDITION: last_bid_strain != 'C'
  CONDITION: partner_last_call != '2NT'
  CONDITION: rule20_total <= 21.5
  CONDITION: passes_since_last_bid <= 0.5
  CONDITION: hcp <= 6.5
  CONDITION: support_in_partner_suit <= 3.5
  CONDITION: diamond_hcp <= 5.0
  # distilled from Brill /bid

RULE BD_False_P534:
  CALL: 3H
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call != 'PASS'
  CONDITION: last_bid_level <= 2.5
  CONDITION: last_bid_strain != 'C'
  CONDITION: partner_last_call != '2NT'
  CONDITION: rule20_total <= 21.5
  CONDITION: passes_since_last_bid <= 0.5
  CONDITION: hcp <= 6.5
  CONDITION: support_in_partner_suit <= 3.5
  CONDITION: diamond_hcp > 5.0
  # distilled from Brill /bid

RULE BD_False_P535:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call != 'PASS'
  CONDITION: last_bid_level <= 2.5
  CONDITION: last_bid_strain != 'C'
  CONDITION: partner_last_call != '2NT'
  CONDITION: rule20_total <= 21.5
  CONDITION: passes_since_last_bid <= 0.5
  CONDITION: hcp <= 6.5
  CONDITION: support_in_partner_suit > 3.5
  CONDITION: opp_suit_stoppers <= 0.25
  # distilled from Brill /bid

RULE BD_False_P536:
  CALL: 3S
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call != 'PASS'
  CONDITION: last_bid_level <= 2.5
  CONDITION: last_bid_strain != 'C'
  CONDITION: partner_last_call != '2NT'
  CONDITION: rule20_total <= 21.5
  CONDITION: passes_since_last_bid <= 0.5
  CONDITION: hcp <= 6.5
  CONDITION: support_in_partner_suit > 3.5
  CONDITION: opp_suit_stoppers > 0.25
  # distilled from Brill /bid

RULE BD_False_P537:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call != 'PASS'
  CONDITION: last_bid_level <= 2.5
  CONDITION: last_bid_strain != 'C'
  CONDITION: partner_last_call != '2NT'
  CONDITION: rule20_total <= 21.5
  CONDITION: passes_since_last_bid <= 0.5
  CONDITION: hcp > 6.5
  CONDITION: support_in_partner_suit <= 2.5
  CONDITION: auction_contested <= 0.5
  # distilled from Brill /bid

RULE BD_False_P538:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call != 'PASS'
  CONDITION: last_bid_level <= 2.5
  CONDITION: last_bid_strain != 'C'
  CONDITION: partner_last_call != '2NT'
  CONDITION: rule20_total <= 21.5
  CONDITION: passes_since_last_bid <= 0.5
  CONDITION: hcp > 6.5
  CONDITION: support_in_partner_suit <= 2.5
  CONDITION: auction_contested > 0.5
  # distilled from Brill /bid

RULE BD_False_P539:
  CALL: 3S
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call != 'PASS'
  CONDITION: last_bid_level <= 2.5
  CONDITION: last_bid_strain != 'C'
  CONDITION: partner_last_call != '2NT'
  CONDITION: rule20_total <= 21.5
  CONDITION: passes_since_last_bid <= 0.5
  CONDITION: hcp > 6.5
  CONDITION: support_in_partner_suit > 2.5
  CONDITION: partner_last_bid_strain == 'S'
  # distilled from Brill /bid

RULE BD_False_P540:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call != 'PASS'
  CONDITION: last_bid_level <= 2.5
  CONDITION: last_bid_strain != 'C'
  CONDITION: partner_last_call != '2NT'
  CONDITION: rule20_total <= 21.5
  CONDITION: passes_since_last_bid <= 0.5
  CONDITION: hcp > 6.5
  CONDITION: support_in_partner_suit > 2.5
  CONDITION: partner_last_bid_strain != 'S'
  # distilled from Brill /bid

RULE BD_False_P541:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call != 'PASS'
  CONDITION: last_bid_level <= 2.5
  CONDITION: last_bid_strain != 'C'
  CONDITION: partner_last_call != '2NT'
  CONDITION: rule20_total <= 21.5
  CONDITION: passes_since_last_bid > 0.5
  CONDITION: partner_last_call == '2S'
  CONDITION: my_side_bid_count <= 2.5
  CONDITION: spade_len <= 2.5
  # distilled from Brill /bid

RULE BD_False_P542:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call != 'PASS'
  CONDITION: last_bid_level <= 2.5
  CONDITION: last_bid_strain != 'C'
  CONDITION: partner_last_call != '2NT'
  CONDITION: rule20_total <= 21.5
  CONDITION: passes_since_last_bid > 0.5
  CONDITION: partner_last_call == '2S'
  CONDITION: my_side_bid_count <= 2.5
  CONDITION: spade_len > 2.5
  # distilled from Brill /bid

RULE BD_False_P543:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call != 'PASS'
  CONDITION: last_bid_level <= 2.5
  CONDITION: last_bid_strain != 'C'
  CONDITION: partner_last_call != '2NT'
  CONDITION: rule20_total <= 21.5
  CONDITION: passes_since_last_bid > 0.5
  CONDITION: partner_last_call == '2S'
  CONDITION: my_side_bid_count > 2.5
  CONDITION: hcp <= 9.5
  # distilled from Brill /bid

RULE BD_False_P544:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call != 'PASS'
  CONDITION: last_bid_level <= 2.5
  CONDITION: last_bid_strain != 'C'
  CONDITION: partner_last_call != '2NT'
  CONDITION: rule20_total <= 21.5
  CONDITION: passes_since_last_bid > 0.5
  CONDITION: partner_last_call == '2S'
  CONDITION: my_side_bid_count > 2.5
  CONDITION: hcp > 9.5
  # distilled from Brill /bid

RULE BD_False_P545:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call != 'PASS'
  CONDITION: last_bid_level <= 2.5
  CONDITION: last_bid_strain != 'C'
  CONDITION: partner_last_call != '2NT'
  CONDITION: rule20_total <= 21.5
  CONDITION: passes_since_last_bid > 0.5
  CONDITION: partner_last_call != '2S'
  CONDITION: partner_last_bid_strain == 'H'
  CONDITION: s_is_longest <= 0.5
  # distilled from Brill /bid

RULE BD_False_P546:
  CALL: 3H
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call != 'PASS'
  CONDITION: last_bid_level <= 2.5
  CONDITION: last_bid_strain != 'C'
  CONDITION: partner_last_call != '2NT'
  CONDITION: rule20_total <= 21.5
  CONDITION: passes_since_last_bid > 0.5
  CONDITION: partner_last_call != '2S'
  CONDITION: partner_last_bid_strain == 'H'
  CONDITION: s_is_longest > 0.5
  # distilled from Brill /bid

RULE BD_False_P547:
  CALL: 2NT
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call != 'PASS'
  CONDITION: last_bid_level <= 2.5
  CONDITION: last_bid_strain != 'C'
  CONDITION: partner_last_call != '2NT'
  CONDITION: rule20_total <= 21.5
  CONDITION: passes_since_last_bid > 0.5
  CONDITION: partner_last_call != '2S'
  CONDITION: partner_last_bid_strain != 'H'
  CONDITION: opponents_bid <= 0.5
  # distilled from Brill /bid

RULE BD_False_P548:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call != 'PASS'
  CONDITION: last_bid_level <= 2.5
  CONDITION: last_bid_strain != 'C'
  CONDITION: partner_last_call != '2NT'
  CONDITION: rule20_total <= 21.5
  CONDITION: passes_since_last_bid > 0.5
  CONDITION: partner_last_call != '2S'
  CONDITION: partner_last_bid_strain != 'H'
  CONDITION: opponents_bid > 0.5
  # distilled from Brill /bid

RULE BD_False_P549:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call != 'PASS'
  CONDITION: last_bid_level <= 2.5
  CONDITION: last_bid_strain != 'C'
  CONDITION: partner_last_call != '2NT'
  CONDITION: rule20_total > 21.5
  CONDITION: my_last_call == '1NT'
  CONDITION: partner_last_call == '2H'
  CONDITION: spade_len <= 3.5
  CONDITION: hcp <= 14.5
  # distilled from Brill /bid

RULE BD_False_P550:
  CALL: 2S
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call != 'PASS'
  CONDITION: last_bid_level <= 2.5
  CONDITION: last_bid_strain != 'C'
  CONDITION: partner_last_call != '2NT'
  CONDITION: rule20_total > 21.5
  CONDITION: my_last_call == '1NT'
  CONDITION: partner_last_call == '2H'
  CONDITION: spade_len <= 3.5
  CONDITION: hcp > 14.5
  # distilled from Brill /bid

RULE BD_False_P551:
  CALL: 3S
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call != 'PASS'
  CONDITION: last_bid_level <= 2.5
  CONDITION: last_bid_strain != 'C'
  CONDITION: partner_last_call != '2NT'
  CONDITION: rule20_total > 21.5
  CONDITION: my_last_call == '1NT'
  CONDITION: partner_last_call == '2H'
  CONDITION: spade_len > 3.5
  CONDITION: hcp <= 15.5
  # distilled from Brill /bid

RULE BD_False_P552:
  CALL: 3C
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call != 'PASS'
  CONDITION: last_bid_level <= 2.5
  CONDITION: last_bid_strain != 'C'
  CONDITION: partner_last_call != '2NT'
  CONDITION: rule20_total > 21.5
  CONDITION: my_last_call == '1NT'
  CONDITION: partner_last_call == '2H'
  CONDITION: spade_len > 3.5
  CONDITION: hcp > 15.5
  # distilled from Brill /bid

RULE BD_False_P553:
  CALL: 2H
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call != 'PASS'
  CONDITION: last_bid_level <= 2.5
  CONDITION: last_bid_strain != 'C'
  CONDITION: partner_last_call != '2NT'
  CONDITION: rule20_total > 21.5
  CONDITION: my_last_call == '1NT'
  CONDITION: partner_last_call != '2H'
  CONDITION: last_bid_strain == 'D'
  CONDITION: heart_len <= 3.5
  # distilled from Brill /bid

RULE BD_False_P554:
  CALL: 3H
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call != 'PASS'
  CONDITION: last_bid_level <= 2.5
  CONDITION: last_bid_strain != 'C'
  CONDITION: partner_last_call != '2NT'
  CONDITION: rule20_total > 21.5
  CONDITION: my_last_call == '1NT'
  CONDITION: partner_last_call != '2H'
  CONDITION: last_bid_strain == 'D'
  CONDITION: heart_len > 3.5
  # distilled from Brill /bid

RULE BD_False_P555:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call != 'PASS'
  CONDITION: last_bid_level <= 2.5
  CONDITION: last_bid_strain != 'C'
  CONDITION: partner_last_call != '2NT'
  CONDITION: rule20_total > 21.5
  CONDITION: my_last_call == '1NT'
  CONDITION: partner_last_call != '2H'
  CONDITION: last_bid_strain != 'D'
  CONDITION: major_hcp <= 7.5
  # distilled from Brill /bid

RULE BD_False_P556:
  CALL: 2NT
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call != 'PASS'
  CONDITION: last_bid_level <= 2.5
  CONDITION: last_bid_strain != 'C'
  CONDITION: partner_last_call != '2NT'
  CONDITION: rule20_total > 21.5
  CONDITION: my_last_call == '1NT'
  CONDITION: partner_last_call != '2H'
  CONDITION: last_bid_strain != 'D'
  CONDITION: major_hcp > 7.5
  # distilled from Brill /bid

RULE BD_False_P557:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call != 'PASS'
  CONDITION: last_bid_level <= 2.5
  CONDITION: last_bid_strain != 'C'
  CONDITION: partner_last_call != '2NT'
  CONDITION: rule20_total > 21.5
  CONDITION: my_last_call != '1NT'
  CONDITION: s_is_best_major <= 0.5
  CONDITION: my_last_call == '1H'
  CONDITION: s_stopper <= 0.5
  # distilled from Brill /bid

RULE BD_False_P558:
  CALL: 4H
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call != 'PASS'
  CONDITION: last_bid_level <= 2.5
  CONDITION: last_bid_strain != 'C'
  CONDITION: partner_last_call != '2NT'
  CONDITION: rule20_total > 21.5
  CONDITION: my_last_call != '1NT'
  CONDITION: s_is_best_major <= 0.5
  CONDITION: my_last_call == '1H'
  CONDITION: s_stopper > 0.5
  # distilled from Brill /bid

RULE BD_False_P559:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call != 'PASS'
  CONDITION: last_bid_level <= 2.5
  CONDITION: last_bid_strain != 'C'
  CONDITION: partner_last_call != '2NT'
  CONDITION: rule20_total > 21.5
  CONDITION: my_last_call != '1NT'
  CONDITION: s_is_best_major <= 0.5
  CONDITION: my_last_call != '1H'
  CONDITION: shortest_suit_len <= 1.5
  # distilled from Brill /bid

RULE BD_False_P560:
  CALL: 2NT
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call != 'PASS'
  CONDITION: last_bid_level <= 2.5
  CONDITION: last_bid_strain != 'C'
  CONDITION: partner_last_call != '2NT'
  CONDITION: rule20_total > 21.5
  CONDITION: my_last_call != '1NT'
  CONDITION: s_is_best_major <= 0.5
  CONDITION: my_last_call != '1H'
  CONDITION: shortest_suit_len > 1.5
  # distilled from Brill /bid

RULE BD_False_P561:
  CALL: 4S
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call != 'PASS'
  CONDITION: last_bid_level <= 2.5
  CONDITION: last_bid_strain != 'C'
  CONDITION: partner_last_call != '2NT'
  CONDITION: rule20_total > 21.5
  CONDITION: my_last_call != '1NT'
  CONDITION: s_is_best_major > 0.5
  CONDITION: agreed_trump == 'S'
  CONDITION: rule20_total <= 22.5
  # distilled from Brill /bid

RULE BD_False_P562:
  CALL: 4S
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call != 'PASS'
  CONDITION: last_bid_level <= 2.5
  CONDITION: last_bid_strain != 'C'
  CONDITION: partner_last_call != '2NT'
  CONDITION: rule20_total > 21.5
  CONDITION: my_last_call != '1NT'
  CONDITION: s_is_best_major > 0.5
  CONDITION: agreed_trump == 'S'
  CONDITION: rule20_total > 22.5
  # distilled from Brill /bid

RULE BD_False_P563:
  CALL: 2NT
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call != 'PASS'
  CONDITION: last_bid_level <= 2.5
  CONDITION: last_bid_strain != 'C'
  CONDITION: partner_last_call != '2NT'
  CONDITION: rule20_total > 21.5
  CONDITION: my_last_call != '1NT'
  CONDITION: s_is_best_major > 0.5
  CONDITION: agreed_trump != 'S'
  CONDITION: competition_level <= 2.5
  # distilled from Brill /bid

RULE BD_False_P564:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call != 'PASS'
  CONDITION: last_bid_level <= 2.5
  CONDITION: last_bid_strain != 'C'
  CONDITION: partner_last_call != '2NT'
  CONDITION: rule20_total > 21.5
  CONDITION: my_last_call != '1NT'
  CONDITION: s_is_best_major > 0.5
  CONDITION: agreed_trump != 'S'
  CONDITION: competition_level > 2.5
  # distilled from Brill /bid

RULE BD_False_P565:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call != 'PASS'
  CONDITION: last_bid_level > 2.5
  CONDITION: last_bid_level <= 3.5
  CONDITION: last_bid_strain == 'NT'
  CONDITION: rule20_total <= 24.5
  CONDITION: rule20_total <= 21.5
  CONDITION: minor_hcp <= 2.5
  CONDITION: h_has_jack <= 0.5
  CONDITION: diamond_hcp <= 1.5
  # distilled from Brill /bid

RULE BD_False_P566:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call != 'PASS'
  CONDITION: last_bid_level > 2.5
  CONDITION: last_bid_level <= 3.5
  CONDITION: last_bid_strain == 'NT'
  CONDITION: rule20_total <= 24.5
  CONDITION: rule20_total <= 21.5
  CONDITION: minor_hcp <= 2.5
  CONDITION: h_has_jack <= 0.5
  CONDITION: diamond_hcp > 1.5
  # distilled from Brill /bid

RULE BD_False_P567:
  CALL: 4H
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call != 'PASS'
  CONDITION: last_bid_level > 2.5
  CONDITION: last_bid_level <= 3.5
  CONDITION: last_bid_strain == 'NT'
  CONDITION: rule20_total <= 24.5
  CONDITION: rule20_total <= 21.5
  CONDITION: minor_hcp <= 2.5
  CONDITION: h_has_jack > 0.5
  CONDITION: spade_hcp <= 1.5
  # distilled from Brill /bid

RULE BD_False_P568:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call != 'PASS'
  CONDITION: last_bid_level > 2.5
  CONDITION: last_bid_level <= 3.5
  CONDITION: last_bid_strain == 'NT'
  CONDITION: rule20_total <= 24.5
  CONDITION: rule20_total <= 21.5
  CONDITION: minor_hcp <= 2.5
  CONDITION: h_has_jack > 0.5
  CONDITION: spade_hcp > 1.5
  # distilled from Brill /bid

RULE BD_False_P569:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call != 'PASS'
  CONDITION: last_bid_level > 2.5
  CONDITION: last_bid_level <= 3.5
  CONDITION: last_bid_strain == 'NT'
  CONDITION: rule20_total <= 24.5
  CONDITION: rule20_total <= 21.5
  CONDITION: minor_hcp > 2.5
  CONDITION: partner_last_call == '3NT'
  # distilled from Brill /bid

RULE BD_False_P570:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call != 'PASS'
  CONDITION: last_bid_level > 2.5
  CONDITION: last_bid_level <= 3.5
  CONDITION: last_bid_strain == 'NT'
  CONDITION: rule20_total <= 24.5
  CONDITION: rule20_total <= 21.5
  CONDITION: minor_hcp > 2.5
  CONDITION: partner_last_call != '3NT'
  CONDITION: spade_hcp <= 1.5
  # distilled from Brill /bid

RULE BD_False_P571:
  CALL: X
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call != 'PASS'
  CONDITION: last_bid_level > 2.5
  CONDITION: last_bid_level <= 3.5
  CONDITION: last_bid_strain == 'NT'
  CONDITION: rule20_total <= 24.5
  CONDITION: rule20_total <= 21.5
  CONDITION: minor_hcp > 2.5
  CONDITION: partner_last_call != '3NT'
  CONDITION: spade_hcp > 1.5
  # distilled from Brill /bid

RULE BD_False_P572:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call != 'PASS'
  CONDITION: last_bid_level > 2.5
  CONDITION: last_bid_level <= 3.5
  CONDITION: last_bid_strain == 'NT'
  CONDITION: rule20_total <= 24.5
  CONDITION: rule20_total > 21.5
  CONDITION: my_seat == 'W'
  CONDITION: club_hcp <= 3.5
  CONDITION: diamond_hcp <= 3.5
  # distilled from Brill /bid

RULE BD_False_P573:
  CALL: 4H
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call != 'PASS'
  CONDITION: last_bid_level > 2.5
  CONDITION: last_bid_level <= 3.5
  CONDITION: last_bid_strain == 'NT'
  CONDITION: rule20_total <= 24.5
  CONDITION: rule20_total > 21.5
  CONDITION: my_seat == 'W'
  CONDITION: club_hcp <= 3.5
  CONDITION: diamond_hcp > 3.5
  # distilled from Brill /bid

RULE BD_False_P574:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call != 'PASS'
  CONDITION: last_bid_level > 2.5
  CONDITION: last_bid_level <= 3.5
  CONDITION: last_bid_strain == 'NT'
  CONDITION: rule20_total <= 24.5
  CONDITION: rule20_total > 21.5
  CONDITION: my_seat == 'W'
  CONDITION: club_hcp > 3.5
  # distilled from Brill /bid

RULE BD_False_P575:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call != 'PASS'
  CONDITION: last_bid_level > 2.5
  CONDITION: last_bid_level <= 3.5
  CONDITION: last_bid_strain == 'NT'
  CONDITION: rule20_total <= 24.5
  CONDITION: rule20_total > 21.5
  CONDITION: my_seat != 'W'
  CONDITION: my_last_call == '2S'
  CONDITION: spade_len <= 2.5
  # distilled from Brill /bid

RULE BD_False_P576:
  CALL: 4S
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call != 'PASS'
  CONDITION: last_bid_level > 2.5
  CONDITION: last_bid_level <= 3.5
  CONDITION: last_bid_strain == 'NT'
  CONDITION: rule20_total <= 24.5
  CONDITION: rule20_total > 21.5
  CONDITION: my_seat != 'W'
  CONDITION: my_last_call == '2S'
  CONDITION: spade_len > 2.5
  # distilled from Brill /bid

RULE BD_False_P577:
  CALL: 4S
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call != 'PASS'
  CONDITION: last_bid_level > 2.5
  CONDITION: last_bid_level <= 3.5
  CONDITION: last_bid_strain == 'NT'
  CONDITION: rule20_total <= 24.5
  CONDITION: rule20_total > 21.5
  CONDITION: my_seat != 'W'
  CONDITION: my_last_call != '2S'
  CONDITION: my_last_call == '1S'
  # distilled from Brill /bid

RULE BD_False_P578:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call != 'PASS'
  CONDITION: last_bid_level > 2.5
  CONDITION: last_bid_level <= 3.5
  CONDITION: last_bid_strain == 'NT'
  CONDITION: rule20_total <= 24.5
  CONDITION: rule20_total > 21.5
  CONDITION: my_seat != 'W'
  CONDITION: my_last_call != '2S'
  CONDITION: my_last_call != '1S'
  # distilled from Brill /bid

RULE BD_False_P579:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call != 'PASS'
  CONDITION: last_bid_level > 2.5
  CONDITION: last_bid_level <= 3.5
  CONDITION: last_bid_strain == 'NT'
  CONDITION: rule20_total > 24.5
  CONDITION: auction_len <= 7.5
  CONDITION: c_has_king <= 0.5
  CONDITION: h_has_king <= 0.5
  CONDITION: longest_suit_len <= 4.5
  # distilled from Brill /bid

RULE BD_False_P580:
  CALL: 4NT
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call != 'PASS'
  CONDITION: last_bid_level > 2.5
  CONDITION: last_bid_level <= 3.5
  CONDITION: last_bid_strain == 'NT'
  CONDITION: rule20_total > 24.5
  CONDITION: auction_len <= 7.5
  CONDITION: c_has_king <= 0.5
  CONDITION: h_has_king <= 0.5
  CONDITION: longest_suit_len > 4.5
  # distilled from Brill /bid

RULE BD_False_P581:
  CALL: 5NT
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call != 'PASS'
  CONDITION: last_bid_level > 2.5
  CONDITION: last_bid_level <= 3.5
  CONDITION: last_bid_strain == 'NT'
  CONDITION: rule20_total > 24.5
  CONDITION: auction_len <= 7.5
  CONDITION: c_has_king <= 0.5
  CONDITION: h_has_king > 0.5
  CONDITION: hcp <= 16.5
  # distilled from Brill /bid

RULE BD_False_P582:
  CALL: 4H
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call != 'PASS'
  CONDITION: last_bid_level > 2.5
  CONDITION: last_bid_level <= 3.5
  CONDITION: last_bid_strain == 'NT'
  CONDITION: rule20_total > 24.5
  CONDITION: auction_len <= 7.5
  CONDITION: c_has_king <= 0.5
  CONDITION: h_has_king > 0.5
  CONDITION: hcp > 16.5
  # distilled from Brill /bid

RULE BD_False_P583:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call != 'PASS'
  CONDITION: last_bid_level > 2.5
  CONDITION: last_bid_level <= 3.5
  CONDITION: last_bid_strain == 'NT'
  CONDITION: rule20_total > 24.5
  CONDITION: auction_len <= 7.5
  CONDITION: c_has_king > 0.5
  # distilled from Brill /bid

RULE BD_False_P584:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call != 'PASS'
  CONDITION: last_bid_level > 2.5
  CONDITION: last_bid_level <= 3.5
  CONDITION: last_bid_strain == 'NT'
  CONDITION: rule20_total > 24.5
  CONDITION: auction_len > 7.5
  CONDITION: my_last_call == '2H'
  CONDITION: hcp <= 16.5
  # distilled from Brill /bid

RULE BD_False_P585:
  CALL: 4H
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call != 'PASS'
  CONDITION: last_bid_level > 2.5
  CONDITION: last_bid_level <= 3.5
  CONDITION: last_bid_strain == 'NT'
  CONDITION: rule20_total > 24.5
  CONDITION: auction_len > 7.5
  CONDITION: my_last_call == '2H'
  CONDITION: hcp > 16.5
  # distilled from Brill /bid

RULE BD_False_P586:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call != 'PASS'
  CONDITION: last_bid_level > 2.5
  CONDITION: last_bid_level <= 3.5
  CONDITION: last_bid_strain == 'NT'
  CONDITION: rule20_total > 24.5
  CONDITION: auction_len > 7.5
  CONDITION: my_last_call != '2H'
  # distilled from Brill /bid

RULE BD_False_P587:
  CALL: 4S
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call != 'PASS'
  CONDITION: last_bid_level > 2.5
  CONDITION: last_bid_level <= 3.5
  CONDITION: last_bid_strain != 'NT'
  CONDITION: opponents_bid <= 0.5
  CONDITION: last_bid_strain == 'S'
  CONDITION: spade_len <= 4.5
  CONDITION: hcp <= 14.5
  CONDITION: h_is_longest <= 0.5
  # distilled from Brill /bid

RULE BD_False_P588:
  CALL: 4S
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call != 'PASS'
  CONDITION: last_bid_level > 2.5
  CONDITION: last_bid_level <= 3.5
  CONDITION: last_bid_strain != 'NT'
  CONDITION: opponents_bid <= 0.5
  CONDITION: last_bid_strain == 'S'
  CONDITION: spade_len <= 4.5
  CONDITION: hcp <= 14.5
  CONDITION: h_is_longest > 0.5
  # distilled from Brill /bid

RULE BD_False_P589:
  CALL: 3NT
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call != 'PASS'
  CONDITION: last_bid_level > 2.5
  CONDITION: last_bid_level <= 3.5
  CONDITION: last_bid_strain != 'NT'
  CONDITION: opponents_bid <= 0.5
  CONDITION: last_bid_strain == 'S'
  CONDITION: spade_len <= 4.5
  CONDITION: hcp > 14.5
  CONDITION: c_has_jack <= 0.5
  # distilled from Brill /bid

RULE BD_False_P590:
  CALL: 3NT
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call != 'PASS'
  CONDITION: last_bid_level > 2.5
  CONDITION: last_bid_level <= 3.5
  CONDITION: last_bid_strain != 'NT'
  CONDITION: opponents_bid <= 0.5
  CONDITION: last_bid_strain == 'S'
  CONDITION: spade_len <= 4.5
  CONDITION: hcp > 14.5
  CONDITION: c_has_jack > 0.5
  # distilled from Brill /bid

RULE BD_False_P591:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call != 'PASS'
  CONDITION: last_bid_level > 2.5
  CONDITION: last_bid_level <= 3.5
  CONDITION: last_bid_strain != 'NT'
  CONDITION: opponents_bid <= 0.5
  CONDITION: last_bid_strain == 'S'
  CONDITION: spade_len > 4.5
  CONDITION: total_points <= 15.5
  CONDITION: my_last_call == '2S'
  # distilled from Brill /bid

RULE BD_False_P592:
  CALL: 4S
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call != 'PASS'
  CONDITION: last_bid_level > 2.5
  CONDITION: last_bid_level <= 3.5
  CONDITION: last_bid_strain != 'NT'
  CONDITION: opponents_bid <= 0.5
  CONDITION: last_bid_strain == 'S'
  CONDITION: spade_len > 4.5
  CONDITION: total_points <= 15.5
  CONDITION: my_last_call != '2S'
  # distilled from Brill /bid

RULE BD_False_P593:
  CALL: 4NT
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call != 'PASS'
  CONDITION: last_bid_level > 2.5
  CONDITION: last_bid_level <= 3.5
  CONDITION: last_bid_strain != 'NT'
  CONDITION: opponents_bid <= 0.5
  CONDITION: last_bid_strain == 'S'
  CONDITION: spade_len > 4.5
  CONDITION: total_points > 15.5
  CONDITION: has_trump_king <= 0.5
  # distilled from Brill /bid

RULE BD_False_P594:
  CALL: 4S
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call != 'PASS'
  CONDITION: last_bid_level > 2.5
  CONDITION: last_bid_level <= 3.5
  CONDITION: last_bid_strain != 'NT'
  CONDITION: opponents_bid <= 0.5
  CONDITION: last_bid_strain == 'S'
  CONDITION: spade_len > 4.5
  CONDITION: total_points > 15.5
  CONDITION: has_trump_king > 0.5
  # distilled from Brill /bid

RULE BD_False_P595:
  CALL: 4H
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call != 'PASS'
  CONDITION: last_bid_level > 2.5
  CONDITION: last_bid_level <= 3.5
  CONDITION: last_bid_strain != 'NT'
  CONDITION: opponents_bid <= 0.5
  CONDITION: last_bid_strain != 'S'
  CONDITION: last_bid_strain == 'H'
  CONDITION: our_fit_shown <= 0.5
  CONDITION: ace_count <= 1.5
  # distilled from Brill /bid

RULE BD_False_P596:
  CALL: 3NT
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call != 'PASS'
  CONDITION: last_bid_level > 2.5
  CONDITION: last_bid_level <= 3.5
  CONDITION: last_bid_strain != 'NT'
  CONDITION: opponents_bid <= 0.5
  CONDITION: last_bid_strain != 'S'
  CONDITION: last_bid_strain == 'H'
  CONDITION: our_fit_shown <= 0.5
  CONDITION: ace_count > 1.5
  # distilled from Brill /bid

RULE BD_False_P597:
  CALL: 4H
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call != 'PASS'
  CONDITION: last_bid_level > 2.5
  CONDITION: last_bid_level <= 3.5
  CONDITION: last_bid_strain != 'NT'
  CONDITION: opponents_bid <= 0.5
  CONDITION: last_bid_strain != 'S'
  CONDITION: last_bid_strain == 'H'
  CONDITION: our_fit_shown > 0.5
  CONDITION: my_last_call == '2H'
  # distilled from Brill /bid

RULE BD_False_P598:
  CALL: 4H
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call != 'PASS'
  CONDITION: last_bid_level > 2.5
  CONDITION: last_bid_level <= 3.5
  CONDITION: last_bid_strain != 'NT'
  CONDITION: opponents_bid <= 0.5
  CONDITION: last_bid_strain != 'S'
  CONDITION: last_bid_strain == 'H'
  CONDITION: our_fit_shown > 0.5
  CONDITION: my_last_call != '2H'
  # distilled from Brill /bid

RULE BD_False_P599:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call != 'PASS'
  CONDITION: last_bid_level > 2.5
  CONDITION: last_bid_level <= 3.5
  CONDITION: last_bid_strain != 'NT'
  CONDITION: opponents_bid <= 0.5
  CONDITION: last_bid_strain != 'S'
  CONDITION: last_bid_strain != 'H'
  CONDITION: hcp <= 16.5
  CONDITION: agreed_trump == 'D'
  # distilled from Brill /bid

RULE BD_False_P600:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call != 'PASS'
  CONDITION: last_bid_level > 2.5
  CONDITION: last_bid_level <= 3.5
  CONDITION: last_bid_strain != 'NT'
  CONDITION: opponents_bid <= 0.5
  CONDITION: last_bid_strain != 'S'
  CONDITION: last_bid_strain != 'H'
  CONDITION: hcp <= 16.5
  CONDITION: agreed_trump != 'D'
  # distilled from Brill /bid

RULE BD_False_P601:
  CALL: 3S
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call != 'PASS'
  CONDITION: last_bid_level > 2.5
  CONDITION: last_bid_level <= 3.5
  CONDITION: last_bid_strain != 'NT'
  CONDITION: opponents_bid <= 0.5
  CONDITION: last_bid_strain != 'S'
  CONDITION: last_bid_strain != 'H'
  CONDITION: hcp > 16.5
  CONDITION: heart_len <= 3.5
  # distilled from Brill /bid

RULE BD_False_P602:
  CALL: 3H
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call != 'PASS'
  CONDITION: last_bid_level > 2.5
  CONDITION: last_bid_level <= 3.5
  CONDITION: last_bid_strain != 'NT'
  CONDITION: opponents_bid <= 0.5
  CONDITION: last_bid_strain != 'S'
  CONDITION: last_bid_strain != 'H'
  CONDITION: hcp > 16.5
  CONDITION: heart_len > 3.5
  # distilled from Brill /bid

RULE BD_False_P603:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call != 'PASS'
  CONDITION: last_bid_level > 2.5
  CONDITION: last_bid_level <= 3.5
  CONDITION: last_bid_strain != 'NT'
  CONDITION: opponents_bid > 0.5
  CONDITION: s_is_best_major <= 0.5
  CONDITION: d_is_longest <= 0.5
  CONDITION: hcp <= 11.5
  CONDITION: singleton_count <= 0.5
  # distilled from Brill /bid

RULE BD_False_P604:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call != 'PASS'
  CONDITION: last_bid_level > 2.5
  CONDITION: last_bid_level <= 3.5
  CONDITION: last_bid_strain != 'NT'
  CONDITION: opponents_bid > 0.5
  CONDITION: s_is_best_major <= 0.5
  CONDITION: d_is_longest <= 0.5
  CONDITION: hcp <= 11.5
  CONDITION: singleton_count > 0.5
  # distilled from Brill /bid

RULE BD_False_P605:
  CALL: 4H
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call != 'PASS'
  CONDITION: last_bid_level > 2.5
  CONDITION: last_bid_level <= 3.5
  CONDITION: last_bid_strain != 'NT'
  CONDITION: opponents_bid > 0.5
  CONDITION: s_is_best_major <= 0.5
  CONDITION: d_is_longest <= 0.5
  CONDITION: hcp > 11.5
  CONDITION: competition_level <= 3.5
  # distilled from Brill /bid

RULE BD_False_P606:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call != 'PASS'
  CONDITION: last_bid_level > 2.5
  CONDITION: last_bid_level <= 3.5
  CONDITION: last_bid_strain != 'NT'
  CONDITION: opponents_bid > 0.5
  CONDITION: s_is_best_major <= 0.5
  CONDITION: d_is_longest <= 0.5
  CONDITION: hcp > 11.5
  CONDITION: competition_level > 3.5
  # distilled from Brill /bid

RULE BD_False_P607:
  CALL: 3S
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call != 'PASS'
  CONDITION: last_bid_level > 2.5
  CONDITION: last_bid_level <= 3.5
  CONDITION: last_bid_strain != 'NT'
  CONDITION: opponents_bid > 0.5
  CONDITION: s_is_best_major <= 0.5
  CONDITION: d_is_longest > 0.5
  CONDITION: last_bid_strain == 'C'
  CONDITION: third_longest_len <= 1.5
  # distilled from Brill /bid

RULE BD_False_P608:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call != 'PASS'
  CONDITION: last_bid_level > 2.5
  CONDITION: last_bid_level <= 3.5
  CONDITION: last_bid_strain != 'NT'
  CONDITION: opponents_bid > 0.5
  CONDITION: s_is_best_major <= 0.5
  CONDITION: d_is_longest > 0.5
  CONDITION: last_bid_strain == 'C'
  CONDITION: third_longest_len > 1.5
  # distilled from Brill /bid

RULE BD_False_P609:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call != 'PASS'
  CONDITION: last_bid_level > 2.5
  CONDITION: last_bid_level <= 3.5
  CONDITION: last_bid_strain != 'NT'
  CONDITION: opponents_bid > 0.5
  CONDITION: s_is_best_major <= 0.5
  CONDITION: d_is_longest > 0.5
  CONDITION: last_bid_strain != 'C'
  CONDITION: hcp <= 9.5
  # distilled from Brill /bid

RULE BD_False_P610:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call != 'PASS'
  CONDITION: last_bid_level > 2.5
  CONDITION: last_bid_level <= 3.5
  CONDITION: last_bid_strain != 'NT'
  CONDITION: opponents_bid > 0.5
  CONDITION: s_is_best_major <= 0.5
  CONDITION: d_is_longest > 0.5
  CONDITION: last_bid_strain != 'C'
  CONDITION: hcp > 9.5
  # distilled from Brill /bid

RULE BD_False_P611:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call != 'PASS'
  CONDITION: last_bid_level > 2.5
  CONDITION: last_bid_level <= 3.5
  CONDITION: last_bid_strain != 'NT'
  CONDITION: opponents_bid > 0.5
  CONDITION: s_is_best_major > 0.5
  CONDITION: opp_bid_count <= 1.5
  CONDITION: support_in_partner_suit <= 3.5
  CONDITION: competition_level <= 2.5
  # distilled from Brill /bid

RULE BD_False_P612:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call != 'PASS'
  CONDITION: last_bid_level > 2.5
  CONDITION: last_bid_level <= 3.5
  CONDITION: last_bid_strain != 'NT'
  CONDITION: opponents_bid > 0.5
  CONDITION: s_is_best_major > 0.5
  CONDITION: opp_bid_count <= 1.5
  CONDITION: support_in_partner_suit <= 3.5
  CONDITION: competition_level > 2.5
  # distilled from Brill /bid

RULE BD_False_P613:
  CALL: 4S
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call != 'PASS'
  CONDITION: last_bid_level > 2.5
  CONDITION: last_bid_level <= 3.5
  CONDITION: last_bid_strain != 'NT'
  CONDITION: opponents_bid > 0.5
  CONDITION: s_is_best_major > 0.5
  CONDITION: opp_bid_count <= 1.5
  CONDITION: support_in_partner_suit > 3.5
  CONDITION: partner_last_bid_strain == 'S'
  # distilled from Brill /bid

RULE BD_False_P614:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call != 'PASS'
  CONDITION: last_bid_level > 2.5
  CONDITION: last_bid_level <= 3.5
  CONDITION: last_bid_strain != 'NT'
  CONDITION: opponents_bid > 0.5
  CONDITION: s_is_best_major > 0.5
  CONDITION: opp_bid_count <= 1.5
  CONDITION: support_in_partner_suit > 3.5
  CONDITION: partner_last_bid_strain != 'S'
  # distilled from Brill /bid

RULE BD_False_P615:
  CALL: 4S
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call != 'PASS'
  CONDITION: last_bid_level > 2.5
  CONDITION: last_bid_level <= 3.5
  CONDITION: last_bid_strain != 'NT'
  CONDITION: opponents_bid > 0.5
  CONDITION: s_is_best_major > 0.5
  CONDITION: opp_bid_count > 1.5
  CONDITION: is_semi_balanced <= 0.5
  CONDITION: auction_len <= 8.5
  # distilled from Brill /bid

RULE BD_False_P616:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call != 'PASS'
  CONDITION: last_bid_level > 2.5
  CONDITION: last_bid_level <= 3.5
  CONDITION: last_bid_strain != 'NT'
  CONDITION: opponents_bid > 0.5
  CONDITION: s_is_best_major > 0.5
  CONDITION: opp_bid_count > 1.5
  CONDITION: is_semi_balanced <= 0.5
  CONDITION: auction_len > 8.5
  # distilled from Brill /bid

RULE BD_False_P617:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call != 'PASS'
  CONDITION: last_bid_level > 2.5
  CONDITION: last_bid_level <= 3.5
  CONDITION: last_bid_strain != 'NT'
  CONDITION: opponents_bid > 0.5
  CONDITION: s_is_best_major > 0.5
  CONDITION: opp_bid_count > 1.5
  CONDITION: is_semi_balanced > 0.5
  CONDITION: partner_last_call == 'X'
  # distilled from Brill /bid

RULE BD_False_P618:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call != 'PASS'
  CONDITION: last_bid_level > 2.5
  CONDITION: last_bid_level <= 3.5
  CONDITION: last_bid_strain != 'NT'
  CONDITION: opponents_bid > 0.5
  CONDITION: s_is_best_major > 0.5
  CONDITION: opp_bid_count > 1.5
  CONDITION: is_semi_balanced > 0.5
  CONDITION: partner_last_call != 'X'
  # distilled from Brill /bid

RULE BD_False_P619:
  CALL: 5C
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call != 'PASS'
  CONDITION: last_bid_level > 2.5
  CONDITION: last_bid_level > 3.5
  CONDITION: partner_last_call == '4NT'
  CONDITION: keycard_count_agreed <= 1.5
  CONDITION: quick_tricks <= 1.25
  # distilled from Brill /bid

RULE BD_False_P620:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call != 'PASS'
  CONDITION: last_bid_level > 2.5
  CONDITION: last_bid_level > 3.5
  CONDITION: partner_last_call == '4NT'
  CONDITION: keycard_count_agreed <= 1.5
  CONDITION: quick_tricks > 1.25
  CONDITION: s_has_ten <= 0.5
  CONDITION: partner_last_bid_strain == 'C'
  CONDITION: hcp <= 10.5
  # distilled from Brill /bid

RULE BD_False_P621:
  CALL: 5D
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call != 'PASS'
  CONDITION: last_bid_level > 2.5
  CONDITION: last_bid_level > 3.5
  CONDITION: partner_last_call == '4NT'
  CONDITION: keycard_count_agreed <= 1.5
  CONDITION: quick_tricks > 1.25
  CONDITION: s_has_ten <= 0.5
  CONDITION: partner_last_bid_strain == 'C'
  CONDITION: hcp > 10.5
  # distilled from Brill /bid

RULE BD_False_P622:
  CALL: 5D
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call != 'PASS'
  CONDITION: last_bid_level > 2.5
  CONDITION: last_bid_level > 3.5
  CONDITION: partner_last_call == '4NT'
  CONDITION: keycard_count_agreed <= 1.5
  CONDITION: quick_tricks > 1.25
  CONDITION: s_has_ten <= 0.5
  CONDITION: partner_last_bid_strain != 'C'
  # distilled from Brill /bid

RULE BD_False_P623:
  CALL: 5H
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call != 'PASS'
  CONDITION: last_bid_level > 2.5
  CONDITION: last_bid_level > 3.5
  CONDITION: partner_last_call == '4NT'
  CONDITION: keycard_count_agreed <= 1.5
  CONDITION: quick_tricks > 1.25
  CONDITION: s_has_ten > 0.5
  CONDITION: major_hcp <= 9.0
  # distilled from Brill /bid

RULE BD_False_P624:
  CALL: 5D
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call != 'PASS'
  CONDITION: last_bid_level > 2.5
  CONDITION: last_bid_level > 3.5
  CONDITION: partner_last_call == '4NT'
  CONDITION: keycard_count_agreed <= 1.5
  CONDITION: quick_tricks > 1.25
  CONDITION: s_has_ten > 0.5
  CONDITION: major_hcp > 9.0
  # distilled from Brill /bid

RULE BD_False_P625:
  CALL: 5S
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call != 'PASS'
  CONDITION: last_bid_level > 2.5
  CONDITION: last_bid_level > 3.5
  CONDITION: partner_last_call == '4NT'
  CONDITION: keycard_count_agreed > 1.5
  CONDITION: controls <= 5.5
  CONDITION: diamond_len <= 2.5
  CONDITION: hcp <= 13.5
  # distilled from Brill /bid

RULE BD_False_P626:
  CALL: 5C
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call != 'PASS'
  CONDITION: last_bid_level > 2.5
  CONDITION: last_bid_level > 3.5
  CONDITION: partner_last_call == '4NT'
  CONDITION: keycard_count_agreed > 1.5
  CONDITION: controls <= 5.5
  CONDITION: diamond_len <= 2.5
  CONDITION: hcp > 13.5
  CONDITION: hcp <= 15.0
  # distilled from Brill /bid

RULE BD_False_P627:
  CALL: 6C
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call != 'PASS'
  CONDITION: last_bid_level > 2.5
  CONDITION: last_bid_level > 3.5
  CONDITION: partner_last_call == '4NT'
  CONDITION: keycard_count_agreed > 1.5
  CONDITION: controls <= 5.5
  CONDITION: diamond_len <= 2.5
  CONDITION: hcp > 13.5
  CONDITION: hcp > 15.0
  # distilled from Brill /bid

RULE BD_False_P628:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call != 'PASS'
  CONDITION: last_bid_level > 2.5
  CONDITION: last_bid_level > 3.5
  CONDITION: partner_last_call == '4NT'
  CONDITION: keycard_count_agreed > 1.5
  CONDITION: controls <= 5.5
  CONDITION: diamond_len > 2.5
  CONDITION: major_hcp <= 9.5
  CONDITION: hcp <= 11.5
  # distilled from Brill /bid

RULE BD_False_P629:
  CALL: 5H
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call != 'PASS'
  CONDITION: last_bid_level > 2.5
  CONDITION: last_bid_level > 3.5
  CONDITION: partner_last_call == '4NT'
  CONDITION: keycard_count_agreed > 1.5
  CONDITION: controls <= 5.5
  CONDITION: diamond_len > 2.5
  CONDITION: major_hcp <= 9.5
  CONDITION: hcp > 11.5
  # distilled from Brill /bid

RULE BD_False_P630:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call != 'PASS'
  CONDITION: last_bid_level > 2.5
  CONDITION: last_bid_level > 3.5
  CONDITION: partner_last_call == '4NT'
  CONDITION: keycard_count_agreed > 1.5
  CONDITION: controls <= 5.5
  CONDITION: diamond_len > 2.5
  CONDITION: major_hcp > 9.5
  CONDITION: hcp <= 15.5
  # distilled from Brill /bid

RULE BD_False_P631:
  CALL: 5S
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call != 'PASS'
  CONDITION: last_bid_level > 2.5
  CONDITION: last_bid_level > 3.5
  CONDITION: partner_last_call == '4NT'
  CONDITION: keycard_count_agreed > 1.5
  CONDITION: controls <= 5.5
  CONDITION: diamond_len > 2.5
  CONDITION: major_hcp > 9.5
  CONDITION: hcp > 15.5
  # distilled from Brill /bid

RULE BD_False_P632:
  CALL: 5C
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call != 'PASS'
  CONDITION: last_bid_level > 2.5
  CONDITION: last_bid_level > 3.5
  CONDITION: partner_last_call == '4NT'
  CONDITION: keycard_count_agreed > 1.5
  CONDITION: controls > 5.5
  CONDITION: h_is_best_major <= 0.5
  # distilled from Brill /bid

RULE BD_False_P633:
  CALL: 5D
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call != 'PASS'
  CONDITION: last_bid_level > 2.5
  CONDITION: last_bid_level > 3.5
  CONDITION: partner_last_call == '4NT'
  CONDITION: keycard_count_agreed > 1.5
  CONDITION: controls > 5.5
  CONDITION: h_is_best_major > 0.5
  CONDITION: club_hcp <= 6.0
  # distilled from Brill /bid

RULE BD_False_P634:
  CALL: 6NT
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call != 'PASS'
  CONDITION: last_bid_level > 2.5
  CONDITION: last_bid_level > 3.5
  CONDITION: partner_last_call == '4NT'
  CONDITION: keycard_count_agreed > 1.5
  CONDITION: controls > 5.5
  CONDITION: h_is_best_major > 0.5
  CONDITION: club_hcp > 6.0
  CONDITION: hcp <= 18.5
  # distilled from Brill /bid

RULE BD_False_P635:
  CALL: 6D
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call != 'PASS'
  CONDITION: last_bid_level > 2.5
  CONDITION: last_bid_level > 3.5
  CONDITION: partner_last_call == '4NT'
  CONDITION: keycard_count_agreed > 1.5
  CONDITION: controls > 5.5
  CONDITION: h_is_best_major > 0.5
  CONDITION: club_hcp > 6.0
  CONDITION: hcp > 18.5
  # distilled from Brill /bid

RULE BD_False_P636:
  CALL: 5S
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call != 'PASS'
  CONDITION: last_bid_level > 2.5
  CONDITION: last_bid_level > 3.5
  CONDITION: partner_last_call != '4NT'
  CONDITION: my_last_call == '4NT'
  CONDITION: rule20_total <= 24.5
  CONDITION: my_seat == 'W'
  CONDITION: diamond_hcp <= 1.0
  CONDITION: hcp <= 11.0
  # distilled from Brill /bid

RULE BD_False_P637:
  CALL: 6C
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call != 'PASS'
  CONDITION: last_bid_level > 2.5
  CONDITION: last_bid_level > 3.5
  CONDITION: partner_last_call != '4NT'
  CONDITION: my_last_call == '4NT'
  CONDITION: rule20_total <= 24.5
  CONDITION: my_seat == 'W'
  CONDITION: diamond_hcp <= 1.0
  CONDITION: hcp > 11.0
  # distilled from Brill /bid

RULE BD_False_P638:
  CALL: 5H
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call != 'PASS'
  CONDITION: last_bid_level > 2.5
  CONDITION: last_bid_level > 3.5
  CONDITION: partner_last_call != '4NT'
  CONDITION: my_last_call == '4NT'
  CONDITION: rule20_total <= 24.5
  CONDITION: my_seat == 'W'
  CONDITION: diamond_hcp > 1.0
  CONDITION: minor_hcp <= 3.5
  # distilled from Brill /bid

RULE BD_False_P639:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call != 'PASS'
  CONDITION: last_bid_level > 2.5
  CONDITION: last_bid_level > 3.5
  CONDITION: partner_last_call != '4NT'
  CONDITION: my_last_call == '4NT'
  CONDITION: rule20_total <= 24.5
  CONDITION: my_seat == 'W'
  CONDITION: diamond_hcp > 1.0
  CONDITION: minor_hcp > 3.5
  # distilled from Brill /bid

RULE BD_False_P640:
  CALL: 6D
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call != 'PASS'
  CONDITION: last_bid_level > 2.5
  CONDITION: last_bid_level > 3.5
  CONDITION: partner_last_call != '4NT'
  CONDITION: my_last_call == '4NT'
  CONDITION: rule20_total <= 24.5
  CONDITION: my_seat != 'W'
  CONDITION: is_balanced <= 0.5
  CONDITION: spade_hcp <= 2.5
  # distilled from Brill /bid

RULE BD_False_P641:
  CALL: 5S
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call != 'PASS'
  CONDITION: last_bid_level > 2.5
  CONDITION: last_bid_level > 3.5
  CONDITION: partner_last_call != '4NT'
  CONDITION: my_last_call == '4NT'
  CONDITION: rule20_total <= 24.5
  CONDITION: my_seat != 'W'
  CONDITION: is_balanced <= 0.5
  CONDITION: spade_hcp > 2.5
  # distilled from Brill /bid

RULE BD_False_P642:
  CALL: 5D
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call != 'PASS'
  CONDITION: last_bid_level > 2.5
  CONDITION: last_bid_level > 3.5
  CONDITION: partner_last_call != '4NT'
  CONDITION: my_last_call == '4NT'
  CONDITION: rule20_total <= 24.5
  CONDITION: my_seat != 'W'
  CONDITION: is_balanced > 0.5
  # distilled from Brill /bid

RULE BD_False_P643:
  CALL: 5NT
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call != 'PASS'
  CONDITION: last_bid_level > 2.5
  CONDITION: last_bid_level > 3.5
  CONDITION: partner_last_call != '4NT'
  CONDITION: my_last_call == '4NT'
  CONDITION: rule20_total > 24.5
  CONDITION: s_has_queen <= 0.5
  CONDITION: diamond_len <= 2.5
  CONDITION: hcp <= 15.5
  # distilled from Brill /bid

RULE BD_False_P644:
  CALL: 6H
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call != 'PASS'
  CONDITION: last_bid_level > 2.5
  CONDITION: last_bid_level > 3.5
  CONDITION: partner_last_call != '4NT'
  CONDITION: my_last_call == '4NT'
  CONDITION: rule20_total > 24.5
  CONDITION: s_has_queen <= 0.5
  CONDITION: diamond_len <= 2.5
  CONDITION: hcp > 15.5
  # distilled from Brill /bid

RULE BD_False_P645:
  CALL: 5H
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call != 'PASS'
  CONDITION: last_bid_level > 2.5
  CONDITION: last_bid_level > 3.5
  CONDITION: partner_last_call != '4NT'
  CONDITION: my_last_call == '4NT'
  CONDITION: rule20_total > 24.5
  CONDITION: s_has_queen <= 0.5
  CONDITION: diamond_len > 2.5
  CONDITION: is_vulnerable <= 0.5
  # distilled from Brill /bid

RULE BD_False_P646:
  CALL: 5S
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call != 'PASS'
  CONDITION: last_bid_level > 2.5
  CONDITION: last_bid_level > 3.5
  CONDITION: partner_last_call != '4NT'
  CONDITION: my_last_call == '4NT'
  CONDITION: rule20_total > 24.5
  CONDITION: s_has_queen <= 0.5
  CONDITION: diamond_len > 2.5
  CONDITION: is_vulnerable > 0.5
  # distilled from Brill /bid

RULE BD_False_P647:
  CALL: 6D
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call != 'PASS'
  CONDITION: last_bid_level > 2.5
  CONDITION: last_bid_level > 3.5
  CONDITION: partner_last_call != '4NT'
  CONDITION: my_last_call == '4NT'
  CONDITION: rule20_total > 24.5
  CONDITION: s_has_queen > 0.5
  CONDITION: spade_len <= 3.5
  CONDITION: club_len <= 3.0
  # distilled from Brill /bid

RULE BD_False_P648:
  CALL: 6C
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call != 'PASS'
  CONDITION: last_bid_level > 2.5
  CONDITION: last_bid_level > 3.5
  CONDITION: partner_last_call != '4NT'
  CONDITION: my_last_call == '4NT'
  CONDITION: rule20_total > 24.5
  CONDITION: s_has_queen > 0.5
  CONDITION: spade_len <= 3.5
  CONDITION: club_len > 3.0
  # distilled from Brill /bid

RULE BD_False_P649:
  CALL: 6S
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call != 'PASS'
  CONDITION: last_bid_level > 2.5
  CONDITION: last_bid_level > 3.5
  CONDITION: partner_last_call != '4NT'
  CONDITION: my_last_call == '4NT'
  CONDITION: rule20_total > 24.5
  CONDITION: s_has_queen > 0.5
  CONDITION: spade_len > 3.5
  CONDITION: king_count <= 2.5
  # distilled from Brill /bid

RULE BD_False_P650:
  CALL: 6H
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call != 'PASS'
  CONDITION: last_bid_level > 2.5
  CONDITION: last_bid_level > 3.5
  CONDITION: partner_last_call != '4NT'
  CONDITION: my_last_call == '4NT'
  CONDITION: rule20_total > 24.5
  CONDITION: s_has_queen > 0.5
  CONDITION: spade_len > 3.5
  CONDITION: king_count > 2.5
  # distilled from Brill /bid

RULE BD_False_P651:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call != 'PASS'
  CONDITION: last_bid_level > 2.5
  CONDITION: last_bid_level > 3.5
  CONDITION: partner_last_call != '4NT'
  CONDITION: my_last_call != '4NT'
  CONDITION: partner_last_call == '4D'
  CONDITION: opp_suit_stoppers <= 1.5
  CONDITION: c_has_king <= 0.5
  # distilled from Brill /bid

RULE BD_False_P652:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call != 'PASS'
  CONDITION: last_bid_level > 2.5
  CONDITION: last_bid_level > 3.5
  CONDITION: partner_last_call != '4NT'
  CONDITION: my_last_call != '4NT'
  CONDITION: partner_last_call == '4D'
  CONDITION: opp_suit_stoppers <= 1.5
  CONDITION: c_has_king > 0.5
  CONDITION: shortest_suit_len <= 1.5
  # distilled from Brill /bid

RULE BD_False_P653:
  CALL: 4S
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call != 'PASS'
  CONDITION: last_bid_level > 2.5
  CONDITION: last_bid_level > 3.5
  CONDITION: partner_last_call != '4NT'
  CONDITION: my_last_call != '4NT'
  CONDITION: partner_last_call == '4D'
  CONDITION: opp_suit_stoppers <= 1.5
  CONDITION: c_has_king > 0.5
  CONDITION: shortest_suit_len > 1.5
  # distilled from Brill /bid

RULE BD_False_P654:
  CALL: 4S
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call != 'PASS'
  CONDITION: last_bid_level > 2.5
  CONDITION: last_bid_level > 3.5
  CONDITION: partner_last_call != '4NT'
  CONDITION: my_last_call != '4NT'
  CONDITION: partner_last_call == '4D'
  CONDITION: opp_suit_stoppers > 1.5
  CONDITION: my_side_bid_count <= 2.5
  CONDITION: my_last_call == '1S'
  # distilled from Brill /bid

RULE BD_False_P655:
  CALL: 4H
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call != 'PASS'
  CONDITION: last_bid_level > 2.5
  CONDITION: last_bid_level > 3.5
  CONDITION: partner_last_call != '4NT'
  CONDITION: my_last_call != '4NT'
  CONDITION: partner_last_call == '4D'
  CONDITION: opp_suit_stoppers > 1.5
  CONDITION: my_side_bid_count <= 2.5
  CONDITION: my_last_call != '1S'
  # distilled from Brill /bid

RULE BD_False_P656:
  CALL: 4NT
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call != 'PASS'
  CONDITION: last_bid_level > 2.5
  CONDITION: last_bid_level > 3.5
  CONDITION: partner_last_call != '4NT'
  CONDITION: my_last_call != '4NT'
  CONDITION: partner_last_call == '4D'
  CONDITION: opp_suit_stoppers > 1.5
  CONDITION: my_side_bid_count > 2.5
  CONDITION: my_seat == 'E'
  # distilled from Brill /bid

RULE BD_False_P657:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call != 'PASS'
  CONDITION: last_bid_level > 2.5
  CONDITION: last_bid_level > 3.5
  CONDITION: partner_last_call != '4NT'
  CONDITION: my_last_call != '4NT'
  CONDITION: partner_last_call == '4D'
  CONDITION: opp_suit_stoppers > 1.5
  CONDITION: my_side_bid_count > 2.5
  CONDITION: my_seat != 'E'
  # distilled from Brill /bid

RULE BD_False_P658:
  CALL: 4S
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call != 'PASS'
  CONDITION: last_bid_level > 2.5
  CONDITION: last_bid_level > 3.5
  CONDITION: partner_last_call != '4NT'
  CONDITION: my_last_call != '4NT'
  CONDITION: partner_last_call != '4D'
  CONDITION: my_side_bid_count <= 2.5
  CONDITION: my_last_call == '1S'
  CONDITION: has_trump_queen <= 0.5
  # distilled from Brill /bid

RULE BD_False_P659:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call != 'PASS'
  CONDITION: last_bid_level > 2.5
  CONDITION: last_bid_level > 3.5
  CONDITION: partner_last_call != '4NT'
  CONDITION: my_last_call != '4NT'
  CONDITION: partner_last_call != '4D'
  CONDITION: my_side_bid_count <= 2.5
  CONDITION: my_last_call == '1S'
  CONDITION: has_trump_queen > 0.5
  # distilled from Brill /bid

RULE BD_False_P660:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call != 'PASS'
  CONDITION: last_bid_level > 2.5
  CONDITION: last_bid_level > 3.5
  CONDITION: partner_last_call != '4NT'
  CONDITION: my_last_call != '4NT'
  CONDITION: partner_last_call != '4D'
  CONDITION: my_side_bid_count <= 2.5
  CONDITION: my_last_call != '1S'
  CONDITION: opp_first_bid_level <= 2.5
  # distilled from Brill /bid

RULE BD_False_P661:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call != 'PASS'
  CONDITION: last_bid_level > 2.5
  CONDITION: last_bid_level > 3.5
  CONDITION: partner_last_call != '4NT'
  CONDITION: my_last_call != '4NT'
  CONDITION: partner_last_call != '4D'
  CONDITION: my_side_bid_count <= 2.5
  CONDITION: my_last_call != '1S'
  CONDITION: opp_first_bid_level > 2.5
  # distilled from Brill /bid

RULE BD_False_P662:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call != 'PASS'
  CONDITION: last_bid_level > 2.5
  CONDITION: last_bid_level > 3.5
  CONDITION: partner_last_call != '4NT'
  CONDITION: my_last_call != '4NT'
  CONDITION: partner_last_call != '4D'
  CONDITION: my_side_bid_count > 2.5
  CONDITION: last_bid_level <= 4.5
  CONDITION: losing_trick_count <= 5.5
  # distilled from Brill /bid

RULE BD_False_P663:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call != 'PASS'
  CONDITION: last_bid_level > 2.5
  CONDITION: last_bid_level > 3.5
  CONDITION: partner_last_call != '4NT'
  CONDITION: my_last_call != '4NT'
  CONDITION: partner_last_call != '4D'
  CONDITION: my_side_bid_count > 2.5
  CONDITION: last_bid_level <= 4.5
  CONDITION: losing_trick_count > 5.5
  # distilled from Brill /bid

RULE BD_False_P664:
  CALL: 6NT
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call != 'PASS'
  CONDITION: last_bid_level > 2.5
  CONDITION: last_bid_level > 3.5
  CONDITION: partner_last_call != '4NT'
  CONDITION: my_last_call != '4NT'
  CONDITION: partner_last_call != '4D'
  CONDITION: my_side_bid_count > 2.5
  CONDITION: last_bid_level > 4.5
  CONDITION: partner_last_call == '5NT'
  # distilled from Brill /bid

RULE BD_False_P665:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call != 'PASS'
  CONDITION: last_bid_level > 2.5
  CONDITION: last_bid_level > 3.5
  CONDITION: partner_last_call != '4NT'
  CONDITION: my_last_call != '4NT'
  CONDITION: partner_last_call != '4D'
  CONDITION: my_side_bid_count > 2.5
  CONDITION: last_bid_level > 4.5
  CONDITION: partner_last_call != '5NT'
  # distilled from Brill /bid

RULE BD_True_P0:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == True
  CONDITION: hcp <= 11.5
  CONDITION: longest_suit_len <= 5.5
  CONDITION: rule20_total <= 19.5
  # distilled from Brill /bid

RULE BD_True_P1:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == True
  CONDITION: hcp <= 11.5
  CONDITION: longest_suit_len <= 5.5
  CONDITION: rule20_total > 19.5
  CONDITION: rule20_total <= 20.5
  CONDITION: spade_len <= 4.5
  CONDITION: spade_len <= 3.5
  # distilled from Brill /bid

RULE BD_True_P2:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == True
  CONDITION: hcp <= 11.5
  CONDITION: longest_suit_len <= 5.5
  CONDITION: rule20_total > 19.5
  CONDITION: rule20_total <= 20.5
  CONDITION: spade_len <= 4.5
  CONDITION: spade_len > 3.5
  CONDITION: heart_len <= 4.5
  # distilled from Brill /bid

RULE BD_True_P3:
  CALL: 1H
  PRIORITY: 10
  CONDITION: is_opening == True
  CONDITION: hcp <= 11.5
  CONDITION: longest_suit_len <= 5.5
  CONDITION: rule20_total > 19.5
  CONDITION: rule20_total <= 20.5
  CONDITION: spade_len <= 4.5
  CONDITION: spade_len > 3.5
  CONDITION: heart_len > 4.5
  CONDITION: major_hcp <= 9.5
  # distilled from Brill /bid

RULE BD_True_P4:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == True
  CONDITION: hcp <= 11.5
  CONDITION: longest_suit_len <= 5.5
  CONDITION: rule20_total > 19.5
  CONDITION: rule20_total <= 20.5
  CONDITION: spade_len <= 4.5
  CONDITION: spade_len > 3.5
  CONDITION: heart_len > 4.5
  CONDITION: major_hcp > 9.5
  # distilled from Brill /bid

RULE BD_True_P5:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == True
  CONDITION: hcp <= 11.5
  CONDITION: longest_suit_len <= 5.5
  CONDITION: rule20_total > 19.5
  CONDITION: rule20_total <= 20.5
  CONDITION: spade_len > 4.5
  CONDITION: heart_len <= 3.5
  # distilled from Brill /bid

RULE BD_True_P6:
  CALL: 1S
  PRIORITY: 10
  CONDITION: is_opening == True
  CONDITION: hcp <= 11.5
  CONDITION: longest_suit_len <= 5.5
  CONDITION: rule20_total > 19.5
  CONDITION: rule20_total <= 20.5
  CONDITION: spade_len > 4.5
  CONDITION: heart_len > 3.5
  CONDITION: is_unfavorable_vuln <= 0.5
  # distilled from Brill /bid

RULE BD_True_P7:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == True
  CONDITION: hcp <= 11.5
  CONDITION: longest_suit_len <= 5.5
  CONDITION: rule20_total > 19.5
  CONDITION: rule20_total <= 20.5
  CONDITION: spade_len > 4.5
  CONDITION: heart_len > 3.5
  CONDITION: is_unfavorable_vuln > 0.5
  # distilled from Brill /bid

RULE BD_True_P8:
  CALL: 1H
  PRIORITY: 10
  CONDITION: is_opening == True
  CONDITION: hcp <= 11.5
  CONDITION: longest_suit_len <= 5.5
  CONDITION: rule20_total > 19.5
  CONDITION: rule20_total > 20.5
  CONDITION: s_is_best_major <= 0.5
  # distilled from Brill /bid

RULE BD_True_P9:
  CALL: 1D
  PRIORITY: 10
  CONDITION: is_opening == True
  CONDITION: hcp <= 11.5
  CONDITION: longest_suit_len <= 5.5
  CONDITION: rule20_total > 19.5
  CONDITION: rule20_total > 20.5
  CONDITION: s_is_best_major > 0.5
  CONDITION: major_hcp <= 6.5
  # distilled from Brill /bid

RULE BD_True_P10:
  CALL: 1S
  PRIORITY: 10
  CONDITION: is_opening == True
  CONDITION: hcp <= 11.5
  CONDITION: longest_suit_len <= 5.5
  CONDITION: rule20_total > 19.5
  CONDITION: rule20_total > 20.5
  CONDITION: s_is_best_major > 0.5
  CONDITION: major_hcp > 6.5
  # distilled from Brill /bid

RULE BD_True_P11:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == True
  CONDITION: hcp <= 11.5
  CONDITION: longest_suit_len > 5.5
  CONDITION: spade_len <= 5.5
  CONDITION: diamond_len <= 5.5
  CONDITION: longest_suit_len <= 6.5
  CONDITION: rule20_total <= 20.5
  CONDITION: heart_len <= 5.5
  # distilled from Brill /bid

RULE BD_True_P12:
  CALL: 2H
  PRIORITY: 10
  CONDITION: is_opening == True
  CONDITION: hcp <= 11.5
  CONDITION: longest_suit_len > 5.5
  CONDITION: spade_len <= 5.5
  CONDITION: diamond_len <= 5.5
  CONDITION: longest_suit_len <= 6.5
  CONDITION: rule20_total <= 20.5
  CONDITION: heart_len > 5.5
  CONDITION: h_top3_honors <= 1.5
  CONDITION: losing_trick_count <= 7.5
  CONDITION: hcp <= 10.5
  # distilled from Brill /bid

RULE BD_True_P13:
  CALL: 1H
  PRIORITY: 10
  CONDITION: is_opening == True
  CONDITION: hcp <= 11.5
  CONDITION: longest_suit_len > 5.5
  CONDITION: spade_len <= 5.5
  CONDITION: diamond_len <= 5.5
  CONDITION: longest_suit_len <= 6.5
  CONDITION: rule20_total <= 20.5
  CONDITION: heart_len > 5.5
  CONDITION: h_top3_honors <= 1.5
  CONDITION: losing_trick_count <= 7.5
  CONDITION: hcp > 10.5
  # distilled from Brill /bid

RULE BD_True_P14:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == True
  CONDITION: hcp <= 11.5
  CONDITION: longest_suit_len > 5.5
  CONDITION: spade_len <= 5.5
  CONDITION: diamond_len <= 5.5
  CONDITION: longest_suit_len <= 6.5
  CONDITION: rule20_total <= 20.5
  CONDITION: heart_len > 5.5
  CONDITION: h_top3_honors <= 1.5
  CONDITION: losing_trick_count > 7.5
  CONDITION: is_favorable_vuln <= 0.5
  # distilled from Brill /bid

RULE BD_True_P15:
  CALL: 2H
  PRIORITY: 10
  CONDITION: is_opening == True
  CONDITION: hcp <= 11.5
  CONDITION: longest_suit_len > 5.5
  CONDITION: spade_len <= 5.5
  CONDITION: diamond_len <= 5.5
  CONDITION: longest_suit_len <= 6.5
  CONDITION: rule20_total <= 20.5
  CONDITION: heart_len > 5.5
  CONDITION: h_top3_honors <= 1.5
  CONDITION: losing_trick_count > 7.5
  CONDITION: is_favorable_vuln > 0.5
  # distilled from Brill /bid

RULE BD_True_P16:
  CALL: 2H
  PRIORITY: 10
  CONDITION: is_opening == True
  CONDITION: hcp <= 11.5
  CONDITION: longest_suit_len > 5.5
  CONDITION: spade_len <= 5.5
  CONDITION: diamond_len <= 5.5
  CONDITION: longest_suit_len <= 6.5
  CONDITION: rule20_total <= 20.5
  CONDITION: heart_len > 5.5
  CONDITION: h_top3_honors > 1.5
  CONDITION: spade_len <= 3.5
  # distilled from Brill /bid

RULE BD_True_P17:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == True
  CONDITION: hcp <= 11.5
  CONDITION: longest_suit_len > 5.5
  CONDITION: spade_len <= 5.5
  CONDITION: diamond_len <= 5.5
  CONDITION: longest_suit_len <= 6.5
  CONDITION: rule20_total <= 20.5
  CONDITION: heart_len > 5.5
  CONDITION: h_top3_honors > 1.5
  CONDITION: spade_len > 3.5
  # distilled from Brill /bid

RULE BD_True_P18:
  CALL: 1H
  PRIORITY: 10
  CONDITION: is_opening == True
  CONDITION: hcp <= 11.5
  CONDITION: longest_suit_len > 5.5
  CONDITION: spade_len <= 5.5
  CONDITION: diamond_len <= 5.5
  CONDITION: longest_suit_len <= 6.5
  CONDITION: rule20_total > 20.5
  CONDITION: club_hcp <= 2.0
  # distilled from Brill /bid

RULE BD_True_P19:
  CALL: 1C
  PRIORITY: 10
  CONDITION: is_opening == True
  CONDITION: hcp <= 11.5
  CONDITION: longest_suit_len > 5.5
  CONDITION: spade_len <= 5.5
  CONDITION: diamond_len <= 5.5
  CONDITION: longest_suit_len <= 6.5
  CONDITION: rule20_total > 20.5
  CONDITION: club_hcp > 2.0
  # distilled from Brill /bid

RULE BD_True_P20:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == True
  CONDITION: hcp <= 11.5
  CONDITION: longest_suit_len > 5.5
  CONDITION: spade_len <= 5.5
  CONDITION: diamond_len <= 5.5
  CONDITION: longest_suit_len > 6.5
  CONDITION: heart_len <= 5.0
  CONDITION: hcp <= 3.5
  # distilled from Brill /bid

RULE BD_True_P21:
  CALL: 3C
  PRIORITY: 10
  CONDITION: is_opening == True
  CONDITION: hcp <= 11.5
  CONDITION: longest_suit_len > 5.5
  CONDITION: spade_len <= 5.5
  CONDITION: diamond_len <= 5.5
  CONDITION: longest_suit_len > 6.5
  CONDITION: heart_len <= 5.0
  CONDITION: hcp > 3.5
  CONDITION: spade_hcp <= 3.5
  CONDITION: club_len <= 7.5
  # distilled from Brill /bid

RULE BD_True_P22:
  CALL: 4C
  PRIORITY: 10
  CONDITION: is_opening == True
  CONDITION: hcp <= 11.5
  CONDITION: longest_suit_len > 5.5
  CONDITION: spade_len <= 5.5
  CONDITION: diamond_len <= 5.5
  CONDITION: longest_suit_len > 6.5
  CONDITION: heart_len <= 5.0
  CONDITION: hcp > 3.5
  CONDITION: spade_hcp <= 3.5
  CONDITION: club_len > 7.5
  # distilled from Brill /bid

RULE BD_True_P23:
  CALL: 1C
  PRIORITY: 10
  CONDITION: is_opening == True
  CONDITION: hcp <= 11.5
  CONDITION: longest_suit_len > 5.5
  CONDITION: spade_len <= 5.5
  CONDITION: diamond_len <= 5.5
  CONDITION: longest_suit_len > 6.5
  CONDITION: heart_len <= 5.0
  CONDITION: hcp > 3.5
  CONDITION: spade_hcp > 3.5
  # distilled from Brill /bid

RULE BD_True_P24:
  CALL: 4H
  PRIORITY: 10
  CONDITION: is_opening == True
  CONDITION: hcp <= 11.5
  CONDITION: longest_suit_len > 5.5
  CONDITION: spade_len <= 5.5
  CONDITION: diamond_len <= 5.5
  CONDITION: longest_suit_len > 6.5
  CONDITION: heart_len > 5.0
  CONDITION: losing_trick_count <= 5.5
  CONDITION: major_hcp <= 9.0
  # distilled from Brill /bid

RULE BD_True_P25:
  CALL: 5H
  PRIORITY: 10
  CONDITION: is_opening == True
  CONDITION: hcp <= 11.5
  CONDITION: longest_suit_len > 5.5
  CONDITION: spade_len <= 5.5
  CONDITION: diamond_len <= 5.5
  CONDITION: longest_suit_len > 6.5
  CONDITION: heart_len > 5.0
  CONDITION: losing_trick_count <= 5.5
  CONDITION: major_hcp > 9.0
  # distilled from Brill /bid

RULE BD_True_P26:
  CALL: 3H
  PRIORITY: 10
  CONDITION: is_opening == True
  CONDITION: hcp <= 11.5
  CONDITION: longest_suit_len > 5.5
  CONDITION: spade_len <= 5.5
  CONDITION: diamond_len <= 5.5
  CONDITION: longest_suit_len > 6.5
  CONDITION: heart_len > 5.0
  CONDITION: losing_trick_count > 5.5
  # distilled from Brill /bid

RULE BD_True_P27:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == True
  CONDITION: hcp <= 11.5
  CONDITION: longest_suit_len > 5.5
  CONDITION: spade_len <= 5.5
  CONDITION: diamond_len > 5.5
  CONDITION: rule20_total <= 20.5
  CONDITION: diamond_len <= 6.5
  CONDITION: diamond_hcp <= 5.5
  CONDITION: h_has_jack <= 0.5
  CONDITION: s_has_queen <= 0.5
  CONDITION: quick_tricks <= 1.75
  # distilled from Brill /bid

RULE BD_True_P28:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == True
  CONDITION: hcp <= 11.5
  CONDITION: longest_suit_len > 5.5
  CONDITION: spade_len <= 5.5
  CONDITION: diamond_len > 5.5
  CONDITION: rule20_total <= 20.5
  CONDITION: diamond_len <= 6.5
  CONDITION: diamond_hcp <= 5.5
  CONDITION: h_has_jack <= 0.5
  CONDITION: s_has_queen <= 0.5
  CONDITION: quick_tricks > 1.75
  # distilled from Brill /bid

RULE BD_True_P29:
  CALL: 2D
  PRIORITY: 10
  CONDITION: is_opening == True
  CONDITION: hcp <= 11.5
  CONDITION: longest_suit_len > 5.5
  CONDITION: spade_len <= 5.5
  CONDITION: diamond_len > 5.5
  CONDITION: rule20_total <= 20.5
  CONDITION: diamond_len <= 6.5
  CONDITION: diamond_hcp <= 5.5
  CONDITION: h_has_jack <= 0.5
  CONDITION: s_has_queen > 0.5
  CONDITION: hcp <= 8.5
  # distilled from Brill /bid

RULE BD_True_P30:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == True
  CONDITION: hcp <= 11.5
  CONDITION: longest_suit_len > 5.5
  CONDITION: spade_len <= 5.5
  CONDITION: diamond_len > 5.5
  CONDITION: rule20_total <= 20.5
  CONDITION: diamond_len <= 6.5
  CONDITION: diamond_hcp <= 5.5
  CONDITION: h_has_jack <= 0.5
  CONDITION: s_has_queen > 0.5
  CONDITION: hcp > 8.5
  # distilled from Brill /bid

RULE BD_True_P31:
  CALL: 2D
  PRIORITY: 10
  CONDITION: is_opening == True
  CONDITION: hcp <= 11.5
  CONDITION: longest_suit_len > 5.5
  CONDITION: spade_len <= 5.5
  CONDITION: diamond_len > 5.5
  CONDITION: rule20_total <= 20.5
  CONDITION: diamond_len <= 6.5
  CONDITION: diamond_hcp <= 5.5
  CONDITION: h_has_jack > 0.5
  CONDITION: s_has_jack <= 0.5
  # distilled from Brill /bid

RULE BD_True_P32:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == True
  CONDITION: hcp <= 11.5
  CONDITION: longest_suit_len > 5.5
  CONDITION: spade_len <= 5.5
  CONDITION: diamond_len > 5.5
  CONDITION: rule20_total <= 20.5
  CONDITION: diamond_len <= 6.5
  CONDITION: diamond_hcp <= 5.5
  CONDITION: h_has_jack > 0.5
  CONDITION: s_has_jack > 0.5
  # distilled from Brill /bid

RULE BD_True_P33:
  CALL: 2D
  PRIORITY: 10
  CONDITION: is_opening == True
  CONDITION: hcp <= 11.5
  CONDITION: longest_suit_len > 5.5
  CONDITION: spade_len <= 5.5
  CONDITION: diamond_len > 5.5
  CONDITION: rule20_total <= 20.5
  CONDITION: diamond_len <= 6.5
  CONDITION: diamond_hcp > 5.5
  # distilled from Brill /bid

RULE BD_True_P34:
  CALL: 3D
  PRIORITY: 10
  CONDITION: is_opening == True
  CONDITION: hcp <= 11.5
  CONDITION: longest_suit_len > 5.5
  CONDITION: spade_len <= 5.5
  CONDITION: diamond_len > 5.5
  CONDITION: rule20_total <= 20.5
  CONDITION: diamond_len > 6.5
  CONDITION: s_has_king <= 0.5
  CONDITION: heart_hcp <= 3.5
  # distilled from Brill /bid

RULE BD_True_P35:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == True
  CONDITION: hcp <= 11.5
  CONDITION: longest_suit_len > 5.5
  CONDITION: spade_len <= 5.5
  CONDITION: diamond_len > 5.5
  CONDITION: rule20_total <= 20.5
  CONDITION: diamond_len > 6.5
  CONDITION: s_has_king <= 0.5
  CONDITION: heart_hcp > 3.5
  # distilled from Brill /bid

RULE BD_True_P36:
  CALL: 4D
  PRIORITY: 10
  CONDITION: is_opening == True
  CONDITION: hcp <= 11.5
  CONDITION: longest_suit_len > 5.5
  CONDITION: spade_len <= 5.5
  CONDITION: diamond_len > 5.5
  CONDITION: rule20_total <= 20.5
  CONDITION: diamond_len > 6.5
  CONDITION: s_has_king > 0.5
  # distilled from Brill /bid

RULE BD_True_P37:
  CALL: 1D
  PRIORITY: 10
  CONDITION: is_opening == True
  CONDITION: hcp <= 11.5
  CONDITION: longest_suit_len > 5.5
  CONDITION: spade_len <= 5.5
  CONDITION: diamond_len > 5.5
  CONDITION: rule20_total > 20.5
  # distilled from Brill /bid

RULE BD_True_P38:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == True
  CONDITION: hcp <= 11.5
  CONDITION: longest_suit_len > 5.5
  CONDITION: spade_len > 5.5
  CONDITION: spade_len <= 6.5
  CONDITION: rule20_total <= 20.5
  CONDITION: quick_tricks <= 0.75
  CONDITION: c_has_queen <= 0.5
  # distilled from Brill /bid

RULE BD_True_P39:
  CALL: 2S
  PRIORITY: 10
  CONDITION: is_opening == True
  CONDITION: hcp <= 11.5
  CONDITION: longest_suit_len > 5.5
  CONDITION: spade_len > 5.5
  CONDITION: spade_len <= 6.5
  CONDITION: rule20_total <= 20.5
  CONDITION: quick_tricks <= 0.75
  CONDITION: c_has_queen > 0.5
  # distilled from Brill /bid

RULE BD_True_P40:
  CALL: 2S
  PRIORITY: 10
  CONDITION: is_opening == True
  CONDITION: hcp <= 11.5
  CONDITION: longest_suit_len > 5.5
  CONDITION: spade_len > 5.5
  CONDITION: spade_len <= 6.5
  CONDITION: rule20_total <= 20.5
  CONDITION: quick_tricks > 0.75
  CONDITION: hcp <= 10.5
  CONDITION: losing_trick_count <= 7.5
  CONDITION: controls <= 3.5
  # distilled from Brill /bid

RULE BD_True_P41:
  CALL: 2S
  PRIORITY: 10
  CONDITION: is_opening == True
  CONDITION: hcp <= 11.5
  CONDITION: longest_suit_len > 5.5
  CONDITION: spade_len > 5.5
  CONDITION: spade_len <= 6.5
  CONDITION: rule20_total <= 20.5
  CONDITION: quick_tricks > 0.75
  CONDITION: hcp <= 10.5
  CONDITION: losing_trick_count <= 7.5
  CONDITION: controls > 3.5
  CONDITION: diamond_len <= 3.0
  # distilled from Brill /bid

RULE BD_True_P42:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == True
  CONDITION: hcp <= 11.5
  CONDITION: longest_suit_len > 5.5
  CONDITION: spade_len > 5.5
  CONDITION: spade_len <= 6.5
  CONDITION: rule20_total <= 20.5
  CONDITION: quick_tricks > 0.75
  CONDITION: hcp <= 10.5
  CONDITION: losing_trick_count <= 7.5
  CONDITION: controls > 3.5
  CONDITION: diamond_len > 3.0
  # distilled from Brill /bid

RULE BD_True_P43:
  CALL: 2S
  PRIORITY: 10
  CONDITION: is_opening == True
  CONDITION: hcp <= 11.5
  CONDITION: longest_suit_len > 5.5
  CONDITION: spade_len > 5.5
  CONDITION: spade_len <= 6.5
  CONDITION: rule20_total <= 20.5
  CONDITION: quick_tricks > 0.75
  CONDITION: hcp <= 10.5
  CONDITION: losing_trick_count > 7.5
  CONDITION: major_hcp <= 6.5
  CONDITION: hcp <= 6.5
  # distilled from Brill /bid

RULE BD_True_P44:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == True
  CONDITION: hcp <= 11.5
  CONDITION: longest_suit_len > 5.5
  CONDITION: spade_len > 5.5
  CONDITION: spade_len <= 6.5
  CONDITION: rule20_total <= 20.5
  CONDITION: quick_tricks > 0.75
  CONDITION: hcp <= 10.5
  CONDITION: losing_trick_count > 7.5
  CONDITION: major_hcp <= 6.5
  CONDITION: hcp > 6.5
  # distilled from Brill /bid

RULE BD_True_P45:
  CALL: 2S
  PRIORITY: 10
  CONDITION: is_opening == True
  CONDITION: hcp <= 11.5
  CONDITION: longest_suit_len > 5.5
  CONDITION: spade_len > 5.5
  CONDITION: spade_len <= 6.5
  CONDITION: rule20_total <= 20.5
  CONDITION: quick_tricks > 0.75
  CONDITION: hcp <= 10.5
  CONDITION: losing_trick_count > 7.5
  CONDITION: major_hcp > 6.5
  # distilled from Brill /bid

RULE BD_True_P46:
  CALL: 1S
  PRIORITY: 10
  CONDITION: is_opening == True
  CONDITION: hcp <= 11.5
  CONDITION: longest_suit_len > 5.5
  CONDITION: spade_len > 5.5
  CONDITION: spade_len <= 6.5
  CONDITION: rule20_total <= 20.5
  CONDITION: quick_tricks > 0.75
  CONDITION: hcp > 10.5
  CONDITION: is_vulnerable <= 0.5
  # distilled from Brill /bid

RULE BD_True_P47:
  CALL: 2S
  PRIORITY: 10
  CONDITION: is_opening == True
  CONDITION: hcp <= 11.5
  CONDITION: longest_suit_len > 5.5
  CONDITION: spade_len > 5.5
  CONDITION: spade_len <= 6.5
  CONDITION: rule20_total <= 20.5
  CONDITION: quick_tricks > 0.75
  CONDITION: hcp > 10.5
  CONDITION: is_vulnerable > 0.5
  CONDITION: h_has_jack <= 0.5
  # distilled from Brill /bid

RULE BD_True_P48:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == True
  CONDITION: hcp <= 11.5
  CONDITION: longest_suit_len > 5.5
  CONDITION: spade_len > 5.5
  CONDITION: spade_len <= 6.5
  CONDITION: rule20_total <= 20.5
  CONDITION: quick_tricks > 0.75
  CONDITION: hcp > 10.5
  CONDITION: is_vulnerable > 0.5
  CONDITION: h_has_jack > 0.5
  # distilled from Brill /bid

RULE BD_True_P49:
  CALL: 1S
  PRIORITY: 10
  CONDITION: is_opening == True
  CONDITION: hcp <= 11.5
  CONDITION: longest_suit_len > 5.5
  CONDITION: spade_len > 5.5
  CONDITION: spade_len <= 6.5
  CONDITION: rule20_total > 20.5
  # distilled from Brill /bid

RULE BD_True_P50:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == True
  CONDITION: hcp <= 11.5
  CONDITION: longest_suit_len > 5.5
  CONDITION: spade_len > 5.5
  CONDITION: spade_len > 6.5
  CONDITION: rule20_total <= 20.5
  CONDITION: hcp <= 4.5
  # distilled from Brill /bid

RULE BD_True_P51:
  CALL: 3S
  PRIORITY: 10
  CONDITION: is_opening == True
  CONDITION: hcp <= 11.5
  CONDITION: longest_suit_len > 5.5
  CONDITION: spade_len > 5.5
  CONDITION: spade_len > 6.5
  CONDITION: rule20_total <= 20.5
  CONDITION: hcp > 4.5
  # distilled from Brill /bid

RULE BD_True_P52:
  CALL: 4S
  PRIORITY: 10
  CONDITION: is_opening == True
  CONDITION: hcp <= 11.5
  CONDITION: longest_suit_len > 5.5
  CONDITION: spade_len > 5.5
  CONDITION: spade_len > 6.5
  CONDITION: rule20_total > 20.5
  CONDITION: hcp <= 10.0
  # distilled from Brill /bid

RULE BD_True_P53:
  CALL: 1S
  PRIORITY: 10
  CONDITION: is_opening == True
  CONDITION: hcp <= 11.5
  CONDITION: longest_suit_len > 5.5
  CONDITION: spade_len > 5.5
  CONDITION: spade_len > 6.5
  CONDITION: rule20_total > 20.5
  CONDITION: hcp > 10.0
  # distilled from Brill /bid

RULE BD_True_P54:
  CALL: 1D
  PRIORITY: 10
  CONDITION: is_opening == True
  CONDITION: hcp > 11.5
  CONDITION: spade_len <= 4.5
  CONDITION: d_is_longest <= 0.5
  CONDITION: heart_len <= 4.5
  CONDITION: hcp <= 14.5
  CONDITION: club_len <= 2.5
  # distilled from Brill /bid

RULE BD_True_P55:
  CALL: 1C
  PRIORITY: 10
  CONDITION: is_opening == True
  CONDITION: hcp > 11.5
  CONDITION: spade_len <= 4.5
  CONDITION: d_is_longest <= 0.5
  CONDITION: heart_len <= 4.5
  CONDITION: hcp <= 14.5
  CONDITION: club_len > 2.5
  # distilled from Brill /bid

RULE BD_True_P56:
  CALL: 1C
  PRIORITY: 10
  CONDITION: is_opening == True
  CONDITION: hcp > 11.5
  CONDITION: spade_len <= 4.5
  CONDITION: d_is_longest <= 0.5
  CONDITION: heart_len <= 4.5
  CONDITION: hcp > 14.5
  CONDITION: total_points <= 17.5
  CONDITION: is_semi_balanced <= 0.5
  # distilled from Brill /bid

RULE BD_True_P57:
  CALL: 1NT
  PRIORITY: 10
  CONDITION: is_opening == True
  CONDITION: hcp > 11.5
  CONDITION: spade_len <= 4.5
  CONDITION: d_is_longest <= 0.5
  CONDITION: heart_len <= 4.5
  CONDITION: hcp > 14.5
  CONDITION: total_points <= 17.5
  CONDITION: is_semi_balanced > 0.5
  # distilled from Brill /bid

RULE BD_True_P58:
  CALL: 1NT
  PRIORITY: 10
  CONDITION: is_opening == True
  CONDITION: hcp > 11.5
  CONDITION: spade_len <= 4.5
  CONDITION: d_is_longest <= 0.5
  CONDITION: heart_len <= 4.5
  CONDITION: hcp > 14.5
  CONDITION: total_points > 17.5
  CONDITION: hcp <= 19.5
  CONDITION: club_len <= 2.5
  CONDITION: hcp <= 17.5
  # distilled from Brill /bid

RULE BD_True_P59:
  CALL: 1D
  PRIORITY: 10
  CONDITION: is_opening == True
  CONDITION: hcp > 11.5
  CONDITION: spade_len <= 4.5
  CONDITION: d_is_longest <= 0.5
  CONDITION: heart_len <= 4.5
  CONDITION: hcp > 14.5
  CONDITION: total_points > 17.5
  CONDITION: hcp <= 19.5
  CONDITION: club_len <= 2.5
  CONDITION: hcp > 17.5
  # distilled from Brill /bid

RULE BD_True_P60:
  CALL: 1C
  PRIORITY: 10
  CONDITION: is_opening == True
  CONDITION: hcp > 11.5
  CONDITION: spade_len <= 4.5
  CONDITION: d_is_longest <= 0.5
  CONDITION: heart_len <= 4.5
  CONDITION: hcp > 14.5
  CONDITION: total_points > 17.5
  CONDITION: hcp <= 19.5
  CONDITION: club_len > 2.5
  # distilled from Brill /bid

RULE BD_True_P61:
  CALL: 2NT
  PRIORITY: 10
  CONDITION: is_opening == True
  CONDITION: hcp > 11.5
  CONDITION: spade_len <= 4.5
  CONDITION: d_is_longest <= 0.5
  CONDITION: heart_len <= 4.5
  CONDITION: hcp > 14.5
  CONDITION: total_points > 17.5
  CONDITION: hcp > 19.5
  CONDITION: hcp <= 21.5
  # distilled from Brill /bid

RULE BD_True_P62:
  CALL: 2C
  PRIORITY: 10
  CONDITION: is_opening == True
  CONDITION: hcp > 11.5
  CONDITION: spade_len <= 4.5
  CONDITION: d_is_longest <= 0.5
  CONDITION: heart_len <= 4.5
  CONDITION: hcp > 14.5
  CONDITION: total_points > 17.5
  CONDITION: hcp > 19.5
  CONDITION: hcp > 21.5
  CONDITION: hcp <= 24.5
  # distilled from Brill /bid

RULE BD_True_P63:
  CALL: 3NT
  PRIORITY: 10
  CONDITION: is_opening == True
  CONDITION: hcp > 11.5
  CONDITION: spade_len <= 4.5
  CONDITION: d_is_longest <= 0.5
  CONDITION: heart_len <= 4.5
  CONDITION: hcp > 14.5
  CONDITION: total_points > 17.5
  CONDITION: hcp > 19.5
  CONDITION: hcp > 21.5
  CONDITION: hcp > 24.5
  # distilled from Brill /bid

RULE BD_True_P64:
  CALL: 1H
  PRIORITY: 10
  CONDITION: is_opening == True
  CONDITION: hcp > 11.5
  CONDITION: spade_len <= 4.5
  CONDITION: d_is_longest <= 0.5
  CONDITION: heart_len > 4.5
  CONDITION: hcp <= 19.5
  CONDITION: shape_pattern == '5332'
  CONDITION: hcp <= 14.5
  # distilled from Brill /bid

RULE BD_True_P65:
  CALL: 1NT
  PRIORITY: 10
  CONDITION: is_opening == True
  CONDITION: hcp > 11.5
  CONDITION: spade_len <= 4.5
  CONDITION: d_is_longest <= 0.5
  CONDITION: heart_len > 4.5
  CONDITION: hcp <= 19.5
  CONDITION: shape_pattern == '5332'
  CONDITION: hcp > 14.5
  CONDITION: hcp <= 16.5
  # distilled from Brill /bid

RULE BD_True_P66:
  CALL: 1H
  PRIORITY: 10
  CONDITION: is_opening == True
  CONDITION: hcp > 11.5
  CONDITION: spade_len <= 4.5
  CONDITION: d_is_longest <= 0.5
  CONDITION: heart_len > 4.5
  CONDITION: hcp <= 19.5
  CONDITION: shape_pattern == '5332'
  CONDITION: hcp > 14.5
  CONDITION: hcp > 16.5
  # distilled from Brill /bid

RULE BD_True_P67:
  CALL: 1H
  PRIORITY: 10
  CONDITION: is_opening == True
  CONDITION: hcp > 11.5
  CONDITION: spade_len <= 4.5
  CONDITION: d_is_longest <= 0.5
  CONDITION: heart_len > 4.5
  CONDITION: hcp <= 19.5
  CONDITION: shape_pattern != '5332'
  CONDITION: club_len <= 5.5
  CONDITION: auction_len <= 2.5
  # distilled from Brill /bid

RULE BD_True_P68:
  CALL: 2H
  PRIORITY: 10
  CONDITION: is_opening == True
  CONDITION: hcp > 11.5
  CONDITION: spade_len <= 4.5
  CONDITION: d_is_longest <= 0.5
  CONDITION: heart_len > 4.5
  CONDITION: hcp <= 19.5
  CONDITION: shape_pattern != '5332'
  CONDITION: club_len <= 5.5
  CONDITION: auction_len > 2.5
  CONDITION: hcp <= 12.5
  # distilled from Brill /bid

RULE BD_True_P69:
  CALL: 1H
  PRIORITY: 10
  CONDITION: is_opening == True
  CONDITION: hcp > 11.5
  CONDITION: spade_len <= 4.5
  CONDITION: d_is_longest <= 0.5
  CONDITION: heart_len > 4.5
  CONDITION: hcp <= 19.5
  CONDITION: shape_pattern != '5332'
  CONDITION: club_len <= 5.5
  CONDITION: auction_len > 2.5
  CONDITION: hcp > 12.5
  # distilled from Brill /bid

RULE BD_True_P70:
  CALL: 1C
  PRIORITY: 10
  CONDITION: is_opening == True
  CONDITION: hcp > 11.5
  CONDITION: spade_len <= 4.5
  CONDITION: d_is_longest <= 0.5
  CONDITION: heart_len > 4.5
  CONDITION: hcp <= 19.5
  CONDITION: shape_pattern != '5332'
  CONDITION: club_len > 5.5
  # distilled from Brill /bid

RULE BD_True_P71:
  CALL: 2NT
  PRIORITY: 10
  CONDITION: is_opening == True
  CONDITION: hcp > 11.5
  CONDITION: spade_len <= 4.5
  CONDITION: d_is_longest <= 0.5
  CONDITION: heart_len > 4.5
  CONDITION: hcp > 19.5
  CONDITION: total_points <= 21.5
  # distilled from Brill /bid

RULE BD_True_P72:
  CALL: 1H
  PRIORITY: 10
  CONDITION: is_opening == True
  CONDITION: hcp > 11.5
  CONDITION: spade_len <= 4.5
  CONDITION: d_is_longest <= 0.5
  CONDITION: heart_len > 4.5
  CONDITION: hcp > 19.5
  CONDITION: total_points > 21.5
  CONDITION: hcp <= 21.0
  # distilled from Brill /bid

RULE BD_True_P73:
  CALL: 2C
  PRIORITY: 10
  CONDITION: is_opening == True
  CONDITION: hcp > 11.5
  CONDITION: spade_len <= 4.5
  CONDITION: d_is_longest <= 0.5
  CONDITION: heart_len > 4.5
  CONDITION: hcp > 19.5
  CONDITION: total_points > 21.5
  CONDITION: hcp > 21.0
  # distilled from Brill /bid

RULE BD_True_P74:
  CALL: 1D
  PRIORITY: 10
  CONDITION: is_opening == True
  CONDITION: hcp > 11.5
  CONDITION: spade_len <= 4.5
  CONDITION: d_is_longest > 0.5
  CONDITION: hcp <= 14.5
  CONDITION: heart_len <= 4.5
  # distilled from Brill /bid

RULE BD_True_P75:
  CALL: 1H
  PRIORITY: 10
  CONDITION: is_opening == True
  CONDITION: hcp > 11.5
  CONDITION: spade_len <= 4.5
  CONDITION: d_is_longest > 0.5
  CONDITION: hcp <= 14.5
  CONDITION: heart_len > 4.5
  # distilled from Brill /bid

RULE BD_True_P76:
  CALL: 1D
  PRIORITY: 10
  CONDITION: is_opening == True
  CONDITION: hcp > 11.5
  CONDITION: spade_len <= 4.5
  CONDITION: d_is_longest > 0.5
  CONDITION: hcp > 14.5
  CONDITION: is_semi_balanced <= 0.5
  CONDITION: heart_len <= 4.5
  CONDITION: controls <= 7.5
  # distilled from Brill /bid

RULE BD_True_P77:
  CALL: 2NT
  PRIORITY: 10
  CONDITION: is_opening == True
  CONDITION: hcp > 11.5
  CONDITION: spade_len <= 4.5
  CONDITION: d_is_longest > 0.5
  CONDITION: hcp > 14.5
  CONDITION: is_semi_balanced <= 0.5
  CONDITION: heart_len <= 4.5
  CONDITION: controls > 7.5
  CONDITION: hcp <= 21.0
  # distilled from Brill /bid

RULE BD_True_P78:
  CALL: 2C
  PRIORITY: 10
  CONDITION: is_opening == True
  CONDITION: hcp > 11.5
  CONDITION: spade_len <= 4.5
  CONDITION: d_is_longest > 0.5
  CONDITION: hcp > 14.5
  CONDITION: is_semi_balanced <= 0.5
  CONDITION: heart_len <= 4.5
  CONDITION: controls > 7.5
  CONDITION: hcp > 21.0
  # distilled from Brill /bid

RULE BD_True_P79:
  CALL: 1H
  PRIORITY: 10
  CONDITION: is_opening == True
  CONDITION: hcp > 11.5
  CONDITION: spade_len <= 4.5
  CONDITION: d_is_longest > 0.5
  CONDITION: hcp > 14.5
  CONDITION: is_semi_balanced <= 0.5
  CONDITION: heart_len > 4.5
  CONDITION: diamond_len <= 5.5
  # distilled from Brill /bid

RULE BD_True_P80:
  CALL: 1D
  PRIORITY: 10
  CONDITION: is_opening == True
  CONDITION: hcp > 11.5
  CONDITION: spade_len <= 4.5
  CONDITION: d_is_longest > 0.5
  CONDITION: hcp > 14.5
  CONDITION: is_semi_balanced <= 0.5
  CONDITION: heart_len > 4.5
  CONDITION: diamond_len > 5.5
  # distilled from Brill /bid

RULE BD_True_P81:
  CALL: 1NT
  PRIORITY: 10
  CONDITION: is_opening == True
  CONDITION: hcp > 11.5
  CONDITION: spade_len <= 4.5
  CONDITION: d_is_longest > 0.5
  CONDITION: hcp > 14.5
  CONDITION: is_semi_balanced > 0.5
  CONDITION: hcp <= 17.5
  # distilled from Brill /bid

RULE BD_True_P82:
  CALL: 1D
  PRIORITY: 10
  CONDITION: is_opening == True
  CONDITION: hcp > 11.5
  CONDITION: spade_len <= 4.5
  CONDITION: d_is_longest > 0.5
  CONDITION: hcp > 14.5
  CONDITION: is_semi_balanced > 0.5
  CONDITION: hcp > 17.5
  CONDITION: hcp <= 19.5
  # distilled from Brill /bid

RULE BD_True_P83:
  CALL: 2NT
  PRIORITY: 10
  CONDITION: is_opening == True
  CONDITION: hcp > 11.5
  CONDITION: spade_len <= 4.5
  CONDITION: d_is_longest > 0.5
  CONDITION: hcp > 14.5
  CONDITION: is_semi_balanced > 0.5
  CONDITION: hcp > 17.5
  CONDITION: hcp > 19.5
  CONDITION: hcp <= 22.5
  # distilled from Brill /bid

RULE BD_True_P84:
  CALL: 2C
  PRIORITY: 10
  CONDITION: is_opening == True
  CONDITION: hcp > 11.5
  CONDITION: spade_len <= 4.5
  CONDITION: d_is_longest > 0.5
  CONDITION: hcp > 14.5
  CONDITION: is_semi_balanced > 0.5
  CONDITION: hcp > 17.5
  CONDITION: hcp > 19.5
  CONDITION: hcp > 22.5
  # distilled from Brill /bid

RULE BD_True_P85:
  CALL: 1S
  PRIORITY: 10
  CONDITION: is_opening == True
  CONDITION: hcp > 11.5
  CONDITION: spade_len > 4.5
  CONDITION: hcp <= 19.5
  CONDITION: shape_pattern == '5332'
  CONDITION: hcp <= 14.5
  # distilled from Brill /bid

RULE BD_True_P86:
  CALL: 1NT
  PRIORITY: 10
  CONDITION: is_opening == True
  CONDITION: hcp > 11.5
  CONDITION: spade_len > 4.5
  CONDITION: hcp <= 19.5
  CONDITION: shape_pattern == '5332'
  CONDITION: hcp > 14.5
  CONDITION: hcp <= 16.5
  # distilled from Brill /bid

RULE BD_True_P87:
  CALL: 1S
  PRIORITY: 10
  CONDITION: is_opening == True
  CONDITION: hcp > 11.5
  CONDITION: spade_len > 4.5
  CONDITION: hcp <= 19.5
  CONDITION: shape_pattern == '5332'
  CONDITION: hcp > 14.5
  CONDITION: hcp > 16.5
  # distilled from Brill /bid

RULE BD_True_P88:
  CALL: 1H
  PRIORITY: 10
  CONDITION: is_opening == True
  CONDITION: hcp > 11.5
  CONDITION: spade_len > 4.5
  CONDITION: hcp <= 19.5
  CONDITION: shape_pattern != '5332'
  CONDITION: s_is_longest <= 0.5
  CONDITION: hcp <= 15.5
  # distilled from Brill /bid

RULE BD_True_P89:
  CALL: 1C
  PRIORITY: 10
  CONDITION: is_opening == True
  CONDITION: hcp > 11.5
  CONDITION: spade_len > 4.5
  CONDITION: hcp <= 19.5
  CONDITION: shape_pattern != '5332'
  CONDITION: s_is_longest <= 0.5
  CONDITION: hcp > 15.5
  # distilled from Brill /bid

RULE BD_True_P90:
  CALL: 1S
  PRIORITY: 10
  CONDITION: is_opening == True
  CONDITION: hcp > 11.5
  CONDITION: spade_len > 4.5
  CONDITION: hcp <= 19.5
  CONDITION: shape_pattern != '5332'
  CONDITION: s_is_longest > 0.5
  CONDITION: king_count <= 2.5
  # distilled from Brill /bid

RULE BD_True_P91:
  CALL: 2C
  PRIORITY: 10
  CONDITION: is_opening == True
  CONDITION: hcp > 11.5
  CONDITION: spade_len > 4.5
  CONDITION: hcp <= 19.5
  CONDITION: shape_pattern != '5332'
  CONDITION: s_is_longest > 0.5
  CONDITION: king_count > 2.5
  CONDITION: shape_pattern == '7321'
  # distilled from Brill /bid

RULE BD_True_P92:
  CALL: 1S
  PRIORITY: 10
  CONDITION: is_opening == True
  CONDITION: hcp > 11.5
  CONDITION: spade_len > 4.5
  CONDITION: hcp <= 19.5
  CONDITION: shape_pattern != '5332'
  CONDITION: s_is_longest > 0.5
  CONDITION: king_count > 2.5
  CONDITION: shape_pattern != '7321'
  CONDITION: jack_count <= 2.0
  # distilled from Brill /bid

RULE BD_True_P93:
  CALL: 2S
  PRIORITY: 10
  CONDITION: is_opening == True
  CONDITION: hcp > 11.5
  CONDITION: spade_len > 4.5
  CONDITION: hcp <= 19.5
  CONDITION: shape_pattern != '5332'
  CONDITION: s_is_longest > 0.5
  CONDITION: king_count > 2.5
  CONDITION: shape_pattern != '7321'
  CONDITION: jack_count > 2.0
  # distilled from Brill /bid

RULE BD_True_P94:
  CALL: 2NT
  PRIORITY: 10
  CONDITION: is_opening == True
  CONDITION: hcp > 11.5
  CONDITION: spade_len > 4.5
  CONDITION: hcp > 19.5
  CONDITION: rule20_total <= 30.5
  CONDITION: shortest_suit_len <= 1.5
  CONDITION: ace_count <= 2.5
  # distilled from Brill /bid

RULE BD_True_P95:
  CALL: 1S
  PRIORITY: 10
  CONDITION: is_opening == True
  CONDITION: hcp > 11.5
  CONDITION: spade_len > 4.5
  CONDITION: hcp > 19.5
  CONDITION: rule20_total <= 30.5
  CONDITION: shortest_suit_len <= 1.5
  CONDITION: ace_count > 2.5
  CONDITION: major_hcp <= 13.0
  # distilled from Brill /bid

RULE BD_True_P96:
  CALL: 2C
  PRIORITY: 10
  CONDITION: is_opening == True
  CONDITION: hcp > 11.5
  CONDITION: spade_len > 4.5
  CONDITION: hcp > 19.5
  CONDITION: rule20_total <= 30.5
  CONDITION: shortest_suit_len <= 1.5
  CONDITION: ace_count > 2.5
  CONDITION: major_hcp > 13.0
  # distilled from Brill /bid

RULE BD_True_P97:
  CALL: 2NT
  PRIORITY: 10
  CONDITION: is_opening == True
  CONDITION: hcp > 11.5
  CONDITION: spade_len > 4.5
  CONDITION: hcp > 19.5
  CONDITION: rule20_total <= 30.5
  CONDITION: shortest_suit_len > 1.5
  # distilled from Brill /bid

RULE BD_True_P98:
  CALL: 2C
  PRIORITY: 10
  CONDITION: is_opening == True
  CONDITION: hcp > 11.5
  CONDITION: spade_len > 4.5
  CONDITION: hcp > 19.5
  CONDITION: rule20_total > 30.5
  # distilled from Brill /bid
