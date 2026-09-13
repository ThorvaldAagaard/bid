# ==========================================
# IMPROVED BIDDING SYSTEM: id3_fixture
# Generated via Continuous Self-Improvement Pipeline
# ==========================================

# --- Active Rules & Conventions ---

RULE R_1NT:
  CALL: 1NT
  PRIORITY: 10
  CONDITION: hcp >= 15
  CONDITION: hcp <= 17
  CONDITION: is_balanced == True

RULE R_1H:
  CALL: 1H
  PRIORITY: 10
  CONDITION: hcp >= 12
  CONDITION: hcp <= 21
  CONDITION: heart_len >= 5


# --- Refined ID3 Exception Trees (Speedup Learning Splits) ---

INTERSECTION R_1H ^ R_1NT:
  TREE:
    SPLIT hcp <= 16.5 fallback 1H
      LEAF 1H
      LEAF 1NT
