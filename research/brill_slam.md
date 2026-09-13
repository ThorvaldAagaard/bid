# Brill — the 4NT layer (keycard responses)

> Targeted capture of `system/brill.md`'s one missing layer: partner's
> answer to our 4NT ask, which sits at `<prefix>-4N-P-*` — one call
> deeper than the 2-call sweep in `research/fetch_brill.py`.
>
> - **Source:** `GET https://brillservice.aalborgdata.dk/getresponses?auction=<seq>`
> - **Scope:** every auction prefix in `system/brill.md`, extended by `4N-P`
> - **Result:** 217 positions define calls — **148 keycard (RKCB 0314)**, 69 quantitative/other
> - **Regenerate:** `python3 research/fetch_brill_slam.py`

## Why this layer is the interesting one

Brill's *asking* rules are useless to us: they are gated on engine-internal
verdicts (`CanAsk_H_RKC`, `CanBid6_*`) that Brill never publishes, so they
do not survive translation (§6.40). The *answers* are different — they are
pure hand tests, and they spell out Roman Keycard Blackwood 0314:

| Response | Means |
|---|---|
| 5♣ | 0 or 3 keycards |
| 5♦ | 1 or 4 keycards |
| 5♥ | 2 or 5 keycards, no trump queen |
| 5♠ | 2 or 5 keycards, with trump queen |
| 5NT | 2 keycards and a void somewhere |
| 6x | 1 or 3 keycards and a void in suit x |

`havekeycards` counts the four aces **plus the king of trump**; `trumpqueen`
is whether the hand holds the queen of trump.

## What blocks an implementation

Not the scheme — that is fully captured below. The blocker is two features
that `bid/features.py` does not expose, and both need the same missing
piece of state: **which suit is trump.**

1. `havekeycards` — the repo's `keycard_count_1430` is currently just
   `ace_count`, so it is **off by one whenever the hand holds the trump
   king**. For a slam convention that is not a rounding error.
2. `trumpqueen` — no feature at all, and it cannot be written as a
   conjunction of `*_has_queen` booleans without knowing the trump suit.

Adding an `agreed_trump` feature (the auction-agreed strain, or `None`)
would unblock RKCB, Gerber and the Grand Slam Force together. Until then
this file is a spec, not something to convert.

---

## Keycard positions (RKCB 0314) — 148

### `1C-P-4N-P`

| Call | Requires |
|---|---|
| P | `(true)` |
| 5C | `(havekeycards == 0 or havekeycards == 3)` |
| 5D | `(havekeycards == 1 or havekeycards == 4)` |
| 5H | `((havekeycards == 2 or havekeycards == 5) and not trumpqueen)` |
| 5S | `((havekeycards == 2 or havekeycards == 5) and trumpqueen)` |
| 5N | `(havekeycards == 2 and (D == 0 or H == 0 or S == 0))` |

### `1C-X-4N-P`

| Call | Requires |
|---|---|
| P | `(true)` |
| 5C | `(havekeycards == 0 or havekeycards == 3)` |
| 5D | `(havekeycards == 1 or havekeycards == 4)` |
| 5H | `((havekeycards == 2 or havekeycards == 5) and not trumpqueen)` |
| 5S | `((havekeycards == 2 or havekeycards == 5) and trumpqueen)` |
| 5N | `(havekeycards == 2 and (D == 0 or H == 0 or S == 0))` |

### `1C-1D-4N-P`

| Call | Requires |
|---|---|
| P | `(true)` |
| 5C | `(havekeycards == 0 or havekeycards == 3)` |
| 5D | `(havekeycards == 1 or havekeycards == 4)` |
| 5H | `((havekeycards == 2 or havekeycards == 5) and not trumpqueen)` |
| 5S | `((havekeycards == 2 or havekeycards == 5) and trumpqueen)` |
| 5N | `(havekeycards == 2 and (D == 0 or H == 0 or S == 0))` |

### `1C-1H-4N-P`

| Call | Requires |
|---|---|
| P | `(true)` |
| 5C | `(havekeycards == 0 or havekeycards == 3)` |
| 5D | `(havekeycards == 1 or havekeycards == 4)` |
| 5H | `((havekeycards == 2 or havekeycards == 5) and not trumpqueen)` |
| 5S | `((havekeycards == 2 or havekeycards == 5) and trumpqueen)` |
| 5N | `(havekeycards == 2 and (D == 0 or H == 0 or S == 0))` |

### `1C-1S-4N-P`

| Call | Requires |
|---|---|
| P | `(true)` |
| 5C | `(havekeycards == 0 or havekeycards == 3)` |
| 5D | `(havekeycards == 1 or havekeycards == 4)` |
| 5H | `((havekeycards == 2 or havekeycards == 5) and not trumpqueen)` |
| 5S | `((havekeycards == 2 or havekeycards == 5) and trumpqueen)` |
| 5N | `(havekeycards == 2 and (D == 0 or H == 0 or S == 0))` |

### `1C-2C-4N-P`

| Call | Requires |
|---|---|
| P | `(true)` |
| 5C | `(havekeycards == 0 or havekeycards == 3)` |
| 5D | `(havekeycards == 1 or havekeycards == 4)` |
| 5H | `((havekeycards == 2 or havekeycards == 5) and not trumpqueen)` |
| 5S | `((havekeycards == 2 or havekeycards == 5) and trumpqueen)` |
| 5N | `(havekeycards == 2 and (D == 0 or H == 0 or S == 0))` |

### `1C-2D-4N-P`

| Call | Requires |
|---|---|
| P | `(true)` |
| 5C | `(havekeycards == 0 or havekeycards == 3)` |
| 5D | `(havekeycards == 1 or havekeycards == 4)` |
| 5H | `((havekeycards == 2 or havekeycards == 5) and not trumpqueen)` |
| 5S | `((havekeycards == 2 or havekeycards == 5) and trumpqueen)` |
| 5N | `(havekeycards == 2 and (D == 0 or H == 0 or S == 0))` |

### `1C-2H-4N-P`

| Call | Requires |
|---|---|
| P | `(true)` |
| 5C | `(havekeycards == 0 or havekeycards == 3)` |
| 5D | `(havekeycards == 1 or havekeycards == 4)` |
| 5H | `((havekeycards == 2 or havekeycards == 5) and not trumpqueen)` |
| 5S | `((havekeycards == 2 or havekeycards == 5) and trumpqueen)` |
| 5N | `(havekeycards == 2 and (D == 0 or H == 0 or S == 0))` |

### `1C-2S-4N-P`

| Call | Requires |
|---|---|
| P | `(true)` |
| 5C | `(havekeycards == 0 or havekeycards == 3)` |
| 5D | `(havekeycards == 1 or havekeycards == 4)` |
| 5H | `((havekeycards == 2 or havekeycards == 5) and not trumpqueen)` |
| 5S | `((havekeycards == 2 or havekeycards == 5) and trumpqueen)` |
| 5N | `(havekeycards == 2 and (D == 0 or H == 0 or S == 0))` |

### `1C-3C-4N-P`

| Call | Requires |
|---|---|
| P | `(true)` |
| 5C | `(havekeycards == 0 or havekeycards == 3)` |
| 5D | `(havekeycards == 1 or havekeycards == 4)` |
| 5H | `((havekeycards == 2 or havekeycards == 5) and not trumpqueen)` |
| 5S | `((havekeycards == 2 or havekeycards == 5) and trumpqueen)` |
| 5N | `(havekeycards == 2 and (D == 0 or H == 0 or S == 0))` |

### `1C-3D-4N-P`

| Call | Requires |
|---|---|
| P | `(true)` |
| 5C | `(havekeycards == 0 or havekeycards == 3)` |
| 5D | `(havekeycards == 1 or havekeycards == 4)` |
| 5H | `((havekeycards == 2 or havekeycards == 5) and not trumpqueen)` |
| 5S | `((havekeycards == 2 or havekeycards == 5) and trumpqueen)` |
| 5N | `(havekeycards == 2 and (D == 0 or H == 0 or S == 0))` |

### `1C-3H-4N-P`

| Call | Requires |
|---|---|
| P | `(true)` |
| 5C | `(havekeycards == 0 or havekeycards == 3)` |
| 5D | `(havekeycards == 1 or havekeycards == 4)` |
| 5H | `((havekeycards == 2 or havekeycards == 5) and not trumpqueen)` |
| 5S | `((havekeycards == 2 or havekeycards == 5) and trumpqueen)` |
| 5N | `(havekeycards == 2 and (D == 0 or H == 0 or S == 0))` |

### `1C-3S-4N-P`

| Call | Requires |
|---|---|
| P | `(true)` |
| 5C | `(havekeycards == 0 or havekeycards == 3)` |
| 5D | `(havekeycards == 1 or havekeycards == 4)` |
| 5H | `((havekeycards == 2 or havekeycards == 5) and not trumpqueen)` |
| 5S | `((havekeycards == 2 or havekeycards == 5) and trumpqueen)` |
| 5N | `(havekeycards == 2 and (D == 0 or H == 0 or S == 0))` |

### `1C-4D-4N-P`

| Call | Requires |
|---|---|
| P | `(true)` |
| 5C | `(havekeycards == 0 or havekeycards == 3)` |
| 5D | `(havekeycards == 1 or havekeycards == 4)` |
| 5H | `((havekeycards == 2 or havekeycards == 5) and not trumpqueen)` |
| 5S | `((havekeycards == 2 or havekeycards == 5) and trumpqueen)` |
| 5N | `(havekeycards == 2 and (D == 0 or H == 0 or S == 0))` |

### `1C-4H-4N-P`

| Call | Requires |
|---|---|
| P | `(true)` |
| 5C | `(havekeycards == 0 or havekeycards == 3)` |
| 5D | `(havekeycards == 1 or havekeycards == 4)` |
| 5H | `((havekeycards == 2 or havekeycards == 5) and not trumpqueen)` |
| 5S | `((havekeycards == 2 or havekeycards == 5) and trumpqueen)` |
| 5N | `(havekeycards == 2 and (D == 0 or H == 0 or S == 0))` |

### `1C-4S-4N-P`

| Call | Requires |
|---|---|
| P | `(true)` |
| 5C | `(havekeycards == 0 or havekeycards == 3)` |
| 5D | `(havekeycards == 1 or havekeycards == 4)` |
| 5H | `((havekeycards == 2 or havekeycards == 5) and not trumpqueen)` |
| 5S | `((havekeycards == 2 or havekeycards == 5) and trumpqueen)` |
| 5N | `(havekeycards == 2 and (D == 0 or H == 0 or S == 0))` |

### `1C-1N-4N-P`

| Call | Requires |
|---|---|
| P | `(true)` |
| 5C | `(havekeycards == 0 or havekeycards == 3)` |
| 5D | `(havekeycards == 1 or havekeycards == 4)` |
| 5H | `((havekeycards == 2 or havekeycards == 5) and not trumpqueen)` |
| 5S | `((havekeycards == 2 or havekeycards == 5) and trumpqueen)` |
| 5N | `(havekeycards == 2 and (D == 0 or H == 0 or S == 0))` |

### `1C-2N-4N-P`

| Call | Requires |
|---|---|
| P | `(true)` |
| 5C | `(havekeycards == 0 or havekeycards == 3)` |
| 5D | `(havekeycards == 1 or havekeycards == 4)` |
| 5H | `((havekeycards == 2 or havekeycards == 5) and not trumpqueen)` |
| 5S | `((havekeycards == 2 or havekeycards == 5) and trumpqueen)` |
| 5N | `(havekeycards == 2 and (D == 0 or H == 0 or S == 0))` |

### `1D-P-4N-P`

| Call | Requires |
|---|---|
| P | `(true)` |
| 5C | `(havekeycards == 0 or havekeycards == 3)` |
| 5D | `(havekeycards == 1 or havekeycards == 4)` |
| 5H | `((havekeycards == 2 or havekeycards == 5) and not trumpqueen)` |
| 5S | `((havekeycards == 2 or havekeycards == 5) and trumpqueen)` |
| 5N | `(havekeycards == 2 and (C == 0 or H == 0 or S == 0))` |
| 6C | `((havekeycards == 1 or havekeycards == 3) and C == 0)` |

### `1D-X-4N-P`

| Call | Requires |
|---|---|
| P | `(true)` |
| 5C | `(havekeycards == 0 or havekeycards == 3)` |
| 5D | `(havekeycards == 1 or havekeycards == 4)` |
| 5H | `((havekeycards == 2 or havekeycards == 5) and not trumpqueen)` |
| 5S | `((havekeycards == 2 or havekeycards == 5) and trumpqueen)` |
| 5N | `(havekeycards == 2 and (C == 0 or H == 0 or S == 0))` |
| 6C | `((havekeycards == 1 or havekeycards == 3) and C == 0)` |

### `1D-1H-4N-P`

| Call | Requires |
|---|---|
| P | `(true)` |
| 5C | `(havekeycards == 0 or havekeycards == 3)` |
| 5D | `(havekeycards == 1 or havekeycards == 4)` |
| 5H | `((havekeycards == 2 or havekeycards == 5) and not trumpqueen)` |
| 5S | `((havekeycards == 2 or havekeycards == 5) and trumpqueen)` |
| 5N | `(havekeycards == 2 and (C == 0 or H == 0 or S == 0))` |
| 6C | `((havekeycards == 1 or havekeycards == 3) and C == 0)` |

### `1D-1S-4N-P`

| Call | Requires |
|---|---|
| P | `(true)` |
| 5C | `(havekeycards == 0 or havekeycards == 3)` |
| 5D | `(havekeycards == 1 or havekeycards == 4)` |
| 5H | `((havekeycards == 2 or havekeycards == 5) and not trumpqueen)` |
| 5S | `((havekeycards == 2 or havekeycards == 5) and trumpqueen)` |
| 5N | `(havekeycards == 2 and (C == 0 or H == 0 or S == 0))` |
| 6C | `((havekeycards == 1 or havekeycards == 3) and C == 0)` |

### `1D-2C-4N-P`

| Call | Requires |
|---|---|
| P | `(true)` |
| 5C | `(havekeycards == 0 or havekeycards == 3)` |
| 5D | `(havekeycards == 1 or havekeycards == 4)` |
| 5H | `((havekeycards == 2 or havekeycards == 5) and not trumpqueen)` |
| 5S | `((havekeycards == 2 or havekeycards == 5) and trumpqueen)` |
| 5N | `(havekeycards == 2 and (C == 0 or H == 0 or S == 0))` |
| 6C | `((havekeycards == 1 or havekeycards == 3) and C == 0)` |

### `1D-2D-4N-P`

| Call | Requires |
|---|---|
| P | `(true)` |
| 5C | `(havekeycards == 0 or havekeycards == 3)` |
| 5D | `(havekeycards == 1 or havekeycards == 4)` |
| 5H | `((havekeycards == 2 or havekeycards == 5) and not trumpqueen)` |
| 5S | `((havekeycards == 2 or havekeycards == 5) and trumpqueen)` |
| 5N | `(havekeycards == 2 and (C == 0 or H == 0 or S == 0))` |
| 6C | `((havekeycards == 1 or havekeycards == 3) and C == 0)` |

### `1D-2H-4N-P`

| Call | Requires |
|---|---|
| P | `(true)` |
| 5C | `(havekeycards == 0 or havekeycards == 3)` |
| 5D | `(havekeycards == 1 or havekeycards == 4)` |
| 5H | `((havekeycards == 2 or havekeycards == 5) and not trumpqueen)` |
| 5S | `((havekeycards == 2 or havekeycards == 5) and trumpqueen)` |
| 5N | `(havekeycards == 2 and (C == 0 or H == 0 or S == 0))` |
| 6C | `((havekeycards == 1 or havekeycards == 3) and C == 0)` |

