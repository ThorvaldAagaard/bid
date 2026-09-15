# Brill connector (`src/bid/brill`)

Talk to the remote Brill service (`https://brillservice.aalborgdata.dk`) from
this repo: ask what Brill would bid, pull its authored rule table, double-dummy
a deal, auction a whole board, or play one card at a time.

```python
from bid.brill import BrillClient, PlayState

c = BrillClient(cache_path="data/brill_cache.json")

# one bid
r = c.bid("AKQ2.J54.T98.762", ctx="1H-P", seat="S")
print(r.bid, "|", r.means, "|", r.requires)

# a whole board, card by card
st = PlayState.from_deal("N:... ... ... ...", ctx="1N-P-P-P")
st.play_out(c)
print(st.tricks(), st.result())
```

Command line:

```bash
python3 -m bid.brill version
python3 -m bid.brill bid "AKQ2.J54.T98.762" --ctx 1H-P --seat S
python3 -m bid.brill dd "N:AQJ2.AK3.QJ4.432 KT8.QJT9.K85.AQ7 9753.876.732.J98 64.542.AT96.KT65"
python3 -m bid.brill play "N:QT8.AKQ7.JT9.AT9 K97.JT84.72.KJ42 A2.965.AKQ854.83 J6543.32.63.Q765" --ctx 1N-P-P-P
```

---

## Layout

| module | what it holds |
| --- | --- |
| `client.py` | `BrillClient` — one method per endpoint, stdlib `urllib` only |
| `models.py` | typed results (`BidResult`, `PlayResult`, `DDTable`, ...) and errors |
| `convert.py` | repo types ↔ Brill wire formats (PBN hands/deals, calls, cards, vul) |
| `play.py` | `Contract`, `PlayState`, `trick_winner` — card-play bookkeeping |

Design constraints, in the order they bite:

* **stdlib only.** The project ships torch/numpy and nothing else; a connector
  must not drag in `requests`.
* **Offline-testable.** `transport=` takes any
  `(method, url, body) -> (status, text)`. `tests/test_brill_client.py` runs
  65 tests with zero network access.
* **No silent loss.** The published OpenAPI document declares **no response
  schemas at all** (`/dd` is typed as `Void`). Every shape here was recovered
  by calling the live service, and undocumented keys are kept on `.raw` so a
  service change shows up as a missing attribute rather than disappearing
  data.
* **Cacheable.** `cache_path=` gives a persistent JSON cache. Brill's rule
  set changes between builds, so `version().version` is the invalidation key.

---

## Wire formats that are easy to get silently wrong

Brill takes everything as strings on the query string. Four of them are not
what you would guess:

1. **PBN hands carry no suit letters.** `AKQJ.AKQ.AK.AKQJ` is spades, hearts,
   diamonds, clubs, ranks descending.
2. **PBN deals are `"<dealer>:<N> <E> <S> <W>"`** — hands always in compass
   order, *not* starting from the dealer. Verified against `/dd`.
3. **Vulnerability is spelled `None | NS | EW | All`.** `Both` is accepted and
   echoed as `All`; anything else is an HTTP 400.
4. **Notrump is `N`, not `NT`** — `1N`, and in `/dd` the strain key is `"N"`.

---

## `/play`: the undocumented contract

`/play` is the one endpoint whose parameter list does not explain itself, and
getting it wrong gives a bare HTTP 400. Its error bodies, however, are
unusually good teachers. Recovered by probing:

* **`played` has no separator at all** — a flat run of two-character cards,
  `"S7SA"`. Sending `"S7,SA"` gets *"has odd length. Cards must be 2
  characters each (Suit-Rank)"*.
* **Position 1 belongs to declarer's LHO** (the opening leader). Every
  position after that is the *real* play order — the winner of each trick
  leads the next one, so the list is **not** a repeating N-E-S-W cycle. The
  service checks every card against the hand it believes owns that position
  and names the seat in its error, which is how you read its internal
  assignment back.
* **`hand` must be the seat's original 13 cards.** Brill subtracts `played`
  itself; a 12-card remainder is *"has 12 cards (expected exactly 13)"*.
* **Zero cards played is not this endpoint.** It answers *"No cards played.
  For opening lead, use the /lead endpoint instead of /play."*

`PlayState` maintains all of that. Push cards, ask for the next one:

```python
st = PlayState.from_deal(deal, ctx="1N-P-P-P")
while not st.complete:
    st.push(st.ask(c).card)       # /lead for card 0, then /play
```

It also does its own follow-suit validation (`push` raises on a revoke) and
trick accounting (`tricks()`, `result()`), so it works with a local engine too.

**Validated end to end:** a full 52-card board against the live service with
no 400s, finishing at NS 12 tricks — exactly the `/dd` number for the same
deal. Since Brill rejects any card whose seat disagrees with its own
assignment, a clean run is proof that `PlayState`'s leader sequence matches
the service's.

### Response shape

```json
{"card": "DQ", "quality": 0.36, "matchpoint": false, "player": 1,
 "who": "BRILL", "tieBreakInfo": "[EQUALISE] S: DA -> DQ (touching group)"}
```

`player` is the position *within the current trick* (1 = the hand that led
it), not a seat. `who` is omitted when `quality` is 1.0 — Brill drops it for
double-dummy-exact answers rather than reporting a meaningless attribution.

---

## Endpoints

All 25 swagger paths are covered. The ones worth knowing:

| method | endpoint | notes |
| --- | --- | --- |
| `version()` | `/version` | `ruleCount`, commit — use as the cache key |
| `systems()` | `/systems` | `conventions=True` for the convention list |
| `bid()` | `/bid` | one hand, one position; returns `means` + `requires` |
| `bid_for_hand()` | `/bid` | defaults `seat` to the seat on lead after `history` |
| `bids()` | `/bids` | legal calls at a position |
| `get_responses()` | `/getresponses` | rules Brill *authors* here |
| `infer_responses()` | `/inferresponses` | meaning of calls Brill does *not* define |
| `explain()` | `/explain` | whole auction, call by call |
| `dd()` | `/dd` | double-dummy table; `best_contract()` |
| `autobid()` | `/autobid` | auction a board, no play |
| `autoplay()` | `/autoplay` | bid *and* play a board (slow) |
| `autoplay_start()` / `autoplay_status()` | `/autoplay/*` | async variant |
| `lead()` | `/lead` | opening lead |
| `play()` | `/play` | card in the current trick — see above |

`/explain` buries the useful text two levels down, under
`explanation[0].rawRuleMeans` / `explainingRuleInstance.resolvedMeans`;
`Explanation.from_json` lifts it.

---

## Errors

| error | raised when |
| --- | --- |
| `BrillBadRequest` | HTTP 4xx — never retried; `.status`, `.body`, `.url` |
| `BrillUnavailable` | transport failure or 5xx after all retries |
| `BrillContractError` | service answered in an unrecognised shape |

An empty `played` raises `ValueError` locally rather than spending a round
trip on a request the service would reject.

---

## Testing

`tests/test_brill_client.py` — 65 tests, no network. Covers URL construction,
PBN conversion, card/`played` encoding, contract derivation, trick winners,
`PlayState` bookkeeping, retry/backoff, caching (memory and on-disk), 4xx
mapping and response parsing.
