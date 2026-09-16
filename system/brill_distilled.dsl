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
  CONDITION: hcp <= 5.5
  CONDITION: opening_bid == '1NT'
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
  CONDITION: hcp <= 5.5
  CONDITION: opening_bid == '1NT'
  CONDITION: heart_len <= 4.5
  CONDITION: longest_suit_len <= 5.5
  CONDITION: competition_level > 1.5
  CONDITION: shape_pattern == '5431'
  # distilled from Brill /bid

RULE BD_False_P2:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid <= 0.5
  CONDITION: spade_len <= 3.5
  CONDITION: hcp <= 7.5
  CONDITION: hcp <= 5.5
  CONDITION: opening_bid == '1NT'
  CONDITION: heart_len <= 4.5
  CONDITION: longest_suit_len <= 5.5
  CONDITION: competition_level > 1.5
  CONDITION: shape_pattern != '5431'
  # distilled from Brill /bid

RULE BD_False_P3:
  CALL: 2NT
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid <= 0.5
  CONDITION: spade_len <= 3.5
  CONDITION: hcp <= 7.5
  CONDITION: hcp <= 5.5
  CONDITION: opening_bid == '1NT'
  CONDITION: heart_len <= 4.5
  CONDITION: longest_suit_len > 5.5
  CONDITION: diamond_len <= 5.0
  CONDITION: h_has_ten <= 0.5
  # distilled from Brill /bid

RULE BD_False_P4:
  CALL: XX
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid <= 0.5
  CONDITION: spade_len <= 3.5
  CONDITION: hcp <= 7.5
  CONDITION: hcp <= 5.5
  CONDITION: opening_bid == '1NT'
  CONDITION: heart_len <= 4.5
  CONDITION: longest_suit_len > 5.5
  CONDITION: diamond_len <= 5.0
  CONDITION: h_has_ten > 0.5
  # distilled from Brill /bid

RULE BD_False_P5:
  CALL: XX
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid <= 0.5
  CONDITION: spade_len <= 3.5
  CONDITION: hcp <= 7.5
  CONDITION: hcp <= 5.5
  CONDITION: opening_bid == '1NT'
  CONDITION: heart_len <= 4.5
  CONDITION: longest_suit_len > 5.5
  CONDITION: diamond_len > 5.0
  CONDITION: shape_pattern == '7321'
  # distilled from Brill /bid

RULE BD_False_P6:
  CALL: 3C
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid <= 0.5
  CONDITION: spade_len <= 3.5
  CONDITION: hcp <= 7.5
  CONDITION: hcp <= 5.5
  CONDITION: opening_bid == '1NT'
  CONDITION: heart_len <= 4.5
  CONDITION: longest_suit_len > 5.5
  CONDITION: diamond_len > 5.0
  CONDITION: shape_pattern != '7321'
  # distilled from Brill /bid

RULE BD_False_P7:
  CALL: 4D
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid <= 0.5
  CONDITION: spade_len <= 3.5
  CONDITION: hcp <= 7.5
  CONDITION: hcp <= 5.5
  CONDITION: opening_bid == '1NT'
  CONDITION: heart_len > 4.5
  CONDITION: shape_pattern == '6430'
  # distilled from Brill /bid

RULE BD_False_P8:
  CALL: 2D
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid <= 0.5
  CONDITION: spade_len <= 3.5
  CONDITION: hcp <= 7.5
  CONDITION: hcp <= 5.5
  CONDITION: opening_bid == '1NT'
  CONDITION: heart_len > 4.5
  CONDITION: shape_pattern != '6430'
  # distilled from Brill /bid

RULE BD_False_P9:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid <= 0.5
  CONDITION: spade_len <= 3.5
  CONDITION: hcp <= 7.5
  CONDITION: hcp <= 5.5
  CONDITION: opening_bid != '1NT'
  CONDITION: hcp <= 4.5
  CONDITION: support_in_partner_suit <= 4.5
  CONDITION: total_points <= 5.5
  # distilled from Brill /bid

RULE BD_False_P10:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid <= 0.5
  CONDITION: spade_len <= 3.5
  CONDITION: hcp <= 7.5
  CONDITION: hcp <= 5.5
  CONDITION: opening_bid != '1NT'
  CONDITION: hcp <= 4.5
  CONDITION: support_in_partner_suit <= 4.5
  CONDITION: total_points > 5.5
  CONDITION: support_in_partner_suit <= 2.5
  # distilled from Brill /bid

RULE BD_False_P11:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid <= 0.5
  CONDITION: spade_len <= 3.5
  CONDITION: hcp <= 7.5
  CONDITION: hcp <= 5.5
  CONDITION: opening_bid != '1NT'
  CONDITION: hcp <= 4.5
  CONDITION: support_in_partner_suit <= 4.5
  CONDITION: total_points > 5.5
  CONDITION: support_in_partner_suit > 2.5
  # distilled from Brill /bid

RULE BD_False_P12:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid <= 0.5
  CONDITION: spade_len <= 3.5
  CONDITION: hcp <= 7.5
  CONDITION: hcp <= 5.5
  CONDITION: opening_bid != '1NT'
  CONDITION: hcp <= 4.5
  CONDITION: support_in_partner_suit > 4.5
  CONDITION: heart_len <= 4.0
  CONDITION: hcp <= 3.5
  # distilled from Brill /bid

RULE BD_False_P13:
  CALL: 3C
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid <= 0.5
  CONDITION: spade_len <= 3.5
  CONDITION: hcp <= 7.5
  CONDITION: hcp <= 5.5
  CONDITION: opening_bid != '1NT'
  CONDITION: hcp <= 4.5
  CONDITION: support_in_partner_suit > 4.5
  CONDITION: heart_len <= 4.0
  CONDITION: hcp > 3.5
  # distilled from Brill /bid

RULE BD_False_P14:
  CALL: 4H
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid <= 0.5
  CONDITION: spade_len <= 3.5
  CONDITION: hcp <= 7.5
  CONDITION: hcp <= 5.5
  CONDITION: opening_bid != '1NT'
  CONDITION: hcp <= 4.5
  CONDITION: support_in_partner_suit > 4.5
  CONDITION: heart_len > 4.0
  CONDITION: h_has_ten <= 0.5
  # distilled from Brill /bid

RULE BD_False_P15:
  CALL: 2H
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid <= 0.5
  CONDITION: spade_len <= 3.5
  CONDITION: hcp <= 7.5
  CONDITION: hcp <= 5.5
  CONDITION: opening_bid != '1NT'
  CONDITION: hcp <= 4.5
  CONDITION: support_in_partner_suit > 4.5
  CONDITION: heart_len > 4.0
  CONDITION: h_has_ten > 0.5
  # distilled from Brill /bid

RULE BD_False_P16:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid <= 0.5
  CONDITION: spade_len <= 3.5
  CONDITION: hcp <= 7.5
  CONDITION: hcp <= 5.5
  CONDITION: opening_bid != '1NT'
  CONDITION: hcp > 4.5
  CONDITION: last_bid_strain == 'S'
  CONDITION: auction_len <= 5.5
  CONDITION: spade_len <= 2.5
  # distilled from Brill /bid

RULE BD_False_P17:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid <= 0.5
  CONDITION: spade_len <= 3.5
  CONDITION: hcp <= 7.5
  CONDITION: hcp <= 5.5
  CONDITION: opening_bid != '1NT'
  CONDITION: hcp > 4.5
  CONDITION: last_bid_strain == 'S'
  CONDITION: auction_len <= 5.5
  CONDITION: spade_len > 2.5
  # distilled from Brill /bid

RULE BD_False_P18:
  CALL: 1NT
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid <= 0.5
  CONDITION: spade_len <= 3.5
  CONDITION: hcp <= 7.5
  CONDITION: hcp <= 5.5
  CONDITION: opening_bid != '1NT'
  CONDITION: hcp > 4.5
  CONDITION: last_bid_strain == 'S'
  CONDITION: auction_len > 5.5
  CONDITION: spade_len <= 2.5
  # distilled from Brill /bid

RULE BD_False_P19:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid <= 0.5
  CONDITION: spade_len <= 3.5
  CONDITION: hcp <= 7.5
  CONDITION: hcp <= 5.5
  CONDITION: opening_bid != '1NT'
  CONDITION: hcp > 4.5
  CONDITION: last_bid_strain == 'S'
  CONDITION: auction_len > 5.5
  CONDITION: spade_len > 2.5
  # distilled from Brill /bid

RULE BD_False_P20:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid <= 0.5
  CONDITION: spade_len <= 3.5
  CONDITION: hcp <= 7.5
  CONDITION: hcp <= 5.5
  CONDITION: opening_bid != '1NT'
  CONDITION: hcp > 4.5
  CONDITION: last_bid_strain != 'S'
  CONDITION: heart_len <= 3.5
  CONDITION: support_in_partner_suit <= 4.5
  # distilled from Brill /bid

RULE BD_False_P21:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid <= 0.5
  CONDITION: spade_len <= 3.5
  CONDITION: hcp <= 7.5
  CONDITION: hcp <= 5.5
  CONDITION: opening_bid != '1NT'
  CONDITION: hcp > 4.5
  CONDITION: last_bid_strain != 'S'
  CONDITION: heart_len <= 3.5
  CONDITION: support_in_partner_suit > 4.5
  # distilled from Brill /bid

RULE BD_False_P22:
  CALL: 2H
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid <= 0.5
  CONDITION: spade_len <= 3.5
  CONDITION: hcp <= 7.5
  CONDITION: hcp <= 5.5
  CONDITION: opening_bid != '1NT'
  CONDITION: hcp > 4.5
  CONDITION: last_bid_strain != 'S'
  CONDITION: heart_len > 3.5
  CONDITION: last_bid_strain == 'H'
  # distilled from Brill /bid

RULE BD_False_P23:
  CALL: 1H
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid <= 0.5
  CONDITION: spade_len <= 3.5
  CONDITION: hcp <= 7.5
  CONDITION: hcp <= 5.5
  CONDITION: opening_bid != '1NT'
  CONDITION: hcp > 4.5
  CONDITION: last_bid_strain != 'S'
  CONDITION: heart_len > 3.5
  CONDITION: last_bid_strain != 'H'
  # distilled from Brill /bid

RULE BD_False_P24:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid <= 0.5
  CONDITION: spade_len <= 3.5
  CONDITION: hcp <= 7.5
  CONDITION: hcp > 5.5
  CONDITION: last_bid_strain == 'NT'
  CONDITION: heart_len <= 4.5
  CONDITION: longest_suit_len <= 5.5
  CONDITION: auction_len <= 5.5
  # distilled from Brill /bid

RULE BD_False_P25:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid <= 0.5
  CONDITION: spade_len <= 3.5
  CONDITION: hcp <= 7.5
  CONDITION: hcp > 5.5
  CONDITION: last_bid_strain == 'NT'
  CONDITION: heart_len <= 4.5
  CONDITION: longest_suit_len <= 5.5
  CONDITION: auction_len > 5.5
  CONDITION: opening_bid == '1D'
  # distilled from Brill /bid

RULE BD_False_P26:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid <= 0.5
  CONDITION: spade_len <= 3.5
  CONDITION: hcp <= 7.5
  CONDITION: hcp > 5.5
  CONDITION: last_bid_strain == 'NT'
  CONDITION: heart_len <= 4.5
  CONDITION: longest_suit_len <= 5.5
  CONDITION: auction_len > 5.5
  CONDITION: opening_bid != '1D'
  # distilled from Brill /bid

RULE BD_False_P27:
  CALL: 2NT
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid <= 0.5
  CONDITION: spade_len <= 3.5
  CONDITION: hcp <= 7.5
  CONDITION: hcp > 5.5
  CONDITION: last_bid_strain == 'NT'
  CONDITION: heart_len <= 4.5
  CONDITION: longest_suit_len > 5.5
  CONDITION: diamond_len <= 4.5
  # distilled from Brill /bid

RULE BD_False_P28:
  CALL: 3C
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid <= 0.5
  CONDITION: spade_len <= 3.5
  CONDITION: hcp <= 7.5
  CONDITION: hcp > 5.5
  CONDITION: last_bid_strain == 'NT'
  CONDITION: heart_len <= 4.5
  CONDITION: longest_suit_len > 5.5
  CONDITION: diamond_len > 4.5
  CONDITION: total_points <= 9.5
  # distilled from Brill /bid

RULE BD_False_P29:
  CALL: 2S
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid <= 0.5
  CONDITION: spade_len <= 3.5
  CONDITION: hcp <= 7.5
  CONDITION: hcp > 5.5
  CONDITION: last_bid_strain == 'NT'
  CONDITION: heart_len <= 4.5
  CONDITION: longest_suit_len > 5.5
  CONDITION: diamond_len > 4.5
  CONDITION: total_points > 9.5
  # distilled from Brill /bid

RULE BD_False_P30:
  CALL: 2D
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid <= 0.5
  CONDITION: spade_len <= 3.5
  CONDITION: hcp <= 7.5
  CONDITION: hcp > 5.5
  CONDITION: last_bid_strain == 'NT'
  CONDITION: heart_len > 4.5
  CONDITION: auction_len <= 5.5
  CONDITION: heart_len <= 5.5
  # distilled from Brill /bid

RULE BD_False_P31:
  CALL: 2D
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid <= 0.5
  CONDITION: spade_len <= 3.5
  CONDITION: hcp <= 7.5
  CONDITION: hcp > 5.5
  CONDITION: last_bid_strain == 'NT'
  CONDITION: heart_len > 4.5
  CONDITION: auction_len <= 5.5
  CONDITION: heart_len > 5.5
  CONDITION: total_points <= 7.5
  # distilled from Brill /bid

RULE BD_False_P32:
  CALL: 4D
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid <= 0.5
  CONDITION: spade_len <= 3.5
  CONDITION: hcp <= 7.5
  CONDITION: hcp > 5.5
  CONDITION: last_bid_strain == 'NT'
  CONDITION: heart_len > 4.5
  CONDITION: auction_len <= 5.5
  CONDITION: heart_len > 5.5
  CONDITION: total_points > 7.5
  # distilled from Brill /bid

RULE BD_False_P33:
  CALL: 2H
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid <= 0.5
  CONDITION: spade_len <= 3.5
  CONDITION: hcp <= 7.5
  CONDITION: hcp > 5.5
  CONDITION: last_bid_strain == 'NT'
  CONDITION: heart_len > 4.5
  CONDITION: auction_len > 5.5
  CONDITION: diamond_len <= 2.5
  # distilled from Brill /bid

RULE BD_False_P34:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid <= 0.5
  CONDITION: spade_len <= 3.5
  CONDITION: hcp <= 7.5
  CONDITION: hcp > 5.5
  CONDITION: last_bid_strain == 'NT'
  CONDITION: heart_len > 4.5
  CONDITION: auction_len > 5.5
  CONDITION: diamond_len > 2.5
  CONDITION: heart_len <= 5.5
  # distilled from Brill /bid

RULE BD_False_P35:
  CALL: 2H
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid <= 0.5
  CONDITION: spade_len <= 3.5
  CONDITION: hcp <= 7.5
  CONDITION: hcp > 5.5
  CONDITION: last_bid_strain == 'NT'
  CONDITION: heart_len > 4.5
  CONDITION: auction_len > 5.5
  CONDITION: diamond_len > 2.5
  CONDITION: heart_len > 5.5
  # distilled from Brill /bid

RULE BD_False_P36:
  CALL: 1NT
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid <= 0.5
  CONDITION: spade_len <= 3.5
  CONDITION: hcp <= 7.5
  CONDITION: hcp > 5.5
  CONDITION: last_bid_strain != 'NT'
  CONDITION: last_bid_strain == 'S'
  CONDITION: spade_len <= 2.5
  CONDITION: competition_level <= 1.5
  # distilled from Brill /bid

RULE BD_False_P37:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid <= 0.5
  CONDITION: spade_len <= 3.5
  CONDITION: hcp <= 7.5
  CONDITION: hcp > 5.5
  CONDITION: last_bid_strain != 'NT'
  CONDITION: last_bid_strain == 'S'
  CONDITION: spade_len <= 2.5
  CONDITION: competition_level > 1.5
  CONDITION: hcp <= 6.5
  # distilled from Brill /bid

RULE BD_False_P38:
  CALL: 1NT
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid <= 0.5
  CONDITION: spade_len <= 3.5
  CONDITION: hcp <= 7.5
  CONDITION: hcp > 5.5
  CONDITION: last_bid_strain != 'NT'
  CONDITION: last_bid_strain == 'S'
  CONDITION: spade_len <= 2.5
  CONDITION: competition_level > 1.5
  CONDITION: hcp > 6.5
  # distilled from Brill /bid

RULE BD_False_P39:
  CALL: 2S
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid <= 0.5
  CONDITION: spade_len <= 3.5
  CONDITION: hcp <= 7.5
  CONDITION: hcp > 5.5
  CONDITION: last_bid_strain != 'NT'
  CONDITION: last_bid_strain == 'S'
  CONDITION: spade_len > 2.5
  CONDITION: auction_len <= 5.5
  # distilled from Brill /bid

RULE BD_False_P40:
  CALL: 1NT
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid <= 0.5
  CONDITION: spade_len <= 3.5
  CONDITION: hcp <= 7.5
  CONDITION: hcp > 5.5
  CONDITION: last_bid_strain != 'NT'
  CONDITION: last_bid_strain == 'S'
  CONDITION: spade_len > 2.5
  CONDITION: auction_len > 5.5
  CONDITION: queen_count <= 2.5
  # distilled from Brill /bid

RULE BD_False_P41:
  CALL: 2D
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid <= 0.5
  CONDITION: spade_len <= 3.5
  CONDITION: hcp <= 7.5
  CONDITION: hcp > 5.5
  CONDITION: last_bid_strain != 'NT'
  CONDITION: last_bid_strain == 'S'
  CONDITION: spade_len > 2.5
  CONDITION: auction_len > 5.5
  CONDITION: queen_count > 2.5
  # distilled from Brill /bid

RULE BD_False_P42:
  CALL: 3C
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid <= 0.5
  CONDITION: spade_len <= 3.5
  CONDITION: hcp <= 7.5
  CONDITION: hcp > 5.5
  CONDITION: last_bid_strain != 'NT'
  CONDITION: last_bid_strain != 'S'
  CONDITION: heart_len <= 3.5
  CONDITION: last_bid_strain == 'C'
  CONDITION: d_is_longest <= 0.5
  # distilled from Brill /bid

RULE BD_False_P43:
  CALL: 1D
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid <= 0.5
  CONDITION: spade_len <= 3.5
  CONDITION: hcp <= 7.5
  CONDITION: hcp > 5.5
  CONDITION: last_bid_strain != 'NT'
  CONDITION: last_bid_strain != 'S'
  CONDITION: heart_len <= 3.5
  CONDITION: last_bid_strain == 'C'
  CONDITION: d_is_longest > 0.5
  # distilled from Brill /bid

RULE BD_False_P44:
  CALL: 1NT
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid <= 0.5
  CONDITION: spade_len <= 3.5
  CONDITION: hcp <= 7.5
  CONDITION: hcp > 5.5
  CONDITION: last_bid_strain != 'NT'
  CONDITION: last_bid_strain != 'S'
  CONDITION: heart_len <= 3.5
  CONDITION: last_bid_strain != 'C'
  CONDITION: opening_bid == '1H'
  # distilled from Brill /bid

RULE BD_False_P45:
  CALL: 1NT
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid <= 0.5
  CONDITION: spade_len <= 3.5
  CONDITION: hcp <= 7.5
  CONDITION: hcp > 5.5
  CONDITION: last_bid_strain != 'NT'
  CONDITION: last_bid_strain != 'S'
  CONDITION: heart_len <= 3.5
  CONDITION: last_bid_strain != 'C'
  CONDITION: opening_bid != '1H'
  # distilled from Brill /bid

RULE BD_False_P46:
  CALL: 2H
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid <= 0.5
  CONDITION: spade_len <= 3.5
  CONDITION: hcp <= 7.5
  CONDITION: hcp > 5.5
  CONDITION: last_bid_strain != 'NT'
  CONDITION: last_bid_strain != 'S'
  CONDITION: heart_len > 3.5
  CONDITION: last_bid_strain == 'H'
  CONDITION: heart_len <= 4.5
  # distilled from Brill /bid

RULE BD_False_P47:
  CALL: 4H
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid <= 0.5
  CONDITION: spade_len <= 3.5
  CONDITION: hcp <= 7.5
  CONDITION: hcp > 5.5
  CONDITION: last_bid_strain != 'NT'
  CONDITION: last_bid_strain != 'S'
  CONDITION: heart_len > 3.5
  CONDITION: last_bid_strain == 'H'
  CONDITION: heart_len > 4.5
  # distilled from Brill /bid

RULE BD_False_P48:
  CALL: 1H
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid <= 0.5
  CONDITION: spade_len <= 3.5
  CONDITION: hcp <= 7.5
  CONDITION: hcp > 5.5
  CONDITION: last_bid_strain != 'NT'
  CONDITION: last_bid_strain != 'S'
  CONDITION: heart_len > 3.5
  CONDITION: last_bid_strain != 'H'
  CONDITION: d_is_longest <= 0.5
  # distilled from Brill /bid

RULE BD_False_P49:
  CALL: 1D
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid <= 0.5
  CONDITION: spade_len <= 3.5
  CONDITION: hcp <= 7.5
  CONDITION: hcp > 5.5
  CONDITION: last_bid_strain != 'NT'
  CONDITION: last_bid_strain != 'S'
  CONDITION: heart_len > 3.5
  CONDITION: last_bid_strain != 'H'
  CONDITION: d_is_longest > 0.5
  # distilled from Brill /bid

RULE BD_False_P50:
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
  CONDITION: longest_suit_len <= 5.5
  # distilled from Brill /bid

RULE BD_False_P51:
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
  CONDITION: longest_suit_len > 5.5
  CONDITION: d_has_ten <= 0.5
  CONDITION: s_is_best_major <= 0.5
  # distilled from Brill /bid

RULE BD_False_P52:
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
  CONDITION: longest_suit_len > 5.5
  CONDITION: d_has_ten <= 0.5
  CONDITION: s_is_best_major > 0.5
  # distilled from Brill /bid

RULE BD_False_P53:
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
  CONDITION: longest_suit_len > 5.5
  CONDITION: d_has_ten > 0.5
  # distilled from Brill /bid

RULE BD_False_P54:
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
  CONDITION: second_longest_len <= 3.5
  CONDITION: rule20_total <= 21.5
  # distilled from Brill /bid

RULE BD_False_P55:
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
  CONDITION: second_longest_len <= 3.5
  CONDITION: rule20_total > 21.5
  # distilled from Brill /bid

RULE BD_False_P56:
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
  CONDITION: second_longest_len > 3.5
  CONDITION: longest_suit_len <= 4.5
  # distilled from Brill /bid

RULE BD_False_P57:
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
  CONDITION: second_longest_len > 3.5
  CONDITION: longest_suit_len > 4.5
  # distilled from Brill /bid

RULE BD_False_P58:
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
  CONDITION: hcp <= 17.5
  CONDITION: rule20_total <= 21.5
  # distilled from Brill /bid

RULE BD_False_P59:
  CALL: 2D
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
  CONDITION: hcp <= 17.5
  CONDITION: rule20_total > 21.5
  # distilled from Brill /bid

RULE BD_False_P60:
  CALL: 3C
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
  CONDITION: hcp > 17.5
  CONDITION: heart_len <= 1.5
  # distilled from Brill /bid

RULE BD_False_P61:
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
  CONDITION: hcp > 17.5
  CONDITION: heart_len > 1.5
  # distilled from Brill /bid

RULE BD_False_P62:
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
  CONDITION: last_bid_strain == 'C'
  CONDITION: d_is_longest <= 0.5
  CONDITION: club_len <= 4.5
  # distilled from Brill /bid

RULE BD_False_P63:
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
  CONDITION: last_bid_strain == 'C'
  CONDITION: d_is_longest <= 0.5
  CONDITION: club_len > 4.5
  # distilled from Brill /bid

RULE BD_False_P64:
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
  CONDITION: last_bid_strain == 'C'
  CONDITION: d_is_longest > 0.5
  CONDITION: club_len <= 4.5
  # distilled from Brill /bid

RULE BD_False_P65:
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
  CONDITION: last_bid_strain == 'C'
  CONDITION: d_is_longest > 0.5
  CONDITION: club_len > 4.5
  # distilled from Brill /bid

RULE BD_False_P66:
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
  CONDITION: last_bid_strain != 'C'
  CONDITION: opening_bid == '1S'
  CONDITION: spade_len <= 2.5
  # distilled from Brill /bid

RULE BD_False_P67:
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
  CONDITION: last_bid_strain != 'C'
  CONDITION: opening_bid == '1S'
  CONDITION: spade_len > 2.5
  # distilled from Brill /bid

RULE BD_False_P68:
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
  CONDITION: last_bid_strain != 'C'
  CONDITION: opening_bid != '1S'
  CONDITION: opening_bid == '1H'
  # distilled from Brill /bid

RULE BD_False_P69:
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
  CONDITION: last_bid_strain != 'C'
  CONDITION: opening_bid != '1S'
  CONDITION: opening_bid != '1H'
  # distilled from Brill /bid

RULE BD_False_P70:
  CALL: 1D
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
  CONDITION: club_len <= 3.5
  CONDITION: opening_bid == '1C'
  # distilled from Brill /bid

RULE BD_False_P71:
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
  CONDITION: club_len <= 3.5
  CONDITION: opening_bid != '1C'
  # distilled from Brill /bid

RULE BD_False_P72:
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
  CONDITION: club_len > 3.5
  CONDITION: hcp <= 11.5
  # distilled from Brill /bid

RULE BD_False_P73:
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
  CONDITION: club_len > 3.5
  CONDITION: hcp > 11.5
  # distilled from Brill /bid

RULE BD_False_P74:
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
  CONDITION: my_side_bid_count <= 1.5
  CONDITION: hcp <= 11.5
  # distilled from Brill /bid

RULE BD_False_P75:
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
  CONDITION: my_side_bid_count <= 1.5
  CONDITION: hcp > 11.5
  # distilled from Brill /bid

RULE BD_False_P76:
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
  CONDITION: my_side_bid_count > 1.5
  CONDITION: hcp <= 15.0
  # distilled from Brill /bid

RULE BD_False_P77:
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
  CONDITION: my_side_bid_count > 1.5
  CONDITION: hcp > 15.0
  # distilled from Brill /bid

RULE BD_False_P78:
  CALL: 1NT
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid <= 0.5
  CONDITION: spade_len <= 3.5
  CONDITION: hcp > 7.5
  CONDITION: heart_len > 3.5
  CONDITION: last_bid_strain == 'S'
  CONDITION: heart_len <= 5.5
  CONDITION: rule20_total <= 22.5
  CONDITION: my_side_bid_count <= 2.5
  CONDITION: hcp <= 9.5
  # distilled from Brill /bid

RULE BD_False_P79:
  CALL: 1NT
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid <= 0.5
  CONDITION: spade_len <= 3.5
  CONDITION: hcp > 7.5
  CONDITION: heart_len > 3.5
  CONDITION: last_bid_strain == 'S'
  CONDITION: heart_len <= 5.5
  CONDITION: rule20_total <= 22.5
  CONDITION: my_side_bid_count <= 2.5
  CONDITION: hcp > 9.5
  # distilled from Brill /bid

RULE BD_False_P80:
  CALL: 1NT
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid <= 0.5
  CONDITION: spade_len <= 3.5
  CONDITION: hcp > 7.5
  CONDITION: heart_len > 3.5
  CONDITION: last_bid_strain == 'S'
  CONDITION: heart_len <= 5.5
  CONDITION: rule20_total <= 22.5
  CONDITION: my_side_bid_count > 2.5
  CONDITION: hcp <= 9.5
  # distilled from Brill /bid

RULE BD_False_P81:
  CALL: 2NT
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid <= 0.5
  CONDITION: spade_len <= 3.5
  CONDITION: hcp > 7.5
  CONDITION: heart_len > 3.5
  CONDITION: last_bid_strain == 'S'
  CONDITION: heart_len <= 5.5
  CONDITION: rule20_total <= 22.5
  CONDITION: my_side_bid_count > 2.5
  CONDITION: hcp > 9.5
  # distilled from Brill /bid

RULE BD_False_P82:
  CALL: 2D
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid <= 0.5
  CONDITION: spade_len <= 3.5
  CONDITION: hcp > 7.5
  CONDITION: heart_len > 3.5
  CONDITION: last_bid_strain == 'S'
  CONDITION: heart_len <= 5.5
  CONDITION: rule20_total > 22.5
  CONDITION: hcp <= 16.5
  CONDITION: club_len <= 3.5
  # distilled from Brill /bid

RULE BD_False_P83:
  CALL: 2C
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid <= 0.5
  CONDITION: spade_len <= 3.5
  CONDITION: hcp > 7.5
  CONDITION: heart_len > 3.5
  CONDITION: last_bid_strain == 'S'
  CONDITION: heart_len <= 5.5
  CONDITION: rule20_total > 22.5
  CONDITION: hcp <= 16.5
  CONDITION: club_len > 3.5
  # distilled from Brill /bid

RULE BD_False_P84:
  CALL: 2NT
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid <= 0.5
  CONDITION: spade_len <= 3.5
  CONDITION: hcp > 7.5
  CONDITION: heart_len > 3.5
  CONDITION: last_bid_strain == 'S'
  CONDITION: heart_len <= 5.5
  CONDITION: rule20_total > 22.5
  CONDITION: hcp > 16.5
  CONDITION: opening_bid == '1H'
  # distilled from Brill /bid

RULE BD_False_P85:
  CALL: 2H
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid <= 0.5
  CONDITION: spade_len <= 3.5
  CONDITION: hcp > 7.5
  CONDITION: heart_len > 3.5
  CONDITION: last_bid_strain == 'S'
  CONDITION: heart_len <= 5.5
  CONDITION: rule20_total > 22.5
  CONDITION: hcp > 16.5
  CONDITION: opening_bid != '1H'
  # distilled from Brill /bid

RULE BD_False_P86:
  CALL: 1NT
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid <= 0.5
  CONDITION: spade_len <= 3.5
  CONDITION: hcp > 7.5
  CONDITION: heart_len > 3.5
  CONDITION: last_bid_strain == 'S'
  CONDITION: heart_len > 5.5
  CONDITION: hcp <= 9.5
  CONDITION: auction_len <= 5.5
  CONDITION: spade_len <= 2.5
  # distilled from Brill /bid

RULE BD_False_P87:
  CALL: 2S
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid <= 0.5
  CONDITION: spade_len <= 3.5
  CONDITION: hcp > 7.5
  CONDITION: heart_len > 3.5
  CONDITION: last_bid_strain == 'S'
  CONDITION: heart_len > 5.5
  CONDITION: hcp <= 9.5
  CONDITION: auction_len <= 5.5
  CONDITION: spade_len > 2.5
  # distilled from Brill /bid

RULE BD_False_P88:
  CALL: 2H
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid <= 0.5
  CONDITION: spade_len <= 3.5
  CONDITION: hcp > 7.5
  CONDITION: heart_len > 3.5
  CONDITION: last_bid_strain == 'S'
  CONDITION: heart_len > 5.5
  CONDITION: hcp <= 9.5
  CONDITION: auction_len > 5.5
  # distilled from Brill /bid

RULE BD_False_P89:
  CALL: 2H
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid <= 0.5
  CONDITION: spade_len <= 3.5
  CONDITION: hcp > 7.5
  CONDITION: heart_len > 3.5
  CONDITION: last_bid_strain == 'S'
  CONDITION: heart_len > 5.5
  CONDITION: hcp > 9.5
  CONDITION: my_side_bid_count <= 2.5
  CONDITION: hcp <= 17.5
  # distilled from Brill /bid

RULE BD_False_P90:
  CALL: 3NT
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid <= 0.5
  CONDITION: spade_len <= 3.5
  CONDITION: hcp > 7.5
  CONDITION: heart_len > 3.5
  CONDITION: last_bid_strain == 'S'
  CONDITION: heart_len > 5.5
  CONDITION: hcp > 9.5
  CONDITION: my_side_bid_count <= 2.5
  CONDITION: hcp > 17.5
  # distilled from Brill /bid

RULE BD_False_P91:
  CALL: 3H
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid <= 0.5
  CONDITION: spade_len <= 3.5
  CONDITION: hcp > 7.5
  CONDITION: heart_len > 3.5
  CONDITION: last_bid_strain == 'S'
  CONDITION: heart_len > 5.5
  CONDITION: hcp > 9.5
  CONDITION: my_side_bid_count > 2.5
  CONDITION: hcp <= 12.5
  # distilled from Brill /bid

RULE BD_False_P92:
  CALL: 2C
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid <= 0.5
  CONDITION: spade_len <= 3.5
  CONDITION: hcp > 7.5
  CONDITION: heart_len > 3.5
  CONDITION: last_bid_strain == 'S'
  CONDITION: heart_len > 5.5
  CONDITION: hcp > 9.5
  CONDITION: my_side_bid_count > 2.5
  CONDITION: hcp > 12.5
  # distilled from Brill /bid

RULE BD_False_P93:
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
  CONDITION: competition_level <= 1.5
  CONDITION: spade_len <= 1.5
  # distilled from Brill /bid

RULE BD_False_P94:
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
  CONDITION: competition_level <= 1.5
  CONDITION: spade_len > 1.5
  # distilled from Brill /bid

RULE BD_False_P95:
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
  CONDITION: competition_level > 1.5
  CONDITION: hcp <= 11.5
  # distilled from Brill /bid

RULE BD_False_P96:
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
  CONDITION: competition_level > 1.5
  CONDITION: hcp > 11.5
  # distilled from Brill /bid

RULE BD_False_P97:
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
  CONDITION: competition_level <= 1.5
  # distilled from Brill /bid

RULE BD_False_P98:
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
  CONDITION: competition_level > 1.5
  # distilled from Brill /bid

RULE BD_False_P99:
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
  CONDITION: my_last_call == '1H'
  # distilled from Brill /bid

RULE BD_False_P100:
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
  CONDITION: my_last_call != '1H'
  # distilled from Brill /bid

RULE BD_False_P101:
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
  CONDITION: opening_bid == '1H'
  CONDITION: hcp <= 11.5
  # distilled from Brill /bid

RULE BD_False_P102:
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
  CONDITION: opening_bid == '1H'
  CONDITION: hcp > 11.5
  # distilled from Brill /bid

RULE BD_False_P103:
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
  CONDITION: opening_bid != '1H'
  CONDITION: total_points <= 15.5
  # distilled from Brill /bid

RULE BD_False_P104:
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
  CONDITION: opening_bid != '1H'
  CONDITION: total_points > 15.5
  # distilled from Brill /bid

RULE BD_False_P105:
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

RULE BD_False_P106:
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
  CONDITION: rule20_total > 24.5
  # distilled from Brill /bid

RULE BD_False_P107:
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

RULE BD_False_P108:
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

RULE BD_False_P109:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid <= 0.5
  CONDITION: spade_len > 3.5
  CONDITION: last_bid_strain == 'NT'
  CONDITION: spade_len <= 4.5
  CONDITION: hcp <= 7.5
  CONDITION: heart_len <= 4.5
  CONDITION: support_in_partner_suit <= 3.5
  CONDITION: longest_suit_len <= 5.5
  CONDITION: heart_len <= 0.5
  # distilled from Brill /bid

RULE BD_False_P110:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid <= 0.5
  CONDITION: spade_len > 3.5
  CONDITION: last_bid_strain == 'NT'
  CONDITION: spade_len <= 4.5
  CONDITION: hcp <= 7.5
  CONDITION: heart_len <= 4.5
  CONDITION: support_in_partner_suit <= 3.5
  CONDITION: longest_suit_len <= 5.5
  CONDITION: heart_len > 0.5
  # distilled from Brill /bid

RULE BD_False_P111:
  CALL: XX
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid <= 0.5
  CONDITION: spade_len > 3.5
  CONDITION: last_bid_strain == 'NT'
  CONDITION: spade_len <= 4.5
  CONDITION: hcp <= 7.5
  CONDITION: heart_len <= 4.5
  CONDITION: support_in_partner_suit <= 3.5
  CONDITION: longest_suit_len > 5.5
  CONDITION: passes_since_last_bid <= 0.5
  # distilled from Brill /bid

RULE BD_False_P112:
  CALL: 2NT
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid <= 0.5
  CONDITION: spade_len > 3.5
  CONDITION: last_bid_strain == 'NT'
  CONDITION: spade_len <= 4.5
  CONDITION: hcp <= 7.5
  CONDITION: heart_len <= 4.5
  CONDITION: support_in_partner_suit <= 3.5
  CONDITION: longest_suit_len > 5.5
  CONDITION: passes_since_last_bid > 0.5
  # distilled from Brill /bid

RULE BD_False_P113:
  CALL: 2D
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid <= 0.5
  CONDITION: spade_len > 3.5
  CONDITION: last_bid_strain == 'NT'
  CONDITION: spade_len <= 4.5
  CONDITION: hcp <= 7.5
  CONDITION: heart_len <= 4.5
  CONDITION: support_in_partner_suit > 3.5
  CONDITION: club_len <= 3.0
  # distilled from Brill /bid

RULE BD_False_P114:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid <= 0.5
  CONDITION: spade_len > 3.5
  CONDITION: last_bid_strain == 'NT'
  CONDITION: spade_len <= 4.5
  CONDITION: hcp <= 7.5
  CONDITION: heart_len <= 4.5
  CONDITION: support_in_partner_suit > 3.5
  CONDITION: club_len > 3.0
  CONDITION: passes_since_last_bid <= 0.5
  # distilled from Brill /bid

RULE BD_False_P115:
  CALL: 2C
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid <= 0.5
  CONDITION: spade_len > 3.5
  CONDITION: last_bid_strain == 'NT'
  CONDITION: spade_len <= 4.5
  CONDITION: hcp <= 7.5
  CONDITION: heart_len <= 4.5
  CONDITION: support_in_partner_suit > 3.5
  CONDITION: club_len > 3.0
  CONDITION: passes_since_last_bid > 0.5
  # distilled from Brill /bid

RULE BD_False_P116:
  CALL: 2D
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid <= 0.5
  CONDITION: spade_len > 3.5
  CONDITION: last_bid_strain == 'NT'
  CONDITION: spade_len <= 4.5
  CONDITION: hcp <= 7.5
  CONDITION: heart_len > 4.5
  CONDITION: auction_len <= 5.5
  CONDITION: heart_len <= 5.5
  # distilled from Brill /bid

RULE BD_False_P117:
  CALL: 4D
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid <= 0.5
  CONDITION: spade_len > 3.5
  CONDITION: last_bid_strain == 'NT'
  CONDITION: spade_len <= 4.5
  CONDITION: hcp <= 7.5
  CONDITION: heart_len > 4.5
  CONDITION: auction_len <= 5.5
  CONDITION: heart_len > 5.5
  # distilled from Brill /bid

RULE BD_False_P118:
  CALL: 2H
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid <= 0.5
  CONDITION: spade_len > 3.5
  CONDITION: last_bid_strain == 'NT'
  CONDITION: spade_len <= 4.5
  CONDITION: hcp <= 7.5
  CONDITION: heart_len > 4.5
  CONDITION: auction_len > 5.5
  # distilled from Brill /bid

RULE BD_False_P119:
  CALL: 3H
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid <= 0.5
  CONDITION: spade_len > 3.5
  CONDITION: last_bid_strain == 'NT'
  CONDITION: spade_len <= 4.5
  CONDITION: hcp > 7.5
  CONDITION: competition_level <= 1.5
  CONDITION: heart_len <= 1.5
  CONDITION: minor_hcp <= 10.5
  # distilled from Brill /bid

RULE BD_False_P120:
  CALL: 2C
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid <= 0.5
  CONDITION: spade_len > 3.5
  CONDITION: last_bid_strain == 'NT'
  CONDITION: spade_len <= 4.5
  CONDITION: hcp > 7.5
  CONDITION: competition_level <= 1.5
  CONDITION: heart_len <= 1.5
  CONDITION: minor_hcp > 10.5
  # distilled from Brill /bid

RULE BD_False_P121:
  CALL: 3D
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid <= 0.5
  CONDITION: spade_len > 3.5
  CONDITION: last_bid_strain == 'NT'
  CONDITION: spade_len <= 4.5
  CONDITION: hcp > 7.5
  CONDITION: competition_level <= 1.5
  CONDITION: heart_len > 1.5
  CONDITION: heart_len <= 4.5
  CONDITION: diamond_len <= 1.5
  # distilled from Brill /bid

RULE BD_False_P122:
  CALL: 2C
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid <= 0.5
  CONDITION: spade_len > 3.5
  CONDITION: last_bid_strain == 'NT'
  CONDITION: spade_len <= 4.5
  CONDITION: hcp > 7.5
  CONDITION: competition_level <= 1.5
  CONDITION: heart_len > 1.5
  CONDITION: heart_len <= 4.5
  CONDITION: diamond_len > 1.5
  # distilled from Brill /bid

RULE BD_False_P123:
  CALL: 2D
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid <= 0.5
  CONDITION: spade_len > 3.5
  CONDITION: last_bid_strain == 'NT'
  CONDITION: spade_len <= 4.5
  CONDITION: hcp > 7.5
  CONDITION: competition_level <= 1.5
  CONDITION: heart_len > 1.5
  CONDITION: heart_len > 4.5
  CONDITION: rule20_total <= 18.5
  # distilled from Brill /bid

RULE BD_False_P124:
  CALL: 2C
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid <= 0.5
  CONDITION: spade_len > 3.5
  CONDITION: last_bid_strain == 'NT'
  CONDITION: spade_len <= 4.5
  CONDITION: hcp > 7.5
  CONDITION: competition_level <= 1.5
  CONDITION: heart_len > 1.5
  CONDITION: heart_len > 4.5
  CONDITION: rule20_total > 18.5
  # distilled from Brill /bid

RULE BD_False_P125:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid <= 0.5
  CONDITION: spade_len > 3.5
  CONDITION: last_bid_strain == 'NT'
  CONDITION: spade_len <= 4.5
  CONDITION: hcp > 7.5
  CONDITION: competition_level > 1.5
  CONDITION: heart_len <= 4.5
  CONDITION: hcp <= 11.5
  CONDITION: support_in_partner_suit <= 3.5
  # distilled from Brill /bid

RULE BD_False_P126:
  CALL: 3D
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid <= 0.5
  CONDITION: spade_len > 3.5
  CONDITION: last_bid_strain == 'NT'
  CONDITION: spade_len <= 4.5
  CONDITION: hcp > 7.5
  CONDITION: competition_level > 1.5
  CONDITION: heart_len <= 4.5
  CONDITION: hcp <= 11.5
  CONDITION: support_in_partner_suit > 3.5
  # distilled from Brill /bid

RULE BD_False_P127:
  CALL: 3NT
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid <= 0.5
  CONDITION: spade_len > 3.5
  CONDITION: last_bid_strain == 'NT'
  CONDITION: spade_len <= 4.5
  CONDITION: hcp > 7.5
  CONDITION: competition_level > 1.5
  CONDITION: heart_len <= 4.5
  CONDITION: hcp > 11.5
  CONDITION: my_first_call == '1S'
  # distilled from Brill /bid

RULE BD_False_P128:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid <= 0.5
  CONDITION: spade_len > 3.5
  CONDITION: last_bid_strain == 'NT'
  CONDITION: spade_len <= 4.5
  CONDITION: hcp > 7.5
  CONDITION: competition_level > 1.5
  CONDITION: heart_len <= 4.5
  CONDITION: hcp > 11.5
  CONDITION: my_first_call != '1S'
  # distilled from Brill /bid

RULE BD_False_P129:
  CALL: 2D
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid <= 0.5
  CONDITION: spade_len > 3.5
  CONDITION: last_bid_strain == 'NT'
  CONDITION: spade_len <= 4.5
  CONDITION: hcp > 7.5
  CONDITION: competition_level > 1.5
  CONDITION: heart_len > 4.5
  CONDITION: rule20_total <= 25.5
  CONDITION: club_len <= 1.5
  # distilled from Brill /bid

RULE BD_False_P130:
  CALL: 2C
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid <= 0.5
  CONDITION: spade_len > 3.5
  CONDITION: last_bid_strain == 'NT'
  CONDITION: spade_len <= 4.5
  CONDITION: hcp > 7.5
  CONDITION: competition_level > 1.5
  CONDITION: heart_len > 4.5
  CONDITION: rule20_total <= 25.5
  CONDITION: club_len > 1.5
  # distilled from Brill /bid

RULE BD_False_P131:
  CALL: 2D
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid <= 0.5
  CONDITION: spade_len > 3.5
  CONDITION: last_bid_strain == 'NT'
  CONDITION: spade_len <= 4.5
  CONDITION: hcp > 7.5
  CONDITION: competition_level > 1.5
  CONDITION: heart_len > 4.5
  CONDITION: rule20_total > 25.5
  CONDITION: my_seat == 'S'
  # distilled from Brill /bid

RULE BD_False_P132:
  CALL: 2S
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid <= 0.5
  CONDITION: spade_len > 3.5
  CONDITION: last_bid_strain == 'NT'
  CONDITION: spade_len <= 4.5
  CONDITION: hcp > 7.5
  CONDITION: competition_level > 1.5
  CONDITION: heart_len > 4.5
  CONDITION: rule20_total > 25.5
  CONDITION: my_seat != 'S'
  # distilled from Brill /bid

RULE BD_False_P133:
  CALL: 2D
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid <= 0.5
  CONDITION: spade_len > 3.5
  CONDITION: last_bid_strain == 'NT'
  CONDITION: spade_len > 4.5
  CONDITION: my_last_call == '1S'
  CONDITION: heart_len <= 3.5
  CONDITION: spade_len <= 5.5
  CONDITION: c_is_best_minor <= 0.5
  CONDITION: competition_level <= 2.5
  # distilled from Brill /bid

RULE BD_False_P134:
  CALL: 2D
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid <= 0.5
  CONDITION: spade_len > 3.5
  CONDITION: last_bid_strain == 'NT'
  CONDITION: spade_len > 4.5
  CONDITION: my_last_call == '1S'
  CONDITION: heart_len <= 3.5
  CONDITION: spade_len <= 5.5
  CONDITION: c_is_best_minor <= 0.5
  CONDITION: competition_level > 2.5
  # distilled from Brill /bid

RULE BD_False_P135:
  CALL: 2C
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid <= 0.5
  CONDITION: spade_len > 3.5
  CONDITION: last_bid_strain == 'NT'
  CONDITION: spade_len > 4.5
  CONDITION: my_last_call == '1S'
  CONDITION: heart_len <= 3.5
  CONDITION: spade_len <= 5.5
  CONDITION: c_is_best_minor > 0.5
  CONDITION: competition_level <= 2.5
  # distilled from Brill /bid

RULE BD_False_P136:
  CALL: 2S
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid <= 0.5
  CONDITION: spade_len > 3.5
  CONDITION: last_bid_strain == 'NT'
  CONDITION: spade_len > 4.5
  CONDITION: my_last_call == '1S'
  CONDITION: heart_len <= 3.5
  CONDITION: spade_len <= 5.5
  CONDITION: c_is_best_minor > 0.5
  CONDITION: competition_level > 2.5
  # distilled from Brill /bid

RULE BD_False_P137:
  CALL: 2S
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid <= 0.5
  CONDITION: spade_len > 3.5
  CONDITION: last_bid_strain == 'NT'
  CONDITION: spade_len > 4.5
  CONDITION: my_last_call == '1S'
  CONDITION: heart_len <= 3.5
  CONDITION: spade_len > 5.5
  CONDITION: rule20_total <= 24.5
  CONDITION: diamond_len <= 3.5
  # distilled from Brill /bid

RULE BD_False_P138:
  CALL: 2D
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid <= 0.5
  CONDITION: spade_len > 3.5
  CONDITION: last_bid_strain == 'NT'
  CONDITION: spade_len > 4.5
  CONDITION: my_last_call == '1S'
  CONDITION: heart_len <= 3.5
  CONDITION: spade_len > 5.5
  CONDITION: rule20_total <= 24.5
  CONDITION: diamond_len > 3.5
  # distilled from Brill /bid

RULE BD_False_P139:
  CALL: 3S
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid <= 0.5
  CONDITION: spade_len > 3.5
  CONDITION: last_bid_strain == 'NT'
  CONDITION: spade_len > 4.5
  CONDITION: my_last_call == '1S'
  CONDITION: heart_len <= 3.5
  CONDITION: spade_len > 5.5
  CONDITION: rule20_total > 24.5
  CONDITION: spade_len <= 6.5
  # distilled from Brill /bid

RULE BD_False_P140:
  CALL: 4S
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid <= 0.5
  CONDITION: spade_len > 3.5
  CONDITION: last_bid_strain == 'NT'
  CONDITION: spade_len > 4.5
  CONDITION: my_last_call == '1S'
  CONDITION: heart_len <= 3.5
  CONDITION: spade_len > 5.5
  CONDITION: rule20_total > 24.5
  CONDITION: spade_len > 6.5
  # distilled from Brill /bid

RULE BD_False_P141:
  CALL: 3H
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid <= 0.5
  CONDITION: spade_len > 3.5
  CONDITION: last_bid_strain == 'NT'
  CONDITION: spade_len > 4.5
  CONDITION: my_last_call == '1S'
  CONDITION: heart_len > 3.5
  CONDITION: competition_level <= 2.5
  CONDITION: rule20_total <= 25.5
  CONDITION: losing_trick_count <= 4.5
  # distilled from Brill /bid

RULE BD_False_P142:
  CALL: 2H
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid <= 0.5
  CONDITION: spade_len > 3.5
  CONDITION: last_bid_strain == 'NT'
  CONDITION: spade_len > 4.5
  CONDITION: my_last_call == '1S'
  CONDITION: heart_len > 3.5
  CONDITION: competition_level <= 2.5
  CONDITION: rule20_total <= 25.5
  CONDITION: losing_trick_count > 4.5
  # distilled from Brill /bid

RULE BD_False_P143:
  CALL: 2NT
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid <= 0.5
  CONDITION: spade_len > 3.5
  CONDITION: last_bid_strain == 'NT'
  CONDITION: spade_len > 4.5
  CONDITION: my_last_call == '1S'
  CONDITION: heart_len > 3.5
  CONDITION: competition_level <= 2.5
  CONDITION: rule20_total > 25.5
  CONDITION: rule20_total <= 26.5
  # distilled from Brill /bid

RULE BD_False_P144:
  CALL: 3H
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid <= 0.5
  CONDITION: spade_len > 3.5
  CONDITION: last_bid_strain == 'NT'
  CONDITION: spade_len > 4.5
  CONDITION: my_last_call == '1S'
  CONDITION: heart_len > 3.5
  CONDITION: competition_level <= 2.5
  CONDITION: rule20_total > 25.5
  CONDITION: rule20_total > 26.5
  # distilled from Brill /bid

RULE BD_False_P145:
  CALL: 2S
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid <= 0.5
  CONDITION: spade_len > 3.5
  CONDITION: last_bid_strain == 'NT'
  CONDITION: spade_len > 4.5
  CONDITION: my_last_call == '1S'
  CONDITION: heart_len > 3.5
  CONDITION: competition_level > 2.5
  CONDITION: hcp <= 10.5
  # distilled from Brill /bid

RULE BD_False_P146:
  CALL: 2C
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid <= 0.5
  CONDITION: spade_len > 3.5
  CONDITION: last_bid_strain == 'NT'
  CONDITION: spade_len > 4.5
  CONDITION: my_last_call == '1S'
  CONDITION: heart_len > 3.5
  CONDITION: competition_level > 2.5
  CONDITION: hcp > 10.5
  CONDITION: opening_bid == '1D'
  # distilled from Brill /bid

RULE BD_False_P147:
  CALL: 2D
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid <= 0.5
  CONDITION: spade_len > 3.5
  CONDITION: last_bid_strain == 'NT'
  CONDITION: spade_len > 4.5
  CONDITION: my_last_call == '1S'
  CONDITION: heart_len > 3.5
  CONDITION: competition_level > 2.5
  CONDITION: hcp > 10.5
  CONDITION: opening_bid != '1D'
  # distilled from Brill /bid

RULE BD_False_P148:
  CALL: 2H
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid <= 0.5
  CONDITION: spade_len > 3.5
  CONDITION: last_bid_strain == 'NT'
  CONDITION: spade_len > 4.5
  CONDITION: my_last_call != '1S'
  CONDITION: longest_suit_len <= 5.5
  CONDITION: heart_len <= 3.5
  CONDITION: passes_since_last_bid <= 1.5
  # distilled from Brill /bid

RULE BD_False_P149:
  CALL: 2S
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid <= 0.5
  CONDITION: spade_len > 3.5
  CONDITION: last_bid_strain == 'NT'
  CONDITION: spade_len > 4.5
  CONDITION: my_last_call != '1S'
  CONDITION: longest_suit_len <= 5.5
  CONDITION: heart_len <= 3.5
  CONDITION: passes_since_last_bid > 1.5
  # distilled from Brill /bid

RULE BD_False_P150:
  CALL: 2H
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid <= 0.5
  CONDITION: spade_len > 3.5
  CONDITION: last_bid_strain == 'NT'
  CONDITION: spade_len > 4.5
  CONDITION: my_last_call != '1S'
  CONDITION: longest_suit_len <= 5.5
  CONDITION: heart_len > 3.5
  CONDITION: hcp <= 9.5
  CONDITION: heart_len <= 4.5
  # distilled from Brill /bid

RULE BD_False_P151:
  CALL: 2D
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid <= 0.5
  CONDITION: spade_len > 3.5
  CONDITION: last_bid_strain == 'NT'
  CONDITION: spade_len > 4.5
  CONDITION: my_last_call != '1S'
  CONDITION: longest_suit_len <= 5.5
  CONDITION: heart_len > 3.5
  CONDITION: hcp <= 9.5
  CONDITION: heart_len > 4.5
  # distilled from Brill /bid

RULE BD_False_P152:
  CALL: 2C
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid <= 0.5
  CONDITION: spade_len > 3.5
  CONDITION: last_bid_strain == 'NT'
  CONDITION: spade_len > 4.5
  CONDITION: my_last_call != '1S'
  CONDITION: longest_suit_len <= 5.5
  CONDITION: heart_len > 3.5
  CONDITION: hcp > 9.5
  # distilled from Brill /bid

RULE BD_False_P153:
  CALL: 2H
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid <= 0.5
  CONDITION: spade_len > 3.5
  CONDITION: last_bid_strain == 'NT'
  CONDITION: spade_len > 4.5
  CONDITION: my_last_call != '1S'
  CONDITION: longest_suit_len > 5.5
  CONDITION: total_points <= 7.5
  CONDITION: hcp <= 6.5
  CONDITION: heart_len <= 4.5
  # distilled from Brill /bid

RULE BD_False_P154:
  CALL: 2D
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid <= 0.5
  CONDITION: spade_len > 3.5
  CONDITION: last_bid_strain == 'NT'
  CONDITION: spade_len > 4.5
  CONDITION: my_last_call != '1S'
  CONDITION: longest_suit_len > 5.5
  CONDITION: total_points <= 7.5
  CONDITION: hcp <= 6.5
  CONDITION: heart_len > 4.5
  # distilled from Brill /bid

RULE BD_False_P155:
  CALL: 4H
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid <= 0.5
  CONDITION: spade_len > 3.5
  CONDITION: last_bid_strain == 'NT'
  CONDITION: spade_len > 4.5
  CONDITION: my_last_call != '1S'
  CONDITION: longest_suit_len > 5.5
  CONDITION: total_points <= 7.5
  CONDITION: hcp > 6.5
  # distilled from Brill /bid

RULE BD_False_P156:
  CALL: 4H
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid <= 0.5
  CONDITION: spade_len > 3.5
  CONDITION: last_bid_strain == 'NT'
  CONDITION: spade_len > 4.5
  CONDITION: my_last_call != '1S'
  CONDITION: longest_suit_len > 5.5
  CONDITION: total_points > 7.5
  CONDITION: second_longest_len <= 4.5
  # distilled from Brill /bid

RULE BD_False_P157:
  CALL: 2H
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid <= 0.5
  CONDITION: spade_len > 3.5
  CONDITION: last_bid_strain == 'NT'
  CONDITION: spade_len > 4.5
  CONDITION: my_last_call != '1S'
  CONDITION: longest_suit_len > 5.5
  CONDITION: total_points > 7.5
  CONDITION: second_longest_len > 4.5
  CONDITION: heart_hcp <= 0.5
  # distilled from Brill /bid

RULE BD_False_P158:
  CALL: 4H
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid <= 0.5
  CONDITION: spade_len > 3.5
  CONDITION: last_bid_strain == 'NT'
  CONDITION: spade_len > 4.5
  CONDITION: my_last_call != '1S'
  CONDITION: longest_suit_len > 5.5
  CONDITION: total_points > 7.5
  CONDITION: second_longest_len > 4.5
  CONDITION: heart_hcp > 0.5
  # distilled from Brill /bid

RULE BD_False_P159:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid <= 0.5
  CONDITION: spade_len > 3.5
  CONDITION: last_bid_strain != 'NT'
  CONDITION: last_bid_strain == 'S'
  CONDITION: hcp <= 8.5
  CONDITION: support_in_partner_suit <= 4.5
  CONDITION: hcp <= 4.5
  CONDITION: total_points <= 5.5
  # distilled from Brill /bid

RULE BD_False_P160:
  CALL: 2S
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid <= 0.5
  CONDITION: spade_len > 3.5
  CONDITION: last_bid_strain != 'NT'
  CONDITION: last_bid_strain == 'S'
  CONDITION: hcp <= 8.5
  CONDITION: support_in_partner_suit <= 4.5
  CONDITION: hcp <= 4.5
  CONDITION: total_points > 5.5
  CONDITION: major_hcp <= 2.5
  # distilled from Brill /bid

RULE BD_False_P161:
  CALL: 3S
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid <= 0.5
  CONDITION: spade_len > 3.5
  CONDITION: last_bid_strain != 'NT'
  CONDITION: last_bid_strain == 'S'
  CONDITION: hcp <= 8.5
  CONDITION: support_in_partner_suit <= 4.5
  CONDITION: hcp <= 4.5
  CONDITION: total_points > 5.5
  CONDITION: major_hcp > 2.5
  # distilled from Brill /bid

RULE BD_False_P162:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid <= 0.5
  CONDITION: spade_len > 3.5
  CONDITION: last_bid_strain != 'NT'
  CONDITION: last_bid_strain == 'S'
  CONDITION: hcp <= 8.5
  CONDITION: support_in_partner_suit <= 4.5
  CONDITION: hcp > 4.5
  CONDITION: my_last_call == '1H'
  CONDITION: total_points <= 7.5
  # distilled from Brill /bid

RULE BD_False_P163:
  CALL: 2S
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid <= 0.5
  CONDITION: spade_len > 3.5
  CONDITION: last_bid_strain != 'NT'
  CONDITION: last_bid_strain == 'S'
  CONDITION: hcp <= 8.5
  CONDITION: support_in_partner_suit <= 4.5
  CONDITION: hcp > 4.5
  CONDITION: my_last_call == '1H'
  CONDITION: total_points > 7.5
  # distilled from Brill /bid

RULE BD_False_P164:
  CALL: 2S
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid <= 0.5
  CONDITION: spade_len > 3.5
  CONDITION: last_bid_strain != 'NT'
  CONDITION: last_bid_strain == 'S'
  CONDITION: hcp <= 8.5
  CONDITION: support_in_partner_suit <= 4.5
  CONDITION: hcp > 4.5
  CONDITION: my_last_call != '1H'
  CONDITION: passes_since_last_bid <= 0.5
  # distilled from Brill /bid

RULE BD_False_P165:
  CALL: 2S
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid <= 0.5
  CONDITION: spade_len > 3.5
  CONDITION: last_bid_strain != 'NT'
  CONDITION: last_bid_strain == 'S'
  CONDITION: hcp <= 8.5
  CONDITION: support_in_partner_suit <= 4.5
  CONDITION: hcp > 4.5
  CONDITION: my_last_call != '1H'
  CONDITION: passes_since_last_bid > 0.5
  # distilled from Brill /bid

RULE BD_False_P166:
  CALL: 4S
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid <= 0.5
  CONDITION: spade_len > 3.5
  CONDITION: last_bid_strain != 'NT'
  CONDITION: last_bid_strain == 'S'
  CONDITION: hcp <= 8.5
  CONDITION: support_in_partner_suit > 4.5
  CONDITION: competition_level <= 1.5
  # distilled from Brill /bid

RULE BD_False_P167:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid <= 0.5
  CONDITION: spade_len > 3.5
  CONDITION: last_bid_strain != 'NT'
  CONDITION: last_bid_strain == 'S'
  CONDITION: hcp <= 8.5
  CONDITION: support_in_partner_suit > 4.5
  CONDITION: competition_level > 1.5
  CONDITION: major_hcp <= 1.5
  CONDITION: hcp <= 0.5
  # distilled from Brill /bid

RULE BD_False_P168:
  CALL: 2S
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid <= 0.5
  CONDITION: spade_len > 3.5
  CONDITION: last_bid_strain != 'NT'
  CONDITION: last_bid_strain == 'S'
  CONDITION: hcp <= 8.5
  CONDITION: support_in_partner_suit > 4.5
  CONDITION: competition_level > 1.5
  CONDITION: major_hcp <= 1.5
  CONDITION: hcp > 0.5
  # distilled from Brill /bid

RULE BD_False_P169:
  CALL: 4S
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid <= 0.5
  CONDITION: spade_len > 3.5
  CONDITION: last_bid_strain != 'NT'
  CONDITION: last_bid_strain == 'S'
  CONDITION: hcp <= 8.5
  CONDITION: support_in_partner_suit > 4.5
  CONDITION: competition_level > 1.5
  CONDITION: major_hcp > 1.5
  CONDITION: hcp <= 5.5
  # distilled from Brill /bid

RULE BD_False_P170:
  CALL: 2S
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid <= 0.5
  CONDITION: spade_len > 3.5
  CONDITION: last_bid_strain != 'NT'
  CONDITION: last_bid_strain == 'S'
  CONDITION: hcp <= 8.5
  CONDITION: support_in_partner_suit > 4.5
  CONDITION: competition_level > 1.5
  CONDITION: major_hcp > 1.5
  CONDITION: hcp > 5.5
  # distilled from Brill /bid

RULE BD_False_P171:
  CALL: 2S
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid <= 0.5
  CONDITION: spade_len > 3.5
  CONDITION: last_bid_strain != 'NT'
  CONDITION: last_bid_strain == 'S'
  CONDITION: hcp > 8.5
  CONDITION: opening_bid == '1S'
  CONDITION: total_points <= 11.5
  CONDITION: passes_since_last_bid <= 0.5
  CONDITION: hcp <= 9.5
  # distilled from Brill /bid

RULE BD_False_P172:
  CALL: 2NT
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid <= 0.5
  CONDITION: spade_len > 3.5
  CONDITION: last_bid_strain != 'NT'
  CONDITION: last_bid_strain == 'S'
  CONDITION: hcp > 8.5
  CONDITION: opening_bid == '1S'
  CONDITION: total_points <= 11.5
  CONDITION: passes_since_last_bid <= 0.5
  CONDITION: hcp > 9.5
  # distilled from Brill /bid

RULE BD_False_P173:
  CALL: 3S
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid <= 0.5
  CONDITION: spade_len > 3.5
  CONDITION: last_bid_strain != 'NT'
  CONDITION: last_bid_strain == 'S'
  CONDITION: hcp > 8.5
  CONDITION: opening_bid == '1S'
  CONDITION: total_points <= 11.5
  CONDITION: passes_since_last_bid > 0.5
  CONDITION: auction_len <= 3.5
  # distilled from Brill /bid

RULE BD_False_P174:
  CALL: 3S
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid <= 0.5
  CONDITION: spade_len > 3.5
  CONDITION: last_bid_strain != 'NT'
  CONDITION: last_bid_strain == 'S'
  CONDITION: hcp > 8.5
  CONDITION: opening_bid == '1S'
  CONDITION: total_points <= 11.5
  CONDITION: passes_since_last_bid > 0.5
  CONDITION: auction_len > 3.5
  # distilled from Brill /bid

RULE BD_False_P175:
  CALL: 4C
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid <= 0.5
  CONDITION: spade_len > 3.5
  CONDITION: last_bid_strain != 'NT'
  CONDITION: last_bid_strain == 'S'
  CONDITION: hcp > 8.5
  CONDITION: opening_bid == '1S'
  CONDITION: total_points > 11.5
  CONDITION: passes_since_last_bid <= 1.5
  CONDITION: club_len <= 1.5
  # distilled from Brill /bid

RULE BD_False_P176:
  CALL: 2NT
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid <= 0.5
  CONDITION: spade_len > 3.5
  CONDITION: last_bid_strain != 'NT'
  CONDITION: last_bid_strain == 'S'
  CONDITION: hcp > 8.5
  CONDITION: opening_bid == '1S'
  CONDITION: total_points > 11.5
  CONDITION: passes_since_last_bid <= 1.5
  CONDITION: club_len > 1.5
  # distilled from Brill /bid

RULE BD_False_P177:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid <= 0.5
  CONDITION: spade_len > 3.5
  CONDITION: last_bid_strain != 'NT'
  CONDITION: last_bid_strain == 'S'
  CONDITION: hcp > 8.5
  CONDITION: opening_bid == '1S'
  CONDITION: total_points > 11.5
  CONDITION: passes_since_last_bid > 1.5
  CONDITION: spade_len <= 5.5
  # distilled from Brill /bid

RULE BD_False_P178:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid <= 0.5
  CONDITION: spade_len > 3.5
  CONDITION: last_bid_strain != 'NT'
  CONDITION: last_bid_strain == 'S'
  CONDITION: hcp > 8.5
  CONDITION: opening_bid == '1S'
  CONDITION: total_points > 11.5
  CONDITION: passes_since_last_bid > 1.5
  CONDITION: spade_len > 5.5
  # distilled from Brill /bid

RULE BD_False_P179:
  CALL: 2S
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid <= 0.5
  CONDITION: spade_len > 3.5
  CONDITION: last_bid_strain != 'NT'
  CONDITION: last_bid_strain == 'S'
  CONDITION: hcp > 8.5
  CONDITION: opening_bid != '1S'
  CONDITION: hcp <= 14.5
  CONDITION: my_side_bid_count <= 2.5
  CONDITION: is_balanced <= 0.5
  # distilled from Brill /bid

RULE BD_False_P180:
  CALL: 2S
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid <= 0.5
  CONDITION: spade_len > 3.5
  CONDITION: last_bid_strain != 'NT'
  CONDITION: last_bid_strain == 'S'
  CONDITION: hcp > 8.5
  CONDITION: opening_bid != '1S'
  CONDITION: hcp <= 14.5
  CONDITION: my_side_bid_count <= 2.5
  CONDITION: is_balanced > 0.5
  # distilled from Brill /bid

RULE BD_False_P181:
  CALL: 2S
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid <= 0.5
  CONDITION: spade_len > 3.5
  CONDITION: last_bid_strain != 'NT'
  CONDITION: last_bid_strain == 'S'
  CONDITION: hcp > 8.5
  CONDITION: opening_bid != '1S'
  CONDITION: hcp <= 14.5
  CONDITION: my_side_bid_count > 2.5
  CONDITION: hcp <= 9.5
  # distilled from Brill /bid

RULE BD_False_P182:
  CALL: 4S
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid <= 0.5
  CONDITION: spade_len > 3.5
  CONDITION: last_bid_strain != 'NT'
  CONDITION: last_bid_strain == 'S'
  CONDITION: hcp > 8.5
  CONDITION: opening_bid != '1S'
  CONDITION: hcp <= 14.5
  CONDITION: my_side_bid_count > 2.5
  CONDITION: hcp > 9.5
  # distilled from Brill /bid

RULE BD_False_P183:
  CALL: 2C
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid <= 0.5
  CONDITION: spade_len > 3.5
  CONDITION: last_bid_strain != 'NT'
  CONDITION: last_bid_strain == 'S'
  CONDITION: hcp > 8.5
  CONDITION: opening_bid != '1S'
  CONDITION: hcp > 14.5
  CONDITION: hcp <= 17.5
  CONDITION: partner_first_call == '1D'
  # distilled from Brill /bid

RULE BD_False_P184:
  CALL: 3S
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid <= 0.5
  CONDITION: spade_len > 3.5
  CONDITION: last_bid_strain != 'NT'
  CONDITION: last_bid_strain == 'S'
  CONDITION: hcp > 8.5
  CONDITION: opening_bid != '1S'
  CONDITION: hcp > 14.5
  CONDITION: hcp <= 17.5
  CONDITION: partner_first_call != '1D'
  # distilled from Brill /bid

RULE BD_False_P185:
  CALL: 4D
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid <= 0.5
  CONDITION: spade_len > 3.5
  CONDITION: last_bid_strain != 'NT'
  CONDITION: last_bid_strain == 'S'
  CONDITION: hcp > 8.5
  CONDITION: opening_bid != '1S'
  CONDITION: hcp > 14.5
  CONDITION: hcp > 17.5
  CONDITION: my_last_call == '1H'
  # distilled from Brill /bid

RULE BD_False_P186:
  CALL: 4S
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid <= 0.5
  CONDITION: spade_len > 3.5
  CONDITION: last_bid_strain != 'NT'
  CONDITION: last_bid_strain == 'S'
  CONDITION: hcp > 8.5
  CONDITION: opening_bid != '1S'
  CONDITION: hcp > 14.5
  CONDITION: hcp > 17.5
  CONDITION: my_last_call != '1H'
  # distilled from Brill /bid

RULE BD_False_P187:
  CALL: 2S
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid <= 0.5
  CONDITION: spade_len > 3.5
  CONDITION: last_bid_strain != 'NT'
  CONDITION: last_bid_strain != 'S'
  CONDITION: h_is_best_major <= 0.5
  CONDITION: hcp <= 4.5
  CONDITION: total_points <= 5.5
  CONDITION: shape_pattern == '6421'
  CONDITION: s_has_ten <= 0.5
  # distilled from Brill /bid

RULE BD_False_P188:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid <= 0.5
  CONDITION: spade_len > 3.5
  CONDITION: last_bid_strain != 'NT'
  CONDITION: last_bid_strain != 'S'
  CONDITION: h_is_best_major <= 0.5
  CONDITION: hcp <= 4.5
  CONDITION: total_points <= 5.5
  CONDITION: shape_pattern == '6421'
  CONDITION: s_has_ten > 0.5
  # distilled from Brill /bid

RULE BD_False_P189:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid <= 0.5
  CONDITION: spade_len > 3.5
  CONDITION: last_bid_strain != 'NT'
  CONDITION: last_bid_strain != 'S'
  CONDITION: h_is_best_major <= 0.5
  CONDITION: hcp <= 4.5
  CONDITION: total_points <= 5.5
  CONDITION: shape_pattern != '6421'
  # distilled from Brill /bid

RULE BD_False_P190:
  CALL: 1S
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid <= 0.5
  CONDITION: spade_len > 3.5
  CONDITION: last_bid_strain != 'NT'
  CONDITION: last_bid_strain != 'S'
  CONDITION: h_is_best_major <= 0.5
  CONDITION: hcp <= 4.5
  CONDITION: total_points > 5.5
  CONDITION: last_bid_strain == 'H'
  CONDITION: heart_len <= 2.5
  # distilled from Brill /bid

RULE BD_False_P191:
  CALL: 2H
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid <= 0.5
  CONDITION: spade_len > 3.5
  CONDITION: last_bid_strain != 'NT'
  CONDITION: last_bid_strain != 'S'
  CONDITION: h_is_best_major <= 0.5
  CONDITION: hcp <= 4.5
  CONDITION: total_points > 5.5
  CONDITION: last_bid_strain == 'H'
  CONDITION: heart_len > 2.5
  # distilled from Brill /bid

RULE BD_False_P192:
  CALL: 1S
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid <= 0.5
  CONDITION: spade_len > 3.5
  CONDITION: last_bid_strain != 'NT'
  CONDITION: last_bid_strain != 'S'
  CONDITION: h_is_best_major <= 0.5
  CONDITION: hcp <= 4.5
  CONDITION: total_points > 5.5
  CONDITION: last_bid_strain != 'H'
  CONDITION: passes_since_last_bid <= 0.5
  # distilled from Brill /bid

RULE BD_False_P193:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid <= 0.5
  CONDITION: spade_len > 3.5
  CONDITION: last_bid_strain != 'NT'
  CONDITION: last_bid_strain != 'S'
  CONDITION: h_is_best_major <= 0.5
  CONDITION: hcp <= 4.5
  CONDITION: total_points > 5.5
  CONDITION: last_bid_strain != 'H'
  CONDITION: passes_since_last_bid > 0.5
  # distilled from Brill /bid

RULE BD_False_P194:
  CALL: 1S
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid <= 0.5
  CONDITION: spade_len > 3.5
  CONDITION: last_bid_strain != 'NT'
  CONDITION: last_bid_strain != 'S'
  CONDITION: h_is_best_major <= 0.5
  CONDITION: hcp > 4.5
  CONDITION: last_bid_strain == 'C'
  CONDITION: d_is_longest <= 0.5
  CONDITION: spade_len <= 6.5
  # distilled from Brill /bid

RULE BD_False_P195:
  CALL: 4S
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid <= 0.5
  CONDITION: spade_len > 3.5
  CONDITION: last_bid_strain != 'NT'
  CONDITION: last_bid_strain != 'S'
  CONDITION: h_is_best_major <= 0.5
  CONDITION: hcp > 4.5
  CONDITION: last_bid_strain == 'C'
  CONDITION: d_is_longest <= 0.5
  CONDITION: spade_len > 6.5
  # distilled from Brill /bid

RULE BD_False_P196:
  CALL: 1S
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid <= 0.5
  CONDITION: spade_len > 3.5
  CONDITION: last_bid_strain != 'NT'
  CONDITION: last_bid_strain != 'S'
  CONDITION: h_is_best_major <= 0.5
  CONDITION: hcp > 4.5
  CONDITION: last_bid_strain == 'C'
  CONDITION: d_is_longest > 0.5
  CONDITION: shape_pattern == '5521'
  # distilled from Brill /bid

RULE BD_False_P197:
  CALL: 1D
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid <= 0.5
  CONDITION: spade_len > 3.5
  CONDITION: last_bid_strain != 'NT'
  CONDITION: last_bid_strain != 'S'
  CONDITION: h_is_best_major <= 0.5
  CONDITION: hcp > 4.5
  CONDITION: last_bid_strain == 'C'
  CONDITION: d_is_longest > 0.5
  CONDITION: shape_pattern != '5521'
  # distilled from Brill /bid

RULE BD_False_P198:
  CALL: 1S
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid <= 0.5
  CONDITION: spade_len > 3.5
  CONDITION: last_bid_strain != 'NT'
  CONDITION: last_bid_strain != 'S'
  CONDITION: h_is_best_major <= 0.5
  CONDITION: hcp > 4.5
  CONDITION: last_bid_strain != 'C'
  CONDITION: hcp <= 9.5
  CONDITION: support_in_partner_suit <= 2.5
  # distilled from Brill /bid

RULE BD_False_P199:
  CALL: 1S
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid <= 0.5
  CONDITION: spade_len > 3.5
  CONDITION: last_bid_strain != 'NT'
  CONDITION: last_bid_strain != 'S'
  CONDITION: h_is_best_major <= 0.5
  CONDITION: hcp > 4.5
  CONDITION: last_bid_strain != 'C'
  CONDITION: hcp <= 9.5
  CONDITION: support_in_partner_suit > 2.5
  # distilled from Brill /bid

RULE BD_False_P200:
  CALL: 1S
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid <= 0.5
  CONDITION: spade_len > 3.5
  CONDITION: last_bid_strain != 'NT'
  CONDITION: last_bid_strain != 'S'
  CONDITION: h_is_best_major <= 0.5
  CONDITION: hcp > 4.5
  CONDITION: last_bid_strain != 'C'
  CONDITION: hcp > 9.5
  CONDITION: hcp <= 17.5
  # distilled from Brill /bid

RULE BD_False_P201:
  CALL: 2NT
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid <= 0.5
  CONDITION: spade_len > 3.5
  CONDITION: last_bid_strain != 'NT'
  CONDITION: last_bid_strain != 'S'
  CONDITION: h_is_best_major <= 0.5
  CONDITION: hcp > 4.5
  CONDITION: last_bid_strain != 'C'
  CONDITION: hcp > 9.5
  CONDITION: hcp > 17.5
  # distilled from Brill /bid

RULE BD_False_P202:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid <= 0.5
  CONDITION: spade_len > 3.5
  CONDITION: last_bid_strain != 'NT'
  CONDITION: last_bid_strain != 'S'
  CONDITION: h_is_best_major > 0.5
  CONDITION: last_bid_strain == 'H'
  CONDITION: opening_bid == '1H'
  CONDITION: hcp <= 8.5
  CONDITION: total_points <= 5.5
  # distilled from Brill /bid

RULE BD_False_P203:
  CALL: 2H
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid <= 0.5
  CONDITION: spade_len > 3.5
  CONDITION: last_bid_strain != 'NT'
  CONDITION: last_bid_strain != 'S'
  CONDITION: h_is_best_major > 0.5
  CONDITION: last_bid_strain == 'H'
  CONDITION: opening_bid == '1H'
  CONDITION: hcp <= 8.5
  CONDITION: total_points > 5.5
  # distilled from Brill /bid

RULE BD_False_P204:
  CALL: 3H
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid <= 0.5
  CONDITION: spade_len > 3.5
  CONDITION: last_bid_strain != 'NT'
  CONDITION: last_bid_strain != 'S'
  CONDITION: h_is_best_major > 0.5
  CONDITION: last_bid_strain == 'H'
  CONDITION: opening_bid == '1H'
  CONDITION: hcp > 8.5
  CONDITION: total_points <= 12.5
  # distilled from Brill /bid

RULE BD_False_P205:
  CALL: 2NT
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid <= 0.5
  CONDITION: spade_len > 3.5
  CONDITION: last_bid_strain != 'NT'
  CONDITION: last_bid_strain != 'S'
  CONDITION: h_is_best_major > 0.5
  CONDITION: last_bid_strain == 'H'
  CONDITION: opening_bid == '1H'
  CONDITION: hcp > 8.5
  CONDITION: total_points > 12.5
  # distilled from Brill /bid

RULE BD_False_P206:
  CALL: 2H
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid <= 0.5
  CONDITION: spade_len > 3.5
  CONDITION: last_bid_strain != 'NT'
  CONDITION: last_bid_strain != 'S'
  CONDITION: h_is_best_major > 0.5
  CONDITION: last_bid_strain == 'H'
  CONDITION: opening_bid != '1H'
  CONDITION: total_points <= 14.5
  CONDITION: diamond_len <= 3.5
  # distilled from Brill /bid

RULE BD_False_P207:
  CALL: 3H
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid <= 0.5
  CONDITION: spade_len > 3.5
  CONDITION: last_bid_strain != 'NT'
  CONDITION: last_bid_strain != 'S'
  CONDITION: h_is_best_major > 0.5
  CONDITION: last_bid_strain == 'H'
  CONDITION: opening_bid != '1H'
  CONDITION: total_points <= 14.5
  CONDITION: diamond_len > 3.5
  # distilled from Brill /bid

RULE BD_False_P208:
  CALL: 3H
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid <= 0.5
  CONDITION: spade_len > 3.5
  CONDITION: last_bid_strain != 'NT'
  CONDITION: last_bid_strain != 'S'
  CONDITION: h_is_best_major > 0.5
  CONDITION: last_bid_strain == 'H'
  CONDITION: opening_bid != '1H'
  CONDITION: total_points > 14.5
  CONDITION: hcp <= 17.0
  # distilled from Brill /bid

RULE BD_False_P209:
  CALL: 4H
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid <= 0.5
  CONDITION: spade_len > 3.5
  CONDITION: last_bid_strain != 'NT'
  CONDITION: last_bid_strain != 'S'
  CONDITION: h_is_best_major > 0.5
  CONDITION: last_bid_strain == 'H'
  CONDITION: opening_bid != '1H'
  CONDITION: total_points > 14.5
  CONDITION: hcp > 17.0
  # distilled from Brill /bid

RULE BD_False_P210:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid <= 0.5
  CONDITION: spade_len > 3.5
  CONDITION: last_bid_strain != 'NT'
  CONDITION: last_bid_strain != 'S'
  CONDITION: h_is_best_major > 0.5
  CONDITION: last_bid_strain != 'H'
  CONDITION: hcp <= 4.5
  CONDITION: controls <= 1.5
  CONDITION: d_has_queen <= 0.5
  # distilled from Brill /bid

RULE BD_False_P211:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid <= 0.5
  CONDITION: spade_len > 3.5
  CONDITION: last_bid_strain != 'NT'
  CONDITION: last_bid_strain != 'S'
  CONDITION: h_is_best_major > 0.5
  CONDITION: last_bid_strain != 'H'
  CONDITION: hcp <= 4.5
  CONDITION: controls <= 1.5
  CONDITION: d_has_queen > 0.5
  # distilled from Brill /bid

RULE BD_False_P212:
  CALL: 1H
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid <= 0.5
  CONDITION: spade_len > 3.5
  CONDITION: last_bid_strain != 'NT'
  CONDITION: last_bid_strain != 'S'
  CONDITION: h_is_best_major > 0.5
  CONDITION: last_bid_strain != 'H'
  CONDITION: hcp <= 4.5
  CONDITION: controls > 1.5
  # distilled from Brill /bid

RULE BD_False_P213:
  CALL: 1H
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid <= 0.5
  CONDITION: spade_len > 3.5
  CONDITION: last_bid_strain != 'NT'
  CONDITION: last_bid_strain != 'S'
  CONDITION: h_is_best_major > 0.5
  CONDITION: last_bid_strain != 'H'
  CONDITION: hcp > 4.5
  CONDITION: spade_len <= 4.5
  CONDITION: d_is_longest <= 0.5
  # distilled from Brill /bid

RULE BD_False_P214:
  CALL: 1D
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid <= 0.5
  CONDITION: spade_len > 3.5
  CONDITION: last_bid_strain != 'NT'
  CONDITION: last_bid_strain != 'S'
  CONDITION: h_is_best_major > 0.5
  CONDITION: last_bid_strain != 'H'
  CONDITION: hcp > 4.5
  CONDITION: spade_len <= 4.5
  CONDITION: d_is_longest > 0.5
  # distilled from Brill /bid

RULE BD_False_P215:
  CALL: 1S
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid <= 0.5
  CONDITION: spade_len > 3.5
  CONDITION: last_bid_strain != 'NT'
  CONDITION: last_bid_strain != 'S'
  CONDITION: h_is_best_major > 0.5
  CONDITION: last_bid_strain != 'H'
  CONDITION: hcp > 4.5
  CONDITION: spade_len > 4.5
  CONDITION: heart_len <= 5.5
  # distilled from Brill /bid

RULE BD_False_P216:
  CALL: 1H
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid <= 0.5
  CONDITION: spade_len > 3.5
  CONDITION: last_bid_strain != 'NT'
  CONDITION: last_bid_strain != 'S'
  CONDITION: h_is_best_major > 0.5
  CONDITION: last_bid_strain != 'H'
  CONDITION: hcp > 4.5
  CONDITION: spade_len > 4.5
  CONDITION: heart_len > 5.5
  # distilled from Brill /bid

RULE BD_False_P217:
  CALL: 1H
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid > 0.5
  CONDITION: spade_len <= 4.5
  CONDITION: rule20_total <= 18.5
  CONDITION: my_side_bid_count <= 0.5
  CONDITION: partner_last_call == 'X'
  CONDITION: spade_len <= 3.5
  CONDITION: passes_since_last_bid <= 0.5
  CONDITION: last_bid_strain == 'D'
  CONDITION: hcp <= 4.5
  # distilled from Brill /bid

RULE BD_False_P218:
  CALL: 1H
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid > 0.5
  CONDITION: spade_len <= 4.5
  CONDITION: rule20_total <= 18.5
  CONDITION: my_side_bid_count <= 0.5
  CONDITION: partner_last_call == 'X'
  CONDITION: spade_len <= 3.5
  CONDITION: passes_since_last_bid <= 0.5
  CONDITION: last_bid_strain == 'D'
  CONDITION: hcp > 4.5
  # distilled from Brill /bid

RULE BD_False_P219:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid > 0.5
  CONDITION: spade_len <= 4.5
  CONDITION: rule20_total <= 18.5
  CONDITION: my_side_bid_count <= 0.5
  CONDITION: partner_last_call == 'X'
  CONDITION: spade_len <= 3.5
  CONDITION: passes_since_last_bid <= 0.5
  CONDITION: last_bid_strain != 'D'
  CONDITION: c_is_best_minor <= 0.5
  # distilled from Brill /bid

RULE BD_False_P220:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid > 0.5
  CONDITION: spade_len <= 4.5
  CONDITION: rule20_total <= 18.5
  CONDITION: my_side_bid_count <= 0.5
  CONDITION: partner_last_call == 'X'
  CONDITION: spade_len <= 3.5
  CONDITION: passes_since_last_bid <= 0.5
  CONDITION: last_bid_strain != 'D'
  CONDITION: c_is_best_minor > 0.5
  # distilled from Brill /bid

RULE BD_False_P221:
  CALL: 1NT
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid > 0.5
  CONDITION: spade_len <= 4.5
  CONDITION: rule20_total <= 18.5
  CONDITION: my_side_bid_count <= 0.5
  CONDITION: partner_last_call == 'X'
  CONDITION: spade_len <= 3.5
  CONDITION: passes_since_last_bid > 0.5
  CONDITION: heart_len <= 3.5
  CONDITION: d_is_longest <= 0.5
  # distilled from Brill /bid

RULE BD_False_P222:
  CALL: 2D
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid > 0.5
  CONDITION: spade_len <= 4.5
  CONDITION: rule20_total <= 18.5
  CONDITION: my_side_bid_count <= 0.5
  CONDITION: partner_last_call == 'X'
  CONDITION: spade_len <= 3.5
  CONDITION: passes_since_last_bid > 0.5
  CONDITION: heart_len <= 3.5
  CONDITION: d_is_longest > 0.5
  # distilled from Brill /bid

RULE BD_False_P223:
  CALL: 2C
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid > 0.5
  CONDITION: spade_len <= 4.5
  CONDITION: rule20_total <= 18.5
  CONDITION: my_side_bid_count <= 0.5
  CONDITION: partner_last_call == 'X'
  CONDITION: spade_len <= 3.5
  CONDITION: passes_since_last_bid > 0.5
  CONDITION: heart_len > 3.5
  CONDITION: last_bid_strain == 'NT'
  # distilled from Brill /bid

RULE BD_False_P224:
  CALL: 1H
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid > 0.5
  CONDITION: spade_len <= 4.5
  CONDITION: rule20_total <= 18.5
  CONDITION: my_side_bid_count <= 0.5
  CONDITION: partner_last_call == 'X'
  CONDITION: spade_len <= 3.5
  CONDITION: passes_since_last_bid > 0.5
  CONDITION: heart_len > 3.5
  CONDITION: last_bid_strain != 'NT'
  # distilled from Brill /bid

RULE BD_False_P225:
  CALL: 1NT
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid > 0.5
  CONDITION: spade_len <= 4.5
  CONDITION: rule20_total <= 18.5
  CONDITION: my_side_bid_count <= 0.5
  CONDITION: partner_last_call == 'X'
  CONDITION: spade_len > 3.5
  CONDITION: last_bid_strain == 'S'
  CONDITION: opening_bid == '1S'
  CONDITION: minor_hcp <= 5.5
  # distilled from Brill /bid

RULE BD_False_P226:
  CALL: 3H
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid > 0.5
  CONDITION: spade_len <= 4.5
  CONDITION: rule20_total <= 18.5
  CONDITION: my_side_bid_count <= 0.5
  CONDITION: partner_last_call == 'X'
  CONDITION: spade_len > 3.5
  CONDITION: last_bid_strain == 'S'
  CONDITION: opening_bid == '1S'
  CONDITION: minor_hcp > 5.5
  # distilled from Brill /bid

RULE BD_False_P227:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid > 0.5
  CONDITION: spade_len <= 4.5
  CONDITION: rule20_total <= 18.5
  CONDITION: my_side_bid_count <= 0.5
  CONDITION: partner_last_call == 'X'
  CONDITION: spade_len > 3.5
  CONDITION: last_bid_strain == 'S'
  CONDITION: opening_bid != '1S'
  CONDITION: major_hcp <= 5.5
  # distilled from Brill /bid

RULE BD_False_P228:
  CALL: 2H
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid > 0.5
  CONDITION: spade_len <= 4.5
  CONDITION: rule20_total <= 18.5
  CONDITION: my_side_bid_count <= 0.5
  CONDITION: partner_last_call == 'X'
  CONDITION: spade_len > 3.5
  CONDITION: last_bid_strain == 'S'
  CONDITION: opening_bid != '1S'
  CONDITION: major_hcp > 5.5
  # distilled from Brill /bid

RULE BD_False_P229:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid > 0.5
  CONDITION: spade_len <= 4.5
  CONDITION: rule20_total <= 18.5
  CONDITION: my_side_bid_count <= 0.5
  CONDITION: partner_last_call == 'X'
  CONDITION: spade_len > 3.5
  CONDITION: last_bid_strain != 'S'
  CONDITION: last_bid_strain == 'NT'
  CONDITION: auction_len <= 6.5
  # distilled from Brill /bid

RULE BD_False_P230:
  CALL: 2S
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid > 0.5
  CONDITION: spade_len <= 4.5
  CONDITION: rule20_total <= 18.5
  CONDITION: my_side_bid_count <= 0.5
  CONDITION: partner_last_call == 'X'
  CONDITION: spade_len > 3.5
  CONDITION: last_bid_strain != 'S'
  CONDITION: last_bid_strain == 'NT'
  CONDITION: auction_len > 6.5
  # distilled from Brill /bid

RULE BD_False_P231:
  CALL: 1S
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid > 0.5
  CONDITION: spade_len <= 4.5
  CONDITION: rule20_total <= 18.5
  CONDITION: my_side_bid_count <= 0.5
  CONDITION: partner_last_call == 'X'
  CONDITION: spade_len > 3.5
  CONDITION: last_bid_strain != 'S'
  CONDITION: last_bid_strain != 'NT'
  CONDITION: heart_len <= 3.5
  # distilled from Brill /bid

RULE BD_False_P232:
  CALL: 1H
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid > 0.5
  CONDITION: spade_len <= 4.5
  CONDITION: rule20_total <= 18.5
  CONDITION: my_side_bid_count <= 0.5
  CONDITION: partner_last_call == 'X'
  CONDITION: spade_len > 3.5
  CONDITION: last_bid_strain != 'S'
  CONDITION: last_bid_strain != 'NT'
  CONDITION: heart_len > 3.5
  # distilled from Brill /bid

RULE BD_False_P233:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid > 0.5
  CONDITION: spade_len <= 4.5
  CONDITION: rule20_total <= 18.5
  CONDITION: my_side_bid_count <= 0.5
  CONDITION: partner_last_call != 'X'
  CONDITION: heart_len <= 4.5
  CONDITION: diamond_len <= 4.5
  CONDITION: total_points <= 9.5
  CONDITION: losing_trick_count <= 7.5
  # distilled from Brill /bid

RULE BD_False_P234:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid > 0.5
  CONDITION: spade_len <= 4.5
  CONDITION: rule20_total <= 18.5
  CONDITION: my_side_bid_count <= 0.5
  CONDITION: partner_last_call != 'X'
  CONDITION: heart_len <= 4.5
  CONDITION: diamond_len <= 4.5
  CONDITION: total_points <= 9.5
  CONDITION: losing_trick_count > 7.5
  # distilled from Brill /bid

RULE BD_False_P235:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid > 0.5
  CONDITION: spade_len <= 4.5
  CONDITION: rule20_total <= 18.5
  CONDITION: my_side_bid_count <= 0.5
  CONDITION: partner_last_call != 'X'
  CONDITION: heart_len <= 4.5
  CONDITION: diamond_len <= 4.5
  CONDITION: total_points > 9.5
  CONDITION: is_semi_balanced <= 0.5
  # distilled from Brill /bid

RULE BD_False_P236:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid > 0.5
  CONDITION: spade_len <= 4.5
  CONDITION: rule20_total <= 18.5
  CONDITION: my_side_bid_count <= 0.5
  CONDITION: partner_last_call != 'X'
  CONDITION: heart_len <= 4.5
  CONDITION: diamond_len <= 4.5
  CONDITION: total_points > 9.5
  CONDITION: is_semi_balanced > 0.5
  # distilled from Brill /bid

RULE BD_False_P237:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid > 0.5
  CONDITION: spade_len <= 4.5
  CONDITION: rule20_total <= 18.5
  CONDITION: my_side_bid_count <= 0.5
  CONDITION: partner_last_call != 'X'
  CONDITION: heart_len <= 4.5
  CONDITION: diamond_len > 4.5
  CONDITION: last_bid_strain == 'C'
  CONDITION: hcp <= 7.5
  # distilled from Brill /bid

RULE BD_False_P238:
  CALL: 1D
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid > 0.5
  CONDITION: spade_len <= 4.5
  CONDITION: rule20_total <= 18.5
  CONDITION: my_side_bid_count <= 0.5
  CONDITION: partner_last_call != 'X'
  CONDITION: heart_len <= 4.5
  CONDITION: diamond_len > 4.5
  CONDITION: last_bid_strain == 'C'
  CONDITION: hcp > 7.5
  # distilled from Brill /bid

RULE BD_False_P239:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid > 0.5
  CONDITION: spade_len <= 4.5
  CONDITION: rule20_total <= 18.5
  CONDITION: my_side_bid_count <= 0.5
  CONDITION: partner_last_call != 'X'
  CONDITION: heart_len <= 4.5
  CONDITION: diamond_len > 4.5
  CONDITION: last_bid_strain != 'C'
  CONDITION: losing_trick_count <= 7.5
  # distilled from Brill /bid

RULE BD_False_P240:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid > 0.5
  CONDITION: spade_len <= 4.5
  CONDITION: rule20_total <= 18.5
  CONDITION: my_side_bid_count <= 0.5
  CONDITION: partner_last_call != 'X'
  CONDITION: heart_len <= 4.5
  CONDITION: diamond_len > 4.5
  CONDITION: last_bid_strain != 'C'
  CONDITION: losing_trick_count > 7.5
  # distilled from Brill /bid

RULE BD_False_P241:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid > 0.5
  CONDITION: spade_len <= 4.5
  CONDITION: rule20_total <= 18.5
  CONDITION: my_side_bid_count <= 0.5
  CONDITION: partner_last_call != 'X'
  CONDITION: heart_len > 4.5
  CONDITION: hcp <= 7.5
  CONDITION: longest_suit_len <= 5.5
  CONDITION: club_hcp <= 6.5
  # distilled from Brill /bid

RULE BD_False_P242:
  CALL: 2S
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid > 0.5
  CONDITION: spade_len <= 4.5
  CONDITION: rule20_total <= 18.5
  CONDITION: my_side_bid_count <= 0.5
  CONDITION: partner_last_call != 'X'
  CONDITION: heart_len > 4.5
  CONDITION: hcp <= 7.5
  CONDITION: longest_suit_len <= 5.5
  CONDITION: club_hcp > 6.5
  # distilled from Brill /bid

RULE BD_False_P243:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid > 0.5
  CONDITION: spade_len <= 4.5
  CONDITION: rule20_total <= 18.5
  CONDITION: my_side_bid_count <= 0.5
  CONDITION: partner_last_call != 'X'
  CONDITION: heart_len > 4.5
  CONDITION: hcp <= 7.5
  CONDITION: longest_suit_len > 5.5
  CONDITION: hcp <= 5.5
  # distilled from Brill /bid

RULE BD_False_P244:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid > 0.5
  CONDITION: spade_len <= 4.5
  CONDITION: rule20_total <= 18.5
  CONDITION: my_side_bid_count <= 0.5
  CONDITION: partner_last_call != 'X'
  CONDITION: heart_len > 4.5
  CONDITION: hcp <= 7.5
  CONDITION: longest_suit_len > 5.5
  CONDITION: hcp > 5.5
  # distilled from Brill /bid

RULE BD_False_P245:
  CALL: 1H
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid > 0.5
  CONDITION: spade_len <= 4.5
  CONDITION: rule20_total <= 18.5
  CONDITION: my_side_bid_count <= 0.5
  CONDITION: partner_last_call != 'X'
  CONDITION: heart_len > 4.5
  CONDITION: hcp > 7.5
  CONDITION: last_bid_strain == 'D'
  CONDITION: heart_len <= 5.5
  # distilled from Brill /bid

RULE BD_False_P246:
  CALL: 2H
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid > 0.5
  CONDITION: spade_len <= 4.5
  CONDITION: rule20_total <= 18.5
  CONDITION: my_side_bid_count <= 0.5
  CONDITION: partner_last_call != 'X'
  CONDITION: heart_len > 4.5
  CONDITION: hcp > 7.5
  CONDITION: last_bid_strain == 'D'
  CONDITION: heart_len > 5.5
  # distilled from Brill /bid

RULE BD_False_P247:
  CALL: 1H
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid > 0.5
  CONDITION: spade_len <= 4.5
  CONDITION: rule20_total <= 18.5
  CONDITION: my_side_bid_count <= 0.5
  CONDITION: partner_last_call != 'X'
  CONDITION: heart_len > 4.5
  CONDITION: hcp > 7.5
  CONDITION: last_bid_strain != 'D'
  CONDITION: last_bid_strain == 'C'
  # distilled from Brill /bid

RULE BD_False_P248:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid > 0.5
  CONDITION: spade_len <= 4.5
  CONDITION: rule20_total <= 18.5
  CONDITION: my_side_bid_count <= 0.5
  CONDITION: partner_last_call != 'X'
  CONDITION: heart_len > 4.5
  CONDITION: hcp > 7.5
  CONDITION: last_bid_strain != 'D'
  CONDITION: last_bid_strain != 'C'
  # distilled from Brill /bid

RULE BD_False_P249:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid > 0.5
  CONDITION: spade_len <= 4.5
  CONDITION: rule20_total <= 18.5
  CONDITION: my_side_bid_count > 0.5
  CONDITION: hcp <= 6.5
  CONDITION: support_in_partner_suit <= 3.5
  CONDITION: partner_last_bid_strain == 'NONE'
  CONDITION: heart_len <= 4.5
  CONDITION: longest_suit_len <= 5.5
  # distilled from Brill /bid

RULE BD_False_P250:
  CALL: 3C
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid > 0.5
  CONDITION: spade_len <= 4.5
  CONDITION: rule20_total <= 18.5
  CONDITION: my_side_bid_count > 0.5
  CONDITION: hcp <= 6.5
  CONDITION: support_in_partner_suit <= 3.5
  CONDITION: partner_last_bid_strain == 'NONE'
  CONDITION: heart_len <= 4.5
  CONDITION: longest_suit_len > 5.5
  # distilled from Brill /bid

RULE BD_False_P251:
  CALL: 2D
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid > 0.5
  CONDITION: spade_len <= 4.5
  CONDITION: rule20_total <= 18.5
  CONDITION: my_side_bid_count > 0.5
  CONDITION: hcp <= 6.5
  CONDITION: support_in_partner_suit <= 3.5
  CONDITION: partner_last_bid_strain == 'NONE'
  CONDITION: heart_len > 4.5
  CONDITION: auction_len <= 6.5
  # distilled from Brill /bid

RULE BD_False_P252:
  CALL: 2NT
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid > 0.5
  CONDITION: spade_len <= 4.5
  CONDITION: rule20_total <= 18.5
  CONDITION: my_side_bid_count > 0.5
  CONDITION: hcp <= 6.5
  CONDITION: support_in_partner_suit <= 3.5
  CONDITION: partner_last_bid_strain == 'NONE'
  CONDITION: heart_len > 4.5
  CONDITION: auction_len > 6.5
  # distilled from Brill /bid

RULE BD_False_P253:
  CALL: 2C
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid > 0.5
  CONDITION: spade_len <= 4.5
  CONDITION: rule20_total <= 18.5
  CONDITION: my_side_bid_count > 0.5
  CONDITION: hcp <= 6.5
  CONDITION: support_in_partner_suit <= 3.5
  CONDITION: partner_last_bid_strain != 'NONE'
  CONDITION: partner_last_call == 'X'
  CONDITION: last_bid_strain == 'S'
  # distilled from Brill /bid

RULE BD_False_P254:
  CALL: 2C
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid > 0.5
  CONDITION: spade_len <= 4.5
  CONDITION: rule20_total <= 18.5
  CONDITION: my_side_bid_count > 0.5
  CONDITION: hcp <= 6.5
  CONDITION: support_in_partner_suit <= 3.5
  CONDITION: partner_last_bid_strain != 'NONE'
  CONDITION: partner_last_call == 'X'
  CONDITION: last_bid_strain != 'S'
  # distilled from Brill /bid

RULE BD_False_P255:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid > 0.5
  CONDITION: spade_len <= 4.5
  CONDITION: rule20_total <= 18.5
  CONDITION: my_side_bid_count > 0.5
  CONDITION: hcp <= 6.5
  CONDITION: support_in_partner_suit <= 3.5
  CONDITION: partner_last_bid_strain != 'NONE'
  CONDITION: partner_last_call != 'X'
  CONDITION: last_bid_strain == 'NT'
  # distilled from Brill /bid

RULE BD_False_P256:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid > 0.5
  CONDITION: spade_len <= 4.5
  CONDITION: rule20_total <= 18.5
  CONDITION: my_side_bid_count > 0.5
  CONDITION: hcp <= 6.5
  CONDITION: support_in_partner_suit <= 3.5
  CONDITION: partner_last_bid_strain != 'NONE'
  CONDITION: partner_last_call != 'X'
  CONDITION: last_bid_strain != 'NT'
  # distilled from Brill /bid

RULE BD_False_P257:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid > 0.5
  CONDITION: spade_len <= 4.5
  CONDITION: rule20_total <= 18.5
  CONDITION: my_side_bid_count > 0.5
  CONDITION: hcp <= 6.5
  CONDITION: support_in_partner_suit > 3.5
  CONDITION: partner_last_bid_strain == 'S'
  CONDITION: total_points <= 4.5
  CONDITION: diamond_len <= 3.5
  # distilled from Brill /bid

RULE BD_False_P258:
  CALL: 2S
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid > 0.5
  CONDITION: spade_len <= 4.5
  CONDITION: rule20_total <= 18.5
  CONDITION: my_side_bid_count > 0.5
  CONDITION: hcp <= 6.5
  CONDITION: support_in_partner_suit > 3.5
  CONDITION: partner_last_bid_strain == 'S'
  CONDITION: total_points <= 4.5
  CONDITION: diamond_len > 3.5
  # distilled from Brill /bid

RULE BD_False_P259:
  CALL: 2S
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid > 0.5
  CONDITION: spade_len <= 4.5
  CONDITION: rule20_total <= 18.5
  CONDITION: my_side_bid_count > 0.5
  CONDITION: hcp <= 6.5
  CONDITION: support_in_partner_suit > 3.5
  CONDITION: partner_last_bid_strain == 'S'
  CONDITION: total_points > 4.5
  CONDITION: last_bid_seat == 'N'
  # distilled from Brill /bid

RULE BD_False_P260:
  CALL: 3S
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid > 0.5
  CONDITION: spade_len <= 4.5
  CONDITION: rule20_total <= 18.5
  CONDITION: my_side_bid_count > 0.5
  CONDITION: hcp <= 6.5
  CONDITION: support_in_partner_suit > 3.5
  CONDITION: partner_last_bid_strain == 'S'
  CONDITION: total_points > 4.5
  CONDITION: last_bid_seat != 'N'
  # distilled from Brill /bid

RULE BD_False_P261:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid > 0.5
  CONDITION: spade_len <= 4.5
  CONDITION: rule20_total <= 18.5
  CONDITION: my_side_bid_count > 0.5
  CONDITION: hcp <= 6.5
  CONDITION: support_in_partner_suit > 3.5
  CONDITION: partner_last_bid_strain != 'S'
  CONDITION: total_points <= 5.5
  CONDITION: partner_first_call == '1D'
  # distilled from Brill /bid

RULE BD_False_P262:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid > 0.5
  CONDITION: spade_len <= 4.5
  CONDITION: rule20_total <= 18.5
  CONDITION: my_side_bid_count > 0.5
  CONDITION: hcp <= 6.5
  CONDITION: support_in_partner_suit > 3.5
  CONDITION: partner_last_bid_strain != 'S'
  CONDITION: total_points <= 5.5
  CONDITION: partner_first_call != '1D'
  # distilled from Brill /bid

RULE BD_False_P263:
  CALL: 3H
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid > 0.5
  CONDITION: spade_len <= 4.5
  CONDITION: rule20_total <= 18.5
  CONDITION: my_side_bid_count > 0.5
  CONDITION: hcp <= 6.5
  CONDITION: support_in_partner_suit > 3.5
  CONDITION: partner_last_bid_strain != 'S'
  CONDITION: total_points > 5.5
  CONDITION: partner_last_call == '1H'
  # distilled from Brill /bid

RULE BD_False_P264:
  CALL: X
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid > 0.5
  CONDITION: spade_len <= 4.5
  CONDITION: rule20_total <= 18.5
  CONDITION: my_side_bid_count > 0.5
  CONDITION: hcp <= 6.5
  CONDITION: support_in_partner_suit > 3.5
  CONDITION: partner_last_bid_strain != 'S'
  CONDITION: total_points > 5.5
  CONDITION: partner_last_call != '1H'
  # distilled from Brill /bid

RULE BD_False_P265:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid > 0.5
  CONDITION: spade_len <= 4.5
  CONDITION: rule20_total <= 18.5
  CONDITION: my_side_bid_count > 0.5
  CONDITION: hcp > 6.5
  CONDITION: support_in_partner_suit <= 2.5
  CONDITION: partner_last_bid_strain == 'NONE'
  CONDITION: heart_len <= 4.5
  CONDITION: hcp <= 7.5
  # distilled from Brill /bid

RULE BD_False_P266:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid > 0.5
  CONDITION: spade_len <= 4.5
  CONDITION: rule20_total <= 18.5
  CONDITION: my_side_bid_count > 0.5
  CONDITION: hcp > 6.5
  CONDITION: support_in_partner_suit <= 2.5
  CONDITION: partner_last_bid_strain == 'NONE'
  CONDITION: heart_len <= 4.5
  CONDITION: hcp > 7.5
  # distilled from Brill /bid

RULE BD_False_P267:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid > 0.5
  CONDITION: spade_len <= 4.5
  CONDITION: rule20_total <= 18.5
  CONDITION: my_side_bid_count > 0.5
  CONDITION: hcp > 6.5
  CONDITION: support_in_partner_suit <= 2.5
  CONDITION: partner_last_bid_strain == 'NONE'
  CONDITION: heart_len > 4.5
  CONDITION: my_last_call == '1H'
  # distilled from Brill /bid

RULE BD_False_P268:
  CALL: 2D
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid > 0.5
  CONDITION: spade_len <= 4.5
  CONDITION: rule20_total <= 18.5
  CONDITION: my_side_bid_count > 0.5
  CONDITION: hcp > 6.5
  CONDITION: support_in_partner_suit <= 2.5
  CONDITION: partner_last_bid_strain == 'NONE'
  CONDITION: heart_len > 4.5
  CONDITION: my_last_call != '1H'
  # distilled from Brill /bid

RULE BD_False_P269:
  CALL: X
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid > 0.5
  CONDITION: spade_len <= 4.5
  CONDITION: rule20_total <= 18.5
  CONDITION: my_side_bid_count > 0.5
  CONDITION: hcp > 6.5
  CONDITION: support_in_partner_suit <= 2.5
  CONDITION: partner_last_bid_strain != 'NONE'
  CONDITION: competition_level <= 2.5
  CONDITION: passes_since_last_bid <= 0.5
  # distilled from Brill /bid

RULE BD_False_P270:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid > 0.5
  CONDITION: spade_len <= 4.5
  CONDITION: rule20_total <= 18.5
  CONDITION: my_side_bid_count > 0.5
  CONDITION: hcp > 6.5
  CONDITION: support_in_partner_suit <= 2.5
  CONDITION: partner_last_bid_strain != 'NONE'
  CONDITION: competition_level <= 2.5
  CONDITION: passes_since_last_bid > 0.5
  # distilled from Brill /bid

RULE BD_False_P271:
  CALL: 2H
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid > 0.5
  CONDITION: spade_len <= 4.5
  CONDITION: rule20_total <= 18.5
  CONDITION: my_side_bid_count > 0.5
  CONDITION: hcp > 6.5
  CONDITION: support_in_partner_suit <= 2.5
  CONDITION: partner_last_bid_strain != 'NONE'
  CONDITION: competition_level > 2.5
  CONDITION: my_last_call == '1H'
  # distilled from Brill /bid

RULE BD_False_P272:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid > 0.5
  CONDITION: spade_len <= 4.5
  CONDITION: rule20_total <= 18.5
  CONDITION: my_side_bid_count > 0.5
  CONDITION: hcp > 6.5
  CONDITION: support_in_partner_suit <= 2.5
  CONDITION: partner_last_bid_strain != 'NONE'
  CONDITION: competition_level > 2.5
  CONDITION: my_last_call != '1H'
  # distilled from Brill /bid

RULE BD_False_P273:
  CALL: 2S
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid > 0.5
  CONDITION: spade_len <= 4.5
  CONDITION: rule20_total <= 18.5
  CONDITION: my_side_bid_count > 0.5
  CONDITION: hcp > 6.5
  CONDITION: support_in_partner_suit > 2.5
  CONDITION: partner_last_call == '1S'
  CONDITION: hcp <= 9.5
  CONDITION: spade_len <= 3.5
  # distilled from Brill /bid

RULE BD_False_P274:
  CALL: 2S
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid > 0.5
  CONDITION: spade_len <= 4.5
  CONDITION: rule20_total <= 18.5
  CONDITION: my_side_bid_count > 0.5
  CONDITION: hcp > 6.5
  CONDITION: support_in_partner_suit > 2.5
  CONDITION: partner_last_call == '1S'
  CONDITION: hcp <= 9.5
  CONDITION: spade_len > 3.5
  # distilled from Brill /bid

RULE BD_False_P275:
  CALL: 2C
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid > 0.5
  CONDITION: spade_len <= 4.5
  CONDITION: rule20_total <= 18.5
  CONDITION: my_side_bid_count > 0.5
  CONDITION: hcp > 6.5
  CONDITION: support_in_partner_suit > 2.5
  CONDITION: partner_last_call == '1S'
  CONDITION: hcp > 9.5
  CONDITION: opp_last_call == '1C'
  # distilled from Brill /bid

RULE BD_False_P276:
  CALL: 2H
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid > 0.5
  CONDITION: spade_len <= 4.5
  CONDITION: rule20_total <= 18.5
  CONDITION: my_side_bid_count > 0.5
  CONDITION: hcp > 6.5
  CONDITION: support_in_partner_suit > 2.5
  CONDITION: partner_last_call == '1S'
  CONDITION: hcp > 9.5
  CONDITION: opp_last_call != '1C'
  # distilled from Brill /bid

RULE BD_False_P277:
  CALL: 2H
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid > 0.5
  CONDITION: spade_len <= 4.5
  CONDITION: rule20_total <= 18.5
  CONDITION: my_side_bid_count > 0.5
  CONDITION: hcp > 6.5
  CONDITION: support_in_partner_suit > 2.5
  CONDITION: partner_last_call != '1S'
  CONDITION: partner_last_call == '1H'
  CONDITION: total_points <= 9.5
  # distilled from Brill /bid

RULE BD_False_P278:
  CALL: 2S
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid > 0.5
  CONDITION: spade_len <= 4.5
  CONDITION: rule20_total <= 18.5
  CONDITION: my_side_bid_count > 0.5
  CONDITION: hcp > 6.5
  CONDITION: support_in_partner_suit > 2.5
  CONDITION: partner_last_call != '1S'
  CONDITION: partner_last_call == '1H'
  CONDITION: total_points > 9.5
  # distilled from Brill /bid

RULE BD_False_P279:
  CALL: 1H
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid > 0.5
  CONDITION: spade_len <= 4.5
  CONDITION: rule20_total <= 18.5
  CONDITION: my_side_bid_count > 0.5
  CONDITION: hcp > 6.5
  CONDITION: support_in_partner_suit > 2.5
  CONDITION: partner_last_call != '1S'
  CONDITION: partner_last_call != '1H'
  CONDITION: last_bid_strain == 'D'
  # distilled from Brill /bid

RULE BD_False_P280:
  CALL: X
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid > 0.5
  CONDITION: spade_len <= 4.5
  CONDITION: rule20_total <= 18.5
  CONDITION: my_side_bid_count > 0.5
  CONDITION: hcp > 6.5
  CONDITION: support_in_partner_suit > 2.5
  CONDITION: partner_last_call != '1S'
  CONDITION: partner_last_call != '1H'
  CONDITION: last_bid_strain != 'D'
  # distilled from Brill /bid

RULE BD_False_P281:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid > 0.5
  CONDITION: spade_len <= 4.5
  CONDITION: rule20_total > 18.5
  CONDITION: heart_len <= 4.5
  CONDITION: longest_suit_len <= 5.5
  CONDITION: my_side_bid_count <= 0.5
  CONDITION: hcp <= 14.5
  CONDITION: diamond_len <= 4.5
  CONDITION: club_len <= 4.5
  # distilled from Brill /bid

RULE BD_False_P282:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid > 0.5
  CONDITION: spade_len <= 4.5
  CONDITION: rule20_total > 18.5
  CONDITION: heart_len <= 4.5
  CONDITION: longest_suit_len <= 5.5
  CONDITION: my_side_bid_count <= 0.5
  CONDITION: hcp <= 14.5
  CONDITION: diamond_len <= 4.5
  CONDITION: club_len > 4.5
  # distilled from Brill /bid

RULE BD_False_P283:
  CALL: 1D
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid > 0.5
  CONDITION: spade_len <= 4.5
  CONDITION: rule20_total > 18.5
  CONDITION: heart_len <= 4.5
  CONDITION: longest_suit_len <= 5.5
  CONDITION: my_side_bid_count <= 0.5
  CONDITION: hcp <= 14.5
  CONDITION: diamond_len > 4.5
  CONDITION: last_bid_strain == 'C'
  # distilled from Brill /bid

RULE BD_False_P284:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid > 0.5
  CONDITION: spade_len <= 4.5
  CONDITION: rule20_total > 18.5
  CONDITION: heart_len <= 4.5
  CONDITION: longest_suit_len <= 5.5
  CONDITION: my_side_bid_count <= 0.5
  CONDITION: hcp <= 14.5
  CONDITION: diamond_len > 4.5
  CONDITION: last_bid_strain != 'C'
  # distilled from Brill /bid

RULE BD_False_P285:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid > 0.5
  CONDITION: spade_len <= 4.5
  CONDITION: rule20_total > 18.5
  CONDITION: heart_len <= 4.5
  CONDITION: longest_suit_len <= 5.5
  CONDITION: my_side_bid_count <= 0.5
  CONDITION: hcp > 14.5
  CONDITION: total_points <= 17.5
  CONDITION: last_bid_strain == 'NT'
  # distilled from Brill /bid

RULE BD_False_P286:
  CALL: 1NT
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid > 0.5
  CONDITION: spade_len <= 4.5
  CONDITION: rule20_total > 18.5
  CONDITION: heart_len <= 4.5
  CONDITION: longest_suit_len <= 5.5
  CONDITION: my_side_bid_count <= 0.5
  CONDITION: hcp > 14.5
  CONDITION: total_points <= 17.5
  CONDITION: last_bid_strain != 'NT'
  # distilled from Brill /bid

RULE BD_False_P287:
  CALL: X
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid > 0.5
  CONDITION: spade_len <= 4.5
  CONDITION: rule20_total > 18.5
  CONDITION: heart_len <= 4.5
  CONDITION: longest_suit_len <= 5.5
  CONDITION: my_side_bid_count <= 0.5
  CONDITION: hcp > 14.5
  CONDITION: total_points > 17.5
  CONDITION: hcp <= 17.5
  # distilled from Brill /bid

RULE BD_False_P288:
  CALL: X
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid > 0.5
  CONDITION: spade_len <= 4.5
  CONDITION: rule20_total > 18.5
  CONDITION: heart_len <= 4.5
  CONDITION: longest_suit_len <= 5.5
  CONDITION: my_side_bid_count <= 0.5
  CONDITION: hcp > 14.5
  CONDITION: total_points > 17.5
  CONDITION: hcp > 17.5
  # distilled from Brill /bid

RULE BD_False_P289:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid > 0.5
  CONDITION: spade_len <= 4.5
  CONDITION: rule20_total > 18.5
  CONDITION: heart_len <= 4.5
  CONDITION: longest_suit_len <= 5.5
  CONDITION: my_side_bid_count > 0.5
  CONDITION: partner_last_call == 'PASS'
  CONDITION: total_points <= 17.5
  CONDITION: partner_first_call == 'PASS'
  # distilled from Brill /bid

RULE BD_False_P290:
  CALL: 3NT
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid > 0.5
  CONDITION: spade_len <= 4.5
  CONDITION: rule20_total > 18.5
  CONDITION: heart_len <= 4.5
  CONDITION: longest_suit_len <= 5.5
  CONDITION: my_side_bid_count > 0.5
  CONDITION: partner_last_call == 'PASS'
  CONDITION: total_points <= 17.5
  CONDITION: partner_first_call != 'PASS'
  # distilled from Brill /bid

RULE BD_False_P291:
  CALL: 1NT
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid > 0.5
  CONDITION: spade_len <= 4.5
  CONDITION: rule20_total > 18.5
  CONDITION: heart_len <= 4.5
  CONDITION: longest_suit_len <= 5.5
  CONDITION: my_side_bid_count > 0.5
  CONDITION: partner_last_call == 'PASS'
  CONDITION: total_points > 17.5
  CONDITION: competition_level <= 2.5
  # distilled from Brill /bid

RULE BD_False_P292:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid > 0.5
  CONDITION: spade_len <= 4.5
  CONDITION: rule20_total > 18.5
  CONDITION: heart_len <= 4.5
  CONDITION: longest_suit_len <= 5.5
  CONDITION: my_side_bid_count > 0.5
  CONDITION: partner_last_call == 'PASS'
  CONDITION: total_points > 17.5
  CONDITION: competition_level > 2.5
  # distilled from Brill /bid

RULE BD_False_P293:
  CALL: X
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid > 0.5
  CONDITION: spade_len <= 4.5
  CONDITION: rule20_total > 18.5
  CONDITION: heart_len <= 4.5
  CONDITION: longest_suit_len <= 5.5
  CONDITION: my_side_bid_count > 0.5
  CONDITION: partner_last_call != 'PASS'
  CONDITION: passes_since_last_bid <= 0.5
  CONDITION: support_in_partner_suit <= 3.5
  # distilled from Brill /bid

RULE BD_False_P294:
  CALL: 2H
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid > 0.5
  CONDITION: spade_len <= 4.5
  CONDITION: rule20_total > 18.5
  CONDITION: heart_len <= 4.5
  CONDITION: longest_suit_len <= 5.5
  CONDITION: my_side_bid_count > 0.5
  CONDITION: partner_last_call != 'PASS'
  CONDITION: passes_since_last_bid <= 0.5
  CONDITION: support_in_partner_suit > 3.5
  # distilled from Brill /bid

RULE BD_False_P295:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid > 0.5
  CONDITION: spade_len <= 4.5
  CONDITION: rule20_total > 18.5
  CONDITION: heart_len <= 4.5
  CONDITION: longest_suit_len <= 5.5
  CONDITION: my_side_bid_count > 0.5
  CONDITION: partner_last_call != 'PASS'
  CONDITION: passes_since_last_bid > 0.5
  CONDITION: last_bid_strain == 'NT'
  # distilled from Brill /bid

RULE BD_False_P296:
  CALL: 1NT
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid > 0.5
  CONDITION: spade_len <= 4.5
  CONDITION: rule20_total > 18.5
  CONDITION: heart_len <= 4.5
  CONDITION: longest_suit_len <= 5.5
  CONDITION: my_side_bid_count > 0.5
  CONDITION: partner_last_call != 'PASS'
  CONDITION: passes_since_last_bid > 0.5
  CONDITION: last_bid_strain != 'NT'
  # distilled from Brill /bid

RULE BD_False_P297:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid > 0.5
  CONDITION: spade_len <= 4.5
  CONDITION: rule20_total > 18.5
  CONDITION: heart_len <= 4.5
  CONDITION: longest_suit_len > 5.5
  CONDITION: diamond_len <= 4.5
  CONDITION: hcp <= 11.5
  CONDITION: my_side_bid_count <= 0.5
  CONDITION: club_len <= 6.5
  # distilled from Brill /bid

RULE BD_False_P298:
  CALL: 4C
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid > 0.5
  CONDITION: spade_len <= 4.5
  CONDITION: rule20_total > 18.5
  CONDITION: heart_len <= 4.5
  CONDITION: longest_suit_len > 5.5
  CONDITION: diamond_len <= 4.5
  CONDITION: hcp <= 11.5
  CONDITION: my_side_bid_count <= 0.5
  CONDITION: club_len > 6.5
  # distilled from Brill /bid

RULE BD_False_P299:
  CALL: X
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid > 0.5
  CONDITION: spade_len <= 4.5
  CONDITION: rule20_total > 18.5
  CONDITION: heart_len <= 4.5
  CONDITION: longest_suit_len > 5.5
  CONDITION: diamond_len <= 4.5
  CONDITION: hcp <= 11.5
  CONDITION: my_side_bid_count > 0.5
  CONDITION: competition_level <= 2.5
  # distilled from Brill /bid

RULE BD_False_P300:
  CALL: 2C
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid > 0.5
  CONDITION: spade_len <= 4.5
  CONDITION: rule20_total > 18.5
  CONDITION: heart_len <= 4.5
  CONDITION: longest_suit_len > 5.5
  CONDITION: diamond_len <= 4.5
  CONDITION: hcp <= 11.5
  CONDITION: my_side_bid_count > 0.5
  CONDITION: competition_level > 2.5
  # distilled from Brill /bid

RULE BD_False_P301:
  CALL: 2C
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid > 0.5
  CONDITION: spade_len <= 4.5
  CONDITION: rule20_total > 18.5
  CONDITION: heart_len <= 4.5
  CONDITION: longest_suit_len > 5.5
  CONDITION: diamond_len <= 4.5
  CONDITION: hcp > 11.5
  CONDITION: hcp <= 15.5
  CONDITION: support_in_partner_suit <= 2.5
  # distilled from Brill /bid

RULE BD_False_P302:
  CALL: X
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid > 0.5
  CONDITION: spade_len <= 4.5
  CONDITION: rule20_total > 18.5
  CONDITION: heart_len <= 4.5
  CONDITION: longest_suit_len > 5.5
  CONDITION: diamond_len <= 4.5
  CONDITION: hcp > 11.5
  CONDITION: hcp <= 15.5
  CONDITION: support_in_partner_suit > 2.5
  # distilled from Brill /bid

RULE BD_False_P303:
  CALL: 3C
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid > 0.5
  CONDITION: spade_len <= 4.5
  CONDITION: rule20_total > 18.5
  CONDITION: heart_len <= 4.5
  CONDITION: longest_suit_len > 5.5
  CONDITION: diamond_len <= 4.5
  CONDITION: hcp > 11.5
  CONDITION: hcp > 15.5
  CONDITION: my_last_call == '1C'
  # distilled from Brill /bid

RULE BD_False_P304:
  CALL: X
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid > 0.5
  CONDITION: spade_len <= 4.5
  CONDITION: rule20_total > 18.5
  CONDITION: heart_len <= 4.5
  CONDITION: longest_suit_len > 5.5
  CONDITION: diamond_len <= 4.5
  CONDITION: hcp > 11.5
  CONDITION: hcp > 15.5
  CONDITION: my_last_call != '1C'
  # distilled from Brill /bid

RULE BD_False_P305:
  CALL: 4D
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid > 0.5
  CONDITION: spade_len <= 4.5
  CONDITION: rule20_total > 18.5
  CONDITION: heart_len <= 4.5
  CONDITION: longest_suit_len > 5.5
  CONDITION: diamond_len > 4.5
  CONDITION: last_bid_strain == 'C'
  CONDITION: hcp <= 11.5
  CONDITION: is_vulnerable <= 0.5
  # distilled from Brill /bid

RULE BD_False_P306:
  CALL: 2D
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid > 0.5
  CONDITION: spade_len <= 4.5
  CONDITION: rule20_total > 18.5
  CONDITION: heart_len <= 4.5
  CONDITION: longest_suit_len > 5.5
  CONDITION: diamond_len > 4.5
  CONDITION: last_bid_strain == 'C'
  CONDITION: hcp <= 11.5
  CONDITION: is_vulnerable > 0.5
  # distilled from Brill /bid

RULE BD_False_P307:
  CALL: 1D
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid > 0.5
  CONDITION: spade_len <= 4.5
  CONDITION: rule20_total > 18.5
  CONDITION: heart_len <= 4.5
  CONDITION: longest_suit_len > 5.5
  CONDITION: diamond_len > 4.5
  CONDITION: last_bid_strain == 'C'
  CONDITION: hcp > 11.5
  CONDITION: passes_since_last_bid <= 1.0
  # distilled from Brill /bid

RULE BD_False_P308:
  CALL: 2D
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid > 0.5
  CONDITION: spade_len <= 4.5
  CONDITION: rule20_total > 18.5
  CONDITION: heart_len <= 4.5
  CONDITION: longest_suit_len > 5.5
  CONDITION: diamond_len > 4.5
  CONDITION: last_bid_strain == 'C'
  CONDITION: hcp > 11.5
  CONDITION: passes_since_last_bid > 1.0
  # distilled from Brill /bid

RULE BD_False_P309:
  CALL: 2C
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid > 0.5
  CONDITION: spade_len <= 4.5
  CONDITION: rule20_total > 18.5
  CONDITION: heart_len <= 4.5
  CONDITION: longest_suit_len > 5.5
  CONDITION: diamond_len > 4.5
  CONDITION: last_bid_strain != 'C'
  CONDITION: opening_bid == '1NT'
  CONDITION: second_longest_len <= 3.5
  # distilled from Brill /bid

RULE BD_False_P310:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid > 0.5
  CONDITION: spade_len <= 4.5
  CONDITION: rule20_total > 18.5
  CONDITION: heart_len <= 4.5
  CONDITION: longest_suit_len > 5.5
  CONDITION: diamond_len > 4.5
  CONDITION: last_bid_strain != 'C'
  CONDITION: opening_bid == '1NT'
  CONDITION: second_longest_len > 3.5
  # distilled from Brill /bid

RULE BD_False_P311:
  CALL: 2D
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid > 0.5
  CONDITION: spade_len <= 4.5
  CONDITION: rule20_total > 18.5
  CONDITION: heart_len <= 4.5
  CONDITION: longest_suit_len > 5.5
  CONDITION: diamond_len > 4.5
  CONDITION: last_bid_strain != 'C'
  CONDITION: opening_bid != '1NT'
  CONDITION: losing_trick_count <= 5.5
  # distilled from Brill /bid

RULE BD_False_P312:
  CALL: 2D
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid > 0.5
  CONDITION: spade_len <= 4.5
  CONDITION: rule20_total > 18.5
  CONDITION: heart_len <= 4.5
  CONDITION: longest_suit_len > 5.5
  CONDITION: diamond_len > 4.5
  CONDITION: last_bid_strain != 'C'
  CONDITION: opening_bid != '1NT'
  CONDITION: losing_trick_count > 5.5
  # distilled from Brill /bid

RULE BD_False_P313:
  CALL: 2H
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid > 0.5
  CONDITION: spade_len <= 4.5
  CONDITION: rule20_total > 18.5
  CONDITION: heart_len > 4.5
  CONDITION: last_bid_strain == 'S'
  CONDITION: second_longest_len <= 4.5
  CONDITION: heart_len <= 5.5
  CONDITION: passes_since_last_bid <= 0.5
  CONDITION: my_last_call == 'PASS'
  # distilled from Brill /bid

RULE BD_False_P314:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid > 0.5
  CONDITION: spade_len <= 4.5
  CONDITION: rule20_total > 18.5
  CONDITION: heart_len > 4.5
  CONDITION: last_bid_strain == 'S'
  CONDITION: second_longest_len <= 4.5
  CONDITION: heart_len <= 5.5
  CONDITION: passes_since_last_bid <= 0.5
  CONDITION: my_last_call != 'PASS'
  # distilled from Brill /bid

RULE BD_False_P315:
  CALL: 2C
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid > 0.5
  CONDITION: spade_len <= 4.5
  CONDITION: rule20_total > 18.5
  CONDITION: heart_len > 4.5
  CONDITION: last_bid_strain == 'S'
  CONDITION: second_longest_len <= 4.5
  CONDITION: heart_len <= 5.5
  CONDITION: passes_since_last_bid > 0.5
  CONDITION: d_is_best_minor <= 0.5
  # distilled from Brill /bid

RULE BD_False_P316:
  CALL: 1NT
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid > 0.5
  CONDITION: spade_len <= 4.5
  CONDITION: rule20_total > 18.5
  CONDITION: heart_len > 4.5
  CONDITION: last_bid_strain == 'S'
  CONDITION: second_longest_len <= 4.5
  CONDITION: heart_len <= 5.5
  CONDITION: passes_since_last_bid > 0.5
  CONDITION: d_is_best_minor > 0.5
  # distilled from Brill /bid

RULE BD_False_P317:
  CALL: 2H
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid > 0.5
  CONDITION: spade_len <= 4.5
  CONDITION: rule20_total > 18.5
  CONDITION: heart_len > 4.5
  CONDITION: last_bid_strain == 'S'
  CONDITION: second_longest_len <= 4.5
  CONDITION: heart_len > 5.5
  CONDITION: heart_len <= 6.5
  CONDITION: partner_last_bid_strain == 'NONE'
  # distilled from Brill /bid

RULE BD_False_P318:
  CALL: 2H
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid > 0.5
  CONDITION: spade_len <= 4.5
  CONDITION: rule20_total > 18.5
  CONDITION: heart_len > 4.5
  CONDITION: last_bid_strain == 'S'
  CONDITION: second_longest_len <= 4.5
  CONDITION: heart_len > 5.5
  CONDITION: heart_len <= 6.5
  CONDITION: partner_last_bid_strain != 'NONE'
  # distilled from Brill /bid

RULE BD_False_P319:
  CALL: 4H
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid > 0.5
  CONDITION: spade_len <= 4.5
  CONDITION: rule20_total > 18.5
  CONDITION: heart_len > 4.5
  CONDITION: last_bid_strain == 'S'
  CONDITION: second_longest_len <= 4.5
  CONDITION: heart_len > 5.5
  CONDITION: heart_len > 6.5
  CONDITION: queen_count <= 1.5
  # distilled from Brill /bid

RULE BD_False_P320:
  CALL: 2H
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid > 0.5
  CONDITION: spade_len <= 4.5
  CONDITION: rule20_total > 18.5
  CONDITION: heart_len > 4.5
  CONDITION: last_bid_strain == 'S'
  CONDITION: second_longest_len <= 4.5
  CONDITION: heart_len > 5.5
  CONDITION: heart_len > 6.5
  CONDITION: queen_count > 1.5
  # distilled from Brill /bid

RULE BD_False_P321:
  CALL: 2S
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid > 0.5
  CONDITION: spade_len <= 4.5
  CONDITION: rule20_total > 18.5
  CONDITION: heart_len > 4.5
  CONDITION: last_bid_strain == 'S'
  CONDITION: second_longest_len > 4.5
  CONDITION: opening_bid == '1S'
  CONDITION: passes_since_last_bid <= 1.0
  # distilled from Brill /bid

RULE BD_False_P322:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid > 0.5
  CONDITION: spade_len <= 4.5
  CONDITION: rule20_total > 18.5
  CONDITION: heart_len > 4.5
  CONDITION: last_bid_strain == 'S'
  CONDITION: second_longest_len > 4.5
  CONDITION: opening_bid == '1S'
  CONDITION: passes_since_last_bid > 1.0
  CONDITION: hcp <= 11.5
  # distilled from Brill /bid

RULE BD_False_P323:
  CALL: 2H
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid > 0.5
  CONDITION: spade_len <= 4.5
  CONDITION: rule20_total > 18.5
  CONDITION: heart_len > 4.5
  CONDITION: last_bid_strain == 'S'
  CONDITION: second_longest_len > 4.5
  CONDITION: opening_bid == '1S'
  CONDITION: passes_since_last_bid > 1.0
  CONDITION: hcp > 11.5
  # distilled from Brill /bid

RULE BD_False_P324:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid > 0.5
  CONDITION: spade_len <= 4.5
  CONDITION: rule20_total > 18.5
  CONDITION: heart_len > 4.5
  CONDITION: last_bid_strain == 'S'
  CONDITION: second_longest_len > 4.5
  CONDITION: opening_bid != '1S'
  CONDITION: my_side_bid_count <= 0.5
  CONDITION: d_top2_honors <= 0.5
  # distilled from Brill /bid

RULE BD_False_P325:
  CALL: 2NT
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid > 0.5
  CONDITION: spade_len <= 4.5
  CONDITION: rule20_total > 18.5
  CONDITION: heart_len > 4.5
  CONDITION: last_bid_strain == 'S'
  CONDITION: second_longest_len > 4.5
  CONDITION: opening_bid != '1S'
  CONDITION: my_side_bid_count <= 0.5
  CONDITION: d_top2_honors > 0.5
  # distilled from Brill /bid

RULE BD_False_P326:
  CALL: X
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid > 0.5
  CONDITION: spade_len <= 4.5
  CONDITION: rule20_total > 18.5
  CONDITION: heart_len > 4.5
  CONDITION: last_bid_strain == 'S'
  CONDITION: second_longest_len > 4.5
  CONDITION: opening_bid != '1S'
  CONDITION: my_side_bid_count > 0.5
  CONDITION: minor_hcp <= 4.5
  # distilled from Brill /bid

RULE BD_False_P327:
  CALL: 2H
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid > 0.5
  CONDITION: spade_len <= 4.5
  CONDITION: rule20_total > 18.5
  CONDITION: heart_len > 4.5
  CONDITION: last_bid_strain == 'S'
  CONDITION: second_longest_len > 4.5
  CONDITION: opening_bid != '1S'
  CONDITION: my_side_bid_count > 0.5
  CONDITION: minor_hcp > 4.5
  # distilled from Brill /bid

RULE BD_False_P328:
  CALL: 2H
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid > 0.5
  CONDITION: spade_len <= 4.5
  CONDITION: rule20_total > 18.5
  CONDITION: heart_len > 4.5
  CONDITION: last_bid_strain != 'S'
  CONDITION: last_bid_strain == 'NT'
  CONDITION: heart_len <= 5.5
  CONDITION: auction_len <= 3.5
  CONDITION: losing_trick_count <= 6.5
  # distilled from Brill /bid

RULE BD_False_P329:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid > 0.5
  CONDITION: spade_len <= 4.5
  CONDITION: rule20_total > 18.5
  CONDITION: heart_len > 4.5
  CONDITION: last_bid_strain != 'S'
  CONDITION: last_bid_strain == 'NT'
  CONDITION: heart_len <= 5.5
  CONDITION: auction_len <= 3.5
  CONDITION: losing_trick_count > 6.5
  # distilled from Brill /bid

RULE BD_False_P330:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid > 0.5
  CONDITION: spade_len <= 4.5
  CONDITION: rule20_total > 18.5
  CONDITION: heart_len > 4.5
  CONDITION: last_bid_strain != 'S'
  CONDITION: last_bid_strain == 'NT'
  CONDITION: heart_len <= 5.5
  CONDITION: auction_len > 3.5
  CONDITION: opp_last_call == '1NT'
  # distilled from Brill /bid

RULE BD_False_P331:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid > 0.5
  CONDITION: spade_len <= 4.5
  CONDITION: rule20_total > 18.5
  CONDITION: heart_len > 4.5
  CONDITION: last_bid_strain != 'S'
  CONDITION: last_bid_strain == 'NT'
  CONDITION: heart_len <= 5.5
  CONDITION: auction_len > 3.5
  CONDITION: opp_last_call != '1NT'
  # distilled from Brill /bid

RULE BD_False_P332:
  CALL: 2C
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid > 0.5
  CONDITION: spade_len <= 4.5
  CONDITION: rule20_total > 18.5
  CONDITION: heart_len > 4.5
  CONDITION: last_bid_strain != 'S'
  CONDITION: last_bid_strain == 'NT'
  CONDITION: heart_len > 5.5
  CONDITION: opening_bid == '1NT'
  CONDITION: second_longest_len <= 3.5
  # distilled from Brill /bid

RULE BD_False_P333:
  CALL: 2H
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid > 0.5
  CONDITION: spade_len <= 4.5
  CONDITION: rule20_total > 18.5
  CONDITION: heart_len > 4.5
  CONDITION: last_bid_strain != 'S'
  CONDITION: last_bid_strain == 'NT'
  CONDITION: heart_len > 5.5
  CONDITION: opening_bid == '1NT'
  CONDITION: second_longest_len > 3.5
  # distilled from Brill /bid

RULE BD_False_P334:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid > 0.5
  CONDITION: spade_len <= 4.5
  CONDITION: rule20_total > 18.5
  CONDITION: heart_len > 4.5
  CONDITION: last_bid_strain != 'S'
  CONDITION: last_bid_strain == 'NT'
  CONDITION: heart_len > 5.5
  CONDITION: opening_bid != '1NT'
  CONDITION: partner_last_call == 'PASS'
  # distilled from Brill /bid

RULE BD_False_P335:
  CALL: 2H
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid > 0.5
  CONDITION: spade_len <= 4.5
  CONDITION: rule20_total > 18.5
  CONDITION: heart_len > 4.5
  CONDITION: last_bid_strain != 'S'
  CONDITION: last_bid_strain == 'NT'
  CONDITION: heart_len > 5.5
  CONDITION: opening_bid != '1NT'
  CONDITION: partner_last_call != 'PASS'
  # distilled from Brill /bid

RULE BD_False_P336:
  CALL: 1NT
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid > 0.5
  CONDITION: spade_len <= 4.5
  CONDITION: rule20_total > 18.5
  CONDITION: heart_len > 4.5
  CONDITION: last_bid_strain != 'S'
  CONDITION: last_bid_strain != 'NT'
  CONDITION: last_bid_strain == 'H'
  CONDITION: opp_first_call == 'PASS'
  CONDITION: auction_len <= 4.5
  # distilled from Brill /bid

RULE BD_False_P337:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid > 0.5
  CONDITION: spade_len <= 4.5
  CONDITION: rule20_total > 18.5
  CONDITION: heart_len > 4.5
  CONDITION: last_bid_strain != 'S'
  CONDITION: last_bid_strain != 'NT'
  CONDITION: last_bid_strain == 'H'
  CONDITION: opp_first_call == 'PASS'
  CONDITION: auction_len > 4.5
  # distilled from Brill /bid

RULE BD_False_P338:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid > 0.5
  CONDITION: spade_len <= 4.5
  CONDITION: rule20_total > 18.5
  CONDITION: heart_len > 4.5
  CONDITION: last_bid_strain != 'S'
  CONDITION: last_bid_strain != 'NT'
  CONDITION: last_bid_strain == 'H'
  CONDITION: opp_first_call != 'PASS'
  CONDITION: h_has_ten <= 0.5
  # distilled from Brill /bid

RULE BD_False_P339:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid > 0.5
  CONDITION: spade_len <= 4.5
  CONDITION: rule20_total > 18.5
  CONDITION: heart_len > 4.5
  CONDITION: last_bid_strain != 'S'
  CONDITION: last_bid_strain != 'NT'
  CONDITION: last_bid_strain == 'H'
  CONDITION: opp_first_call != 'PASS'
  CONDITION: h_has_ten > 0.5
  # distilled from Brill /bid

RULE BD_False_P340:
  CALL: 1H
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid > 0.5
  CONDITION: spade_len <= 4.5
  CONDITION: rule20_total > 18.5
  CONDITION: heart_len > 4.5
  CONDITION: last_bid_strain != 'S'
  CONDITION: last_bid_strain != 'NT'
  CONDITION: last_bid_strain != 'H'
  CONDITION: second_longest_len <= 4.5
  CONDITION: heart_len <= 5.5
  # distilled from Brill /bid

RULE BD_False_P341:
  CALL: 1H
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid > 0.5
  CONDITION: spade_len <= 4.5
  CONDITION: rule20_total > 18.5
  CONDITION: heart_len > 4.5
  CONDITION: last_bid_strain != 'S'
  CONDITION: last_bid_strain != 'NT'
  CONDITION: last_bid_strain != 'H'
  CONDITION: second_longest_len <= 4.5
  CONDITION: heart_len > 5.5
  # distilled from Brill /bid

RULE BD_False_P342:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid > 0.5
  CONDITION: spade_len <= 4.5
  CONDITION: rule20_total > 18.5
  CONDITION: heart_len > 4.5
  CONDITION: last_bid_strain != 'S'
  CONDITION: last_bid_strain != 'NT'
  CONDITION: last_bid_strain != 'H'
  CONDITION: second_longest_len > 4.5
  CONDITION: total_points <= 11.5
  # distilled from Brill /bid

RULE BD_False_P343:
  CALL: 2NT
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid > 0.5
  CONDITION: spade_len <= 4.5
  CONDITION: rule20_total > 18.5
  CONDITION: heart_len > 4.5
  CONDITION: last_bid_strain != 'S'
  CONDITION: last_bid_strain != 'NT'
  CONDITION: last_bid_strain != 'H'
  CONDITION: second_longest_len > 4.5
  CONDITION: total_points > 11.5
  # distilled from Brill /bid

RULE BD_False_P344:
  CALL: XX
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid > 0.5
  CONDITION: spade_len > 4.5
  CONDITION: last_bid_strain == 'NT'
  CONDITION: partner_last_call == '1NT'
  CONDITION: my_side_bid_count <= 1.5
  CONDITION: major_hcp <= 7.5
  CONDITION: heart_len <= 1.5
  # distilled from Brill /bid

RULE BD_False_P345:
  CALL: 2H
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid > 0.5
  CONDITION: spade_len > 4.5
  CONDITION: last_bid_strain == 'NT'
  CONDITION: partner_last_call == '1NT'
  CONDITION: my_side_bid_count <= 1.5
  CONDITION: major_hcp <= 7.5
  CONDITION: heart_len > 1.5
  # distilled from Brill /bid

RULE BD_False_P346:
  CALL: 3NT
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid > 0.5
  CONDITION: spade_len > 4.5
  CONDITION: last_bid_strain == 'NT'
  CONDITION: partner_last_call == '1NT'
  CONDITION: my_side_bid_count <= 1.5
  CONDITION: major_hcp > 7.5
  CONDITION: longest_suit_len <= 5.5
  # distilled from Brill /bid

RULE BD_False_P347:
  CALL: 4H
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid > 0.5
  CONDITION: spade_len > 4.5
  CONDITION: last_bid_strain == 'NT'
  CONDITION: partner_last_call == '1NT'
  CONDITION: my_side_bid_count <= 1.5
  CONDITION: major_hcp > 7.5
  CONDITION: longest_suit_len > 5.5
  CONDITION: minor_hcp <= 3.0
  # distilled from Brill /bid

RULE BD_False_P348:
  CALL: 4S
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid > 0.5
  CONDITION: spade_len > 4.5
  CONDITION: last_bid_strain == 'NT'
  CONDITION: partner_last_call == '1NT'
  CONDITION: my_side_bid_count <= 1.5
  CONDITION: major_hcp > 7.5
  CONDITION: longest_suit_len > 5.5
  CONDITION: minor_hcp > 3.0
  # distilled from Brill /bid

RULE BD_False_P349:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid > 0.5
  CONDITION: spade_len > 4.5
  CONDITION: last_bid_strain == 'NT'
  CONDITION: partner_last_call == '1NT'
  CONDITION: my_side_bid_count > 1.5
  CONDITION: total_points <= 14.5
  CONDITION: competition_level <= 3.5
  # distilled from Brill /bid

RULE BD_False_P350:
  CALL: 2S
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid > 0.5
  CONDITION: spade_len > 4.5
  CONDITION: last_bid_strain == 'NT'
  CONDITION: partner_last_call == '1NT'
  CONDITION: my_side_bid_count > 1.5
  CONDITION: total_points <= 14.5
  CONDITION: competition_level > 3.5
  CONDITION: third_longest_len <= 2.5
  CONDITION: diamond_len <= 2.5
  # distilled from Brill /bid

RULE BD_False_P351:
  CALL: 3NT
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid > 0.5
  CONDITION: spade_len > 4.5
  CONDITION: last_bid_strain == 'NT'
  CONDITION: partner_last_call == '1NT'
  CONDITION: my_side_bid_count > 1.5
  CONDITION: total_points <= 14.5
  CONDITION: competition_level > 3.5
  CONDITION: third_longest_len <= 2.5
  CONDITION: diamond_len > 2.5
  # distilled from Brill /bid

RULE BD_False_P352:
  CALL: 2NT
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid > 0.5
  CONDITION: spade_len > 4.5
  CONDITION: last_bid_strain == 'NT'
  CONDITION: partner_last_call == '1NT'
  CONDITION: my_side_bid_count > 1.5
  CONDITION: total_points <= 14.5
  CONDITION: competition_level > 3.5
  CONDITION: third_longest_len > 2.5
  CONDITION: my_seat == 'W'
  # distilled from Brill /bid

RULE BD_False_P353:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid > 0.5
  CONDITION: spade_len > 4.5
  CONDITION: last_bid_strain == 'NT'
  CONDITION: partner_last_call == '1NT'
  CONDITION: my_side_bid_count > 1.5
  CONDITION: total_points <= 14.5
  CONDITION: competition_level > 3.5
  CONDITION: third_longest_len > 2.5
  CONDITION: my_seat != 'W'
  # distilled from Brill /bid

RULE BD_False_P354:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid > 0.5
  CONDITION: spade_len > 4.5
  CONDITION: last_bid_strain == 'NT'
  CONDITION: partner_last_call == '1NT'
  CONDITION: my_side_bid_count > 1.5
  CONDITION: total_points > 14.5
  CONDITION: ace_count <= 1.5
  CONDITION: major_hcp <= 10.0
  CONDITION: major_hcp <= 6.0
  # distilled from Brill /bid

RULE BD_False_P355:
  CALL: 4S
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid > 0.5
  CONDITION: spade_len > 4.5
  CONDITION: last_bid_strain == 'NT'
  CONDITION: partner_last_call == '1NT'
  CONDITION: my_side_bid_count > 1.5
  CONDITION: total_points > 14.5
  CONDITION: ace_count <= 1.5
  CONDITION: major_hcp <= 10.0
  CONDITION: major_hcp > 6.0
  # distilled from Brill /bid

RULE BD_False_P356:
  CALL: 2NT
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid > 0.5
  CONDITION: spade_len > 4.5
  CONDITION: last_bid_strain == 'NT'
  CONDITION: partner_last_call == '1NT'
  CONDITION: my_side_bid_count > 1.5
  CONDITION: total_points > 14.5
  CONDITION: ace_count <= 1.5
  CONDITION: major_hcp > 10.0
  # distilled from Brill /bid

RULE BD_False_P357:
  CALL: 2NT
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid > 0.5
  CONDITION: spade_len > 4.5
  CONDITION: last_bid_strain == 'NT'
  CONDITION: partner_last_call == '1NT'
  CONDITION: my_side_bid_count > 1.5
  CONDITION: total_points > 14.5
  CONDITION: ace_count > 1.5
  CONDITION: partner_opened <= 0.5
  CONDITION: spade_len <= 5.5
  # distilled from Brill /bid

RULE BD_False_P358:
  CALL: 3NT
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid > 0.5
  CONDITION: spade_len > 4.5
  CONDITION: last_bid_strain == 'NT'
  CONDITION: partner_last_call == '1NT'
  CONDITION: my_side_bid_count > 1.5
  CONDITION: total_points > 14.5
  CONDITION: ace_count > 1.5
  CONDITION: partner_opened <= 0.5
  CONDITION: spade_len > 5.5
  # distilled from Brill /bid

RULE BD_False_P359:
  CALL: 3NT
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid > 0.5
  CONDITION: spade_len > 4.5
  CONDITION: last_bid_strain == 'NT'
  CONDITION: partner_last_call == '1NT'
  CONDITION: my_side_bid_count > 1.5
  CONDITION: total_points > 14.5
  CONDITION: ace_count > 1.5
  CONDITION: partner_opened > 0.5
  # distilled from Brill /bid

RULE BD_False_P360:
  CALL: 2S
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid > 0.5
  CONDITION: spade_len > 4.5
  CONDITION: last_bid_strain == 'NT'
  CONDITION: partner_last_call != '1NT'
  CONDITION: rule20_total <= 18.5
  CONDITION: partner_last_call == 'X'
  CONDITION: doubleton_count <= 1.5
  CONDITION: ace_count <= 0.5
  # distilled from Brill /bid

RULE BD_False_P361:
  CALL: 2S
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid > 0.5
  CONDITION: spade_len > 4.5
  CONDITION: last_bid_strain == 'NT'
  CONDITION: partner_last_call != '1NT'
  CONDITION: rule20_total <= 18.5
  CONDITION: partner_last_call == 'X'
  CONDITION: doubleton_count <= 1.5
  CONDITION: ace_count > 0.5
  CONDITION: heart_len <= 2.5
  # distilled from Brill /bid

RULE BD_False_P362:
  CALL: 2H
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid > 0.5
  CONDITION: spade_len > 4.5
  CONDITION: last_bid_strain == 'NT'
  CONDITION: partner_last_call != '1NT'
  CONDITION: rule20_total <= 18.5
  CONDITION: partner_last_call == 'X'
  CONDITION: doubleton_count <= 1.5
  CONDITION: ace_count > 0.5
  CONDITION: heart_len > 2.5
  # distilled from Brill /bid

RULE BD_False_P363:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid > 0.5
  CONDITION: spade_len > 4.5
  CONDITION: last_bid_strain == 'NT'
  CONDITION: partner_last_call != '1NT'
  CONDITION: rule20_total <= 18.5
  CONDITION: partner_last_call == 'X'
  CONDITION: doubleton_count > 1.5
  CONDITION: major_hcp <= 3.0
  # distilled from Brill /bid

RULE BD_False_P364:
  CALL: 2D
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid > 0.5
  CONDITION: spade_len > 4.5
  CONDITION: last_bid_strain == 'NT'
  CONDITION: partner_last_call != '1NT'
  CONDITION: rule20_total <= 18.5
  CONDITION: partner_last_call == 'X'
  CONDITION: doubleton_count > 1.5
  CONDITION: major_hcp > 3.0
  # distilled from Brill /bid

RULE BD_False_P365:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid > 0.5
  CONDITION: spade_len > 4.5
  CONDITION: last_bid_strain == 'NT'
  CONDITION: partner_last_call != '1NT'
  CONDITION: rule20_total <= 18.5
  CONDITION: partner_last_call != 'X'
  CONDITION: partner_last_bid_strain == 'NONE'
  CONDITION: shape_pattern == '7321'
  CONDITION: major_hcp <= 7.5
  # distilled from Brill /bid

RULE BD_False_P366:
  CALL: 4S
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid > 0.5
  CONDITION: spade_len > 4.5
  CONDITION: last_bid_strain == 'NT'
  CONDITION: partner_last_call != '1NT'
  CONDITION: rule20_total <= 18.5
  CONDITION: partner_last_call != 'X'
  CONDITION: partner_last_bid_strain == 'NONE'
  CONDITION: shape_pattern == '7321'
  CONDITION: major_hcp > 7.5
  # distilled from Brill /bid

RULE BD_False_P367:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid > 0.5
  CONDITION: spade_len > 4.5
  CONDITION: last_bid_strain == 'NT'
  CONDITION: partner_last_call != '1NT'
  CONDITION: rule20_total <= 18.5
  CONDITION: partner_last_call != 'X'
  CONDITION: partner_last_bid_strain == 'NONE'
  CONDITION: shape_pattern != '7321'
  CONDITION: total_points <= 10.5
  # distilled from Brill /bid

RULE BD_False_P368:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid > 0.5
  CONDITION: spade_len > 4.5
  CONDITION: last_bid_strain == 'NT'
  CONDITION: partner_last_call != '1NT'
  CONDITION: rule20_total <= 18.5
  CONDITION: partner_last_call != 'X'
  CONDITION: partner_last_bid_strain == 'NONE'
  CONDITION: shape_pattern != '7321'
  CONDITION: total_points > 10.5
  # distilled from Brill /bid

RULE BD_False_P369:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid > 0.5
  CONDITION: spade_len > 4.5
  CONDITION: last_bid_strain == 'NT'
  CONDITION: partner_last_call != '1NT'
  CONDITION: rule20_total <= 18.5
  CONDITION: partner_last_call != 'X'
  CONDITION: partner_last_bid_strain != 'NONE'
  CONDITION: quick_tricks <= 0.75
  CONDITION: spade_hcp <= 3.5
  # distilled from Brill /bid

RULE BD_False_P370:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid > 0.5
  CONDITION: spade_len > 4.5
  CONDITION: last_bid_strain == 'NT'
  CONDITION: partner_last_call != '1NT'
  CONDITION: rule20_total <= 18.5
  CONDITION: partner_last_call != 'X'
  CONDITION: partner_last_bid_strain != 'NONE'
  CONDITION: quick_tricks <= 0.75
  CONDITION: spade_hcp > 3.5
  # distilled from Brill /bid

RULE BD_False_P371:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid > 0.5
  CONDITION: spade_len > 4.5
  CONDITION: last_bid_strain == 'NT'
  CONDITION: partner_last_call != '1NT'
  CONDITION: rule20_total <= 18.5
  CONDITION: partner_last_call != 'X'
  CONDITION: partner_last_bid_strain != 'NONE'
  CONDITION: quick_tricks > 0.75
  CONDITION: spade_len <= 5.5
  # distilled from Brill /bid

RULE BD_False_P372:
  CALL: 2S
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid > 0.5
  CONDITION: spade_len > 4.5
  CONDITION: last_bid_strain == 'NT'
  CONDITION: partner_last_call != '1NT'
  CONDITION: rule20_total <= 18.5
  CONDITION: partner_last_call != 'X'
  CONDITION: partner_last_bid_strain != 'NONE'
  CONDITION: quick_tricks > 0.75
  CONDITION: spade_len > 5.5
  # distilled from Brill /bid

RULE BD_False_P373:
  CALL: X
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid > 0.5
  CONDITION: spade_len > 4.5
  CONDITION: last_bid_strain == 'NT'
  CONDITION: partner_last_call != '1NT'
  CONDITION: rule20_total > 18.5
  CONDITION: shape_pattern == '5332'
  CONDITION: hcp <= 15.5
  CONDITION: major_hcp <= 0.5
  # distilled from Brill /bid

RULE BD_False_P374:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid > 0.5
  CONDITION: spade_len > 4.5
  CONDITION: last_bid_strain == 'NT'
  CONDITION: partner_last_call != '1NT'
  CONDITION: rule20_total > 18.5
  CONDITION: shape_pattern == '5332'
  CONDITION: hcp <= 15.5
  CONDITION: major_hcp > 0.5
  # distilled from Brill /bid

RULE BD_False_P375:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid > 0.5
  CONDITION: spade_len > 4.5
  CONDITION: last_bid_strain == 'NT'
  CONDITION: partner_last_call != '1NT'
  CONDITION: rule20_total > 18.5
  CONDITION: shape_pattern == '5332'
  CONDITION: hcp > 15.5
  CONDITION: club_hcp <= 2.5
  CONDITION: hcp <= 18.5
  # distilled from Brill /bid

RULE BD_False_P376:
  CALL: X
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid > 0.5
  CONDITION: spade_len > 4.5
  CONDITION: last_bid_strain == 'NT'
  CONDITION: partner_last_call != '1NT'
  CONDITION: rule20_total > 18.5
  CONDITION: shape_pattern == '5332'
  CONDITION: hcp > 15.5
  CONDITION: club_hcp <= 2.5
  CONDITION: hcp > 18.5
  # distilled from Brill /bid

RULE BD_False_P377:
  CALL: X
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid > 0.5
  CONDITION: spade_len > 4.5
  CONDITION: last_bid_strain == 'NT'
  CONDITION: partner_last_call != '1NT'
  CONDITION: rule20_total > 18.5
  CONDITION: shape_pattern == '5332'
  CONDITION: hcp > 15.5
  CONDITION: club_hcp > 2.5
  # distilled from Brill /bid

RULE BD_False_P378:
  CALL: 2C
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid > 0.5
  CONDITION: spade_len > 4.5
  CONDITION: last_bid_strain == 'NT'
  CONDITION: partner_last_call != '1NT'
  CONDITION: rule20_total > 18.5
  CONDITION: shape_pattern != '5332'
  CONDITION: second_longest_len <= 3.5
  CONDITION: opening_bid == '1NT'
  CONDITION: spade_len <= 6.5
  # distilled from Brill /bid

RULE BD_False_P379:
  CALL: 3S
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid > 0.5
  CONDITION: spade_len > 4.5
  CONDITION: last_bid_strain == 'NT'
  CONDITION: partner_last_call != '1NT'
  CONDITION: rule20_total > 18.5
  CONDITION: shape_pattern != '5332'
  CONDITION: second_longest_len <= 3.5
  CONDITION: opening_bid == '1NT'
  CONDITION: spade_len > 6.5
  # distilled from Brill /bid

RULE BD_False_P380:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid > 0.5
  CONDITION: spade_len > 4.5
  CONDITION: last_bid_strain == 'NT'
  CONDITION: partner_last_call != '1NT'
  CONDITION: rule20_total > 18.5
  CONDITION: shape_pattern != '5332'
  CONDITION: second_longest_len <= 3.5
  CONDITION: opening_bid != '1NT'
  CONDITION: d_is_best_minor <= 0.5
  # distilled from Brill /bid

RULE BD_False_P381:
  CALL: 2S
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid > 0.5
  CONDITION: spade_len > 4.5
  CONDITION: last_bid_strain == 'NT'
  CONDITION: partner_last_call != '1NT'
  CONDITION: rule20_total > 18.5
  CONDITION: shape_pattern != '5332'
  CONDITION: second_longest_len <= 3.5
  CONDITION: opening_bid != '1NT'
  CONDITION: d_is_best_minor > 0.5
  # distilled from Brill /bid

RULE BD_False_P382:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid > 0.5
  CONDITION: spade_len > 4.5
  CONDITION: last_bid_strain == 'NT'
  CONDITION: partner_last_call != '1NT'
  CONDITION: rule20_total > 18.5
  CONDITION: shape_pattern != '5332'
  CONDITION: second_longest_len > 3.5
  CONDITION: opening_bid == '1NT'
  CONDITION: total_points <= 11.5
  # distilled from Brill /bid

RULE BD_False_P383:
  CALL: 2S
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid > 0.5
  CONDITION: spade_len > 4.5
  CONDITION: last_bid_strain == 'NT'
  CONDITION: partner_last_call != '1NT'
  CONDITION: rule20_total > 18.5
  CONDITION: shape_pattern != '5332'
  CONDITION: second_longest_len > 3.5
  CONDITION: opening_bid == '1NT'
  CONDITION: total_points > 11.5
  # distilled from Brill /bid

RULE BD_False_P384:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid > 0.5
  CONDITION: spade_len > 4.5
  CONDITION: last_bid_strain == 'NT'
  CONDITION: partner_last_call != '1NT'
  CONDITION: rule20_total > 18.5
  CONDITION: shape_pattern != '5332'
  CONDITION: second_longest_len > 3.5
  CONDITION: opening_bid != '1NT'
  CONDITION: partner_last_call == 'PASS'
  # distilled from Brill /bid

RULE BD_False_P385:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid > 0.5
  CONDITION: spade_len > 4.5
  CONDITION: last_bid_strain == 'NT'
  CONDITION: partner_last_call != '1NT'
  CONDITION: rule20_total > 18.5
  CONDITION: shape_pattern != '5332'
  CONDITION: second_longest_len > 3.5
  CONDITION: opening_bid != '1NT'
  CONDITION: partner_last_call != 'PASS'
  # distilled from Brill /bid

RULE BD_False_P386:
  CALL: 1NT
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid > 0.5
  CONDITION: spade_len > 4.5
  CONDITION: last_bid_strain != 'NT'
  CONDITION: hcp <= 7.5
  CONDITION: my_side_bid_count <= 0.5
  CONDITION: partner_first_call == 'X'
  CONDITION: last_bid_strain == 'S'
  CONDITION: club_len <= 2.5
  CONDITION: diamond_hcp <= 1.5
  # distilled from Brill /bid

RULE BD_False_P387:
  CALL: 2D
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid > 0.5
  CONDITION: spade_len > 4.5
  CONDITION: last_bid_strain != 'NT'
  CONDITION: hcp <= 7.5
  CONDITION: my_side_bid_count <= 0.5
  CONDITION: partner_first_call == 'X'
  CONDITION: last_bid_strain == 'S'
  CONDITION: club_len <= 2.5
  CONDITION: diamond_hcp > 1.5
  # distilled from Brill /bid

RULE BD_False_P388:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid > 0.5
  CONDITION: spade_len > 4.5
  CONDITION: last_bid_strain != 'NT'
  CONDITION: hcp <= 7.5
  CONDITION: my_side_bid_count <= 0.5
  CONDITION: partner_first_call == 'X'
  CONDITION: last_bid_strain == 'S'
  CONDITION: club_len > 2.5
  CONDITION: hcp <= 4.0
  # distilled from Brill /bid

RULE BD_False_P389:
  CALL: 2H
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid > 0.5
  CONDITION: spade_len > 4.5
  CONDITION: last_bid_strain != 'NT'
  CONDITION: hcp <= 7.5
  CONDITION: my_side_bid_count <= 0.5
  CONDITION: partner_first_call == 'X'
  CONDITION: last_bid_strain == 'S'
  CONDITION: club_len > 2.5
  CONDITION: hcp > 4.0
  # distilled from Brill /bid

RULE BD_False_P390:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid > 0.5
  CONDITION: spade_len > 4.5
  CONDITION: last_bid_strain != 'NT'
  CONDITION: hcp <= 7.5
  CONDITION: my_side_bid_count <= 0.5
  CONDITION: partner_first_call == 'X'
  CONDITION: last_bid_strain != 'S'
  CONDITION: passes_since_last_bid <= 0.5
  CONDITION: last_bid_strain == 'D'
  # distilled from Brill /bid

RULE BD_False_P391:
  CALL: 1S
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid > 0.5
  CONDITION: spade_len > 4.5
  CONDITION: last_bid_strain != 'NT'
  CONDITION: hcp <= 7.5
  CONDITION: my_side_bid_count <= 0.5
  CONDITION: partner_first_call == 'X'
  CONDITION: last_bid_strain != 'S'
  CONDITION: passes_since_last_bid <= 0.5
  CONDITION: last_bid_strain != 'D'
  # distilled from Brill /bid

RULE BD_False_P392:
  CALL: 1S
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid > 0.5
  CONDITION: spade_len > 4.5
  CONDITION: last_bid_strain != 'NT'
  CONDITION: hcp <= 7.5
  CONDITION: my_side_bid_count <= 0.5
  CONDITION: partner_first_call == 'X'
  CONDITION: last_bid_strain != 'S'
  CONDITION: passes_since_last_bid > 0.5
  # distilled from Brill /bid

RULE BD_False_P393:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid > 0.5
  CONDITION: spade_len > 4.5
  CONDITION: last_bid_strain != 'NT'
  CONDITION: hcp <= 7.5
  CONDITION: my_side_bid_count <= 0.5
  CONDITION: partner_first_call != 'X'
  CONDITION: spade_len <= 5.5
  CONDITION: losing_trick_count <= 7.5
  CONDITION: heart_len <= 4.5
  # distilled from Brill /bid

RULE BD_False_P394:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid > 0.5
  CONDITION: spade_len > 4.5
  CONDITION: last_bid_strain != 'NT'
  CONDITION: hcp <= 7.5
  CONDITION: my_side_bid_count <= 0.5
  CONDITION: partner_first_call != 'X'
  CONDITION: spade_len <= 5.5
  CONDITION: losing_trick_count <= 7.5
  CONDITION: heart_len > 4.5
  # distilled from Brill /bid

RULE BD_False_P395:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid > 0.5
  CONDITION: spade_len > 4.5
  CONDITION: last_bid_strain != 'NT'
  CONDITION: hcp <= 7.5
  CONDITION: my_side_bid_count <= 0.5
  CONDITION: partner_first_call != 'X'
  CONDITION: spade_len <= 5.5
  CONDITION: losing_trick_count > 7.5
  CONDITION: partner_last_call == 'X'
  # distilled from Brill /bid

RULE BD_False_P396:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid > 0.5
  CONDITION: spade_len > 4.5
  CONDITION: last_bid_strain != 'NT'
  CONDITION: hcp <= 7.5
  CONDITION: my_side_bid_count <= 0.5
  CONDITION: partner_first_call != 'X'
  CONDITION: spade_len <= 5.5
  CONDITION: losing_trick_count > 7.5
  CONDITION: partner_last_call != 'X'
  # distilled from Brill /bid

RULE BD_False_P397:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid > 0.5
  CONDITION: spade_len > 4.5
  CONDITION: last_bid_strain != 'NT'
  CONDITION: hcp <= 7.5
  CONDITION: my_side_bid_count <= 0.5
  CONDITION: partner_first_call != 'X'
  CONDITION: spade_len > 5.5
  CONDITION: hcp <= 5.5
  CONDITION: spade_len <= 7.5
  # distilled from Brill /bid

RULE BD_False_P398:
  CALL: 4S
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid > 0.5
  CONDITION: spade_len > 4.5
  CONDITION: last_bid_strain != 'NT'
  CONDITION: hcp <= 7.5
  CONDITION: my_side_bid_count <= 0.5
  CONDITION: partner_first_call != 'X'
  CONDITION: spade_len > 5.5
  CONDITION: hcp <= 5.5
  CONDITION: spade_len > 7.5
  # distilled from Brill /bid

RULE BD_False_P399:
  CALL: 4S
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid > 0.5
  CONDITION: spade_len > 4.5
  CONDITION: last_bid_strain != 'NT'
  CONDITION: hcp <= 7.5
  CONDITION: my_side_bid_count <= 0.5
  CONDITION: partner_first_call != 'X'
  CONDITION: spade_len > 5.5
  CONDITION: hcp > 5.5
  CONDITION: losing_trick_count <= 6.5
  # distilled from Brill /bid

RULE BD_False_P400:
  CALL: 2S
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid > 0.5
  CONDITION: spade_len > 4.5
  CONDITION: last_bid_strain != 'NT'
  CONDITION: hcp <= 7.5
  CONDITION: my_side_bid_count <= 0.5
  CONDITION: partner_first_call != 'X'
  CONDITION: spade_len > 5.5
  CONDITION: hcp > 5.5
  CONDITION: losing_trick_count > 6.5
  # distilled from Brill /bid

RULE BD_False_P401:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid > 0.5
  CONDITION: spade_len > 4.5
  CONDITION: last_bid_strain != 'NT'
  CONDITION: hcp <= 7.5
  CONDITION: my_side_bid_count > 0.5
  CONDITION: partner_last_bid_strain == 'H'
  CONDITION: heart_len <= 3.5
  CONDITION: hcp <= 6.5
  CONDITION: passes_since_last_bid <= 2.0
  # distilled from Brill /bid

RULE BD_False_P402:
  CALL: 2H
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid > 0.5
  CONDITION: spade_len > 4.5
  CONDITION: last_bid_strain != 'NT'
  CONDITION: hcp <= 7.5
  CONDITION: my_side_bid_count > 0.5
  CONDITION: partner_last_bid_strain == 'H'
  CONDITION: heart_len <= 3.5
  CONDITION: hcp <= 6.5
  CONDITION: passes_since_last_bid > 2.0
  # distilled from Brill /bid

RULE BD_False_P403:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid > 0.5
  CONDITION: spade_len > 4.5
  CONDITION: last_bid_strain != 'NT'
  CONDITION: hcp <= 7.5
  CONDITION: my_side_bid_count > 0.5
  CONDITION: partner_last_bid_strain == 'H'
  CONDITION: heart_len <= 3.5
  CONDITION: hcp > 6.5
  CONDITION: heart_len <= 2.5
  # distilled from Brill /bid

RULE BD_False_P404:
  CALL: 2H
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid > 0.5
  CONDITION: spade_len > 4.5
  CONDITION: last_bid_strain != 'NT'
  CONDITION: hcp <= 7.5
  CONDITION: my_side_bid_count > 0.5
  CONDITION: partner_last_bid_strain == 'H'
  CONDITION: heart_len <= 3.5
  CONDITION: hcp > 6.5
  CONDITION: heart_len > 2.5
  # distilled from Brill /bid

RULE BD_False_P405:
  CALL: 3H
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid > 0.5
  CONDITION: spade_len > 4.5
  CONDITION: last_bid_strain != 'NT'
  CONDITION: hcp <= 7.5
  CONDITION: my_side_bid_count > 0.5
  CONDITION: partner_last_bid_strain == 'H'
  CONDITION: heart_len > 3.5
  CONDITION: opp_bid_count <= 1.5
  # distilled from Brill /bid

RULE BD_False_P406:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid > 0.5
  CONDITION: spade_len > 4.5
  CONDITION: last_bid_strain != 'NT'
  CONDITION: hcp <= 7.5
  CONDITION: my_side_bid_count > 0.5
  CONDITION: partner_last_bid_strain == 'H'
  CONDITION: heart_len > 3.5
  CONDITION: opp_bid_count > 1.5
  CONDITION: hcp <= 2.5
  # distilled from Brill /bid

RULE BD_False_P407:
  CALL: 2H
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid > 0.5
  CONDITION: spade_len > 4.5
  CONDITION: last_bid_strain != 'NT'
  CONDITION: hcp <= 7.5
  CONDITION: my_side_bid_count > 0.5
  CONDITION: partner_last_bid_strain == 'H'
  CONDITION: heart_len > 3.5
  CONDITION: opp_bid_count > 1.5
  CONDITION: hcp > 2.5
  # distilled from Brill /bid

RULE BD_False_P408:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid > 0.5
  CONDITION: spade_len > 4.5
  CONDITION: last_bid_strain != 'NT'
  CONDITION: hcp <= 7.5
  CONDITION: my_side_bid_count > 0.5
  CONDITION: partner_last_bid_strain != 'H'
  CONDITION: last_bid_strain == 'S'
  CONDITION: partner_last_call == '1S'
  CONDITION: hcp <= 2.0
  # distilled from Brill /bid

RULE BD_False_P409:
  CALL: 3S
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid > 0.5
  CONDITION: spade_len > 4.5
  CONDITION: last_bid_strain != 'NT'
  CONDITION: hcp <= 7.5
  CONDITION: my_side_bid_count > 0.5
  CONDITION: partner_last_bid_strain != 'H'
  CONDITION: last_bid_strain == 'S'
  CONDITION: partner_last_call == '1S'
  CONDITION: hcp > 2.0
  # distilled from Brill /bid

RULE BD_False_P410:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid > 0.5
  CONDITION: spade_len > 4.5
  CONDITION: last_bid_strain != 'NT'
  CONDITION: hcp <= 7.5
  CONDITION: my_side_bid_count > 0.5
  CONDITION: partner_last_bid_strain != 'H'
  CONDITION: last_bid_strain == 'S'
  CONDITION: partner_last_call != '1S'
  CONDITION: heart_len <= 3.5
  # distilled from Brill /bid

RULE BD_False_P411:
  CALL: X
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid > 0.5
  CONDITION: spade_len > 4.5
  CONDITION: last_bid_strain != 'NT'
  CONDITION: hcp <= 7.5
  CONDITION: my_side_bid_count > 0.5
  CONDITION: partner_last_bid_strain != 'H'
  CONDITION: last_bid_strain == 'S'
  CONDITION: partner_last_call != '1S'
  CONDITION: heart_len > 3.5
  # distilled from Brill /bid

RULE BD_False_P412:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid > 0.5
  CONDITION: spade_len > 4.5
  CONDITION: last_bid_strain != 'NT'
  CONDITION: hcp <= 7.5
  CONDITION: my_side_bid_count > 0.5
  CONDITION: partner_last_bid_strain != 'H'
  CONDITION: last_bid_strain != 'S'
  CONDITION: hcp <= 4.5
  CONDITION: last_bid_strain == 'D'
  # distilled from Brill /bid

RULE BD_False_P413:
  CALL: 1S
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid > 0.5
  CONDITION: spade_len > 4.5
  CONDITION: last_bid_strain != 'NT'
  CONDITION: hcp <= 7.5
  CONDITION: my_side_bid_count > 0.5
  CONDITION: partner_last_bid_strain != 'H'
  CONDITION: last_bid_strain != 'S'
  CONDITION: hcp <= 4.5
  CONDITION: last_bid_strain != 'D'
  # distilled from Brill /bid

RULE BD_False_P414:
  CALL: 1S
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid > 0.5
  CONDITION: spade_len > 4.5
  CONDITION: last_bid_strain != 'NT'
  CONDITION: hcp <= 7.5
  CONDITION: my_side_bid_count > 0.5
  CONDITION: partner_last_bid_strain != 'H'
  CONDITION: last_bid_strain != 'S'
  CONDITION: hcp > 4.5
  CONDITION: spade_len <= 6.5
  # distilled from Brill /bid

RULE BD_False_P415:
  CALL: 4S
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid > 0.5
  CONDITION: spade_len > 4.5
  CONDITION: last_bid_strain != 'NT'
  CONDITION: hcp <= 7.5
  CONDITION: my_side_bid_count > 0.5
  CONDITION: partner_last_bid_strain != 'H'
  CONDITION: last_bid_strain != 'S'
  CONDITION: hcp > 4.5
  CONDITION: spade_len > 6.5
  # distilled from Brill /bid

RULE BD_False_P416:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid > 0.5
  CONDITION: spade_len > 4.5
  CONDITION: last_bid_strain != 'NT'
  CONDITION: hcp > 7.5
  CONDITION: last_bid_strain == 'S'
  CONDITION: partner_last_bid_strain == 'NONE'
  CONDITION: second_longest_len <= 4.5
  CONDITION: passes_since_last_bid <= 0.5
  CONDITION: opening_bid == '1S'
  # distilled from Brill /bid

RULE BD_False_P417:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid > 0.5
  CONDITION: spade_len > 4.5
  CONDITION: last_bid_strain != 'NT'
  CONDITION: hcp > 7.5
  CONDITION: last_bid_strain == 'S'
  CONDITION: partner_last_bid_strain == 'NONE'
  CONDITION: second_longest_len <= 4.5
  CONDITION: passes_since_last_bid <= 0.5
  CONDITION: opening_bid != '1S'
  # distilled from Brill /bid

RULE BD_False_P418:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid > 0.5
  CONDITION: spade_len > 4.5
  CONDITION: last_bid_strain != 'NT'
  CONDITION: hcp > 7.5
  CONDITION: last_bid_strain == 'S'
  CONDITION: partner_last_bid_strain == 'NONE'
  CONDITION: second_longest_len <= 4.5
  CONDITION: passes_since_last_bid > 0.5
  CONDITION: partner_last_call == 'PASS'
  # distilled from Brill /bid

RULE BD_False_P419:
  CALL: 1NT
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid > 0.5
  CONDITION: spade_len > 4.5
  CONDITION: last_bid_strain != 'NT'
  CONDITION: hcp > 7.5
  CONDITION: last_bid_strain == 'S'
  CONDITION: partner_last_bid_strain == 'NONE'
  CONDITION: second_longest_len <= 4.5
  CONDITION: passes_since_last_bid > 0.5
  CONDITION: partner_last_call != 'PASS'
  # distilled from Brill /bid

RULE BD_False_P420:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid > 0.5
  CONDITION: spade_len > 4.5
  CONDITION: last_bid_strain != 'NT'
  CONDITION: hcp > 7.5
  CONDITION: last_bid_strain == 'S'
  CONDITION: partner_last_bid_strain == 'NONE'
  CONDITION: second_longest_len > 4.5
  CONDITION: longest_suit_len <= 5.5
  CONDITION: d_top3_honors <= 1.5
  # distilled from Brill /bid

RULE BD_False_P421:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid > 0.5
  CONDITION: spade_len > 4.5
  CONDITION: last_bid_strain != 'NT'
  CONDITION: hcp > 7.5
  CONDITION: last_bid_strain == 'S'
  CONDITION: partner_last_bid_strain == 'NONE'
  CONDITION: second_longest_len > 4.5
  CONDITION: longest_suit_len <= 5.5
  CONDITION: d_top3_honors > 1.5
  # distilled from Brill /bid

RULE BD_False_P422:
  CALL: 4H
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid > 0.5
  CONDITION: spade_len > 4.5
  CONDITION: last_bid_strain != 'NT'
  CONDITION: hcp > 7.5
  CONDITION: last_bid_strain == 'S'
  CONDITION: partner_last_bid_strain == 'NONE'
  CONDITION: second_longest_len > 4.5
  CONDITION: longest_suit_len > 5.5
  CONDITION: hcp <= 12.5
  # distilled from Brill /bid

RULE BD_False_P423:
  CALL: X
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid > 0.5
  CONDITION: spade_len > 4.5
  CONDITION: last_bid_strain != 'NT'
  CONDITION: hcp > 7.5
  CONDITION: last_bid_strain == 'S'
  CONDITION: partner_last_bid_strain == 'NONE'
  CONDITION: second_longest_len > 4.5
  CONDITION: longest_suit_len > 5.5
  CONDITION: hcp > 12.5
  # distilled from Brill /bid

RULE BD_False_P424:
  CALL: 1NT
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid > 0.5
  CONDITION: spade_len > 4.5
  CONDITION: last_bid_strain != 'NT'
  CONDITION: hcp > 7.5
  CONDITION: last_bid_strain == 'S'
  CONDITION: partner_last_bid_strain != 'NONE'
  CONDITION: support_in_partner_suit <= 3.5
  CONDITION: heart_len <= 3.5
  CONDITION: hcp <= 9.5
  # distilled from Brill /bid

RULE BD_False_P425:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid > 0.5
  CONDITION: spade_len > 4.5
  CONDITION: last_bid_strain != 'NT'
  CONDITION: hcp > 7.5
  CONDITION: last_bid_strain == 'S'
  CONDITION: partner_last_bid_strain != 'NONE'
  CONDITION: support_in_partner_suit <= 3.5
  CONDITION: heart_len <= 3.5
  CONDITION: hcp > 9.5
  # distilled from Brill /bid

RULE BD_False_P426:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid > 0.5
  CONDITION: spade_len > 4.5
  CONDITION: last_bid_strain != 'NT'
  CONDITION: hcp > 7.5
  CONDITION: last_bid_strain == 'S'
  CONDITION: partner_last_bid_strain != 'NONE'
  CONDITION: support_in_partner_suit <= 3.5
  CONDITION: heart_len > 3.5
  CONDITION: heart_hcp <= 1.5
  # distilled from Brill /bid

RULE BD_False_P427:
  CALL: X
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid > 0.5
  CONDITION: spade_len > 4.5
  CONDITION: last_bid_strain != 'NT'
  CONDITION: hcp > 7.5
  CONDITION: last_bid_strain == 'S'
  CONDITION: partner_last_bid_strain != 'NONE'
  CONDITION: support_in_partner_suit <= 3.5
  CONDITION: heart_len > 3.5
  CONDITION: heart_hcp > 1.5
  # distilled from Brill /bid

RULE BD_False_P428:
  CALL: 3D
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid > 0.5
  CONDITION: spade_len > 4.5
  CONDITION: last_bid_strain != 'NT'
  CONDITION: hcp > 7.5
  CONDITION: last_bid_strain == 'S'
  CONDITION: partner_last_bid_strain != 'NONE'
  CONDITION: support_in_partner_suit > 3.5
  CONDITION: opening_bid == '1D'
  CONDITION: hcp <= 8.5
  # distilled from Brill /bid

RULE BD_False_P429:
  CALL: 2D
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid > 0.5
  CONDITION: spade_len > 4.5
  CONDITION: last_bid_strain != 'NT'
  CONDITION: hcp > 7.5
  CONDITION: last_bid_strain == 'S'
  CONDITION: partner_last_bid_strain != 'NONE'
  CONDITION: support_in_partner_suit > 3.5
  CONDITION: opening_bid == '1D'
  CONDITION: hcp > 8.5
  # distilled from Brill /bid

RULE BD_False_P430:
  CALL: 3H
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid > 0.5
  CONDITION: spade_len > 4.5
  CONDITION: last_bid_strain != 'NT'
  CONDITION: hcp > 7.5
  CONDITION: last_bid_strain == 'S'
  CONDITION: partner_last_bid_strain != 'NONE'
  CONDITION: support_in_partner_suit > 3.5
  CONDITION: opening_bid != '1D'
  CONDITION: hcp <= 8.5
  # distilled from Brill /bid

RULE BD_False_P431:
  CALL: 2C
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid > 0.5
  CONDITION: spade_len > 4.5
  CONDITION: last_bid_strain != 'NT'
  CONDITION: hcp > 7.5
  CONDITION: last_bid_strain == 'S'
  CONDITION: partner_last_bid_strain != 'NONE'
  CONDITION: support_in_partner_suit > 3.5
  CONDITION: opening_bid != '1D'
  CONDITION: hcp > 8.5
  # distilled from Brill /bid

RULE BD_False_P432:
  CALL: 2S
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid > 0.5
  CONDITION: spade_len > 4.5
  CONDITION: last_bid_strain != 'NT'
  CONDITION: hcp > 7.5
  CONDITION: last_bid_strain != 'S'
  CONDITION: second_longest_len <= 4.5
  CONDITION: spade_len <= 5.5
  CONDITION: spade_hcp <= 2.5
  CONDITION: partner_last_call == 'X'
  # distilled from Brill /bid

RULE BD_False_P433:
  CALL: 1S
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid > 0.5
  CONDITION: spade_len > 4.5
  CONDITION: last_bid_strain != 'NT'
  CONDITION: hcp > 7.5
  CONDITION: last_bid_strain != 'S'
  CONDITION: second_longest_len <= 4.5
  CONDITION: spade_len <= 5.5
  CONDITION: spade_hcp <= 2.5
  CONDITION: partner_last_call != 'X'
  # distilled from Brill /bid

RULE BD_False_P434:
  CALL: 1S
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid > 0.5
  CONDITION: spade_len > 4.5
  CONDITION: last_bid_strain != 'NT'
  CONDITION: hcp > 7.5
  CONDITION: last_bid_strain != 'S'
  CONDITION: second_longest_len <= 4.5
  CONDITION: spade_len <= 5.5
  CONDITION: spade_hcp > 2.5
  CONDITION: passes_since_last_bid <= 0.5
  # distilled from Brill /bid

RULE BD_False_P435:
  CALL: 1S
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid > 0.5
  CONDITION: spade_len > 4.5
  CONDITION: last_bid_strain != 'NT'
  CONDITION: hcp > 7.5
  CONDITION: last_bid_strain != 'S'
  CONDITION: second_longest_len <= 4.5
  CONDITION: spade_len <= 5.5
  CONDITION: spade_hcp > 2.5
  CONDITION: passes_since_last_bid > 0.5
  # distilled from Brill /bid

RULE BD_False_P436:
  CALL: 2S
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid > 0.5
  CONDITION: spade_len > 4.5
  CONDITION: last_bid_strain != 'NT'
  CONDITION: hcp > 7.5
  CONDITION: last_bid_strain != 'S'
  CONDITION: second_longest_len <= 4.5
  CONDITION: spade_len > 5.5
  CONDITION: rule20_total <= 20.5
  CONDITION: competition_level <= 1.5
  # distilled from Brill /bid

RULE BD_False_P437:
  CALL: 1S
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid > 0.5
  CONDITION: spade_len > 4.5
  CONDITION: last_bid_strain != 'NT'
  CONDITION: hcp > 7.5
  CONDITION: last_bid_strain != 'S'
  CONDITION: second_longest_len <= 4.5
  CONDITION: spade_len > 5.5
  CONDITION: rule20_total <= 20.5
  CONDITION: competition_level > 1.5
  # distilled from Brill /bid

RULE BD_False_P438:
  CALL: 1S
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid > 0.5
  CONDITION: spade_len > 4.5
  CONDITION: last_bid_strain != 'NT'
  CONDITION: hcp > 7.5
  CONDITION: last_bid_strain != 'S'
  CONDITION: second_longest_len <= 4.5
  CONDITION: spade_len > 5.5
  CONDITION: rule20_total > 20.5
  CONDITION: hcp <= 16.5
  # distilled from Brill /bid

RULE BD_False_P439:
  CALL: X
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid > 0.5
  CONDITION: spade_len > 4.5
  CONDITION: last_bid_strain != 'NT'
  CONDITION: hcp > 7.5
  CONDITION: last_bid_strain != 'S'
  CONDITION: second_longest_len <= 4.5
  CONDITION: spade_len > 5.5
  CONDITION: rule20_total > 20.5
  CONDITION: hcp > 16.5
  # distilled from Brill /bid

RULE BD_False_P440:
  CALL: 2H
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid > 0.5
  CONDITION: spade_len > 4.5
  CONDITION: last_bid_strain != 'NT'
  CONDITION: hcp > 7.5
  CONDITION: last_bid_strain != 'S'
  CONDITION: second_longest_len > 4.5
  CONDITION: heart_len <= 4.0
  CONDITION: opening_bid == '1H'
  CONDITION: passes_since_last_bid <= 0.5
  # distilled from Brill /bid

RULE BD_False_P441:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid > 0.5
  CONDITION: spade_len > 4.5
  CONDITION: last_bid_strain != 'NT'
  CONDITION: hcp > 7.5
  CONDITION: last_bid_strain != 'S'
  CONDITION: second_longest_len > 4.5
  CONDITION: heart_len <= 4.0
  CONDITION: opening_bid == '1H'
  CONDITION: passes_since_last_bid > 0.5
  # distilled from Brill /bid

RULE BD_False_P442:
  CALL: 1S
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid > 0.5
  CONDITION: spade_len > 4.5
  CONDITION: last_bid_strain != 'NT'
  CONDITION: hcp > 7.5
  CONDITION: last_bid_strain != 'S'
  CONDITION: second_longest_len > 4.5
  CONDITION: heart_len <= 4.0
  CONDITION: opening_bid != '1H'
  CONDITION: opp_last_call == '1H'
  # distilled from Brill /bid

RULE BD_False_P443:
  CALL: 1S
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid > 0.5
  CONDITION: spade_len > 4.5
  CONDITION: last_bid_strain != 'NT'
  CONDITION: hcp > 7.5
  CONDITION: last_bid_strain != 'S'
  CONDITION: second_longest_len > 4.5
  CONDITION: heart_len <= 4.0
  CONDITION: opening_bid != '1H'
  CONDITION: opp_last_call != '1H'
  # distilled from Brill /bid

RULE BD_False_P444:
  CALL: 2S
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid > 0.5
  CONDITION: spade_len > 4.5
  CONDITION: last_bid_strain != 'NT'
  CONDITION: hcp > 7.5
  CONDITION: last_bid_strain != 'S'
  CONDITION: second_longest_len > 4.5
  CONDITION: heart_len > 4.0
  CONDITION: last_bid_strain == 'C'
  CONDITION: partner_last_call == 'X'
  # distilled from Brill /bid

RULE BD_False_P445:
  CALL: 2C
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid > 0.5
  CONDITION: spade_len > 4.5
  CONDITION: last_bid_strain != 'NT'
  CONDITION: hcp > 7.5
  CONDITION: last_bid_strain != 'S'
  CONDITION: second_longest_len > 4.5
  CONDITION: heart_len > 4.0
  CONDITION: last_bid_strain == 'C'
  CONDITION: partner_last_call != 'X'
  # distilled from Brill /bid

RULE BD_False_P446:
  CALL: 2D
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid > 0.5
  CONDITION: spade_len > 4.5
  CONDITION: last_bid_strain != 'NT'
  CONDITION: hcp > 7.5
  CONDITION: last_bid_strain != 'S'
  CONDITION: second_longest_len > 4.5
  CONDITION: heart_len > 4.0
  CONDITION: last_bid_strain != 'C'
  CONDITION: opening_bid == '1D'
  # distilled from Brill /bid

RULE BD_False_P447:
  CALL: 1S
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level <= 1.5
  CONDITION: opponents_bid > 0.5
  CONDITION: spade_len > 4.5
  CONDITION: last_bid_strain != 'NT'
  CONDITION: hcp > 7.5
  CONDITION: last_bid_strain != 'S'
  CONDITION: second_longest_len > 4.5
  CONDITION: heart_len > 4.0
  CONDITION: last_bid_strain != 'C'
  CONDITION: opening_bid != '1D'
  # distilled from Brill /bid

RULE BD_False_P448:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call == 'PASS'
  CONDITION: total_points <= 13.5
  CONDITION: my_side_bid_count <= 1.5
  CONDITION: opp_bid_count <= 2.5
  CONDITION: total_points <= 11.5
  CONDITION: partner_first_call == 'PASS'
  CONDITION: losing_trick_count <= 7.5
  CONDITION: opening_bid == '1H'
  CONDITION: opp_last_call == '2H'
  # distilled from Brill /bid

RULE BD_False_P449:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call == 'PASS'
  CONDITION: total_points <= 13.5
  CONDITION: my_side_bid_count <= 1.5
  CONDITION: opp_bid_count <= 2.5
  CONDITION: total_points <= 11.5
  CONDITION: partner_first_call == 'PASS'
  CONDITION: losing_trick_count <= 7.5
  CONDITION: opening_bid == '1H'
  CONDITION: opp_last_call != '2H'
  # distilled from Brill /bid

RULE BD_False_P450:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call == 'PASS'
  CONDITION: total_points <= 13.5
  CONDITION: my_side_bid_count <= 1.5
  CONDITION: opp_bid_count <= 2.5
  CONDITION: total_points <= 11.5
  CONDITION: partner_first_call == 'PASS'
  CONDITION: losing_trick_count <= 7.5
  CONDITION: opening_bid != '1H'
  CONDITION: auction_len <= 3.5
  # distilled from Brill /bid

RULE BD_False_P451:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call == 'PASS'
  CONDITION: total_points <= 13.5
  CONDITION: my_side_bid_count <= 1.5
  CONDITION: opp_bid_count <= 2.5
  CONDITION: total_points <= 11.5
  CONDITION: partner_first_call == 'PASS'
  CONDITION: losing_trick_count <= 7.5
  CONDITION: opening_bid != '1H'
  CONDITION: auction_len > 3.5
  # distilled from Brill /bid

RULE BD_False_P452:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call == 'PASS'
  CONDITION: total_points <= 13.5
  CONDITION: my_side_bid_count <= 1.5
  CONDITION: opp_bid_count <= 2.5
  CONDITION: total_points <= 11.5
  CONDITION: partner_first_call == 'PASS'
  CONDITION: losing_trick_count > 7.5
  CONDITION: opening_bid == '2C'
  CONDITION: spade_len <= 5.5
  # distilled from Brill /bid

RULE BD_False_P453:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call == 'PASS'
  CONDITION: total_points <= 13.5
  CONDITION: my_side_bid_count <= 1.5
  CONDITION: opp_bid_count <= 2.5
  CONDITION: total_points <= 11.5
  CONDITION: partner_first_call == 'PASS'
  CONDITION: losing_trick_count > 7.5
  CONDITION: opening_bid == '2C'
  CONDITION: spade_len > 5.5
  # distilled from Brill /bid

RULE BD_False_P454:
  CALL: 3S
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call == 'PASS'
  CONDITION: total_points <= 13.5
  CONDITION: my_side_bid_count <= 1.5
  CONDITION: opp_bid_count <= 2.5
  CONDITION: total_points <= 11.5
  CONDITION: partner_first_call == 'PASS'
  CONDITION: losing_trick_count > 7.5
  CONDITION: opening_bid != '2C'
  CONDITION: partner_last_bid_strain == 'S'
  # distilled from Brill /bid

RULE BD_False_P455:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call == 'PASS'
  CONDITION: total_points <= 13.5
  CONDITION: my_side_bid_count <= 1.5
  CONDITION: opp_bid_count <= 2.5
  CONDITION: total_points <= 11.5
  CONDITION: partner_first_call == 'PASS'
  CONDITION: losing_trick_count > 7.5
  CONDITION: opening_bid != '2C'
  CONDITION: partner_last_bid_strain != 'S'
  # distilled from Brill /bid

RULE BD_False_P456:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call == 'PASS'
  CONDITION: total_points <= 13.5
  CONDITION: my_side_bid_count <= 1.5
  CONDITION: opp_bid_count <= 2.5
  CONDITION: total_points <= 11.5
  CONDITION: partner_first_call != 'PASS'
  CONDITION: last_bid_level <= 2.5
  CONDITION: opp_last_call == '2C'
  CONDITION: hcp <= 8.5
  # distilled from Brill /bid

RULE BD_False_P457:
  CALL: X
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call == 'PASS'
  CONDITION: total_points <= 13.5
  CONDITION: my_side_bid_count <= 1.5
  CONDITION: opp_bid_count <= 2.5
  CONDITION: total_points <= 11.5
  CONDITION: partner_first_call != 'PASS'
  CONDITION: last_bid_level <= 2.5
  CONDITION: opp_last_call == '2C'
  CONDITION: hcp > 8.5
  # distilled from Brill /bid

RULE BD_False_P458:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call == 'PASS'
  CONDITION: total_points <= 13.5
  CONDITION: my_side_bid_count <= 1.5
  CONDITION: opp_bid_count <= 2.5
  CONDITION: total_points <= 11.5
  CONDITION: partner_first_call != 'PASS'
  CONDITION: last_bid_level <= 2.5
  CONDITION: opp_last_call != '2C'
  CONDITION: support_in_partner_suit <= 4.5
  # distilled from Brill /bid

RULE BD_False_P459:
  CALL: 3C
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call == 'PASS'
  CONDITION: total_points <= 13.5
  CONDITION: my_side_bid_count <= 1.5
  CONDITION: opp_bid_count <= 2.5
  CONDITION: total_points <= 11.5
  CONDITION: partner_first_call != 'PASS'
  CONDITION: last_bid_level <= 2.5
  CONDITION: opp_last_call != '2C'
  CONDITION: support_in_partner_suit > 4.5
  # distilled from Brill /bid

RULE BD_False_P460:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call == 'PASS'
  CONDITION: total_points <= 13.5
  CONDITION: my_side_bid_count <= 1.5
  CONDITION: opp_bid_count <= 2.5
  CONDITION: total_points <= 11.5
  CONDITION: partner_first_call != 'PASS'
  CONDITION: last_bid_level > 2.5
  CONDITION: rule20_total <= 15.5
  CONDITION: support_in_partner_suit <= 3.5
  # distilled from Brill /bid

RULE BD_False_P461:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call == 'PASS'
  CONDITION: total_points <= 13.5
  CONDITION: my_side_bid_count <= 1.5
  CONDITION: opp_bid_count <= 2.5
  CONDITION: total_points <= 11.5
  CONDITION: partner_first_call != 'PASS'
  CONDITION: last_bid_level > 2.5
  CONDITION: rule20_total <= 15.5
  CONDITION: support_in_partner_suit > 3.5
  # distilled from Brill /bid

RULE BD_False_P462:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call == 'PASS'
  CONDITION: total_points <= 13.5
  CONDITION: my_side_bid_count <= 1.5
  CONDITION: opp_bid_count <= 2.5
  CONDITION: total_points <= 11.5
  CONDITION: partner_first_call != 'PASS'
  CONDITION: last_bid_level > 2.5
  CONDITION: rule20_total > 15.5
  CONDITION: partner_first_call == '1C'
  # distilled from Brill /bid

RULE BD_False_P463:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call == 'PASS'
  CONDITION: total_points <= 13.5
  CONDITION: my_side_bid_count <= 1.5
  CONDITION: opp_bid_count <= 2.5
  CONDITION: total_points <= 11.5
  CONDITION: partner_first_call != 'PASS'
  CONDITION: last_bid_level > 2.5
  CONDITION: rule20_total > 15.5
  CONDITION: partner_first_call != '1C'
  # distilled from Brill /bid

RULE BD_False_P464:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call == 'PASS'
  CONDITION: total_points <= 13.5
  CONDITION: my_side_bid_count <= 1.5
  CONDITION: opp_bid_count <= 2.5
  CONDITION: total_points > 11.5
  CONDITION: spade_len <= 4.5
  CONDITION: heart_len <= 5.5
  CONDITION: support_in_partner_suit <= 1.5
  CONDITION: diamond_len <= 5.5
  # distilled from Brill /bid

RULE BD_False_P465:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call == 'PASS'
  CONDITION: total_points <= 13.5
  CONDITION: my_side_bid_count <= 1.5
  CONDITION: opp_bid_count <= 2.5
  CONDITION: total_points > 11.5
  CONDITION: spade_len <= 4.5
  CONDITION: heart_len <= 5.5
  CONDITION: support_in_partner_suit <= 1.5
  CONDITION: diamond_len > 5.5
  # distilled from Brill /bid

RULE BD_False_P466:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call == 'PASS'
  CONDITION: total_points <= 13.5
  CONDITION: my_side_bid_count <= 1.5
  CONDITION: opp_bid_count <= 2.5
  CONDITION: total_points > 11.5
  CONDITION: spade_len <= 4.5
  CONDITION: heart_len <= 5.5
  CONDITION: support_in_partner_suit > 1.5
  CONDITION: my_last_call == 'PASS'
  # distilled from Brill /bid

RULE BD_False_P467:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call == 'PASS'
  CONDITION: total_points <= 13.5
  CONDITION: my_side_bid_count <= 1.5
  CONDITION: opp_bid_count <= 2.5
  CONDITION: total_points > 11.5
  CONDITION: spade_len <= 4.5
  CONDITION: heart_len <= 5.5
  CONDITION: support_in_partner_suit > 1.5
  CONDITION: my_last_call != 'PASS'
  # distilled from Brill /bid

RULE BD_False_P468:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call == 'PASS'
  CONDITION: total_points <= 13.5
  CONDITION: my_side_bid_count <= 1.5
  CONDITION: opp_bid_count <= 2.5
  CONDITION: total_points > 11.5
  CONDITION: spade_len <= 4.5
  CONDITION: heart_len > 5.5
  CONDITION: opp_last_call == '2D'
  CONDITION: heart_hcp <= 4.5
  # distilled from Brill /bid

RULE BD_False_P469:
  CALL: 2H
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call == 'PASS'
  CONDITION: total_points <= 13.5
  CONDITION: my_side_bid_count <= 1.5
  CONDITION: opp_bid_count <= 2.5
  CONDITION: total_points > 11.5
  CONDITION: spade_len <= 4.5
  CONDITION: heart_len > 5.5
  CONDITION: opp_last_call == '2D'
  CONDITION: heart_hcp > 4.5
  # distilled from Brill /bid

RULE BD_False_P470:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call == 'PASS'
  CONDITION: total_points <= 13.5
  CONDITION: my_side_bid_count <= 1.5
  CONDITION: opp_bid_count <= 2.5
  CONDITION: total_points > 11.5
  CONDITION: spade_len <= 4.5
  CONDITION: heart_len > 5.5
  CONDITION: opp_last_call != '2D'
  CONDITION: my_side_bid_count <= 0.5
  # distilled from Brill /bid

RULE BD_False_P471:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call == 'PASS'
  CONDITION: total_points <= 13.5
  CONDITION: my_side_bid_count <= 1.5
  CONDITION: opp_bid_count <= 2.5
  CONDITION: total_points > 11.5
  CONDITION: spade_len <= 4.5
  CONDITION: heart_len > 5.5
  CONDITION: opp_last_call != '2D'
  CONDITION: my_side_bid_count > 0.5
  # distilled from Brill /bid

RULE BD_False_P472:
  CALL: X
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call == 'PASS'
  CONDITION: total_points <= 13.5
  CONDITION: my_side_bid_count <= 1.5
  CONDITION: opp_bid_count <= 2.5
  CONDITION: total_points > 11.5
  CONDITION: spade_len > 4.5
  CONDITION: rule_of_21 <= 0.5
  CONDITION: opp_last_call == '2H'
  CONDITION: heart_len <= 1.5
  # distilled from Brill /bid

RULE BD_False_P473:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call == 'PASS'
  CONDITION: total_points <= 13.5
  CONDITION: my_side_bid_count <= 1.5
  CONDITION: opp_bid_count <= 2.5
  CONDITION: total_points > 11.5
  CONDITION: spade_len > 4.5
  CONDITION: rule_of_21 <= 0.5
  CONDITION: opp_last_call == '2H'
  CONDITION: heart_len > 1.5
  # distilled from Brill /bid

RULE BD_False_P474:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call == 'PASS'
  CONDITION: total_points <= 13.5
  CONDITION: my_side_bid_count <= 1.5
  CONDITION: opp_bid_count <= 2.5
  CONDITION: total_points > 11.5
  CONDITION: spade_len > 4.5
  CONDITION: rule_of_21 <= 0.5
  CONDITION: opp_last_call != '2H'
  CONDITION: competition_level <= 1.5
  # distilled from Brill /bid

RULE BD_False_P475:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call == 'PASS'
  CONDITION: total_points <= 13.5
  CONDITION: my_side_bid_count <= 1.5
  CONDITION: opp_bid_count <= 2.5
  CONDITION: total_points > 11.5
  CONDITION: spade_len > 4.5
  CONDITION: rule_of_21 <= 0.5
  CONDITION: opp_last_call != '2H'
  CONDITION: competition_level > 1.5
  # distilled from Brill /bid

RULE BD_False_P476:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call == 'PASS'
  CONDITION: total_points <= 13.5
  CONDITION: my_side_bid_count <= 1.5
  CONDITION: opp_bid_count <= 2.5
  CONDITION: total_points > 11.5
  CONDITION: spade_len > 4.5
  CONDITION: rule_of_21 > 0.5
  CONDITION: opp_last_call == '2D'
  CONDITION: my_last_call == '1S'
  # distilled from Brill /bid

RULE BD_False_P477:
  CALL: 2S
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call == 'PASS'
  CONDITION: total_points <= 13.5
  CONDITION: my_side_bid_count <= 1.5
  CONDITION: opp_bid_count <= 2.5
  CONDITION: total_points > 11.5
  CONDITION: spade_len > 4.5
  CONDITION: rule_of_21 > 0.5
  CONDITION: opp_last_call == '2D'
  CONDITION: my_last_call != '1S'
  # distilled from Brill /bid

RULE BD_False_P478:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call == 'PASS'
  CONDITION: total_points <= 13.5
  CONDITION: my_side_bid_count <= 1.5
  CONDITION: opp_bid_count <= 2.5
  CONDITION: total_points > 11.5
  CONDITION: spade_len > 4.5
  CONDITION: rule_of_21 > 0.5
  CONDITION: opp_last_call != '2D'
  CONDITION: spade_len <= 5.5
  # distilled from Brill /bid

RULE BD_False_P479:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call == 'PASS'
  CONDITION: total_points <= 13.5
  CONDITION: my_side_bid_count <= 1.5
  CONDITION: opp_bid_count <= 2.5
  CONDITION: total_points > 11.5
  CONDITION: spade_len > 4.5
  CONDITION: rule_of_21 > 0.5
  CONDITION: opp_last_call != '2D'
  CONDITION: spade_len > 5.5
  # distilled from Brill /bid

RULE BD_False_P480:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call == 'PASS'
  CONDITION: total_points <= 13.5
  CONDITION: my_side_bid_count <= 1.5
  CONDITION: opp_bid_count > 2.5
  CONDITION: my_side_bid_count <= 0.5
  CONDITION: total_points <= 10.5
  CONDITION: last_bid_level <= 4.5
  CONDITION: opp_last_call == '2S'
  CONDITION: partner_first_call == 'PASS'
  # distilled from Brill /bid

RULE BD_False_P481:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call == 'PASS'
  CONDITION: total_points <= 13.5
  CONDITION: my_side_bid_count <= 1.5
  CONDITION: opp_bid_count > 2.5
  CONDITION: my_side_bid_count <= 0.5
  CONDITION: total_points <= 10.5
  CONDITION: last_bid_level <= 4.5
  CONDITION: opp_last_call == '2S'
  CONDITION: partner_first_call != 'PASS'
  # distilled from Brill /bid

RULE BD_False_P482:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call == 'PASS'
  CONDITION: total_points <= 13.5
  CONDITION: my_side_bid_count <= 1.5
  CONDITION: opp_bid_count > 2.5
  CONDITION: my_side_bid_count <= 0.5
  CONDITION: total_points <= 10.5
  CONDITION: last_bid_level <= 4.5
  CONDITION: opp_last_call != '2S'
  # distilled from Brill /bid

RULE BD_False_P483:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call == 'PASS'
  CONDITION: total_points <= 13.5
  CONDITION: my_side_bid_count <= 1.5
  CONDITION: opp_bid_count > 2.5
  CONDITION: my_side_bid_count <= 0.5
  CONDITION: total_points <= 10.5
  CONDITION: last_bid_level > 4.5
  CONDITION: opp_suit_stoppers <= 0.75
  # distilled from Brill /bid

RULE BD_False_P484:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call == 'PASS'
  CONDITION: total_points <= 13.5
  CONDITION: my_side_bid_count <= 1.5
  CONDITION: opp_bid_count > 2.5
  CONDITION: my_side_bid_count <= 0.5
  CONDITION: total_points <= 10.5
  CONDITION: last_bid_level > 4.5
  CONDITION: opp_suit_stoppers > 0.75
  CONDITION: spade_len <= 3.5
  # distilled from Brill /bid

RULE BD_False_P485:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call == 'PASS'
  CONDITION: total_points <= 13.5
  CONDITION: my_side_bid_count <= 1.5
  CONDITION: opp_bid_count > 2.5
  CONDITION: my_side_bid_count <= 0.5
  CONDITION: total_points <= 10.5
  CONDITION: last_bid_level > 4.5
  CONDITION: opp_suit_stoppers > 0.75
  CONDITION: spade_len > 3.5
  # distilled from Brill /bid

RULE BD_False_P486:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call == 'PASS'
  CONDITION: total_points <= 13.5
  CONDITION: my_side_bid_count <= 1.5
  CONDITION: opp_bid_count > 2.5
  CONDITION: my_side_bid_count <= 0.5
  CONDITION: total_points > 10.5
  CONDITION: competition_level <= 3.5
  CONDITION: spade_hcp <= 0.5
  CONDITION: club_len <= 5.5
  # distilled from Brill /bid

RULE BD_False_P487:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call == 'PASS'
  CONDITION: total_points <= 13.5
  CONDITION: my_side_bid_count <= 1.5
  CONDITION: opp_bid_count > 2.5
  CONDITION: my_side_bid_count <= 0.5
  CONDITION: total_points > 10.5
  CONDITION: competition_level <= 3.5
  CONDITION: spade_hcp <= 0.5
  CONDITION: club_len > 5.5
  # distilled from Brill /bid

RULE BD_False_P488:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call == 'PASS'
  CONDITION: total_points <= 13.5
  CONDITION: my_side_bid_count <= 1.5
  CONDITION: opp_bid_count > 2.5
  CONDITION: my_side_bid_count <= 0.5
  CONDITION: total_points > 10.5
  CONDITION: competition_level <= 3.5
  CONDITION: spade_hcp > 0.5
  CONDITION: opp_last_call == '2H'
  # distilled from Brill /bid

RULE BD_False_P489:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call == 'PASS'
  CONDITION: total_points <= 13.5
  CONDITION: my_side_bid_count <= 1.5
  CONDITION: opp_bid_count > 2.5
  CONDITION: my_side_bid_count <= 0.5
  CONDITION: total_points > 10.5
  CONDITION: competition_level <= 3.5
  CONDITION: spade_hcp > 0.5
  CONDITION: opp_last_call != '2H'
  # distilled from Brill /bid

RULE BD_False_P490:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call == 'PASS'
  CONDITION: total_points <= 13.5
  CONDITION: my_side_bid_count <= 1.5
  CONDITION: opp_bid_count > 2.5
  CONDITION: my_side_bid_count <= 0.5
  CONDITION: total_points > 10.5
  CONDITION: competition_level > 3.5
  CONDITION: competition_level <= 5.5
  CONDITION: club_len <= 1.5
  # distilled from Brill /bid

RULE BD_False_P491:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call == 'PASS'
  CONDITION: total_points <= 13.5
  CONDITION: my_side_bid_count <= 1.5
  CONDITION: opp_bid_count > 2.5
  CONDITION: my_side_bid_count <= 0.5
  CONDITION: total_points > 10.5
  CONDITION: competition_level > 3.5
  CONDITION: competition_level <= 5.5
  CONDITION: club_len > 1.5
  # distilled from Brill /bid

RULE BD_False_P492:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call == 'PASS'
  CONDITION: total_points <= 13.5
  CONDITION: my_side_bid_count <= 1.5
  CONDITION: opp_bid_count > 2.5
  CONDITION: my_side_bid_count <= 0.5
  CONDITION: total_points > 10.5
  CONDITION: competition_level > 3.5
  CONDITION: competition_level > 5.5
  CONDITION: is_vulnerable <= 0.5
  # distilled from Brill /bid

RULE BD_False_P493:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call == 'PASS'
  CONDITION: total_points <= 13.5
  CONDITION: my_side_bid_count <= 1.5
  CONDITION: opp_bid_count > 2.5
  CONDITION: my_side_bid_count <= 0.5
  CONDITION: total_points > 10.5
  CONDITION: competition_level > 3.5
  CONDITION: competition_level > 5.5
  CONDITION: is_vulnerable > 0.5
  # distilled from Brill /bid

RULE BD_False_P494:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call == 'PASS'
  CONDITION: total_points <= 13.5
  CONDITION: my_side_bid_count <= 1.5
  CONDITION: opp_bid_count > 2.5
  CONDITION: my_side_bid_count > 0.5
  CONDITION: last_bid_level <= 2.5
  CONDITION: competition_level <= 6.5
  CONDITION: c_is_best_minor <= 0.5
  CONDITION: shortest_suit_len <= 1.5
  # distilled from Brill /bid

RULE BD_False_P495:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call == 'PASS'
  CONDITION: total_points <= 13.5
  CONDITION: my_side_bid_count <= 1.5
  CONDITION: opp_bid_count > 2.5
  CONDITION: my_side_bid_count > 0.5
  CONDITION: last_bid_level <= 2.5
  CONDITION: competition_level <= 6.5
  CONDITION: c_is_best_minor <= 0.5
  CONDITION: shortest_suit_len > 1.5
  # distilled from Brill /bid

RULE BD_False_P496:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call == 'PASS'
  CONDITION: total_points <= 13.5
  CONDITION: my_side_bid_count <= 1.5
  CONDITION: opp_bid_count > 2.5
  CONDITION: my_side_bid_count > 0.5
  CONDITION: last_bid_level <= 2.5
  CONDITION: competition_level <= 6.5
  CONDITION: c_is_best_minor > 0.5
  CONDITION: club_len <= 4.5
  # distilled from Brill /bid

RULE BD_False_P497:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call == 'PASS'
  CONDITION: total_points <= 13.5
  CONDITION: my_side_bid_count <= 1.5
  CONDITION: opp_bid_count > 2.5
  CONDITION: my_side_bid_count > 0.5
  CONDITION: last_bid_level <= 2.5
  CONDITION: competition_level <= 6.5
  CONDITION: c_is_best_minor > 0.5
  CONDITION: club_len > 4.5
  # distilled from Brill /bid

RULE BD_False_P498:
  CALL: 2H
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call == 'PASS'
  CONDITION: total_points <= 13.5
  CONDITION: my_side_bid_count <= 1.5
  CONDITION: opp_bid_count > 2.5
  CONDITION: my_side_bid_count > 0.5
  CONDITION: last_bid_level <= 2.5
  CONDITION: competition_level > 6.5
  CONDITION: diamond_len <= 2.5
  # distilled from Brill /bid

RULE BD_False_P499:
  CALL: X
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call == 'PASS'
  CONDITION: total_points <= 13.5
  CONDITION: my_side_bid_count <= 1.5
  CONDITION: opp_bid_count > 2.5
  CONDITION: my_side_bid_count > 0.5
  CONDITION: last_bid_level <= 2.5
  CONDITION: competition_level > 6.5
  CONDITION: diamond_len > 2.5
  # distilled from Brill /bid

RULE BD_False_P500:
  CALL: X
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call == 'PASS'
  CONDITION: total_points <= 13.5
  CONDITION: my_side_bid_count <= 1.5
  CONDITION: opp_bid_count > 2.5
  CONDITION: my_side_bid_count > 0.5
  CONDITION: last_bid_level > 2.5
  CONDITION: support_in_partner_suit <= 3.5
  CONDITION: my_last_call == '5C'
  # distilled from Brill /bid

RULE BD_False_P501:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call == 'PASS'
  CONDITION: total_points <= 13.5
  CONDITION: my_side_bid_count <= 1.5
  CONDITION: opp_bid_count > 2.5
  CONDITION: my_side_bid_count > 0.5
  CONDITION: last_bid_level > 2.5
  CONDITION: support_in_partner_suit <= 3.5
  CONDITION: my_last_call != '5C'
  CONDITION: last_bid_level <= 3.5
  # distilled from Brill /bid

RULE BD_False_P502:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call == 'PASS'
  CONDITION: total_points <= 13.5
  CONDITION: my_side_bid_count <= 1.5
  CONDITION: opp_bid_count > 2.5
  CONDITION: my_side_bid_count > 0.5
  CONDITION: last_bid_level > 2.5
  CONDITION: support_in_partner_suit <= 3.5
  CONDITION: my_last_call != '5C'
  CONDITION: last_bid_level > 3.5
  # distilled from Brill /bid

RULE BD_False_P503:
  CALL: 3S
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call == 'PASS'
  CONDITION: total_points <= 13.5
  CONDITION: my_side_bid_count <= 1.5
  CONDITION: opp_bid_count > 2.5
  CONDITION: my_side_bid_count > 0.5
  CONDITION: last_bid_level > 2.5
  CONDITION: support_in_partner_suit > 3.5
  CONDITION: opp_last_call == '3C'
  CONDITION: partner_last_bid_strain == 'S'
  # distilled from Brill /bid

RULE BD_False_P504:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call == 'PASS'
  CONDITION: total_points <= 13.5
  CONDITION: my_side_bid_count <= 1.5
  CONDITION: opp_bid_count > 2.5
  CONDITION: my_side_bid_count > 0.5
  CONDITION: last_bid_level > 2.5
  CONDITION: support_in_partner_suit > 3.5
  CONDITION: opp_last_call == '3C'
  CONDITION: partner_last_bid_strain != 'S'
  # distilled from Brill /bid

RULE BD_False_P505:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call == 'PASS'
  CONDITION: total_points <= 13.5
  CONDITION: my_side_bid_count <= 1.5
  CONDITION: opp_bid_count > 2.5
  CONDITION: my_side_bid_count > 0.5
  CONDITION: last_bid_level > 2.5
  CONDITION: support_in_partner_suit > 3.5
  CONDITION: opp_last_call != '3C'
  CONDITION: second_longest_len <= 4.5
  # distilled from Brill /bid

RULE BD_False_P506:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call == 'PASS'
  CONDITION: total_points <= 13.5
  CONDITION: my_side_bid_count <= 1.5
  CONDITION: opp_bid_count > 2.5
  CONDITION: my_side_bid_count > 0.5
  CONDITION: last_bid_level > 2.5
  CONDITION: support_in_partner_suit > 3.5
  CONDITION: opp_last_call != '3C'
  CONDITION: second_longest_len > 4.5
  # distilled from Brill /bid

RULE BD_False_P507:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call == 'PASS'
  CONDITION: total_points <= 13.5
  CONDITION: my_side_bid_count > 1.5
  CONDITION: last_bid_level <= 2.5
  CONDITION: spade_len <= 5.5
  CONDITION: total_points <= 9.5
  CONDITION: support_in_partner_suit <= 4.5
  CONDITION: my_first_call == '2H'
  CONDITION: s_is_best_major <= 0.5
  # distilled from Brill /bid

RULE BD_False_P508:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call == 'PASS'
  CONDITION: total_points <= 13.5
  CONDITION: my_side_bid_count > 1.5
  CONDITION: last_bid_level <= 2.5
  CONDITION: spade_len <= 5.5
  CONDITION: total_points <= 9.5
  CONDITION: support_in_partner_suit <= 4.5
  CONDITION: my_first_call == '2H'
  CONDITION: s_is_best_major > 0.5
  # distilled from Brill /bid

RULE BD_False_P509:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call == 'PASS'
  CONDITION: total_points <= 13.5
  CONDITION: my_side_bid_count > 1.5
  CONDITION: last_bid_level <= 2.5
  CONDITION: spade_len <= 5.5
  CONDITION: total_points <= 9.5
  CONDITION: support_in_partner_suit <= 4.5
  CONDITION: my_first_call != '2H'
  CONDITION: partner_first_call == '1C'
  # distilled from Brill /bid

RULE BD_False_P510:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call == 'PASS'
  CONDITION: total_points <= 13.5
  CONDITION: my_side_bid_count > 1.5
  CONDITION: last_bid_level <= 2.5
  CONDITION: spade_len <= 5.5
  CONDITION: total_points <= 9.5
  CONDITION: support_in_partner_suit <= 4.5
  CONDITION: my_first_call != '2H'
  CONDITION: partner_first_call != '1C'
  # distilled from Brill /bid

RULE BD_False_P511:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call == 'PASS'
  CONDITION: total_points <= 13.5
  CONDITION: my_side_bid_count > 1.5
  CONDITION: last_bid_level <= 2.5
  CONDITION: spade_len <= 5.5
  CONDITION: total_points <= 9.5
  CONDITION: support_in_partner_suit > 4.5
  CONDITION: hcp <= 4.5
  # distilled from Brill /bid

RULE BD_False_P512:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call == 'PASS'
  CONDITION: total_points <= 13.5
  CONDITION: my_side_bid_count > 1.5
  CONDITION: last_bid_level <= 2.5
  CONDITION: spade_len <= 5.5
  CONDITION: total_points <= 9.5
  CONDITION: support_in_partner_suit > 4.5
  CONDITION: hcp > 4.5
  CONDITION: c_is_longest <= 0.5
  # distilled from Brill /bid

RULE BD_False_P513:
  CALL: 3C
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call == 'PASS'
  CONDITION: total_points <= 13.5
  CONDITION: my_side_bid_count > 1.5
  CONDITION: last_bid_level <= 2.5
  CONDITION: spade_len <= 5.5
  CONDITION: total_points <= 9.5
  CONDITION: support_in_partner_suit > 4.5
  CONDITION: hcp > 4.5
  CONDITION: c_is_longest > 0.5
  # distilled from Brill /bid

RULE BD_False_P514:
  CALL: 3H
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call == 'PASS'
  CONDITION: total_points <= 13.5
  CONDITION: my_side_bid_count > 1.5
  CONDITION: last_bid_level <= 2.5
  CONDITION: spade_len <= 5.5
  CONDITION: total_points > 9.5
  CONDITION: competition_level <= 4.5
  CONDITION: partner_last_bid_strain == 'H'
  CONDITION: c_has_jack <= 0.5
  # distilled from Brill /bid

RULE BD_False_P515:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call == 'PASS'
  CONDITION: total_points <= 13.5
  CONDITION: my_side_bid_count > 1.5
  CONDITION: last_bid_level <= 2.5
  CONDITION: spade_len <= 5.5
  CONDITION: total_points > 9.5
  CONDITION: competition_level <= 4.5
  CONDITION: partner_last_bid_strain == 'H'
  CONDITION: c_has_jack > 0.5
  # distilled from Brill /bid

RULE BD_False_P516:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call == 'PASS'
  CONDITION: total_points <= 13.5
  CONDITION: my_side_bid_count > 1.5
  CONDITION: last_bid_level <= 2.5
  CONDITION: spade_len <= 5.5
  CONDITION: total_points > 9.5
  CONDITION: competition_level <= 4.5
  CONDITION: partner_last_bid_strain != 'H'
  CONDITION: my_last_call == 'PASS'
  # distilled from Brill /bid

RULE BD_False_P517:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call == 'PASS'
  CONDITION: total_points <= 13.5
  CONDITION: my_side_bid_count > 1.5
  CONDITION: last_bid_level <= 2.5
  CONDITION: spade_len <= 5.5
  CONDITION: total_points > 9.5
  CONDITION: competition_level <= 4.5
  CONDITION: partner_last_bid_strain != 'H'
  CONDITION: my_last_call != 'PASS'
  # distilled from Brill /bid

RULE BD_False_P518:
  CALL: 3C
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call == 'PASS'
  CONDITION: total_points <= 13.5
  CONDITION: my_side_bid_count > 1.5
  CONDITION: last_bid_level <= 2.5
  CONDITION: spade_len <= 5.5
  CONDITION: total_points > 9.5
  CONDITION: competition_level > 4.5
  CONDITION: heart_len <= 3.5
  CONDITION: my_last_call == '2C'
  # distilled from Brill /bid

RULE BD_False_P519:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call == 'PASS'
  CONDITION: total_points <= 13.5
  CONDITION: my_side_bid_count > 1.5
  CONDITION: last_bid_level <= 2.5
  CONDITION: spade_len <= 5.5
  CONDITION: total_points > 9.5
  CONDITION: competition_level > 4.5
  CONDITION: heart_len <= 3.5
  CONDITION: my_last_call != '2C'
  # distilled from Brill /bid

RULE BD_False_P520:
  CALL: 3D
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call == 'PASS'
  CONDITION: total_points <= 13.5
  CONDITION: my_side_bid_count > 1.5
  CONDITION: last_bid_level <= 2.5
  CONDITION: spade_len <= 5.5
  CONDITION: total_points > 9.5
  CONDITION: competition_level > 4.5
  CONDITION: heart_len > 3.5
  CONDITION: partner_first_call == '2D'
  # distilled from Brill /bid

RULE BD_False_P521:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call == 'PASS'
  CONDITION: total_points <= 13.5
  CONDITION: my_side_bid_count > 1.5
  CONDITION: last_bid_level <= 2.5
  CONDITION: spade_len <= 5.5
  CONDITION: total_points > 9.5
  CONDITION: competition_level > 4.5
  CONDITION: heart_len > 3.5
  CONDITION: partner_first_call != '2D'
  # distilled from Brill /bid

RULE BD_False_P522:
  CALL: 2S
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call == 'PASS'
  CONDITION: total_points <= 13.5
  CONDITION: my_side_bid_count > 1.5
  CONDITION: last_bid_level <= 2.5
  CONDITION: spade_len > 5.5
  CONDITION: competition_level <= 5.5
  CONDITION: heart_hcp <= 4.5
  # distilled from Brill /bid

RULE BD_False_P523:
  CALL: X
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call == 'PASS'
  CONDITION: total_points <= 13.5
  CONDITION: my_side_bid_count > 1.5
  CONDITION: last_bid_level <= 2.5
  CONDITION: spade_len > 5.5
  CONDITION: competition_level <= 5.5
  CONDITION: heart_hcp > 4.5
  # distilled from Brill /bid

RULE BD_False_P524:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call == 'PASS'
  CONDITION: total_points <= 13.5
  CONDITION: my_side_bid_count > 1.5
  CONDITION: last_bid_level <= 2.5
  CONDITION: spade_len > 5.5
  CONDITION: competition_level > 5.5
  # distilled from Brill /bid

RULE BD_False_P525:
  CALL: X
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call == 'PASS'
  CONDITION: total_points <= 13.5
  CONDITION: my_side_bid_count > 1.5
  CONDITION: last_bid_level > 2.5
  CONDITION: last_bid_level <= 3.5
  CONDITION: my_last_call == '2S'
  CONDITION: partner_first_call == '1H'
  CONDITION: major_hcp <= 7.0
  CONDITION: diamond_hcp <= 6.0
  # distilled from Brill /bid

RULE BD_False_P526:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call == 'PASS'
  CONDITION: total_points <= 13.5
  CONDITION: my_side_bid_count > 1.5
  CONDITION: last_bid_level > 2.5
  CONDITION: last_bid_level <= 3.5
  CONDITION: my_last_call == '2S'
  CONDITION: partner_first_call == '1H'
  CONDITION: major_hcp <= 7.0
  CONDITION: diamond_hcp > 6.0
  # distilled from Brill /bid

RULE BD_False_P527:
  CALL: 4S
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call == 'PASS'
  CONDITION: total_points <= 13.5
  CONDITION: my_side_bid_count > 1.5
  CONDITION: last_bid_level > 2.5
  CONDITION: last_bid_level <= 3.5
  CONDITION: my_last_call == '2S'
  CONDITION: partner_first_call == '1H'
  CONDITION: major_hcp > 7.0
  # distilled from Brill /bid

RULE BD_False_P528:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call == 'PASS'
  CONDITION: total_points <= 13.5
  CONDITION: my_side_bid_count > 1.5
  CONDITION: last_bid_level > 2.5
  CONDITION: last_bid_level <= 3.5
  CONDITION: my_last_call == '2S'
  CONDITION: partner_first_call != '1H'
  CONDITION: spade_len <= 3.5
  CONDITION: d_has_jack <= 0.5
  # distilled from Brill /bid

RULE BD_False_P529:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call == 'PASS'
  CONDITION: total_points <= 13.5
  CONDITION: my_side_bid_count > 1.5
  CONDITION: last_bid_level > 2.5
  CONDITION: last_bid_level <= 3.5
  CONDITION: my_last_call == '2S'
  CONDITION: partner_first_call != '1H'
  CONDITION: spade_len <= 3.5
  CONDITION: d_has_jack > 0.5
  # distilled from Brill /bid

RULE BD_False_P530:
  CALL: 3S
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call == 'PASS'
  CONDITION: total_points <= 13.5
  CONDITION: my_side_bid_count > 1.5
  CONDITION: last_bid_level > 2.5
  CONDITION: last_bid_level <= 3.5
  CONDITION: my_last_call == '2S'
  CONDITION: partner_first_call != '1H'
  CONDITION: spade_len > 3.5
  CONDITION: hcp <= 10.5
  # distilled from Brill /bid

RULE BD_False_P531:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call == 'PASS'
  CONDITION: total_points <= 13.5
  CONDITION: my_side_bid_count > 1.5
  CONDITION: last_bid_level > 2.5
  CONDITION: last_bid_level <= 3.5
  CONDITION: my_last_call == '2S'
  CONDITION: partner_first_call != '1H'
  CONDITION: spade_len > 3.5
  CONDITION: hcp > 10.5
  # distilled from Brill /bid

RULE BD_False_P532:
  CALL: 3S
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call == 'PASS'
  CONDITION: total_points <= 13.5
  CONDITION: my_side_bid_count > 1.5
  CONDITION: last_bid_level > 2.5
  CONDITION: last_bid_level <= 3.5
  CONDITION: my_last_call != '2S'
  CONDITION: my_last_call == '2H'
  CONDITION: partner_first_call == '1NT'
  CONDITION: jack_count <= 0.5
  # distilled from Brill /bid

RULE BD_False_P533:
  CALL: 4S
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call == 'PASS'
  CONDITION: total_points <= 13.5
  CONDITION: my_side_bid_count > 1.5
  CONDITION: last_bid_level > 2.5
  CONDITION: last_bid_level <= 3.5
  CONDITION: my_last_call != '2S'
  CONDITION: my_last_call == '2H'
  CONDITION: partner_first_call == '1NT'
  CONDITION: jack_count > 0.5
  # distilled from Brill /bid

RULE BD_False_P534:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call == 'PASS'
  CONDITION: total_points <= 13.5
  CONDITION: my_side_bid_count > 1.5
  CONDITION: last_bid_level > 2.5
  CONDITION: last_bid_level <= 3.5
  CONDITION: my_last_call != '2S'
  CONDITION: my_last_call == '2H'
  CONDITION: partner_first_call != '1NT'
  CONDITION: last_bid_seat == 'N'
  # distilled from Brill /bid

RULE BD_False_P535:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call == 'PASS'
  CONDITION: total_points <= 13.5
  CONDITION: my_side_bid_count > 1.5
  CONDITION: last_bid_level > 2.5
  CONDITION: last_bid_level <= 3.5
  CONDITION: my_last_call != '2S'
  CONDITION: my_last_call == '2H'
  CONDITION: partner_first_call != '1NT'
  CONDITION: last_bid_seat != 'N'
  # distilled from Brill /bid

RULE BD_False_P536:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call == 'PASS'
  CONDITION: total_points <= 13.5
  CONDITION: my_side_bid_count > 1.5
  CONDITION: last_bid_level > 2.5
  CONDITION: last_bid_level <= 3.5
  CONDITION: my_last_call != '2S'
  CONDITION: my_last_call != '2H'
  CONDITION: opp_last_call == '3C'
  CONDITION: partner_last_bid_strain == 'S'
  # distilled from Brill /bid

RULE BD_False_P537:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call == 'PASS'
  CONDITION: total_points <= 13.5
  CONDITION: my_side_bid_count > 1.5
  CONDITION: last_bid_level > 2.5
  CONDITION: last_bid_level <= 3.5
  CONDITION: my_last_call != '2S'
  CONDITION: my_last_call != '2H'
  CONDITION: opp_last_call == '3C'
  CONDITION: partner_last_bid_strain != 'S'
  # distilled from Brill /bid

RULE BD_False_P538:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call == 'PASS'
  CONDITION: total_points <= 13.5
  CONDITION: my_side_bid_count > 1.5
  CONDITION: last_bid_level > 2.5
  CONDITION: last_bid_level <= 3.5
  CONDITION: my_last_call != '2S'
  CONDITION: my_last_call != '2H'
  CONDITION: opp_last_call != '3C'
  CONDITION: hcp <= 8.5
  # distilled from Brill /bid

RULE BD_False_P539:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call == 'PASS'
  CONDITION: total_points <= 13.5
  CONDITION: my_side_bid_count > 1.5
  CONDITION: last_bid_level > 2.5
  CONDITION: last_bid_level <= 3.5
  CONDITION: my_last_call != '2S'
  CONDITION: my_last_call != '2H'
  CONDITION: opp_last_call != '3C'
  CONDITION: hcp > 8.5
  # distilled from Brill /bid

RULE BD_False_P540:
  CALL: 5D
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call == 'PASS'
  CONDITION: total_points <= 13.5
  CONDITION: my_side_bid_count > 1.5
  CONDITION: last_bid_level > 2.5
  CONDITION: last_bid_level > 3.5
  CONDITION: heart_len <= 4.5
  CONDITION: my_last_call == '3NT'
  CONDITION: hcp <= 11.0
  # distilled from Brill /bid

RULE BD_False_P541:
  CALL: 5C
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call == 'PASS'
  CONDITION: total_points <= 13.5
  CONDITION: my_side_bid_count > 1.5
  CONDITION: last_bid_level > 2.5
  CONDITION: last_bid_level > 3.5
  CONDITION: heart_len <= 4.5
  CONDITION: my_last_call == '3NT'
  CONDITION: hcp > 11.0
  # distilled from Brill /bid

RULE BD_False_P542:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call == 'PASS'
  CONDITION: total_points <= 13.5
  CONDITION: my_side_bid_count > 1.5
  CONDITION: last_bid_level > 2.5
  CONDITION: last_bid_level > 3.5
  CONDITION: heart_len <= 4.5
  CONDITION: my_last_call != '3NT'
  CONDITION: rule20_total <= 16.5
  CONDITION: partner_opened <= 0.5
  # distilled from Brill /bid

RULE BD_False_P543:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call == 'PASS'
  CONDITION: total_points <= 13.5
  CONDITION: my_side_bid_count > 1.5
  CONDITION: last_bid_level > 2.5
  CONDITION: last_bid_level > 3.5
  CONDITION: heart_len <= 4.5
  CONDITION: my_last_call != '3NT'
  CONDITION: rule20_total <= 16.5
  CONDITION: partner_opened > 0.5
  # distilled from Brill /bid

RULE BD_False_P544:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call == 'PASS'
  CONDITION: total_points <= 13.5
  CONDITION: my_side_bid_count > 1.5
  CONDITION: last_bid_level > 2.5
  CONDITION: last_bid_level > 3.5
  CONDITION: heart_len <= 4.5
  CONDITION: my_last_call != '3NT'
  CONDITION: rule20_total > 16.5
  CONDITION: spade_len <= 1.5
  # distilled from Brill /bid

RULE BD_False_P545:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call == 'PASS'
  CONDITION: total_points <= 13.5
  CONDITION: my_side_bid_count > 1.5
  CONDITION: last_bid_level > 2.5
  CONDITION: last_bid_level > 3.5
  CONDITION: heart_len <= 4.5
  CONDITION: my_last_call != '3NT'
  CONDITION: rule20_total > 16.5
  CONDITION: spade_len > 1.5
  # distilled from Brill /bid

RULE BD_False_P546:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call == 'PASS'
  CONDITION: total_points <= 13.5
  CONDITION: my_side_bid_count > 1.5
  CONDITION: last_bid_level > 2.5
  CONDITION: last_bid_level > 3.5
  CONDITION: heart_len > 4.5
  CONDITION: opp_last_call == '4S'
  CONDITION: my_last_call == '4H'
  CONDITION: spade_hcp <= 2.0
  # distilled from Brill /bid

RULE BD_False_P547:
  CALL: 5H
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call == 'PASS'
  CONDITION: total_points <= 13.5
  CONDITION: my_side_bid_count > 1.5
  CONDITION: last_bid_level > 2.5
  CONDITION: last_bid_level > 3.5
  CONDITION: heart_len > 4.5
  CONDITION: opp_last_call == '4S'
  CONDITION: my_last_call == '4H'
  CONDITION: spade_hcp > 2.0
  # distilled from Brill /bid

RULE BD_False_P548:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call == 'PASS'
  CONDITION: total_points <= 13.5
  CONDITION: my_side_bid_count > 1.5
  CONDITION: last_bid_level > 2.5
  CONDITION: last_bid_level > 3.5
  CONDITION: heart_len > 4.5
  CONDITION: opp_last_call == '4S'
  CONDITION: my_last_call != '4H'
  CONDITION: losing_trick_count <= 6.5
  # distilled from Brill /bid

RULE BD_False_P549:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call == 'PASS'
  CONDITION: total_points <= 13.5
  CONDITION: my_side_bid_count > 1.5
  CONDITION: last_bid_level > 2.5
  CONDITION: last_bid_level > 3.5
  CONDITION: heart_len > 4.5
  CONDITION: opp_last_call == '4S'
  CONDITION: my_last_call != '4H'
  CONDITION: losing_trick_count > 6.5
  # distilled from Brill /bid

RULE BD_False_P550:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call == 'PASS'
  CONDITION: total_points <= 13.5
  CONDITION: my_side_bid_count > 1.5
  CONDITION: last_bid_level > 2.5
  CONDITION: last_bid_level > 3.5
  CONDITION: heart_len > 4.5
  CONDITION: opp_last_call != '4S'
  CONDITION: my_first_call == '4H'
  CONDITION: spade_hcp <= 3.0
  # distilled from Brill /bid

RULE BD_False_P551:
  CALL: X
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call == 'PASS'
  CONDITION: total_points <= 13.5
  CONDITION: my_side_bid_count > 1.5
  CONDITION: last_bid_level > 2.5
  CONDITION: last_bid_level > 3.5
  CONDITION: heart_len > 4.5
  CONDITION: opp_last_call != '4S'
  CONDITION: my_first_call == '4H'
  CONDITION: spade_hcp > 3.0
  # distilled from Brill /bid

RULE BD_False_P552:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call == 'PASS'
  CONDITION: total_points <= 13.5
  CONDITION: my_side_bid_count > 1.5
  CONDITION: last_bid_level > 2.5
  CONDITION: last_bid_level > 3.5
  CONDITION: heart_len > 4.5
  CONDITION: opp_last_call != '4S'
  CONDITION: my_first_call != '4H'
  CONDITION: my_last_call == '4S'
  # distilled from Brill /bid

RULE BD_False_P553:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call == 'PASS'
  CONDITION: total_points <= 13.5
  CONDITION: my_side_bid_count > 1.5
  CONDITION: last_bid_level > 2.5
  CONDITION: last_bid_level > 3.5
  CONDITION: heart_len > 4.5
  CONDITION: opp_last_call != '4S'
  CONDITION: my_first_call != '4H'
  CONDITION: my_last_call != '4S'
  # distilled from Brill /bid

RULE BD_False_P554:
  CALL: X
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call == 'PASS'
  CONDITION: total_points > 13.5
  CONDITION: auction_len <= 3.5
  CONDITION: longest_suit_len <= 5.5
  CONDITION: hcp <= 16.5
  CONDITION: opp_last_call == '2D'
  CONDITION: heart_len <= 4.5
  CONDITION: spade_len <= 4.5
  CONDITION: diamond_hcp <= 3.5
  # distilled from Brill /bid

RULE BD_False_P555:
  CALL: 2NT
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call == 'PASS'
  CONDITION: total_points > 13.5
  CONDITION: auction_len <= 3.5
  CONDITION: longest_suit_len <= 5.5
  CONDITION: hcp <= 16.5
  CONDITION: opp_last_call == '2D'
  CONDITION: heart_len <= 4.5
  CONDITION: spade_len <= 4.5
  CONDITION: diamond_hcp > 3.5
  # distilled from Brill /bid

RULE BD_False_P556:
  CALL: X
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call == 'PASS'
  CONDITION: total_points > 13.5
  CONDITION: auction_len <= 3.5
  CONDITION: longest_suit_len <= 5.5
  CONDITION: hcp <= 16.5
  CONDITION: opp_last_call == '2D'
  CONDITION: heart_len <= 4.5
  CONDITION: spade_len > 4.5
  CONDITION: hcp <= 13.0
  # distilled from Brill /bid

RULE BD_False_P557:
  CALL: 2S
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call == 'PASS'
  CONDITION: total_points > 13.5
  CONDITION: auction_len <= 3.5
  CONDITION: longest_suit_len <= 5.5
  CONDITION: hcp <= 16.5
  CONDITION: opp_last_call == '2D'
  CONDITION: heart_len <= 4.5
  CONDITION: spade_len > 4.5
  CONDITION: hcp > 13.0
  # distilled from Brill /bid

RULE BD_False_P558:
  CALL: 2H
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call == 'PASS'
  CONDITION: total_points > 13.5
  CONDITION: auction_len <= 3.5
  CONDITION: longest_suit_len <= 5.5
  CONDITION: hcp <= 16.5
  CONDITION: opp_last_call == '2D'
  CONDITION: heart_len > 4.5
  CONDITION: spade_len <= 4.5
  CONDITION: hcp <= 13.5
  # distilled from Brill /bid

RULE BD_False_P559:
  CALL: 2H
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call == 'PASS'
  CONDITION: total_points > 13.5
  CONDITION: auction_len <= 3.5
  CONDITION: longest_suit_len <= 5.5
  CONDITION: hcp <= 16.5
  CONDITION: opp_last_call == '2D'
  CONDITION: heart_len > 4.5
  CONDITION: spade_len <= 4.5
  CONDITION: hcp > 13.5
  # distilled from Brill /bid

RULE BD_False_P560:
  CALL: 3D
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call == 'PASS'
  CONDITION: total_points > 13.5
  CONDITION: auction_len <= 3.5
  CONDITION: longest_suit_len <= 5.5
  CONDITION: hcp <= 16.5
  CONDITION: opp_last_call == '2D'
  CONDITION: heart_len > 4.5
  CONDITION: spade_len > 4.5
  # distilled from Brill /bid

RULE BD_False_P561:
  CALL: X
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call == 'PASS'
  CONDITION: total_points > 13.5
  CONDITION: auction_len <= 3.5
  CONDITION: longest_suit_len <= 5.5
  CONDITION: hcp <= 16.5
  CONDITION: opp_last_call != '2D'
  CONDITION: opp_suit_stoppers <= 0.25
  CONDITION: opp_is_in_game <= 0.5
  CONDITION: heart_hcp <= 0.5
  # distilled from Brill /bid

RULE BD_False_P562:
  CALL: X
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call == 'PASS'
  CONDITION: total_points > 13.5
  CONDITION: auction_len <= 3.5
  CONDITION: longest_suit_len <= 5.5
  CONDITION: hcp <= 16.5
  CONDITION: opp_last_call != '2D'
  CONDITION: opp_suit_stoppers <= 0.25
  CONDITION: opp_is_in_game <= 0.5
  CONDITION: heart_hcp > 0.5
  # distilled from Brill /bid

RULE BD_False_P563:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call == 'PASS'
  CONDITION: total_points > 13.5
  CONDITION: auction_len <= 3.5
  CONDITION: longest_suit_len <= 5.5
  CONDITION: hcp <= 16.5
  CONDITION: opp_last_call != '2D'
  CONDITION: opp_suit_stoppers <= 0.25
  CONDITION: opp_is_in_game > 0.5
  CONDITION: hcp <= 13.5
  # distilled from Brill /bid

RULE BD_False_P564:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call == 'PASS'
  CONDITION: total_points > 13.5
  CONDITION: auction_len <= 3.5
  CONDITION: longest_suit_len <= 5.5
  CONDITION: hcp <= 16.5
  CONDITION: opp_last_call != '2D'
  CONDITION: opp_suit_stoppers <= 0.25
  CONDITION: opp_is_in_game > 0.5
  CONDITION: hcp > 13.5
  # distilled from Brill /bid

RULE BD_False_P565:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call == 'PASS'
  CONDITION: total_points > 13.5
  CONDITION: auction_len <= 3.5
  CONDITION: longest_suit_len <= 5.5
  CONDITION: hcp <= 16.5
  CONDITION: opp_last_call != '2D'
  CONDITION: opp_suit_stoppers > 0.25
  CONDITION: opp_bid_count <= 1.5
  CONDITION: rule20_total <= 22.5
  # distilled from Brill /bid

RULE BD_False_P566:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call == 'PASS'
  CONDITION: total_points > 13.5
  CONDITION: auction_len <= 3.5
  CONDITION: longest_suit_len <= 5.5
  CONDITION: hcp <= 16.5
  CONDITION: opp_last_call != '2D'
  CONDITION: opp_suit_stoppers > 0.25
  CONDITION: opp_bid_count <= 1.5
  CONDITION: rule20_total > 22.5
  # distilled from Brill /bid

RULE BD_False_P567:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call == 'PASS'
  CONDITION: total_points > 13.5
  CONDITION: auction_len <= 3.5
  CONDITION: longest_suit_len <= 5.5
  CONDITION: hcp <= 16.5
  CONDITION: opp_last_call != '2D'
  CONDITION: opp_suit_stoppers > 0.25
  CONDITION: opp_bid_count > 1.5
  CONDITION: rule20_total <= 23.5
  # distilled from Brill /bid

RULE BD_False_P568:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call == 'PASS'
  CONDITION: total_points > 13.5
  CONDITION: auction_len <= 3.5
  CONDITION: longest_suit_len <= 5.5
  CONDITION: hcp <= 16.5
  CONDITION: opp_last_call != '2D'
  CONDITION: opp_suit_stoppers > 0.25
  CONDITION: opp_bid_count > 1.5
  CONDITION: rule20_total > 23.5
  # distilled from Brill /bid

RULE BD_False_P569:
  CALL: X
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call == 'PASS'
  CONDITION: total_points > 13.5
  CONDITION: auction_len <= 3.5
  CONDITION: longest_suit_len <= 5.5
  CONDITION: hcp > 16.5
  CONDITION: opp_suit_stoppers <= 0.75
  CONDITION: quick_tricks <= 4.25
  CONDITION: singleton_count <= 0.5
  CONDITION: club_len <= 4.5
  # distilled from Brill /bid

RULE BD_False_P570:
  CALL: 3C
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call == 'PASS'
  CONDITION: total_points > 13.5
  CONDITION: auction_len <= 3.5
  CONDITION: longest_suit_len <= 5.5
  CONDITION: hcp > 16.5
  CONDITION: opp_suit_stoppers <= 0.75
  CONDITION: quick_tricks <= 4.25
  CONDITION: singleton_count <= 0.5
  CONDITION: club_len > 4.5
  # distilled from Brill /bid

RULE BD_False_P571:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call == 'PASS'
  CONDITION: total_points > 13.5
  CONDITION: auction_len <= 3.5
  CONDITION: longest_suit_len <= 5.5
  CONDITION: hcp > 16.5
  CONDITION: opp_suit_stoppers <= 0.75
  CONDITION: quick_tricks <= 4.25
  CONDITION: singleton_count > 0.5
  CONDITION: spade_len <= 4.5
  # distilled from Brill /bid

RULE BD_False_P572:
  CALL: 2S
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call == 'PASS'
  CONDITION: total_points > 13.5
  CONDITION: auction_len <= 3.5
  CONDITION: longest_suit_len <= 5.5
  CONDITION: hcp > 16.5
  CONDITION: opp_suit_stoppers <= 0.75
  CONDITION: quick_tricks <= 4.25
  CONDITION: singleton_count > 0.5
  CONDITION: spade_len > 4.5
  # distilled from Brill /bid

RULE BD_False_P573:
  CALL: X
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call == 'PASS'
  CONDITION: total_points > 13.5
  CONDITION: auction_len <= 3.5
  CONDITION: longest_suit_len <= 5.5
  CONDITION: hcp > 16.5
  CONDITION: opp_suit_stoppers <= 0.75
  CONDITION: quick_tricks > 4.25
  CONDITION: hcp <= 23.0
  # distilled from Brill /bid

RULE BD_False_P574:
  CALL: 4NT
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call == 'PASS'
  CONDITION: total_points > 13.5
  CONDITION: auction_len <= 3.5
  CONDITION: longest_suit_len <= 5.5
  CONDITION: hcp > 16.5
  CONDITION: opp_suit_stoppers <= 0.75
  CONDITION: quick_tricks > 4.25
  CONDITION: hcp > 23.0
  # distilled from Brill /bid

RULE BD_False_P575:
  CALL: X
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call == 'PASS'
  CONDITION: total_points > 13.5
  CONDITION: auction_len <= 3.5
  CONDITION: longest_suit_len <= 5.5
  CONDITION: hcp > 16.5
  CONDITION: opp_suit_stoppers > 0.75
  CONDITION: hcp <= 18.5
  CONDITION: last_bid_level <= 2.5
  CONDITION: shortest_suit_len <= 1.5
  # distilled from Brill /bid

RULE BD_False_P576:
  CALL: 2NT
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call == 'PASS'
  CONDITION: total_points > 13.5
  CONDITION: auction_len <= 3.5
  CONDITION: longest_suit_len <= 5.5
  CONDITION: hcp > 16.5
  CONDITION: opp_suit_stoppers > 0.75
  CONDITION: hcp <= 18.5
  CONDITION: last_bid_level <= 2.5
  CONDITION: shortest_suit_len > 1.5
  # distilled from Brill /bid

RULE BD_False_P577:
  CALL: 3NT
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call == 'PASS'
  CONDITION: total_points > 13.5
  CONDITION: auction_len <= 3.5
  CONDITION: longest_suit_len <= 5.5
  CONDITION: hcp > 16.5
  CONDITION: opp_suit_stoppers > 0.75
  CONDITION: hcp <= 18.5
  CONDITION: last_bid_level > 2.5
  CONDITION: d_has_ten <= 0.5
  # distilled from Brill /bid

RULE BD_False_P578:
  CALL: X
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call == 'PASS'
  CONDITION: total_points > 13.5
  CONDITION: auction_len <= 3.5
  CONDITION: longest_suit_len <= 5.5
  CONDITION: hcp > 16.5
  CONDITION: opp_suit_stoppers > 0.75
  CONDITION: hcp <= 18.5
  CONDITION: last_bid_level > 2.5
  CONDITION: d_has_ten > 0.5
  # distilled from Brill /bid

RULE BD_False_P579:
  CALL: 3NT
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call == 'PASS'
  CONDITION: total_points > 13.5
  CONDITION: auction_len <= 3.5
  CONDITION: longest_suit_len <= 5.5
  CONDITION: hcp > 16.5
  CONDITION: opp_suit_stoppers > 0.75
  CONDITION: hcp > 18.5
  CONDITION: last_bid_level <= 3.5
  CONDITION: rule20_total <= 30.5
  # distilled from Brill /bid

RULE BD_False_P580:
  CALL: 3S
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call == 'PASS'
  CONDITION: total_points > 13.5
  CONDITION: auction_len <= 3.5
  CONDITION: longest_suit_len <= 5.5
  CONDITION: hcp > 16.5
  CONDITION: opp_suit_stoppers > 0.75
  CONDITION: hcp > 18.5
  CONDITION: last_bid_level <= 3.5
  CONDITION: rule20_total > 30.5
  # distilled from Brill /bid

RULE BD_False_P581:
  CALL: X
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call == 'PASS'
  CONDITION: total_points > 13.5
  CONDITION: auction_len <= 3.5
  CONDITION: longest_suit_len <= 5.5
  CONDITION: hcp > 16.5
  CONDITION: opp_suit_stoppers > 0.75
  CONDITION: hcp > 18.5
  CONDITION: last_bid_level > 3.5
  # distilled from Brill /bid

RULE BD_False_P582:
  CALL: 4NT
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call == 'PASS'
  CONDITION: total_points > 13.5
  CONDITION: auction_len <= 3.5
  CONDITION: longest_suit_len > 5.5
  CONDITION: spade_len <= 5.5
  CONDITION: club_len <= 5.5
  CONDITION: heart_len <= 5.5
  CONDITION: hcp <= 14.5
  CONDITION: losing_trick_count <= 4.5
  # distilled from Brill /bid

RULE BD_False_P583:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call == 'PASS'
  CONDITION: total_points > 13.5
  CONDITION: auction_len <= 3.5
  CONDITION: longest_suit_len > 5.5
  CONDITION: spade_len <= 5.5
  CONDITION: club_len <= 5.5
  CONDITION: heart_len <= 5.5
  CONDITION: hcp <= 14.5
  CONDITION: losing_trick_count > 4.5
  # distilled from Brill /bid

RULE BD_False_P584:
  CALL: 3D
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call == 'PASS'
  CONDITION: total_points > 13.5
  CONDITION: auction_len <= 3.5
  CONDITION: longest_suit_len > 5.5
  CONDITION: spade_len <= 5.5
  CONDITION: club_len <= 5.5
  CONDITION: heart_len <= 5.5
  CONDITION: hcp > 14.5
  CONDITION: opp_first_bid_level <= 2.5
  # distilled from Brill /bid

RULE BD_False_P585:
  CALL: 4D
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call == 'PASS'
  CONDITION: total_points > 13.5
  CONDITION: auction_len <= 3.5
  CONDITION: longest_suit_len > 5.5
  CONDITION: spade_len <= 5.5
  CONDITION: club_len <= 5.5
  CONDITION: heart_len <= 5.5
  CONDITION: hcp > 14.5
  CONDITION: opp_first_bid_level > 2.5
  # distilled from Brill /bid

RULE BD_False_P586:
  CALL: 4H
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call == 'PASS'
  CONDITION: total_points > 13.5
  CONDITION: auction_len <= 3.5
  CONDITION: longest_suit_len > 5.5
  CONDITION: spade_len <= 5.5
  CONDITION: club_len <= 5.5
  CONDITION: heart_len > 5.5
  CONDITION: opp_last_call == '2D'
  CONDITION: is_vulnerable <= 0.5
  # distilled from Brill /bid

RULE BD_False_P587:
  CALL: 2H
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call == 'PASS'
  CONDITION: total_points > 13.5
  CONDITION: auction_len <= 3.5
  CONDITION: longest_suit_len > 5.5
  CONDITION: spade_len <= 5.5
  CONDITION: club_len <= 5.5
  CONDITION: heart_len > 5.5
  CONDITION: opp_last_call == '2D'
  CONDITION: is_vulnerable > 0.5
  # distilled from Brill /bid

RULE BD_False_P588:
  CALL: 4H
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call == 'PASS'
  CONDITION: total_points > 13.5
  CONDITION: auction_len <= 3.5
  CONDITION: longest_suit_len > 5.5
  CONDITION: spade_len <= 5.5
  CONDITION: club_len <= 5.5
  CONDITION: heart_len > 5.5
  CONDITION: opp_last_call != '2D'
  CONDITION: losing_trick_count <= 4.5
  # distilled from Brill /bid

RULE BD_False_P589:
  CALL: 3H
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call == 'PASS'
  CONDITION: total_points > 13.5
  CONDITION: auction_len <= 3.5
  CONDITION: longest_suit_len > 5.5
  CONDITION: spade_len <= 5.5
  CONDITION: club_len <= 5.5
  CONDITION: heart_len > 5.5
  CONDITION: opp_last_call != '2D'
  CONDITION: losing_trick_count > 4.5
  # distilled from Brill /bid

RULE BD_False_P590:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call == 'PASS'
  CONDITION: total_points > 13.5
  CONDITION: auction_len <= 3.5
  CONDITION: longest_suit_len > 5.5
  CONDITION: spade_len <= 5.5
  CONDITION: club_len > 5.5
  CONDITION: last_bid_level <= 2.5
  CONDITION: rule20_total <= 24.5
  CONDITION: singleton_count <= 1.5
  # distilled from Brill /bid

RULE BD_False_P591:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call == 'PASS'
  CONDITION: total_points > 13.5
  CONDITION: auction_len <= 3.5
  CONDITION: longest_suit_len > 5.5
  CONDITION: spade_len <= 5.5
  CONDITION: club_len > 5.5
  CONDITION: last_bid_level <= 2.5
  CONDITION: rule20_total <= 24.5
  CONDITION: singleton_count > 1.5
  # distilled from Brill /bid

RULE BD_False_P592:
  CALL: 3C
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call == 'PASS'
  CONDITION: total_points > 13.5
  CONDITION: auction_len <= 3.5
  CONDITION: longest_suit_len > 5.5
  CONDITION: spade_len <= 5.5
  CONDITION: club_len > 5.5
  CONDITION: last_bid_level <= 2.5
  CONDITION: rule20_total > 24.5
  CONDITION: last_bid_strain == 'D'
  # distilled from Brill /bid

RULE BD_False_P593:
  CALL: X
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call == 'PASS'
  CONDITION: total_points > 13.5
  CONDITION: auction_len <= 3.5
  CONDITION: longest_suit_len > 5.5
  CONDITION: spade_len <= 5.5
  CONDITION: club_len > 5.5
  CONDITION: last_bid_level <= 2.5
  CONDITION: rule20_total > 24.5
  CONDITION: last_bid_strain != 'D'
  # distilled from Brill /bid

RULE BD_False_P594:
  CALL: 4C
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call == 'PASS'
  CONDITION: total_points > 13.5
  CONDITION: auction_len <= 3.5
  CONDITION: longest_suit_len > 5.5
  CONDITION: spade_len <= 5.5
  CONDITION: club_len > 5.5
  CONDITION: last_bid_level > 2.5
  CONDITION: last_bid_level <= 3.5
  CONDITION: h_has_jack <= 0.5
  # distilled from Brill /bid

RULE BD_False_P595:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call == 'PASS'
  CONDITION: total_points > 13.5
  CONDITION: auction_len <= 3.5
  CONDITION: longest_suit_len > 5.5
  CONDITION: spade_len <= 5.5
  CONDITION: club_len > 5.5
  CONDITION: last_bid_level > 2.5
  CONDITION: last_bid_level <= 3.5
  CONDITION: h_has_jack > 0.5
  # distilled from Brill /bid

RULE BD_False_P596:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call == 'PASS'
  CONDITION: total_points > 13.5
  CONDITION: auction_len <= 3.5
  CONDITION: longest_suit_len > 5.5
  CONDITION: spade_len <= 5.5
  CONDITION: club_len > 5.5
  CONDITION: last_bid_level > 2.5
  CONDITION: last_bid_level > 3.5
  CONDITION: minor_hcp <= 10.5
  # distilled from Brill /bid

RULE BD_False_P597:
  CALL: 5C
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call == 'PASS'
  CONDITION: total_points > 13.5
  CONDITION: auction_len <= 3.5
  CONDITION: longest_suit_len > 5.5
  CONDITION: spade_len <= 5.5
  CONDITION: club_len > 5.5
  CONDITION: last_bid_level > 2.5
  CONDITION: last_bid_level > 3.5
  CONDITION: minor_hcp > 10.5
  # distilled from Brill /bid

RULE BD_False_P598:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call == 'PASS'
  CONDITION: total_points > 13.5
  CONDITION: auction_len <= 3.5
  CONDITION: longest_suit_len > 5.5
  CONDITION: spade_len > 5.5
  CONDITION: last_bid_level <= 2.5
  CONDITION: heart_hcp <= 2.5
  CONDITION: hcp <= 12.5
  CONDITION: major_hcp <= 5.5
  # distilled from Brill /bid

RULE BD_False_P599:
  CALL: 3S
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call == 'PASS'
  CONDITION: total_points > 13.5
  CONDITION: auction_len <= 3.5
  CONDITION: longest_suit_len > 5.5
  CONDITION: spade_len > 5.5
  CONDITION: last_bid_level <= 2.5
  CONDITION: heart_hcp <= 2.5
  CONDITION: hcp <= 12.5
  CONDITION: major_hcp > 5.5
  # distilled from Brill /bid

RULE BD_False_P600:
  CALL: 2S
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call == 'PASS'
  CONDITION: total_points > 13.5
  CONDITION: auction_len <= 3.5
  CONDITION: longest_suit_len > 5.5
  CONDITION: spade_len > 5.5
  CONDITION: last_bid_level <= 2.5
  CONDITION: heart_hcp <= 2.5
  CONDITION: hcp > 12.5
  CONDITION: second_longest_len <= 4.5
  # distilled from Brill /bid

RULE BD_False_P601:
  CALL: 3H
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call == 'PASS'
  CONDITION: total_points > 13.5
  CONDITION: auction_len <= 3.5
  CONDITION: longest_suit_len > 5.5
  CONDITION: spade_len > 5.5
  CONDITION: last_bid_level <= 2.5
  CONDITION: heart_hcp <= 2.5
  CONDITION: hcp > 12.5
  CONDITION: second_longest_len > 4.5
  # distilled from Brill /bid

RULE BD_False_P602:
  CALL: 2S
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call == 'PASS'
  CONDITION: total_points > 13.5
  CONDITION: auction_len <= 3.5
  CONDITION: longest_suit_len > 5.5
  CONDITION: spade_len > 5.5
  CONDITION: last_bid_level <= 2.5
  CONDITION: heart_hcp > 2.5
  CONDITION: spade_len <= 6.5
  # distilled from Brill /bid

RULE BD_False_P603:
  CALL: 2S
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call == 'PASS'
  CONDITION: total_points > 13.5
  CONDITION: auction_len <= 3.5
  CONDITION: longest_suit_len > 5.5
  CONDITION: spade_len > 5.5
  CONDITION: last_bid_level <= 2.5
  CONDITION: heart_hcp > 2.5
  CONDITION: spade_len > 6.5
  CONDITION: minor_hcp <= 2.5
  # distilled from Brill /bid

RULE BD_False_P604:
  CALL: 4S
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call == 'PASS'
  CONDITION: total_points > 13.5
  CONDITION: auction_len <= 3.5
  CONDITION: longest_suit_len > 5.5
  CONDITION: spade_len > 5.5
  CONDITION: last_bid_level <= 2.5
  CONDITION: heart_hcp > 2.5
  CONDITION: spade_len > 6.5
  CONDITION: minor_hcp > 2.5
  # distilled from Brill /bid

RULE BD_False_P605:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call == 'PASS'
  CONDITION: total_points > 13.5
  CONDITION: auction_len <= 3.5
  CONDITION: longest_suit_len > 5.5
  CONDITION: spade_len > 5.5
  CONDITION: last_bid_level > 2.5
  CONDITION: total_points <= 17.5
  CONDITION: c_has_king <= 0.5
  CONDITION: s_has_ace <= 0.5
  # distilled from Brill /bid

RULE BD_False_P606:
  CALL: 3S
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call == 'PASS'
  CONDITION: total_points > 13.5
  CONDITION: auction_len <= 3.5
  CONDITION: longest_suit_len > 5.5
  CONDITION: spade_len > 5.5
  CONDITION: last_bid_level > 2.5
  CONDITION: total_points <= 17.5
  CONDITION: c_has_king <= 0.5
  CONDITION: s_has_ace > 0.5
  # distilled from Brill /bid

RULE BD_False_P607:
  CALL: 4S
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call == 'PASS'
  CONDITION: total_points > 13.5
  CONDITION: auction_len <= 3.5
  CONDITION: longest_suit_len > 5.5
  CONDITION: spade_len > 5.5
  CONDITION: last_bid_level > 2.5
  CONDITION: total_points <= 17.5
  CONDITION: c_has_king > 0.5
  CONDITION: major_hcp <= 9.0
  # distilled from Brill /bid

RULE BD_False_P608:
  CALL: 4D
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call == 'PASS'
  CONDITION: total_points > 13.5
  CONDITION: auction_len <= 3.5
  CONDITION: longest_suit_len > 5.5
  CONDITION: spade_len > 5.5
  CONDITION: last_bid_level > 2.5
  CONDITION: total_points <= 17.5
  CONDITION: c_has_king > 0.5
  CONDITION: major_hcp > 9.0
  # distilled from Brill /bid

RULE BD_False_P609:
  CALL: 4S
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call == 'PASS'
  CONDITION: total_points > 13.5
  CONDITION: auction_len <= 3.5
  CONDITION: longest_suit_len > 5.5
  CONDITION: spade_len > 5.5
  CONDITION: last_bid_level > 2.5
  CONDITION: total_points > 17.5
  CONDITION: second_longest_len <= 4.5
  CONDITION: spade_hcp <= 9.5
  # distilled from Brill /bid

RULE BD_False_P610:
  CALL: 5S
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call == 'PASS'
  CONDITION: total_points > 13.5
  CONDITION: auction_len <= 3.5
  CONDITION: longest_suit_len > 5.5
  CONDITION: spade_len > 5.5
  CONDITION: last_bid_level > 2.5
  CONDITION: total_points > 17.5
  CONDITION: second_longest_len <= 4.5
  CONDITION: spade_hcp > 9.5
  # distilled from Brill /bid

RULE BD_False_P611:
  CALL: 3NT
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call == 'PASS'
  CONDITION: total_points > 13.5
  CONDITION: auction_len <= 3.5
  CONDITION: longest_suit_len > 5.5
  CONDITION: spade_len > 5.5
  CONDITION: last_bid_level > 2.5
  CONDITION: total_points > 17.5
  CONDITION: second_longest_len > 4.5
  CONDITION: hcp <= 17.5
  # distilled from Brill /bid

RULE BD_False_P612:
  CALL: 3S
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call == 'PASS'
  CONDITION: total_points > 13.5
  CONDITION: auction_len <= 3.5
  CONDITION: longest_suit_len > 5.5
  CONDITION: spade_len > 5.5
  CONDITION: last_bid_level > 2.5
  CONDITION: total_points > 17.5
  CONDITION: second_longest_len > 4.5
  CONDITION: hcp > 17.5
  # distilled from Brill /bid

RULE BD_False_P613:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call == 'PASS'
  CONDITION: total_points > 13.5
  CONDITION: auction_len > 3.5
  CONDITION: spade_len <= 5.5
  CONDITION: total_points <= 17.5
  CONDITION: last_bid_level <= 2.5
  CONDITION: longest_suit_len <= 5.5
  CONDITION: partner_first_call == 'PASS'
  CONDITION: total_points <= 15.5
  # distilled from Brill /bid

RULE BD_False_P614:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call == 'PASS'
  CONDITION: total_points > 13.5
  CONDITION: auction_len > 3.5
  CONDITION: spade_len <= 5.5
  CONDITION: total_points <= 17.5
  CONDITION: last_bid_level <= 2.5
  CONDITION: longest_suit_len <= 5.5
  CONDITION: partner_first_call == 'PASS'
  CONDITION: total_points > 15.5
  # distilled from Brill /bid

RULE BD_False_P615:
  CALL: 3NT
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call == 'PASS'
  CONDITION: total_points > 13.5
  CONDITION: auction_len > 3.5
  CONDITION: spade_len <= 5.5
  CONDITION: total_points <= 17.5
  CONDITION: last_bid_level <= 2.5
  CONDITION: longest_suit_len <= 5.5
  CONDITION: partner_first_call != 'PASS'
  CONDITION: my_last_call == 'XX'
  # distilled from Brill /bid

RULE BD_False_P616:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call == 'PASS'
  CONDITION: total_points > 13.5
  CONDITION: auction_len > 3.5
  CONDITION: spade_len <= 5.5
  CONDITION: total_points <= 17.5
  CONDITION: last_bid_level <= 2.5
  CONDITION: longest_suit_len <= 5.5
  CONDITION: partner_first_call != 'PASS'
  CONDITION: my_last_call != 'XX'
  # distilled from Brill /bid

RULE BD_False_P617:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call == 'PASS'
  CONDITION: total_points > 13.5
  CONDITION: auction_len > 3.5
  CONDITION: spade_len <= 5.5
  CONDITION: total_points <= 17.5
  CONDITION: last_bid_level <= 2.5
  CONDITION: longest_suit_len > 5.5
  CONDITION: club_len <= 5.5
  CONDITION: heart_len <= 5.5
  # distilled from Brill /bid

RULE BD_False_P618:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call == 'PASS'
  CONDITION: total_points > 13.5
  CONDITION: auction_len > 3.5
  CONDITION: spade_len <= 5.5
  CONDITION: total_points <= 17.5
  CONDITION: last_bid_level <= 2.5
  CONDITION: longest_suit_len > 5.5
  CONDITION: club_len <= 5.5
  CONDITION: heart_len > 5.5
  # distilled from Brill /bid

RULE BD_False_P619:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call == 'PASS'
  CONDITION: total_points > 13.5
  CONDITION: auction_len > 3.5
  CONDITION: spade_len <= 5.5
  CONDITION: total_points <= 17.5
  CONDITION: last_bid_level <= 2.5
  CONDITION: longest_suit_len > 5.5
  CONDITION: club_len > 5.5
  CONDITION: my_last_call == '1C'
  # distilled from Brill /bid

RULE BD_False_P620:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call == 'PASS'
  CONDITION: total_points > 13.5
  CONDITION: auction_len > 3.5
  CONDITION: spade_len <= 5.5
  CONDITION: total_points <= 17.5
  CONDITION: last_bid_level <= 2.5
  CONDITION: longest_suit_len > 5.5
  CONDITION: club_len > 5.5
  CONDITION: my_last_call != '1C'
  # distilled from Brill /bid

RULE BD_False_P621:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call == 'PASS'
  CONDITION: total_points > 13.5
  CONDITION: auction_len > 3.5
  CONDITION: spade_len <= 5.5
  CONDITION: total_points <= 17.5
  CONDITION: last_bid_level > 2.5
  CONDITION: partner_last_bid_strain == 'NONE'
  CONDITION: opp_is_in_game <= 0.5
  CONDITION: diamond_len <= 5.5
  # distilled from Brill /bid

RULE BD_False_P622:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call == 'PASS'
  CONDITION: total_points > 13.5
  CONDITION: auction_len > 3.5
  CONDITION: spade_len <= 5.5
  CONDITION: total_points <= 17.5
  CONDITION: last_bid_level > 2.5
  CONDITION: partner_last_bid_strain == 'NONE'
  CONDITION: opp_is_in_game <= 0.5
  CONDITION: diamond_len > 5.5
  # distilled from Brill /bid

RULE BD_False_P623:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call == 'PASS'
  CONDITION: total_points > 13.5
  CONDITION: auction_len > 3.5
  CONDITION: spade_len <= 5.5
  CONDITION: total_points <= 17.5
  CONDITION: last_bid_level > 2.5
  CONDITION: partner_last_bid_strain == 'NONE'
  CONDITION: opp_is_in_game > 0.5
  CONDITION: my_side_bid_count <= 1.5
  # distilled from Brill /bid

RULE BD_False_P624:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call == 'PASS'
  CONDITION: total_points > 13.5
  CONDITION: auction_len > 3.5
  CONDITION: spade_len <= 5.5
  CONDITION: total_points <= 17.5
  CONDITION: last_bid_level > 2.5
  CONDITION: partner_last_bid_strain == 'NONE'
  CONDITION: opp_is_in_game > 0.5
  CONDITION: my_side_bid_count > 1.5
  # distilled from Brill /bid

RULE BD_False_P625:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call == 'PASS'
  CONDITION: total_points > 13.5
  CONDITION: auction_len > 3.5
  CONDITION: spade_len <= 5.5
  CONDITION: total_points <= 17.5
  CONDITION: last_bid_level > 2.5
  CONDITION: partner_last_bid_strain != 'NONE'
  CONDITION: auction_len <= 7.5
  CONDITION: s_has_ace <= 0.5
  # distilled from Brill /bid

RULE BD_False_P626:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call == 'PASS'
  CONDITION: total_points > 13.5
  CONDITION: auction_len > 3.5
  CONDITION: spade_len <= 5.5
  CONDITION: total_points <= 17.5
  CONDITION: last_bid_level > 2.5
  CONDITION: partner_last_bid_strain != 'NONE'
  CONDITION: auction_len <= 7.5
  CONDITION: s_has_ace > 0.5
  # distilled from Brill /bid

RULE BD_False_P627:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call == 'PASS'
  CONDITION: total_points > 13.5
  CONDITION: auction_len > 3.5
  CONDITION: spade_len <= 5.5
  CONDITION: total_points <= 17.5
  CONDITION: last_bid_level > 2.5
  CONDITION: partner_last_bid_strain != 'NONE'
  CONDITION: auction_len > 7.5
  CONDITION: opp_is_in_game <= 0.5
  # distilled from Brill /bid

RULE BD_False_P628:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call == 'PASS'
  CONDITION: total_points > 13.5
  CONDITION: auction_len > 3.5
  CONDITION: spade_len <= 5.5
  CONDITION: total_points <= 17.5
  CONDITION: last_bid_level > 2.5
  CONDITION: partner_last_bid_strain != 'NONE'
  CONDITION: auction_len > 7.5
  CONDITION: opp_is_in_game > 0.5
  # distilled from Brill /bid

RULE BD_False_P629:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call == 'PASS'
  CONDITION: total_points > 13.5
  CONDITION: auction_len > 3.5
  CONDITION: spade_len <= 5.5
  CONDITION: total_points > 17.5
  CONDITION: last_bid_level <= 2.5
  CONDITION: longest_suit_len <= 5.5
  CONDITION: competition_level <= 3.5
  CONDITION: heart_len <= 3.5
  # distilled from Brill /bid

RULE BD_False_P630:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call == 'PASS'
  CONDITION: total_points > 13.5
  CONDITION: auction_len > 3.5
  CONDITION: spade_len <= 5.5
  CONDITION: total_points > 17.5
  CONDITION: last_bid_level <= 2.5
  CONDITION: longest_suit_len <= 5.5
  CONDITION: competition_level <= 3.5
  CONDITION: heart_len > 3.5
  # distilled from Brill /bid

RULE BD_False_P631:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call == 'PASS'
  CONDITION: total_points > 13.5
  CONDITION: auction_len > 3.5
  CONDITION: spade_len <= 5.5
  CONDITION: total_points > 17.5
  CONDITION: last_bid_level <= 2.5
  CONDITION: longest_suit_len <= 5.5
  CONDITION: competition_level > 3.5
  CONDITION: support_in_partner_suit <= 4.5
  # distilled from Brill /bid

RULE BD_False_P632:
  CALL: 3D
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call == 'PASS'
  CONDITION: total_points > 13.5
  CONDITION: auction_len > 3.5
  CONDITION: spade_len <= 5.5
  CONDITION: total_points > 17.5
  CONDITION: last_bid_level <= 2.5
  CONDITION: longest_suit_len <= 5.5
  CONDITION: competition_level > 3.5
  CONDITION: support_in_partner_suit > 4.5
  # distilled from Brill /bid

RULE BD_False_P633:
  CALL: 3C
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call == 'PASS'
  CONDITION: total_points > 13.5
  CONDITION: auction_len > 3.5
  CONDITION: spade_len <= 5.5
  CONDITION: total_points > 17.5
  CONDITION: last_bid_level <= 2.5
  CONDITION: longest_suit_len > 5.5
  CONDITION: d_top3_honors <= 1.5
  CONDITION: heart_len <= 3.5
  # distilled from Brill /bid

RULE BD_False_P634:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call == 'PASS'
  CONDITION: total_points > 13.5
  CONDITION: auction_len > 3.5
  CONDITION: spade_len <= 5.5
  CONDITION: total_points > 17.5
  CONDITION: last_bid_level <= 2.5
  CONDITION: longest_suit_len > 5.5
  CONDITION: d_top3_honors <= 1.5
  CONDITION: heart_len > 3.5
  # distilled from Brill /bid

RULE BD_False_P635:
  CALL: 3D
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call == 'PASS'
  CONDITION: total_points > 13.5
  CONDITION: auction_len > 3.5
  CONDITION: spade_len <= 5.5
  CONDITION: total_points > 17.5
  CONDITION: last_bid_level <= 2.5
  CONDITION: longest_suit_len > 5.5
  CONDITION: d_top3_honors > 1.5
  CONDITION: minor_hcp <= 10.5
  # distilled from Brill /bid

RULE BD_False_P636:
  CALL: 3D
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call == 'PASS'
  CONDITION: total_points > 13.5
  CONDITION: auction_len > 3.5
  CONDITION: spade_len <= 5.5
  CONDITION: total_points > 17.5
  CONDITION: last_bid_level <= 2.5
  CONDITION: longest_suit_len > 5.5
  CONDITION: d_top3_honors > 1.5
  CONDITION: minor_hcp > 10.5
  # distilled from Brill /bid

RULE BD_False_P637:
  CALL: 5C
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call == 'PASS'
  CONDITION: total_points > 13.5
  CONDITION: auction_len > 3.5
  CONDITION: spade_len <= 5.5
  CONDITION: total_points > 17.5
  CONDITION: last_bid_level > 2.5
  CONDITION: competition_level <= 3.5
  CONDITION: diamond_len <= 4.5
  CONDITION: losing_trick_count <= 3.5
  # distilled from Brill /bid

RULE BD_False_P638:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call == 'PASS'
  CONDITION: total_points > 13.5
  CONDITION: auction_len > 3.5
  CONDITION: spade_len <= 5.5
  CONDITION: total_points > 17.5
  CONDITION: last_bid_level > 2.5
  CONDITION: competition_level <= 3.5
  CONDITION: diamond_len <= 4.5
  CONDITION: losing_trick_count > 3.5
  # distilled from Brill /bid

RULE BD_False_P639:
  CALL: 3D
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call == 'PASS'
  CONDITION: total_points > 13.5
  CONDITION: auction_len > 3.5
  CONDITION: spade_len <= 5.5
  CONDITION: total_points > 17.5
  CONDITION: last_bid_level > 2.5
  CONDITION: competition_level <= 3.5
  CONDITION: diamond_len > 4.5
  CONDITION: opp_last_call == '3C'
  # distilled from Brill /bid

RULE BD_False_P640:
  CALL: X
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call == 'PASS'
  CONDITION: total_points > 13.5
  CONDITION: auction_len > 3.5
  CONDITION: spade_len <= 5.5
  CONDITION: total_points > 17.5
  CONDITION: last_bid_level > 2.5
  CONDITION: competition_level <= 3.5
  CONDITION: diamond_len > 4.5
  CONDITION: opp_last_call != '3C'
  # distilled from Brill /bid

RULE BD_False_P641:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call == 'PASS'
  CONDITION: total_points > 13.5
  CONDITION: auction_len > 3.5
  CONDITION: spade_len <= 5.5
  CONDITION: total_points > 17.5
  CONDITION: last_bid_level > 2.5
  CONDITION: competition_level > 3.5
  CONDITION: s_has_ten <= 0.5
  CONDITION: opp_is_in_game <= 0.5
  # distilled from Brill /bid

RULE BD_False_P642:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call == 'PASS'
  CONDITION: total_points > 13.5
  CONDITION: auction_len > 3.5
  CONDITION: spade_len <= 5.5
  CONDITION: total_points > 17.5
  CONDITION: last_bid_level > 2.5
  CONDITION: competition_level > 3.5
  CONDITION: s_has_ten <= 0.5
  CONDITION: opp_is_in_game > 0.5
  # distilled from Brill /bid

RULE BD_False_P643:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call == 'PASS'
  CONDITION: total_points > 13.5
  CONDITION: auction_len > 3.5
  CONDITION: spade_len <= 5.5
  CONDITION: total_points > 17.5
  CONDITION: last_bid_level > 2.5
  CONDITION: competition_level > 3.5
  CONDITION: s_has_ten > 0.5
  CONDITION: last_bid_level <= 4.5
  # distilled from Brill /bid

RULE BD_False_P644:
  CALL: X
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call == 'PASS'
  CONDITION: total_points > 13.5
  CONDITION: auction_len > 3.5
  CONDITION: spade_len <= 5.5
  CONDITION: total_points > 17.5
  CONDITION: last_bid_level > 2.5
  CONDITION: competition_level > 3.5
  CONDITION: s_has_ten > 0.5
  CONDITION: last_bid_level > 4.5
  # distilled from Brill /bid

RULE BD_False_P645:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call == 'PASS'
  CONDITION: total_points > 13.5
  CONDITION: auction_len > 3.5
  CONDITION: spade_len > 5.5
  CONDITION: last_bid_level <= 2.5
  CONDITION: rule20_total <= 24.5
  CONDITION: opp_bid_count <= 2.5
  CONDITION: hcp <= 13.5
  CONDITION: s_has_ace <= 0.5
  # distilled from Brill /bid

RULE BD_False_P646:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call == 'PASS'
  CONDITION: total_points > 13.5
  CONDITION: auction_len > 3.5
  CONDITION: spade_len > 5.5
  CONDITION: last_bid_level <= 2.5
  CONDITION: rule20_total <= 24.5
  CONDITION: opp_bid_count <= 2.5
  CONDITION: hcp <= 13.5
  CONDITION: s_has_ace > 0.5
  # distilled from Brill /bid

RULE BD_False_P647:
  CALL: 2S
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call == 'PASS'
  CONDITION: total_points > 13.5
  CONDITION: auction_len > 3.5
  CONDITION: spade_len > 5.5
  CONDITION: last_bid_level <= 2.5
  CONDITION: rule20_total <= 24.5
  CONDITION: opp_bid_count <= 2.5
  CONDITION: hcp > 13.5
  CONDITION: total_points <= 16.5
  # distilled from Brill /bid

RULE BD_False_P648:
  CALL: 3S
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call == 'PASS'
  CONDITION: total_points > 13.5
  CONDITION: auction_len > 3.5
  CONDITION: spade_len > 5.5
  CONDITION: last_bid_level <= 2.5
  CONDITION: rule20_total <= 24.5
  CONDITION: opp_bid_count <= 2.5
  CONDITION: hcp > 13.5
  CONDITION: total_points > 16.5
  # distilled from Brill /bid

RULE BD_False_P649:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call == 'PASS'
  CONDITION: total_points > 13.5
  CONDITION: auction_len > 3.5
  CONDITION: spade_len > 5.5
  CONDITION: last_bid_level <= 2.5
  CONDITION: rule20_total <= 24.5
  CONDITION: opp_bid_count > 2.5
  CONDITION: spade_hcp <= 7.5
  # distilled from Brill /bid

RULE BD_False_P650:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call == 'PASS'
  CONDITION: total_points > 13.5
  CONDITION: auction_len > 3.5
  CONDITION: spade_len > 5.5
  CONDITION: last_bid_level <= 2.5
  CONDITION: rule20_total <= 24.5
  CONDITION: opp_bid_count > 2.5
  CONDITION: spade_hcp > 7.5
  CONDITION: major_hcp <= 11.0
  # distilled from Brill /bid

RULE BD_False_P651:
  CALL: 2S
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call == 'PASS'
  CONDITION: total_points > 13.5
  CONDITION: auction_len > 3.5
  CONDITION: spade_len > 5.5
  CONDITION: last_bid_level <= 2.5
  CONDITION: rule20_total <= 24.5
  CONDITION: opp_bid_count > 2.5
  CONDITION: spade_hcp > 7.5
  CONDITION: major_hcp > 11.0
  # distilled from Brill /bid

RULE BD_False_P652:
  CALL: 2S
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call == 'PASS'
  CONDITION: total_points > 13.5
  CONDITION: auction_len > 3.5
  CONDITION: spade_len > 5.5
  CONDITION: last_bid_level <= 2.5
  CONDITION: rule20_total > 24.5
  CONDITION: losing_trick_count <= 4.5
  CONDITION: spade_len <= 6.5
  CONDITION: heart_hcp <= 3.5
  # distilled from Brill /bid

RULE BD_False_P653:
  CALL: 2S
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call == 'PASS'
  CONDITION: total_points > 13.5
  CONDITION: auction_len > 3.5
  CONDITION: spade_len > 5.5
  CONDITION: last_bid_level <= 2.5
  CONDITION: rule20_total > 24.5
  CONDITION: losing_trick_count <= 4.5
  CONDITION: spade_len <= 6.5
  CONDITION: heart_hcp > 3.5
  # distilled from Brill /bid

RULE BD_False_P654:
  CALL: 4S
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call == 'PASS'
  CONDITION: total_points > 13.5
  CONDITION: auction_len > 3.5
  CONDITION: spade_len > 5.5
  CONDITION: last_bid_level <= 2.5
  CONDITION: rule20_total > 24.5
  CONDITION: losing_trick_count <= 4.5
  CONDITION: spade_len > 6.5
  # distilled from Brill /bid

RULE BD_False_P655:
  CALL: 2S
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call == 'PASS'
  CONDITION: total_points > 13.5
  CONDITION: auction_len > 3.5
  CONDITION: spade_len > 5.5
  CONDITION: last_bid_level <= 2.5
  CONDITION: rule20_total > 24.5
  CONDITION: losing_trick_count > 4.5
  CONDITION: opp_bid_count <= 2.5
  CONDITION: heart_len <= 3.5
  # distilled from Brill /bid

RULE BD_False_P656:
  CALL: 2S
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call == 'PASS'
  CONDITION: total_points > 13.5
  CONDITION: auction_len > 3.5
  CONDITION: spade_len > 5.5
  CONDITION: last_bid_level <= 2.5
  CONDITION: rule20_total > 24.5
  CONDITION: losing_trick_count > 4.5
  CONDITION: opp_bid_count <= 2.5
  CONDITION: heart_len > 3.5
  # distilled from Brill /bid

RULE BD_False_P657:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call == 'PASS'
  CONDITION: total_points > 13.5
  CONDITION: auction_len > 3.5
  CONDITION: spade_len > 5.5
  CONDITION: last_bid_level <= 2.5
  CONDITION: rule20_total > 24.5
  CONDITION: losing_trick_count > 4.5
  CONDITION: opp_bid_count > 2.5
  CONDITION: quick_tricks <= 3.25
  # distilled from Brill /bid

RULE BD_False_P658:
  CALL: 2S
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call == 'PASS'
  CONDITION: total_points > 13.5
  CONDITION: auction_len > 3.5
  CONDITION: spade_len > 5.5
  CONDITION: last_bid_level <= 2.5
  CONDITION: rule20_total > 24.5
  CONDITION: losing_trick_count > 4.5
  CONDITION: opp_bid_count > 2.5
  CONDITION: quick_tricks > 3.25
  # distilled from Brill /bid

RULE BD_False_P659:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call == 'PASS'
  CONDITION: total_points > 13.5
  CONDITION: auction_len > 3.5
  CONDITION: spade_len > 5.5
  CONDITION: last_bid_level > 2.5
  CONDITION: competition_level <= 4.5
  CONDITION: last_bid_level <= 3.5
  CONDITION: total_points <= 17.5
  CONDITION: controls <= 5.5
  # distilled from Brill /bid

RULE BD_False_P660:
  CALL: 3S
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call == 'PASS'
  CONDITION: total_points > 13.5
  CONDITION: auction_len > 3.5
  CONDITION: spade_len > 5.5
  CONDITION: last_bid_level > 2.5
  CONDITION: competition_level <= 4.5
  CONDITION: last_bid_level <= 3.5
  CONDITION: total_points <= 17.5
  CONDITION: controls > 5.5
  # distilled from Brill /bid

RULE BD_False_P661:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call == 'PASS'
  CONDITION: total_points > 13.5
  CONDITION: auction_len > 3.5
  CONDITION: spade_len > 5.5
  CONDITION: last_bid_level > 2.5
  CONDITION: competition_level <= 4.5
  CONDITION: last_bid_level <= 3.5
  CONDITION: total_points > 17.5
  CONDITION: opp_first_bid_level <= 1.5
  # distilled from Brill /bid

RULE BD_False_P662:
  CALL: 3S
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call == 'PASS'
  CONDITION: total_points > 13.5
  CONDITION: auction_len > 3.5
  CONDITION: spade_len > 5.5
  CONDITION: last_bid_level > 2.5
  CONDITION: competition_level <= 4.5
  CONDITION: last_bid_level <= 3.5
  CONDITION: total_points > 17.5
  CONDITION: opp_first_bid_level > 1.5
  # distilled from Brill /bid

RULE BD_False_P663:
  CALL: 4S
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call == 'PASS'
  CONDITION: total_points > 13.5
  CONDITION: auction_len > 3.5
  CONDITION: spade_len > 5.5
  CONDITION: last_bid_level > 2.5
  CONDITION: competition_level <= 4.5
  CONDITION: last_bid_level > 3.5
  CONDITION: rule20_total <= 28.5
  CONDITION: shape_pattern == '8311'
  # distilled from Brill /bid

RULE BD_False_P664:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call == 'PASS'
  CONDITION: total_points > 13.5
  CONDITION: auction_len > 3.5
  CONDITION: spade_len > 5.5
  CONDITION: last_bid_level > 2.5
  CONDITION: competition_level <= 4.5
  CONDITION: last_bid_level > 3.5
  CONDITION: rule20_total <= 28.5
  CONDITION: shape_pattern != '8311'
  # distilled from Brill /bid

RULE BD_False_P665:
  CALL: X
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call == 'PASS'
  CONDITION: total_points > 13.5
  CONDITION: auction_len > 3.5
  CONDITION: spade_len > 5.5
  CONDITION: last_bid_level > 2.5
  CONDITION: competition_level <= 4.5
  CONDITION: last_bid_level > 3.5
  CONDITION: rule20_total > 28.5
  CONDITION: major_hcp <= 7.5
  # distilled from Brill /bid

RULE BD_False_P666:
  CALL: 4S
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call == 'PASS'
  CONDITION: total_points > 13.5
  CONDITION: auction_len > 3.5
  CONDITION: spade_len > 5.5
  CONDITION: last_bid_level > 2.5
  CONDITION: competition_level <= 4.5
  CONDITION: last_bid_level > 3.5
  CONDITION: rule20_total > 28.5
  CONDITION: major_hcp > 7.5
  # distilled from Brill /bid

RULE BD_False_P667:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call == 'PASS'
  CONDITION: total_points > 13.5
  CONDITION: auction_len > 3.5
  CONDITION: spade_len > 5.5
  CONDITION: last_bid_level > 2.5
  CONDITION: competition_level > 4.5
  CONDITION: opp_contract_level <= 4.5
  # distilled from Brill /bid

RULE BD_False_P668:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call == 'PASS'
  CONDITION: total_points > 13.5
  CONDITION: auction_len > 3.5
  CONDITION: spade_len > 5.5
  CONDITION: last_bid_level > 2.5
  CONDITION: competition_level > 4.5
  CONDITION: opp_contract_level > 4.5
  CONDITION: our_fit_shown <= 0.5
  CONDITION: minor_hcp <= 8.5
  # distilled from Brill /bid

RULE BD_False_P669:
  CALL: 5S
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call == 'PASS'
  CONDITION: total_points > 13.5
  CONDITION: auction_len > 3.5
  CONDITION: spade_len > 5.5
  CONDITION: last_bid_level > 2.5
  CONDITION: competition_level > 4.5
  CONDITION: opp_contract_level > 4.5
  CONDITION: our_fit_shown <= 0.5
  CONDITION: minor_hcp > 8.5
  # distilled from Brill /bid

RULE BD_False_P670:
  CALL: X
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call == 'PASS'
  CONDITION: total_points > 13.5
  CONDITION: auction_len > 3.5
  CONDITION: spade_len > 5.5
  CONDITION: last_bid_level > 2.5
  CONDITION: competition_level > 4.5
  CONDITION: opp_contract_level > 4.5
  CONDITION: our_fit_shown > 0.5
  CONDITION: h_has_ten <= 0.5
  # distilled from Brill /bid

RULE BD_False_P671:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call == 'PASS'
  CONDITION: total_points > 13.5
  CONDITION: auction_len > 3.5
  CONDITION: spade_len > 5.5
  CONDITION: last_bid_level > 2.5
  CONDITION: competition_level > 4.5
  CONDITION: opp_contract_level > 4.5
  CONDITION: our_fit_shown > 0.5
  CONDITION: h_has_ten > 0.5
  # distilled from Brill /bid

RULE BD_False_P672:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call != 'PASS'
  CONDITION: last_bid_level <= 2.5
  CONDITION: partner_last_call == '2NT'
  CONDITION: competition_level <= 3.5
  CONDITION: opening_bid == '1S'
  CONDITION: spade_len <= 2.5
  CONDITION: hcp <= 7.5
  # distilled from Brill /bid

RULE BD_False_P673:
  CALL: 3NT
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call != 'PASS'
  CONDITION: last_bid_level <= 2.5
  CONDITION: partner_last_call == '2NT'
  CONDITION: competition_level <= 3.5
  CONDITION: opening_bid == '1S'
  CONDITION: spade_len <= 2.5
  CONDITION: hcp > 7.5
  CONDITION: opp_first_call == 'PASS'
  CONDITION: total_points <= 16.5
  # distilled from Brill /bid

RULE BD_False_P674:
  CALL: 6D
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call != 'PASS'
  CONDITION: last_bid_level <= 2.5
  CONDITION: partner_last_call == '2NT'
  CONDITION: competition_level <= 3.5
  CONDITION: opening_bid == '1S'
  CONDITION: spade_len <= 2.5
  CONDITION: hcp > 7.5
  CONDITION: opp_first_call == 'PASS'
  CONDITION: total_points > 16.5
  # distilled from Brill /bid

RULE BD_False_P675:
  CALL: 3D
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call != 'PASS'
  CONDITION: last_bid_level <= 2.5
  CONDITION: partner_last_call == '2NT'
  CONDITION: competition_level <= 3.5
  CONDITION: opening_bid == '1S'
  CONDITION: spade_len <= 2.5
  CONDITION: hcp > 7.5
  CONDITION: opp_first_call != 'PASS'
  CONDITION: club_hcp <= 4.0
  # distilled from Brill /bid

RULE BD_False_P676:
  CALL: 3C
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call != 'PASS'
  CONDITION: last_bid_level <= 2.5
  CONDITION: partner_last_call == '2NT'
  CONDITION: competition_level <= 3.5
  CONDITION: opening_bid == '1S'
  CONDITION: spade_len <= 2.5
  CONDITION: hcp > 7.5
  CONDITION: opp_first_call != 'PASS'
  CONDITION: club_hcp > 4.0
  # distilled from Brill /bid

RULE BD_False_P677:
  CALL: 3C
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call != 'PASS'
  CONDITION: last_bid_level <= 2.5
  CONDITION: partner_last_call == '2NT'
  CONDITION: competition_level <= 3.5
  CONDITION: opening_bid == '1S'
  CONDITION: spade_len > 2.5
  CONDITION: hcp <= 7.5
  CONDITION: auction_len <= 5.5
  CONDITION: spade_hcp <= 1.5
  # distilled from Brill /bid

RULE BD_False_P678:
  CALL: 3NT
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call != 'PASS'
  CONDITION: last_bid_level <= 2.5
  CONDITION: partner_last_call == '2NT'
  CONDITION: competition_level <= 3.5
  CONDITION: opening_bid == '1S'
  CONDITION: spade_len > 2.5
  CONDITION: hcp <= 7.5
  CONDITION: auction_len <= 5.5
  CONDITION: spade_hcp > 1.5
  # distilled from Brill /bid

RULE BD_False_P679:
  CALL: 3S
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call != 'PASS'
  CONDITION: last_bid_level <= 2.5
  CONDITION: partner_last_call == '2NT'
  CONDITION: competition_level <= 3.5
  CONDITION: opening_bid == '1S'
  CONDITION: spade_len > 2.5
  CONDITION: hcp <= 7.5
  CONDITION: auction_len > 5.5
  # distilled from Brill /bid

RULE BD_False_P680:
  CALL: 3H
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call != 'PASS'
  CONDITION: last_bid_level <= 2.5
  CONDITION: partner_last_call == '2NT'
  CONDITION: competition_level <= 3.5
  CONDITION: opening_bid == '1S'
  CONDITION: spade_len > 2.5
  CONDITION: hcp > 7.5
  CONDITION: shortest_suit_len <= 1.5
  CONDITION: competition_level <= 2.5
  # distilled from Brill /bid

RULE BD_False_P681:
  CALL: 4S
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call != 'PASS'
  CONDITION: last_bid_level <= 2.5
  CONDITION: partner_last_call == '2NT'
  CONDITION: competition_level <= 3.5
  CONDITION: opening_bid == '1S'
  CONDITION: spade_len > 2.5
  CONDITION: hcp > 7.5
  CONDITION: shortest_suit_len <= 1.5
  CONDITION: competition_level > 2.5
  # distilled from Brill /bid

RULE BD_False_P682:
  CALL: 4S
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call != 'PASS'
  CONDITION: last_bid_level <= 2.5
  CONDITION: partner_last_call == '2NT'
  CONDITION: competition_level <= 3.5
  CONDITION: opening_bid == '1S'
  CONDITION: spade_len > 2.5
  CONDITION: hcp > 7.5
  CONDITION: shortest_suit_len > 1.5
  CONDITION: opponents_bid <= 0.5
  # distilled from Brill /bid

RULE BD_False_P683:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call != 'PASS'
  CONDITION: last_bid_level <= 2.5
  CONDITION: partner_last_call == '2NT'
  CONDITION: competition_level <= 3.5
  CONDITION: opening_bid == '1S'
  CONDITION: spade_len > 2.5
  CONDITION: hcp > 7.5
  CONDITION: shortest_suit_len > 1.5
  CONDITION: opponents_bid > 0.5
  # distilled from Brill /bid

RULE BD_False_P684:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call != 'PASS'
  CONDITION: last_bid_level <= 2.5
  CONDITION: partner_last_call == '2NT'
  CONDITION: competition_level <= 3.5
  CONDITION: opening_bid != '1S'
  CONDITION: hcp <= 17.5
  CONDITION: longest_suit_len <= 4.5
  CONDITION: my_side_bid_count <= 2.5
  CONDITION: opening_bid == '1C'
  # distilled from Brill /bid

RULE BD_False_P685:
  CALL: 3C
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call != 'PASS'
  CONDITION: last_bid_level <= 2.5
  CONDITION: partner_last_call == '2NT'
  CONDITION: competition_level <= 3.5
  CONDITION: opening_bid != '1S'
  CONDITION: hcp <= 17.5
  CONDITION: longest_suit_len <= 4.5
  CONDITION: my_side_bid_count <= 2.5
  CONDITION: opening_bid != '1C'
  # distilled from Brill /bid

RULE BD_False_P686:
  CALL: 3C
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call != 'PASS'
  CONDITION: last_bid_level <= 2.5
  CONDITION: partner_last_call == '2NT'
  CONDITION: competition_level <= 3.5
  CONDITION: opening_bid != '1S'
  CONDITION: hcp <= 17.5
  CONDITION: longest_suit_len <= 4.5
  CONDITION: my_side_bid_count > 2.5
  CONDITION: opening_bid == '2C'
  # distilled from Brill /bid

RULE BD_False_P687:
  CALL: 3NT
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call != 'PASS'
  CONDITION: last_bid_level <= 2.5
  CONDITION: partner_last_call == '2NT'
  CONDITION: competition_level <= 3.5
  CONDITION: opening_bid != '1S'
  CONDITION: hcp <= 17.5
  CONDITION: longest_suit_len <= 4.5
  CONDITION: my_side_bid_count > 2.5
  CONDITION: opening_bid != '2C'
  # distilled from Brill /bid

RULE BD_False_P688:
  CALL: 3NT
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call != 'PASS'
  CONDITION: last_bid_level <= 2.5
  CONDITION: partner_last_call == '2NT'
  CONDITION: competition_level <= 3.5
  CONDITION: opening_bid != '1S'
  CONDITION: hcp <= 17.5
  CONDITION: longest_suit_len > 4.5
  CONDITION: heart_len <= 4.5
  CONDITION: spade_len <= 4.5
  # distilled from Brill /bid

RULE BD_False_P689:
  CALL: 3H
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call != 'PASS'
  CONDITION: last_bid_level <= 2.5
  CONDITION: partner_last_call == '2NT'
  CONDITION: competition_level <= 3.5
  CONDITION: opening_bid != '1S'
  CONDITION: hcp <= 17.5
  CONDITION: longest_suit_len > 4.5
  CONDITION: heart_len <= 4.5
  CONDITION: spade_len > 4.5
  # distilled from Brill /bid

RULE BD_False_P690:
  CALL: 4H
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call != 'PASS'
  CONDITION: last_bid_level <= 2.5
  CONDITION: partner_last_call == '2NT'
  CONDITION: competition_level <= 3.5
  CONDITION: opening_bid != '1S'
  CONDITION: hcp <= 17.5
  CONDITION: longest_suit_len > 4.5
  CONDITION: heart_len > 4.5
  CONDITION: opening_bid == '1H'
  # distilled from Brill /bid

RULE BD_False_P691:
  CALL: 3D
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call != 'PASS'
  CONDITION: last_bid_level <= 2.5
  CONDITION: partner_last_call == '2NT'
  CONDITION: competition_level <= 3.5
  CONDITION: opening_bid != '1S'
  CONDITION: hcp <= 17.5
  CONDITION: longest_suit_len > 4.5
  CONDITION: heart_len > 4.5
  CONDITION: opening_bid != '1H'
  # distilled from Brill /bid

RULE BD_False_P692:
  CALL: 3NT
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call != 'PASS'
  CONDITION: last_bid_level <= 2.5
  CONDITION: partner_last_call == '2NT'
  CONDITION: competition_level <= 3.5
  CONDITION: opening_bid != '1S'
  CONDITION: hcp > 17.5
  CONDITION: rule20_total <= 27.5
  CONDITION: second_longest_len <= 3.5
  CONDITION: d_has_ace <= 0.5
  # distilled from Brill /bid

RULE BD_False_P693:
  CALL: 4NT
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call != 'PASS'
  CONDITION: last_bid_level <= 2.5
  CONDITION: partner_last_call == '2NT'
  CONDITION: competition_level <= 3.5
  CONDITION: opening_bid != '1S'
  CONDITION: hcp > 17.5
  CONDITION: rule20_total <= 27.5
  CONDITION: second_longest_len <= 3.5
  CONDITION: d_has_ace > 0.5
  # distilled from Brill /bid

RULE BD_False_P694:
  CALL: 3NT
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call != 'PASS'
  CONDITION: last_bid_level <= 2.5
  CONDITION: partner_last_call == '2NT'
  CONDITION: competition_level <= 3.5
  CONDITION: opening_bid != '1S'
  CONDITION: hcp > 17.5
  CONDITION: rule20_total <= 27.5
  CONDITION: second_longest_len > 3.5
  CONDITION: s_has_ten <= 0.5
  # distilled from Brill /bid

RULE BD_False_P695:
  CALL: 3D
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call != 'PASS'
  CONDITION: last_bid_level <= 2.5
  CONDITION: partner_last_call == '2NT'
  CONDITION: competition_level <= 3.5
  CONDITION: opening_bid != '1S'
  CONDITION: hcp > 17.5
  CONDITION: rule20_total <= 27.5
  CONDITION: second_longest_len > 3.5
  CONDITION: s_has_ten > 0.5
  # distilled from Brill /bid

RULE BD_False_P696:
  CALL: 4NT
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call != 'PASS'
  CONDITION: last_bid_level <= 2.5
  CONDITION: partner_last_call == '2NT'
  CONDITION: competition_level <= 3.5
  CONDITION: opening_bid != '1S'
  CONDITION: hcp > 17.5
  CONDITION: rule20_total > 27.5
  CONDITION: heart_len <= 4.5
  CONDITION: opponents_bid <= 0.5
  # distilled from Brill /bid

RULE BD_False_P697:
  CALL: 3S
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call != 'PASS'
  CONDITION: last_bid_level <= 2.5
  CONDITION: partner_last_call == '2NT'
  CONDITION: competition_level <= 3.5
  CONDITION: opening_bid != '1S'
  CONDITION: hcp > 17.5
  CONDITION: rule20_total > 27.5
  CONDITION: heart_len <= 4.5
  CONDITION: opponents_bid > 0.5
  # distilled from Brill /bid

RULE BD_False_P698:
  CALL: 3H
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call != 'PASS'
  CONDITION: last_bid_level <= 2.5
  CONDITION: partner_last_call == '2NT'
  CONDITION: competition_level <= 3.5
  CONDITION: opening_bid != '1S'
  CONDITION: hcp > 17.5
  CONDITION: rule20_total > 27.5
  CONDITION: heart_len > 4.5
  CONDITION: hcp <= 22.5
  # distilled from Brill /bid

RULE BD_False_P699:
  CALL: 5NT
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call != 'PASS'
  CONDITION: last_bid_level <= 2.5
  CONDITION: partner_last_call == '2NT'
  CONDITION: competition_level <= 3.5
  CONDITION: opening_bid != '1S'
  CONDITION: hcp > 17.5
  CONDITION: rule20_total > 27.5
  CONDITION: heart_len > 4.5
  CONDITION: hcp > 22.5
  # distilled from Brill /bid

RULE BD_False_P700:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call != 'PASS'
  CONDITION: last_bid_level <= 2.5
  CONDITION: partner_last_call == '2NT'
  CONDITION: competition_level > 3.5
  CONDITION: hcp <= 15.5
  CONDITION: opening_bid == '1NT'
  CONDITION: partner_last_bid_strain == 'D'
  CONDITION: heart_len <= 2.5
  # distilled from Brill /bid

RULE BD_False_P701:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call != 'PASS'
  CONDITION: last_bid_level <= 2.5
  CONDITION: partner_last_call == '2NT'
  CONDITION: competition_level > 3.5
  CONDITION: hcp <= 15.5
  CONDITION: opening_bid == '1NT'
  CONDITION: partner_last_bid_strain == 'D'
  CONDITION: heart_len > 2.5
  CONDITION: hcp <= 12.0
  # distilled from Brill /bid

RULE BD_False_P702:
  CALL: 3H
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call != 'PASS'
  CONDITION: last_bid_level <= 2.5
  CONDITION: partner_last_call == '2NT'
  CONDITION: competition_level > 3.5
  CONDITION: hcp <= 15.5
  CONDITION: opening_bid == '1NT'
  CONDITION: partner_last_bid_strain == 'D'
  CONDITION: heart_len > 2.5
  CONDITION: hcp > 12.0
  # distilled from Brill /bid

RULE BD_False_P703:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call != 'PASS'
  CONDITION: last_bid_level <= 2.5
  CONDITION: partner_last_call == '2NT'
  CONDITION: competition_level > 3.5
  CONDITION: hcp <= 15.5
  CONDITION: opening_bid == '1NT'
  CONDITION: partner_last_bid_strain != 'D'
  CONDITION: partner_last_bid_strain == 'H'
  CONDITION: quick_tricks <= 2.25
  # distilled from Brill /bid

RULE BD_False_P704:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call != 'PASS'
  CONDITION: last_bid_level <= 2.5
  CONDITION: partner_last_call == '2NT'
  CONDITION: competition_level > 3.5
  CONDITION: hcp <= 15.5
  CONDITION: opening_bid == '1NT'
  CONDITION: partner_last_bid_strain != 'D'
  CONDITION: partner_last_bid_strain == 'H'
  CONDITION: quick_tricks > 2.25
  # distilled from Brill /bid

RULE BD_False_P705:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call != 'PASS'
  CONDITION: last_bid_level <= 2.5
  CONDITION: partner_last_call == '2NT'
  CONDITION: competition_level > 3.5
  CONDITION: hcp <= 15.5
  CONDITION: opening_bid == '1NT'
  CONDITION: partner_last_bid_strain != 'D'
  CONDITION: partner_last_bid_strain != 'H'
  # distilled from Brill /bid

RULE BD_False_P706:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call != 'PASS'
  CONDITION: last_bid_level <= 2.5
  CONDITION: partner_last_call == '2NT'
  CONDITION: competition_level > 3.5
  CONDITION: hcp <= 15.5
  CONDITION: opening_bid != '1NT'
  CONDITION: hcp <= 13.5
  CONDITION: spade_len <= 5.5
  CONDITION: second_longest_len <= 4.5
  # distilled from Brill /bid

RULE BD_False_P707:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call != 'PASS'
  CONDITION: last_bid_level <= 2.5
  CONDITION: partner_last_call == '2NT'
  CONDITION: competition_level > 3.5
  CONDITION: hcp <= 15.5
  CONDITION: opening_bid != '1NT'
  CONDITION: hcp <= 13.5
  CONDITION: spade_len <= 5.5
  CONDITION: second_longest_len > 4.5
  # distilled from Brill /bid

RULE BD_False_P708:
  CALL: 3S
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call != 'PASS'
  CONDITION: last_bid_level <= 2.5
  CONDITION: partner_last_call == '2NT'
  CONDITION: competition_level > 3.5
  CONDITION: hcp <= 15.5
  CONDITION: opening_bid != '1NT'
  CONDITION: hcp <= 13.5
  CONDITION: spade_len > 5.5
  CONDITION: diamond_len <= 2.5
  # distilled from Brill /bid

RULE BD_False_P709:
  CALL: 3NT
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call != 'PASS'
  CONDITION: last_bid_level <= 2.5
  CONDITION: partner_last_call == '2NT'
  CONDITION: competition_level > 3.5
  CONDITION: hcp <= 15.5
  CONDITION: opening_bid != '1NT'
  CONDITION: hcp <= 13.5
  CONDITION: spade_len > 5.5
  CONDITION: diamond_len > 2.5
  # distilled from Brill /bid

RULE BD_False_P710:
  CALL: 3NT
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call != 'PASS'
  CONDITION: last_bid_level <= 2.5
  CONDITION: partner_last_call == '2NT'
  CONDITION: competition_level > 3.5
  CONDITION: hcp <= 15.5
  CONDITION: opening_bid != '1NT'
  CONDITION: hcp > 13.5
  CONDITION: my_first_call == '1NT'
  CONDITION: hcp <= 14.5
  # distilled from Brill /bid

RULE BD_False_P711:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call != 'PASS'
  CONDITION: last_bid_level <= 2.5
  CONDITION: partner_last_call == '2NT'
  CONDITION: competition_level > 3.5
  CONDITION: hcp <= 15.5
  CONDITION: opening_bid != '1NT'
  CONDITION: hcp > 13.5
  CONDITION: my_first_call == '1NT'
  CONDITION: hcp > 14.5
  # distilled from Brill /bid

RULE BD_False_P712:
  CALL: 3NT
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call != 'PASS'
  CONDITION: last_bid_level <= 2.5
  CONDITION: partner_last_call == '2NT'
  CONDITION: competition_level > 3.5
  CONDITION: hcp <= 15.5
  CONDITION: opening_bid != '1NT'
  CONDITION: hcp > 13.5
  CONDITION: my_first_call != '1NT'
  CONDITION: partner_first_call == '2C'
  # distilled from Brill /bid

RULE BD_False_P713:
  CALL: 3NT
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call != 'PASS'
  CONDITION: last_bid_level <= 2.5
  CONDITION: partner_last_call == '2NT'
  CONDITION: competition_level > 3.5
  CONDITION: hcp <= 15.5
  CONDITION: opening_bid != '1NT'
  CONDITION: hcp > 13.5
  CONDITION: my_first_call != '1NT'
  CONDITION: partner_first_call != '2C'
  # distilled from Brill /bid

RULE BD_False_P714:
  CALL: 3NT
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call != 'PASS'
  CONDITION: last_bid_level <= 2.5
  CONDITION: partner_last_call == '2NT'
  CONDITION: competition_level > 3.5
  CONDITION: hcp > 15.5
  CONDITION: my_first_call == '1NT'
  CONDITION: partner_last_bid_strain == 'C'
  # distilled from Brill /bid

RULE BD_False_P715:
  CALL: 3NT
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call != 'PASS'
  CONDITION: last_bid_level <= 2.5
  CONDITION: partner_last_call == '2NT'
  CONDITION: competition_level > 3.5
  CONDITION: hcp > 15.5
  CONDITION: my_first_call == '1NT'
  CONDITION: partner_last_bid_strain != 'C'
  CONDITION: my_last_call == '2H'
  CONDITION: heart_len <= 2.5
  # distilled from Brill /bid

RULE BD_False_P716:
  CALL: 4H
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call != 'PASS'
  CONDITION: last_bid_level <= 2.5
  CONDITION: partner_last_call == '2NT'
  CONDITION: competition_level > 3.5
  CONDITION: hcp > 15.5
  CONDITION: my_first_call == '1NT'
  CONDITION: partner_last_bid_strain != 'C'
  CONDITION: my_last_call == '2H'
  CONDITION: heart_len > 2.5
  # distilled from Brill /bid

RULE BD_False_P717:
  CALL: 3NT
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call != 'PASS'
  CONDITION: last_bid_level <= 2.5
  CONDITION: partner_last_call == '2NT'
  CONDITION: competition_level > 3.5
  CONDITION: hcp > 15.5
  CONDITION: my_first_call == '1NT'
  CONDITION: partner_last_bid_strain != 'C'
  CONDITION: my_last_call != '2H'
  CONDITION: spade_len <= 2.5
  # distilled from Brill /bid

RULE BD_False_P718:
  CALL: 4S
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call != 'PASS'
  CONDITION: last_bid_level <= 2.5
  CONDITION: partner_last_call == '2NT'
  CONDITION: competition_level > 3.5
  CONDITION: hcp > 15.5
  CONDITION: my_first_call == '1NT'
  CONDITION: partner_last_bid_strain != 'C'
  CONDITION: my_last_call != '2H'
  CONDITION: spade_len > 2.5
  # distilled from Brill /bid

RULE BD_False_P719:
  CALL: 3NT
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call != 'PASS'
  CONDITION: last_bid_level <= 2.5
  CONDITION: partner_last_call == '2NT'
  CONDITION: competition_level > 3.5
  CONDITION: hcp > 15.5
  CONDITION: my_first_call != '1NT'
  CONDITION: my_side_bid_count <= 4.5
  CONDITION: opponents_bid <= 0.5
  CONDITION: major_hcp <= 13.5
  # distilled from Brill /bid

RULE BD_False_P720:
  CALL: 3S
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call != 'PASS'
  CONDITION: last_bid_level <= 2.5
  CONDITION: partner_last_call == '2NT'
  CONDITION: competition_level > 3.5
  CONDITION: hcp > 15.5
  CONDITION: my_first_call != '1NT'
  CONDITION: my_side_bid_count <= 4.5
  CONDITION: opponents_bid <= 0.5
  CONDITION: major_hcp > 13.5
  # distilled from Brill /bid

RULE BD_False_P721:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call != 'PASS'
  CONDITION: last_bid_level <= 2.5
  CONDITION: partner_last_call == '2NT'
  CONDITION: competition_level > 3.5
  CONDITION: hcp > 15.5
  CONDITION: my_first_call != '1NT'
  CONDITION: my_side_bid_count <= 4.5
  CONDITION: opponents_bid > 0.5
  CONDITION: second_longest_len <= 4.5
  # distilled from Brill /bid

RULE BD_False_P722:
  CALL: 3S
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call != 'PASS'
  CONDITION: last_bid_level <= 2.5
  CONDITION: partner_last_call == '2NT'
  CONDITION: competition_level > 3.5
  CONDITION: hcp > 15.5
  CONDITION: my_first_call != '1NT'
  CONDITION: my_side_bid_count <= 4.5
  CONDITION: opponents_bid > 0.5
  CONDITION: second_longest_len > 4.5
  # distilled from Brill /bid

RULE BD_False_P723:
  CALL: 6C
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call != 'PASS'
  CONDITION: last_bid_level <= 2.5
  CONDITION: partner_last_call == '2NT'
  CONDITION: competition_level > 3.5
  CONDITION: hcp > 15.5
  CONDITION: my_first_call != '1NT'
  CONDITION: my_side_bid_count > 4.5
  CONDITION: hcp <= 18.0
  CONDITION: diamond_len <= 1.5
  # distilled from Brill /bid

RULE BD_False_P724:
  CALL: 3NT
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call != 'PASS'
  CONDITION: last_bid_level <= 2.5
  CONDITION: partner_last_call == '2NT'
  CONDITION: competition_level > 3.5
  CONDITION: hcp > 15.5
  CONDITION: my_first_call != '1NT'
  CONDITION: my_side_bid_count > 4.5
  CONDITION: hcp <= 18.0
  CONDITION: diamond_len > 1.5
  # distilled from Brill /bid

RULE BD_False_P725:
  CALL: 4NT
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call != 'PASS'
  CONDITION: last_bid_level <= 2.5
  CONDITION: partner_last_call == '2NT'
  CONDITION: competition_level > 3.5
  CONDITION: hcp > 15.5
  CONDITION: my_first_call != '1NT'
  CONDITION: my_side_bid_count > 4.5
  CONDITION: hcp > 18.0
  CONDITION: hcp <= 19.5
  # distilled from Brill /bid

RULE BD_False_P726:
  CALL: 5NT
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call != 'PASS'
  CONDITION: last_bid_level <= 2.5
  CONDITION: partner_last_call == '2NT'
  CONDITION: competition_level > 3.5
  CONDITION: hcp > 15.5
  CONDITION: my_first_call != '1NT'
  CONDITION: my_side_bid_count > 4.5
  CONDITION: hcp > 18.0
  CONDITION: hcp > 19.5
  # distilled from Brill /bid

RULE BD_False_P727:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call != 'PASS'
  CONDITION: last_bid_level <= 2.5
  CONDITION: partner_last_call != '2NT'
  CONDITION: last_bid_strain == 'C'
  CONDITION: passes_since_last_bid <= 0.5
  CONDITION: hcp <= 6.5
  CONDITION: support_in_partner_suit <= 3.5
  CONDITION: partner_first_call == '1NT'
  CONDITION: longest_suit_len <= 5.5
  # distilled from Brill /bid

RULE BD_False_P728:
  CALL: 4D
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call != 'PASS'
  CONDITION: last_bid_level <= 2.5
  CONDITION: partner_last_call != '2NT'
  CONDITION: last_bid_strain == 'C'
  CONDITION: passes_since_last_bid <= 0.5
  CONDITION: hcp <= 6.5
  CONDITION: support_in_partner_suit <= 3.5
  CONDITION: partner_first_call == '1NT'
  CONDITION: longest_suit_len > 5.5
  # distilled from Brill /bid

RULE BD_False_P729:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call != 'PASS'
  CONDITION: last_bid_level <= 2.5
  CONDITION: partner_last_call != '2NT'
  CONDITION: last_bid_strain == 'C'
  CONDITION: passes_since_last_bid <= 0.5
  CONDITION: hcp <= 6.5
  CONDITION: support_in_partner_suit <= 3.5
  CONDITION: partner_first_call != '1NT'
  CONDITION: support_in_partner_suit <= 2.5
  # distilled from Brill /bid

RULE BD_False_P730:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call != 'PASS'
  CONDITION: last_bid_level <= 2.5
  CONDITION: partner_last_call != '2NT'
  CONDITION: last_bid_strain == 'C'
  CONDITION: passes_since_last_bid <= 0.5
  CONDITION: hcp <= 6.5
  CONDITION: support_in_partner_suit <= 3.5
  CONDITION: partner_first_call != '1NT'
  CONDITION: support_in_partner_suit > 2.5
  # distilled from Brill /bid

RULE BD_False_P731:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call != 'PASS'
  CONDITION: last_bid_level <= 2.5
  CONDITION: partner_last_call != '2NT'
  CONDITION: last_bid_strain == 'C'
  CONDITION: passes_since_last_bid <= 0.5
  CONDITION: hcp <= 6.5
  CONDITION: support_in_partner_suit > 3.5
  CONDITION: partner_last_bid_strain == 'C'
  # distilled from Brill /bid

RULE BD_False_P732:
  CALL: 3S
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call != 'PASS'
  CONDITION: last_bid_level <= 2.5
  CONDITION: partner_last_call != '2NT'
  CONDITION: last_bid_strain == 'C'
  CONDITION: passes_since_last_bid <= 0.5
  CONDITION: hcp <= 6.5
  CONDITION: support_in_partner_suit > 3.5
  CONDITION: partner_last_bid_strain != 'C'
  CONDITION: partner_last_call == '1S'
  # distilled from Brill /bid

RULE BD_False_P733:
  CALL: 4H
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call != 'PASS'
  CONDITION: last_bid_level <= 2.5
  CONDITION: partner_last_call != '2NT'
  CONDITION: last_bid_strain == 'C'
  CONDITION: passes_since_last_bid <= 0.5
  CONDITION: hcp <= 6.5
  CONDITION: support_in_partner_suit > 3.5
  CONDITION: partner_last_bid_strain != 'C'
  CONDITION: partner_last_call != '1S'
  # distilled from Brill /bid

RULE BD_False_P734:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call != 'PASS'
  CONDITION: last_bid_level <= 2.5
  CONDITION: partner_last_call != '2NT'
  CONDITION: last_bid_strain == 'C'
  CONDITION: passes_since_last_bid <= 0.5
  CONDITION: hcp > 6.5
  CONDITION: support_in_partner_suit <= 3.5
  CONDITION: heart_len <= 4.5
  CONDITION: spade_len <= 4.5
  # distilled from Brill /bid

RULE BD_False_P735:
  CALL: 2S
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call != 'PASS'
  CONDITION: last_bid_level <= 2.5
  CONDITION: partner_last_call != '2NT'
  CONDITION: last_bid_strain == 'C'
  CONDITION: passes_since_last_bid <= 0.5
  CONDITION: hcp > 6.5
  CONDITION: support_in_partner_suit <= 3.5
  CONDITION: heart_len <= 4.5
  CONDITION: spade_len > 4.5
  # distilled from Brill /bid

RULE BD_False_P736:
  CALL: 2D
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call != 'PASS'
  CONDITION: last_bid_level <= 2.5
  CONDITION: partner_last_call != '2NT'
  CONDITION: last_bid_strain == 'C'
  CONDITION: passes_since_last_bid <= 0.5
  CONDITION: hcp > 6.5
  CONDITION: support_in_partner_suit <= 3.5
  CONDITION: heart_len > 4.5
  CONDITION: opening_bid == '1NT'
  # distilled from Brill /bid

RULE BD_False_P737:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call != 'PASS'
  CONDITION: last_bid_level <= 2.5
  CONDITION: partner_last_call != '2NT'
  CONDITION: last_bid_strain == 'C'
  CONDITION: passes_since_last_bid <= 0.5
  CONDITION: hcp > 6.5
  CONDITION: support_in_partner_suit <= 3.5
  CONDITION: heart_len > 4.5
  CONDITION: opening_bid != '1NT'
  # distilled from Brill /bid

RULE BD_False_P738:
  CALL: 2S
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call != 'PASS'
  CONDITION: last_bid_level <= 2.5
  CONDITION: partner_last_call != '2NT'
  CONDITION: last_bid_strain == 'C'
  CONDITION: passes_since_last_bid <= 0.5
  CONDITION: hcp > 6.5
  CONDITION: support_in_partner_suit > 3.5
  CONDITION: partner_last_call == '1S'
  CONDITION: hcp <= 14.5
  # distilled from Brill /bid

RULE BD_False_P739:
  CALL: 4S
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call != 'PASS'
  CONDITION: last_bid_level <= 2.5
  CONDITION: partner_last_call != '2NT'
  CONDITION: last_bid_strain == 'C'
  CONDITION: passes_since_last_bid <= 0.5
  CONDITION: hcp > 6.5
  CONDITION: support_in_partner_suit > 3.5
  CONDITION: partner_last_call == '1S'
  CONDITION: hcp > 14.5
  # distilled from Brill /bid

RULE BD_False_P740:
  CALL: 2H
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call != 'PASS'
  CONDITION: last_bid_level <= 2.5
  CONDITION: partner_last_call != '2NT'
  CONDITION: last_bid_strain == 'C'
  CONDITION: passes_since_last_bid <= 0.5
  CONDITION: hcp > 6.5
  CONDITION: support_in_partner_suit > 3.5
  CONDITION: partner_last_call != '1S'
  CONDITION: partner_last_call == '1H'
  # distilled from Brill /bid

RULE BD_False_P741:
  CALL: 3C
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call != 'PASS'
  CONDITION: last_bid_level <= 2.5
  CONDITION: partner_last_call != '2NT'
  CONDITION: last_bid_strain == 'C'
  CONDITION: passes_since_last_bid <= 0.5
  CONDITION: hcp > 6.5
  CONDITION: support_in_partner_suit > 3.5
  CONDITION: partner_last_call != '1S'
  CONDITION: partner_last_call != '1H'
  # distilled from Brill /bid

RULE BD_False_P742:
  CALL: 2D
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call != 'PASS'
  CONDITION: last_bid_level <= 2.5
  CONDITION: partner_last_call != '2NT'
  CONDITION: last_bid_strain == 'C'
  CONDITION: passes_since_last_bid > 0.5
  CONDITION: opening_bid == '1NT'
  CONDITION: heart_len <= 3.5
  CONDITION: spade_len <= 3.5
  CONDITION: my_last_call == '1NT'
  # distilled from Brill /bid

RULE BD_False_P743:
  CALL: 2D
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call != 'PASS'
  CONDITION: last_bid_level <= 2.5
  CONDITION: partner_last_call != '2NT'
  CONDITION: last_bid_strain == 'C'
  CONDITION: passes_since_last_bid > 0.5
  CONDITION: opening_bid == '1NT'
  CONDITION: heart_len <= 3.5
  CONDITION: spade_len <= 3.5
  CONDITION: my_last_call != '1NT'
  # distilled from Brill /bid

RULE BD_False_P744:
  CALL: 2D
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call != 'PASS'
  CONDITION: last_bid_level <= 2.5
  CONDITION: partner_last_call != '2NT'
  CONDITION: last_bid_strain == 'C'
  CONDITION: passes_since_last_bid > 0.5
  CONDITION: opening_bid == '1NT'
  CONDITION: heart_len <= 3.5
  CONDITION: spade_len > 3.5
  CONDITION: hcp <= 13.0
  # distilled from Brill /bid

RULE BD_False_P745:
  CALL: 2S
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call != 'PASS'
  CONDITION: last_bid_level <= 2.5
  CONDITION: partner_last_call != '2NT'
  CONDITION: last_bid_strain == 'C'
  CONDITION: passes_since_last_bid > 0.5
  CONDITION: opening_bid == '1NT'
  CONDITION: heart_len <= 3.5
  CONDITION: spade_len > 3.5
  CONDITION: hcp > 13.0
  # distilled from Brill /bid

RULE BD_False_P746:
  CALL: 2H
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call != 'PASS'
  CONDITION: last_bid_level <= 2.5
  CONDITION: partner_last_call != '2NT'
  CONDITION: last_bid_strain == 'C'
  CONDITION: passes_since_last_bid > 0.5
  CONDITION: opening_bid == '1NT'
  CONDITION: heart_len > 3.5
  CONDITION: my_last_call == '1NT'
  # distilled from Brill /bid

RULE BD_False_P747:
  CALL: 2D
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call != 'PASS'
  CONDITION: last_bid_level <= 2.5
  CONDITION: partner_last_call != '2NT'
  CONDITION: last_bid_strain == 'C'
  CONDITION: passes_since_last_bid > 0.5
  CONDITION: opening_bid == '1NT'
  CONDITION: heart_len > 3.5
  CONDITION: my_last_call != '1NT'
  CONDITION: hcp <= 10.5
  # distilled from Brill /bid

RULE BD_False_P748:
  CALL: 2NT
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call != 'PASS'
  CONDITION: last_bid_level <= 2.5
  CONDITION: partner_last_call != '2NT'
  CONDITION: last_bid_strain == 'C'
  CONDITION: passes_since_last_bid > 0.5
  CONDITION: opening_bid == '1NT'
  CONDITION: heart_len > 3.5
  CONDITION: my_last_call != '1NT'
  CONDITION: hcp > 10.5
  # distilled from Brill /bid

RULE BD_False_P749:
  CALL: 2D
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call != 'PASS'
  CONDITION: last_bid_level <= 2.5
  CONDITION: partner_last_call != '2NT'
  CONDITION: last_bid_strain == 'C'
  CONDITION: passes_since_last_bid > 0.5
  CONDITION: opening_bid != '1NT'
  CONDITION: hcp <= 7.5
  CONDITION: opening_bid == '2C'
  CONDITION: controls <= 2.5
  # distilled from Brill /bid

RULE BD_False_P750:
  CALL: 2D
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call != 'PASS'
  CONDITION: last_bid_level <= 2.5
  CONDITION: partner_last_call != '2NT'
  CONDITION: last_bid_strain == 'C'
  CONDITION: passes_since_last_bid > 0.5
  CONDITION: opening_bid != '1NT'
  CONDITION: hcp <= 7.5
  CONDITION: opening_bid == '2C'
  CONDITION: controls > 2.5
  # distilled from Brill /bid

RULE BD_False_P751:
  CALL: 2D
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call != 'PASS'
  CONDITION: last_bid_level <= 2.5
  CONDITION: partner_last_call != '2NT'
  CONDITION: last_bid_strain == 'C'
  CONDITION: passes_since_last_bid > 0.5
  CONDITION: opening_bid != '1NT'
  CONDITION: hcp <= 7.5
  CONDITION: opening_bid != '2C'
  CONDITION: partner_first_call == '1D'
  # distilled from Brill /bid

RULE BD_False_P752:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call != 'PASS'
  CONDITION: last_bid_level <= 2.5
  CONDITION: partner_last_call != '2NT'
  CONDITION: last_bid_strain == 'C'
  CONDITION: passes_since_last_bid > 0.5
  CONDITION: opening_bid != '1NT'
  CONDITION: hcp <= 7.5
  CONDITION: opening_bid != '2C'
  CONDITION: partner_first_call != '1D'
  # distilled from Brill /bid

RULE BD_False_P753:
  CALL: 2NT
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call != 'PASS'
  CONDITION: last_bid_level <= 2.5
  CONDITION: partner_last_call != '2NT'
  CONDITION: last_bid_strain == 'C'
  CONDITION: passes_since_last_bid > 0.5
  CONDITION: opening_bid != '1NT'
  CONDITION: hcp > 7.5
  CONDITION: rule20_total <= 20.5
  CONDITION: partner_first_call == '2C'
  # distilled from Brill /bid

RULE BD_False_P754:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call != 'PASS'
  CONDITION: last_bid_level <= 2.5
  CONDITION: partner_last_call != '2NT'
  CONDITION: last_bid_strain == 'C'
  CONDITION: passes_since_last_bid > 0.5
  CONDITION: opening_bid != '1NT'
  CONDITION: hcp > 7.5
  CONDITION: rule20_total <= 20.5
  CONDITION: partner_first_call != '2C'
  # distilled from Brill /bid

RULE BD_False_P755:
  CALL: 4S
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call != 'PASS'
  CONDITION: last_bid_level <= 2.5
  CONDITION: partner_last_call != '2NT'
  CONDITION: last_bid_strain == 'C'
  CONDITION: passes_since_last_bid > 0.5
  CONDITION: opening_bid != '1NT'
  CONDITION: hcp > 7.5
  CONDITION: rule20_total > 20.5
  CONDITION: my_first_call == '1S'
  # distilled from Brill /bid

RULE BD_False_P756:
  CALL: 2NT
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call != 'PASS'
  CONDITION: last_bid_level <= 2.5
  CONDITION: partner_last_call != '2NT'
  CONDITION: last_bid_strain == 'C'
  CONDITION: passes_since_last_bid > 0.5
  CONDITION: opening_bid != '1NT'
  CONDITION: hcp > 7.5
  CONDITION: rule20_total > 20.5
  CONDITION: my_first_call != '1S'
  # distilled from Brill /bid

RULE BD_False_P757:
  CALL: 3C
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call != 'PASS'
  CONDITION: last_bid_level <= 2.5
  CONDITION: partner_last_call != '2NT'
  CONDITION: last_bid_strain != 'C'
  CONDITION: partner_last_call == '2S'
  CONDITION: spade_len <= 2.5
  CONDITION: opp_last_call == '1S'
  CONDITION: heart_len <= 4.5
  CONDITION: spade_hcp <= 1.5
  # distilled from Brill /bid

RULE BD_False_P758:
  CALL: 2NT
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call != 'PASS'
  CONDITION: last_bid_level <= 2.5
  CONDITION: partner_last_call != '2NT'
  CONDITION: last_bid_strain != 'C'
  CONDITION: partner_last_call == '2S'
  CONDITION: spade_len <= 2.5
  CONDITION: opp_last_call == '1S'
  CONDITION: heart_len <= 4.5
  CONDITION: spade_hcp > 1.5
  # distilled from Brill /bid

RULE BD_False_P759:
  CALL: 4H
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call != 'PASS'
  CONDITION: last_bid_level <= 2.5
  CONDITION: partner_last_call != '2NT'
  CONDITION: last_bid_strain != 'C'
  CONDITION: partner_last_call == '2S'
  CONDITION: spade_len <= 2.5
  CONDITION: opp_last_call == '1S'
  CONDITION: heart_len > 4.5
  CONDITION: losing_trick_count <= 6.5
  # distilled from Brill /bid

RULE BD_False_P760:
  CALL: 3H
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call != 'PASS'
  CONDITION: last_bid_level <= 2.5
  CONDITION: partner_last_call != '2NT'
  CONDITION: last_bid_strain != 'C'
  CONDITION: partner_last_call == '2S'
  CONDITION: spade_len <= 2.5
  CONDITION: opp_last_call == '1S'
  CONDITION: heart_len > 4.5
  CONDITION: losing_trick_count > 6.5
  # distilled from Brill /bid

RULE BD_False_P761:
  CALL: 2NT
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call != 'PASS'
  CONDITION: last_bid_level <= 2.5
  CONDITION: partner_last_call != '2NT'
  CONDITION: last_bid_strain != 'C'
  CONDITION: partner_last_call == '2S'
  CONDITION: spade_len <= 2.5
  CONDITION: opp_last_call != '1S'
  CONDITION: hcp <= 14.5
  CONDITION: partner_first_call == '1NT'
  # distilled from Brill /bid

RULE BD_False_P762:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call != 'PASS'
  CONDITION: last_bid_level <= 2.5
  CONDITION: partner_last_call != '2NT'
  CONDITION: last_bid_strain != 'C'
  CONDITION: partner_last_call == '2S'
  CONDITION: spade_len <= 2.5
  CONDITION: opp_last_call != '1S'
  CONDITION: hcp <= 14.5
  CONDITION: partner_first_call != '1NT'
  # distilled from Brill /bid

RULE BD_False_P763:
  CALL: 2NT
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call != 'PASS'
  CONDITION: last_bid_level <= 2.5
  CONDITION: partner_last_call != '2NT'
  CONDITION: last_bid_strain != 'C'
  CONDITION: partner_last_call == '2S'
  CONDITION: spade_len <= 2.5
  CONDITION: opp_last_call != '1S'
  CONDITION: hcp > 14.5
  CONDITION: auction_len <= 3.5
  # distilled from Brill /bid

RULE BD_False_P764:
  CALL: 2NT
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call != 'PASS'
  CONDITION: last_bid_level <= 2.5
  CONDITION: partner_last_call != '2NT'
  CONDITION: last_bid_strain != 'C'
  CONDITION: partner_last_call == '2S'
  CONDITION: spade_len <= 2.5
  CONDITION: opp_last_call != '1S'
  CONDITION: hcp > 14.5
  CONDITION: auction_len > 3.5
  # distilled from Brill /bid

RULE BD_False_P765:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call != 'PASS'
  CONDITION: last_bid_level <= 2.5
  CONDITION: partner_last_call != '2NT'
  CONDITION: last_bid_strain != 'C'
  CONDITION: partner_last_call == '2S'
  CONDITION: spade_len > 2.5
  CONDITION: total_points <= 15.5
  CONDITION: competition_level <= 3.5
  CONDITION: my_last_call == '2H'
  # distilled from Brill /bid

RULE BD_False_P766:
  CALL: 3S
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call != 'PASS'
  CONDITION: last_bid_level <= 2.5
  CONDITION: partner_last_call != '2NT'
  CONDITION: last_bid_strain != 'C'
  CONDITION: partner_last_call == '2S'
  CONDITION: spade_len > 2.5
  CONDITION: total_points <= 15.5
  CONDITION: competition_level <= 3.5
  CONDITION: my_last_call != '2H'
  # distilled from Brill /bid

RULE BD_False_P767:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call != 'PASS'
  CONDITION: last_bid_level <= 2.5
  CONDITION: partner_last_call != '2NT'
  CONDITION: last_bid_strain != 'C'
  CONDITION: partner_last_call == '2S'
  CONDITION: spade_len > 2.5
  CONDITION: total_points <= 15.5
  CONDITION: competition_level > 3.5
  CONDITION: our_fit_shown <= 0.5
  # distilled from Brill /bid

RULE BD_False_P768:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call != 'PASS'
  CONDITION: last_bid_level <= 2.5
  CONDITION: partner_last_call != '2NT'
  CONDITION: last_bid_strain != 'C'
  CONDITION: partner_last_call == '2S'
  CONDITION: spade_len > 2.5
  CONDITION: total_points <= 15.5
  CONDITION: competition_level > 3.5
  CONDITION: our_fit_shown > 0.5
  # distilled from Brill /bid

RULE BD_False_P769:
  CALL: 4S
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call != 'PASS'
  CONDITION: last_bid_level <= 2.5
  CONDITION: partner_last_call != '2NT'
  CONDITION: last_bid_strain != 'C'
  CONDITION: partner_last_call == '2S'
  CONDITION: spade_len > 2.5
  CONDITION: total_points > 15.5
  CONDITION: my_last_call == '1S'
  CONDITION: opening_bid == '1S'
  # distilled from Brill /bid

RULE BD_False_P770:
  CALL: 4S
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call != 'PASS'
  CONDITION: last_bid_level <= 2.5
  CONDITION: partner_last_call != '2NT'
  CONDITION: last_bid_strain != 'C'
  CONDITION: partner_last_call == '2S'
  CONDITION: spade_len > 2.5
  CONDITION: total_points > 15.5
  CONDITION: my_last_call == '1S'
  CONDITION: opening_bid != '1S'
  # distilled from Brill /bid

RULE BD_False_P771:
  CALL: 4S
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call != 'PASS'
  CONDITION: last_bid_level <= 2.5
  CONDITION: partner_last_call != '2NT'
  CONDITION: last_bid_strain != 'C'
  CONDITION: partner_last_call == '2S'
  CONDITION: spade_len > 2.5
  CONDITION: total_points > 15.5
  CONDITION: my_last_call != '1S'
  CONDITION: auction_len <= 3.5
  # distilled from Brill /bid

RULE BD_False_P772:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call != 'PASS'
  CONDITION: last_bid_level <= 2.5
  CONDITION: partner_last_call != '2NT'
  CONDITION: last_bid_strain != 'C'
  CONDITION: partner_last_call == '2S'
  CONDITION: spade_len > 2.5
  CONDITION: total_points > 15.5
  CONDITION: my_last_call != '1S'
  CONDITION: auction_len > 3.5
  # distilled from Brill /bid

RULE BD_False_P773:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call != 'PASS'
  CONDITION: last_bid_level <= 2.5
  CONDITION: partner_last_call != '2NT'
  CONDITION: last_bid_strain != 'C'
  CONDITION: partner_last_call != '2S'
  CONDITION: passes_since_last_bid <= 0.5
  CONDITION: hcp <= 6.5
  CONDITION: support_in_partner_suit <= 3.5
  CONDITION: spade_len <= 4.5
  # distilled from Brill /bid

RULE BD_False_P774:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call != 'PASS'
  CONDITION: last_bid_level <= 2.5
  CONDITION: partner_last_call != '2NT'
  CONDITION: last_bid_strain != 'C'
  CONDITION: partner_last_call != '2S'
  CONDITION: passes_since_last_bid <= 0.5
  CONDITION: hcp <= 6.5
  CONDITION: support_in_partner_suit <= 3.5
  CONDITION: spade_len > 4.5
  # distilled from Brill /bid

RULE BD_False_P775:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call != 'PASS'
  CONDITION: last_bid_level <= 2.5
  CONDITION: partner_last_call != '2NT'
  CONDITION: last_bid_strain != 'C'
  CONDITION: partner_last_call != '2S'
  CONDITION: passes_since_last_bid <= 0.5
  CONDITION: hcp <= 6.5
  CONDITION: support_in_partner_suit > 3.5
  CONDITION: partner_last_call == '1S'
  # distilled from Brill /bid

RULE BD_False_P776:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call != 'PASS'
  CONDITION: last_bid_level <= 2.5
  CONDITION: partner_last_call != '2NT'
  CONDITION: last_bid_strain != 'C'
  CONDITION: partner_last_call != '2S'
  CONDITION: passes_since_last_bid <= 0.5
  CONDITION: hcp <= 6.5
  CONDITION: support_in_partner_suit > 3.5
  CONDITION: partner_last_call != '1S'
  # distilled from Brill /bid

RULE BD_False_P777:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call != 'PASS'
  CONDITION: last_bid_level <= 2.5
  CONDITION: partner_last_call != '2NT'
  CONDITION: last_bid_strain != 'C'
  CONDITION: partner_last_call != '2S'
  CONDITION: passes_since_last_bid <= 0.5
  CONDITION: hcp > 6.5
  CONDITION: support_in_partner_suit <= 2.5
  CONDITION: s_is_longest <= 0.5
  # distilled from Brill /bid

RULE BD_False_P778:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call != 'PASS'
  CONDITION: last_bid_level <= 2.5
  CONDITION: partner_last_call != '2NT'
  CONDITION: last_bid_strain != 'C'
  CONDITION: partner_last_call != '2S'
  CONDITION: passes_since_last_bid <= 0.5
  CONDITION: hcp > 6.5
  CONDITION: support_in_partner_suit <= 2.5
  CONDITION: s_is_longest > 0.5
  # distilled from Brill /bid

RULE BD_False_P779:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call != 'PASS'
  CONDITION: last_bid_level <= 2.5
  CONDITION: partner_last_call != '2NT'
  CONDITION: last_bid_strain != 'C'
  CONDITION: partner_last_call != '2S'
  CONDITION: passes_since_last_bid <= 0.5
  CONDITION: hcp > 6.5
  CONDITION: support_in_partner_suit > 2.5
  CONDITION: partner_last_call == '2H'
  # distilled from Brill /bid

RULE BD_False_P780:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call != 'PASS'
  CONDITION: last_bid_level <= 2.5
  CONDITION: partner_last_call != '2NT'
  CONDITION: last_bid_strain != 'C'
  CONDITION: partner_last_call != '2S'
  CONDITION: passes_since_last_bid <= 0.5
  CONDITION: hcp > 6.5
  CONDITION: support_in_partner_suit > 2.5
  CONDITION: partner_last_call != '2H'
  # distilled from Brill /bid

RULE BD_False_P781:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call != 'PASS'
  CONDITION: last_bid_level <= 2.5
  CONDITION: partner_last_call != '2NT'
  CONDITION: last_bid_strain != 'C'
  CONDITION: partner_last_call != '2S'
  CONDITION: passes_since_last_bid > 0.5
  CONDITION: partner_last_call == '2H'
  CONDITION: my_first_call == '1NT'
  CONDITION: hcp <= 14.5
  # distilled from Brill /bid

RULE BD_False_P782:
  CALL: 2S
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call != 'PASS'
  CONDITION: last_bid_level <= 2.5
  CONDITION: partner_last_call != '2NT'
  CONDITION: last_bid_strain != 'C'
  CONDITION: partner_last_call != '2S'
  CONDITION: passes_since_last_bid > 0.5
  CONDITION: partner_last_call == '2H'
  CONDITION: my_first_call == '1NT'
  CONDITION: hcp > 14.5
  # distilled from Brill /bid

RULE BD_False_P783:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call != 'PASS'
  CONDITION: last_bid_level <= 2.5
  CONDITION: partner_last_call != '2NT'
  CONDITION: last_bid_strain != 'C'
  CONDITION: partner_last_call != '2S'
  CONDITION: passes_since_last_bid > 0.5
  CONDITION: partner_last_call == '2H'
  CONDITION: my_first_call != '1NT'
  CONDITION: heart_len <= 2.5
  # distilled from Brill /bid

RULE BD_False_P784:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call != 'PASS'
  CONDITION: last_bid_level <= 2.5
  CONDITION: partner_last_call != '2NT'
  CONDITION: last_bid_strain != 'C'
  CONDITION: partner_last_call != '2S'
  CONDITION: passes_since_last_bid > 0.5
  CONDITION: partner_last_call == '2H'
  CONDITION: my_first_call != '1NT'
  CONDITION: heart_len > 2.5
  # distilled from Brill /bid

RULE BD_False_P785:
  CALL: 2H
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call != 'PASS'
  CONDITION: last_bid_level <= 2.5
  CONDITION: partner_last_call != '2NT'
  CONDITION: last_bid_strain != 'C'
  CONDITION: partner_last_call != '2S'
  CONDITION: passes_since_last_bid > 0.5
  CONDITION: partner_last_call != '2H'
  CONDITION: my_first_call == '1NT'
  CONDITION: my_side_bid_count <= 2.5
  # distilled from Brill /bid

RULE BD_False_P786:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call != 'PASS'
  CONDITION: last_bid_level <= 2.5
  CONDITION: partner_last_call != '2NT'
  CONDITION: last_bid_strain != 'C'
  CONDITION: partner_last_call != '2S'
  CONDITION: passes_since_last_bid > 0.5
  CONDITION: partner_last_call != '2H'
  CONDITION: my_first_call == '1NT'
  CONDITION: my_side_bid_count > 2.5
  # distilled from Brill /bid

RULE BD_False_P787:
  CALL: 2NT
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call != 'PASS'
  CONDITION: last_bid_level <= 2.5
  CONDITION: partner_last_call != '2NT'
  CONDITION: last_bid_strain != 'C'
  CONDITION: partner_last_call != '2S'
  CONDITION: passes_since_last_bid > 0.5
  CONDITION: partner_last_call != '2H'
  CONDITION: my_first_call != '1NT'
  CONDITION: partner_first_call == '1NT'
  # distilled from Brill /bid

RULE BD_False_P788:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call != 'PASS'
  CONDITION: last_bid_level <= 2.5
  CONDITION: partner_last_call != '2NT'
  CONDITION: last_bid_strain != 'C'
  CONDITION: partner_last_call != '2S'
  CONDITION: passes_since_last_bid > 0.5
  CONDITION: partner_last_call != '2H'
  CONDITION: my_first_call != '1NT'
  CONDITION: partner_first_call != '1NT'
  # distilled from Brill /bid

RULE BD_False_P789:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call != 'PASS'
  CONDITION: last_bid_level > 2.5
  CONDITION: last_bid_level <= 3.5
  CONDITION: last_bid_strain == 'NT'
  CONDITION: partner_first_call == '2H'
  CONDITION: my_first_call == '2NT'
  CONDITION: heart_len <= 1.5
  # distilled from Brill /bid

RULE BD_False_P790:
  CALL: 4H
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call != 'PASS'
  CONDITION: last_bid_level > 2.5
  CONDITION: last_bid_level <= 3.5
  CONDITION: last_bid_strain == 'NT'
  CONDITION: partner_first_call == '2H'
  CONDITION: my_first_call == '2NT'
  CONDITION: heart_len > 1.5
  CONDITION: hcp <= 19.5
  # distilled from Brill /bid

RULE BD_False_P791:
  CALL: 4NT
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call != 'PASS'
  CONDITION: last_bid_level > 2.5
  CONDITION: last_bid_level <= 3.5
  CONDITION: last_bid_strain == 'NT'
  CONDITION: partner_first_call == '2H'
  CONDITION: my_first_call == '2NT'
  CONDITION: heart_len > 1.5
  CONDITION: hcp > 19.5
  # distilled from Brill /bid

RULE BD_False_P792:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call != 'PASS'
  CONDITION: last_bid_level > 2.5
  CONDITION: last_bid_level <= 3.5
  CONDITION: last_bid_strain == 'NT'
  CONDITION: partner_first_call == '2H'
  CONDITION: my_first_call != '2NT'
  CONDITION: my_first_call == '1NT'
  CONDITION: spade_len <= 2.5
  # distilled from Brill /bid

RULE BD_False_P793:
  CALL: 4S
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call != 'PASS'
  CONDITION: last_bid_level > 2.5
  CONDITION: last_bid_level <= 3.5
  CONDITION: last_bid_strain == 'NT'
  CONDITION: partner_first_call == '2H'
  CONDITION: my_first_call != '2NT'
  CONDITION: my_first_call == '1NT'
  CONDITION: spade_len > 2.5
  # distilled from Brill /bid

RULE BD_False_P794:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call != 'PASS'
  CONDITION: last_bid_level > 2.5
  CONDITION: last_bid_level <= 3.5
  CONDITION: last_bid_strain == 'NT'
  CONDITION: partner_first_call == '2H'
  CONDITION: my_first_call != '2NT'
  CONDITION: my_first_call != '1NT'
  # distilled from Brill /bid

RULE BD_False_P795:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call != 'PASS'
  CONDITION: last_bid_level > 2.5
  CONDITION: last_bid_level <= 3.5
  CONDITION: last_bid_strain == 'NT'
  CONDITION: partner_first_call != '2H'
  CONDITION: my_last_call == '2NT'
  CONDITION: opening_bid == '2S'
  CONDITION: support_in_partner_suit <= 1.5
  # distilled from Brill /bid

RULE BD_False_P796:
  CALL: 4S
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call != 'PASS'
  CONDITION: last_bid_level > 2.5
  CONDITION: last_bid_level <= 3.5
  CONDITION: last_bid_strain == 'NT'
  CONDITION: partner_first_call != '2H'
  CONDITION: my_last_call == '2NT'
  CONDITION: opening_bid == '2S'
  CONDITION: support_in_partner_suit > 1.5
  # distilled from Brill /bid

RULE BD_False_P797:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call != 'PASS'
  CONDITION: last_bid_level > 2.5
  CONDITION: last_bid_level <= 3.5
  CONDITION: last_bid_strain == 'NT'
  CONDITION: partner_first_call != '2H'
  CONDITION: my_last_call == '2NT'
  CONDITION: opening_bid != '2S'
  CONDITION: hcp <= 6.5
  CONDITION: heart_hcp <= 3.5
  # distilled from Brill /bid

RULE BD_False_P798:
  CALL: 4S
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call != 'PASS'
  CONDITION: last_bid_level > 2.5
  CONDITION: last_bid_level <= 3.5
  CONDITION: last_bid_strain == 'NT'
  CONDITION: partner_first_call != '2H'
  CONDITION: my_last_call == '2NT'
  CONDITION: opening_bid != '2S'
  CONDITION: hcp <= 6.5
  CONDITION: heart_hcp > 3.5
  # distilled from Brill /bid

RULE BD_False_P799:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call != 'PASS'
  CONDITION: last_bid_level > 2.5
  CONDITION: last_bid_level <= 3.5
  CONDITION: last_bid_strain == 'NT'
  CONDITION: partner_first_call != '2H'
  CONDITION: my_last_call == '2NT'
  CONDITION: opening_bid != '2S'
  CONDITION: hcp > 6.5
  CONDITION: heart_len <= 5.5
  # distilled from Brill /bid

RULE BD_False_P800:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call != 'PASS'
  CONDITION: last_bid_level > 2.5
  CONDITION: last_bid_level <= 3.5
  CONDITION: last_bid_strain == 'NT'
  CONDITION: partner_first_call != '2H'
  CONDITION: my_last_call == '2NT'
  CONDITION: opening_bid != '2S'
  CONDITION: hcp > 6.5
  CONDITION: heart_len > 5.5
  # distilled from Brill /bid

RULE BD_False_P801:
  CALL: 4S
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call != 'PASS'
  CONDITION: last_bid_level > 2.5
  CONDITION: last_bid_level <= 3.5
  CONDITION: last_bid_strain == 'NT'
  CONDITION: partner_first_call != '2H'
  CONDITION: my_last_call != '2NT'
  CONDITION: my_first_call == '1S'
  CONDITION: competition_level <= 2.5
  CONDITION: quick_tricks <= 3.0
  # distilled from Brill /bid

RULE BD_False_P802:
  CALL: 4NT
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call != 'PASS'
  CONDITION: last_bid_level > 2.5
  CONDITION: last_bid_level <= 3.5
  CONDITION: last_bid_strain == 'NT'
  CONDITION: partner_first_call != '2H'
  CONDITION: my_last_call != '2NT'
  CONDITION: my_first_call == '1S'
  CONDITION: competition_level <= 2.5
  CONDITION: quick_tricks > 3.0
  # distilled from Brill /bid

RULE BD_False_P803:
  CALL: 4S
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call != 'PASS'
  CONDITION: last_bid_level > 2.5
  CONDITION: last_bid_level <= 3.5
  CONDITION: last_bid_strain == 'NT'
  CONDITION: partner_first_call != '2H'
  CONDITION: my_last_call != '2NT'
  CONDITION: my_first_call == '1S'
  CONDITION: competition_level > 2.5
  CONDITION: partner_last_bid_strain == 'S'
  # distilled from Brill /bid

RULE BD_False_P804:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call != 'PASS'
  CONDITION: last_bid_level > 2.5
  CONDITION: last_bid_level <= 3.5
  CONDITION: last_bid_strain == 'NT'
  CONDITION: partner_first_call != '2H'
  CONDITION: my_last_call != '2NT'
  CONDITION: my_first_call == '1S'
  CONDITION: competition_level > 2.5
  CONDITION: partner_last_bid_strain != 'S'
  # distilled from Brill /bid

RULE BD_False_P805:
  CALL: 4H
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call != 'PASS'
  CONDITION: last_bid_level > 2.5
  CONDITION: last_bid_level <= 3.5
  CONDITION: last_bid_strain == 'NT'
  CONDITION: partner_first_call != '2H'
  CONDITION: my_last_call != '2NT'
  CONDITION: my_first_call != '1S'
  CONDITION: my_last_call == '1H'
  CONDITION: auction_len <= 5.5
  # distilled from Brill /bid

RULE BD_False_P806:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call != 'PASS'
  CONDITION: last_bid_level > 2.5
  CONDITION: last_bid_level <= 3.5
  CONDITION: last_bid_strain == 'NT'
  CONDITION: partner_first_call != '2H'
  CONDITION: my_last_call != '2NT'
  CONDITION: my_first_call != '1S'
  CONDITION: my_last_call == '1H'
  CONDITION: auction_len > 5.5
  # distilled from Brill /bid

RULE BD_False_P807:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call != 'PASS'
  CONDITION: last_bid_level > 2.5
  CONDITION: last_bid_level <= 3.5
  CONDITION: last_bid_strain == 'NT'
  CONDITION: partner_first_call != '2H'
  CONDITION: my_last_call != '2NT'
  CONDITION: my_first_call != '1S'
  CONDITION: my_last_call != '1H'
  CONDITION: partner_last_bid_strain == 'D'
  # distilled from Brill /bid

RULE BD_False_P808:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call != 'PASS'
  CONDITION: last_bid_level > 2.5
  CONDITION: last_bid_level <= 3.5
  CONDITION: last_bid_strain == 'NT'
  CONDITION: partner_first_call != '2H'
  CONDITION: my_last_call != '2NT'
  CONDITION: my_first_call != '1S'
  CONDITION: my_last_call != '1H'
  CONDITION: partner_last_bid_strain != 'D'
  # distilled from Brill /bid

RULE BD_False_P809:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call != 'PASS'
  CONDITION: last_bid_level > 2.5
  CONDITION: last_bid_level <= 3.5
  CONDITION: last_bid_strain != 'NT'
  CONDITION: partner_last_call == '3S'
  CONDITION: agreed_trump == 'S'
  CONDITION: total_points <= 15.5
  CONDITION: my_side_bid_count <= 4.5
  CONDITION: opp_contract_level <= 2.5
  # distilled from Brill /bid

RULE BD_False_P810:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call != 'PASS'
  CONDITION: last_bid_level > 2.5
  CONDITION: last_bid_level <= 3.5
  CONDITION: last_bid_strain != 'NT'
  CONDITION: partner_last_call == '3S'
  CONDITION: agreed_trump == 'S'
  CONDITION: total_points <= 15.5
  CONDITION: my_side_bid_count <= 4.5
  CONDITION: opp_contract_level > 2.5
  # distilled from Brill /bid

RULE BD_False_P811:
  CALL: 4S
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call != 'PASS'
  CONDITION: last_bid_level > 2.5
  CONDITION: last_bid_level <= 3.5
  CONDITION: last_bid_strain != 'NT'
  CONDITION: partner_last_call == '3S'
  CONDITION: agreed_trump == 'S'
  CONDITION: total_points <= 15.5
  CONDITION: my_side_bid_count > 4.5
  CONDITION: club_len <= 2.5
  # distilled from Brill /bid

RULE BD_False_P812:
  CALL: 4S
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call != 'PASS'
  CONDITION: last_bid_level > 2.5
  CONDITION: last_bid_level <= 3.5
  CONDITION: last_bid_strain != 'NT'
  CONDITION: partner_last_call == '3S'
  CONDITION: agreed_trump == 'S'
  CONDITION: total_points <= 15.5
  CONDITION: my_side_bid_count > 4.5
  CONDITION: club_len > 2.5
  # distilled from Brill /bid

RULE BD_False_P813:
  CALL: 4S
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call != 'PASS'
  CONDITION: last_bid_level > 2.5
  CONDITION: last_bid_level <= 3.5
  CONDITION: last_bid_strain != 'NT'
  CONDITION: partner_last_call == '3S'
  CONDITION: agreed_trump == 'S'
  CONDITION: total_points > 15.5
  CONDITION: opponents_bid <= 0.5
  CONDITION: spade_len <= 4.5
  # distilled from Brill /bid

RULE BD_False_P814:
  CALL: 4S
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call != 'PASS'
  CONDITION: last_bid_level > 2.5
  CONDITION: last_bid_level <= 3.5
  CONDITION: last_bid_strain != 'NT'
  CONDITION: partner_last_call == '3S'
  CONDITION: agreed_trump == 'S'
  CONDITION: total_points > 15.5
  CONDITION: opponents_bid <= 0.5
  CONDITION: spade_len > 4.5
  # distilled from Brill /bid

RULE BD_False_P815:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call != 'PASS'
  CONDITION: last_bid_level > 2.5
  CONDITION: last_bid_level <= 3.5
  CONDITION: last_bid_strain != 'NT'
  CONDITION: partner_last_call == '3S'
  CONDITION: agreed_trump == 'S'
  CONDITION: total_points > 15.5
  CONDITION: opponents_bid > 0.5
  CONDITION: my_last_call == 'X'
  # distilled from Brill /bid

RULE BD_False_P816:
  CALL: 4S
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call != 'PASS'
  CONDITION: last_bid_level > 2.5
  CONDITION: last_bid_level <= 3.5
  CONDITION: last_bid_strain != 'NT'
  CONDITION: partner_last_call == '3S'
  CONDITION: agreed_trump == 'S'
  CONDITION: total_points > 15.5
  CONDITION: opponents_bid > 0.5
  CONDITION: my_last_call != 'X'
  # distilled from Brill /bid

RULE BD_False_P817:
  CALL: 3NT
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call != 'PASS'
  CONDITION: last_bid_level > 2.5
  CONDITION: last_bid_level <= 3.5
  CONDITION: last_bid_strain != 'NT'
  CONDITION: partner_last_call == '3S'
  CONDITION: agreed_trump != 'S'
  CONDITION: opponents_bid <= 0.5
  CONDITION: spade_len <= 1.5
  CONDITION: total_points <= 19.5
  # distilled from Brill /bid

RULE BD_False_P818:
  CALL: 3NT
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call != 'PASS'
  CONDITION: last_bid_level > 2.5
  CONDITION: last_bid_level <= 3.5
  CONDITION: last_bid_strain != 'NT'
  CONDITION: partner_last_call == '3S'
  CONDITION: agreed_trump != 'S'
  CONDITION: opponents_bid <= 0.5
  CONDITION: spade_len <= 1.5
  CONDITION: total_points > 19.5
  # distilled from Brill /bid

RULE BD_False_P819:
  CALL: 4S
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call != 'PASS'
  CONDITION: last_bid_level > 2.5
  CONDITION: last_bid_level <= 3.5
  CONDITION: last_bid_strain != 'NT'
  CONDITION: partner_last_call == '3S'
  CONDITION: agreed_trump != 'S'
  CONDITION: opponents_bid <= 0.5
  CONDITION: spade_len > 1.5
  CONDITION: hcp <= 10.5
  # distilled from Brill /bid

RULE BD_False_P820:
  CALL: 4S
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call != 'PASS'
  CONDITION: last_bid_level > 2.5
  CONDITION: last_bid_level <= 3.5
  CONDITION: last_bid_strain != 'NT'
  CONDITION: partner_last_call == '3S'
  CONDITION: agreed_trump != 'S'
  CONDITION: opponents_bid <= 0.5
  CONDITION: spade_len > 1.5
  CONDITION: hcp > 10.5
  # distilled from Brill /bid

RULE BD_False_P821:
  CALL: 3NT
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call != 'PASS'
  CONDITION: last_bid_level > 2.5
  CONDITION: last_bid_level <= 3.5
  CONDITION: last_bid_strain != 'NT'
  CONDITION: partner_last_call == '3S'
  CONDITION: agreed_trump != 'S'
  CONDITION: opponents_bid > 0.5
  CONDITION: opp_last_call == '2S'
  CONDITION: opp_fit_shown <= 0.5
  # distilled from Brill /bid

RULE BD_False_P822:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call != 'PASS'
  CONDITION: last_bid_level > 2.5
  CONDITION: last_bid_level <= 3.5
  CONDITION: last_bid_strain != 'NT'
  CONDITION: partner_last_call == '3S'
  CONDITION: agreed_trump != 'S'
  CONDITION: opponents_bid > 0.5
  CONDITION: opp_last_call == '2S'
  CONDITION: opp_fit_shown > 0.5
  # distilled from Brill /bid

RULE BD_False_P823:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call != 'PASS'
  CONDITION: last_bid_level > 2.5
  CONDITION: last_bid_level <= 3.5
  CONDITION: last_bid_strain != 'NT'
  CONDITION: partner_last_call == '3S'
  CONDITION: agreed_trump != 'S'
  CONDITION: opponents_bid > 0.5
  CONDITION: opp_last_call != '2S'
  CONDITION: hcp <= 9.5
  # distilled from Brill /bid

RULE BD_False_P824:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call != 'PASS'
  CONDITION: last_bid_level > 2.5
  CONDITION: last_bid_level <= 3.5
  CONDITION: last_bid_strain != 'NT'
  CONDITION: partner_last_call == '3S'
  CONDITION: agreed_trump != 'S'
  CONDITION: opponents_bid > 0.5
  CONDITION: opp_last_call != '2S'
  CONDITION: hcp > 9.5
  # distilled from Brill /bid

RULE BD_False_P825:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call != 'PASS'
  CONDITION: last_bid_level > 2.5
  CONDITION: last_bid_level <= 3.5
  CONDITION: last_bid_strain != 'NT'
  CONDITION: partner_last_call != '3S'
  CONDITION: partner_last_call == '3H'
  CONDITION: agreed_trump == 'H'
  CONDITION: rule20_total <= 23.5
  CONDITION: my_side_bid_count <= 2.5
  # distilled from Brill /bid

RULE BD_False_P826:
  CALL: 4H
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call != 'PASS'
  CONDITION: last_bid_level > 2.5
  CONDITION: last_bid_level <= 3.5
  CONDITION: last_bid_strain != 'NT'
  CONDITION: partner_last_call != '3S'
  CONDITION: partner_last_call == '3H'
  CONDITION: agreed_trump == 'H'
  CONDITION: rule20_total <= 23.5
  CONDITION: my_side_bid_count > 2.5
  # distilled from Brill /bid

RULE BD_False_P827:
  CALL: 4H
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call != 'PASS'
  CONDITION: last_bid_level > 2.5
  CONDITION: last_bid_level <= 3.5
  CONDITION: last_bid_strain != 'NT'
  CONDITION: partner_last_call != '3S'
  CONDITION: partner_last_call == '3H'
  CONDITION: agreed_trump == 'H'
  CONDITION: rule20_total > 23.5
  CONDITION: heart_len <= 4.5
  # distilled from Brill /bid

RULE BD_False_P828:
  CALL: 4H
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call != 'PASS'
  CONDITION: last_bid_level > 2.5
  CONDITION: last_bid_level <= 3.5
  CONDITION: last_bid_strain != 'NT'
  CONDITION: partner_last_call != '3S'
  CONDITION: partner_last_call == '3H'
  CONDITION: agreed_trump == 'H'
  CONDITION: rule20_total > 23.5
  CONDITION: heart_len > 4.5
  # distilled from Brill /bid

RULE BD_False_P829:
  CALL: 4H
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call != 'PASS'
  CONDITION: last_bid_level > 2.5
  CONDITION: last_bid_level <= 3.5
  CONDITION: last_bid_strain != 'NT'
  CONDITION: partner_last_call != '3S'
  CONDITION: partner_last_call == '3H'
  CONDITION: agreed_trump != 'H'
  CONDITION: opponents_bid <= 0.5
  CONDITION: hcp <= 14.5
  # distilled from Brill /bid

RULE BD_False_P830:
  CALL: 3S
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call != 'PASS'
  CONDITION: last_bid_level > 2.5
  CONDITION: last_bid_level <= 3.5
  CONDITION: last_bid_strain != 'NT'
  CONDITION: partner_last_call != '3S'
  CONDITION: partner_last_call == '3H'
  CONDITION: agreed_trump != 'H'
  CONDITION: opponents_bid <= 0.5
  CONDITION: hcp > 14.5
  # distilled from Brill /bid

RULE BD_False_P831:
  CALL: 3S
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call != 'PASS'
  CONDITION: last_bid_level > 2.5
  CONDITION: last_bid_level <= 3.5
  CONDITION: last_bid_strain != 'NT'
  CONDITION: partner_last_call != '3S'
  CONDITION: partner_last_call == '3H'
  CONDITION: agreed_trump != 'H'
  CONDITION: opponents_bid > 0.5
  CONDITION: my_last_call == '1S'
  # distilled from Brill /bid

RULE BD_False_P832:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call != 'PASS'
  CONDITION: last_bid_level > 2.5
  CONDITION: last_bid_level <= 3.5
  CONDITION: last_bid_strain != 'NT'
  CONDITION: partner_last_call != '3S'
  CONDITION: partner_last_call == '3H'
  CONDITION: agreed_trump != 'H'
  CONDITION: opponents_bid > 0.5
  CONDITION: my_last_call != '1S'
  # distilled from Brill /bid

RULE BD_False_P833:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call != 'PASS'
  CONDITION: last_bid_level > 2.5
  CONDITION: last_bid_level <= 3.5
  CONDITION: last_bid_strain != 'NT'
  CONDITION: partner_last_call != '3S'
  CONDITION: partner_last_call != '3H'
  CONDITION: opponents_bid <= 0.5
  CONDITION: hcp <= 14.5
  CONDITION: my_side_bid_count <= 2.5
  # distilled from Brill /bid

RULE BD_False_P834:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call != 'PASS'
  CONDITION: last_bid_level > 2.5
  CONDITION: last_bid_level <= 3.5
  CONDITION: last_bid_strain != 'NT'
  CONDITION: partner_last_call != '3S'
  CONDITION: partner_last_call != '3H'
  CONDITION: opponents_bid <= 0.5
  CONDITION: hcp <= 14.5
  CONDITION: my_side_bid_count > 2.5
  # distilled from Brill /bid

RULE BD_False_P835:
  CALL: 3H
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call != 'PASS'
  CONDITION: last_bid_level > 2.5
  CONDITION: last_bid_level <= 3.5
  CONDITION: last_bid_strain != 'NT'
  CONDITION: partner_last_call != '3S'
  CONDITION: partner_last_call != '3H'
  CONDITION: opponents_bid <= 0.5
  CONDITION: hcp > 14.5
  CONDITION: my_last_call == '2NT'
  # distilled from Brill /bid

RULE BD_False_P836:
  CALL: 3NT
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call != 'PASS'
  CONDITION: last_bid_level > 2.5
  CONDITION: last_bid_level <= 3.5
  CONDITION: last_bid_strain != 'NT'
  CONDITION: partner_last_call != '3S'
  CONDITION: partner_last_call != '3H'
  CONDITION: opponents_bid <= 0.5
  CONDITION: hcp > 14.5
  CONDITION: my_last_call != '2NT'
  # distilled from Brill /bid

RULE BD_False_P837:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call != 'PASS'
  CONDITION: last_bid_level > 2.5
  CONDITION: last_bid_level <= 3.5
  CONDITION: last_bid_strain != 'NT'
  CONDITION: partner_last_call != '3S'
  CONDITION: partner_last_call != '3H'
  CONDITION: opponents_bid > 0.5
  CONDITION: partner_last_bid_strain == 'S'
  CONDITION: spade_len <= 2.5
  # distilled from Brill /bid

RULE BD_False_P838:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call != 'PASS'
  CONDITION: last_bid_level > 2.5
  CONDITION: last_bid_level <= 3.5
  CONDITION: last_bid_strain != 'NT'
  CONDITION: partner_last_call != '3S'
  CONDITION: partner_last_call != '3H'
  CONDITION: opponents_bid > 0.5
  CONDITION: partner_last_bid_strain == 'S'
  CONDITION: spade_len > 2.5
  # distilled from Brill /bid

RULE BD_False_P839:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call != 'PASS'
  CONDITION: last_bid_level > 2.5
  CONDITION: last_bid_level <= 3.5
  CONDITION: last_bid_strain != 'NT'
  CONDITION: partner_last_call != '3S'
  CONDITION: partner_last_call != '3H'
  CONDITION: opponents_bid > 0.5
  CONDITION: partner_last_bid_strain != 'S'
  CONDITION: spade_len <= 4.5
  # distilled from Brill /bid

RULE BD_False_P840:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call != 'PASS'
  CONDITION: last_bid_level > 2.5
  CONDITION: last_bid_level <= 3.5
  CONDITION: last_bid_strain != 'NT'
  CONDITION: partner_last_call != '3S'
  CONDITION: partner_last_call != '3H'
  CONDITION: opponents_bid > 0.5
  CONDITION: partner_last_bid_strain != 'S'
  CONDITION: spade_len > 4.5
  # distilled from Brill /bid

RULE BD_False_P841:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call != 'PASS'
  CONDITION: last_bid_level > 2.5
  CONDITION: last_bid_level > 3.5
  CONDITION: partner_last_call == '4NT'
  CONDITION: keycard_count_agreed <= 1.5
  CONDITION: keycard_count_agreed <= 0.5
  CONDITION: our_fit_shown <= 0.5
  CONDITION: my_last_call == '2NT'
  CONDITION: hcp <= 10.5
  # distilled from Brill /bid

RULE BD_False_P842:
  CALL: 6NT
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call != 'PASS'
  CONDITION: last_bid_level > 2.5
  CONDITION: last_bid_level > 3.5
  CONDITION: partner_last_call == '4NT'
  CONDITION: keycard_count_agreed <= 1.5
  CONDITION: keycard_count_agreed <= 0.5
  CONDITION: our_fit_shown <= 0.5
  CONDITION: my_last_call == '2NT'
  CONDITION: hcp > 10.5
  # distilled from Brill /bid

RULE BD_False_P843:
  CALL: 5C
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call != 'PASS'
  CONDITION: last_bid_level > 2.5
  CONDITION: last_bid_level > 3.5
  CONDITION: partner_last_call == '4NT'
  CONDITION: keycard_count_agreed <= 1.5
  CONDITION: keycard_count_agreed <= 0.5
  CONDITION: our_fit_shown <= 0.5
  CONDITION: my_last_call != '2NT'
  CONDITION: quick_tricks <= 0.75
  # distilled from Brill /bid

RULE BD_False_P844:
  CALL: 5D
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call != 'PASS'
  CONDITION: last_bid_level > 2.5
  CONDITION: last_bid_level > 3.5
  CONDITION: partner_last_call == '4NT'
  CONDITION: keycard_count_agreed <= 1.5
  CONDITION: keycard_count_agreed <= 0.5
  CONDITION: our_fit_shown <= 0.5
  CONDITION: my_last_call != '2NT'
  CONDITION: quick_tricks > 0.75
  # distilled from Brill /bid

RULE BD_False_P845:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call != 'PASS'
  CONDITION: last_bid_level > 2.5
  CONDITION: last_bid_level > 3.5
  CONDITION: partner_last_call == '4NT'
  CONDITION: keycard_count_agreed <= 1.5
  CONDITION: keycard_count_agreed <= 0.5
  CONDITION: our_fit_shown > 0.5
  CONDITION: my_last_call == '4C'
  # distilled from Brill /bid

RULE BD_False_P846:
  CALL: 5C
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call != 'PASS'
  CONDITION: last_bid_level > 2.5
  CONDITION: last_bid_level > 3.5
  CONDITION: partner_last_call == '4NT'
  CONDITION: keycard_count_agreed <= 1.5
  CONDITION: keycard_count_agreed <= 0.5
  CONDITION: our_fit_shown > 0.5
  CONDITION: my_last_call != '4C'
  # distilled from Brill /bid

RULE BD_False_P847:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call != 'PASS'
  CONDITION: last_bid_level > 2.5
  CONDITION: last_bid_level > 3.5
  CONDITION: partner_last_call == '4NT'
  CONDITION: keycard_count_agreed <= 1.5
  CONDITION: keycard_count_agreed > 0.5
  CONDITION: our_fit_shown <= 0.5
  CONDITION: my_last_call == '2NT'
  CONDITION: diamond_hcp <= 5.0
  # distilled from Brill /bid

RULE BD_False_P848:
  CALL: 6NT
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call != 'PASS'
  CONDITION: last_bid_level > 2.5
  CONDITION: last_bid_level > 3.5
  CONDITION: partner_last_call == '4NT'
  CONDITION: keycard_count_agreed <= 1.5
  CONDITION: keycard_count_agreed > 0.5
  CONDITION: our_fit_shown <= 0.5
  CONDITION: my_last_call == '2NT'
  CONDITION: diamond_hcp > 5.0
  # distilled from Brill /bid

RULE BD_False_P849:
  CALL: 5S
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call != 'PASS'
  CONDITION: last_bid_level > 2.5
  CONDITION: last_bid_level > 3.5
  CONDITION: partner_last_call == '4NT'
  CONDITION: keycard_count_agreed <= 1.5
  CONDITION: keycard_count_agreed > 0.5
  CONDITION: our_fit_shown <= 0.5
  CONDITION: my_last_call != '2NT'
  CONDITION: losing_trick_count <= 5.5
  # distilled from Brill /bid

RULE BD_False_P850:
  CALL: 5D
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call != 'PASS'
  CONDITION: last_bid_level > 2.5
  CONDITION: last_bid_level > 3.5
  CONDITION: partner_last_call == '4NT'
  CONDITION: keycard_count_agreed <= 1.5
  CONDITION: keycard_count_agreed > 0.5
  CONDITION: our_fit_shown <= 0.5
  CONDITION: my_last_call != '2NT'
  CONDITION: losing_trick_count > 5.5
  # distilled from Brill /bid

RULE BD_False_P851:
  CALL: 5D
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call != 'PASS'
  CONDITION: last_bid_level > 2.5
  CONDITION: last_bid_level > 3.5
  CONDITION: partner_last_call == '4NT'
  CONDITION: keycard_count_agreed <= 1.5
  CONDITION: keycard_count_agreed > 0.5
  CONDITION: our_fit_shown > 0.5
  # distilled from Brill /bid

RULE BD_False_P852:
  CALL: 5NT
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call != 'PASS'
  CONDITION: last_bid_level > 2.5
  CONDITION: last_bid_level > 3.5
  CONDITION: partner_last_call == '4NT'
  CONDITION: keycard_count_agreed > 1.5
  CONDITION: keycard_count_agreed <= 2.5
  CONDITION: our_fit_shown <= 0.5
  CONDITION: shortest_suit_len <= 0.5
  CONDITION: controls <= 5.5
  # distilled from Brill /bid

RULE BD_False_P853:
  CALL: 6C
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call != 'PASS'
  CONDITION: last_bid_level > 2.5
  CONDITION: last_bid_level > 3.5
  CONDITION: partner_last_call == '4NT'
  CONDITION: keycard_count_agreed > 1.5
  CONDITION: keycard_count_agreed <= 2.5
  CONDITION: our_fit_shown <= 0.5
  CONDITION: shortest_suit_len <= 0.5
  CONDITION: controls > 5.5
  # distilled from Brill /bid

RULE BD_False_P854:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call != 'PASS'
  CONDITION: last_bid_level > 2.5
  CONDITION: last_bid_level > 3.5
  CONDITION: partner_last_call == '4NT'
  CONDITION: keycard_count_agreed > 1.5
  CONDITION: keycard_count_agreed <= 2.5
  CONDITION: our_fit_shown <= 0.5
  CONDITION: shortest_suit_len > 0.5
  CONDITION: partner_first_call == '2C'
  # distilled from Brill /bid

RULE BD_False_P855:
  CALL: 5C
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call != 'PASS'
  CONDITION: last_bid_level > 2.5
  CONDITION: last_bid_level > 3.5
  CONDITION: partner_last_call == '4NT'
  CONDITION: keycard_count_agreed > 1.5
  CONDITION: keycard_count_agreed <= 2.5
  CONDITION: our_fit_shown <= 0.5
  CONDITION: shortest_suit_len > 0.5
  CONDITION: partner_first_call != '2C'
  # distilled from Brill /bid

RULE BD_False_P856:
  CALL: 5NT
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call != 'PASS'
  CONDITION: last_bid_level > 2.5
  CONDITION: last_bid_level > 3.5
  CONDITION: partner_last_call == '4NT'
  CONDITION: keycard_count_agreed > 1.5
  CONDITION: keycard_count_agreed <= 2.5
  CONDITION: our_fit_shown > 0.5
  CONDITION: has_trump_queen <= 0.5
  CONDITION: shortest_suit_len <= 0.5
  # distilled from Brill /bid

RULE BD_False_P857:
  CALL: 5H
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call != 'PASS'
  CONDITION: last_bid_level > 2.5
  CONDITION: last_bid_level > 3.5
  CONDITION: partner_last_call == '4NT'
  CONDITION: keycard_count_agreed > 1.5
  CONDITION: keycard_count_agreed <= 2.5
  CONDITION: our_fit_shown > 0.5
  CONDITION: has_trump_queen <= 0.5
  CONDITION: shortest_suit_len > 0.5
  # distilled from Brill /bid

RULE BD_False_P858:
  CALL: 5S
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call != 'PASS'
  CONDITION: last_bid_level > 2.5
  CONDITION: last_bid_level > 3.5
  CONDITION: partner_last_call == '4NT'
  CONDITION: keycard_count_agreed > 1.5
  CONDITION: keycard_count_agreed <= 2.5
  CONDITION: our_fit_shown > 0.5
  CONDITION: has_trump_queen > 0.5
  CONDITION: club_len <= 5.5
  # distilled from Brill /bid

RULE BD_False_P859:
  CALL: 5NT
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call != 'PASS'
  CONDITION: last_bid_level > 2.5
  CONDITION: last_bid_level > 3.5
  CONDITION: partner_last_call == '4NT'
  CONDITION: keycard_count_agreed > 1.5
  CONDITION: keycard_count_agreed <= 2.5
  CONDITION: our_fit_shown > 0.5
  CONDITION: has_trump_queen > 0.5
  CONDITION: club_len > 5.5
  # distilled from Brill /bid

RULE BD_False_P860:
  CALL: 5D
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call != 'PASS'
  CONDITION: last_bid_level > 2.5
  CONDITION: last_bid_level > 3.5
  CONDITION: partner_last_call == '4NT'
  CONDITION: keycard_count_agreed > 1.5
  CONDITION: keycard_count_agreed > 2.5
  CONDITION: controls <= 7.5
  CONDITION: shortest_suit_len <= 0.5
  CONDITION: club_hcp <= 5.5
  # distilled from Brill /bid

RULE BD_False_P861:
  CALL: 6D
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call != 'PASS'
  CONDITION: last_bid_level > 2.5
  CONDITION: last_bid_level > 3.5
  CONDITION: partner_last_call == '4NT'
  CONDITION: keycard_count_agreed > 1.5
  CONDITION: keycard_count_agreed > 2.5
  CONDITION: controls <= 7.5
  CONDITION: shortest_suit_len <= 0.5
  CONDITION: club_hcp > 5.5
  # distilled from Brill /bid

RULE BD_False_P862:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call != 'PASS'
  CONDITION: last_bid_level > 2.5
  CONDITION: last_bid_level > 3.5
  CONDITION: partner_last_call == '4NT'
  CONDITION: keycard_count_agreed > 1.5
  CONDITION: keycard_count_agreed > 2.5
  CONDITION: controls <= 7.5
  CONDITION: shortest_suit_len > 0.5
  CONDITION: my_last_call == '2NT'
  # distilled from Brill /bid

RULE BD_False_P863:
  CALL: 5C
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call != 'PASS'
  CONDITION: last_bid_level > 2.5
  CONDITION: last_bid_level > 3.5
  CONDITION: partner_last_call == '4NT'
  CONDITION: keycard_count_agreed > 1.5
  CONDITION: keycard_count_agreed > 2.5
  CONDITION: controls <= 7.5
  CONDITION: shortest_suit_len > 0.5
  CONDITION: my_last_call != '2NT'
  # distilled from Brill /bid

RULE BD_False_P864:
  CALL: 5D
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call != 'PASS'
  CONDITION: last_bid_level > 2.5
  CONDITION: last_bid_level > 3.5
  CONDITION: partner_last_call == '4NT'
  CONDITION: keycard_count_agreed > 1.5
  CONDITION: keycard_count_agreed > 2.5
  CONDITION: controls > 7.5
  CONDITION: c_has_king <= 0.5
  CONDITION: major_hcp <= 10.5
  # distilled from Brill /bid

RULE BD_False_P865:
  CALL: 5D
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call != 'PASS'
  CONDITION: last_bid_level > 2.5
  CONDITION: last_bid_level > 3.5
  CONDITION: partner_last_call == '4NT'
  CONDITION: keycard_count_agreed > 1.5
  CONDITION: keycard_count_agreed > 2.5
  CONDITION: controls > 7.5
  CONDITION: c_has_king <= 0.5
  CONDITION: major_hcp > 10.5
  # distilled from Brill /bid

RULE BD_False_P866:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call != 'PASS'
  CONDITION: last_bid_level > 2.5
  CONDITION: last_bid_level > 3.5
  CONDITION: partner_last_call == '4NT'
  CONDITION: keycard_count_agreed > 1.5
  CONDITION: keycard_count_agreed > 2.5
  CONDITION: controls > 7.5
  CONDITION: c_has_king > 0.5
  CONDITION: heart_len <= 2.5
  # distilled from Brill /bid

RULE BD_False_P867:
  CALL: 5C
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call != 'PASS'
  CONDITION: last_bid_level > 2.5
  CONDITION: last_bid_level > 3.5
  CONDITION: partner_last_call == '4NT'
  CONDITION: keycard_count_agreed > 1.5
  CONDITION: keycard_count_agreed > 2.5
  CONDITION: controls > 7.5
  CONDITION: c_has_king > 0.5
  CONDITION: heart_len > 2.5
  # distilled from Brill /bid

RULE BD_False_P868:
  CALL: 4H
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call != 'PASS'
  CONDITION: last_bid_level > 2.5
  CONDITION: last_bid_level > 3.5
  CONDITION: partner_last_call != '4NT'
  CONDITION: last_bid_level <= 4.5
  CONDITION: last_bid_strain == 'D'
  CONDITION: my_first_call == '1NT'
  CONDITION: competition_level <= 4.5
  # distilled from Brill /bid

RULE BD_False_P869:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call != 'PASS'
  CONDITION: last_bid_level > 2.5
  CONDITION: last_bid_level > 3.5
  CONDITION: partner_last_call != '4NT'
  CONDITION: last_bid_level <= 4.5
  CONDITION: last_bid_strain == 'D'
  CONDITION: my_first_call == '1NT'
  CONDITION: competition_level > 4.5
  # distilled from Brill /bid

RULE BD_False_P870:
  CALL: 4S
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call != 'PASS'
  CONDITION: last_bid_level > 2.5
  CONDITION: last_bid_level > 3.5
  CONDITION: partner_last_call != '4NT'
  CONDITION: last_bid_level <= 4.5
  CONDITION: last_bid_strain == 'D'
  CONDITION: my_first_call != '1NT'
  CONDITION: opponents_bid <= 0.5
  CONDITION: my_last_call == '1S'
  # distilled from Brill /bid

RULE BD_False_P871:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call != 'PASS'
  CONDITION: last_bid_level > 2.5
  CONDITION: last_bid_level > 3.5
  CONDITION: partner_last_call != '4NT'
  CONDITION: last_bid_level <= 4.5
  CONDITION: last_bid_strain == 'D'
  CONDITION: my_first_call != '1NT'
  CONDITION: opponents_bid <= 0.5
  CONDITION: my_last_call != '1S'
  # distilled from Brill /bid

RULE BD_False_P872:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call != 'PASS'
  CONDITION: last_bid_level > 2.5
  CONDITION: last_bid_level > 3.5
  CONDITION: partner_last_call != '4NT'
  CONDITION: last_bid_level <= 4.5
  CONDITION: last_bid_strain == 'D'
  CONDITION: my_first_call != '1NT'
  CONDITION: opponents_bid > 0.5
  CONDITION: partner_last_call == '4D'
  # distilled from Brill /bid

RULE BD_False_P873:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call != 'PASS'
  CONDITION: last_bid_level > 2.5
  CONDITION: last_bid_level > 3.5
  CONDITION: partner_last_call != '4NT'
  CONDITION: last_bid_level <= 4.5
  CONDITION: last_bid_strain == 'D'
  CONDITION: my_first_call != '1NT'
  CONDITION: opponents_bid > 0.5
  CONDITION: partner_last_call != '4D'
  # distilled from Brill /bid

RULE BD_False_P874:
  CALL: 4S
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call != 'PASS'
  CONDITION: last_bid_level > 2.5
  CONDITION: last_bid_level > 3.5
  CONDITION: partner_last_call != '4NT'
  CONDITION: last_bid_level <= 4.5
  CONDITION: last_bid_strain != 'D'
  CONDITION: last_bid_strain == 'C'
  CONDITION: opponents_bid <= 0.5
  CONDITION: my_last_call == '1S'
  # distilled from Brill /bid

RULE BD_False_P875:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call != 'PASS'
  CONDITION: last_bid_level > 2.5
  CONDITION: last_bid_level > 3.5
  CONDITION: partner_last_call != '4NT'
  CONDITION: last_bid_level <= 4.5
  CONDITION: last_bid_strain != 'D'
  CONDITION: last_bid_strain == 'C'
  CONDITION: opponents_bid <= 0.5
  CONDITION: my_last_call != '1S'
  # distilled from Brill /bid

RULE BD_False_P876:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call != 'PASS'
  CONDITION: last_bid_level > 2.5
  CONDITION: last_bid_level > 3.5
  CONDITION: partner_last_call != '4NT'
  CONDITION: last_bid_level <= 4.5
  CONDITION: last_bid_strain != 'D'
  CONDITION: last_bid_strain == 'C'
  CONDITION: opponents_bid > 0.5
  CONDITION: partner_last_call == '4C'
  # distilled from Brill /bid

RULE BD_False_P877:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call != 'PASS'
  CONDITION: last_bid_level > 2.5
  CONDITION: last_bid_level > 3.5
  CONDITION: partner_last_call != '4NT'
  CONDITION: last_bid_level <= 4.5
  CONDITION: last_bid_strain != 'D'
  CONDITION: last_bid_strain == 'C'
  CONDITION: opponents_bid > 0.5
  CONDITION: partner_last_call != '4C'
  # distilled from Brill /bid

RULE BD_False_P878:
  CALL: 4S
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call != 'PASS'
  CONDITION: last_bid_level > 2.5
  CONDITION: last_bid_level > 3.5
  CONDITION: partner_last_call != '4NT'
  CONDITION: last_bid_level <= 4.5
  CONDITION: last_bid_strain != 'D'
  CONDITION: last_bid_strain != 'C'
  CONDITION: my_side_bid_count <= 2.5
  CONDITION: my_first_call == '1NT'
  # distilled from Brill /bid

RULE BD_False_P879:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call != 'PASS'
  CONDITION: last_bid_level > 2.5
  CONDITION: last_bid_level > 3.5
  CONDITION: partner_last_call != '4NT'
  CONDITION: last_bid_level <= 4.5
  CONDITION: last_bid_strain != 'D'
  CONDITION: last_bid_strain != 'C'
  CONDITION: my_side_bid_count <= 2.5
  CONDITION: my_first_call != '1NT'
  # distilled from Brill /bid

RULE BD_False_P880:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call != 'PASS'
  CONDITION: last_bid_level > 2.5
  CONDITION: last_bid_level > 3.5
  CONDITION: partner_last_call != '4NT'
  CONDITION: last_bid_level <= 4.5
  CONDITION: last_bid_strain != 'D'
  CONDITION: last_bid_strain != 'C'
  CONDITION: my_side_bid_count > 2.5
  CONDITION: losing_trick_count <= 5.5
  # distilled from Brill /bid

RULE BD_False_P881:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call != 'PASS'
  CONDITION: last_bid_level > 2.5
  CONDITION: last_bid_level > 3.5
  CONDITION: partner_last_call != '4NT'
  CONDITION: last_bid_level <= 4.5
  CONDITION: last_bid_strain != 'D'
  CONDITION: last_bid_strain != 'C'
  CONDITION: my_side_bid_count > 2.5
  CONDITION: losing_trick_count > 5.5
  # distilled from Brill /bid

RULE BD_False_P882:
  CALL: 5D
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call != 'PASS'
  CONDITION: last_bid_level > 2.5
  CONDITION: last_bid_level > 3.5
  CONDITION: partner_last_call != '4NT'
  CONDITION: last_bid_level > 4.5
  CONDITION: my_last_call == '4NT'
  CONDITION: last_bid_level <= 5.5
  CONDITION: last_bid_strain == 'C'
  CONDITION: heart_len <= 4.5
  # distilled from Brill /bid

RULE BD_False_P883:
  CALL: 5D
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call != 'PASS'
  CONDITION: last_bid_level > 2.5
  CONDITION: last_bid_level > 3.5
  CONDITION: partner_last_call != '4NT'
  CONDITION: last_bid_level > 4.5
  CONDITION: my_last_call == '4NT'
  CONDITION: last_bid_level <= 5.5
  CONDITION: last_bid_strain == 'C'
  CONDITION: heart_len > 4.5
  # distilled from Brill /bid

RULE BD_False_P884:
  CALL: 5H
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call != 'PASS'
  CONDITION: last_bid_level > 2.5
  CONDITION: last_bid_level > 3.5
  CONDITION: partner_last_call != '4NT'
  CONDITION: last_bid_level > 4.5
  CONDITION: my_last_call == '4NT'
  CONDITION: last_bid_level <= 5.5
  CONDITION: last_bid_strain != 'C'
  CONDITION: last_bid_strain == 'D'
  # distilled from Brill /bid

RULE BD_False_P885:
  CALL: 6S
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call != 'PASS'
  CONDITION: last_bid_level > 2.5
  CONDITION: last_bid_level > 3.5
  CONDITION: partner_last_call != '4NT'
  CONDITION: last_bid_level > 4.5
  CONDITION: my_last_call == '4NT'
  CONDITION: last_bid_level <= 5.5
  CONDITION: last_bid_strain != 'C'
  CONDITION: last_bid_strain != 'D'
  # distilled from Brill /bid

RULE BD_False_P886:
  CALL: 6NT
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call != 'PASS'
  CONDITION: last_bid_level > 2.5
  CONDITION: last_bid_level > 3.5
  CONDITION: partner_last_call != '4NT'
  CONDITION: last_bid_level > 4.5
  CONDITION: my_last_call == '4NT'
  CONDITION: last_bid_level > 5.5
  CONDITION: shortest_suit_len <= 1.5
  CONDITION: support_in_partner_suit <= 2.5
  # distilled from Brill /bid

RULE BD_False_P887:
  CALL: 6S
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call != 'PASS'
  CONDITION: last_bid_level > 2.5
  CONDITION: last_bid_level > 3.5
  CONDITION: partner_last_call != '4NT'
  CONDITION: last_bid_level > 4.5
  CONDITION: my_last_call == '4NT'
  CONDITION: last_bid_level > 5.5
  CONDITION: shortest_suit_len <= 1.5
  CONDITION: support_in_partner_suit > 2.5
  # distilled from Brill /bid

RULE BD_False_P888:
  CALL: 6D
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call != 'PASS'
  CONDITION: last_bid_level > 2.5
  CONDITION: last_bid_level > 3.5
  CONDITION: partner_last_call != '4NT'
  CONDITION: last_bid_level > 4.5
  CONDITION: my_last_call == '4NT'
  CONDITION: last_bid_level > 5.5
  CONDITION: shortest_suit_len > 1.5
  CONDITION: opening_bid == '1H'
  # distilled from Brill /bid

RULE BD_False_P889:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call != 'PASS'
  CONDITION: last_bid_level > 2.5
  CONDITION: last_bid_level > 3.5
  CONDITION: partner_last_call != '4NT'
  CONDITION: last_bid_level > 4.5
  CONDITION: my_last_call == '4NT'
  CONDITION: last_bid_level > 5.5
  CONDITION: shortest_suit_len > 1.5
  CONDITION: opening_bid != '1H'
  # distilled from Brill /bid

RULE BD_False_P890:
  CALL: 6NT
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call != 'PASS'
  CONDITION: last_bid_level > 2.5
  CONDITION: last_bid_level > 3.5
  CONDITION: partner_last_call != '4NT'
  CONDITION: last_bid_level > 4.5
  CONDITION: my_last_call != '4NT'
  CONDITION: partner_last_call == '5NT'
  CONDITION: my_last_call == '2NT'
  CONDITION: jack_count <= 1.5
  # distilled from Brill /bid

RULE BD_False_P891:
  CALL: 7NT
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call != 'PASS'
  CONDITION: last_bid_level > 2.5
  CONDITION: last_bid_level > 3.5
  CONDITION: partner_last_call != '4NT'
  CONDITION: last_bid_level > 4.5
  CONDITION: my_last_call != '4NT'
  CONDITION: partner_last_call == '5NT'
  CONDITION: my_last_call == '2NT'
  CONDITION: jack_count > 1.5
  # distilled from Brill /bid

RULE BD_False_P892:
  CALL: 6C
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call != 'PASS'
  CONDITION: last_bid_level > 2.5
  CONDITION: last_bid_level > 3.5
  CONDITION: partner_last_call != '4NT'
  CONDITION: last_bid_level > 4.5
  CONDITION: my_last_call != '4NT'
  CONDITION: partner_last_call == '5NT'
  CONDITION: my_last_call != '2NT'
  CONDITION: king_count <= 1.5
  # distilled from Brill /bid

RULE BD_False_P893:
  CALL: 7S
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call != 'PASS'
  CONDITION: last_bid_level > 2.5
  CONDITION: last_bid_level > 3.5
  CONDITION: partner_last_call != '4NT'
  CONDITION: last_bid_level > 4.5
  CONDITION: my_last_call != '4NT'
  CONDITION: partner_last_call == '5NT'
  CONDITION: my_last_call != '2NT'
  CONDITION: king_count > 1.5
  # distilled from Brill /bid

RULE BD_False_P894:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call != 'PASS'
  CONDITION: last_bid_level > 2.5
  CONDITION: last_bid_level > 3.5
  CONDITION: partner_last_call != '4NT'
  CONDITION: last_bid_level > 4.5
  CONDITION: my_last_call != '4NT'
  CONDITION: partner_last_call != '5NT'
  CONDITION: my_side_bid_count <= 4.5
  CONDITION: passes_since_last_bid <= 0.5
  # distilled from Brill /bid

RULE BD_False_P895:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call != 'PASS'
  CONDITION: last_bid_level > 2.5
  CONDITION: last_bid_level > 3.5
  CONDITION: partner_last_call != '4NT'
  CONDITION: last_bid_level > 4.5
  CONDITION: my_last_call != '4NT'
  CONDITION: partner_last_call != '5NT'
  CONDITION: my_side_bid_count <= 4.5
  CONDITION: passes_since_last_bid > 0.5
  # distilled from Brill /bid

RULE BD_False_P896:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call != 'PASS'
  CONDITION: last_bid_level > 2.5
  CONDITION: last_bid_level > 3.5
  CONDITION: partner_last_call != '4NT'
  CONDITION: last_bid_level > 4.5
  CONDITION: my_last_call != '4NT'
  CONDITION: partner_last_call != '5NT'
  CONDITION: my_side_bid_count > 4.5
  CONDITION: last_bid_level <= 5.5
  # distilled from Brill /bid

RULE BD_False_P897:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == False
  CONDITION: last_bid_level > 1.5
  CONDITION: partner_last_call != 'PASS'
  CONDITION: last_bid_level > 2.5
  CONDITION: last_bid_level > 3.5
  CONDITION: partner_last_call != '4NT'
  CONDITION: last_bid_level > 4.5
  CONDITION: my_last_call != '4NT'
  CONDITION: partner_last_call != '5NT'
  CONDITION: my_side_bid_count > 4.5
  CONDITION: last_bid_level > 5.5
  # distilled from Brill /bid

RULE BD_True_P0:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == True
  CONDITION: hcp <= 11.5
  CONDITION: longest_suit_len <= 5.5
  CONDITION: controls <= 4.5
  CONDITION: rule20_total <= 20.5
  CONDITION: rule20_total <= 19.5
  CONDITION: auction_len <= 2.5
  # distilled from Brill /bid

RULE BD_True_P1:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == True
  CONDITION: hcp <= 11.5
  CONDITION: longest_suit_len <= 5.5
  CONDITION: controls <= 4.5
  CONDITION: rule20_total <= 20.5
  CONDITION: rule20_total <= 19.5
  CONDITION: auction_len > 2.5
  CONDITION: spade_len <= 4.5
  # distilled from Brill /bid

RULE BD_True_P2:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == True
  CONDITION: hcp <= 11.5
  CONDITION: longest_suit_len <= 5.5
  CONDITION: controls <= 4.5
  CONDITION: rule20_total <= 20.5
  CONDITION: rule20_total <= 19.5
  CONDITION: auction_len > 2.5
  CONDITION: spade_len > 4.5
  CONDITION: hcp <= 9.5
  # distilled from Brill /bid

RULE BD_True_P3:
  CALL: 1S
  PRIORITY: 10
  CONDITION: is_opening == True
  CONDITION: hcp <= 11.5
  CONDITION: longest_suit_len <= 5.5
  CONDITION: controls <= 4.5
  CONDITION: rule20_total <= 20.5
  CONDITION: rule20_total <= 19.5
  CONDITION: auction_len > 2.5
  CONDITION: spade_len > 4.5
  CONDITION: hcp > 9.5
  # distilled from Brill /bid

RULE BD_True_P4:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == True
  CONDITION: hcp <= 11.5
  CONDITION: longest_suit_len <= 5.5
  CONDITION: controls <= 4.5
  CONDITION: rule20_total <= 20.5
  CONDITION: rule20_total > 19.5
  CONDITION: spade_len <= 4.5
  CONDITION: spade_len <= 3.5
  # distilled from Brill /bid

RULE BD_True_P5:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == True
  CONDITION: hcp <= 11.5
  CONDITION: longest_suit_len <= 5.5
  CONDITION: controls <= 4.5
  CONDITION: rule20_total <= 20.5
  CONDITION: rule20_total > 19.5
  CONDITION: spade_len <= 4.5
  CONDITION: spade_len > 3.5
  CONDITION: heart_len <= 4.5
  # distilled from Brill /bid

RULE BD_True_P6:
  CALL: 1H
  PRIORITY: 10
  CONDITION: is_opening == True
  CONDITION: hcp <= 11.5
  CONDITION: longest_suit_len <= 5.5
  CONDITION: controls <= 4.5
  CONDITION: rule20_total <= 20.5
  CONDITION: rule20_total > 19.5
  CONDITION: spade_len <= 4.5
  CONDITION: spade_len > 3.5
  CONDITION: heart_len > 4.5
  CONDITION: is_vulnerable <= 0.5
  # distilled from Brill /bid

RULE BD_True_P7:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == True
  CONDITION: hcp <= 11.5
  CONDITION: longest_suit_len <= 5.5
  CONDITION: controls <= 4.5
  CONDITION: rule20_total <= 20.5
  CONDITION: rule20_total > 19.5
  CONDITION: spade_len <= 4.5
  CONDITION: spade_len > 3.5
  CONDITION: heart_len > 4.5
  CONDITION: is_vulnerable > 0.5
  # distilled from Brill /bid

RULE BD_True_P8:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == True
  CONDITION: hcp <= 11.5
  CONDITION: longest_suit_len <= 5.5
  CONDITION: controls <= 4.5
  CONDITION: rule20_total <= 20.5
  CONDITION: rule20_total > 19.5
  CONDITION: spade_len > 4.5
  CONDITION: heart_len <= 3.5
  CONDITION: auction_len <= 2.5
  # distilled from Brill /bid

RULE BD_True_P9:
  CALL: 1S
  PRIORITY: 10
  CONDITION: is_opening == True
  CONDITION: hcp <= 11.5
  CONDITION: longest_suit_len <= 5.5
  CONDITION: controls <= 4.5
  CONDITION: rule20_total <= 20.5
  CONDITION: rule20_total > 19.5
  CONDITION: spade_len > 4.5
  CONDITION: heart_len <= 3.5
  CONDITION: auction_len > 2.5
  # distilled from Brill /bid

RULE BD_True_P10:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == True
  CONDITION: hcp <= 11.5
  CONDITION: longest_suit_len <= 5.5
  CONDITION: controls <= 4.5
  CONDITION: rule20_total <= 20.5
  CONDITION: rule20_total > 19.5
  CONDITION: spade_len > 4.5
  CONDITION: heart_len > 3.5
  CONDITION: is_vulnerable <= 0.5
  CONDITION: hcp <= 10.5
  # distilled from Brill /bid

RULE BD_True_P11:
  CALL: 1S
  PRIORITY: 10
  CONDITION: is_opening == True
  CONDITION: hcp <= 11.5
  CONDITION: longest_suit_len <= 5.5
  CONDITION: controls <= 4.5
  CONDITION: rule20_total <= 20.5
  CONDITION: rule20_total > 19.5
  CONDITION: spade_len > 4.5
  CONDITION: heart_len > 3.5
  CONDITION: is_vulnerable <= 0.5
  CONDITION: hcp > 10.5
  # distilled from Brill /bid

RULE BD_True_P12:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == True
  CONDITION: hcp <= 11.5
  CONDITION: longest_suit_len <= 5.5
  CONDITION: controls <= 4.5
  CONDITION: rule20_total <= 20.5
  CONDITION: rule20_total > 19.5
  CONDITION: spade_len > 4.5
  CONDITION: heart_len > 3.5
  CONDITION: is_vulnerable > 0.5
  CONDITION: auction_len <= 2.5
  # distilled from Brill /bid

RULE BD_True_P13:
  CALL: 1S
  PRIORITY: 10
  CONDITION: is_opening == True
  CONDITION: hcp <= 11.5
  CONDITION: longest_suit_len <= 5.5
  CONDITION: controls <= 4.5
  CONDITION: rule20_total <= 20.5
  CONDITION: rule20_total > 19.5
  CONDITION: spade_len > 4.5
  CONDITION: heart_len > 3.5
  CONDITION: is_vulnerable > 0.5
  CONDITION: auction_len > 2.5
  # distilled from Brill /bid

RULE BD_True_P14:
  CALL: 1D
  PRIORITY: 10
  CONDITION: is_opening == True
  CONDITION: hcp <= 11.5
  CONDITION: longest_suit_len <= 5.5
  CONDITION: controls <= 4.5
  CONDITION: rule20_total > 20.5
  CONDITION: spade_len <= 4.0
  CONDITION: heart_len <= 4.0
  # distilled from Brill /bid

RULE BD_True_P15:
  CALL: 1H
  PRIORITY: 10
  CONDITION: is_opening == True
  CONDITION: hcp <= 11.5
  CONDITION: longest_suit_len <= 5.5
  CONDITION: controls <= 4.5
  CONDITION: rule20_total > 20.5
  CONDITION: spade_len <= 4.0
  CONDITION: heart_len > 4.0
  # distilled from Brill /bid

RULE BD_True_P16:
  CALL: 1S
  PRIORITY: 10
  CONDITION: is_opening == True
  CONDITION: hcp <= 11.5
  CONDITION: longest_suit_len <= 5.5
  CONDITION: controls <= 4.5
  CONDITION: rule20_total > 20.5
  CONDITION: spade_len > 4.0
  # distilled from Brill /bid

RULE BD_True_P17:
  CALL: 1D
  PRIORITY: 10
  CONDITION: is_opening == True
  CONDITION: hcp <= 11.5
  CONDITION: longest_suit_len <= 5.5
  CONDITION: controls > 4.5
  CONDITION: d_is_longest <= 0.5
  CONDITION: spade_len <= 4.5
  CONDITION: heart_len <= 4.5
  CONDITION: club_len <= 2.5
  CONDITION: d_has_king <= 0.5
  # distilled from Brill /bid

RULE BD_True_P18:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == True
  CONDITION: hcp <= 11.5
  CONDITION: longest_suit_len <= 5.5
  CONDITION: controls > 4.5
  CONDITION: d_is_longest <= 0.5
  CONDITION: spade_len <= 4.5
  CONDITION: heart_len <= 4.5
  CONDITION: club_len <= 2.5
  CONDITION: d_has_king > 0.5
  # distilled from Brill /bid

RULE BD_True_P19:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == True
  CONDITION: hcp <= 11.5
  CONDITION: longest_suit_len <= 5.5
  CONDITION: controls > 4.5
  CONDITION: d_is_longest <= 0.5
  CONDITION: spade_len <= 4.5
  CONDITION: heart_len <= 4.5
  CONDITION: club_len > 2.5
  CONDITION: heart_len <= 0.5
  # distilled from Brill /bid

RULE BD_True_P20:
  CALL: 1C
  PRIORITY: 10
  CONDITION: is_opening == True
  CONDITION: hcp <= 11.5
  CONDITION: longest_suit_len <= 5.5
  CONDITION: controls > 4.5
  CONDITION: d_is_longest <= 0.5
  CONDITION: spade_len <= 4.5
  CONDITION: heart_len <= 4.5
  CONDITION: club_len > 2.5
  CONDITION: heart_len > 0.5
  CONDITION: h_has_ten <= 0.5
  CONDITION: is_favorable_vuln <= 0.5
  # distilled from Brill /bid

RULE BD_True_P21:
  CALL: 1C
  PRIORITY: 10
  CONDITION: is_opening == True
  CONDITION: hcp <= 11.5
  CONDITION: longest_suit_len <= 5.5
  CONDITION: controls > 4.5
  CONDITION: d_is_longest <= 0.5
  CONDITION: spade_len <= 4.5
  CONDITION: heart_len <= 4.5
  CONDITION: club_len > 2.5
  CONDITION: heart_len > 0.5
  CONDITION: h_has_ten <= 0.5
  CONDITION: is_favorable_vuln > 0.5
  # distilled from Brill /bid

RULE BD_True_P22:
  CALL: 1C
  PRIORITY: 10
  CONDITION: is_opening == True
  CONDITION: hcp <= 11.5
  CONDITION: longest_suit_len <= 5.5
  CONDITION: controls > 4.5
  CONDITION: d_is_longest <= 0.5
  CONDITION: spade_len <= 4.5
  CONDITION: heart_len <= 4.5
  CONDITION: club_len > 2.5
  CONDITION: heart_len > 0.5
  CONDITION: h_has_ten > 0.5
  CONDITION: heart_len <= 3.5
  # distilled from Brill /bid

RULE BD_True_P23:
  CALL: 1C
  PRIORITY: 10
  CONDITION: is_opening == True
  CONDITION: hcp <= 11.5
  CONDITION: longest_suit_len <= 5.5
  CONDITION: controls > 4.5
  CONDITION: d_is_longest <= 0.5
  CONDITION: spade_len <= 4.5
  CONDITION: heart_len <= 4.5
  CONDITION: club_len > 2.5
  CONDITION: heart_len > 0.5
  CONDITION: h_has_ten > 0.5
  CONDITION: heart_len > 3.5
  # distilled from Brill /bid

RULE BD_True_P24:
  CALL: 1H
  PRIORITY: 10
  CONDITION: is_opening == True
  CONDITION: hcp <= 11.5
  CONDITION: longest_suit_len <= 5.5
  CONDITION: controls > 4.5
  CONDITION: d_is_longest <= 0.5
  CONDITION: spade_len <= 4.5
  CONDITION: heart_len > 4.5
  CONDITION: h_has_king <= 0.5
  # distilled from Brill /bid

RULE BD_True_P25:
  CALL: 1H
  PRIORITY: 10
  CONDITION: is_opening == True
  CONDITION: hcp <= 11.5
  CONDITION: longest_suit_len <= 5.5
  CONDITION: controls > 4.5
  CONDITION: d_is_longest <= 0.5
  CONDITION: spade_len <= 4.5
  CONDITION: heart_len > 4.5
  CONDITION: h_has_king > 0.5
  CONDITION: total_points <= 12.5
  CONDITION: major_hcp <= 9.0
  CONDITION: major_hcp <= 5.0
  # distilled from Brill /bid

RULE BD_True_P26:
  CALL: 1H
  PRIORITY: 10
  CONDITION: is_opening == True
  CONDITION: hcp <= 11.5
  CONDITION: longest_suit_len <= 5.5
  CONDITION: controls > 4.5
  CONDITION: d_is_longest <= 0.5
  CONDITION: spade_len <= 4.5
  CONDITION: heart_len > 4.5
  CONDITION: h_has_king > 0.5
  CONDITION: total_points <= 12.5
  CONDITION: major_hcp <= 9.0
  CONDITION: major_hcp > 5.0
  # distilled from Brill /bid

RULE BD_True_P27:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == True
  CONDITION: hcp <= 11.5
  CONDITION: longest_suit_len <= 5.5
  CONDITION: controls > 4.5
  CONDITION: d_is_longest <= 0.5
  CONDITION: spade_len <= 4.5
  CONDITION: heart_len > 4.5
  CONDITION: h_has_king > 0.5
  CONDITION: total_points <= 12.5
  CONDITION: major_hcp > 9.0
  # distilled from Brill /bid

RULE BD_True_P28:
  CALL: 1H
  PRIORITY: 10
  CONDITION: is_opening == True
  CONDITION: hcp <= 11.5
  CONDITION: longest_suit_len <= 5.5
  CONDITION: controls > 4.5
  CONDITION: d_is_longest <= 0.5
  CONDITION: spade_len <= 4.5
  CONDITION: heart_len > 4.5
  CONDITION: h_has_king > 0.5
  CONDITION: total_points > 12.5
  # distilled from Brill /bid

RULE BD_True_P29:
  CALL: 1S
  PRIORITY: 10
  CONDITION: is_opening == True
  CONDITION: hcp <= 11.5
  CONDITION: longest_suit_len <= 5.5
  CONDITION: controls > 4.5
  CONDITION: d_is_longest <= 0.5
  CONDITION: spade_len > 4.5
  CONDITION: s_has_ten <= 0.5
  CONDITION: major_hcp <= 5.5
  # distilled from Brill /bid

RULE BD_True_P30:
  CALL: 1S
  PRIORITY: 10
  CONDITION: is_opening == True
  CONDITION: hcp <= 11.5
  CONDITION: longest_suit_len <= 5.5
  CONDITION: controls > 4.5
  CONDITION: d_is_longest <= 0.5
  CONDITION: spade_len > 4.5
  CONDITION: s_has_ten <= 0.5
  CONDITION: major_hcp > 5.5
  CONDITION: club_len <= 2.5
  # distilled from Brill /bid

RULE BD_True_P31:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == True
  CONDITION: hcp <= 11.5
  CONDITION: longest_suit_len <= 5.5
  CONDITION: controls > 4.5
  CONDITION: d_is_longest <= 0.5
  CONDITION: spade_len > 4.5
  CONDITION: s_has_ten <= 0.5
  CONDITION: major_hcp > 5.5
  CONDITION: club_len > 2.5
  CONDITION: h_has_ten <= 0.5
  CONDITION: total_points <= 11.5
  # distilled from Brill /bid

RULE BD_True_P32:
  CALL: 1S
  PRIORITY: 10
  CONDITION: is_opening == True
  CONDITION: hcp <= 11.5
  CONDITION: longest_suit_len <= 5.5
  CONDITION: controls > 4.5
  CONDITION: d_is_longest <= 0.5
  CONDITION: spade_len > 4.5
  CONDITION: s_has_ten <= 0.5
  CONDITION: major_hcp > 5.5
  CONDITION: club_len > 2.5
  CONDITION: h_has_ten <= 0.5
  CONDITION: total_points > 11.5
  # distilled from Brill /bid

RULE BD_True_P33:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == True
  CONDITION: hcp <= 11.5
  CONDITION: longest_suit_len <= 5.5
  CONDITION: controls > 4.5
  CONDITION: d_is_longest <= 0.5
  CONDITION: spade_len > 4.5
  CONDITION: s_has_ten <= 0.5
  CONDITION: major_hcp > 5.5
  CONDITION: club_len > 2.5
  CONDITION: h_has_ten > 0.5
  # distilled from Brill /bid

RULE BD_True_P34:
  CALL: 1S
  PRIORITY: 10
  CONDITION: is_opening == True
  CONDITION: hcp <= 11.5
  CONDITION: longest_suit_len <= 5.5
  CONDITION: controls > 4.5
  CONDITION: d_is_longest <= 0.5
  CONDITION: spade_len > 4.5
  CONDITION: s_has_ten > 0.5
  # distilled from Brill /bid

RULE BD_True_P35:
  CALL: 1D
  PRIORITY: 10
  CONDITION: is_opening == True
  CONDITION: hcp <= 11.5
  CONDITION: longest_suit_len <= 5.5
  CONDITION: controls > 4.5
  CONDITION: d_is_longest > 0.5
  CONDITION: heart_len <= 4.5
  CONDITION: spade_len <= 4.5
  CONDITION: is_vulnerable <= 0.5
  # distilled from Brill /bid

RULE BD_True_P36:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == True
  CONDITION: hcp <= 11.5
  CONDITION: longest_suit_len <= 5.5
  CONDITION: controls > 4.5
  CONDITION: d_is_longest > 0.5
  CONDITION: heart_len <= 4.5
  CONDITION: spade_len <= 4.5
  CONDITION: is_vulnerable > 0.5
  CONDITION: s_has_ten <= 0.5
  CONDITION: club_hcp <= 1.5
  CONDITION: spade_len <= 1.5
  # distilled from Brill /bid

RULE BD_True_P37:
  CALL: 1D
  PRIORITY: 10
  CONDITION: is_opening == True
  CONDITION: hcp <= 11.5
  CONDITION: longest_suit_len <= 5.5
  CONDITION: controls > 4.5
  CONDITION: d_is_longest > 0.5
  CONDITION: heart_len <= 4.5
  CONDITION: spade_len <= 4.5
  CONDITION: is_vulnerable > 0.5
  CONDITION: s_has_ten <= 0.5
  CONDITION: club_hcp <= 1.5
  CONDITION: spade_len > 1.5
  # distilled from Brill /bid

RULE BD_True_P38:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == True
  CONDITION: hcp <= 11.5
  CONDITION: longest_suit_len <= 5.5
  CONDITION: controls > 4.5
  CONDITION: d_is_longest > 0.5
  CONDITION: heart_len <= 4.5
  CONDITION: spade_len <= 4.5
  CONDITION: is_vulnerable > 0.5
  CONDITION: s_has_ten <= 0.5
  CONDITION: club_hcp > 1.5
  CONDITION: club_len <= 2.5
  # distilled from Brill /bid

RULE BD_True_P39:
  CALL: 1D
  PRIORITY: 10
  CONDITION: is_opening == True
  CONDITION: hcp <= 11.5
  CONDITION: longest_suit_len <= 5.5
  CONDITION: controls > 4.5
  CONDITION: d_is_longest > 0.5
  CONDITION: heart_len <= 4.5
  CONDITION: spade_len <= 4.5
  CONDITION: is_vulnerable > 0.5
  CONDITION: s_has_ten <= 0.5
  CONDITION: club_hcp > 1.5
  CONDITION: club_len > 2.5
  # distilled from Brill /bid

RULE BD_True_P40:
  CALL: 1D
  PRIORITY: 10
  CONDITION: is_opening == True
  CONDITION: hcp <= 11.5
  CONDITION: longest_suit_len <= 5.5
  CONDITION: controls > 4.5
  CONDITION: d_is_longest > 0.5
  CONDITION: heart_len <= 4.5
  CONDITION: spade_len <= 4.5
  CONDITION: is_vulnerable > 0.5
  CONDITION: s_has_ten > 0.5
  # distilled from Brill /bid

RULE BD_True_P41:
  CALL: 1S
  PRIORITY: 10
  CONDITION: is_opening == True
  CONDITION: hcp <= 11.5
  CONDITION: longest_suit_len <= 5.5
  CONDITION: controls > 4.5
  CONDITION: d_is_longest > 0.5
  CONDITION: heart_len <= 4.5
  CONDITION: spade_len > 4.5
  # distilled from Brill /bid

RULE BD_True_P42:
  CALL: 1H
  PRIORITY: 10
  CONDITION: is_opening == True
  CONDITION: hcp <= 11.5
  CONDITION: longest_suit_len <= 5.5
  CONDITION: controls > 4.5
  CONDITION: d_is_longest > 0.5
  CONDITION: heart_len > 4.5
  # distilled from Brill /bid

RULE BD_True_P43:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == True
  CONDITION: hcp <= 11.5
  CONDITION: longest_suit_len > 5.5
  CONDITION: spade_len <= 5.5
  CONDITION: diamond_len <= 5.5
  CONDITION: heart_len <= 5.5
  CONDITION: club_len <= 6.5
  CONDITION: rule20_total <= 20.5
  CONDITION: quick_tricks <= 2.75
  # distilled from Brill /bid

RULE BD_True_P44:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == True
  CONDITION: hcp <= 11.5
  CONDITION: longest_suit_len > 5.5
  CONDITION: spade_len <= 5.5
  CONDITION: diamond_len <= 5.5
  CONDITION: heart_len <= 5.5
  CONDITION: club_len <= 6.5
  CONDITION: rule20_total <= 20.5
  CONDITION: quick_tricks > 2.75
  CONDITION: major_hcp <= 2.0
  # distilled from Brill /bid

RULE BD_True_P45:
  CALL: 1C
  PRIORITY: 10
  CONDITION: is_opening == True
  CONDITION: hcp <= 11.5
  CONDITION: longest_suit_len > 5.5
  CONDITION: spade_len <= 5.5
  CONDITION: diamond_len <= 5.5
  CONDITION: heart_len <= 5.5
  CONDITION: club_len <= 6.5
  CONDITION: rule20_total <= 20.5
  CONDITION: quick_tricks > 2.75
  CONDITION: major_hcp > 2.0
  # distilled from Brill /bid

RULE BD_True_P46:
  CALL: 1C
  PRIORITY: 10
  CONDITION: is_opening == True
  CONDITION: hcp <= 11.5
  CONDITION: longest_suit_len > 5.5
  CONDITION: spade_len <= 5.5
  CONDITION: diamond_len <= 5.5
  CONDITION: heart_len <= 5.5
  CONDITION: club_len <= 6.5
  CONDITION: rule20_total > 20.5
  # distilled from Brill /bid

RULE BD_True_P47:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == True
  CONDITION: hcp <= 11.5
  CONDITION: longest_suit_len > 5.5
  CONDITION: spade_len <= 5.5
  CONDITION: diamond_len <= 5.5
  CONDITION: heart_len <= 5.5
  CONDITION: club_len > 6.5
  CONDITION: rule20_total <= 20.5
  CONDITION: hcp <= 4.5
  # distilled from Brill /bid

RULE BD_True_P48:
  CALL: 3C
  PRIORITY: 10
  CONDITION: is_opening == True
  CONDITION: hcp <= 11.5
  CONDITION: longest_suit_len > 5.5
  CONDITION: spade_len <= 5.5
  CONDITION: diamond_len <= 5.5
  CONDITION: heart_len <= 5.5
  CONDITION: club_len > 6.5
  CONDITION: rule20_total <= 20.5
  CONDITION: hcp > 4.5
  CONDITION: losing_trick_count <= 6.5
  CONDITION: is_favorable_vuln <= 0.5
  # distilled from Brill /bid

RULE BD_True_P49:
  CALL: 4C
  PRIORITY: 10
  CONDITION: is_opening == True
  CONDITION: hcp <= 11.5
  CONDITION: longest_suit_len > 5.5
  CONDITION: spade_len <= 5.5
  CONDITION: diamond_len <= 5.5
  CONDITION: heart_len <= 5.5
  CONDITION: club_len > 6.5
  CONDITION: rule20_total <= 20.5
  CONDITION: hcp > 4.5
  CONDITION: losing_trick_count <= 6.5
  CONDITION: is_favorable_vuln > 0.5
  # distilled from Brill /bid

RULE BD_True_P50:
  CALL: 3C
  PRIORITY: 10
  CONDITION: is_opening == True
  CONDITION: hcp <= 11.5
  CONDITION: longest_suit_len > 5.5
  CONDITION: spade_len <= 5.5
  CONDITION: diamond_len <= 5.5
  CONDITION: heart_len <= 5.5
  CONDITION: club_len > 6.5
  CONDITION: rule20_total <= 20.5
  CONDITION: hcp > 4.5
  CONDITION: losing_trick_count > 6.5
  CONDITION: club_hcp <= 7.5
  # distilled from Brill /bid

RULE BD_True_P51:
  CALL: 3C
  PRIORITY: 10
  CONDITION: is_opening == True
  CONDITION: hcp <= 11.5
  CONDITION: longest_suit_len > 5.5
  CONDITION: spade_len <= 5.5
  CONDITION: diamond_len <= 5.5
  CONDITION: heart_len <= 5.5
  CONDITION: club_len > 6.5
  CONDITION: rule20_total <= 20.5
  CONDITION: hcp > 4.5
  CONDITION: losing_trick_count > 6.5
  CONDITION: club_hcp > 7.5
  # distilled from Brill /bid

RULE BD_True_P52:
  CALL: 5C
  PRIORITY: 10
  CONDITION: is_opening == True
  CONDITION: hcp <= 11.5
  CONDITION: longest_suit_len > 5.5
  CONDITION: spade_len <= 5.5
  CONDITION: diamond_len <= 5.5
  CONDITION: heart_len <= 5.5
  CONDITION: club_len > 6.5
  CONDITION: rule20_total > 20.5
  CONDITION: second_longest_len <= 2.5
  # distilled from Brill /bid

RULE BD_True_P53:
  CALL: 1C
  PRIORITY: 10
  CONDITION: is_opening == True
  CONDITION: hcp <= 11.5
  CONDITION: longest_suit_len > 5.5
  CONDITION: spade_len <= 5.5
  CONDITION: diamond_len <= 5.5
  CONDITION: heart_len <= 5.5
  CONDITION: club_len > 6.5
  CONDITION: rule20_total > 20.5
  CONDITION: second_longest_len > 2.5
  CONDITION: auction_len <= 2.5
  # distilled from Brill /bid

RULE BD_True_P54:
  CALL: 3C
  PRIORITY: 10
  CONDITION: is_opening == True
  CONDITION: hcp <= 11.5
  CONDITION: longest_suit_len > 5.5
  CONDITION: spade_len <= 5.5
  CONDITION: diamond_len <= 5.5
  CONDITION: heart_len <= 5.5
  CONDITION: club_len > 6.5
  CONDITION: rule20_total > 20.5
  CONDITION: second_longest_len > 2.5
  CONDITION: auction_len > 2.5
  # distilled from Brill /bid

RULE BD_True_P55:
  CALL: 2H
  PRIORITY: 10
  CONDITION: is_opening == True
  CONDITION: hcp <= 11.5
  CONDITION: longest_suit_len > 5.5
  CONDITION: spade_len <= 5.5
  CONDITION: diamond_len <= 5.5
  CONDITION: heart_len > 5.5
  CONDITION: heart_len <= 6.5
  CONDITION: rule20_total <= 19.5
  CONDITION: h_top3_honors <= 1.5
  CONDITION: losing_trick_count <= 7.5
  CONDITION: is_unfavorable_vuln <= 0.5
  # distilled from Brill /bid

RULE BD_True_P56:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == True
  CONDITION: hcp <= 11.5
  CONDITION: longest_suit_len > 5.5
  CONDITION: spade_len <= 5.5
  CONDITION: diamond_len <= 5.5
  CONDITION: heart_len > 5.5
  CONDITION: heart_len <= 6.5
  CONDITION: rule20_total <= 19.5
  CONDITION: h_top3_honors <= 1.5
  CONDITION: losing_trick_count <= 7.5
  CONDITION: is_unfavorable_vuln > 0.5
  # distilled from Brill /bid

RULE BD_True_P57:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == True
  CONDITION: hcp <= 11.5
  CONDITION: longest_suit_len > 5.5
  CONDITION: spade_len <= 5.5
  CONDITION: diamond_len <= 5.5
  CONDITION: heart_len > 5.5
  CONDITION: heart_len <= 6.5
  CONDITION: rule20_total <= 19.5
  CONDITION: h_top3_honors <= 1.5
  CONDITION: losing_trick_count > 7.5
  CONDITION: is_favorable_vuln <= 0.5
  # distilled from Brill /bid

RULE BD_True_P58:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == True
  CONDITION: hcp <= 11.5
  CONDITION: longest_suit_len > 5.5
  CONDITION: spade_len <= 5.5
  CONDITION: diamond_len <= 5.5
  CONDITION: heart_len > 5.5
  CONDITION: heart_len <= 6.5
  CONDITION: rule20_total <= 19.5
  CONDITION: h_top3_honors <= 1.5
  CONDITION: losing_trick_count > 7.5
  CONDITION: is_favorable_vuln > 0.5
  # distilled from Brill /bid

RULE BD_True_P59:
  CALL: 2H
  PRIORITY: 10
  CONDITION: is_opening == True
  CONDITION: hcp <= 11.5
  CONDITION: longest_suit_len > 5.5
  CONDITION: spade_len <= 5.5
  CONDITION: diamond_len <= 5.5
  CONDITION: heart_len > 5.5
  CONDITION: heart_len <= 6.5
  CONDITION: rule20_total <= 19.5
  CONDITION: h_top3_honors > 1.5
  CONDITION: spade_len <= 3.5
  # distilled from Brill /bid

RULE BD_True_P60:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == True
  CONDITION: hcp <= 11.5
  CONDITION: longest_suit_len > 5.5
  CONDITION: spade_len <= 5.5
  CONDITION: diamond_len <= 5.5
  CONDITION: heart_len > 5.5
  CONDITION: heart_len <= 6.5
  CONDITION: rule20_total <= 19.5
  CONDITION: h_top3_honors > 1.5
  CONDITION: spade_len > 3.5
  CONDITION: hcp <= 8.5
  # distilled from Brill /bid

RULE BD_True_P61:
  CALL: 2H
  PRIORITY: 10
  CONDITION: is_opening == True
  CONDITION: hcp <= 11.5
  CONDITION: longest_suit_len > 5.5
  CONDITION: spade_len <= 5.5
  CONDITION: diamond_len <= 5.5
  CONDITION: heart_len > 5.5
  CONDITION: heart_len <= 6.5
  CONDITION: rule20_total <= 19.5
  CONDITION: h_top3_honors > 1.5
  CONDITION: spade_len > 3.5
  CONDITION: hcp > 8.5
  # distilled from Brill /bid

RULE BD_True_P62:
  CALL: 2H
  PRIORITY: 10
  CONDITION: is_opening == True
  CONDITION: hcp <= 11.5
  CONDITION: longest_suit_len > 5.5
  CONDITION: spade_len <= 5.5
  CONDITION: diamond_len <= 5.5
  CONDITION: heart_len > 5.5
  CONDITION: heart_len <= 6.5
  CONDITION: rule20_total > 19.5
  CONDITION: rule20_total <= 20.5
  CONDITION: hcp <= 10.5
  CONDITION: spade_len <= 3.5
  # distilled from Brill /bid

RULE BD_True_P63:
  CALL: 2H
  PRIORITY: 10
  CONDITION: is_opening == True
  CONDITION: hcp <= 11.5
  CONDITION: longest_suit_len > 5.5
  CONDITION: spade_len <= 5.5
  CONDITION: diamond_len <= 5.5
  CONDITION: heart_len > 5.5
  CONDITION: heart_len <= 6.5
  CONDITION: rule20_total > 19.5
  CONDITION: rule20_total <= 20.5
  CONDITION: hcp <= 10.5
  CONDITION: spade_len > 3.5
  # distilled from Brill /bid

RULE BD_True_P64:
  CALL: 1H
  PRIORITY: 10
  CONDITION: is_opening == True
  CONDITION: hcp <= 11.5
  CONDITION: longest_suit_len > 5.5
  CONDITION: spade_len <= 5.5
  CONDITION: diamond_len <= 5.5
  CONDITION: heart_len > 5.5
  CONDITION: heart_len <= 6.5
  CONDITION: rule20_total > 19.5
  CONDITION: rule20_total <= 20.5
  CONDITION: hcp > 10.5
  CONDITION: is_vulnerable <= 0.5
  # distilled from Brill /bid

RULE BD_True_P65:
  CALL: 2H
  PRIORITY: 10
  CONDITION: is_opening == True
  CONDITION: hcp <= 11.5
  CONDITION: longest_suit_len > 5.5
  CONDITION: spade_len <= 5.5
  CONDITION: diamond_len <= 5.5
  CONDITION: heart_len > 5.5
  CONDITION: heart_len <= 6.5
  CONDITION: rule20_total > 19.5
  CONDITION: rule20_total <= 20.5
  CONDITION: hcp > 10.5
  CONDITION: is_vulnerable > 0.5
  # distilled from Brill /bid

RULE BD_True_P66:
  CALL: 1H
  PRIORITY: 10
  CONDITION: is_opening == True
  CONDITION: hcp <= 11.5
  CONDITION: longest_suit_len > 5.5
  CONDITION: spade_len <= 5.5
  CONDITION: diamond_len <= 5.5
  CONDITION: heart_len > 5.5
  CONDITION: heart_len <= 6.5
  CONDITION: rule20_total > 19.5
  CONDITION: rule20_total > 20.5
  CONDITION: auction_len <= 2.5
  # distilled from Brill /bid

RULE BD_True_P67:
  CALL: 2H
  PRIORITY: 10
  CONDITION: is_opening == True
  CONDITION: hcp <= 11.5
  CONDITION: longest_suit_len > 5.5
  CONDITION: spade_len <= 5.5
  CONDITION: diamond_len <= 5.5
  CONDITION: heart_len > 5.5
  CONDITION: heart_len <= 6.5
  CONDITION: rule20_total > 19.5
  CONDITION: rule20_total > 20.5
  CONDITION: auction_len > 2.5
  # distilled from Brill /bid

RULE BD_True_P68:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == True
  CONDITION: hcp <= 11.5
  CONDITION: longest_suit_len > 5.5
  CONDITION: spade_len <= 5.5
  CONDITION: diamond_len <= 5.5
  CONDITION: heart_len > 5.5
  CONDITION: heart_len > 6.5
  CONDITION: hcp <= 4.5
  # distilled from Brill /bid

RULE BD_True_P69:
  CALL: 3H
  PRIORITY: 10
  CONDITION: is_opening == True
  CONDITION: hcp <= 11.5
  CONDITION: longest_suit_len > 5.5
  CONDITION: spade_len <= 5.5
  CONDITION: diamond_len <= 5.5
  CONDITION: heart_len > 5.5
  CONDITION: heart_len > 6.5
  CONDITION: hcp > 4.5
  CONDITION: rule20_total <= 20.5
  CONDITION: losing_trick_count <= 6.5
  CONDITION: is_favorable_vuln <= 0.5
  # distilled from Brill /bid

RULE BD_True_P70:
  CALL: 4H
  PRIORITY: 10
  CONDITION: is_opening == True
  CONDITION: hcp <= 11.5
  CONDITION: longest_suit_len > 5.5
  CONDITION: spade_len <= 5.5
  CONDITION: diamond_len <= 5.5
  CONDITION: heart_len > 5.5
  CONDITION: heart_len > 6.5
  CONDITION: hcp > 4.5
  CONDITION: rule20_total <= 20.5
  CONDITION: losing_trick_count <= 6.5
  CONDITION: is_favorable_vuln > 0.5
  # distilled from Brill /bid

RULE BD_True_P71:
  CALL: 3H
  PRIORITY: 10
  CONDITION: is_opening == True
  CONDITION: hcp <= 11.5
  CONDITION: longest_suit_len > 5.5
  CONDITION: spade_len <= 5.5
  CONDITION: diamond_len <= 5.5
  CONDITION: heart_len > 5.5
  CONDITION: heart_len > 6.5
  CONDITION: hcp > 4.5
  CONDITION: rule20_total <= 20.5
  CONDITION: losing_trick_count > 6.5
  # distilled from Brill /bid

RULE BD_True_P72:
  CALL: 1H
  PRIORITY: 10
  CONDITION: is_opening == True
  CONDITION: hcp <= 11.5
  CONDITION: longest_suit_len > 5.5
  CONDITION: spade_len <= 5.5
  CONDITION: diamond_len <= 5.5
  CONDITION: heart_len > 5.5
  CONDITION: heart_len > 6.5
  CONDITION: hcp > 4.5
  CONDITION: rule20_total > 20.5
  CONDITION: losing_trick_count <= 5.5
  CONDITION: club_len <= 1.5
  # distilled from Brill /bid

RULE BD_True_P73:
  CALL: 4H
  PRIORITY: 10
  CONDITION: is_opening == True
  CONDITION: hcp <= 11.5
  CONDITION: longest_suit_len > 5.5
  CONDITION: spade_len <= 5.5
  CONDITION: diamond_len <= 5.5
  CONDITION: heart_len > 5.5
  CONDITION: heart_len > 6.5
  CONDITION: hcp > 4.5
  CONDITION: rule20_total > 20.5
  CONDITION: losing_trick_count <= 5.5
  CONDITION: club_len > 1.5
  # distilled from Brill /bid

RULE BD_True_P74:
  CALL: 1H
  PRIORITY: 10
  CONDITION: is_opening == True
  CONDITION: hcp <= 11.5
  CONDITION: longest_suit_len > 5.5
  CONDITION: spade_len <= 5.5
  CONDITION: diamond_len <= 5.5
  CONDITION: heart_len > 5.5
  CONDITION: heart_len > 6.5
  CONDITION: hcp > 4.5
  CONDITION: rule20_total > 20.5
  CONDITION: losing_trick_count > 5.5
  CONDITION: heart_hcp <= 7.5
  # distilled from Brill /bid

RULE BD_True_P75:
  CALL: 4H
  PRIORITY: 10
  CONDITION: is_opening == True
  CONDITION: hcp <= 11.5
  CONDITION: longest_suit_len > 5.5
  CONDITION: spade_len <= 5.5
  CONDITION: diamond_len <= 5.5
  CONDITION: heart_len > 5.5
  CONDITION: heart_len > 6.5
  CONDITION: hcp > 4.5
  CONDITION: rule20_total > 20.5
  CONDITION: losing_trick_count > 5.5
  CONDITION: heart_hcp > 7.5
  # distilled from Brill /bid

RULE BD_True_P76:
  CALL: 2D
  PRIORITY: 10
  CONDITION: is_opening == True
  CONDITION: hcp <= 11.5
  CONDITION: longest_suit_len > 5.5
  CONDITION: spade_len <= 5.5
  CONDITION: diamond_len > 5.5
  CONDITION: rule20_total <= 20.5
  CONDITION: diamond_len <= 6.5
  CONDITION: d_top3_honors <= 1.5
  CONDITION: losing_trick_count <= 7.5
  CONDITION: is_unfavorable_vuln <= 0.5
  CONDITION: second_longest_len <= 4.5
  # distilled from Brill /bid

RULE BD_True_P77:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == True
  CONDITION: hcp <= 11.5
  CONDITION: longest_suit_len > 5.5
  CONDITION: spade_len <= 5.5
  CONDITION: diamond_len > 5.5
  CONDITION: rule20_total <= 20.5
  CONDITION: diamond_len <= 6.5
  CONDITION: d_top3_honors <= 1.5
  CONDITION: losing_trick_count <= 7.5
  CONDITION: is_unfavorable_vuln <= 0.5
  CONDITION: second_longest_len > 4.5
  # distilled from Brill /bid

RULE BD_True_P78:
  CALL: 2D
  PRIORITY: 10
  CONDITION: is_opening == True
  CONDITION: hcp <= 11.5
  CONDITION: longest_suit_len > 5.5
  CONDITION: spade_len <= 5.5
  CONDITION: diamond_len > 5.5
  CONDITION: rule20_total <= 20.5
  CONDITION: diamond_len <= 6.5
  CONDITION: d_top3_honors <= 1.5
  CONDITION: losing_trick_count <= 7.5
  CONDITION: is_unfavorable_vuln > 0.5
  CONDITION: losing_trick_count <= 6.5
  # distilled from Brill /bid

RULE BD_True_P79:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == True
  CONDITION: hcp <= 11.5
  CONDITION: longest_suit_len > 5.5
  CONDITION: spade_len <= 5.5
  CONDITION: diamond_len > 5.5
  CONDITION: rule20_total <= 20.5
  CONDITION: diamond_len <= 6.5
  CONDITION: d_top3_honors <= 1.5
  CONDITION: losing_trick_count <= 7.5
  CONDITION: is_unfavorable_vuln > 0.5
  CONDITION: losing_trick_count > 6.5
  # distilled from Brill /bid

RULE BD_True_P80:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == True
  CONDITION: hcp <= 11.5
  CONDITION: longest_suit_len > 5.5
  CONDITION: spade_len <= 5.5
  CONDITION: diamond_len > 5.5
  CONDITION: rule20_total <= 20.5
  CONDITION: diamond_len <= 6.5
  CONDITION: d_top3_honors <= 1.5
  CONDITION: losing_trick_count > 7.5
  CONDITION: is_favorable_vuln <= 0.5
  # distilled from Brill /bid

RULE BD_True_P81:
  CALL: 2D
  PRIORITY: 10
  CONDITION: is_opening == True
  CONDITION: hcp <= 11.5
  CONDITION: longest_suit_len > 5.5
  CONDITION: spade_len <= 5.5
  CONDITION: diamond_len > 5.5
  CONDITION: rule20_total <= 20.5
  CONDITION: diamond_len <= 6.5
  CONDITION: d_top3_honors <= 1.5
  CONDITION: losing_trick_count > 7.5
  CONDITION: is_favorable_vuln > 0.5
  CONDITION: losing_trick_count <= 8.5
  # distilled from Brill /bid

RULE BD_True_P82:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == True
  CONDITION: hcp <= 11.5
  CONDITION: longest_suit_len > 5.5
  CONDITION: spade_len <= 5.5
  CONDITION: diamond_len > 5.5
  CONDITION: rule20_total <= 20.5
  CONDITION: diamond_len <= 6.5
  CONDITION: d_top3_honors <= 1.5
  CONDITION: losing_trick_count > 7.5
  CONDITION: is_favorable_vuln > 0.5
  CONDITION: losing_trick_count > 8.5
  # distilled from Brill /bid

RULE BD_True_P83:
  CALL: 2D
  PRIORITY: 10
  CONDITION: is_opening == True
  CONDITION: hcp <= 11.5
  CONDITION: longest_suit_len > 5.5
  CONDITION: spade_len <= 5.5
  CONDITION: diamond_len > 5.5
  CONDITION: rule20_total <= 20.5
  CONDITION: diamond_len <= 6.5
  CONDITION: d_top3_honors > 1.5
  CONDITION: second_longest_len <= 4.5
  # distilled from Brill /bid

RULE BD_True_P84:
  CALL: 2D
  PRIORITY: 10
  CONDITION: is_opening == True
  CONDITION: hcp <= 11.5
  CONDITION: longest_suit_len > 5.5
  CONDITION: spade_len <= 5.5
  CONDITION: diamond_len > 5.5
  CONDITION: rule20_total <= 20.5
  CONDITION: diamond_len <= 6.5
  CONDITION: d_top3_honors > 1.5
  CONDITION: second_longest_len > 4.5
  CONDITION: major_hcp <= 0.5
  # distilled from Brill /bid

RULE BD_True_P85:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == True
  CONDITION: hcp <= 11.5
  CONDITION: longest_suit_len > 5.5
  CONDITION: spade_len <= 5.5
  CONDITION: diamond_len > 5.5
  CONDITION: rule20_total <= 20.5
  CONDITION: diamond_len <= 6.5
  CONDITION: d_top3_honors > 1.5
  CONDITION: second_longest_len > 4.5
  CONDITION: major_hcp > 0.5
  # distilled from Brill /bid

RULE BD_True_P86:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == True
  CONDITION: hcp <= 11.5
  CONDITION: longest_suit_len > 5.5
  CONDITION: spade_len <= 5.5
  CONDITION: diamond_len > 5.5
  CONDITION: rule20_total <= 20.5
  CONDITION: diamond_len > 6.5
  CONDITION: hcp <= 4.5
  # distilled from Brill /bid

RULE BD_True_P87:
  CALL: 3D
  PRIORITY: 10
  CONDITION: is_opening == True
  CONDITION: hcp <= 11.5
  CONDITION: longest_suit_len > 5.5
  CONDITION: spade_len <= 5.5
  CONDITION: diamond_len > 5.5
  CONDITION: rule20_total <= 20.5
  CONDITION: diamond_len > 6.5
  CONDITION: hcp > 4.5
  CONDITION: losing_trick_count <= 6.5
  CONDITION: second_longest_len <= 4.5
  CONDITION: diamond_len <= 7.5
  # distilled from Brill /bid

RULE BD_True_P88:
  CALL: 4D
  PRIORITY: 10
  CONDITION: is_opening == True
  CONDITION: hcp <= 11.5
  CONDITION: longest_suit_len > 5.5
  CONDITION: spade_len <= 5.5
  CONDITION: diamond_len > 5.5
  CONDITION: rule20_total <= 20.5
  CONDITION: diamond_len > 6.5
  CONDITION: hcp > 4.5
  CONDITION: losing_trick_count <= 6.5
  CONDITION: second_longest_len <= 4.5
  CONDITION: diamond_len > 7.5
  # distilled from Brill /bid

RULE BD_True_P89:
  CALL: 4D
  PRIORITY: 10
  CONDITION: is_opening == True
  CONDITION: hcp <= 11.5
  CONDITION: longest_suit_len > 5.5
  CONDITION: spade_len <= 5.5
  CONDITION: diamond_len > 5.5
  CONDITION: rule20_total <= 20.5
  CONDITION: diamond_len > 6.5
  CONDITION: hcp > 4.5
  CONDITION: losing_trick_count <= 6.5
  CONDITION: second_longest_len > 4.5
  CONDITION: major_hcp <= 0.5
  # distilled from Brill /bid

RULE BD_True_P90:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == True
  CONDITION: hcp <= 11.5
  CONDITION: longest_suit_len > 5.5
  CONDITION: spade_len <= 5.5
  CONDITION: diamond_len > 5.5
  CONDITION: rule20_total <= 20.5
  CONDITION: diamond_len > 6.5
  CONDITION: hcp > 4.5
  CONDITION: losing_trick_count <= 6.5
  CONDITION: second_longest_len > 4.5
  CONDITION: major_hcp > 0.5
  # distilled from Brill /bid

RULE BD_True_P91:
  CALL: 3D
  PRIORITY: 10
  CONDITION: is_opening == True
  CONDITION: hcp <= 11.5
  CONDITION: longest_suit_len > 5.5
  CONDITION: spade_len <= 5.5
  CONDITION: diamond_len > 5.5
  CONDITION: rule20_total <= 20.5
  CONDITION: diamond_len > 6.5
  CONDITION: hcp > 4.5
  CONDITION: losing_trick_count > 6.5
  # distilled from Brill /bid

RULE BD_True_P92:
  CALL: 5D
  PRIORITY: 10
  CONDITION: is_opening == True
  CONDITION: hcp <= 11.5
  CONDITION: longest_suit_len > 5.5
  CONDITION: spade_len <= 5.5
  CONDITION: diamond_len > 5.5
  CONDITION: rule20_total > 20.5
  CONDITION: heart_len <= 5.5
  CONDITION: shape_pattern == '8410'
  # distilled from Brill /bid

RULE BD_True_P93:
  CALL: 1D
  PRIORITY: 10
  CONDITION: is_opening == True
  CONDITION: hcp <= 11.5
  CONDITION: longest_suit_len > 5.5
  CONDITION: spade_len <= 5.5
  CONDITION: diamond_len > 5.5
  CONDITION: rule20_total > 20.5
  CONDITION: heart_len <= 5.5
  CONDITION: shape_pattern != '8410'
  CONDITION: auction_len <= 2.5
  # distilled from Brill /bid

RULE BD_True_P94:
  CALL: 3D
  PRIORITY: 10
  CONDITION: is_opening == True
  CONDITION: hcp <= 11.5
  CONDITION: longest_suit_len > 5.5
  CONDITION: spade_len <= 5.5
  CONDITION: diamond_len > 5.5
  CONDITION: rule20_total > 20.5
  CONDITION: heart_len <= 5.5
  CONDITION: shape_pattern != '8410'
  CONDITION: auction_len > 2.5
  CONDITION: hcp <= 10.5
  # distilled from Brill /bid

RULE BD_True_P95:
  CALL: 1D
  PRIORITY: 10
  CONDITION: is_opening == True
  CONDITION: hcp <= 11.5
  CONDITION: longest_suit_len > 5.5
  CONDITION: spade_len <= 5.5
  CONDITION: diamond_len > 5.5
  CONDITION: rule20_total > 20.5
  CONDITION: heart_len <= 5.5
  CONDITION: shape_pattern != '8410'
  CONDITION: auction_len > 2.5
  CONDITION: hcp > 10.5
  # distilled from Brill /bid

RULE BD_True_P96:
  CALL: 1H
  PRIORITY: 10
  CONDITION: is_opening == True
  CONDITION: hcp <= 11.5
  CONDITION: longest_suit_len > 5.5
  CONDITION: spade_len <= 5.5
  CONDITION: diamond_len > 5.5
  CONDITION: rule20_total > 20.5
  CONDITION: heart_len > 5.5
  # distilled from Brill /bid

RULE BD_True_P97:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == True
  CONDITION: hcp <= 11.5
  CONDITION: longest_suit_len > 5.5
  CONDITION: spade_len > 5.5
  CONDITION: spade_len <= 6.5
  CONDITION: losing_trick_count <= 7.5
  CONDITION: rule20_total <= 20.5
  CONDITION: hcp <= 10.5
  CONDITION: is_unfavorable_vuln <= 0.5
  CONDITION: hcp <= 4.5
  # distilled from Brill /bid

RULE BD_True_P98:
  CALL: 2S
  PRIORITY: 10
  CONDITION: is_opening == True
  CONDITION: hcp <= 11.5
  CONDITION: longest_suit_len > 5.5
  CONDITION: spade_len > 5.5
  CONDITION: spade_len <= 6.5
  CONDITION: losing_trick_count <= 7.5
  CONDITION: rule20_total <= 20.5
  CONDITION: hcp <= 10.5
  CONDITION: is_unfavorable_vuln <= 0.5
  CONDITION: hcp > 4.5
  CONDITION: heart_len <= 4.5
  # distilled from Brill /bid

RULE BD_True_P99:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == True
  CONDITION: hcp <= 11.5
  CONDITION: longest_suit_len > 5.5
  CONDITION: spade_len > 5.5
  CONDITION: spade_len <= 6.5
  CONDITION: losing_trick_count <= 7.5
  CONDITION: rule20_total <= 20.5
  CONDITION: hcp <= 10.5
  CONDITION: is_unfavorable_vuln <= 0.5
  CONDITION: hcp > 4.5
  CONDITION: heart_len > 4.5
  # distilled from Brill /bid

RULE BD_True_P100:
  CALL: 2S
  PRIORITY: 10
  CONDITION: is_opening == True
  CONDITION: hcp <= 11.5
  CONDITION: longest_suit_len > 5.5
  CONDITION: spade_len > 5.5
  CONDITION: spade_len <= 6.5
  CONDITION: losing_trick_count <= 7.5
  CONDITION: rule20_total <= 20.5
  CONDITION: hcp <= 10.5
  CONDITION: is_unfavorable_vuln > 0.5
  CONDITION: s_top3_honors <= 1.5
  CONDITION: losing_trick_count <= 6.5
  # distilled from Brill /bid

RULE BD_True_P101:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == True
  CONDITION: hcp <= 11.5
  CONDITION: longest_suit_len > 5.5
  CONDITION: spade_len > 5.5
  CONDITION: spade_len <= 6.5
  CONDITION: losing_trick_count <= 7.5
  CONDITION: rule20_total <= 20.5
  CONDITION: hcp <= 10.5
  CONDITION: is_unfavorable_vuln > 0.5
  CONDITION: s_top3_honors <= 1.5
  CONDITION: losing_trick_count > 6.5
  # distilled from Brill /bid

RULE BD_True_P102:
  CALL: 2S
  PRIORITY: 10
  CONDITION: is_opening == True
  CONDITION: hcp <= 11.5
  CONDITION: longest_suit_len > 5.5
  CONDITION: spade_len > 5.5
  CONDITION: spade_len <= 6.5
  CONDITION: losing_trick_count <= 7.5
  CONDITION: rule20_total <= 20.5
  CONDITION: hcp <= 10.5
  CONDITION: is_unfavorable_vuln > 0.5
  CONDITION: s_top3_honors > 1.5
  CONDITION: heart_len <= 3.5
  # distilled from Brill /bid

RULE BD_True_P103:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == True
  CONDITION: hcp <= 11.5
  CONDITION: longest_suit_len > 5.5
  CONDITION: spade_len > 5.5
  CONDITION: spade_len <= 6.5
  CONDITION: losing_trick_count <= 7.5
  CONDITION: rule20_total <= 20.5
  CONDITION: hcp <= 10.5
  CONDITION: is_unfavorable_vuln > 0.5
  CONDITION: s_top3_honors > 1.5
  CONDITION: heart_len > 3.5
  # distilled from Brill /bid

RULE BD_True_P104:
  CALL: 1S
  PRIORITY: 10
  CONDITION: is_opening == True
  CONDITION: hcp <= 11.5
  CONDITION: longest_suit_len > 5.5
  CONDITION: spade_len > 5.5
  CONDITION: spade_len <= 6.5
  CONDITION: losing_trick_count <= 7.5
  CONDITION: rule20_total <= 20.5
  CONDITION: hcp > 10.5
  CONDITION: is_vulnerable <= 0.5
  CONDITION: d_has_ten <= 0.5
  # distilled from Brill /bid

RULE BD_True_P105:
  CALL: 2S
  PRIORITY: 10
  CONDITION: is_opening == True
  CONDITION: hcp <= 11.5
  CONDITION: longest_suit_len > 5.5
  CONDITION: spade_len > 5.5
  CONDITION: spade_len <= 6.5
  CONDITION: losing_trick_count <= 7.5
  CONDITION: rule20_total <= 20.5
  CONDITION: hcp > 10.5
  CONDITION: is_vulnerable <= 0.5
  CONDITION: d_has_ten > 0.5
  # distilled from Brill /bid

RULE BD_True_P106:
  CALL: 2S
  PRIORITY: 10
  CONDITION: is_opening == True
  CONDITION: hcp <= 11.5
  CONDITION: longest_suit_len > 5.5
  CONDITION: spade_len > 5.5
  CONDITION: spade_len <= 6.5
  CONDITION: losing_trick_count <= 7.5
  CONDITION: rule20_total <= 20.5
  CONDITION: hcp > 10.5
  CONDITION: is_vulnerable > 0.5
  CONDITION: controls <= 4.5
  CONDITION: s_top3_honors <= 1.5
  # distilled from Brill /bid

RULE BD_True_P107:
  CALL: 2S
  PRIORITY: 10
  CONDITION: is_opening == True
  CONDITION: hcp <= 11.5
  CONDITION: longest_suit_len > 5.5
  CONDITION: spade_len > 5.5
  CONDITION: spade_len <= 6.5
  CONDITION: losing_trick_count <= 7.5
  CONDITION: rule20_total <= 20.5
  CONDITION: hcp > 10.5
  CONDITION: is_vulnerable > 0.5
  CONDITION: controls <= 4.5
  CONDITION: s_top3_honors > 1.5
  # distilled from Brill /bid

RULE BD_True_P108:
  CALL: 1S
  PRIORITY: 10
  CONDITION: is_opening == True
  CONDITION: hcp <= 11.5
  CONDITION: longest_suit_len > 5.5
  CONDITION: spade_len > 5.5
  CONDITION: spade_len <= 6.5
  CONDITION: losing_trick_count <= 7.5
  CONDITION: rule20_total <= 20.5
  CONDITION: hcp > 10.5
  CONDITION: is_vulnerable > 0.5
  CONDITION: controls > 4.5
  # distilled from Brill /bid

RULE BD_True_P109:
  CALL: 1S
  PRIORITY: 10
  CONDITION: is_opening == True
  CONDITION: hcp <= 11.5
  CONDITION: longest_suit_len > 5.5
  CONDITION: spade_len > 5.5
  CONDITION: spade_len <= 6.5
  CONDITION: losing_trick_count <= 7.5
  CONDITION: rule20_total > 20.5
  CONDITION: auction_len <= 2.5
  # distilled from Brill /bid

RULE BD_True_P110:
  CALL: 2S
  PRIORITY: 10
  CONDITION: is_opening == True
  CONDITION: hcp <= 11.5
  CONDITION: longest_suit_len > 5.5
  CONDITION: spade_len > 5.5
  CONDITION: spade_len <= 6.5
  CONDITION: losing_trick_count <= 7.5
  CONDITION: rule20_total > 20.5
  CONDITION: auction_len > 2.5
  # distilled from Brill /bid

RULE BD_True_P111:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == True
  CONDITION: hcp <= 11.5
  CONDITION: longest_suit_len > 5.5
  CONDITION: spade_len > 5.5
  CONDITION: spade_len <= 6.5
  CONDITION: losing_trick_count > 7.5
  CONDITION: s_top3_honors <= 1.5
  CONDITION: is_favorable_vuln <= 0.5
  CONDITION: quick_tricks <= 2.25
  # distilled from Brill /bid

RULE BD_True_P112:
  CALL: 1S
  PRIORITY: 10
  CONDITION: is_opening == True
  CONDITION: hcp <= 11.5
  CONDITION: longest_suit_len > 5.5
  CONDITION: spade_len > 5.5
  CONDITION: spade_len <= 6.5
  CONDITION: losing_trick_count > 7.5
  CONDITION: s_top3_honors <= 1.5
  CONDITION: is_favorable_vuln <= 0.5
  CONDITION: quick_tricks > 2.25
  # distilled from Brill /bid

RULE BD_True_P113:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == True
  CONDITION: hcp <= 11.5
  CONDITION: longest_suit_len > 5.5
  CONDITION: spade_len > 5.5
  CONDITION: spade_len <= 6.5
  CONDITION: losing_trick_count > 7.5
  CONDITION: s_top3_honors <= 1.5
  CONDITION: is_favorable_vuln > 0.5
  CONDITION: total_points <= 7.5
  CONDITION: hcp <= 4.5
  # distilled from Brill /bid

RULE BD_True_P114:
  CALL: 2S
  PRIORITY: 10
  CONDITION: is_opening == True
  CONDITION: hcp <= 11.5
  CONDITION: longest_suit_len > 5.5
  CONDITION: spade_len > 5.5
  CONDITION: spade_len <= 6.5
  CONDITION: losing_trick_count > 7.5
  CONDITION: s_top3_honors <= 1.5
  CONDITION: is_favorable_vuln > 0.5
  CONDITION: total_points <= 7.5
  CONDITION: hcp > 4.5
  CONDITION: losing_trick_count <= 8.5
  # distilled from Brill /bid

RULE BD_True_P115:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == True
  CONDITION: hcp <= 11.5
  CONDITION: longest_suit_len > 5.5
  CONDITION: spade_len > 5.5
  CONDITION: spade_len <= 6.5
  CONDITION: losing_trick_count > 7.5
  CONDITION: s_top3_honors <= 1.5
  CONDITION: is_favorable_vuln > 0.5
  CONDITION: total_points <= 7.5
  CONDITION: hcp > 4.5
  CONDITION: losing_trick_count > 8.5
  # distilled from Brill /bid

RULE BD_True_P116:
  CALL: 2S
  PRIORITY: 10
  CONDITION: is_opening == True
  CONDITION: hcp <= 11.5
  CONDITION: longest_suit_len > 5.5
  CONDITION: spade_len > 5.5
  CONDITION: spade_len <= 6.5
  CONDITION: losing_trick_count > 7.5
  CONDITION: s_top3_honors <= 1.5
  CONDITION: is_favorable_vuln > 0.5
  CONDITION: total_points > 7.5
  CONDITION: c_has_ace <= 0.5
  # distilled from Brill /bid

RULE BD_True_P117:
  CALL: PASS
  PRIORITY: 10
  CONDITION: is_opening == True
  CONDITION: hcp <= 11.5
  CONDITION: longest_suit_len > 5.5
  CONDITION: spade_len > 5.5
  CONDITION: spade_len <= 6.5
  CONDITION: losing_trick_count > 7.5
  CONDITION: s_top3_honors <= 1.5
  CONDITION: is_favorable_vuln > 0.5
  CONDITION: total_points > 7.5
  CONDITION: c_has_ace > 0.5
  CONDITION: hcp <= 10.0
  # distilled from Brill /bid

RULE BD_True_P118:
  CALL: 1S
  PRIORITY: 10
  CONDITION: is_opening == True
  CONDITION: hcp <= 11.5
  CONDITION: longest_suit_len > 5.5
  CONDITION: spade_len > 5.5
  CONDITION: spade_len <= 6.5
  CONDITION: losing_trick_count > 7.5
  CONDITION: s_top3_honors <= 1.5
  CONDITION: is_favorable_vuln > 0.5
  CONDITION: total_points > 7.5
  CONDITION: c_has_ace > 0.5
  CONDITION: hcp > 10.0
  # distilled from Brill /bid

RULE BD_True_P119:
  CALL: 2S
  PRIORITY: 10
  CONDITION: is_opening == True
  CONDITION: hcp <= 11.5
  CONDITION: longest_suit_len > 5.5
  CONDITION: spade_len > 5.5
  CONDITION: spade_len <= 6.5
  CONDITION: losing_trick_count > 7.5
  CONDITION: s_top3_honors > 1.5
  CONDITION: hcp <= 10.5
  # distilled from Brill /bid

RULE BD_True_P120:
  CALL: 1S
  PRIORITY: 10
  CONDITION: is_opening == True
  CONDITION: hcp <= 11.5
  CONDITION: longest_suit_len > 5.5
  CONDITION: spade_len > 5.5
  CONDITION: spade_len <= 6.5
  CONDITION: losing_trick_count > 7.5
  CONDITION: s_top3_honors > 1.5
  CONDITION: hcp > 10.5
  # distilled from Brill /bid

RULE BD_True_P121:
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

RULE BD_True_P122:
  CALL: 4S
  PRIORITY: 10
  CONDITION: is_opening == True
  CONDITION: hcp <= 11.5
  CONDITION: longest_suit_len > 5.5
  CONDITION: spade_len > 5.5
  CONDITION: spade_len > 6.5
  CONDITION: rule20_total <= 20.5
  CONDITION: hcp > 4.5
  CONDITION: is_favorable_vuln <= 0.5
  CONDITION: losing_trick_count <= 5.5
  CONDITION: spade_len <= 7.5
  # distilled from Brill /bid

RULE BD_True_P123:
  CALL: 5S
  PRIORITY: 10
  CONDITION: is_opening == True
  CONDITION: hcp <= 11.5
  CONDITION: longest_suit_len > 5.5
  CONDITION: spade_len > 5.5
  CONDITION: spade_len > 6.5
  CONDITION: rule20_total <= 20.5
  CONDITION: hcp > 4.5
  CONDITION: is_favorable_vuln <= 0.5
  CONDITION: losing_trick_count <= 5.5
  CONDITION: spade_len > 7.5
  CONDITION: hcp <= 8.5
  # distilled from Brill /bid

RULE BD_True_P124:
  CALL: 3S
  PRIORITY: 10
  CONDITION: is_opening == True
  CONDITION: hcp <= 11.5
  CONDITION: longest_suit_len > 5.5
  CONDITION: spade_len > 5.5
  CONDITION: spade_len > 6.5
  CONDITION: rule20_total <= 20.5
  CONDITION: hcp > 4.5
  CONDITION: is_favorable_vuln <= 0.5
  CONDITION: losing_trick_count <= 5.5
  CONDITION: spade_len > 7.5
  CONDITION: hcp > 8.5
  # distilled from Brill /bid

RULE BD_True_P125:
  CALL: 3S
  PRIORITY: 10
  CONDITION: is_opening == True
  CONDITION: hcp <= 11.5
  CONDITION: longest_suit_len > 5.5
  CONDITION: spade_len > 5.5
  CONDITION: spade_len > 6.5
  CONDITION: rule20_total <= 20.5
  CONDITION: hcp > 4.5
  CONDITION: is_favorable_vuln <= 0.5
  CONDITION: losing_trick_count > 5.5
  # distilled from Brill /bid

RULE BD_True_P126:
  CALL: 5S
  PRIORITY: 10
  CONDITION: is_opening == True
  CONDITION: hcp <= 11.5
  CONDITION: longest_suit_len > 5.5
  CONDITION: spade_len > 5.5
  CONDITION: spade_len > 6.5
  CONDITION: rule20_total <= 20.5
  CONDITION: hcp > 4.5
  CONDITION: is_favorable_vuln > 0.5
  CONDITION: losing_trick_count <= 6.5
  CONDITION: hcp <= 6.5
  # distilled from Brill /bid

RULE BD_True_P127:
  CALL: 4S
  PRIORITY: 10
  CONDITION: is_opening == True
  CONDITION: hcp <= 11.5
  CONDITION: longest_suit_len > 5.5
  CONDITION: spade_len > 5.5
  CONDITION: spade_len > 6.5
  CONDITION: rule20_total <= 20.5
  CONDITION: hcp > 4.5
  CONDITION: is_favorable_vuln > 0.5
  CONDITION: losing_trick_count <= 6.5
  CONDITION: hcp > 6.5
  # distilled from Brill /bid

RULE BD_True_P128:
  CALL: 3S
  PRIORITY: 10
  CONDITION: is_opening == True
  CONDITION: hcp <= 11.5
  CONDITION: longest_suit_len > 5.5
  CONDITION: spade_len > 5.5
  CONDITION: spade_len > 6.5
  CONDITION: rule20_total <= 20.5
  CONDITION: hcp > 4.5
  CONDITION: is_favorable_vuln > 0.5
  CONDITION: losing_trick_count > 6.5
  # distilled from Brill /bid

RULE BD_True_P129:
  CALL: 1S
  PRIORITY: 10
  CONDITION: is_opening == True
  CONDITION: hcp <= 11.5
  CONDITION: longest_suit_len > 5.5
  CONDITION: spade_len > 5.5
  CONDITION: spade_len > 6.5
  CONDITION: rule20_total > 20.5
  CONDITION: is_favorable_vuln <= 0.5
  CONDITION: second_longest_len <= 3.5
  # distilled from Brill /bid

RULE BD_True_P130:
  CALL: 4S
  PRIORITY: 10
  CONDITION: is_opening == True
  CONDITION: hcp <= 11.5
  CONDITION: longest_suit_len > 5.5
  CONDITION: spade_len > 5.5
  CONDITION: spade_len > 6.5
  CONDITION: rule20_total > 20.5
  CONDITION: is_favorable_vuln <= 0.5
  CONDITION: second_longest_len > 3.5
  CONDITION: is_unfavorable_vuln <= 0.5
  CONDITION: losing_trick_count <= 5.5
  # distilled from Brill /bid

RULE BD_True_P131:
  CALL: 3S
  PRIORITY: 10
  CONDITION: is_opening == True
  CONDITION: hcp <= 11.5
  CONDITION: longest_suit_len > 5.5
  CONDITION: spade_len > 5.5
  CONDITION: spade_len > 6.5
  CONDITION: rule20_total > 20.5
  CONDITION: is_favorable_vuln <= 0.5
  CONDITION: second_longest_len > 3.5
  CONDITION: is_unfavorable_vuln <= 0.5
  CONDITION: losing_trick_count > 5.5
  # distilled from Brill /bid

RULE BD_True_P132:
  CALL: 4S
  PRIORITY: 10
  CONDITION: is_opening == True
  CONDITION: hcp <= 11.5
  CONDITION: longest_suit_len > 5.5
  CONDITION: spade_len > 5.5
  CONDITION: spade_len > 6.5
  CONDITION: rule20_total > 20.5
  CONDITION: is_favorable_vuln <= 0.5
  CONDITION: second_longest_len > 3.5
  CONDITION: is_unfavorable_vuln > 0.5
  CONDITION: spade_hcp <= 5.5
  # distilled from Brill /bid

RULE BD_True_P133:
  CALL: 1S
  PRIORITY: 10
  CONDITION: is_opening == True
  CONDITION: hcp <= 11.5
  CONDITION: longest_suit_len > 5.5
  CONDITION: spade_len > 5.5
  CONDITION: spade_len > 6.5
  CONDITION: rule20_total > 20.5
  CONDITION: is_favorable_vuln <= 0.5
  CONDITION: second_longest_len > 3.5
  CONDITION: is_unfavorable_vuln > 0.5
  CONDITION: spade_hcp > 5.5
  # distilled from Brill /bid

RULE BD_True_P134:
  CALL: 4S
  PRIORITY: 10
  CONDITION: is_opening == True
  CONDITION: hcp <= 11.5
  CONDITION: longest_suit_len > 5.5
  CONDITION: spade_len > 5.5
  CONDITION: spade_len > 6.5
  CONDITION: rule20_total > 20.5
  CONDITION: is_favorable_vuln > 0.5
  # distilled from Brill /bid

RULE BD_True_P135:
  CALL: 1D
  PRIORITY: 10
  CONDITION: is_opening == True
  CONDITION: hcp > 11.5
  CONDITION: spade_len <= 4.5
  CONDITION: heart_len <= 4.5
  CONDITION: d_is_longest <= 0.5
  CONDITION: hcp <= 14.5
  CONDITION: club_len <= 2.5
  # distilled from Brill /bid

RULE BD_True_P136:
  CALL: 1C
  PRIORITY: 10
  CONDITION: is_opening == True
  CONDITION: hcp > 11.5
  CONDITION: spade_len <= 4.5
  CONDITION: heart_len <= 4.5
  CONDITION: d_is_longest <= 0.5
  CONDITION: hcp <= 14.5
  CONDITION: club_len > 2.5
  # distilled from Brill /bid

RULE BD_True_P137:
  CALL: 1C
  PRIORITY: 10
  CONDITION: is_opening == True
  CONDITION: hcp > 11.5
  CONDITION: spade_len <= 4.5
  CONDITION: heart_len <= 4.5
  CONDITION: d_is_longest <= 0.5
  CONDITION: hcp > 14.5
  CONDITION: total_points <= 17.5
  CONDITION: is_semi_balanced <= 0.5
  # distilled from Brill /bid

RULE BD_True_P138:
  CALL: 1NT
  PRIORITY: 10
  CONDITION: is_opening == True
  CONDITION: hcp > 11.5
  CONDITION: spade_len <= 4.5
  CONDITION: heart_len <= 4.5
  CONDITION: d_is_longest <= 0.5
  CONDITION: hcp > 14.5
  CONDITION: total_points <= 17.5
  CONDITION: is_semi_balanced > 0.5
  # distilled from Brill /bid

RULE BD_True_P139:
  CALL: 1NT
  PRIORITY: 10
  CONDITION: is_opening == True
  CONDITION: hcp > 11.5
  CONDITION: spade_len <= 4.5
  CONDITION: heart_len <= 4.5
  CONDITION: d_is_longest <= 0.5
  CONDITION: hcp > 14.5
  CONDITION: total_points > 17.5
  CONDITION: hcp <= 19.5
  CONDITION: club_len <= 2.5
  CONDITION: hcp <= 17.5
  # distilled from Brill /bid

RULE BD_True_P140:
  CALL: 1D
  PRIORITY: 10
  CONDITION: is_opening == True
  CONDITION: hcp > 11.5
  CONDITION: spade_len <= 4.5
  CONDITION: heart_len <= 4.5
  CONDITION: d_is_longest <= 0.5
  CONDITION: hcp > 14.5
  CONDITION: total_points > 17.5
  CONDITION: hcp <= 19.5
  CONDITION: club_len <= 2.5
  CONDITION: hcp > 17.5
  # distilled from Brill /bid

RULE BD_True_P141:
  CALL: 1C
  PRIORITY: 10
  CONDITION: is_opening == True
  CONDITION: hcp > 11.5
  CONDITION: spade_len <= 4.5
  CONDITION: heart_len <= 4.5
  CONDITION: d_is_longest <= 0.5
  CONDITION: hcp > 14.5
  CONDITION: total_points > 17.5
  CONDITION: hcp <= 19.5
  CONDITION: club_len > 2.5
  CONDITION: hcp <= 17.5
  CONDITION: is_semi_balanced <= 0.5
  # distilled from Brill /bid

RULE BD_True_P142:
  CALL: 1NT
  PRIORITY: 10
  CONDITION: is_opening == True
  CONDITION: hcp > 11.5
  CONDITION: spade_len <= 4.5
  CONDITION: heart_len <= 4.5
  CONDITION: d_is_longest <= 0.5
  CONDITION: hcp > 14.5
  CONDITION: total_points > 17.5
  CONDITION: hcp <= 19.5
  CONDITION: club_len > 2.5
  CONDITION: hcp <= 17.5
  CONDITION: is_semi_balanced > 0.5
  # distilled from Brill /bid

RULE BD_True_P143:
  CALL: 2C
  PRIORITY: 10
  CONDITION: is_opening == True
  CONDITION: hcp > 11.5
  CONDITION: spade_len <= 4.5
  CONDITION: heart_len <= 4.5
  CONDITION: d_is_longest <= 0.5
  CONDITION: hcp > 14.5
  CONDITION: total_points > 17.5
  CONDITION: hcp <= 19.5
  CONDITION: club_len > 2.5
  CONDITION: hcp > 17.5
  CONDITION: major_hcp <= 1.0
  # distilled from Brill /bid

RULE BD_True_P144:
  CALL: 1C
  PRIORITY: 10
  CONDITION: is_opening == True
  CONDITION: hcp > 11.5
  CONDITION: spade_len <= 4.5
  CONDITION: heart_len <= 4.5
  CONDITION: d_is_longest <= 0.5
  CONDITION: hcp > 14.5
  CONDITION: total_points > 17.5
  CONDITION: hcp <= 19.5
  CONDITION: club_len > 2.5
  CONDITION: hcp > 17.5
  CONDITION: major_hcp > 1.0
  # distilled from Brill /bid

RULE BD_True_P145:
  CALL: 1C
  PRIORITY: 10
  CONDITION: is_opening == True
  CONDITION: hcp > 11.5
  CONDITION: spade_len <= 4.5
  CONDITION: heart_len <= 4.5
  CONDITION: d_is_longest <= 0.5
  CONDITION: hcp > 14.5
  CONDITION: total_points > 17.5
  CONDITION: hcp > 19.5
  CONDITION: hcp <= 21.5
  CONDITION: is_semi_balanced <= 0.5
  CONDITION: third_longest_len <= 2.5
  # distilled from Brill /bid

RULE BD_True_P146:
  CALL: 2NT
  PRIORITY: 10
  CONDITION: is_opening == True
  CONDITION: hcp > 11.5
  CONDITION: spade_len <= 4.5
  CONDITION: heart_len <= 4.5
  CONDITION: d_is_longest <= 0.5
  CONDITION: hcp > 14.5
  CONDITION: total_points > 17.5
  CONDITION: hcp > 19.5
  CONDITION: hcp <= 21.5
  CONDITION: is_semi_balanced <= 0.5
  CONDITION: third_longest_len > 2.5
  # distilled from Brill /bid

RULE BD_True_P147:
  CALL: 2NT
  PRIORITY: 10
  CONDITION: is_opening == True
  CONDITION: hcp > 11.5
  CONDITION: spade_len <= 4.5
  CONDITION: heart_len <= 4.5
  CONDITION: d_is_longest <= 0.5
  CONDITION: hcp > 14.5
  CONDITION: total_points > 17.5
  CONDITION: hcp > 19.5
  CONDITION: hcp <= 21.5
  CONDITION: is_semi_balanced > 0.5
  # distilled from Brill /bid

RULE BD_True_P148:
  CALL: 2C
  PRIORITY: 10
  CONDITION: is_opening == True
  CONDITION: hcp > 11.5
  CONDITION: spade_len <= 4.5
  CONDITION: heart_len <= 4.5
  CONDITION: d_is_longest <= 0.5
  CONDITION: hcp > 14.5
  CONDITION: total_points > 17.5
  CONDITION: hcp > 19.5
  CONDITION: hcp > 21.5
  CONDITION: hcp <= 24.5
  # distilled from Brill /bid

RULE BD_True_P149:
  CALL: 3NT
  PRIORITY: 10
  CONDITION: is_opening == True
  CONDITION: hcp > 11.5
  CONDITION: spade_len <= 4.5
  CONDITION: heart_len <= 4.5
  CONDITION: d_is_longest <= 0.5
  CONDITION: hcp > 14.5
  CONDITION: total_points > 17.5
  CONDITION: hcp > 19.5
  CONDITION: hcp > 21.5
  CONDITION: hcp > 24.5
  # distilled from Brill /bid

RULE BD_True_P150:
  CALL: 1D
  PRIORITY: 10
  CONDITION: is_opening == True
  CONDITION: hcp > 11.5
  CONDITION: spade_len <= 4.5
  CONDITION: heart_len <= 4.5
  CONDITION: d_is_longest > 0.5
  CONDITION: hcp <= 14.5
  CONDITION: diamond_len <= 6.5
  # distilled from Brill /bid

RULE BD_True_P151:
  CALL: 1D
  PRIORITY: 10
  CONDITION: is_opening == True
  CONDITION: hcp > 11.5
  CONDITION: spade_len <= 4.5
  CONDITION: heart_len <= 4.5
  CONDITION: d_is_longest > 0.5
  CONDITION: hcp <= 14.5
  CONDITION: diamond_len > 6.5
  CONDITION: auction_len <= 2.5
  # distilled from Brill /bid

RULE BD_True_P152:
  CALL: 3D
  PRIORITY: 10
  CONDITION: is_opening == True
  CONDITION: hcp > 11.5
  CONDITION: spade_len <= 4.5
  CONDITION: heart_len <= 4.5
  CONDITION: d_is_longest > 0.5
  CONDITION: hcp <= 14.5
  CONDITION: diamond_len > 6.5
  CONDITION: auction_len > 2.5
  CONDITION: hcp <= 12.5
  CONDITION: heart_hcp <= 1.5
  # distilled from Brill /bid

RULE BD_True_P153:
  CALL: 4D
  PRIORITY: 10
  CONDITION: is_opening == True
  CONDITION: hcp > 11.5
  CONDITION: spade_len <= 4.5
  CONDITION: heart_len <= 4.5
  CONDITION: d_is_longest > 0.5
  CONDITION: hcp <= 14.5
  CONDITION: diamond_len > 6.5
  CONDITION: auction_len > 2.5
  CONDITION: hcp <= 12.5
  CONDITION: heart_hcp > 1.5
  # distilled from Brill /bid

RULE BD_True_P154:
  CALL: 1D
  PRIORITY: 10
  CONDITION: is_opening == True
  CONDITION: hcp > 11.5
  CONDITION: spade_len <= 4.5
  CONDITION: heart_len <= 4.5
  CONDITION: d_is_longest > 0.5
  CONDITION: hcp <= 14.5
  CONDITION: diamond_len > 6.5
  CONDITION: auction_len > 2.5
  CONDITION: hcp > 12.5
  # distilled from Brill /bid

RULE BD_True_P155:
  CALL: 1D
  PRIORITY: 10
  CONDITION: is_opening == True
  CONDITION: hcp > 11.5
  CONDITION: spade_len <= 4.5
  CONDITION: heart_len <= 4.5
  CONDITION: d_is_longest > 0.5
  CONDITION: hcp > 14.5
  CONDITION: total_points <= 17.5
  CONDITION: is_semi_balanced <= 0.5
  # distilled from Brill /bid

RULE BD_True_P156:
  CALL: 1NT
  PRIORITY: 10
  CONDITION: is_opening == True
  CONDITION: hcp > 11.5
  CONDITION: spade_len <= 4.5
  CONDITION: heart_len <= 4.5
  CONDITION: d_is_longest > 0.5
  CONDITION: hcp > 14.5
  CONDITION: total_points <= 17.5
  CONDITION: is_semi_balanced > 0.5
  # distilled from Brill /bid

RULE BD_True_P157:
  CALL: 1D
  PRIORITY: 10
  CONDITION: is_opening == True
  CONDITION: hcp > 11.5
  CONDITION: spade_len <= 4.5
  CONDITION: heart_len <= 4.5
  CONDITION: d_is_longest > 0.5
  CONDITION: hcp > 14.5
  CONDITION: total_points > 17.5
  CONDITION: hcp <= 19.5
  CONDITION: hcp <= 17.5
  CONDITION: is_semi_balanced <= 0.5
  CONDITION: total_points <= 20.5
  # distilled from Brill /bid

RULE BD_True_P158:
  CALL: 2C
  PRIORITY: 10
  CONDITION: is_opening == True
  CONDITION: hcp > 11.5
  CONDITION: spade_len <= 4.5
  CONDITION: heart_len <= 4.5
  CONDITION: d_is_longest > 0.5
  CONDITION: hcp > 14.5
  CONDITION: total_points > 17.5
  CONDITION: hcp <= 19.5
  CONDITION: hcp <= 17.5
  CONDITION: is_semi_balanced <= 0.5
  CONDITION: total_points > 20.5
  # distilled from Brill /bid

RULE BD_True_P159:
  CALL: 1NT
  PRIORITY: 10
  CONDITION: is_opening == True
  CONDITION: hcp > 11.5
  CONDITION: spade_len <= 4.5
  CONDITION: heart_len <= 4.5
  CONDITION: d_is_longest > 0.5
  CONDITION: hcp > 14.5
  CONDITION: total_points > 17.5
  CONDITION: hcp <= 19.5
  CONDITION: hcp <= 17.5
  CONDITION: is_semi_balanced > 0.5
  # distilled from Brill /bid

RULE BD_True_P160:
  CALL: 1D
  PRIORITY: 10
  CONDITION: is_opening == True
  CONDITION: hcp > 11.5
  CONDITION: spade_len <= 4.5
  CONDITION: heart_len <= 4.5
  CONDITION: d_is_longest > 0.5
  CONDITION: hcp > 14.5
  CONDITION: total_points > 17.5
  CONDITION: hcp <= 19.5
  CONDITION: hcp > 17.5
  # distilled from Brill /bid

RULE BD_True_P161:
  CALL: 1D
  PRIORITY: 10
  CONDITION: is_opening == True
  CONDITION: hcp > 11.5
  CONDITION: spade_len <= 4.5
  CONDITION: heart_len <= 4.5
  CONDITION: d_is_longest > 0.5
  CONDITION: hcp > 14.5
  CONDITION: total_points > 17.5
  CONDITION: hcp > 19.5
  CONDITION: hcp <= 21.5
  CONDITION: is_semi_balanced <= 0.5
  CONDITION: losing_trick_count <= 3.5
  # distilled from Brill /bid

RULE BD_True_P162:
  CALL: 2NT
  PRIORITY: 10
  CONDITION: is_opening == True
  CONDITION: hcp > 11.5
  CONDITION: spade_len <= 4.5
  CONDITION: heart_len <= 4.5
  CONDITION: d_is_longest > 0.5
  CONDITION: hcp > 14.5
  CONDITION: total_points > 17.5
  CONDITION: hcp > 19.5
  CONDITION: hcp <= 21.5
  CONDITION: is_semi_balanced <= 0.5
  CONDITION: losing_trick_count > 3.5
  # distilled from Brill /bid

RULE BD_True_P163:
  CALL: 2NT
  PRIORITY: 10
  CONDITION: is_opening == True
  CONDITION: hcp > 11.5
  CONDITION: spade_len <= 4.5
  CONDITION: heart_len <= 4.5
  CONDITION: d_is_longest > 0.5
  CONDITION: hcp > 14.5
  CONDITION: total_points > 17.5
  CONDITION: hcp > 19.5
  CONDITION: hcp <= 21.5
  CONDITION: is_semi_balanced > 0.5
  # distilled from Brill /bid

RULE BD_True_P164:
  CALL: 2C
  PRIORITY: 10
  CONDITION: is_opening == True
  CONDITION: hcp > 11.5
  CONDITION: spade_len <= 4.5
  CONDITION: heart_len <= 4.5
  CONDITION: d_is_longest > 0.5
  CONDITION: hcp > 14.5
  CONDITION: total_points > 17.5
  CONDITION: hcp > 19.5
  CONDITION: hcp > 21.5
  CONDITION: hcp <= 24.5
  # distilled from Brill /bid

RULE BD_True_P165:
  CALL: 3NT
  PRIORITY: 10
  CONDITION: is_opening == True
  CONDITION: hcp > 11.5
  CONDITION: spade_len <= 4.5
  CONDITION: heart_len <= 4.5
  CONDITION: d_is_longest > 0.5
  CONDITION: hcp > 14.5
  CONDITION: total_points > 17.5
  CONDITION: hcp > 19.5
  CONDITION: hcp > 21.5
  CONDITION: hcp > 24.5
  # distilled from Brill /bid

RULE BD_True_P166:
  CALL: 1H
  PRIORITY: 10
  CONDITION: is_opening == True
  CONDITION: hcp > 11.5
  CONDITION: spade_len <= 4.5
  CONDITION: heart_len > 4.5
  CONDITION: hcp <= 19.5
  CONDITION: shape_pattern == '5332'
  CONDITION: hcp <= 14.5
  # distilled from Brill /bid

RULE BD_True_P167:
  CALL: 1NT
  PRIORITY: 10
  CONDITION: is_opening == True
  CONDITION: hcp > 11.5
  CONDITION: spade_len <= 4.5
  CONDITION: heart_len > 4.5
  CONDITION: hcp <= 19.5
  CONDITION: shape_pattern == '5332'
  CONDITION: hcp > 14.5
  CONDITION: hcp <= 16.5
  # distilled from Brill /bid

RULE BD_True_P168:
  CALL: 1H
  PRIORITY: 10
  CONDITION: is_opening == True
  CONDITION: hcp > 11.5
  CONDITION: spade_len <= 4.5
  CONDITION: heart_len > 4.5
  CONDITION: hcp <= 19.5
  CONDITION: shape_pattern == '5332'
  CONDITION: hcp > 14.5
  CONDITION: hcp > 16.5
  # distilled from Brill /bid

RULE BD_True_P169:
  CALL: 1D
  PRIORITY: 10
  CONDITION: is_opening == True
  CONDITION: hcp > 11.5
  CONDITION: spade_len <= 4.5
  CONDITION: heart_len > 4.5
  CONDITION: hcp <= 19.5
  CONDITION: shape_pattern != '5332'
  CONDITION: h_is_longest <= 0.5
  CONDITION: club_hcp <= 4.5
  CONDITION: heart_hcp <= 8.0
  # distilled from Brill /bid

RULE BD_True_P170:
  CALL: 2C
  PRIORITY: 10
  CONDITION: is_opening == True
  CONDITION: hcp > 11.5
  CONDITION: spade_len <= 4.5
  CONDITION: heart_len > 4.5
  CONDITION: hcp <= 19.5
  CONDITION: shape_pattern != '5332'
  CONDITION: h_is_longest <= 0.5
  CONDITION: club_hcp <= 4.5
  CONDITION: heart_hcp > 8.0
  # distilled from Brill /bid

RULE BD_True_P171:
  CALL: 1C
  PRIORITY: 10
  CONDITION: is_opening == True
  CONDITION: hcp > 11.5
  CONDITION: spade_len <= 4.5
  CONDITION: heart_len > 4.5
  CONDITION: hcp <= 19.5
  CONDITION: shape_pattern != '5332'
  CONDITION: h_is_longest <= 0.5
  CONDITION: club_hcp > 4.5
  CONDITION: club_len <= 6.5
  # distilled from Brill /bid

RULE BD_True_P172:
  CALL: 2C
  PRIORITY: 10
  CONDITION: is_opening == True
  CONDITION: hcp > 11.5
  CONDITION: spade_len <= 4.5
  CONDITION: heart_len > 4.5
  CONDITION: hcp <= 19.5
  CONDITION: shape_pattern != '5332'
  CONDITION: h_is_longest <= 0.5
  CONDITION: club_hcp > 4.5
  CONDITION: club_len > 6.5
  # distilled from Brill /bid

RULE BD_True_P173:
  CALL: 1H
  PRIORITY: 10
  CONDITION: is_opening == True
  CONDITION: hcp > 11.5
  CONDITION: spade_len <= 4.5
  CONDITION: heart_len > 4.5
  CONDITION: hcp <= 19.5
  CONDITION: shape_pattern != '5332'
  CONDITION: h_is_longest > 0.5
  CONDITION: losing_trick_count <= 3.5
  CONDITION: hcp <= 17.5
  # distilled from Brill /bid

RULE BD_True_P174:
  CALL: 1H
  PRIORITY: 10
  CONDITION: is_opening == True
  CONDITION: hcp > 11.5
  CONDITION: spade_len <= 4.5
  CONDITION: heart_len > 4.5
  CONDITION: hcp <= 19.5
  CONDITION: shape_pattern != '5332'
  CONDITION: h_is_longest > 0.5
  CONDITION: losing_trick_count <= 3.5
  CONDITION: hcp > 17.5
  CONDITION: minor_hcp <= 9.5
  CONDITION: heart_len <= 5.5
  # distilled from Brill /bid

RULE BD_True_P175:
  CALL: 2C
  PRIORITY: 10
  CONDITION: is_opening == True
  CONDITION: hcp > 11.5
  CONDITION: spade_len <= 4.5
  CONDITION: heart_len > 4.5
  CONDITION: hcp <= 19.5
  CONDITION: shape_pattern != '5332'
  CONDITION: h_is_longest > 0.5
  CONDITION: losing_trick_count <= 3.5
  CONDITION: hcp > 17.5
  CONDITION: minor_hcp <= 9.5
  CONDITION: heart_len > 5.5
  # distilled from Brill /bid

RULE BD_True_P176:
  CALL: 1H
  PRIORITY: 10
  CONDITION: is_opening == True
  CONDITION: hcp > 11.5
  CONDITION: spade_len <= 4.5
  CONDITION: heart_len > 4.5
  CONDITION: hcp <= 19.5
  CONDITION: shape_pattern != '5332'
  CONDITION: h_is_longest > 0.5
  CONDITION: losing_trick_count <= 3.5
  CONDITION: hcp > 17.5
  CONDITION: minor_hcp > 9.5
  # distilled from Brill /bid

RULE BD_True_P177:
  CALL: 1H
  PRIORITY: 10
  CONDITION: is_opening == True
  CONDITION: hcp > 11.5
  CONDITION: spade_len <= 4.5
  CONDITION: heart_len > 4.5
  CONDITION: hcp <= 19.5
  CONDITION: shape_pattern != '5332'
  CONDITION: h_is_longest > 0.5
  CONDITION: losing_trick_count > 3.5
  CONDITION: auction_len <= 2.5
  # distilled from Brill /bid

RULE BD_True_P178:
  CALL: 1H
  PRIORITY: 10
  CONDITION: is_opening == True
  CONDITION: hcp > 11.5
  CONDITION: spade_len <= 4.5
  CONDITION: heart_len > 4.5
  CONDITION: hcp <= 19.5
  CONDITION: shape_pattern != '5332'
  CONDITION: h_is_longest > 0.5
  CONDITION: losing_trick_count > 3.5
  CONDITION: auction_len > 2.5
  CONDITION: hcp <= 12.5
  CONDITION: heart_len <= 5.5
  # distilled from Brill /bid

RULE BD_True_P179:
  CALL: 2H
  PRIORITY: 10
  CONDITION: is_opening == True
  CONDITION: hcp > 11.5
  CONDITION: spade_len <= 4.5
  CONDITION: heart_len > 4.5
  CONDITION: hcp <= 19.5
  CONDITION: shape_pattern != '5332'
  CONDITION: h_is_longest > 0.5
  CONDITION: losing_trick_count > 3.5
  CONDITION: auction_len > 2.5
  CONDITION: hcp <= 12.5
  CONDITION: heart_len > 5.5
  # distilled from Brill /bid

RULE BD_True_P180:
  CALL: 1H
  PRIORITY: 10
  CONDITION: is_opening == True
  CONDITION: hcp > 11.5
  CONDITION: spade_len <= 4.5
  CONDITION: heart_len > 4.5
  CONDITION: hcp <= 19.5
  CONDITION: shape_pattern != '5332'
  CONDITION: h_is_longest > 0.5
  CONDITION: losing_trick_count > 3.5
  CONDITION: auction_len > 2.5
  CONDITION: hcp > 12.5
  CONDITION: heart_len <= 7.5
  # distilled from Brill /bid

RULE BD_True_P181:
  CALL: 4H
  PRIORITY: 10
  CONDITION: is_opening == True
  CONDITION: hcp > 11.5
  CONDITION: spade_len <= 4.5
  CONDITION: heart_len > 4.5
  CONDITION: hcp <= 19.5
  CONDITION: shape_pattern != '5332'
  CONDITION: h_is_longest > 0.5
  CONDITION: losing_trick_count > 3.5
  CONDITION: auction_len > 2.5
  CONDITION: hcp > 12.5
  CONDITION: heart_len > 7.5
  # distilled from Brill /bid

RULE BD_True_P182:
  CALL: 1H
  PRIORITY: 10
  CONDITION: is_opening == True
  CONDITION: hcp > 11.5
  CONDITION: spade_len <= 4.5
  CONDITION: heart_len > 4.5
  CONDITION: hcp > 19.5
  CONDITION: hcp <= 21.5
  CONDITION: shortest_suit_len <= 1.5
  CONDITION: heart_len <= 5.5
  CONDITION: club_hcp <= 8.5
  # distilled from Brill /bid

RULE BD_True_P183:
  CALL: 2C
  PRIORITY: 10
  CONDITION: is_opening == True
  CONDITION: hcp > 11.5
  CONDITION: spade_len <= 4.5
  CONDITION: heart_len > 4.5
  CONDITION: hcp > 19.5
  CONDITION: hcp <= 21.5
  CONDITION: shortest_suit_len <= 1.5
  CONDITION: heart_len <= 5.5
  CONDITION: club_hcp > 8.5
  # distilled from Brill /bid

RULE BD_True_P184:
  CALL: 2C
  PRIORITY: 10
  CONDITION: is_opening == True
  CONDITION: hcp > 11.5
  CONDITION: spade_len <= 4.5
  CONDITION: heart_len > 4.5
  CONDITION: hcp > 19.5
  CONDITION: hcp <= 21.5
  CONDITION: shortest_suit_len <= 1.5
  CONDITION: heart_len > 5.5
  CONDITION: king_count <= 2.5
  # distilled from Brill /bid

RULE BD_True_P185:
  CALL: 1H
  PRIORITY: 10
  CONDITION: is_opening == True
  CONDITION: hcp > 11.5
  CONDITION: spade_len <= 4.5
  CONDITION: heart_len > 4.5
  CONDITION: hcp > 19.5
  CONDITION: hcp <= 21.5
  CONDITION: shortest_suit_len <= 1.5
  CONDITION: heart_len > 5.5
  CONDITION: king_count > 2.5
  # distilled from Brill /bid

RULE BD_True_P186:
  CALL: 2NT
  PRIORITY: 10
  CONDITION: is_opening == True
  CONDITION: hcp > 11.5
  CONDITION: spade_len <= 4.5
  CONDITION: heart_len > 4.5
  CONDITION: hcp > 19.5
  CONDITION: hcp <= 21.5
  CONDITION: shortest_suit_len > 1.5
  CONDITION: heart_len <= 5.5
  # distilled from Brill /bid

RULE BD_True_P187:
  CALL: 1H
  PRIORITY: 10
  CONDITION: is_opening == True
  CONDITION: hcp > 11.5
  CONDITION: spade_len <= 4.5
  CONDITION: heart_len > 4.5
  CONDITION: hcp > 19.5
  CONDITION: hcp <= 21.5
  CONDITION: shortest_suit_len > 1.5
  CONDITION: heart_len > 5.5
  CONDITION: vuln_pressure == 'equal'
  # distilled from Brill /bid

RULE BD_True_P188:
  CALL: 2NT
  PRIORITY: 10
  CONDITION: is_opening == True
  CONDITION: hcp > 11.5
  CONDITION: spade_len <= 4.5
  CONDITION: heart_len > 4.5
  CONDITION: hcp > 19.5
  CONDITION: hcp <= 21.5
  CONDITION: shortest_suit_len > 1.5
  CONDITION: heart_len > 5.5
  CONDITION: vuln_pressure != 'equal'
  CONDITION: major_hcp <= 11.5
  # distilled from Brill /bid

RULE BD_True_P189:
  CALL: 2C
  PRIORITY: 10
  CONDITION: is_opening == True
  CONDITION: hcp > 11.5
  CONDITION: spade_len <= 4.5
  CONDITION: heart_len > 4.5
  CONDITION: hcp > 19.5
  CONDITION: hcp <= 21.5
  CONDITION: shortest_suit_len > 1.5
  CONDITION: heart_len > 5.5
  CONDITION: vuln_pressure != 'equal'
  CONDITION: major_hcp > 11.5
  # distilled from Brill /bid

RULE BD_True_P190:
  CALL: 2C
  PRIORITY: 10
  CONDITION: is_opening == True
  CONDITION: hcp > 11.5
  CONDITION: spade_len <= 4.5
  CONDITION: heart_len > 4.5
  CONDITION: hcp > 19.5
  CONDITION: hcp > 21.5
  # distilled from Brill /bid

RULE BD_True_P191:
  CALL: 1C
  PRIORITY: 10
  CONDITION: is_opening == True
  CONDITION: hcp > 11.5
  CONDITION: spade_len > 4.5
  CONDITION: hcp <= 19.5
  CONDITION: s_is_longest <= 0.5
  CONDITION: heart_len <= 4.0
  CONDITION: diamond_len <= 4.0
  # distilled from Brill /bid

RULE BD_True_P192:
  CALL: 1D
  PRIORITY: 10
  CONDITION: is_opening == True
  CONDITION: hcp > 11.5
  CONDITION: spade_len > 4.5
  CONDITION: hcp <= 19.5
  CONDITION: s_is_longest <= 0.5
  CONDITION: heart_len <= 4.0
  CONDITION: diamond_len > 4.0
  # distilled from Brill /bid

RULE BD_True_P193:
  CALL: 1H
  PRIORITY: 10
  CONDITION: is_opening == True
  CONDITION: hcp > 11.5
  CONDITION: spade_len > 4.5
  CONDITION: hcp <= 19.5
  CONDITION: s_is_longest <= 0.5
  CONDITION: heart_len > 4.0
  # distilled from Brill /bid

RULE BD_True_P194:
  CALL: 1S
  PRIORITY: 10
  CONDITION: is_opening == True
  CONDITION: hcp > 11.5
  CONDITION: spade_len > 4.5
  CONDITION: hcp <= 19.5
  CONDITION: s_is_longest > 0.5
  CONDITION: shape_pattern == '5332'
  CONDITION: hcp <= 14.5
  # distilled from Brill /bid

RULE BD_True_P195:
  CALL: 1NT
  PRIORITY: 10
  CONDITION: is_opening == True
  CONDITION: hcp > 11.5
  CONDITION: spade_len > 4.5
  CONDITION: hcp <= 19.5
  CONDITION: s_is_longest > 0.5
  CONDITION: shape_pattern == '5332'
  CONDITION: hcp > 14.5
  CONDITION: hcp <= 16.5
  # distilled from Brill /bid

RULE BD_True_P196:
  CALL: 1S
  PRIORITY: 10
  CONDITION: is_opening == True
  CONDITION: hcp > 11.5
  CONDITION: spade_len > 4.5
  CONDITION: hcp <= 19.5
  CONDITION: s_is_longest > 0.5
  CONDITION: shape_pattern == '5332'
  CONDITION: hcp > 14.5
  CONDITION: hcp > 16.5
  # distilled from Brill /bid

RULE BD_True_P197:
  CALL: 2C
  PRIORITY: 10
  CONDITION: is_opening == True
  CONDITION: hcp > 11.5
  CONDITION: spade_len > 4.5
  CONDITION: hcp <= 19.5
  CONDITION: s_is_longest > 0.5
  CONDITION: shape_pattern != '5332'
  CONDITION: losing_trick_count <= 3.5
  CONDITION: losing_trick_count <= 2.5
  # distilled from Brill /bid

RULE BD_True_P198:
  CALL: 2C
  PRIORITY: 10
  CONDITION: is_opening == True
  CONDITION: hcp > 11.5
  CONDITION: spade_len > 4.5
  CONDITION: hcp <= 19.5
  CONDITION: s_is_longest > 0.5
  CONDITION: shape_pattern != '5332'
  CONDITION: losing_trick_count <= 3.5
  CONDITION: losing_trick_count > 2.5
  CONDITION: shape_pattern == '6421'
  # distilled from Brill /bid

RULE BD_True_P199:
  CALL: 2C
  PRIORITY: 10
  CONDITION: is_opening == True
  CONDITION: hcp > 11.5
  CONDITION: spade_len > 4.5
  CONDITION: hcp <= 19.5
  CONDITION: s_is_longest > 0.5
  CONDITION: shape_pattern != '5332'
  CONDITION: losing_trick_count <= 3.5
  CONDITION: losing_trick_count > 2.5
  CONDITION: shape_pattern != '6421'
  CONDITION: shape_pattern == '7321'
  # distilled from Brill /bid

RULE BD_True_P200:
  CALL: 1S
  PRIORITY: 10
  CONDITION: is_opening == True
  CONDITION: hcp > 11.5
  CONDITION: spade_len > 4.5
  CONDITION: hcp <= 19.5
  CONDITION: s_is_longest > 0.5
  CONDITION: shape_pattern != '5332'
  CONDITION: losing_trick_count <= 3.5
  CONDITION: losing_trick_count > 2.5
  CONDITION: shape_pattern != '6421'
  CONDITION: shape_pattern != '7321'
  CONDITION: auction_len <= 2.5
  # distilled from Brill /bid

RULE BD_True_P201:
  CALL: 1S
  PRIORITY: 10
  CONDITION: is_opening == True
  CONDITION: hcp > 11.5
  CONDITION: spade_len > 4.5
  CONDITION: hcp <= 19.5
  CONDITION: s_is_longest > 0.5
  CONDITION: shape_pattern != '5332'
  CONDITION: losing_trick_count <= 3.5
  CONDITION: losing_trick_count > 2.5
  CONDITION: shape_pattern != '6421'
  CONDITION: shape_pattern != '7321'
  CONDITION: auction_len > 2.5
  # distilled from Brill /bid

RULE BD_True_P202:
  CALL: 1S
  PRIORITY: 10
  CONDITION: is_opening == True
  CONDITION: hcp > 11.5
  CONDITION: spade_len > 4.5
  CONDITION: hcp <= 19.5
  CONDITION: s_is_longest > 0.5
  CONDITION: shape_pattern != '5332'
  CONDITION: losing_trick_count > 3.5
  CONDITION: auction_len <= 2.5
  CONDITION: shape_pattern == '7321'
  CONDITION: controls <= 6.5
  # distilled from Brill /bid

RULE BD_True_P203:
  CALL: 2C
  PRIORITY: 10
  CONDITION: is_opening == True
  CONDITION: hcp > 11.5
  CONDITION: spade_len > 4.5
  CONDITION: hcp <= 19.5
  CONDITION: s_is_longest > 0.5
  CONDITION: shape_pattern != '5332'
  CONDITION: losing_trick_count > 3.5
  CONDITION: auction_len <= 2.5
  CONDITION: shape_pattern == '7321'
  CONDITION: controls > 6.5
  CONDITION: minor_hcp <= 7.5
  # distilled from Brill /bid

RULE BD_True_P204:
  CALL: 1S
  PRIORITY: 10
  CONDITION: is_opening == True
  CONDITION: hcp > 11.5
  CONDITION: spade_len > 4.5
  CONDITION: hcp <= 19.5
  CONDITION: s_is_longest > 0.5
  CONDITION: shape_pattern != '5332'
  CONDITION: losing_trick_count > 3.5
  CONDITION: auction_len <= 2.5
  CONDITION: shape_pattern == '7321'
  CONDITION: controls > 6.5
  CONDITION: minor_hcp > 7.5
  # distilled from Brill /bid

RULE BD_True_P205:
  CALL: 1S
  PRIORITY: 10
  CONDITION: is_opening == True
  CONDITION: hcp > 11.5
  CONDITION: spade_len > 4.5
  CONDITION: hcp <= 19.5
  CONDITION: s_is_longest > 0.5
  CONDITION: shape_pattern != '5332'
  CONDITION: losing_trick_count > 3.5
  CONDITION: auction_len <= 2.5
  CONDITION: shape_pattern != '7321'
  # distilled from Brill /bid

RULE BD_True_P206:
  CALL: 1S
  PRIORITY: 10
  CONDITION: is_opening == True
  CONDITION: hcp > 11.5
  CONDITION: spade_len > 4.5
  CONDITION: hcp <= 19.5
  CONDITION: s_is_longest > 0.5
  CONDITION: shape_pattern != '5332'
  CONDITION: losing_trick_count > 3.5
  CONDITION: auction_len > 2.5
  CONDITION: hcp <= 12.5
  CONDITION: spade_len <= 5.5
  # distilled from Brill /bid

RULE BD_True_P207:
  CALL: 2S
  PRIORITY: 10
  CONDITION: is_opening == True
  CONDITION: hcp > 11.5
  CONDITION: spade_len > 4.5
  CONDITION: hcp <= 19.5
  CONDITION: s_is_longest > 0.5
  CONDITION: shape_pattern != '5332'
  CONDITION: losing_trick_count > 3.5
  CONDITION: auction_len > 2.5
  CONDITION: hcp <= 12.5
  CONDITION: spade_len > 5.5
  # distilled from Brill /bid

RULE BD_True_P208:
  CALL: 1S
  PRIORITY: 10
  CONDITION: is_opening == True
  CONDITION: hcp > 11.5
  CONDITION: spade_len > 4.5
  CONDITION: hcp <= 19.5
  CONDITION: s_is_longest > 0.5
  CONDITION: shape_pattern != '5332'
  CONDITION: losing_trick_count > 3.5
  CONDITION: auction_len > 2.5
  CONDITION: hcp > 12.5
  # distilled from Brill /bid

RULE BD_True_P209:
  CALL: 1S
  PRIORITY: 10
  CONDITION: is_opening == True
  CONDITION: hcp > 11.5
  CONDITION: spade_len > 4.5
  CONDITION: hcp > 19.5
  CONDITION: hcp <= 21.5
  CONDITION: is_semi_balanced <= 0.5
  CONDITION: spade_len <= 5.5
  CONDITION: quick_tricks <= 4.25
  CONDITION: club_hcp <= 3.5
  # distilled from Brill /bid

RULE BD_True_P210:
  CALL: 2NT
  PRIORITY: 10
  CONDITION: is_opening == True
  CONDITION: hcp > 11.5
  CONDITION: spade_len > 4.5
  CONDITION: hcp > 19.5
  CONDITION: hcp <= 21.5
  CONDITION: is_semi_balanced <= 0.5
  CONDITION: spade_len <= 5.5
  CONDITION: quick_tricks <= 4.25
  CONDITION: club_hcp > 3.5
  # distilled from Brill /bid

RULE BD_True_P211:
  CALL: 1S
  PRIORITY: 10
  CONDITION: is_opening == True
  CONDITION: hcp > 11.5
  CONDITION: spade_len > 4.5
  CONDITION: hcp > 19.5
  CONDITION: hcp <= 21.5
  CONDITION: is_semi_balanced <= 0.5
  CONDITION: spade_len <= 5.5
  CONDITION: quick_tricks > 4.25
  # distilled from Brill /bid

RULE BD_True_P212:
  CALL: 2C
  PRIORITY: 10
  CONDITION: is_opening == True
  CONDITION: hcp > 11.5
  CONDITION: spade_len > 4.5
  CONDITION: hcp > 19.5
  CONDITION: hcp <= 21.5
  CONDITION: is_semi_balanced <= 0.5
  CONDITION: spade_len > 5.5
  CONDITION: losing_trick_count <= 3.5
  # distilled from Brill /bid

RULE BD_True_P213:
  CALL: 2C
  PRIORITY: 10
  CONDITION: is_opening == True
  CONDITION: hcp > 11.5
  CONDITION: spade_len > 4.5
  CONDITION: hcp > 19.5
  CONDITION: hcp <= 21.5
  CONDITION: is_semi_balanced <= 0.5
  CONDITION: spade_len > 5.5
  CONDITION: losing_trick_count > 3.5
  CONDITION: diamond_len <= 2.5
  # distilled from Brill /bid

RULE BD_True_P214:
  CALL: 1S
  PRIORITY: 10
  CONDITION: is_opening == True
  CONDITION: hcp > 11.5
  CONDITION: spade_len > 4.5
  CONDITION: hcp > 19.5
  CONDITION: hcp <= 21.5
  CONDITION: is_semi_balanced <= 0.5
  CONDITION: spade_len > 5.5
  CONDITION: losing_trick_count > 3.5
  CONDITION: diamond_len > 2.5
  # distilled from Brill /bid

RULE BD_True_P215:
  CALL: 2NT
  PRIORITY: 10
  CONDITION: is_opening == True
  CONDITION: hcp > 11.5
  CONDITION: spade_len > 4.5
  CONDITION: hcp > 19.5
  CONDITION: hcp <= 21.5
  CONDITION: is_semi_balanced > 0.5
  CONDITION: spade_len <= 5.5
  # distilled from Brill /bid

RULE BD_True_P216:
  CALL: 2C
  PRIORITY: 10
  CONDITION: is_opening == True
  CONDITION: hcp > 11.5
  CONDITION: spade_len > 4.5
  CONDITION: hcp > 19.5
  CONDITION: hcp <= 21.5
  CONDITION: is_semi_balanced > 0.5
  CONDITION: spade_len > 5.5
  CONDITION: losing_trick_count <= 4.5
  CONDITION: controls <= 7.5
  # distilled from Brill /bid

RULE BD_True_P217:
  CALL: 2C
  PRIORITY: 10
  CONDITION: is_opening == True
  CONDITION: hcp > 11.5
  CONDITION: spade_len > 4.5
  CONDITION: hcp > 19.5
  CONDITION: hcp <= 21.5
  CONDITION: is_semi_balanced > 0.5
  CONDITION: spade_len > 5.5
  CONDITION: losing_trick_count <= 4.5
  CONDITION: controls > 7.5
  CONDITION: major_hcp <= 8.5
  # distilled from Brill /bid

RULE BD_True_P218:
  CALL: 2NT
  PRIORITY: 10
  CONDITION: is_opening == True
  CONDITION: hcp > 11.5
  CONDITION: spade_len > 4.5
  CONDITION: hcp > 19.5
  CONDITION: hcp <= 21.5
  CONDITION: is_semi_balanced > 0.5
  CONDITION: spade_len > 5.5
  CONDITION: losing_trick_count <= 4.5
  CONDITION: controls > 7.5
  CONDITION: major_hcp > 8.5
  # distilled from Brill /bid

RULE BD_True_P219:
  CALL: 1S
  PRIORITY: 10
  CONDITION: is_opening == True
  CONDITION: hcp > 11.5
  CONDITION: spade_len > 4.5
  CONDITION: hcp > 19.5
  CONDITION: hcp <= 21.5
  CONDITION: is_semi_balanced > 0.5
  CONDITION: spade_len > 5.5
  CONDITION: losing_trick_count > 4.5
  CONDITION: ace_count <= 3.5
  # distilled from Brill /bid

RULE BD_True_P220:
  CALL: 2NT
  PRIORITY: 10
  CONDITION: is_opening == True
  CONDITION: hcp > 11.5
  CONDITION: spade_len > 4.5
  CONDITION: hcp > 19.5
  CONDITION: hcp <= 21.5
  CONDITION: is_semi_balanced > 0.5
  CONDITION: spade_len > 5.5
  CONDITION: losing_trick_count > 4.5
  CONDITION: ace_count > 3.5
  # distilled from Brill /bid

RULE BD_True_P221:
  CALL: 2C
  PRIORITY: 10
  CONDITION: is_opening == True
  CONDITION: hcp > 11.5
  CONDITION: spade_len > 4.5
  CONDITION: hcp > 19.5
  CONDITION: hcp > 21.5
  # distilled from Brill /bid