### `1D-2S-4N-P`

| Call | Requires |
|---|---|
| P | `(true)` |
| 5C | `(havekeycards == 0 or havekeycards == 3)` |
| 5D | `(havekeycards == 1 or havekeycards == 4)` |
| 5H | `((havekeycards == 2 or havekeycards == 5) and not trumpqueen)` |
| 5S | `((havekeycards == 2 or havekeycards == 5) and trumpqueen)` |
| 5N | `(havekeycards == 2 and (C == 0 or H == 0 or S == 0))` |
| 6C | `((havekeycards == 1 or havekeycards == 3) and C == 0)` |

### `1D-3C-4N-P`

| Call | Requires |
|---|---|
| P | `(true)` |
| 5C | `(havekeycards == 0 or havekeycards == 3)` |
| 5D | `(havekeycards == 1 or havekeycards == 4)` |
| 5H | `((havekeycards == 2 or havekeycards == 5) and not trumpqueen)` |
| 5S | `((havekeycards == 2 or havekeycards == 5) and trumpqueen)` |
| 5N | `(havekeycards == 2 and (C == 0 or H == 0 or S == 0))` |
| 6C | `((havekeycards == 1 or havekeycards == 3) and C == 0)` |

### `1D-3D-4N-P`

| Call | Requires |
|---|---|
| P | `(true)` |
| 5C | `(havekeycards == 0 or havekeycards == 3)` |
| 5D | `(havekeycards == 1 or havekeycards == 4)` |
| 5H | `((havekeycards == 2 or havekeycards == 5) and not trumpqueen)` |
| 5S | `((havekeycards == 2 or havekeycards == 5) and trumpqueen)` |
| 5N | `(havekeycards == 2 and (C == 0 or H == 0 or S == 0))` |
| 6C | `((havekeycards == 1 or havekeycards == 3) and C == 0)` |

### `1D-3H-4N-P`

| Call | Requires |
|---|---|
| P | `(true)` |
| 5C | `(havekeycards == 0 or havekeycards == 3)` |
| 5D | `(havekeycards == 1 or havekeycards == 4)` |
| 5H | `((havekeycards == 2 or havekeycards == 5) and not trumpqueen)` |
| 5S | `((havekeycards == 2 or havekeycards == 5) and trumpqueen)` |
| 5N | `(havekeycards == 2 and (C == 0 or H == 0 or S == 0))` |
| 6C | `((havekeycards == 1 or havekeycards == 3) and C == 0)` |

### `1D-3S-4N-P`

| Call | Requires |
|---|---|
| P | `(true)` |
| 5C | `(havekeycards == 0 or havekeycards == 3)` |
| 5D | `(havekeycards == 1 or havekeycards == 4)` |
| 5H | `((havekeycards == 2 or havekeycards == 5) and not trumpqueen)` |
| 5S | `((havekeycards == 2 or havekeycards == 5) and trumpqueen)` |
| 5N | `(havekeycards == 2 and (C == 0 or H == 0 or S == 0))` |
| 6C | `((havekeycards == 1 or havekeycards == 3) and C == 0)` |

### `1D-4C-4N-P`

| Call | Requires |
|---|---|
| P | `(true)` |
| 5C | `(havekeycards == 0 or havekeycards == 3)` |
| 5D | `(havekeycards == 1 or havekeycards == 4)` |
| 5H | `((havekeycards == 2 or havekeycards == 5) and not trumpqueen)` |
| 5S | `((havekeycards == 2 or havekeycards == 5) and trumpqueen)` |
| 5N | `(havekeycards == 2 and (C == 0 or H == 0 or S == 0))` |
| 6C | `((havekeycards == 1 or havekeycards == 3) and C == 0)` |

### `1D-4H-4N-P`

| Call | Requires |
|---|---|
| P | `(true)` |
| 5C | `(havekeycards == 0 or havekeycards == 3)` |
| 5D | `(havekeycards == 1 or havekeycards == 4)` |
| 5H | `((havekeycards == 2 or havekeycards == 5) and not trumpqueen)` |
| 5S | `((havekeycards == 2 or havekeycards == 5) and trumpqueen)` |
| 5N | `(havekeycards == 2 and (C == 0 or H == 0 or S == 0))` |
| 6C | `((havekeycards == 1 or havekeycards == 3) and C == 0)` |

### `1D-4S-4N-P`

| Call | Requires |
|---|---|
| P | `(true)` |
| 5C | `(havekeycards == 0 or havekeycards == 3)` |
| 5D | `(havekeycards == 1 or havekeycards == 4)` |
| 5H | `((havekeycards == 2 or havekeycards == 5) and not trumpqueen)` |
| 5S | `((havekeycards == 2 or havekeycards == 5) and trumpqueen)` |
| 5N | `(havekeycards == 2 and (C == 0 or H == 0 or S == 0))` |
| 6C | `((havekeycards == 1 or havekeycards == 3) and C == 0)` |

### `1D-1N-4N-P`

| Call | Requires |
|---|---|
| P | `(true)` |
| 5C | `(havekeycards == 0 or havekeycards == 3)` |
| 5D | `(havekeycards == 1 or havekeycards == 4)` |
| 5H | `((havekeycards == 2 or havekeycards == 5) and not trumpqueen)` |
| 5S | `((havekeycards == 2 or havekeycards == 5) and trumpqueen)` |
| 5N | `(havekeycards == 2 and (C == 0 or H == 0 or S == 0))` |
| 6C | `((havekeycards == 1 or havekeycards == 3) and C == 0)` |

### `1D-2N-4N-P`

| Call | Requires |
|---|---|
| P | `(true)` |
| 5C | `(havekeycards == 0 or havekeycards == 3)` |
| 5D | `(havekeycards == 1 or havekeycards == 4)` |
| 5H | `((havekeycards == 2 or havekeycards == 5) and not trumpqueen)` |
| 5S | `((havekeycards == 2 or havekeycards == 5) and trumpqueen)` |
| 5N | `(havekeycards == 2 and (C == 0 or H == 0 or S == 0))` |
| 6C | `((havekeycards == 1 or havekeycards == 3) and C == 0)` |

### `1H-P-4N-P`

| Call | Requires |
|---|---|
| P | `(true)` |
| 5C | `(havekeycards == 0 or havekeycards == 3)` |
| 5D | `(havekeycards == 1 or havekeycards == 4)` |
| 5H | `((havekeycards == 2 or havekeycards == 5) and not trumpqueen)` |
| 5S | `((havekeycards == 2 or havekeycards == 5) and trumpqueen)` |
| 5N | `(havekeycards == 2 and (C == 0 or D == 0 or S == 0))` |
| 6C | `((havekeycards == 1 or havekeycards == 3) and C == 0)` |
| 6D | `((havekeycards == 1 or havekeycards == 3) and D == 0)` |

### `1H-X-4N-P`

| Call | Requires |
|---|---|
| P | `(true)` |
| 5C | `(havekeycards == 0 or havekeycards == 3)` |
| 5D | `(havekeycards == 1 or havekeycards == 4)` |
| 5H | `((havekeycards == 2 or havekeycards == 5) and not trumpqueen)` |
| 5S | `((havekeycards == 2 or havekeycards == 5) and trumpqueen)` |
| 5N | `(havekeycards == 2 and (C == 0 or D == 0 or S == 0))` |
| 6C | `((havekeycards == 1 or havekeycards == 3) and C == 0)` |
| 6D | `((havekeycards == 1 or havekeycards == 3) and D == 0)` |

### `1H-1S-4N-P`

| Call | Requires |
|---|---|
| P | `(true)` |
| 5C | `(havekeycards == 0 or havekeycards == 3)` |
| 5D | `(havekeycards == 1 or havekeycards == 4)` |
| 5H | `((havekeycards == 2 or havekeycards == 5) and not trumpqueen)` |
| 5S | `((havekeycards == 2 or havekeycards == 5) and trumpqueen)` |
| 5N | `(havekeycards == 2 and (C == 0 or D == 0 or S == 0))` |
| 6C | `((havekeycards == 1 or havekeycards == 3) and C == 0)` |
| 6D | `((havekeycards == 1 or havekeycards == 3) and D == 0)` |

### `1H-2C-4N-P`

| Call | Requires |
|---|---|
| P | `(true)` |
| 5C | `(havekeycards == 0 or havekeycards == 3)` |
| 5D | `(havekeycards == 1 or havekeycards == 4)` |
| 5H | `((havekeycards == 2 or havekeycards == 5) and not trumpqueen)` |
| 5S | `((havekeycards == 2 or havekeycards == 5) and trumpqueen)` |
| 5N | `(havekeycards == 2 and (C == 0 or D == 0 or S == 0))` |
| 6C | `((havekeycards == 1 or havekeycards == 3) and C == 0)` |
| 6D | `((havekeycards == 1 or havekeycards == 3) and D == 0)` |

### `1H-2D-4N-P`

| Call | Requires |
|---|---|
| P | `(true)` |
| 5C | `(havekeycards == 0 or havekeycards == 3)` |
| 5D | `(havekeycards == 1 or havekeycards == 4)` |
| 5H | `((havekeycards == 2 or havekeycards == 5) and not trumpqueen)` |
| 5S | `((havekeycards == 2 or havekeycards == 5) and trumpqueen)` |
| 5N | `(havekeycards == 2 and (C == 0 or D == 0 or S == 0))` |
| 6C | `((havekeycards == 1 or havekeycards == 3) and C == 0)` |
| 6D | `((havekeycards == 1 or havekeycards == 3) and D == 0)` |

### `1H-2H-4N-P`

| Call | Requires |
|---|---|
| P | `(true)` |
| 5C | `(havekeycards == 0 or havekeycards == 3)` |
| 5D | `(havekeycards == 1 or havekeycards == 4)` |
| 5H | `((havekeycards == 2 or havekeycards == 5) and not trumpqueen)` |
| 5S | `((havekeycards == 2 or havekeycards == 5) and trumpqueen)` |
| 5N | `(havekeycards == 2 and (C == 0 or D == 0 or S == 0))` |
| 6C | `((havekeycards == 1 or havekeycards == 3) and C == 0)` |
| 6D | `((havekeycards == 1 or havekeycards == 3) and D == 0)` |

### `1H-2S-4N-P`

| Call | Requires |
|---|---|
| P | `(true)` |
| 5C | `(havekeycards == 0 or havekeycards == 3)` |
| 5D | `(havekeycards == 1 or havekeycards == 4)` |
| 5H | `((havekeycards == 2 or havekeycards == 5) and not trumpqueen)` |
| 5S | `((havekeycards == 2 or havekeycards == 5) and trumpqueen)` |
| 5N | `(havekeycards == 2 and (C == 0 or D == 0 or S == 0))` |
| 6C | `((havekeycards == 1 or havekeycards == 3) and C == 0)` |
| 6D | `((havekeycards == 1 or havekeycards == 3) and D == 0)` |

### `1H-3C-4N-P`

| Call | Requires |
|---|---|
| P | `(true)` |
| 5C | `(havekeycards == 0 or havekeycards == 3)` |
| 5D | `(havekeycards == 1 or havekeycards == 4)` |
| 5H | `((havekeycards == 2 or havekeycards == 5) and not trumpqueen)` |
| 5S | `((havekeycards == 2 or havekeycards == 5) and trumpqueen)` |
| 5N | `(havekeycards == 2 and (C == 0 or D == 0 or S == 0))` |
| 6C | `((havekeycards == 1 or havekeycards == 3) and C == 0)` |
| 6D | `((havekeycards == 1 or havekeycards == 3) and D == 0)` |

### `1H-3D-4N-P`

| Call | Requires |
|---|---|
| P | `(true)` |
| 5C | `(havekeycards == 0 or havekeycards == 3)` |
| 5D | `(havekeycards == 1 or havekeycards == 4)` |
| 5H | `((havekeycards == 2 or havekeycards == 5) and not trumpqueen)` |
| 5S | `((havekeycards == 2 or havekeycards == 5) and trumpqueen)` |
| 5N | `(havekeycards == 2 and (C == 0 or D == 0 or S == 0))` |
| 6C | `((havekeycards == 1 or havekeycards == 3) and C == 0)` |
| 6D | `((havekeycards == 1 or havekeycards == 3) and D == 0)` |

### `1H-3S-4N-P`

| Call | Requires |
|---|---|
| P | `(true)` |
| 5C | `(havekeycards == 0 or havekeycards == 3)` |
| 5D | `(havekeycards == 1 or havekeycards == 4)` |
| 5H | `((havekeycards == 2 or havekeycards == 5) and not trumpqueen)` |
| 5S | `((havekeycards == 2 or havekeycards == 5) and trumpqueen)` |
| 5N | `(havekeycards == 2 and (C == 0 or D == 0 or S == 0))` |
| 6C | `((havekeycards == 1 or havekeycards == 3) and C == 0)` |
| 6D | `((havekeycards == 1 or havekeycards == 3) and D == 0)` |

### `1H-4C-4N-P`

| Call | Requires |
|---|---|
| P | `(true)` |
| 5C | `(havekeycards == 0 or havekeycards == 3)` |
| 5D | `(havekeycards == 1 or havekeycards == 4)` |
| 5H | `((havekeycards == 2 or havekeycards == 5) and not trumpqueen)` |
| 5S | `((havekeycards == 2 or havekeycards == 5) and trumpqueen)` |
| 5N | `(havekeycards == 2 and (C == 0 or D == 0 or S == 0))` |
| 6C | `((havekeycards == 1 or havekeycards == 3) and C == 0)` |
| 6D | `((havekeycards == 1 or havekeycards == 3) and D == 0)` |

### `1H-4D-4N-P`

| Call | Requires |
|---|---|
| P | `(true)` |
| 5C | `(havekeycards == 0 or havekeycards == 3)` |
| 5D | `(havekeycards == 1 or havekeycards == 4)` |
| 5H | `((havekeycards == 2 or havekeycards == 5) and not trumpqueen)` |
| 5S | `((havekeycards == 2 or havekeycards == 5) and trumpqueen)` |
| 5N | `(havekeycards == 2 and (C == 0 or D == 0 or S == 0))` |
| 6C | `((havekeycards == 1 or havekeycards == 3) and C == 0)` |
| 6D | `((havekeycards == 1 or havekeycards == 3) and D == 0)` |

### `1H-4S-4N-P`

| Call | Requires |
|---|---|
| P | `(true)` |
| 5C | `(havekeycards == 0 or havekeycards == 3)` |
| 5D | `(havekeycards == 1 or havekeycards == 4)` |
| 5H | `((havekeycards == 2 or havekeycards == 5) and not trumpqueen)` |
| 5S | `((havekeycards == 2 or havekeycards == 5) and trumpqueen)` |
| 5N | `(havekeycards == 2 and (C == 0 or D == 0 or S == 0))` |
| 6C | `((havekeycards == 1 or havekeycards == 3) and C == 0)` |
| 6D | `((havekeycards == 1 or havekeycards == 3) and D == 0)` |

### `1H-1N-4N-P`

| Call | Requires |
|---|---|
| P | `(true)` |
| 5C | `(havekeycards == 0 or havekeycards == 3)` |
| 5D | `(havekeycards == 1 or havekeycards == 4)` |
| 5H | `((havekeycards == 2 or havekeycards == 5) and not trumpqueen)` |
| 5S | `((havekeycards == 2 or havekeycards == 5) and trumpqueen)` |
| 5N | `(havekeycards == 2 and (C == 0 or D == 0 or S == 0))` |
| 6C | `((havekeycards == 1 or havekeycards == 3) and C == 0)` |
| 6D | `((havekeycards == 1 or havekeycards == 3) and D == 0)` |

### `1H-2N-4N-P`

| Call | Requires |
|---|---|
| P | `(true)` |
| 5C | `(havekeycards == 0 or havekeycards == 3)` |
| 5D | `(havekeycards == 1 or havekeycards == 4)` |
| 5H | `((havekeycards == 2 or havekeycards == 5) and not trumpqueen)` |
| 5S | `((havekeycards == 2 or havekeycards == 5) and trumpqueen)` |
| 5N | `(havekeycards == 2 and (C == 0 or D == 0 or S == 0))` |
| 6C | `((havekeycards == 1 or havekeycards == 3) and C == 0)` |
| 6D | `((havekeycards == 1 or havekeycards == 3) and D == 0)` |

### `1S-P-4N-P`

| Call | Requires |
|---|---|
| 5C | `(havekeycards == 0 or havekeycards == 3)` |
| 5D | `(havekeycards == 1 or havekeycards == 4)` |
| 5H | `((havekeycards == 2 or havekeycards == 5) and not trumpqueen)` |
| 5S | `((havekeycards == 2 or havekeycards == 5) and trumpqueen)` |
| 5N | `(havekeycards == 2 and (C == 0 or D == 0 or H == 0))` |
| 6C | `((havekeycards == 1 or havekeycards == 3) and C == 0)` |
| 6D | `((havekeycards == 1 or havekeycards == 3) and D == 0)` |
| 6H | `((havekeycards == 1 or havekeycards == 3) and H == 0)` |

### `1S-X-4N-P`

| Call | Requires |
|---|---|
| 5C | `(havekeycards == 0 or havekeycards == 3)` |
| 5D | `(havekeycards == 1 or havekeycards == 4)` |
| 5H | `((havekeycards == 2 or havekeycards == 5) and not trumpqueen)` |
| 5S | `((havekeycards == 2 or havekeycards == 5) and trumpqueen)` |
| 5N | `(havekeycards == 2 and (C == 0 or D == 0 or H == 0))` |
| 6C | `((havekeycards == 1 or havekeycards == 3) and C == 0)` |
| 6D | `((havekeycards == 1 or havekeycards == 3) and D == 0)` |
| 6H | `((havekeycards == 1 or havekeycards == 3) and H == 0)` |

### `1S-2C-4N-P`

| Call | Requires |
|---|---|
| 5C | `(havekeycards == 0 or havekeycards == 3)` |
| 5D | `(havekeycards == 1 or havekeycards == 4)` |
| 5H | `((havekeycards == 2 or havekeycards == 5) and not trumpqueen)` |
| 5S | `((havekeycards == 2 or havekeycards == 5) and trumpqueen)` |
| 5N | `(havekeycards == 2 and (C == 0 or D == 0 or H == 0))` |
| 6C | `((havekeycards == 1 or havekeycards == 3) and C == 0)` |
| 6D | `((havekeycards == 1 or havekeycards == 3) and D == 0)` |
| 6H | `((havekeycards == 1 or havekeycards == 3) and H == 0)` |

### `1S-2D-4N-P`

| Call | Requires |
|---|---|
| 5C | `(havekeycards == 0 or havekeycards == 3)` |
| 5D | `(havekeycards == 1 or havekeycards == 4)` |
| 5H | `((havekeycards == 2 or havekeycards == 5) and not trumpqueen)` |
| 5S | `((havekeycards == 2 or havekeycards == 5) and trumpqueen)` |
| 5N | `(havekeycards == 2 and (C == 0 or D == 0 or H == 0))` |
| 6C | `((havekeycards == 1 or havekeycards == 3) and C == 0)` |
| 6D | `((havekeycards == 1 or havekeycards == 3) and D == 0)` |
| 6H | `((havekeycards == 1 or havekeycards == 3) and H == 0)` |

### `1S-2H-4N-P`

| Call | Requires |
|---|---|
| 5C | `(havekeycards == 0 or havekeycards == 3)` |
| 5D | `(havekeycards == 1 or havekeycards == 4)` |
| 5H | `((havekeycards == 2 or havekeycards == 5) and not trumpqueen)` |
| 5S | `((havekeycards == 2 or havekeycards == 5) and trumpqueen)` |
| 5N | `(havekeycards == 2 and (C == 0 or D == 0 or H == 0))` |
| 6C | `((havekeycards == 1 or havekeycards == 3) and C == 0)` |
| 6D | `((havekeycards == 1 or havekeycards == 3) and D == 0)` |
| 6H | `((havekeycards == 1 or havekeycards == 3) and H == 0)` |

### `1S-2S-4N-P`

| Call | Requires |
|---|---|
| 5C | `(havekeycards == 0 or havekeycards == 3)` |
| 5D | `(havekeycards == 1 or havekeycards == 4)` |
| 5H | `((havekeycards == 2 or havekeycards == 5) and not trumpqueen)` |
| 5S | `((havekeycards == 2 or havekeycards == 5) and trumpqueen)` |
| 5N | `(havekeycards == 2 and (C == 0 or D == 0 or H == 0))` |
| 6C | `((havekeycards == 1 or havekeycards == 3) and C == 0)` |
| 6D | `((havekeycards == 1 or havekeycards == 3) and D == 0)` |
| 6H | `((havekeycards == 1 or havekeycards == 3) and H == 0)` |

### `1S-3C-4N-P`

| Call | Requires |
|---|---|
| 5C | `(havekeycards == 0 or havekeycards == 3)` |
| 5D | `(havekeycards == 1 or havekeycards == 4)` |
| 5H | `((havekeycards == 2 or havekeycards == 5) and not trumpqueen)` |
| 5S | `((havekeycards == 2 or havekeycards == 5) and trumpqueen)` |
| 5N | `(havekeycards == 2 and (C == 0 or D == 0 or H == 0))` |
| 6C | `((havekeycards == 1 or havekeycards == 3) and C == 0)` |
| 6D | `((havekeycards == 1 or havekeycards == 3) and D == 0)` |
| 6H | `((havekeycards == 1 or havekeycards == 3) and H == 0)` |

### `1S-3D-4N-P`

| Call | Requires |
|---|---|
| 5C | `(havekeycards == 0 or havekeycards == 3)` |
| 5D | `(havekeycards == 1 or havekeycards == 4)` |
| 5H | `((havekeycards == 2 or havekeycards == 5) and not trumpqueen)` |
| 5S | `((havekeycards == 2 or havekeycards == 5) and trumpqueen)` |
| 5N | `(havekeycards == 2 and (C == 0 or D == 0 or H == 0))` |
| 6C | `((havekeycards == 1 or havekeycards == 3) and C == 0)` |
| 6D | `((havekeycards == 1 or havekeycards == 3) and D == 0)` |
| 6H | `((havekeycards == 1 or havekeycards == 3) and H == 0)` |

### `1S-3H-4N-P`

| Call | Requires |
|---|---|
| 5C | `(havekeycards == 0 or havekeycards == 3)` |
| 5D | `(havekeycards == 1 or havekeycards == 4)` |
| 5H | `((havekeycards == 2 or havekeycards == 5) and not trumpqueen)` |
| 5S | `((havekeycards == 2 or havekeycards == 5) and trumpqueen)` |
| 5N | `(havekeycards == 2 and (C == 0 or D == 0 or H == 0))` |
| 6C | `((havekeycards == 1 or havekeycards == 3) and C == 0)` |
| 6D | `((havekeycards == 1 or havekeycards == 3) and D == 0)` |
| 6H | `((havekeycards == 1 or havekeycards == 3) and H == 0)` |

### `1S-4C-4N-P`

| Call | Requires |
|---|---|
| 5C | `(havekeycards == 0 or havekeycards == 3)` |
| 5D | `(havekeycards == 1 or havekeycards == 4)` |
| 5H | `((havekeycards == 2 or havekeycards == 5) and not trumpqueen)` |
| 5S | `((havekeycards == 2 or havekeycards == 5) and trumpqueen)` |
| 5N | `(havekeycards == 2 and (C == 0 or D == 0 or H == 0))` |
| 6C | `((havekeycards == 1 or havekeycards == 3) and C == 0)` |
| 6D | `((havekeycards == 1 or havekeycards == 3) and D == 0)` |
| 6H | `((havekeycards == 1 or havekeycards == 3) and H == 0)` |

### `1S-4D-4N-P`

| Call | Requires |
|---|---|
| 5C | `(havekeycards == 0 or havekeycards == 3)` |
| 5D | `(havekeycards == 1 or havekeycards == 4)` |
| 5H | `((havekeycards == 2 or havekeycards == 5) and not trumpqueen)` |
| 5S | `((havekeycards == 2 or havekeycards == 5) and trumpqueen)` |
| 5N | `(havekeycards == 2 and (C == 0 or D == 0 or H == 0))` |
| 6C | `((havekeycards == 1 or havekeycards == 3) and C == 0)` |
| 6D | `((havekeycards == 1 or havekeycards == 3) and D == 0)` |
| 6H | `((havekeycards == 1 or havekeycards == 3) and H == 0)` |

### `1S-4H-4N-P`

| Call | Requires |
|---|---|
| 5C | `(havekeycards == 0 or havekeycards == 3)` |
| 5D | `(havekeycards == 1 or havekeycards == 4)` |
| 5H | `((havekeycards == 2 or havekeycards == 5) and not trumpqueen)` |
| 5S | `((havekeycards == 2 or havekeycards == 5) and trumpqueen)` |
| 5N | `(havekeycards == 2 and (C == 0 or D == 0 or H == 0))` |
| 6C | `((havekeycards == 1 or havekeycards == 3) and C == 0)` |
| 6D | `((havekeycards == 1 or havekeycards == 3) and D == 0)` |
| 6H | `((havekeycards == 1 or havekeycards == 3) and H == 0)` |

### `1S-1N-4N-P`

| Call | Requires |
|---|---|
| 5C | `(havekeycards == 0 or havekeycards == 3)` |
| 5D | `(havekeycards == 1 or havekeycards == 4)` |
| 5H | `((havekeycards == 2 or havekeycards == 5) and not trumpqueen)` |
| 5S | `((havekeycards == 2 or havekeycards == 5) and trumpqueen)` |
| 5N | `(havekeycards == 2 and (C == 0 or D == 0 or H == 0))` |
| 6C | `((havekeycards == 1 or havekeycards == 3) and C == 0)` |
| 6D | `((havekeycards == 1 or havekeycards == 3) and D == 0)` |
| 6H | `((havekeycards == 1 or havekeycards == 3) and H == 0)` |

### `1S-2N-4N-P`

| Call | Requires |
|---|---|
| 5C | `(havekeycards == 0 or havekeycards == 3)` |
| 5D | `(havekeycards == 1 or havekeycards == 4)` |
| 5H | `((havekeycards == 2 or havekeycards == 5) and not trumpqueen)` |
| 5S | `((havekeycards == 2 or havekeycards == 5) and trumpqueen)` |
| 5N | `(havekeycards == 2 and (C == 0 or D == 0 or H == 0))` |
| 6C | `((havekeycards == 1 or havekeycards == 3) and C == 0)` |
| 6D | `((havekeycards == 1 or havekeycards == 3) and D == 0)` |
| 6H | `((havekeycards == 1 or havekeycards == 3) and H == 0)` |

### `2D-P-4N-P`

| Call | Requires |
|---|---|
| P | `(true)` |
| 5C | `(havekeycards == 0 or havekeycards == 3)` |
| 5D | `(havekeycards == 1 or havekeycards == 4)` |
| 5H | `((havekeycards == 2 or havekeycards == 5) and not trumpqueen)` |
| 5S | `((havekeycards == 2 or havekeycards == 5) and trumpqueen)` |
| 5N | `(havekeycards == 2 and (C == 0 or H == 0 or S == 0))` |
| 6C | `((havekeycards == 1 or havekeycards == 3) and C == 0)` |

### `2D-X-4N-P`

| Call | Requires |
|---|---|
| P | `(true)` |
| 5C | `(havekeycards == 0 or havekeycards == 3)` |
| 5D | `(havekeycards == 1 or havekeycards == 4)` |
| 5H | `((havekeycards == 2 or havekeycards == 5) and not trumpqueen)` |
| 5S | `((havekeycards == 2 or havekeycards == 5) and trumpqueen)` |
| 5N | `(havekeycards == 2 and (C == 0 or H == 0 or S == 0))` |
| 6C | `((havekeycards == 1 or havekeycards == 3) and C == 0)` |

### `2D-2H-4N-P`

| Call | Requires |
|---|---|
| P | `(true)` |
| 5C | `(havekeycards == 0 or havekeycards == 3)` |
| 5D | `(havekeycards == 1 or havekeycards == 4)` |
| 5H | `((havekeycards == 2 or havekeycards == 5) and not trumpqueen)` |
| 5S | `((havekeycards == 2 or havekeycards == 5) and trumpqueen)` |
| 5N | `(havekeycards == 2 and (C == 0 or H == 0 or S == 0))` |
| 6C | `((havekeycards == 1 or havekeycards == 3) and C == 0)` |

### `2D-2S-4N-P`

| Call | Requires |
|---|---|
| P | `(true)` |
| 5C | `(havekeycards == 0 or havekeycards == 3)` |
| 5D | `(havekeycards == 1 or havekeycards == 4)` |
| 5H | `((havekeycards == 2 or havekeycards == 5) and not trumpqueen)` |
| 5S | `((havekeycards == 2 or havekeycards == 5) and trumpqueen)` |
| 5N | `(havekeycards == 2 and (C == 0 or H == 0 or S == 0))` |
| 6C | `((havekeycards == 1 or havekeycards == 3) and C == 0)` |

### `2D-3C-4N-P`

| Call | Requires |
|---|---|
| P | `(true)` |
| 5C | `(havekeycards == 0 or havekeycards == 3)` |
| 5D | `(havekeycards == 1 or havekeycards == 4)` |
| 5H | `((havekeycards == 2 or havekeycards == 5) and not trumpqueen)` |
| 5S | `((havekeycards == 2 or havekeycards == 5) and trumpqueen)` |
| 5N | `(havekeycards == 2 and (C == 0 or H == 0 or S == 0))` |
| 6C | `((havekeycards == 1 or havekeycards == 3) and C == 0)` |

### `2D-3D-4N-P`

| Call | Requires |
|---|---|
| P | `(true)` |
| 5C | `(havekeycards == 0 or havekeycards == 3)` |
| 5D | `(havekeycards == 1 or havekeycards == 4)` |
| 5H | `((havekeycards == 2 or havekeycards == 5) and not trumpqueen)` |
| 5S | `((havekeycards == 2 or havekeycards == 5) and trumpqueen)` |
| 5N | `(havekeycards == 2 and (D == 0 or H == 0 or S == 0))` |

### `2D-3H-4N-P`

| Call | Requires |
|---|---|
| P | `(true)` |
| 5C | `(havekeycards == 0 or havekeycards == 3)` |
| 5D | `(havekeycards == 1 or havekeycards == 4)` |
| 5H | `((havekeycards == 2 or havekeycards == 5) and not trumpqueen)` |
| 5S | `((havekeycards == 2 or havekeycards == 5) and trumpqueen)` |
| 5N | `(havekeycards == 2 and (C == 0 or H == 0 or S == 0))` |
| 6C | `((havekeycards == 1 or havekeycards == 3) and C == 0)` |

### `2D-3S-4N-P`

| Call | Requires |
|---|---|
| P | `(true)` |
| 5C | `(havekeycards == 0 or havekeycards == 3)` |
| 5D | `(havekeycards == 1 or havekeycards == 4)` |
| 5H | `((havekeycards == 2 or havekeycards == 5) and not trumpqueen)` |
| 5S | `((havekeycards == 2 or havekeycards == 5) and trumpqueen)` |
| 5N | `(havekeycards == 2 and (C == 0 or H == 0 or S == 0))` |
| 6C | `((havekeycards == 1 or havekeycards == 3) and C == 0)` |

### `2D-4C-4N-P`

| Call | Requires |
|---|---|
| P | `(true)` |
| 5C | `(havekeycards == 0 or havekeycards == 3)` |
| 5D | `(havekeycards == 1 or havekeycards == 4)` |
| 5H | `((havekeycards == 2 or havekeycards == 5) and not trumpqueen)` |
| 5S | `((havekeycards == 2 or havekeycards == 5) and trumpqueen)` |
| 5N | `(havekeycards == 2 and (C == 0 or H == 0 or S == 0))` |
| 6C | `((havekeycards == 1 or havekeycards == 3) and C == 0)` |

### `2D-4H-4N-P`

| Call | Requires |
|---|---|
| P | `(true)` |
| 5C | `(havekeycards == 0 or havekeycards == 3)` |
| 5D | `(havekeycards == 1 or havekeycards == 4)` |
| 5H | `((havekeycards == 2 or havekeycards == 5) and not trumpqueen)` |
| 5S | `((havekeycards == 2 or havekeycards == 5) and trumpqueen)` |
| 5N | `(havekeycards == 2 and (C == 0 or H == 0 or S == 0))` |
| 6C | `((havekeycards == 1 or havekeycards == 3) and C == 0)` |

### `2D-4S-4N-P`

| Call | Requires |
|---|---|
| P | `(true)` |
| 5C | `(havekeycards == 0 or havekeycards == 3)` |
| 5D | `(havekeycards == 1 or havekeycards == 4)` |
| 5H | `((havekeycards == 2 or havekeycards == 5) and not trumpqueen)` |
| 5S | `((havekeycards == 2 or havekeycards == 5) and trumpqueen)` |
| 5N | `(havekeycards == 2 and (C == 0 or H == 0 or S == 0))` |
| 6C | `((havekeycards == 1 or havekeycards == 3) and C == 0)` |

### `2D-2N-4N-P`

| Call | Requires |
|---|---|
| P | `(true)` |
| 5C | `(havekeycards == 0 or havekeycards == 3)` |
| 5D | `(havekeycards == 1 or havekeycards == 4)` |
| 5H | `((havekeycards == 2 or havekeycards == 5) and not trumpqueen)` |
| 5S | `((havekeycards == 2 or havekeycards == 5) and trumpqueen)` |
| 5N | `(havekeycards == 2 and (C == 0 or H == 0 or S == 0))` |
| 6C | `((havekeycards == 1 or havekeycards == 3) and C == 0)` |

### `2D-3N-4N-P`

| Call | Requires |
|---|---|
| P | `(true)` |
| 5C | `(havekeycards == 0 or havekeycards == 3)` |
| 5D | `(havekeycards == 1 or havekeycards == 4)` |
| 5H | `((havekeycards == 2 or havekeycards == 5) and not trumpqueen)` |
| 5S | `((havekeycards == 2 or havekeycards == 5) and trumpqueen)` |
| 5N | `(havekeycards == 2 and (C == 0 or H == 0 or S == 0))` |
| 6C | `((havekeycards == 1 or havekeycards == 3) and C == 0)` |

### `2H-P-4N-P`

| Call | Requires |
|---|---|
| P | `(true)` |
| 5C | `(havekeycards == 0 or havekeycards == 3)` |
| 5D | `(havekeycards == 1 or havekeycards == 4)` |
| 5H | `((havekeycards == 2 or havekeycards == 5) and not trumpqueen)` |
| 5S | `((havekeycards == 2 or havekeycards == 5) and trumpqueen)` |
| 5N | `(havekeycards == 2 and (C == 0 or D == 0 or S == 0))` |
| 6C | `((havekeycards == 1 or havekeycards == 3) and C == 0)` |
| 6D | `((havekeycards == 1 or havekeycards == 3) and D == 0)` |

### `2H-X-4N-P`

| Call | Requires |
|---|---|
| P | `(true)` |
| 5C | `(havekeycards == 0 or havekeycards == 3)` |
| 5D | `(havekeycards == 1 or havekeycards == 4)` |
| 5H | `((havekeycards == 2 or havekeycards == 5) and not trumpqueen)` |
| 5S | `((havekeycards == 2 or havekeycards == 5) and trumpqueen)` |
| 5N | `(havekeycards == 2 and (C == 0 or D == 0 or S == 0))` |
| 6C | `((havekeycards == 1 or havekeycards == 3) and C == 0)` |
| 6D | `((havekeycards == 1 or havekeycards == 3) and D == 0)` |

### `2H-2S-4N-P`

| Call | Requires |
|---|---|
| P | `(true)` |
| 5C | `(havekeycards == 0 or havekeycards == 3)` |
| 5D | `(havekeycards == 1 or havekeycards == 4)` |
| 5H | `((havekeycards == 2 or havekeycards == 5) and not trumpqueen)` |
| 5S | `((havekeycards == 2 or havekeycards == 5) and trumpqueen)` |
| 5N | `(havekeycards == 2 and (C == 0 or D == 0 or S == 0))` |
| 6C | `((havekeycards == 1 or havekeycards == 3) and C == 0)` |
| 6D | `((havekeycards == 1 or havekeycards == 3) and D == 0)` |

### `2H-3C-4N-P`

| Call | Requires |
|---|---|
| P | `(true)` |
| 5C | `(havekeycards == 0 or havekeycards == 3)` |
| 5D | `(havekeycards == 1 or havekeycards == 4)` |
| 5H | `((havekeycards == 2 or havekeycards == 5) and not trumpqueen)` |
| 5S | `((havekeycards == 2 or havekeycards == 5) and trumpqueen)` |
| 5N | `(havekeycards == 2 and (C == 0 or D == 0 or S == 0))` |
| 6C | `((havekeycards == 1 or havekeycards == 3) and C == 0)` |
| 6D | `((havekeycards == 1 or havekeycards == 3) and D == 0)` |

### `2H-3D-4N-P`

| Call | Requires |
|---|---|
| P | `(true)` |
| 5C | `(havekeycards == 0 or havekeycards == 3)` |
| 5D | `(havekeycards == 1 or havekeycards == 4)` |
| 5H | `((havekeycards == 2 or havekeycards == 5) and not trumpqueen)` |
| 5S | `((havekeycards == 2 or havekeycards == 5) and trumpqueen)` |
| 5N | `(havekeycards == 2 and (C == 0 or D == 0 or S == 0))` |
| 6C | `((havekeycards == 1 or havekeycards == 3) and C == 0)` |
| 6D | `((havekeycards == 1 or havekeycards == 3) and D == 0)` |

### `2H-3H-4N-P`

| Call | Requires |
|---|---|
| P | `(true)` |
| 5C | `(havekeycards == 0 or havekeycards == 3)` |
| 5D | `(havekeycards == 1 or havekeycards == 4)` |
| 5H | `((havekeycards == 2 or havekeycards == 5) and not trumpqueen)` |
| 5S | `((havekeycards == 2 or havekeycards == 5) and trumpqueen)` |
| 5N | `(havekeycards == 2 and (C == 0 or H == 0 or S == 0))` |
| 6C | `((havekeycards == 1 or havekeycards == 3) and C == 0)` |

### `2H-3S-4N-P`

| Call | Requires |
|---|---|
| P | `(true)` |
| 5C | `(havekeycards == 0 or havekeycards == 3)` |
| 5D | `(havekeycards == 1 or havekeycards == 4)` |
| 5H | `((havekeycards == 2 or havekeycards == 5) and not trumpqueen)` |
| 5S | `((havekeycards == 2 or havekeycards == 5) and trumpqueen)` |
| 5N | `(havekeycards == 2 and (C == 0 or D == 0 or S == 0))` |
| 6C | `((havekeycards == 1 or havekeycards == 3) and C == 0)` |
| 6D | `((havekeycards == 1 or havekeycards == 3) and D == 0)` |

### `2H-4C-4N-P`

| Call | Requires |
|---|---|
| P | `(true)` |
| 5C | `(havekeycards == 0 or havekeycards == 3)` |
| 5D | `(havekeycards == 1 or havekeycards == 4)` |
| 5H | `((havekeycards == 2 or havekeycards == 5) and not trumpqueen)` |
| 5S | `((havekeycards == 2 or havekeycards == 5) and trumpqueen)` |
| 5N | `(havekeycards == 2 and (C == 0 or D == 0 or S == 0))` |
| 6C | `((havekeycards == 1 or havekeycards == 3) and C == 0)` |
| 6D | `((havekeycards == 1 or havekeycards == 3) and D == 0)` |

### `2H-4D-4N-P`

| Call | Requires |
|---|---|
| P | `(true)` |
| 5C | `(havekeycards == 0 or havekeycards == 3)` |
| 5D | `(havekeycards == 1 or havekeycards == 4)` |
| 5H | `((havekeycards == 2 or havekeycards == 5) and not trumpqueen)` |
| 5S | `((havekeycards == 2 or havekeycards == 5) and trumpqueen)` |
| 5N | `(havekeycards == 2 and (C == 0 or D == 0 or S == 0))` |
| 6C | `((havekeycards == 1 or havekeycards == 3) and C == 0)` |
| 6D | `((havekeycards == 1 or havekeycards == 3) and D == 0)` |

### `2H-4H-4N-P`

| Call | Requires |
|---|---|
| P | `(true)` |
| 5C | `(havekeycards == 0 or havekeycards == 3)` |
| 5D | `(havekeycards == 1 or havekeycards == 4)` |
| 5H | `((havekeycards == 2 or havekeycards == 5) and not trumpqueen)` |
| 5S | `((havekeycards == 2 or havekeycards == 5) and trumpqueen)` |
| 5N | `(havekeycards == 2 and (C == 0 or D == 0 or S == 0))` |
| 6C | `((havekeycards == 1 or havekeycards == 3) and C == 0)` |
| 6D | `((havekeycards == 1 or havekeycards == 3) and D == 0)` |

### `2H-4S-4N-P`

| Call | Requires |
|---|---|
| P | `(true)` |
| 5C | `(havekeycards == 0 or havekeycards == 3)` |
| 5D | `(havekeycards == 1 or havekeycards == 4)` |
| 5H | `((havekeycards == 2 or havekeycards == 5) and not trumpqueen)` |
| 5S | `((havekeycards == 2 or havekeycards == 5) and trumpqueen)` |
| 5N | `(havekeycards == 2 and (C == 0 or D == 0 or S == 0))` |
| 6C | `((havekeycards == 1 or havekeycards == 3) and C == 0)` |
| 6D | `((havekeycards == 1 or havekeycards == 3) and D == 0)` |

### `2H-2N-4N-P`

| Call | Requires |
|---|---|
| P | `(true)` |
| 5C | `(havekeycards == 0 or havekeycards == 3)` |
| 5D | `(havekeycards == 1 or havekeycards == 4)` |
| 5H | `((havekeycards == 2 or havekeycards == 5) and not trumpqueen)` |
| 5S | `((havekeycards == 2 or havekeycards == 5) and trumpqueen)` |
| 5N | `(havekeycards == 2 and (C == 0 or D == 0 or S == 0))` |
| 6C | `((havekeycards == 1 or havekeycards == 3) and C == 0)` |
| 6D | `((havekeycards == 1 or havekeycards == 3) and D == 0)` |

### `2H-3N-4N-P`

| Call | Requires |
|---|---|
| P | `(true)` |
| 5C | `(havekeycards == 0 or havekeycards == 3)` |
| 5D | `(havekeycards == 1 or havekeycards == 4)` |
| 5H | `((havekeycards == 2 or havekeycards == 5) and not trumpqueen)` |
| 5S | `((havekeycards == 2 or havekeycards == 5) and trumpqueen)` |
| 5N | `(havekeycards == 2 and (C == 0 or D == 0 or S == 0))` |
| 6C | `((havekeycards == 1 or havekeycards == 3) and C == 0)` |
| 6D | `((havekeycards == 1 or havekeycards == 3) and D == 0)` |

### `2S-P-4N-P`

| Call | Requires |
|---|---|
| 5C | `(havekeycards == 0 or havekeycards == 3)` |
| 5D | `(havekeycards == 1 or havekeycards == 4)` |
| 5H | `((havekeycards == 2 or havekeycards == 5) and not trumpqueen)` |
| 5S | `((havekeycards == 2 or havekeycards == 5) and trumpqueen)` |
| 5N | `(havekeycards == 2 and (C == 0 or D == 0 or H == 0))` |
| 6C | `((havekeycards == 1 or havekeycards == 3) and C == 0)` |
| 6D | `((havekeycards == 1 or havekeycards == 3) and D == 0)` |
| 6H | `((havekeycards == 1 or havekeycards == 3) and H == 0)` |

### `2S-X-4N-P`

| Call | Requires |
|---|---|
| 5C | `(havekeycards == 0 or havekeycards == 3)` |
| 5D | `(havekeycards == 1 or havekeycards == 4)` |
| 5H | `((havekeycards == 2 or havekeycards == 5) and not trumpqueen)` |
| 5S | `((havekeycards == 2 or havekeycards == 5) and trumpqueen)` |
| 5N | `(havekeycards == 2 and (C == 0 or D == 0 or H == 0))` |
| 6C | `((havekeycards == 1 or havekeycards == 3) and C == 0)` |
| 6D | `((havekeycards == 1 or havekeycards == 3) and D == 0)` |
| 6H | `((havekeycards == 1 or havekeycards == 3) and H == 0)` |

### `2S-3C-4N-P`

| Call | Requires |
|---|---|
| 5C | `(havekeycards == 0 or havekeycards == 3)` |
| 5D | `(havekeycards == 1 or havekeycards == 4)` |
| 5H | `((havekeycards == 2 or havekeycards == 5) and not trumpqueen)` |
| 5S | `((havekeycards == 2 or havekeycards == 5) and trumpqueen)` |
| 5N | `(havekeycards == 2 and (C == 0 or D == 0 or H == 0))` |
| 6C | `((havekeycards == 1 or havekeycards == 3) and C == 0)` |
| 6D | `((havekeycards == 1 or havekeycards == 3) and D == 0)` |
| 6H | `((havekeycards == 1 or havekeycards == 3) and H == 0)` |

### `2S-3D-4N-P`

| Call | Requires |
|---|---|
| 5C | `(havekeycards == 0 or havekeycards == 3)` |
| 5D | `(havekeycards == 1 or havekeycards == 4)` |
| 5H | `((havekeycards == 2 or havekeycards == 5) and not trumpqueen)` |
| 5S | `((havekeycards == 2 or havekeycards == 5) and trumpqueen)` |
| 5N | `(havekeycards == 2 and (C == 0 or D == 0 or H == 0))` |
| 6C | `((havekeycards == 1 or havekeycards == 3) and C == 0)` |
| 6D | `((havekeycards == 1 or havekeycards == 3) and D == 0)` |
| 6H | `((havekeycards == 1 or havekeycards == 3) and H == 0)` |

### `2S-3H-4N-P`

| Call | Requires |
|---|---|
| 5C | `(havekeycards == 0 or havekeycards == 3)` |
| 5D | `(havekeycards == 1 or havekeycards == 4)` |
| 5H | `((havekeycards == 2 or havekeycards == 5) and not trumpqueen)` |
| 5S | `((havekeycards == 2 or havekeycards == 5) and trumpqueen)` |
| 5N | `(havekeycards == 2 and (C == 0 or D == 0 or H == 0))` |
| 6C | `((havekeycards == 1 or havekeycards == 3) and C == 0)` |
| 6D | `((havekeycards == 1 or havekeycards == 3) and D == 0)` |
| 6H | `((havekeycards == 1 or havekeycards == 3) and H == 0)` |

### `2S-3S-4N-P`

| Call | Requires |
|---|---|
| P | `(true)` |
| 5C | `(havekeycards == 0 or havekeycards == 3)` |
| 5D | `(havekeycards == 1 or havekeycards == 4)` |
| 5H | `((havekeycards == 2 or havekeycards == 5) and not trumpqueen)` |
| 5S | `((havekeycards == 2 or havekeycards == 5) and trumpqueen)` |
| 5N | `(havekeycards == 2 and (C == 0 or H == 0 or S == 0))` |
| 6C | `((havekeycards == 1 or havekeycards == 3) and C == 0)` |

### `2S-4C-4N-P`

| Call | Requires |
|---|---|
| 5C | `(havekeycards == 0 or havekeycards == 3)` |
| 5D | `(havekeycards == 1 or havekeycards == 4)` |
| 5H | `((havekeycards == 2 or havekeycards == 5) and not trumpqueen)` |
| 5S | `((havekeycards == 2 or havekeycards == 5) and trumpqueen)` |
| 5N | `(havekeycards == 2 and (C == 0 or D == 0 or H == 0))` |
| 6C | `((havekeycards == 1 or havekeycards == 3) and C == 0)` |
| 6D | `((havekeycards == 1 or havekeycards == 3) and D == 0)` |
| 6H | `((havekeycards == 1 or havekeycards == 3) and H == 0)` |

### `2S-4D-4N-P`

| Call | Requires |
|---|---|
| 5C | `(havekeycards == 0 or havekeycards == 3)` |
| 5D | `(havekeycards == 1 or havekeycards == 4)` |
| 5H | `((havekeycards == 2 or havekeycards == 5) and not trumpqueen)` |
| 5S | `((havekeycards == 2 or havekeycards == 5) and trumpqueen)` |
| 5N | `(havekeycards == 2 and (C == 0 or D == 0 or H == 0))` |
| 6C | `((havekeycards == 1 or havekeycards == 3) and C == 0)` |
| 6D | `((havekeycards == 1 or havekeycards == 3) and D == 0)` |
| 6H | `((havekeycards == 1 or havekeycards == 3) and H == 0)` |

### `2S-4H-4N-P`

| Call | Requires |
|---|---|
| 5C | `(havekeycards == 0 or havekeycards == 3)` |
| 5D | `(havekeycards == 1 or havekeycards == 4)` |
| 5H | `((havekeycards == 2 or havekeycards == 5) and not trumpqueen)` |
| 5S | `((havekeycards == 2 or havekeycards == 5) and trumpqueen)` |
| 5N | `(havekeycards == 2 and (C == 0 or D == 0 or H == 0))` |
| 6C | `((havekeycards == 1 or havekeycards == 3) and C == 0)` |
| 6D | `((havekeycards == 1 or havekeycards == 3) and D == 0)` |
| 6H | `((havekeycards == 1 or havekeycards == 3) and H == 0)` |

### `2S-4S-4N-P`

| Call | Requires |
|---|---|
| 5C | `(havekeycards == 0 or havekeycards == 3)` |
| 5D | `(havekeycards == 1 or havekeycards == 4)` |
| 5H | `((havekeycards == 2 or havekeycards == 5) and not trumpqueen)` |
| 5S | `((havekeycards == 2 or havekeycards == 5) and trumpqueen)` |
| 5N | `(havekeycards == 2 and (C == 0 or D == 0 or H == 0))` |
| 6C | `((havekeycards == 1 or havekeycards == 3) and C == 0)` |
| 6D | `((havekeycards == 1 or havekeycards == 3) and D == 0)` |
| 6H | `((havekeycards == 1 or havekeycards == 3) and H == 0)` |

### `2S-2N-4N-P`

| Call | Requires |
|---|---|
| 5C | `(havekeycards == 0 or havekeycards == 3)` |
| 5D | `(havekeycards == 1 or havekeycards == 4)` |
| 5H | `((havekeycards == 2 or havekeycards == 5) and not trumpqueen)` |
| 5S | `((havekeycards == 2 or havekeycards == 5) and trumpqueen)` |
| 5N | `(havekeycards == 2 and (C == 0 or D == 0 or H == 0))` |
| 6C | `((havekeycards == 1 or havekeycards == 3) and C == 0)` |
| 6D | `((havekeycards == 1 or havekeycards == 3) and D == 0)` |
| 6H | `((havekeycards == 1 or havekeycards == 3) and H == 0)` |

### `2S-3N-4N-P`

| Call | Requires |
|---|---|
| 5C | `(havekeycards == 0 or havekeycards == 3)` |
| 5D | `(havekeycards == 1 or havekeycards == 4)` |
| 5H | `((havekeycards == 2 or havekeycards == 5) and not trumpqueen)` |
| 5S | `((havekeycards == 2 or havekeycards == 5) and trumpqueen)` |
| 5N | `(havekeycards == 2 and (C == 0 or D == 0 or H == 0))` |
| 6C | `((havekeycards == 1 or havekeycards == 3) and C == 0)` |
| 6D | `((havekeycards == 1 or havekeycards == 3) and D == 0)` |
| 6H | `((havekeycards == 1 or havekeycards == 3) and H == 0)` |

### `3C-P-4N-P`

| Call | Requires |
|---|---|
| P | `(true)` |
| 5C | `(havekeycards == 0 or havekeycards == 3)` |
| 5D | `(havekeycards == 1 or havekeycards == 4)` |
| 5H | `((havekeycards == 2 or havekeycards == 5) and not trumpqueen)` |
| 5S | `((havekeycards == 2 or havekeycards == 5) and trumpqueen)` |
| 5N | `(havekeycards == 2 and (D == 0 or H == 0 or S == 0))` |

### `3C-X-4N-P`

| Call | Requires |
|---|---|
| P | `(true)` |
| 5C | `(havekeycards == 0 or havekeycards == 3)` |
| 5D | `(havekeycards == 1 or havekeycards == 4)` |
| 5H | `((havekeycards == 2 or havekeycards == 5) and not trumpqueen)` |
| 5S | `((havekeycards == 2 or havekeycards == 5) and trumpqueen)` |
| 5N | `(havekeycards == 2 and (D == 0 or H == 0 or S == 0))` |

### `3C-3D-4N-P`

| Call | Requires |
|---|---|
| P | `(true)` |
| 5C | `(havekeycards == 0 or havekeycards == 3)` |
| 5D | `(havekeycards == 1 or havekeycards == 4)` |
| 5H | `((havekeycards == 2 or havekeycards == 5) and not trumpqueen)` |
| 5S | `((havekeycards == 2 or havekeycards == 5) and trumpqueen)` |
| 5N | `(havekeycards == 2 and (D == 0 or H == 0 or S == 0))` |

### `3C-3H-4N-P`

| Call | Requires |
|---|---|
| P | `(true)` |
| 5C | `(havekeycards == 0 or havekeycards == 3)` |
| 5D | `(havekeycards == 1 or havekeycards == 4)` |
| 5H | `((havekeycards == 2 or havekeycards == 5) and not trumpqueen)` |
| 5S | `((havekeycards == 2 or havekeycards == 5) and trumpqueen)` |
| 5N | `(havekeycards == 2 and (D == 0 or H == 0 or S == 0))` |

### `3C-3S-4N-P`

| Call | Requires |
|---|---|
| P | `(true)` |
| 5C | `(havekeycards == 0 or havekeycards == 3)` |
| 5D | `(havekeycards == 1 or havekeycards == 4)` |
| 5H | `((havekeycards == 2 or havekeycards == 5) and not trumpqueen)` |
| 5S | `((havekeycards == 2 or havekeycards == 5) and trumpqueen)` |
| 5N | `(havekeycards == 2 and (D == 0 or H == 0 or S == 0))` |

### `3C-4C-4N-P`

| Call | Requires |
|---|---|
| P | `(true)` |
| 5C | `(havekeycards == 0 or havekeycards == 3)` |
| 5D | `(havekeycards == 1 or havekeycards == 4)` |
| 5H | `((havekeycards == 2 or havekeycards == 5) and not trumpqueen)` |
| 5S | `((havekeycards == 2 or havekeycards == 5) and trumpqueen)` |
| 5N | `(havekeycards == 2 and (D == 0 or H == 0 or S == 0))` |

### `3C-4H-4N-P`

| Call | Requires |
|---|---|
| P | `(true)` |
| 5C | `(havekeycards == 0 or havekeycards == 3)` |
| 5D | `(havekeycards == 1 or havekeycards == 4)` |
| 5H | `((havekeycards == 2 or havekeycards == 5) and not trumpqueen)` |
| 5S | `((havekeycards == 2 or havekeycards == 5) and trumpqueen)` |
| 5N | `(havekeycards == 2 and (D == 0 or H == 0 or S == 0))` |

### `3C-4S-4N-P`

| Call | Requires |
|---|---|
| P | `(true)` |
| 5C | `(havekeycards == 0 or havekeycards == 3)` |
| 5D | `(havekeycards == 1 or havekeycards == 4)` |
| 5H | `((havekeycards == 2 or havekeycards == 5) and not trumpqueen)` |
| 5S | `((havekeycards == 2 or havekeycards == 5) and trumpqueen)` |
| 5N | `(havekeycards == 2 and (D == 0 or H == 0 or S == 0))` |

### `3C-3N-4N-P`

| Call | Requires |
|---|---|
| P | `(true)` |
| 5C | `(havekeycards == 0 or havekeycards == 3)` |
| 5D | `(havekeycards == 1 or havekeycards == 4)` |
| 5H | `((havekeycards == 2 or havekeycards == 5) and not trumpqueen)` |
| 5S | `((havekeycards == 2 or havekeycards == 5) and trumpqueen)` |
| 5N | `(havekeycards == 2 and (D == 0 or H == 0 or S == 0))` |

### `3D-P-4N-P`

| Call | Requires |
|---|---|
| P | `(true)` |
| 5C | `(havekeycards == 0 or havekeycards == 3)` |
| 5D | `(havekeycards == 1 or havekeycards == 4)` |
| 5H | `((havekeycards == 2 or havekeycards == 5) and not trumpqueen)` |
| 5S | `((havekeycards == 2 or havekeycards == 5) and trumpqueen)` |
| 5N | `(havekeycards == 2 and (C == 0 or H == 0 or S == 0))` |
| 6C | `((havekeycards == 1 or havekeycards == 3) and C == 0)` |

### `3D-X-4N-P`

| Call | Requires |
|---|---|
| P | `(true)` |
| 5C | `(havekeycards == 0 or havekeycards == 3)` |
| 5D | `(havekeycards == 1 or havekeycards == 4)` |
| 5H | `((havekeycards == 2 or havekeycards == 5) and not trumpqueen)` |
| 5S | `((havekeycards == 2 or havekeycards == 5) and trumpqueen)` |
| 5N | `(havekeycards == 2 and (C == 0 or H == 0 or S == 0))` |
| 6C | `((havekeycards == 1 or havekeycards == 3) and C == 0)` |

### `3D-3H-4N-P`

| Call | Requires |
|---|---|
| P | `(true)` |
| 5C | `(havekeycards == 0 or havekeycards == 3)` |
| 5D | `(havekeycards == 1 or havekeycards == 4)` |
| 5H | `((havekeycards == 2 or havekeycards == 5) and not trumpqueen)` |
| 5S | `((havekeycards == 2 or havekeycards == 5) and trumpqueen)` |
| 5N | `(havekeycards == 2 and (D == 0 or H == 0 or S == 0))` |

### `3D-3S-4N-P`

| Call | Requires |
|---|---|
| P | `(true)` |
| 5C | `(havekeycards == 0 or havekeycards == 3)` |
| 5D | `(havekeycards == 1 or havekeycards == 4)` |
| 5H | `((havekeycards == 2 or havekeycards == 5) and not trumpqueen)` |
| 5S | `((havekeycards == 2 or havekeycards == 5) and trumpqueen)` |
| 5N | `(havekeycards == 2 and (D == 0 or H == 0 or S == 0))` |

### `3D-4C-4N-P`

| Call | Requires |
|---|---|
| P | `(true)` |
| 5C | `(havekeycards == 0 or havekeycards == 3)` |
| 5D | `(havekeycards == 1 or havekeycards == 4)` |
| 5H | `((havekeycards == 2 or havekeycards == 5) and not trumpqueen)` |
| 5S | `((havekeycards == 2 or havekeycards == 5) and trumpqueen)` |
| 5N | `(havekeycards == 2 and (C == 0 or H == 0 or S == 0))` |
| 6C | `((havekeycards == 1 or havekeycards == 3) and C == 0)` |

### `3D-4D-4N-P`

| Call | Requires |
|---|---|
| P | `(true)` |
| 5C | `(havekeycards == 0 or havekeycards == 3)` |
| 5D | `(havekeycards == 1 or havekeycards == 4)` |
| 5H | `((havekeycards == 2 or havekeycards == 5) and not trumpqueen)` |
| 5S | `((havekeycards == 2 or havekeycards == 5) and trumpqueen)` |
| 5N | `(havekeycards == 2 and (C == 0 or H == 0 or S == 0))` |
| 6C | `((havekeycards == 1 or havekeycards == 3) and C == 0)` |

### `3D-4H-4N-P`

| Call | Requires |
|---|---|
| P | `(true)` |
| 5C | `(havekeycards == 0 or havekeycards == 3)` |
| 5D | `(havekeycards == 1 or havekeycards == 4)` |
| 5H | `((havekeycards == 2 or havekeycards == 5) and not trumpqueen)` |
| 5S | `((havekeycards == 2 or havekeycards == 5) and trumpqueen)` |
| 5N | `(havekeycards == 2 and (C == 0 or H == 0 or S == 0))` |
| 6C | `((havekeycards == 1 or havekeycards == 3) and C == 0)` |

### `3D-4S-4N-P`

| Call | Requires |
|---|---|
| P | `(true)` |
| 5C | `(havekeycards == 0 or havekeycards == 3)` |
| 5D | `(havekeycards == 1 or havekeycards == 4)` |
| 5H | `((havekeycards == 2 or havekeycards == 5) and not trumpqueen)` |
| 5S | `((havekeycards == 2 or havekeycards == 5) and trumpqueen)` |
| 5N | `(havekeycards == 2 and (C == 0 or H == 0 or S == 0))` |
| 6C | `((havekeycards == 1 or havekeycards == 3) and C == 0)` |

### `3D-3N-4N-P`

| Call | Requires |
|---|---|
| P | `(true)` |
| 5C | `(havekeycards == 0 or havekeycards == 3)` |
| 5D | `(havekeycards == 1 or havekeycards == 4)` |
| 5H | `((havekeycards == 2 or havekeycards == 5) and not trumpqueen)` |
| 5S | `((havekeycards == 2 or havekeycards == 5) and trumpqueen)` |
| 5N | `(havekeycards == 2 and (C == 0 or H == 0 or S == 0))` |
| 6C | `((havekeycards == 1 or havekeycards == 3) and C == 0)` |

### `3H-P-4N-P`

| Call | Requires |
|---|---|
| P | `(true)` |
| 5C | `(havekeycards == 0 or havekeycards == 3)` |
| 5D | `(havekeycards == 1 or havekeycards == 4)` |
| 5H | `((havekeycards == 2 or havekeycards == 5) and not trumpqueen)` |
| 5S | `((havekeycards == 2 or havekeycards == 5) and trumpqueen)` |
| 5N | `(havekeycards == 2 and (C == 0 or D == 0 or S == 0))` |
| 6C | `((havekeycards == 1 or havekeycards == 3) and C == 0)` |
| 6D | `((havekeycards == 1 or havekeycards == 3) and D == 0)` |

### `3H-X-4N-P`

| Call | Requires |
|---|---|
| P | `(true)` |
| 5C | `(havekeycards == 0 or havekeycards == 3)` |
| 5D | `(havekeycards == 1 or havekeycards == 4)` |
| 5H | `((havekeycards == 2 or havekeycards == 5) and not trumpqueen)` |
| 5S | `((havekeycards == 2 or havekeycards == 5) and trumpqueen)` |
| 5N | `(havekeycards == 2 and (C == 0 or D == 0 or S == 0))` |
| 6C | `((havekeycards == 1 or havekeycards == 3) and C == 0)` |
| 6D | `((havekeycards == 1 or havekeycards == 3) and D == 0)` |

### `3H-3S-4N-P`

| Call | Requires |
|---|---|
| P | `(true)` |
| 5C | `(havekeycards == 0 or havekeycards == 3)` |
| 5D | `(havekeycards == 1 or havekeycards == 4)` |
| 5H | `((havekeycards == 2 or havekeycards == 5) and not trumpqueen)` |
| 5S | `((havekeycards == 2 or havekeycards == 5) and trumpqueen)` |
| 5N | `(havekeycards == 2 and (C == 0 or D == 0 or S == 0))` |
| 6C | `((havekeycards == 1 or havekeycards == 3) and C == 0)` |
| 6D | `((havekeycards == 1 or havekeycards == 3) and D == 0)` |

### `3H-4C-4N-P`

| Call | Requires |
|---|---|
| P | `(true)` |
| 5C | `(havekeycards == 0 or havekeycards == 3)` |
| 5D | `(havekeycards == 1 or havekeycards == 4)` |
| 5H | `((havekeycards == 2 or havekeycards == 5) and not trumpqueen)` |
| 5S | `((havekeycards == 2 or havekeycards == 5) and trumpqueen)` |
| 5N | `(havekeycards == 2 and (C == 0 or D == 0 or S == 0))` |
| 6C | `((havekeycards == 1 or havekeycards == 3) and C == 0)` |
| 6D | `((havekeycards == 1 or havekeycards == 3) and D == 0)` |

### `3H-4D-4N-P`

| Call | Requires |
|---|---|
| P | `(true)` |
| 5C | `(havekeycards == 0 or havekeycards == 3)` |
| 5D | `(havekeycards == 1 or havekeycards == 4)` |
| 5H | `((havekeycards == 2 or havekeycards == 5) and not trumpqueen)` |
| 5S | `((havekeycards == 2 or havekeycards == 5) and trumpqueen)` |
| 5N | `(havekeycards == 2 and (C == 0 or D == 0 or S == 0))` |
| 6C | `((havekeycards == 1 or havekeycards == 3) and C == 0)` |
| 6D | `((havekeycards == 1 or havekeycards == 3) and D == 0)` |

### `3H-4H-4N-P`

| Call | Requires |
|---|---|
| P | `(true)` |
| 5C | `(havekeycards == 0 or havekeycards == 3)` |
| 5D | `(havekeycards == 1 or havekeycards == 4)` |
| 5H | `((havekeycards == 2 or havekeycards == 5) and not trumpqueen)` |
| 5S | `((havekeycards == 2 or havekeycards == 5) and trumpqueen)` |
| 5N | `(havekeycards == 2 and (C == 0 or D == 0 or S == 0))` |
| 6C | `((havekeycards == 1 or havekeycards == 3) and C == 0)` |
| 6D | `((havekeycards == 1 or havekeycards == 3) and D == 0)` |

### `3H-4S-4N-P`

| Call | Requires |
|---|---|
| P | `(true)` |
| 5C | `(havekeycards == 0 or havekeycards == 3)` |
| 5D | `(havekeycards == 1 or havekeycards == 4)` |
| 5H | `((havekeycards == 2 or havekeycards == 5) and not trumpqueen)` |
| 5S | `((havekeycards == 2 or havekeycards == 5) and trumpqueen)` |
| 5N | `(havekeycards == 2 and (C == 0 or D == 0 or S == 0))` |
| 6C | `((havekeycards == 1 or havekeycards == 3) and C == 0)` |
| 6D | `((havekeycards == 1 or havekeycards == 3) and D == 0)` |

### `3H-3N-4N-P`

| Call | Requires |
|---|---|
| P | `(true)` |
| 5C | `(havekeycards == 0 or havekeycards == 3)` |
| 5D | `(havekeycards == 1 or havekeycards == 4)` |
| 5H | `((havekeycards == 2 or havekeycards == 5) and not trumpqueen)` |
| 5S | `((havekeycards == 2 or havekeycards == 5) and trumpqueen)` |
| 5N | `(havekeycards == 2 and (C == 0 or D == 0 or S == 0))` |
| 6C | `((havekeycards == 1 or havekeycards == 3) and C == 0)` |
| 6D | `((havekeycards == 1 or havekeycards == 3) and D == 0)` |

### `3S-P-4N-P`

| Call | Requires |
|---|---|
| 5C | `(havekeycards == 0 or havekeycards == 3)` |
| 5D | `(havekeycards == 1 or havekeycards == 4)` |
| 5H | `((havekeycards == 2 or havekeycards == 5) and not trumpqueen)` |
| 5S | `((havekeycards == 2 or havekeycards == 5) and trumpqueen)` |
| 5N | `(havekeycards == 2 and (C == 0 or D == 0 or H == 0))` |
| 6C | `((havekeycards == 1 or havekeycards == 3) and C == 0)` |
| 6D | `((havekeycards == 1 or havekeycards == 3) and D == 0)` |
| 6H | `((havekeycards == 1 or havekeycards == 3) and H == 0)` |

### `3S-X-4N-P`

| Call | Requires |
|---|---|
| 5C | `(havekeycards == 0 or havekeycards == 3)` |
| 5D | `(havekeycards == 1 or havekeycards == 4)` |
| 5H | `((havekeycards == 2 or havekeycards == 5) and not trumpqueen)` |
| 5S | `((havekeycards == 2 or havekeycards == 5) and trumpqueen)` |
| 5N | `(havekeycards == 2 and (C == 0 or D == 0 or H == 0))` |
| 6C | `((havekeycards == 1 or havekeycards == 3) and C == 0)` |
| 6D | `((havekeycards == 1 or havekeycards == 3) and D == 0)` |
| 6H | `((havekeycards == 1 or havekeycards == 3) and H == 0)` |

### `3S-4C-4N-P`

| Call | Requires |
|---|---|
| 5C | `(havekeycards == 0 or havekeycards == 3)` |
| 5D | `(havekeycards == 1 or havekeycards == 4)` |
| 5H | `((havekeycards == 2 or havekeycards == 5) and not trumpqueen)` |
| 5S | `((havekeycards == 2 or havekeycards == 5) and trumpqueen)` |
| 5N | `(havekeycards == 2 and (C == 0 or D == 0 or H == 0))` |
| 6C | `((havekeycards == 1 or havekeycards == 3) and C == 0)` |
| 6D | `((havekeycards == 1 or havekeycards == 3) and D == 0)` |
| 6H | `((havekeycards == 1 or havekeycards == 3) and H == 0)` |

### `3S-4D-4N-P`

| Call | Requires |
|---|---|
| 5C | `(havekeycards == 0 or havekeycards == 3)` |
| 5D | `(havekeycards == 1 or havekeycards == 4)` |
| 5H | `((havekeycards == 2 or havekeycards == 5) and not trumpqueen)` |
| 5S | `((havekeycards == 2 or havekeycards == 5) and trumpqueen)` |
| 5N | `(havekeycards == 2 and (C == 0 or D == 0 or H == 0))` |
| 6C | `((havekeycards == 1 or havekeycards == 3) and C == 0)` |
| 6D | `((havekeycards == 1 or havekeycards == 3) and D == 0)` |
| 6H | `((havekeycards == 1 or havekeycards == 3) and H == 0)` |

### `3S-4H-4N-P`

| Call | Requires |
|---|---|
| 5C | `(havekeycards == 0 or havekeycards == 3)` |
| 5D | `(havekeycards == 1 or havekeycards == 4)` |
| 5H | `((havekeycards == 2 or havekeycards == 5) and not trumpqueen)` |
| 5S | `((havekeycards == 2 or havekeycards == 5) and trumpqueen)` |
| 5N | `(havekeycards == 2 and (C == 0 or D == 0 or H == 0))` |
| 6C | `((havekeycards == 1 or havekeycards == 3) and C == 0)` |
| 6D | `((havekeycards == 1 or havekeycards == 3) and D == 0)` |
| 6H | `((havekeycards == 1 or havekeycards == 3) and H == 0)` |

### `3S-4S-4N-P`

| Call | Requires |
|---|---|
| 5C | `(havekeycards == 0 or havekeycards == 3)` |
| 5D | `(havekeycards == 1 or havekeycards == 4)` |
| 5H | `((havekeycards == 2 or havekeycards == 5) and not trumpqueen)` |
| 5S | `((havekeycards == 2 or havekeycards == 5) and trumpqueen)` |
| 5N | `(havekeycards == 2 and (C == 0 or D == 0 or H == 0))` |
| 6C | `((havekeycards == 1 or havekeycards == 3) and C == 0)` |
| 6D | `((havekeycards == 1 or havekeycards == 3) and D == 0)` |
| 6H | `((havekeycards == 1 or havekeycards == 3) and H == 0)` |

### `3S-3N-4N-P`

| Call | Requires |
|---|---|
| 5C | `(havekeycards == 0 or havekeycards == 3)` |
| 5D | `(havekeycards == 1 or havekeycards == 4)` |
| 5H | `((havekeycards == 2 or havekeycards == 5) and not trumpqueen)` |
| 5S | `((havekeycards == 2 or havekeycards == 5) and trumpqueen)` |
| 5N | `(havekeycards == 2 and (C == 0 or D == 0 or H == 0))` |
| 6C | `((havekeycards == 1 or havekeycards == 3) and C == 0)` |
| 6D | `((havekeycards == 1 or havekeycards == 3) and D == 0)` |
| 6H | `((havekeycards == 1 or havekeycards == 3) and H == 0)` |

### `4C-P-4N-P`

| Call | Requires |
|---|---|
| P | `(true)` |
| 5C | `(havekeycards == 0 or havekeycards == 3)` |
| 5D | `(havekeycards == 1 or havekeycards == 4)` |
| 5H | `((havekeycards == 2 or havekeycards == 5) and not trumpqueen)` |
| 5S | `((havekeycards == 2 or havekeycards == 5) and trumpqueen)` |
| 5N | `(havekeycards == 2 and (D == 0 or H == 0 or S == 0))` |

### `4C-X-4N-P`

| Call | Requires |
|---|---|
| P | `(true)` |
| 5C | `(havekeycards == 0 or havekeycards == 3)` |
| 5D | `(havekeycards == 1 or havekeycards == 4)` |
| 5H | `((havekeycards == 2 or havekeycards == 5) and not trumpqueen)` |
| 5S | `((havekeycards == 2 or havekeycards == 5) and trumpqueen)` |
| 5N | `(havekeycards == 2 and (D == 0 or H == 0 or S == 0))` |

### `4C-4H-4N-P`

| Call | Requires |
|---|---|
| P | `(true)` |
| 5C | `(havekeycards == 0 or havekeycards == 3)` |
| 5D | `(havekeycards == 1 or havekeycards == 4)` |
| 5H | `((havekeycards == 2 or havekeycards == 5) and not trumpqueen)` |
| 5S | `((havekeycards == 2 or havekeycards == 5) and trumpqueen)` |
| 5N | `(havekeycards == 2 and (D == 0 or H == 0 or S == 0))` |

### `4C-4S-4N-P`

| Call | Requires |
|---|---|
| P | `(true)` |
| 5C | `(havekeycards == 0 or havekeycards == 3)` |
| 5D | `(havekeycards == 1 or havekeycards == 4)` |
| 5H | `((havekeycards == 2 or havekeycards == 5) and not trumpqueen)` |
| 5S | `((havekeycards == 2 or havekeycards == 5) and trumpqueen)` |
| 5N | `(havekeycards == 2 and (D == 0 or H == 0 or S == 0))` |

### `4D-P-4N-P`

| Call | Requires |
|---|---|
| P | `(true)` |
| 5C | `(havekeycards == 0 or havekeycards == 3)` |
| 5D | `(havekeycards == 1 or havekeycards == 4)` |
| 5H | `((havekeycards == 2 or havekeycards == 5) and not trumpqueen)` |
| 5S | `((havekeycards == 2 or havekeycards == 5) and trumpqueen)` |
| 5N | `(havekeycards == 2 and (C == 0 or H == 0 or S == 0))` |
| 6C | `((havekeycards == 1 or havekeycards == 3) and C == 0)` |

### `4D-X-4N-P`

| Call | Requires |
|---|---|
| P | `(true)` |
| 5C | `(havekeycards == 0 or havekeycards == 3)` |
| 5D | `(havekeycards == 1 or havekeycards == 4)` |
| 5H | `((havekeycards == 2 or havekeycards == 5) and not trumpqueen)` |
| 5S | `((havekeycards == 2 or havekeycards == 5) and trumpqueen)` |
| 5N | `(havekeycards == 2 and (C == 0 or H == 0 or S == 0))` |
| 6C | `((havekeycards == 1 or havekeycards == 3) and C == 0)` |

### `4D-4H-4N-P`

| Call | Requires |
|---|---|
| P | `(true)` |
| 5C | `(havekeycards == 0 or havekeycards == 3)` |
| 5D | `(havekeycards == 1 or havekeycards == 4)` |
| 5H | `((havekeycards == 2 or havekeycards == 5) and not trumpqueen)` |
| 5S | `((havekeycards == 2 or havekeycards == 5) and trumpqueen)` |
| 5N | `(havekeycards == 2 and (C == 0 or H == 0 or S == 0))` |
| 6C | `((havekeycards == 1 or havekeycards == 3) and C == 0)` |

### `4D-4S-4N-P`

| Call | Requires |
|---|---|
| P | `(true)` |
| 5C | `(havekeycards == 0 or havekeycards == 3)` |
| 5D | `(havekeycards == 1 or havekeycards == 4)` |
| 5H | `((havekeycards == 2 or havekeycards == 5) and not trumpqueen)` |
| 5S | `((havekeycards == 2 or havekeycards == 5) and trumpqueen)` |
| 5N | `(havekeycards == 2 and (C == 0 or H == 0 or S == 0))` |
| 6C | `((havekeycards == 1 or havekeycards == 3) and C == 0)` |

### `4H-P-4N-P`

| Call | Requires |
|---|---|
| P | `(true)` |
| 5C | `(havekeycards == 0 or havekeycards == 3)` |
| 5D | `(havekeycards == 1 or havekeycards == 4)` |
| 5H | `((havekeycards == 2 or havekeycards == 5) and not trumpqueen)` |
| 5S | `((havekeycards == 2 or havekeycards == 5) and trumpqueen)` |
| 5N | `(havekeycards == 2 and (C == 0 or D == 0 or S == 0))` |
| 6C | `((havekeycards == 1 or havekeycards == 3) and C == 0)` |
| 6D | `((havekeycards == 1 or havekeycards == 3) and D == 0)` |

### `4H-X-4N-P`

| Call | Requires |
|---|---|
| P | `(true)` |
| 5C | `(havekeycards == 0 or havekeycards == 3)` |
| 5D | `(havekeycards == 1 or havekeycards == 4)` |
| 5H | `((havekeycards == 2 or havekeycards == 5) and not trumpqueen)` |
| 5S | `((havekeycards == 2 or havekeycards == 5) and trumpqueen)` |
| 5N | `(havekeycards == 2 and (C == 0 or D == 0 or S == 0))` |
| 6C | `((havekeycards == 1 or havekeycards == 3) and C == 0)` |
| 6D | `((havekeycards == 1 or havekeycards == 3) and D == 0)` |

### `4H-4S-4N-P`

| Call | Requires |
|---|---|
| P | `(true)` |
| 5C | `(havekeycards == 0 or havekeycards == 3)` |
| 5D | `(havekeycards == 1 or havekeycards == 4)` |
| 5H | `((havekeycards == 2 or havekeycards == 5) and not trumpqueen)` |
| 5S | `((havekeycards == 2 or havekeycards == 5) and trumpqueen)` |
| 5N | `(havekeycards == 2 and (C == 0 or D == 0 or S == 0))` |
| 6C | `((havekeycards == 1 or havekeycards == 3) and C == 0)` |
| 6D | `((havekeycards == 1 or havekeycards == 3) and D == 0)` |

### `4S-P-4N-P`

| Call | Requires |
|---|---|
| 5C | `(havekeycards == 0 or havekeycards == 3)` |
| 5D | `(havekeycards == 1 or havekeycards == 4)` |
| 5H | `((havekeycards == 2 or havekeycards == 5) and not trumpqueen)` |
| 5S | `((havekeycards == 2 or havekeycards == 5) and trumpqueen)` |
| 5N | `(havekeycards == 2 and (C == 0 or D == 0 or H == 0))` |
| 6C | `((havekeycards == 1 or havekeycards == 3) and C == 0)` |
| 6D | `((havekeycards == 1 or havekeycards == 3) and D == 0)` |
| 6H | `((havekeycards == 1 or havekeycards == 3) and H == 0)` |

### `4S-X-4N-P`

| Call | Requires |
|---|---|
| 5C | `(havekeycards == 0 or havekeycards == 3)` |
| 5D | `(havekeycards == 1 or havekeycards == 4)` |
| 5H | `((havekeycards == 2 or havekeycards == 5) and not trumpqueen)` |
| 5S | `((havekeycards == 2 or havekeycards == 5) and trumpqueen)` |
| 5N | `(havekeycards == 2 and (C == 0 or D == 0 or H == 0))` |
| 6C | `((havekeycards == 1 or havekeycards == 3) and C == 0)` |
| 6D | `((havekeycards == 1 or havekeycards == 3) and D == 0)` |
| 6H | `((havekeycards == 1 or havekeycards == 3) and H == 0)` |

---

## Other 4NT positions (quantitative / notrump-ish) — 69

### `1C-4N-P`

| Call | Requires |
|---|---|
| P | `(makessense)` |

### `1D-4N-P`

| Call | Requires |
|---|---|
| P | `(makessense)` |

### `1H-4N-P`

| Call | Requires |
|---|---|
| P | `(makessense)` |

### `1S-4N-P`

| Call | Requires |
|---|---|
| P | `(makessense)` |

### `2C-4N-P`

| Call | Requires |
|---|---|
| P | `(makessense)` |

### `2D-4N-P`

| Call | Requires |
|---|---|
| P | `(makessense)` |

### `2H-4N-P`

| Call | Requires |
|---|---|
| 5C | `(preference('C') and C >= 2)` |
| 5D | `(preference('D') and D >= 2)` |
| 5S | `(S >= 7)` |
| 5S | `(twicerebiddable('S') and loserlevel >= 5)` |
| 6C | `(C >= 3 and covers('C') >= 4) \| (preference('C') and covers('C') >= 5)` |
| 6D | `(D >= 3 and covers('D') >= 4) \| (preference('D') and covers('D') >= 5)` |

### `2S-4N-P`

| Call | Requires |
|---|---|
| 5C | `(preference('C') and C >= 2)` |
| 5D | `(preference('D') and D >= 2)` |
| 5H | `(H >= 7)` |
| 5H | `(twicerebiddable('H') and loserlevel >= 5)` |
| 6C | `(C >= 3 and covers('C') >= 4) \| (preference('C') and covers('C') >= 5)` |
| 6D | `(D >= 3 and covers('D') >= 4) \| (preference('D') and covers('D') >= 5)` |

### `3C-4N-P`

| Call | Requires |
|---|---|
| P | `(makessense)` |

### `3D-4N-P`

| Call | Requires |
|---|---|
| P | `(makessense)` |

### `3H-4N-P`

| Call | Requires |
|---|---|
| 5C | `(bestminor('C'))` |
| 5D | `(bestminor('D'))` |
| 6C | `(bestminor('C') and C >= 4 and C_points >= 14)` |
| 6D | `(bestminor('D') and D >= 4 and D_points >= 14)` |

### `3S-4N-P`

| Call | Requires |
|---|---|
| 5C | `(bestminor('C'))` |
| 5D | `(bestminor('D'))` |
| 6C | `(bestminor('C') and C >= 4 and C_points >= 14)` |
| 6D | `(bestminor('D') and D >= 4 and D_points >= 14)` |

### `4C-4N-P`

| Call | Requires |
|---|---|
| P | `(makessense)` |

### `4D-4N-P`

| Call | Requires |
|---|---|
| P | `(makessense)` |

### `4H-4N-P`

| Call | Requires |
|---|---|
| 5C | `(bestminor('C'))` |
| 5D | `(bestminor('D'))` |
| 6C | `(bestminor('C') and CanBid6_C)` |
| 6D | `(bestminor('D') and CanBid6_D)` |

### `4S-4N-P`

| Call | Requires |
|---|---|
| 5C | `(bestminor('C'))` |
| 5D | `(bestminor('D'))` |
| 5H | `(H >= 5 and H >= D and H >= C)` |
| 6C | `(bestminor('C') and CanBid6_C)` |
| 6D | `(bestminor('D') and CanBid6_D)` |
| 6H | `(H >= 5 and CanBid6_H)` |

### `1N-4N-P`

| Call | Requires |
|---|---|
| P | `(true) \| (min)` |
| 5N | `(not min and not balanced and S <= 5 and H <= 5 and D <= 5 and C <= 5)` |
| 6C | `(not min and reBiddable('C'))` |
| 6D | `(not min and reBiddable('D'))` |
| 6H | `(not min and H >= 6)` |
| 6H | `(not min and Fit('H'))` |
| 6S | `(not min and S >= 6)` |
| 6S | `(not min and Fit('S'))` |
| 6N | `(not min)` |
| 7N | `(CanBid7NT)` |

### `2N-4N-P`

| Call | Requires |
|---|---|
| P | `(true) \| (min)` |
| 5N | `(not min and not balanced and S <= 5 and H <= 5 and D <= 5 and C <= 5)` |
| 6C | `(not min and reBiddable('C'))` |
| 6D | `(not min and reBiddable('D'))` |
| 6H | `(not min and H >= 6)` |
| 6H | `(not min and Fit('H'))` |
| 6S | `(not min and S >= 6)` |
| 6S | `(not min and Fit('S'))` |
| 6N | `(not min)` |
| 7N | `(CanBid7NT)` |

### `3N-4N-P`

| Call | Requires |
|---|---|
| P | `(true) \| (min)` |
| 5N | `(not min and not balanced and S <= 5 and H <= 5 and D <= 5 and C <= 5)` |
| 6C | `(not min and reBiddable('C'))` |
| 6D | `(not min and reBiddable('D'))` |
| 6H | `(not min and H >= 6)` |
| 6H | `(not min and Fit('H'))` |
| 6S | `(not min and S >= 6)` |
| 6S | `(not min and Fit('S'))` |
| 6N | `(not min)` |
| 7N | `(CanBid7NT)` |

### `P-P-4N-P`

| Call | Requires |
|---|---|
| P | `(true) \| (min)` |
| 5N | `(not min and not balanced and S <= 5 and H <= 5 and D <= 5 and C <= 5)` |
| 6C | `(not min and reBiddable('C'))` |
| 6D | `(not min and reBiddable('D'))` |
| 6H | `(not min and H >= 6)` |
| 6H | `(not min and Fit('H'))` |
| 6S | `(not min and S >= 6)` |
| 6S | `(not min and Fit('S'))` |
| 6N | `(not min)` |
| 7N | `(CanBid7NT)` |

### `P-1C-4N-P`

| Call | Requires |
|---|---|
| P | `(makessense)` |

### `P-1D-4N-P`

| Call | Requires |
|---|---|
| P | `(makessense)` |

### `P-1H-4N-P`

| Call | Requires |
|---|---|
| P | `(makessense)` |

### `P-1S-4N-P`

| Call | Requires |
|---|---|
| P | `(makessense)` |

### `P-2C-4N-P`

| Call | Requires |
|---|---|
| P | `(makessense)` |

### `P-2D-4N-P`

| Call | Requires |
|---|---|
| P | `(makessense)` |

### `P-2H-4N-P`

| Call | Requires |
|---|---|
| 5C | `(preference('C') and C >= 2)` |
| 5D | `(preference('D') and D >= 2)` |
| 5S | `(S >= 7)` |
| 5S | `(twicerebiddable('S') and loserlevel >= 5)` |
| 6C | `(C >= 3 and covers('C') >= 4) \| (preference('C') and covers('C') >= 5)` |
| 6D | `(D >= 3 and covers('D') >= 4) \| (preference('D') and covers('D') >= 5)` |

### `P-2S-4N-P`

| Call | Requires |
|---|---|
| 5C | `(preference('C') and C >= 2)` |
| 5D | `(preference('D') and D >= 2)` |
| 5H | `(H >= 7)` |
| 5H | `(twicerebiddable('H') and loserlevel >= 5)` |
| 6C | `(C >= 3 and covers('C') >= 4) \| (preference('C') and covers('C') >= 5)` |
| 6D | `(D >= 3 and covers('D') >= 4) \| (preference('D') and covers('D') >= 5)` |

### `P-3C-4N-P`

| Call | Requires |
|---|---|
| P | `(makessense)` |

### `P-3D-4N-P`

| Call | Requires |
|---|---|
| P | `(makessense)` |

### `P-3H-4N-P`

| Call | Requires |
|---|---|
| 5C | `(bestminor('C'))` |
| 5D | `(bestminor('D'))` |
| 6C | `(bestminor('C') and C >= 4 and C_points >= 14)` |
| 6D | `(bestminor('D') and D >= 4 and D_points >= 14)` |

### `P-3S-4N-P`

| Call | Requires |
|---|---|
| 5C | `(bestminor('C'))` |
| 5D | `(bestminor('D'))` |
| 6C | `(bestminor('C') and C >= 4 and C_points >= 14)` |
| 6D | `(bestminor('D') and D >= 4 and D_points >= 14)` |

### `P-4C-4N-P`

| Call | Requires |
|---|---|
| P | `(makessense)` |

### `P-4D-4N-P`

| Call | Requires |
|---|---|
| P | `(makessense)` |

### `P-4H-4N-P`

| Call | Requires |
|---|---|
| 5C | `(bestminor('C'))` |
| 5D | `(bestminor('D'))` |
| 6C | `(bestminor('C') and CanBid6_C)` |
| 6D | `(bestminor('D') and CanBid6_D)` |

### `P-4S-4N-P`

| Call | Requires |
|---|---|
| 5C | `(bestminor('C'))` |
| 5D | `(bestminor('D'))` |
| 5H | `(H >= 5 and H >= D and H >= C)` |
| 6C | `(bestminor('C') and CanBid6_C)` |
| 6D | `(bestminor('D') and CanBid6_D)` |
| 6H | `(H >= 5 and CanBid6_H)` |

### `P-1N-4N-P`

| Call | Requires |
|---|---|
| P | `(true) \| (min)` |
| 5N | `(not min and not balanced and S <= 5 and H <= 5 and D <= 5 and C <= 5)` |
| 6C | `(not min and reBiddable('C'))` |
| 6D | `(not min and reBiddable('D'))` |
| 6H | `(not min and H >= 6)` |
| 6H | `(not min and Fit('H'))` |
| 6S | `(not min and S >= 6)` |
| 6S | `(not min and Fit('S'))` |
| 6N | `(not min)` |
| 7N | `(CanBid7NT)` |

### `P-2N-4N-P`

| Call | Requires |
|---|---|
| P | `(true) \| (min)` |
| 5N | `(not min and not balanced and S <= 5 and H <= 5 and D <= 5 and C <= 5)` |
| 6C | `(not min and reBiddable('C'))` |
| 6D | `(not min and reBiddable('D'))` |
| 6H | `(not min and H >= 6)` |
| 6H | `(not min and Fit('H'))` |
| 6S | `(not min and S >= 6)` |
| 6S | `(not min and Fit('S'))` |
| 6N | `(not min)` |
| 7N | `(CanBid7NT)` |

### `P-3N-4N-P`

| Call | Requires |
|---|---|
| P | `(true) \| (min)` |
| 5N | `(not min and not balanced and S <= 5 and H <= 5 and D <= 5 and C <= 5)` |
| 6C | `(not min and reBiddable('C'))` |
| 6D | `(not min and reBiddable('D'))` |
| 6H | `(not min and H >= 6)` |
| 6H | `(not min and Fit('H'))` |
| 6S | `(not min and S >= 6)` |
| 6S | `(not min and Fit('S'))` |
| 6N | `(not min)` |
| 7N | `(CanBid7NT)` |

### `2C-P-4N-P`

| Call | Requires |
|---|---|
| P | `(true) \| (min)` |
| 5N | `(not min and not balanced and S <= 5 and H <= 5 and D <= 5 and C <= 5)` |
| 6C | `(not min and reBiddable('C'))` |
| 6D | `(not min and reBiddable('D'))` |
| 6H | `(not min and H >= 6)` |
| 6H | `(not min and Fit('H'))` |
| 6S | `(not min and S >= 6)` |
| 6S | `(not min and Fit('S'))` |
| 6N | `(not min)` |
| 7N | `(CanBid7NT)` |

### `1N-P-4N-P`

| Call | Requires |
|---|---|
| P | `(true) \| (min)` |
| 5N | `(not min and not balanced and S <= 5 and H <= 5 and D <= 5 and C <= 5)` |
| 6C | `(not min and reBiddable('C'))` |
| 6D | `(not min and reBiddable('D'))` |
| 6H | `(not min and H >= 6)` |
| 6H | `(not min and Fit('H'))` |
| 6S | `(not min and S >= 6)` |
| 6S | `(not min and Fit('S'))` |
| 6N | `(not min)` |
| 7N | `(CanBid7NT)` |

### `2N-P-4N-P`

| Call | Requires |
|---|---|
| P | `(true) \| (min)` |
| 5N | `(not min and not balanced and S <= 5 and H <= 5 and D <= 5 and C <= 5)` |
| 6C | `(not min and reBiddable('C'))` |
| 6D | `(not min and reBiddable('D'))` |
| 6H | `(not min and H >= 6)` |
| 6H | `(not min and Fit('H'))` |
| 6S | `(not min and S >= 6)` |
| 6S | `(not min and Fit('S'))` |
| 6N | `(not min)` |
| 7N | `(CanBid7NT)` |

### `3N-P-4N-P`

| Call | Requires |
|---|---|
| P | `(true) \| (min)` |
| 5N | `(not min and not balanced and S <= 5 and H <= 5 and D <= 5 and C <= 5)` |
| 6C | `(not min and reBiddable('C'))` |
| 6D | `(not min and reBiddable('D'))` |
| 6H | `(not min and H >= 6)` |
| 6H | `(not min and Fit('H'))` |
| 6S | `(not min and S >= 6)` |
| 6S | `(not min and Fit('S'))` |
| 6N | `(not min)` |
| 7N | `(CanBid7NT)` |

### `1N-X-4N-P`

| Call | Requires |
|---|---|
| P | `(true) \| (min)` |
| 5N | `(not min and not balanced and S <= 5 and H <= 5 and D <= 5 and C <= 5)` |
| 6C | `(not min and reBiddable('C'))` |
| 6D | `(not min and reBiddable('D'))` |
| 6H | `(not min and H >= 6)` |
| 6H | `(not min and Fit('H'))` |
| 6S | `(not min and S >= 6)` |
| 6S | `(not min and Fit('S'))` |
| 6N | `(not min)` |
| 7N | `(CanBid7NT)` |

### `1N-2C-4N-P`

| Call | Requires |
|---|---|
| P | `(true) \| (min)` |
| 5N | `(not min and not balanced and S <= 5 and H <= 5 and D <= 5 and C <= 5)` |
| 6C | `(not min and reBiddable('C'))` |
| 6D | `(not min and reBiddable('D'))` |
| 6H | `(not min and H >= 6)` |
| 6H | `(not min and Fit('H'))` |
| 6S | `(not min and S >= 6)` |
| 6S | `(not min and Fit('S'))` |
| 6N | `(not min)` |
| 7N | `(CanBid7NT)` |

### `1N-2D-4N-P`

| Call | Requires |
|---|---|
| P | `(true) \| (min)` |
| 5N | `(not min and not balanced and S <= 5 and H <= 5 and D <= 5 and C <= 5)` |
| 6C | `(not min and reBiddable('C'))` |
| 6D | `(not min and reBiddable('D'))` |
| 6H | `(not min and H >= 6)` |
| 6H | `(not min and Fit('H'))` |
| 6S | `(not min and S >= 6)` |
| 6S | `(not min and Fit('S'))` |
| 6N | `(not min)` |
| 7N | `(CanBid7NT)` |

### `1N-2H-4N-P`

| Call | Requires |
|---|---|
| P | `(true) \| (min)` |
| 5N | `(not min and not balanced and S <= 5 and H <= 5 and D <= 5 and C <= 5)` |
| 6C | `(not min and reBiddable('C'))` |
| 6D | `(not min and reBiddable('D'))` |
| 6H | `(not min and H >= 6)` |
| 6H | `(not min and Fit('H'))` |
| 6S | `(not min and S >= 6)` |
| 6S | `(not min and Fit('S'))` |
| 6N | `(not min)` |
| 7N | `(CanBid7NT)` |

### `1N-2S-4N-P`

| Call | Requires |
|---|---|
| P | `(true) \| (min)` |
| 5N | `(not min and not balanced and S <= 5 and H <= 5 and D <= 5 and C <= 5)` |
| 6C | `(not min and reBiddable('C'))` |
| 6D | `(not min and reBiddable('D'))` |
| 6H | `(not min and H >= 6)` |
| 6H | `(not min and Fit('H'))` |
| 6S | `(not min and S >= 6)` |
| 6S | `(not min and Fit('S'))` |
| 6N | `(not min)` |
| 7N | `(CanBid7NT)` |

### `1N-3C-4N-P`

| Call | Requires |
|---|---|
| P | `(true) \| (min)` |
| 5N | `(not min and not balanced and S <= 5 and H <= 5 and D <= 5 and C <= 5)` |
| 6C | `(not min and reBiddable('C'))` |
| 6D | `(not min and reBiddable('D'))` |
| 6H | `(not min and H >= 6)` |
| 6H | `(not min and Fit('H'))` |
| 6S | `(not min and S >= 6)` |
| 6S | `(not min and Fit('S'))` |
| 6N | `(not min)` |
| 7N | `(CanBid7NT)` |

### `2N-3C-4N-P`

| Call | Requires |
|---|---|
| P | `(true) \| (min)` |
| 5N | `(not min and not balanced and S <= 5 and H <= 5 and D <= 5 and C <= 5)` |
| 6C | `(not min and reBiddable('C'))` |
| 6D | `(not min and reBiddable('D'))` |
| 6H | `(not min and H >= 6)` |
| 6H | `(not min and Fit('H'))` |
| 6S | `(not min and S >= 6)` |
| 6S | `(not min and Fit('S'))` |
| 6N | `(not min)` |
| 7N | `(CanBid7NT)` |

### `1N-3D-4N-P`

| Call | Requires |
|---|---|
| P | `(true) \| (min)` |
| 5N | `(not min and not balanced and S <= 5 and H <= 5 and D <= 5 and C <= 5)` |
| 6C | `(not min and reBiddable('C'))` |
| 6D | `(not min and reBiddable('D'))` |
| 6H | `(not min and H >= 6)` |
| 6H | `(not min and Fit('H'))` |
| 6S | `(not min and S >= 6)` |
| 6S | `(not min and Fit('S'))` |
| 6N | `(not min)` |
| 7N | `(CanBid7NT)` |

### `2N-3D-4N-P`

| Call | Requires |
|---|---|
| P | `(true) \| (min)` |
| 5N | `(not min and not balanced and S <= 5 and H <= 5 and D <= 5 and C <= 5)` |
| 6C | `(not min and reBiddable('C'))` |
| 6D | `(not min and reBiddable('D'))` |
| 6H | `(not min and H >= 6)` |
| 6H | `(not min and Fit('H'))` |
| 6S | `(not min and S >= 6)` |
| 6S | `(not min and Fit('S'))` |
| 6N | `(not min)` |
| 7N | `(CanBid7NT)` |

### `1N-3H-4N-P`

| Call | Requires |
|---|---|
| P | `(true) \| (min)` |
| 5N | `(not min and not balanced and S <= 5 and H <= 5 and D <= 5 and C <= 5)` |
| 6C | `(not min and reBiddable('C'))` |
| 6D | `(not min and reBiddable('D'))` |
| 6H | `(not min and H >= 6)` |
| 6H | `(not min and Fit('H'))` |
| 6S | `(not min and S >= 6)` |
| 6S | `(not min and Fit('S'))` |
| 6N | `(not min)` |
| 7N | `(CanBid7NT)` |

### `2N-3H-4N-P`

| Call | Requires |
|---|---|
| P | `(true) \| (min)` |
| 5N | `(not min and not balanced and S <= 5 and H <= 5 and D <= 5 and C <= 5)` |
| 6C | `(not min and reBiddable('C'))` |
| 6D | `(not min and reBiddable('D'))` |
| 6H | `(not min and H >= 6)` |
| 6H | `(not min and Fit('H'))` |
| 6S | `(not min and S >= 6)` |
| 6S | `(not min and Fit('S'))` |
| 6N | `(not min)` |
| 7N | `(CanBid7NT)` |

### `1N-3S-4N-P`

| Call | Requires |
|---|---|
| P | `(true) \| (min)` |
| 5N | `(not min and not balanced and S <= 5 and H <= 5 and D <= 5 and C <= 5)` |
| 6C | `(not min and reBiddable('C'))` |
| 6D | `(not min and reBiddable('D'))` |
| 6H | `(not min and H >= 6)` |
| 6H | `(not min and Fit('H'))` |
| 6S | `(not min and S >= 6)` |
| 6S | `(not min and Fit('S'))` |
| 6N | `(not min)` |
| 7N | `(CanBid7NT)` |

### `2N-3S-4N-P`

| Call | Requires |
|---|---|
| P | `(true) \| (min)` |
| 5N | `(not min and not balanced and S <= 5 and H <= 5 and D <= 5 and C <= 5)` |
| 6C | `(not min and reBiddable('C'))` |
| 6D | `(not min and reBiddable('D'))` |
| 6H | `(not min and H >= 6)` |
| 6H | `(not min and Fit('H'))` |
| 6S | `(not min and S >= 6)` |
| 6S | `(not min and Fit('S'))` |
| 6N | `(not min)` |
| 7N | `(CanBid7NT)` |

### `1N-4C-4N-P`

| Call | Requires |
|---|---|
| P | `(true) \| (min)` |
| 5N | `(not min and not balanced and S <= 5 and H <= 5 and D <= 5 and C <= 5)` |
| 6C | `(not min and reBiddable('C'))` |
| 6D | `(not min and reBiddable('D'))` |
| 6H | `(not min and H >= 6)` |
| 6H | `(not min and Fit('H'))` |
| 6S | `(not min and S >= 6)` |
| 6S | `(not min and Fit('S'))` |
| 6N | `(not min)` |
| 7N | `(CanBid7NT)` |

### `2N-4C-4N-P`

| Call | Requires |
|---|---|
| P | `(true) \| (min)` |
| 5N | `(not min and not balanced and S <= 5 and H <= 5 and D <= 5 and C <= 5)` |
| 6C | `(not min and reBiddable('C'))` |
| 6D | `(not min and reBiddable('D'))` |
| 6H | `(not min and H >= 6)` |
| 6H | `(not min and Fit('H'))` |
| 6S | `(not min and S >= 6)` |
| 6S | `(not min and Fit('S'))` |
| 6N | `(not min)` |
| 7N | `(CanBid7NT)` |

### `3N-4C-4N-P`

| Call | Requires |
|---|---|
| P | `(true) \| (min)` |
| 5N | `(not min and not balanced and S <= 5 and H <= 5 and D <= 5 and C <= 5)` |
| 6C | `(not min and reBiddable('C'))` |
| 6D | `(not min and reBiddable('D'))` |
| 6H | `(not min and H >= 6)` |
| 6H | `(not min and Fit('H'))` |
| 6S | `(not min and S >= 6)` |
| 6S | `(not min and Fit('S'))` |
| 6N | `(not min)` |
| 7N | `(CanBid7NT)` |

### `1N-4D-4N-P`

| Call | Requires |
|---|---|
| P | `(true) \| (min)` |
| 5N | `(not min and not balanced and S <= 5 and H <= 5 and D <= 5 and C <= 5)` |
| 6C | `(not min and reBiddable('C'))` |
| 6D | `(not min and reBiddable('D'))` |
| 6H | `(not min and H >= 6)` |
| 6H | `(not min and Fit('H'))` |
| 6S | `(not min and S >= 6)` |
| 6S | `(not min and Fit('S'))` |
| 6N | `(not min)` |
| 7N | `(CanBid7NT)` |

### `2N-4D-4N-P`

| Call | Requires |
|---|---|
| P | `(true) \| (min)` |
| 5N | `(not min and not balanced and S <= 5 and H <= 5 and D <= 5 and C <= 5)` |
| 6C | `(not min and reBiddable('C'))` |
| 6D | `(not min and reBiddable('D'))` |
| 6H | `(not min and H >= 6)` |
| 6H | `(not min and Fit('H'))` |
| 6S | `(not min and S >= 6)` |
| 6S | `(not min and Fit('S'))` |
| 6N | `(not min)` |
| 7N | `(CanBid7NT)` |

### `3N-4D-4N-P`

| Call | Requires |
|---|---|
| P | `(true) \| (min)` |
| 5N | `(not min and not balanced and S <= 5 and H <= 5 and D <= 5 and C <= 5)` |
| 6C | `(not min and reBiddable('C'))` |
| 6D | `(not min and reBiddable('D'))` |
| 6H | `(not min and H >= 6)` |
| 6H | `(not min and Fit('H'))` |
| 6S | `(not min and S >= 6)` |
| 6S | `(not min and Fit('S'))` |
| 6N | `(not min)` |
| 7N | `(CanBid7NT)` |

### `1N-4H-4N-P`

| Call | Requires |
|---|---|
| P | `(true) \| (min)` |
| 5N | `(not min and not balanced and S <= 5 and H <= 5 and D <= 5 and C <= 5)` |
| 6C | `(not min and reBiddable('C'))` |
| 6D | `(not min and reBiddable('D'))` |
| 6H | `(not min and H >= 6)` |
| 6H | `(not min and Fit('H'))` |
| 6S | `(not min and S >= 6)` |
| 6S | `(not min and Fit('S'))` |
| 6N | `(not min)` |
| 7N | `(CanBid7NT)` |

### `2N-4H-4N-P`

| Call | Requires |
|---|---|
| P | `(true) \| (min)` |
| 5N | `(not min and not balanced and S <= 5 and H <= 5 and D <= 5 and C <= 5)` |
| 6C | `(not min and reBiddable('C'))` |
| 6D | `(not min and reBiddable('D'))` |
| 6H | `(not min and H >= 6)` |
| 6H | `(not min and Fit('H'))` |
| 6S | `(not min and S >= 6)` |
| 6S | `(not min and Fit('S'))` |
| 6N | `(not min)` |
| 7N | `(CanBid7NT)` |

### `3N-4H-4N-P`

| Call | Requires |
|---|---|
| P | `(true) \| (min)` |
| 5N | `(not min and not balanced and S <= 5 and H <= 5 and D <= 5 and C <= 5)` |
| 6C | `(not min and reBiddable('C'))` |
| 6D | `(not min and reBiddable('D'))` |
| 6H | `(not min and H >= 6)` |
| 6H | `(not min and Fit('H'))` |
| 6S | `(not min and S >= 6)` |
| 6S | `(not min and Fit('S'))` |
| 6N | `(not min)` |
| 7N | `(CanBid7NT)` |

### `1N-4S-4N-P`

| Call | Requires |
|---|---|
| P | `(true) \| (min)` |
| 5N | `(not min and not balanced and S <= 5 and H <= 5 and D <= 5 and C <= 5)` |
| 6C | `(not min and reBiddable('C'))` |
| 6D | `(not min and reBiddable('D'))` |
| 6H | `(not min and H >= 6)` |
| 6H | `(not min and Fit('H'))` |
| 6S | `(not min and S >= 6)` |
| 6S | `(not min and Fit('S'))` |
| 6N | `(not min)` |
| 7N | `(CanBid7NT)` |

### `2N-4S-4N-P`

| Call | Requires |
|---|---|
| P | `(true) \| (min)` |
| 5N | `(not min and not balanced and S <= 5 and H <= 5 and D <= 5 and C <= 5)` |
| 6C | `(not min and reBiddable('C'))` |
| 6D | `(not min and reBiddable('D'))` |
| 6H | `(not min and H >= 6)` |
| 6H | `(not min and Fit('H'))` |
| 6S | `(not min and S >= 6)` |
| 6S | `(not min and Fit('S'))` |
| 6N | `(not min)` |
| 7N | `(CanBid7NT)` |

### `3N-4S-4N-P`

| Call | Requires |
|---|---|
| P | `(true) \| (min)` |
| 5N | `(not min and not balanced and S <= 5 and H <= 5 and D <= 5 and C <= 5)` |
| 6C | `(not min and reBiddable('C'))` |
| 6D | `(not min and reBiddable('D'))` |
| 6H | `(not min and H >= 6)` |
| 6H | `(not min and Fit('H'))` |
| 6S | `(not min and S >= 6)` |
| 6S | `(not min and Fit('S'))` |
| 6N | `(not min)` |
| 7N | `(CanBid7NT)` |

### `1N-2N-4N-P`

| Call | Requires |
|---|---|
| P | `(true) \| (min)` |
| 5N | `(not min and not balanced and S <= 5 and H <= 5 and D <= 5 and C <= 5)` |
| 6C | `(not min and reBiddable('C'))` |
| 6D | `(not min and reBiddable('D'))` |
| 6H | `(not min and H >= 6)` |
| 6H | `(not min and Fit('H'))` |
| 6S | `(not min and S >= 6)` |
| 6S | `(not min and Fit('S'))` |
| 6N | `(not min)` |
| 7N | `(CanBid7NT)` |

