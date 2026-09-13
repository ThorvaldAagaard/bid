# The Brill bidding system

> Merged, single-file snapshot of the Brill bidding system.
>
> - **Source pages:** <https://brillsystem.aalborgdata.dk/index.html> (system summary) and <https://brillsystem.aalborgdata.dk/browse.html> (rule browser)
> - **Rule data:** `GET https://brillservice.aalborgdata.dk/getresponses?auction=<sequence>` — the endpoint `browse.html` itself calls.
> - **Fetched:** 2026-09-13
> - **Service:** Brill · 0.1.0+20260913.1018.g5039e2b-dirty · 1,040,694 rules in the engine
> - **Scope:** the complete tree to **2 calls** deep — 349 auctions, 3052 call definitions.
>
> The engine reports **1,040,694** rules in total, so the tree cannot be walked exhaustively. 33 auctions here are terminal (a 7-level call ends the bidding). 961 rows carry no authored description; the `requires` expression is then the whole definition. Regenerate with `python3 research/fetch_brill.py`.

## Contents

- [Part 1 — System summary](#part-1--system-summary) — prose: openings, responding, competing, slam bidding, conventions, leads and signals.
- [Part 2 — Rule tree](#part-2--rule-tree) — every call the system defines, with the requirement it was authored from.

---

## Part 1 — System summary

Brill's robots bid a natural two-over-one game forcing system: five-card majors, a better-minor 1♣/1♦, a 15–17 notrump and a strong 2♣. It leads and signals to the agreements below. This page is the summary; the rules themselves — every call the system defines, in every auction, with the requirement it was authored from — are one click away.

Browse the rules, call by call →

### Opening leads and signals

What we lead, and what a card means once it is played. The lead is where our carding message lives; the cards that follow say much less than a human partnership's would, and the last part of this section says exactly what they do and do not promise.

#### The card we lead

| Holding | Against a suit contract | Against notrump |
|---|---|---|
| AKQ… | Ace | Ace |
| AK, AKJ… | Ace | Ace — asking partner to unblock |
| KQJ, KQT, KQ(x) | King | King |
| QJT, QJ9, QJ(x) | Queen | Queen |
| JT9, T98 | Top of the sequence | Top of the sequence |
| AJT, KJT | The jack (or the ten) | The jack — interior sequence |
| Ax, Kx, Qx, Jx, Tx | The honour | The honour |
| xx | The higher | The higher |
| Axx, AQx… | Ace | Fourth best |
| Kxx, Qxx, Jxxx… | Small — see the count below | Fourth best |
| xxx and longer | Small — see the count below | Fourth best |
| A singleton | The card itself | The card itself |
| Trumps | Lowest | — |

#### Which small card — the count

From a holding with no honour sequence to lead, the spot card carries a length message, and it is a different one in each contract:

- Against a suit contract, 1–3–5: the higher from two cards, the third highest from three or four, the fifth highest from five or more. So the four from K♥T8543 is fifth best and says five or more; the same four from 854 is third best.

- Against notrump, fourth best — so the Rule of 11 works against us exactly as it should.

The agreement is applied to later leads in the hand too, not just to trick one, and only where the engine rates the candidate cards as equal in trick-taking terms — a lead that actually costs a trick is never made to satisfy a convention.

#### What a card means afterwards

- Following suit, we play the lowest of touching cards. An honour played while following therefore denies the card directly beneath it — a king denies the queen, a queen the jack. That is the one reliable message our defenders give each other, and it is read as such.

- We do not signal — yet. There is no attitude signal, no high-low to ask for a continuation, no even/odd count and no suit preference, and we do not read those signals from you either. Do not defend on the assumption that a spot card was chosen to tell partner something. This is the current state, not the intended one: a full set of signalling agreements is planned, and when it arrives it will be described here.

- Discards are deliberately random among cards of equal value, so the choice gives declarer nothing — and gives partner nothing either. No suit-preference message is being sent.

- Declaring, the choice is hidden: dummy plays the lowest of equal cards (they are face up, so there is nothing to conceal), while declarer picks among them at random, so the defence cannot read declarer's holding from a predictable card.

What the robots do read is the play itself rather than a code: which honours your lead places, how long the suit is if it was a fourth-best or a fifth-best card, an honour you bared, a ruff you declined, a trick you could have won and did not. Those inferences reweight the hands it considers possible; a conventional signal is not needed for them, and one that contradicts your actual cards will not fool it for long.

### Openings

| Opening | Shows |
|---|---|
| 1♣ / 1♦ | 12–21 HCP, 3+ cards. The longer minor; with 4–4–3–2 shape 1♦, with a 4–3–3–3 family 1♣. |
| 1♥ / 1♠ | 12–21 HCP, 5+ cards. An 11-count opens too when it is 5–4 in the majors or holds a six-card major, and in fourth seat on the Rule of 15 (HCP + spades ≥ 15). |
| 1NT | 15–17 HCP, balanced or semi-balanced (a five-card major is possible on 15–16). |
| 2♣ | Strong and artificial: 22+ HCP, or a hand of five losers or fewer with the playing strength to insist on game. |
| 2♦ / 2♥ / 2♠ | Weak two: exactly six cards, 5–11 HCP, no four-card major on the side. |
| 2NT | 20–21 HCP, balanced. |
| 3NT | 25–27 HCP, balanced, no four-card major. |
| 3-level | Preempt: seven cards, 5–11 HCP, no four-card major on the side. |
| 4- and 5-level | Preempt: seven or eight cards in a major, eight in a minor, judged by losing-trick count and vulnerability rather than by points alone. |

Every threshold above is the floor of an authored rule, not a rounded figure — hand shape, suit quality, losing-trick count, vulnerability and seat all move the decision. The browser shows the exact requirement behind each call.

### Responding

#### To 1♥ / 1♠

- Two-over-one (2♣, 2♦, 2♥ over 1♠) is natural and game forcing, 12+ HCP.

- 1NT is forcing, 6–12 HCP without support.

- A raise to two shows 3+ trumps and 6–9; 2NT is Jacoby (game-forcing raise), a jump to three is invitational, a double jump in a new suit is a splinter.

- After a passed hand, 2♣ is Drury.

#### To 1♣ / 1♦

- New suits at the one level are natural and forcing; a raise of the minor is inverted (strong raises are cheap, weak raises jump).

- Opener's rebids are natural; New Minor Forcing and Fourth Suit Forcing find the right game when nothing natural does.

#### To 1NT

- 2♣ Stayman, 2♦ and 2♥ Jacoby transfers, 2♠ to play.

- 2NT invitational; 3-level minors natural with a good six-card suit; 3NT to play.

- 4♦/4♥ are Texas transfers, 4♣ Gerber, 4NT quantitative.

#### To 2♣

- 2♦ waiting (the default answer), 2NT a balanced 8+, a suit response shows five cards of real quality and 7+ HCP.

#### To 2NT

- 3♣ Stayman, 3♦ and 3♥ transfers, 3♠ minor Stayman, 4♦/4♥ Texas.

### Competing

- Overcalls are natural, roughly 8–17, and want a suit worth naming: the requirement scales with the level bid.

- 1NT overcall 15–17 with a stopper. Over their 1NT we play Cappelletti, and a double of a natural 1NT is for penalties.

- Takeout doubles throughout, with responsive and competitive doubles later in the auction, and negative doubles by responder showing the unbid major(s).

- Two-suiters: Michaels cue-bids and the Unusual NT, defined over openings at every level from one to four — and each with its own defence for when the opponents use it against us.

- Preemptive raises and jumps are judged on the Law of Total Tricks and the losing-trick count, not on points.

### Slam bidding

- Roman Keycard Blackwood 0314 in every trump suit, with void-showing responses, a queen ask, a king ask, and DOPI/DEPO answers when the opponents interfere.

- Gerber over notrump, the Grand Slam Force (5NT), quantitative 4NT and splinters.

- No control-showing cue-bids. Brill judges a slam with keycards, splinters and its own trick and loser counts rather than by cue-bidding controls round the table; a cue-bid by you is read for what it shows, but Brill will not start one. A cue-bidding structure is planned.

- Beyond the conventions, the engine counts: the trick estimate, combined losers against cover cards, and the keycard state all have to agree before a slam is bid — which is why the browser sometimes shows a slam rule whose requirement mentions losers rather than points.

### Conventions in play

Loading the convention list from the bidding service…

### Reading the rules yourself

Nothing above is hand-written into the robots: every call comes from a rule, and the rule browser walks the system one call at a time. Click a bid and it lists every call the system defines in that position, what each means, and the requirement the rule was authored from. The auction is in the address, so any position is a link you can share.

From the first call 1NT – Pass – 2♣ (Stayman) 1♠ – Pass – 2NT (Jacoby) 2♣ – Pass – 2♦ (waiting) 1♥ – 1♠ (competing)

Where the system has no rule for a position, the robots still bid — the engine falls back to a practical choice and records the gap, which is how the rule set grows. A call explained as “not defined” in a game you played is one of those.

This page summarises the system; the rules are the authority. Card play is a separate engine and is not described here.

---

## Part 2 — Rule tree

Each table is one auction position; the rows are every call the system defines there, with the `requires` expression that guards it. A `*` after a call marks it artificial. `P` is pass, `X` is double.

**How to read a position.** The leading call may be ours or the opponents', and the rows say which:

- `1H` — the opponents opened 1H and we are to act. The rows are our competitive calls: overcalls, Michaels cue-bids, takeout doubles, and passes.
- `1H-P` — our side opened 1H, the next hand passed, and partner is to respond. The rows are the responding hands.

So both seats appear at every level: the bare sequence is the competitive one, and the same sequence with the intervening pass is our constructive auction.

### Responses (one call made)

#### `1C`

| Call | Means | Requires | Post-condition | Convention | Pri |
|---|---|---|---|---|---|
| P | _(unnamed — the Requires expression is the definition)_ | (true or C >= 7) \| (true) |  |  |  |
| 1D | Natural 1D Overcall | (D >= 5 and hcp>= 10 and hcp<= 17 and bestsuit('D') and HasTopHonors('D', 1, 3)) \| (overcall('D')) |  |  | 21 |
| 1H | Natural 1H Overcall | (H >= 6 and hcp >= 7 and H_points >= 10 and hcp<= 17 and bestsuit('H') and HasTopHonors('H', 1, 3)) \| (overcall('H')) |  |  | 72 |
| 1S | Natural 1S Overcall | (S >= 6 and hcp >= 7 and S_points >= 10 and hcp<= 17 and bestsuit('S') and HasTopHonors('S', 1, 3)) \| (overcall('S')) |  |  | 72 |
| 1N | 15-17 | (C >= 4 and hcp>= 15 and hcp<= 17 and (balanced or semibalanced)) \| (C >= 5 and hcp>= 15 and hcp<= 18 and (balanced or semibalanced)) \| (stopper('C') and hcp>= 15 and hcp<= 17 and (balanced or semibalanced)) | maxhcp=17 |  | 60 |
| 2C* | 5-5 in Majors | (spades >= 5 and hearts >= 5 and spades <= 6 and hearts <= 6 and loserlevel >= 2 and totalpoints >= 8) | minhcp = 10, maxhcp = 20 | MichaelsCuebidMinor | 120 |
| 2D | Preemptive | (IsWeakTwoDiamonds) |  |  | 60 |
| 2H | Weak 2H Overcall | (IsWeakTwoHearts) |  |  | 79 |
| 2S | Weak 2S Overcall | (IsWeakTwoSpades) |  |  | 80 |
| 2N* | 5-5 in lowest two unbid | (hearts >= 5 and D >= 5 and loserlevel >= 3 and totalpoints >= 10) | minhcp = 10 | UnusualNTOverMinor | 110 |
| 3C | Preemptive | (C >= 7 and hcp< 12 and loserlevel >= 3 and singlesuited) | minhcp=5 |  | 20 |
| 3D | Preemptive | (D >= 6 and hcp< 12 and loserlevel >= 3 and singlesuited) | minhcp=5 |  | 22 |
| 3D | _(unnamed — the Requires expression is the definition)_ | (D >= 6 and hcp < 12 and loserlevel >= 3 and HasTopHonors('D', 2, 4) and isvalidbid('3D') and S <= 5 and H <= 5) |  |  | 62 |
| 3H | _(unnamed — the Requires expression is the definition)_ | (H >= 6 and hcp < 12 and loserlevel >= 3 and HasTopHonors('H', 2, 4)) |  |  | 23 |
| 3H | Weak H Overcall | (H >= 7 and loserlevel >= 3 and hcp <= 13) | minhcp=5 |  | 85 |
| 3S | _(unnamed — the Requires expression is the definition)_ | (S >= 6 and hcp < 12 and loserlevel >= 3 and HasTopHonors('S', 2, 4)) |  |  | 23 |
| 3S | Weak S Overcall | (S >= 7 and loserlevel >= 3 and hcp <= 13) | minhcp=5 |  | 85 |
| 4D | Preemptive | (D >= 7 and hcp< 12 and loserlevel >= 4 and HasTopHonors('D', 2, 4) and H < 5 and S < 5) | minhcp=6, maxhcp=14 |  | 130 |
| 4H | Strong Preemptive Overcall | (H >= 7 and loserlevel >= 4 and hcp <= 13 and HasTopHonors('H', 2, 4)) | minhcp=5 |  | 88 |
| 4H | _(unnamed — the Requires expression is the definition)_ | (H >= 8 and loserlevel >= 4 and hcp <= 13) | minhcp=5 |  | 90 |
| 4H | Preemptive with 8+ card suit | (H >= 8 and hcp <= 10 and HasTopHonors('H', 1, 5)) | minhcp=5 |  | 91 |
| 4H | Preemptive | (H >= 7 and hcp<= 10 and singlesuited and loserlevel >= 4) \| (H >= 7 and hcp< 14 and loserlevel >= 4 and S < 5) | minhcp=5 \| minhcp=6, maxhcp=14 |  | 132 |
| 4S | Strong Preemptive Overcall | (S >= 7 and loserlevel >= 4 and hcp <= 13 and HasTopHonors('S', 2, 4)) | minhcp=5 |  | 88 |
| 4S | _(unnamed — the Requires expression is the definition)_ | (S >= 8 and loserlevel >= 4 and hcp <= 13) | minhcp=5 |  | 90 |
| 4S | Preemptive with 8+ card suit | (S >= 8 and hcp <= 10 and HasTopHonors('S', 1, 5)) | minhcp=5 |  | 91 |
| 4S | Preemptive | (S >= 7 and hcp<= 10 and singlesuited and loserlevel >= 4) \| (S >= 7 and hcp< 14 and loserlevel >= 4 and H < 5) | minhcp=5 \| minhcp=6, maxhcp=14 |  | 132 |
| 5D | _(unnamed — the Requires expression is the definition)_ | (D >= 8 and loserlevel >= 5) | minhcp=5 |  | 95 |
| 5D | Preemptive | (D >= 8 and hcp< 14 and loserlevel >= 5 and H < 5 and S < 5) | minhcp=6, maxhcp=14 |  | 131 |
| 6D | Real solid suit, one-loser hand -- twelve tricks on our own | (realsolid('D') and losers == 1) | T=D |  | 140 |
| 6H | Real solid suit, one-loser hand -- twelve tricks on our own | (realsolid('H') and losers == 1) | T=H |  | 142 |
| 6S | Real solid suit, one-loser hand -- twelve tricks on our own | (realsolid('S') and losers == 1) | T=S |  | 142 |
| 7D | Real solid suit, no losers -- thirteen tricks on our own | (realsolid('D') and losers <= 0) | T=D |  | 141 |
| 7H | Real solid suit, no losers -- thirteen tricks on our own | (realsolid('H') and losers <= 0) | T=H |  | 143 |
| 7S | Real solid suit, no losers -- thirteen tricks on our own | (realsolid('S') and losers <= 0) | T=S |  | 143 |
| X | T/O | (takeout('C')) \| (hcp >= 18) \| (hcp >= 12 and S >= 3 and H >= 3 and D >= 3 and D <= 5 and C <= 3 and (S + H >= 7)) \| (hcp >= 10 and S >= 4 and H >= 4 and D >= 3 and C <= 1) \| (doublethenovercall('H') or doublethenovercall('D')) \| (doublethenovercall('S') or doublethenovercall('D')) |  |  | 74 |

#### `1D`

| Call | Means | Requires | Post-condition | Convention | Pri |
|---|---|---|---|---|---|
| P | _(unnamed — the Requires expression is the definition)_ | (true or D >= 7) \| (true) |  |  |  |
| 1H | Natural 1H Overcall | (H >= 6 and hcp >= 7 and H_points >= 10 and hcp<= 17 and bestsuit('H') and HasTopHonors('H', 1, 3)) \| (overcall('H')) |  |  | 72 |
| 1S | Natural 1S Overcall | (S >= 6 and hcp >= 7 and S_points >= 10 and hcp<= 17 and bestsuit('S') and HasTopHonors('S', 1, 3)) \| (overcall('S')) |  |  | 72 |
| 1N | 15-17 | (D >= 4 and hcp>= 15 and hcp<= 17 and (balanced or semibalanced)) \| (D >= 5 and hcp>= 15 and hcp<= 18 and (balanced or semibalanced)) \| (stopper('D') and hcp>= 15 and hcp<= 17 and (balanced or semibalanced)) | maxhcp=17 |  | 60 |
| 2C | Nat | (C >= 5 and hcp>= 10 and hcp<= 17 and loserlevel >= 2 and bestsuit('C')) \| (C >= 6 and hcp>= 10 and hcp<= 17 and loserlevel >= 2 and bestsuit('C')) |  |  | 60 |
| 2D* | 5-5 in Majors | (spades >= 5 and hearts >= 5 and spades <= 6 and hearts <= 6 and loserlevel >= 2 and totalpoints >= 8) | minhcp = 10, maxhcp = 20 | MichaelsCuebidMinor | 120 |
| 2H | Weak 2H Overcall | (IsWeakTwoHearts) |  |  | 79 |
| 2S | Weak 2S Overcall | (IsWeakTwoSpades) |  |  | 80 |
| 2N* | 5-5 in lowest two unbid | (hearts >= 5 and C >= 5 and loserlevel >= 3 and totalpoints >= 10) | minhcp = 10 | UnusualNTOverMinor | 110 |
| 3C | Preemptive | (C >= 6 and hcp< 12 and loserlevel >= 3 and singlesuited) | minhcp=5 |  | 22 |
| 3C | _(unnamed — the Requires expression is the definition)_ | (C >= 6 and hcp < 12 and loserlevel >= 3 and HasTopHonors('C', 2, 4) and isvalidbid('3C') and S <= 5 and H <= 5) |  |  | 62 |
| 3D | Preemptive | (D >= 7 and hcp< 12 and loserlevel >= 3 and singlesuited) | minhcp=5 |  | 20 |
| 3H | _(unnamed — the Requires expression is the definition)_ | (H >= 6 and hcp < 12 and loserlevel >= 3 and HasTopHonors('H', 2, 4)) |  |  | 23 |
| 3H | Weak H Overcall | (H >= 7 and loserlevel >= 3 and hcp <= 13) | minhcp=5 |  | 85 |
| 3S | _(unnamed — the Requires expression is the definition)_ | (S >= 6 and hcp < 12 and loserlevel >= 3 and HasTopHonors('S', 2, 4)) |  |  | 23 |
| 3S | Weak S Overcall | (S >= 7 and loserlevel >= 3 and hcp <= 13) | minhcp=5 |  | 85 |
| 4C | Preemptive | (C >= 7 and hcp< 12 and loserlevel >= 4 and HasTopHonors('C', 2, 4) and H < 5 and S < 5) | minhcp=6, maxhcp=14 |  | 130 |
| 4H | Strong Preemptive Overcall | (H >= 7 and loserlevel >= 4 and hcp <= 13 and HasTopHonors('H', 2, 4)) | minhcp=5 |  | 88 |
| 4H | _(unnamed — the Requires expression is the definition)_ | (H >= 8 and loserlevel >= 4 and hcp <= 13) | minhcp=5 |  | 90 |
| 4H | Preemptive with 8+ card suit | (H >= 8 and hcp <= 10 and HasTopHonors('H', 1, 5)) | minhcp=5 |  | 91 |
| 4H | Preemptive | (H >= 7 and hcp<= 10 and singlesuited and loserlevel >= 4) \| (H >= 7 and hcp< 14 and loserlevel >= 4 and S < 5) | minhcp=5 \| minhcp=6, maxhcp=14 |  | 132 |
| 4S | Strong Preemptive Overcall | (S >= 7 and loserlevel >= 4 and hcp <= 13 and HasTopHonors('S', 2, 4)) | minhcp=5 |  | 88 |
| 4S | _(unnamed — the Requires expression is the definition)_ | (S >= 8 and loserlevel >= 4 and hcp <= 13) | minhcp=5 |  | 90 |
| 4S | Preemptive with 8+ card suit | (S >= 8 and hcp <= 10 and HasTopHonors('S', 1, 5)) | minhcp=5 |  | 91 |
| 4S | Preemptive | (S >= 7 and hcp<= 10 and singlesuited and loserlevel >= 4) \| (S >= 7 and hcp< 14 and loserlevel >= 4 and H < 5) | minhcp=5 \| minhcp=6, maxhcp=14 |  | 132 |
| 5C | _(unnamed — the Requires expression is the definition)_ | (C >= 8 and loserlevel >= 5) | minhcp=5 |  | 95 |
| 5C | Preemptive | (C >= 8 and hcp< 14 and loserlevel >= 5 and H < 5 and S < 5) | minhcp=6, maxhcp=14 |  | 131 |
| 6C | Real solid suit, one-loser hand -- twelve tricks on our own | (realsolid('C') and losers == 1) | T=C |  | 140 |
| 6H | Real solid suit, one-loser hand -- twelve tricks on our own | (realsolid('H') and losers == 1) | T=H |  | 142 |
| 6S | Real solid suit, one-loser hand -- twelve tricks on our own | (realsolid('S') and losers == 1) | T=S |  | 142 |
| 7C | Real solid suit, no losers -- thirteen tricks on our own | (realsolid('C') and losers <= 0) | T=C |  | 141 |
| 7H | Real solid suit, no losers -- thirteen tricks on our own | (realsolid('H') and losers <= 0) | T=H |  | 143 |
| 7S | Real solid suit, no losers -- thirteen tricks on our own | (realsolid('S') and losers <= 0) | T=S |  | 143 |
| X | T/O | (takeout('D')) \| (hcp >= 18) \| (hcp >= 12 and S >= 3 and H >= 3 and C >= 3 and C <= 5 and D <= 3 and (S + H >= 7)) \| (hcp >= 10 and S >= 4 and H >= 4 and C >= 3 and D <= 1) \| (doublethenovercall('H') or doublethenovercall('C')) \| (doublethenovercall('S') or doublethenovercall('C')) |  |  | 74 |

#### `1H`

| Call | Means | Requires | Post-condition | Convention | Pri |
|---|---|---|---|---|---|
| P | _(unnamed — the Requires expression is the definition)_ | (true) \| (H >= 6) |  |  | 1 |
| 1S | Natural 1S Overcall | (S >= 5 and hcp>= 8 and hcp<= 17) |  |  | 60 |
| 1N | 15-17 | (stopper('H') and hcp>= 15 and hcp<= 17 and (balanced or semibalanced)) |  |  | 60 |
| 2C | _(unnamed — the Requires expression is the definition)_ | (overcall('C')) |  |  | 16 |
| 2C | Natural 2C Overcall | (C >= 5 and hcp>= 10 and hcp<= 17 and loserlevel >= 2 and HasTopHonors('C', 2, 4)) \| (C >= 6 and hcp>= 12 and hcp<= 17 and loserlevel >= 2 and HasTopHonors('C', 1, 3)) |  |  | 55 |
| 2D | _(unnamed — the Requires expression is the definition)_ | (overcall('D')) |  |  | 16 |
| 2D | Natural 2D Overcall | (D >= 5 and hcp>= 10 and hcp<= 17 and loserlevel >= 2 and HasTopHonors('D', 2, 4)) \| (D >= 6 and hcp>= 12 and hcp<= 17 and loserlevel >= 2 and HasTopHonors('D', 1, 3)) |  |  | 55 |
| 2H* | 5-5 in other Major and a minor | (S >= 5 and S <= 6 and (diamonds >= 5 or clubs >= 5) and loserlevel >= 2 and totalpoints >= 10) |  | MichaelsCuebidMajor | 120 |
| 2S | Weak 2S Overcall | (IsWeakTwoSpades) |  |  | 62 |
| 2N* | 5-5 in minors | (diamonds >= 5 and clubs >= 5 and loserlevel >= 3 and totalpoints >= 8) | minhcp=8, maxhcp= 14 | UnusualNTOverMajor | 110 |
| 3C | _(unnamed — the Requires expression is the definition)_ | (C >= 6 and hcp < 12 and loserlevel >= 3 and HasTopHonors('C', 2, 4) and hcp >= 5 and S <= 4) | minhcp = 8 |  | 22 |
| 3C | Preempt, good suit | (strongrebiddable('C') and C >= 7 and hcp>= 3 and hcp<= 10 and loserlevel >= 2) \| (C >= 7 and hcp>= 3 and hcp<= 10 and TwiceRebiddable('C') and loserlevel >= 3) |  |  | 61 |
| 3C | Preemptive | (C >= 6 and hcp> 7 and hcp< 12 and loserlevel >= 3 and HasTopHonors('C', 2, 4)) |  |  | 63 |
| 3D | _(unnamed — the Requires expression is the definition)_ | (D >= 6 and hcp < 12 and loserlevel >= 3 and HasTopHonors('D', 2, 4) and hcp >= 5 and S <= 4) | minhcp = 8 |  | 22 |
| 3D | Preempt, good suit | (strongrebiddable('D') and D >= 7 and hcp>= 3 and hcp<= 10 and loserlevel >= 2) \| (D >= 7 and hcp>= 3 and hcp<= 10 and TwiceRebiddable('D') and loserlevel >= 3) |  |  | 61 |
| 3D | Preemptive | (D >= 6 and hcp> 7 and hcp< 12 and loserlevel >= 3 and HasTopHonors('D', 2, 4)) |  |  | 63 |
| 3S | _(unnamed — the Requires expression is the definition)_ | (S >= 6 and hcp <= 12 and loserlevel >= 3 and HasTopHonors('S', 2, 4) and hcp >= 5) | minhcp = 8 |  | 23 |
| 3S | Preempt, good suit | (S >= 7 and hcp>= 3 and hcp<= 10 and TwiceRebiddable('S') and loserlevel >= 3) |  |  | 72 |
| 3S | Preemptive | (S >= 6 and hcp> 7 and hcp< 12 and loserlevel >= 3) |  |  | 74 |
| 4C | Preemptive | (C >= 7 and hcp< 12 and loserlevel >= 3 and HasTopHonors('C', 2, 4) and S < 5 and hcp >= 5) | minhcp = 8 |  | 130 |
| 4D | Preemptive | (D >= 7 and hcp< 12 and loserlevel >= 3 and HasTopHonors('D', 2, 4) and S < 5 and hcp >= 5) | minhcp = 8 |  | 130 |
| 4S | Preemptive | (S >= 7 and hcp< 14 and loserlevel >= 4 and hcp >= 5) |  |  | 132 |
| 5C | Preemptive | (C >= 8 and hcp< 14 and loserlevel >= 5 and S < 5 and hcp >= 5) |  |  | 131 |
| 5D | Preemptive | (D >= 8 and hcp< 14 and loserlevel >= 5 and S < 5 and hcp >= 5) |  |  | 131 |
| 6C | Real solid suit, one-loser hand -- twelve tricks on our own | (realsolid('C') and losers == 1) | T=C |  | 140 |
| 6D | Real solid suit, one-loser hand -- twelve tricks on our own | (realsolid('D') and losers == 1) | T=D |  | 140 |
| 6S | Real solid suit, one-loser hand -- twelve tricks on our own | (realsolid('S') and losers == 1) | T=S |  | 142 |
| 7C | Real solid suit, no losers -- thirteen tricks on our own | (realsolid('C') and losers <= 0) | T=C |  | 141 |
| 7D | Real solid suit, no losers -- thirteen tricks on our own | (realsolid('D') and losers <= 0) | T=D |  | 141 |
| 7S | Real solid suit, no losers -- thirteen tricks on our own | (realsolid('S') and losers <= 0) | T=S |  | 143 |
| X | T/O | (hcp >= 18 and (H <= 4 or balanced)) \| (hcp >= 10 and hcp <= 17 and H <= 1 and S >= 3 and C >= 3 and D >= 3) \| (takeout('H')) \| (doublethenovercall('S')) \| (doublethenovercall('C')) \| (doublethenovercall('D')) |  |  | 76 |

#### `1S`

| Call | Means | Requires | Post-condition | Convention | Pri |
|---|---|---|---|---|---|
| P | _(unnamed — the Requires expression is the definition)_ | (true) \| (S >= 6) |  |  | 1 |
| 1N | 15-17 | (stopper('S') and hcp>= 15 and hcp<= 17 and (balanced or semibalanced)) |  |  | 60 |
| 2C | _(unnamed — the Requires expression is the definition)_ | (overcall('C')) |  |  | 16 |
| 2C | Natural 2C Overcall | (C >= 5 and hcp>= 10 and hcp<= 17 and loserlevel >= 2 and HasTopHonors('C', 2, 4)) \| (C >= 6 and hcp>= 12 and hcp<= 17 and loserlevel >= 2 and HasTopHonors('C', 1, 3)) |  |  | 55 |
| 2D | _(unnamed — the Requires expression is the definition)_ | (overcall('D')) |  |  | 16 |
| 2D | Natural 2D Overcall | (D >= 5 and hcp>= 10 and hcp<= 17 and loserlevel >= 2 and HasTopHonors('D', 2, 4)) \| (D >= 6 and hcp>= 12 and hcp<= 17 and loserlevel >= 2 and HasTopHonors('D', 1, 3)) |  |  | 55 |
| 2H | Natural 2H Overcall | (H >= 5 and hcp>= 11 and hcp<= 17 and loserlevel >= 2 and HasTopHonors('H', 2, 3) and heartlongest) \| (H >= 5 and hcp>= 14 and hcp<= 17 and loserlevel >= 2 and HasTopHonors('H', 2, 4) and heartlongest) \| (H >= 6 and hcp>= 8 and hcp<= 17 and loserlevel >= 2 and HasTopHonors('H', 2, 4) and heartlongest) |  |  | 70 |
| 2S* | 5-5 in other Major and a minor | (H >= 5 and H <= 6 and (diamonds >= 5 or clubs >= 5) and loserlevel >= 2 and totalpoints >= 10) |  | MichaelsCuebidMajor | 120 |
| 2N* | 5-5 in minors | (diamonds >= 5 and clubs >= 5 and loserlevel >= 3 and totalpoints >= 8) | minhcp=8, maxhcp= 14 | UnusualNTOverMajor | 110 |
| 3C | _(unnamed — the Requires expression is the definition)_ | (C >= 6 and hcp < 12 and loserlevel >= 3 and HasTopHonors('C', 2, 4) and hcp >= 5 and H <= 4) | minhcp = 8 |  | 22 |
| 3C | Preempt, good suit | (strongrebiddable('C') and C >= 7 and hcp>= 3 and hcp<= 10 and loserlevel >= 2) \| (C >= 7 and hcp>= 3 and hcp<= 10 and TwiceRebiddable('C') and loserlevel >= 3) |  |  | 61 |
| 3C | Preemptive | (C >= 6 and hcp> 7 and hcp< 12 and loserlevel >= 3 and HasTopHonors('C', 2, 4)) |  |  | 63 |
| 3D | _(unnamed — the Requires expression is the definition)_ | (D >= 6 and hcp < 12 and loserlevel >= 3 and HasTopHonors('D', 2, 4) and hcp >= 5 and H <= 4) | minhcp = 8 |  | 22 |
| 3D | Preempt, good suit | (strongrebiddable('D') and D >= 7 and hcp>= 3 and hcp<= 10 and loserlevel >= 2) \| (D >= 7 and hcp>= 3 and hcp<= 10 and TwiceRebiddable('D') and loserlevel >= 3) |  |  | 61 |
| 3D | Preemptive | (D >= 6 and hcp> 7 and hcp< 12 and loserlevel >= 3 and HasTopHonors('D', 2, 4)) |  |  | 63 |
| 3H | _(unnamed — the Requires expression is the definition)_ | (H >= 6 and hcp <= 12 and loserlevel >= 3 and HasTopHonors('H', 2, 4) and hcp >= 5) | minhcp = 8 |  | 23 |
| 3H | Preempt, good suit | (H >= 7 and hcp>= 3 and hcp<= 10 and TwiceRebiddable('H') and loserlevel >= 3) |  |  | 72 |
| 3H | Preemptive | (H >= 6 and hcp> 7 and hcp< 12 and loserlevel >= 3) |  |  | 74 |
| 4C | Preemptive | (C >= 7 and hcp< 12 and loserlevel >= 3 and HasTopHonors('C', 2, 4) and H < 5 and hcp >= 5) | minhcp = 8 |  | 130 |
| 4D | Preemptive | (D >= 7 and hcp< 12 and loserlevel >= 3 and HasTopHonors('D', 2, 4) and H < 5 and hcp >= 5) | minhcp = 8 |  | 130 |
| 4H | Preemptive | (H >= 7 and hcp< 14 and loserlevel >= 4 and hcp >= 5) |  |  | 132 |
| 5C | Preemptive | (C >= 8 and hcp< 14 and loserlevel >= 5 and H < 5 and hcp >= 5) |  |  | 131 |
| 5D | Preemptive | (D >= 8 and hcp< 14 and loserlevel >= 5 and H < 5 and hcp >= 5) |  |  | 131 |
| 6C | Real solid suit, one-loser hand -- twelve tricks on our own | (realsolid('C') and losers == 1) | T=C |  | 140 |
| 6D | Real solid suit, one-loser hand -- twelve tricks on our own | (realsolid('D') and losers == 1) | T=D |  | 140 |
| 6H | Real solid suit, one-loser hand -- twelve tricks on our own | (realsolid('H') and losers == 1) | T=H |  | 142 |
| 7C | Real solid suit, no losers -- thirteen tricks on our own | (realsolid('C') and losers <= 0) | T=C |  | 141 |
| 7D | Real solid suit, no losers -- thirteen tricks on our own | (realsolid('D') and losers <= 0) | T=D |  | 141 |
| 7H | Real solid suit, no losers -- thirteen tricks on our own | (realsolid('H') and losers <= 0) | T=H |  | 143 |
| X | T/O | (hcp >= 18 and (S <= 4 or balanced)) \| (hcp >= 10 and hcp <= 17 and S <= 1 and H >= 3 and C >= 3 and D >= 3) \| (takeout('S')) \| (doublethenovercall('H')) \| (doublethenovercall('C')) \| (doublethenovercall('D')) |  |  | 76 |

#### `2C`

| Call | Means | Requires | Post-condition | Convention | Pri |
|---|---|---|---|---|---|
| P | _(unnamed — the Requires expression is the definition)_ | (true) |  |  | -1 |
| 2D | _(unnamed — the Requires expression is the definition)_ | (overcall('D')) |  |  | 17 |
| 2H | _(unnamed — the Requires expression is the definition)_ | (H >= 6 and loserlevel >= 2) | minhcp=5,maxhcp=17 |  |  |
| 2S | _(unnamed — the Requires expression is the definition)_ | (S >= 6 and loserlevel >= 2) | minhcp=5,maxhcp=17 |  |  |
| 3C | Hand: 9.AJT2.64.AKJ985 (Overcall) | (overcall('C')) |  |  | 21 |
| 3H | _(unnamed — the Requires expression is the definition)_ | (H >= 7 and loserlevel >= 3) | minhcp=5,maxhcp=17 |  | 10 |
| 3S | _(unnamed — the Requires expression is the definition)_ | (S >= 7 and loserlevel >= 3) | minhcp=5,maxhcp=17 |  | 10 |
| 4C | Hand: AT.T3.AQJT654.54 (Overcall) | (fourlevelovercall('C')) |  |  | 32 |
| 4D | Hand: AT.T3.AQJT654.54 (Overcall) | (fourlevelovercall('D')) |  |  | 32 |
| 4H | _(unnamed — the Requires expression is the definition)_ | (H >= 8 and loserlevel >= 4) | minhcp=5,maxhcp=17 |  | 20 |
| 4H | Hand: AT.T3.AQJT654.54 (Overcall) | (fourlevelovercall('H')) |  |  | 42 |
| 4S | _(unnamed — the Requires expression is the definition)_ | (S >= 8 and loserlevel >= 4) | minhcp=5,maxhcp=17 |  | 20 |
| 4S | Hand: AT.T3.AQJT654.54 (Overcall) | (fourlevelovercall('S')) |  |  | 42 |
| 5C | Hand: ..AKJT76432.QT76 (GameEval) | (C_compgame) |  |  | 52 |
| 5D | Hand: ..AKJT76432.QT76 (GameEval) | (D_compgame) |  |  | 52 |

#### `2D`

| Call | Means | Requires | Post-condition | Convention | Pri |
|---|---|---|---|---|---|
| P | _(unnamed — the Requires expression is the definition)_ | (hcp <= 15) \| (D >= 5) |  |  | 10 |
| 2H | _(unnamed — the Requires expression is the definition)_ | (bestmajor('H') and H >= 6 and hcp>= 11 and hcp<= 17) \| (bestmajor('H') and H >= 5 and hcp>= 13 and hcp<= 18) |  |  | 90 |
| 2S | _(unnamed — the Requires expression is the definition)_ | (bestmajor('S') and S >= 6 and hcp>= 11 and hcp<= 17) \| (bestmajor('S') and S >= 5 and hcp>= 13 and hcp<= 18) |  |  | 90 |
| 2N | _(unnamed — the Requires expression is the definition)_ | (hcp >= 15 and hcp<= 18 and balish and stopper('D')) |  |  | 80 |
| 3C | _(unnamed — the Requires expression is the definition)_ | (C >= 5 and hcp>= 14 and hcp<= 19 and bestsuit('C')) \| (C >= 5 and hcp>= 14 and hcp<= 19 and (H <= 2 or S <= 2) and bestsuit('C')) |  |  | 79 |
| 3D* | 5-5 in the majors | (hearts >= 5 and spades >= 5 and loserlevel >= 3 and hcp >= 10) |  | MichaelsCuebid2X | 110 |
| 3H | _(unnamed — the Requires expression is the definition)_ | (H >= 7 and hcp>= 19) | F1 |  | 93 |
| 3S | _(unnamed — the Requires expression is the definition)_ | (S >= 7 and hcp>= 19) | F1 |  | 93 |
| 3N | _(unnamed — the Requires expression is the definition)_ | (hcp >= 19 and hcp<= 24 and balish and stopper('D')) |  |  | 82 |
| 4C | _(unnamed — the Requires expression is the definition)_ | (C >= 7 and hcp>= 19 and hcp <= 24) |  |  | 95 |
| 4H | _(unnamed — the Requires expression is the definition)_ | (H >= 7 and hcp>= 12 and hcp<= 14) \| (H >= 7 and losers <= 3 and hcp <= 15) |  |  | 97 |
| 4S | _(unnamed — the Requires expression is the definition)_ | (S >= 7 and hcp>= 12 and hcp<= 14) \| (S >= 7 and losers <= 3 and hcp <= 15) |  |  | 97 |
| 6C | Real solid suit, one-loser hand -- twelve tricks on our own | (realsolid('C') and losers == 1) | T=C |  | 140 |
| 6H | Real solid suit, one-loser hand -- twelve tricks on our own | (realsolid('H') and losers == 1) | T=H |  | 142 |
| 6S | Real solid suit, one-loser hand -- twelve tricks on our own | (realsolid('S') and losers == 1) | T=S |  | 142 |
| 7C | Real solid suit, no losers -- thirteen tricks on our own | (realsolid('C') and losers <= 0) | T=C |  | 141 |
| 7H | Real solid suit, no losers -- thirteen tricks on our own | (realsolid('H') and losers <= 0) | T=H |  | 143 |
| 7S | Real solid suit, no losers -- thirteen tricks on our own | (realsolid('S') and losers <= 0) | T=S |  | 143 |
| X | _(unnamed — the Requires expression is the definition)_ | (hcp >= 12 and D <= 1 and S >= 3 and H >= 3 and C <= 5) \| (hcp >= 13 and S >= 3 and H >= 4) \| (hcp >= 13 and S >= 4 and H >= 3) \| (hcp >= 16) \| (H >= 6 and hcp >= 18 and losers <= 4) \| (S >= 6 and hcp >= 18 and losers <= 4) |  |  | 105 |

#### `2H`

| Call | Means | Requires | Post-condition | Convention | Pri |
|---|---|---|---|---|---|
| P | _(unnamed — the Requires expression is the definition)_ | (hcp <= 17) |  |  |  |
| 2S | 6-card overcall | (S >= 6 and hcp>= 10 and hcp<= 12 and HasTopHonors('S', 2, 3)) |  |  | 18 |
| 2S | _(unnamed — the Requires expression is the definition)_ | (S >= 5 and hcp>= 13 and hcp<= 19) |  |  | 20 |
| 2N | _(unnamed — the Requires expression is the definition)_ | (hcp >= 15 and hcp<= 18 and balish and doublestopper('H')) \| (hcp >= 16 and hcp<= 18 and balish and stopper('H')) |  |  | 100 |
| 3C | _(unnamed — the Requires expression is the definition)_ | (bestminor('C') and C >= 5 and S <= 2 and hcp>= 14 and hcp<= 19 and HasTopHonors('D', 2, 3)) \| (bestminor('C') and C >= 6 and hcp>= 14 and hcp<= 19) |  |  | 20 |
| 3D | _(unnamed — the Requires expression is the definition)_ | (bestminor('D') and D >= 5 and S <= 2 and hcp>= 14 and hcp<= 19 and HasTopHonors('D', 2, 3)) \| (bestminor('D') and D >= 6 and hcp>= 14 and hcp<= 19) |  |  | 20 |
| 3H* | 5-5 in other Major and a minor | (S >= 5 and (diamonds >= 5 or clubs >= 5) and loserlevel >= 3 and hcp>= 12) |  | MichaelsCuebid2X | 110 |
| 3S | _(unnamed — the Requires expression is the definition)_ | (S >= 6 and hcp>= 19 and losers >= 4) | F1 |  | 30 |
| 3N | _(unnamed — the Requires expression is the definition)_ | (hcp >= 19 and hcp<= 24 and balish and stopper('H')) \| (hcp >= 20 and hcp<= 24 and H >= 4 and stopper('H')) |  |  | 50 |
| 4C | _(unnamed — the Requires expression is the definition)_ | (bestminor('C') and C >= 7 and hcp>= 19 and singlesuited and losers >= 3) | maxhcp=24 |  | 28 |
| 4D | _(unnamed — the Requires expression is the definition)_ | (bestminor('D') and D >= 7 and hcp>= 19 and singlesuited and losers >= 3) | maxhcp=24 |  | 28 |
| 4H* | 5-5 in minors | (diamonds >= 5 and clubs >= 5 and losers <= 4 and hcp>= 17) |  | MichaelsCuebid2X | 120 |
| 4S | _(unnamed — the Requires expression is the definition)_ | (S >= 7 and S_points >= 18 and losers <= 4) | maxhcp=20 |  | 29 |
| 4N* | 5-5 in minors | (diamonds >= 5 and clubs >= 5 and loserlevel >= 4 and hcp>= 12) |  | UnusualNT2M | 100 |
| 6C | Real solid suit, one-loser hand -- twelve tricks on our own | (realsolid('C') and losers == 1) | T=C |  | 140 |
| 6D | Real solid suit, one-loser hand -- twelve tricks on our own | (realsolid('D') and losers == 1) | T=D |  | 140 |
| 6S | Real solid suit, one-loser hand -- twelve tricks on our own | (realsolid('S') and losers == 1) | T=S |  | 142 |
| 7C | Real solid suit, no losers -- thirteen tricks on our own | (realsolid('C') and losers <= 0) | T=C |  | 141 |
| 7D | Real solid suit, no losers -- thirteen tricks on our own | (realsolid('D') and losers <= 0) | T=D |  | 141 |
| 7S | Real solid suit, no losers -- thirteen tricks on our own | (realsolid('S') and losers <= 0) | T=S |  | 143 |
| X | _(unnamed — the Requires expression is the definition)_ | (hcp >= 15 and S >= 3 and H <= 3) \| (hcp >= 13 and S >= 4 and C >= 2 and D >= 2 and H <= 3) \| (hcp >= 18) \| (doublethenovercall('C')) \| (doublethenovercall('D')) |  |  | 24 |

#### `2S`

| Call | Means | Requires | Post-condition | Convention | Pri |
|---|---|---|---|---|---|
| P | _(unnamed — the Requires expression is the definition)_ | (hcp <= 17) |  |  |  |
| 2N | _(unnamed — the Requires expression is the definition)_ | (hcp >= 15 and hcp<= 18 and balish and doublestopper('S')) \| (hcp >= 16 and hcp<= 18 and balish and stopper('S')) |  |  | 100 |
| 3C | _(unnamed — the Requires expression is the definition)_ | (bestminor('C') and C >= 5 and H <= 2 and hcp>= 14 and hcp<= 19 and HasTopHonors('D', 2, 3)) \| (bestminor('C') and C >= 6 and hcp>= 14 and hcp<= 19) |  |  | 20 |
| 3D | _(unnamed — the Requires expression is the definition)_ | (bestminor('D') and D >= 5 and H <= 2 and hcp>= 14 and hcp<= 19 and HasTopHonors('D', 2, 3)) \| (bestminor('D') and D >= 6 and hcp>= 14 and hcp<= 19) |  |  | 20 |
| 3H | _(unnamed — the Requires expression is the definition)_ | (H >= 6 and hcp>= 13 and hcp<= 19) |  |  | 20 |
| 3S* | 5-5 in other Major and a minor | (H >= 5 and (diamonds >= 5 or clubs >= 5) and loserlevel >= 3 and hcp>= 12) |  | MichaelsCuebid2X | 110 |
| 3N | _(unnamed — the Requires expression is the definition)_ | (hcp >= 19 and hcp<= 24 and balish and stopper('S')) \| (hcp >= 20 and hcp<= 24 and S >= 4 and stopper('S')) |  |  | 50 |
| 4C | _(unnamed — the Requires expression is the definition)_ | (bestminor('C') and C >= 7 and hcp>= 19 and singlesuited and losers >= 3) | maxhcp=24 |  | 28 |
| 4D | _(unnamed — the Requires expression is the definition)_ | (bestminor('D') and D >= 7 and hcp>= 19 and singlesuited and losers >= 3) | maxhcp=24 |  | 28 |
| 4H | _(unnamed — the Requires expression is the definition)_ | (H >= 7 and H_points >= 18 and losers <= 4) \| (H >= 6 and losers <= 4 and hcp >= 15 and HasTopHonors('H', 3, 5)) | maxhcp=20 |  | 30 |
| 4S* | 5-5 in minors | (diamonds >= 5 and clubs >= 5 and losers <= 4 and hcp>= 17) |  | MichaelsCuebid2X | 120 |
| 4N* | 5-5 in minors | (diamonds >= 5 and clubs >= 5 and loserlevel >= 4 and hcp>= 12) |  | UnusualNT2M | 100 |
| 6C | Real solid suit, one-loser hand -- twelve tricks on our own | (realsolid('C') and losers == 1) | T=C |  | 140 |
| 6D | Real solid suit, one-loser hand -- twelve tricks on our own | (realsolid('D') and losers == 1) | T=D |  | 140 |
| 6H | Real solid suit, one-loser hand -- twelve tricks on our own | (realsolid('H') and losers == 1) | T=H |  | 142 |
| 7C | Real solid suit, no losers -- thirteen tricks on our own | (realsolid('C') and losers <= 0) | T=C |  | 141 |
| 7D | Real solid suit, no losers -- thirteen tricks on our own | (realsolid('D') and losers <= 0) | T=D |  | 141 |
| 7H | Real solid suit, no losers -- thirteen tricks on our own | (realsolid('H') and losers <= 0) | T=H |  | 143 |
| X | _(unnamed — the Requires expression is the definition)_ | (hcp >= 15 and H >= 3 and S <= 3) \| (hcp >= 13 and H >= 4 and C >= 2 and D >= 2 and S <= 3) \| (hcp >= 18) \| (doublethenovercall('C')) \| (doublethenovercall('D')) |  |  | 24 |

#### `3C`

| Call | Means | Requires | Post-condition | Convention | Pri |
|---|---|---|---|---|---|
| P | _(unnamed — the Requires expression is the definition)_ | (hcp <= 20 and C >= 4) \| (hcp <= 17 and (S <= 2 or H <= 2)) \| (hcp <= 16 and C >= 3) \| (hcp <= 14) |  |  |  |
| 3D | _(unnamed — the Requires expression is the definition)_ | (D >= 5 and diamondpoints >= 13 and hcp >= 11 and hcp<= 19 and S <= 4 and H <= 4) \| (D >= 6 and diamondpoints >= 14 and hcp >= 12 and hcp<= 19 and S <= 5 and H <= 5) |  |  | 31 |
| 3H | Constructive - long suit with playing tricks | (H >= 7 and losers <= 5 and hcp >= 10 and HasTopHonors('H', 1, 2)) | minhcp=14 |  | 55 |
| 3H | Constructive - quality 6-card suit | (H >= 6 and losers <= 5 and hcp >= 11 and HasTopHonors('H', 2, 3)) | minhcp=14 |  | 57 |
| 3H | _(unnamed — the Requires expression is the definition)_ | (H >= 5 and hcp>= 14 and hcp<= 19) \| (H >= 5 and S <= 1 and hcp>= 14 and hcp<= 20) \| (H >= 6 and hcp>= 14 and hcp<= 19) | minhcp=14 |  | 60 |
| 3S | Constructive - long suit with playing tricks | (S >= 7 and losers <= 5 and hcp >= 10 and HasTopHonors('S', 1, 2)) | minhcp=14 |  | 55 |
| 3S | Constructive - quality 6-card suit | (S >= 6 and losers <= 5 and hcp >= 11 and HasTopHonors('S', 2, 3)) | minhcp=14 |  | 57 |
| 3S | _(unnamed — the Requires expression is the definition)_ | (S >= 5 and hcp>= 14 and hcp<= 19) \| (S >= 5 and H <= 1 and hcp>= 14 and hcp<= 20) \| (S >= 6 and hcp>= 14 and hcp<= 19) | minhcp=14 |  | 60 |
| 3N | _(unnamed — the Requires expression is the definition)_ | (hcp >= 16 and stopper('C')) \| (hcp >= 17 and stopper('C')) |  |  | 50 |
| 4C* | Strong 2-suited | (H >= 5 and S >= 5 and losers <= 5 and C <= 4 and controls >= 5) |  | MichaelsCuebid3X | 70 |
| 4H | Constructive - long suit expects to make game | (H >= 7 and losers <= 4 and hcp >= 12 and HasTopHonors('H', 2, 3)) | minhcp=17 |  | 72 |
| 4H | Constructive - powerful 6-card suit expects game | (H >= 6 and losers <= 4 and hcp >= 14 and HasTopHonors('H', 2, 3)) | minhcp=17 |  | 73 |
| 4H | Natural overcall - 7!S (or 6 solid) - 17+ hcp | (H >= 6 and hcp >= 17) | minhcp=17 |  | 74 |
| 4S | Constructive - long suit expects to make game | (S >= 7 and losers <= 4 and hcp >= 12 and HasTopHonors('S', 2, 3)) | minhcp=17 |  | 72 |
| 4S | Constructive - powerful 6-card suit expects game | (S >= 6 and losers <= 4 and hcp >= 14 and HasTopHonors('S', 2, 3)) | minhcp=17 |  | 73 |
| 4S | Natural overcall - 7!S (or 6 solid) - 17+ hcp | (S >= 6 and hcp >= 17) | minhcp=17 |  | 74 |
| 5C | _(unnamed — the Requires expression is the definition)_ | (C >= 6 and hcp >= 10 and C_game) | minhcp=17 |  | 51 |
| 6D | Real solid suit, one-loser hand -- twelve tricks on our own | (realsolid('D') and losers == 1) | T=D |  | 140 |
| 6H | Real solid suit, one-loser hand -- twelve tricks on our own | (realsolid('H') and losers == 1) | T=H |  | 142 |
| 6S | Real solid suit, one-loser hand -- twelve tricks on our own | (realsolid('S') and losers == 1) | T=S |  | 142 |
| 7D | Real solid suit, no losers -- thirteen tricks on our own | (realsolid('D') and losers <= 0) | T=D |  | 141 |
| 7H | Real solid suit, no losers -- thirteen tricks on our own | (realsolid('H') and losers <= 0) | T=H |  | 143 |
| 7S | Real solid suit, no losers -- thirteen tricks on our own | (realsolid('S') and losers <= 0) | T=S |  | 143 |
| X | _(unnamed — the Requires expression is the definition)_ | (hcp >= 13 and H >= 3 and S >= 3 and C <= 3 and not bestsuit('C')) \| (hcp >= 14 and H >= 4 and S >= 4) \| (takeout('C')) \| (hcp >= 20) |  |  | 32 |

#### `3D`

| Call | Means | Requires | Post-condition | Convention | Pri |
|---|---|---|---|---|---|
| P | _(unnamed — the Requires expression is the definition)_ | (hcp <= 20 and D >= 4) \| (hcp <= 17 and (S <= 2 or H <= 2)) \| (hcp <= 16 and D >= 3) \| (hcp <= 14) |  |  |  |
| 3H | Constructive - long suit with playing tricks | (H >= 7 and losers <= 5 and hcp >= 10 and HasTopHonors('H', 1, 2)) | minhcp=14 |  | 55 |
| 3H | Constructive - quality 6-card suit | (H >= 6 and losers <= 5 and hcp >= 11 and HasTopHonors('H', 2, 3)) | minhcp=14 |  | 57 |
| 3H | _(unnamed — the Requires expression is the definition)_ | (H >= 5 and hcp>= 14 and hcp<= 19) \| (H >= 5 and S <= 1 and hcp>= 14 and hcp<= 20) \| (H >= 6 and hcp>= 14 and hcp<= 19) | minhcp=14 |  | 60 |
| 3S | Constructive - long suit with playing tricks | (S >= 7 and losers <= 5 and hcp >= 10 and HasTopHonors('S', 1, 2)) | minhcp=14 |  | 55 |
| 3S | Constructive - quality 6-card suit | (S >= 6 and losers <= 5 and hcp >= 11 and HasTopHonors('S', 2, 3)) | minhcp=14 |  | 57 |
| 3S | _(unnamed — the Requires expression is the definition)_ | (S >= 5 and hcp>= 14 and hcp<= 19) \| (S >= 5 and H <= 1 and hcp>= 14 and hcp<= 20) \| (S >= 6 and hcp>= 14 and hcp<= 19) | minhcp=14 |  | 60 |
| 3N | _(unnamed — the Requires expression is the definition)_ | (hcp >= 16 and stopper('D')) \| (hcp >= 17 and stopper('D')) |  |  | 50 |
| 4C | _(unnamed — the Requires expression is the definition)_ | (C >= 5 and clubpoints >= 14 and hcp<= 19 and hcp>= 14 and S <= 4 and H <= 4) \| (C >= 6 and clubpoints >= 14 and hcp<= 19 and hcp>= 10 and S <= 5 and H <= 5) | minhcp = 15 |  | 20 |
| 4D* | Strong 2-suited | (H >= 5 and S >= 5 and losers <= 5 and D <= 4 and controls >= 5) |  | MichaelsCuebid3X | 70 |
| 4H | Constructive - long suit expects to make game | (H >= 7 and losers <= 4 and hcp >= 12 and HasTopHonors('H', 2, 3)) | minhcp=17 |  | 72 |
| 4H | Constructive - powerful 6-card suit expects game | (H >= 6 and losers <= 4 and hcp >= 14 and HasTopHonors('H', 2, 3)) | minhcp=17 |  | 73 |
| 4H | Natural overcall - 7!S (or 6 solid) - 17+ hcp | (H >= 6 and hcp >= 17) | minhcp=17 |  | 74 |
| 4S | Constructive - long suit expects to make game | (S >= 7 and losers <= 4 and hcp >= 12 and HasTopHonors('S', 2, 3)) | minhcp=17 |  | 72 |
| 4S | Constructive - powerful 6-card suit expects game | (S >= 6 and losers <= 4 and hcp >= 14 and HasTopHonors('S', 2, 3)) | minhcp=17 |  | 73 |
| 4S | Natural overcall - 7!S (or 6 solid) - 17+ hcp | (S >= 6 and hcp >= 17) | minhcp=17 |  | 74 |
| 5C | _(unnamed — the Requires expression is the definition)_ | (C >= 6 and hcp >= 10 and C_game) | minhcp=17 |  | 51 |
| 6C | Real solid suit, one-loser hand -- twelve tricks on our own | (realsolid('C') and losers == 1) | T=C |  | 140 |
| 6H | Real solid suit, one-loser hand -- twelve tricks on our own | (realsolid('H') and losers == 1) | T=H |  | 142 |
| 6S | Real solid suit, one-loser hand -- twelve tricks on our own | (realsolid('S') and losers == 1) | T=S |  | 142 |
| 7C | Real solid suit, no losers -- thirteen tricks on our own | (realsolid('C') and losers <= 0) | T=C |  | 141 |
| 7H | Real solid suit, no losers -- thirteen tricks on our own | (realsolid('H') and losers <= 0) | T=H |  | 143 |
| 7S | Real solid suit, no losers -- thirteen tricks on our own | (realsolid('S') and losers <= 0) | T=S |  | 143 |
| X | _(unnamed — the Requires expression is the definition)_ | (hcp >= 13 and H >= 3 and S >= 3 and D <= 3 and not bestsuit('D')) \| (hcp >= 14 and H >= 4 and S >= 4) \| (takeout('D')) \| (hcp >= 20) |  |  | 32 |

#### `3H`

| Call | Means | Requires | Post-condition | Convention | Pri |
|---|---|---|---|---|---|
| P | _(unnamed — the Requires expression is the definition)_ | (hcp <= 20 and H >= 4) \| (hcp <= 17) |  |  |  |
| 3S | _(unnamed — the Requires expression is the definition)_ | (S >= 5 and hcp>= 12) \| (S >= 6 and hcp>= 14 and hcp<= 19) |  |  | 25 |
| 3N | _(unnamed — the Requires expression is the definition)_ | (hcp >= 17 and stopper('H')) \| (hcp >= 17 and doublestopper('H')) |  |  | 60 |
| 4C | _(unnamed — the Requires expression is the definition)_ | (C >= 5 and hcp>= 16 and hcp<= 19) \| (C >= 6 and hcp>= 14 and hcp<= 19) |  |  | 22 |
| 4D | _(unnamed — the Requires expression is the definition)_ | (D >= 5 and hcp>= 16 and hcp<= 19) \| (D >= 6 and hcp>= 14 and hcp<= 19) |  |  | 22 |
| 4H* | Strong 2-suited | (S >= 5 and (D >= 5 or C >= 5) and losers <= 5 and H <= 3 and hcp >= 15) |  | MichaelsCuebid3X | 70 |
| 4S | _(unnamed — the Requires expression is the definition)_ | (S >= 6 and hcp>= 14 and hcp<= 19) \| (S >= 6 and losers <= 4) \| (S >= 7 and losers <= 3) | minhcp=14 |  | 75 |
| 4N* | Unusual NT | (C >= 5 and D >= 5 and loserlevel >= 5 and hcp >= 15) | minhcp=15 | UnusualNT3X | 110 |
| 6C | Real solid suit, one-loser hand -- twelve tricks on our own | (realsolid('C') and losers == 1) | T=C |  | 140 |
| 6D | Real solid suit, one-loser hand -- twelve tricks on our own | (realsolid('D') and losers == 1) | T=D |  | 140 |
| 6S | Real solid suit, one-loser hand -- twelve tricks on our own | (realsolid('S') and losers == 1) | T=S |  | 142 |
| 7C | Real solid suit, no losers -- thirteen tricks on our own | (realsolid('C') and losers <= 0) | T=C |  | 141 |
| 7D | Real solid suit, no losers -- thirteen tricks on our own | (realsolid('D') and losers <= 0) | T=D |  | 141 |
| 7S | Real solid suit, no losers -- thirteen tricks on our own | (realsolid('S') and losers <= 0) | T=S |  | 143 |
| X | _(unnamed — the Requires expression is the definition)_ | (hcp >= 18) \| (S >= 4 and hcp>= 14 and C >= 3 and D >= 3) \| (S >= 3 and hcp>= 17 and C >= 3 and D >= 3) |  |  | 18 |

#### `3S`

| Call | Means | Requires | Post-condition | Convention | Pri |
|---|---|---|---|---|---|
| P | _(unnamed — the Requires expression is the definition)_ | (hcp <= 20 and S >= 4) \| (hcp <= 17) |  |  |  |
| 3N | _(unnamed — the Requires expression is the definition)_ | (hcp >= 17 and stopper('S')) \| (hcp >= 17 and doublestopper('S')) |  |  | 60 |
| 4C | _(unnamed — the Requires expression is the definition)_ | (C >= 5 and hcp>= 16 and hcp<= 19) \| (C >= 6 and hcp>= 14 and hcp<= 19) |  |  | 22 |
| 4D | _(unnamed — the Requires expression is the definition)_ | (D >= 5 and hcp>= 16 and hcp<= 19) \| (D >= 6 and hcp>= 14 and hcp<= 19) |  |  | 22 |
| 4H | _(unnamed — the Requires expression is the definition)_ | (H >= 6 and hcp>= 14 and hcp<= 19) \| (H >= 6 and losers <= 4) \| (H >= 7 and losers <= 3) | minhcp=14 |  | 75 |
| 4S* | Strong 2-suited | (H >= 5 and (D >= 5 or C >= 5) and losers <= 5 and S <= 3 and hcp >= 15) |  | MichaelsCuebid3X | 70 |
| 4N* | Unusual NT | (C >= 5 and D >= 5 and loserlevel >= 5 and hcp >= 15) | minhcp=15 | UnusualNT3X | 110 |
| 6C | Real solid suit, one-loser hand -- twelve tricks on our own | (realsolid('C') and losers == 1) | T=C |  | 140 |
| 6D | Real solid suit, one-loser hand -- twelve tricks on our own | (realsolid('D') and losers == 1) | T=D |  | 140 |
| 6H | Real solid suit, one-loser hand -- twelve tricks on our own | (realsolid('H') and losers == 1) | T=H |  | 142 |
| 7C | Real solid suit, no losers -- thirteen tricks on our own | (realsolid('C') and losers <= 0) | T=C |  | 141 |
| 7D | Real solid suit, no losers -- thirteen tricks on our own | (realsolid('D') and losers <= 0) | T=D |  | 141 |
| 7H | Real solid suit, no losers -- thirteen tricks on our own | (realsolid('H') and losers <= 0) | T=H |  | 143 |
| X | _(unnamed — the Requires expression is the definition)_ | (hcp >= 18) \| (H >= 4 and hcp>= 14 and C >= 3 and D >= 3) \| (H >= 3 and hcp>= 17 and C >= 3 and D >= 3) |  |  | 18 |

#### `4C`

| Call | Means | Requires | Post-condition | Convention | Pri |
|---|---|---|---|---|---|
| P | _(unnamed — the Requires expression is the definition)_ | (hcp <= 16 and (S <= 2 or H <= 2)) \| (hcp <= 18) |  |  |  |
| 4D | _(unnamed — the Requires expression is the definition)_ | (D >= 6 and hcp>= 14 and hcp<= 19) |  |  | -1 |
| 4H | _(unnamed — the Requires expression is the definition)_ | (bestmajor('H') and H >= 5 and hcp>= 14 and hcp<= 19) \| (bestmajor('H') and H >= 6 and hcp>= 14 and hcp<= 19) |  |  | 10 |
| 4S | _(unnamed — the Requires expression is the definition)_ | (bestmajor('S') and S >= 5 and hcp>= 14 and hcp<= 19) \| (bestmajor('S') and S >= 6 and hcp>= 14 and hcp<= 19) |  |  | 10 |
| 5C* | Strong 2-suited | (H >= 5 and S >= 5 and losers <= 2 and C <= 4) |  | MichaelsCuebid4X | 70 |
| X | _(unnamed — the Requires expression is the definition)_ | (hcp >= 13 and C <= 1 and h >= 3 and S >= 3) \| (hcp >= 14 and h >= 4 and S >= 4) \| (hcp >= 16 and H >= 2 and S >= 2) \| (hcp >= 19) |  |  | 30 |

#### `4D`

| Call | Means | Requires | Post-condition | Convention | Pri |
|---|---|---|---|---|---|
| P | _(unnamed — the Requires expression is the definition)_ | (hcp <= 16 and (S <= 2 or H <= 2)) \| (hcp <= 18) |  |  |  |
| 4H | _(unnamed — the Requires expression is the definition)_ | (bestmajor('H') and H >= 5 and hcp>= 14 and hcp<= 19) \| (bestmajor('H') and H >= 6 and hcp>= 14 and hcp<= 19) |  |  | 10 |
| 4S | _(unnamed — the Requires expression is the definition)_ | (bestmajor('S') and S >= 5 and hcp>= 14 and hcp<= 19) \| (bestmajor('S') and S >= 6 and hcp>= 14 and hcp<= 19) |  |  | 10 |
| 5C | _(unnamed — the Requires expression is the definition)_ | (C >= 7 and losers <= 4 and hcp>= 14) |  |  | 20 |
| 5D* | Strong 2-suited | (H >= 5 and S >= 5 and losers <= 2 and D <= 4) |  | MichaelsCuebid4X | 70 |
| X | _(unnamed — the Requires expression is the definition)_ | (hcp >= 13 and D <= 1 and h >= 3 and S >= 3) \| (hcp >= 14 and h >= 4 and S >= 4) \| (hcp >= 16 and H >= 2 and S >= 2) \| (hcp >= 19) |  |  | 30 |

#### `4H`

| Call | Means | Requires | Post-condition | Convention | Pri |
|---|---|---|---|---|---|
| P | _(unnamed — the Requires expression is the definition)_ | (makessense) |  |  |  |
| 4S | _(unnamed — the Requires expression is the definition)_ | (hcp >= 12 and S >= 5 and losers <= 4) \| (hcp >= 10 and S >= 6 and losers <= 5) \| (hcp >= 14 and S >= 6) |  |  | 25 |
| 4N* | Unusual NT | (C >= 5 and D >= 5 and loserlevel >= 4) |  | UnusualNT4X | 110 |
| 5C | Board: 880009, Hand: .AKT983.AK9853.A [MS=3a-loser-game(losers=2,ownTricks=11,game=5D,contract=4S)] | (twicerebiddable('C') and losers <= 2) \| (C_compgame) \| (cansacrifice('C')) | T=C |  | 29 |
| 5C | _(unnamed — the Requires expression is the definition)_ | (C >= 7 and hcp >= 16) \| (C >= 7 and loserlevel >= 5) | minhcp=15 |  | 30 |
| 5D | Board: 880009, Hand: .AKT983.AK9853.A [MS=3a-loser-game(losers=2,ownTricks=11,game=5D,contract=4S)] | (twicerebiddable('D') and losers <= 2) \| (D_compgame) \| (cansacrifice('D')) | T=D |  | 29 |
| 5D | _(unnamed — the Requires expression is the definition)_ | (D >= 7 and hcp >= 16) \| (D >= 7 and loserlevel >= 5) | minhcp=15 |  | 30 |
| 5S | Hand: .AKQJT9653.K3.62 (GameEval) | (cansacrifice('S')) |  |  | 43 |
| X | _(unnamed — the Requires expression is the definition)_ | (hcp >= 14 and H <= 2 and S >= 4) \| (hcp >= 15 and H <= 1 and S >= 3) \| (hcp >= 18) \| (takeout('H')) |  |  | 24 |

#### `4S`

| Call | Means | Requires | Post-condition | Convention | Pri |
|---|---|---|---|---|---|
| P | _(unnamed — the Requires expression is the definition)_ | (makessense) |  |  |  |
| 4N* | Takeout of spades - hearts and both minors | ((D >= 5 and C >= 5 and loserlevel >= 4) or (S <= 1 and hcp >= 13 and H >= 3 and D >= 3 and C >= 3)) | F1 | Takeout4NOver4S | 120 |
| 5C | Board: 880009, Hand: .AKT983.AK9853.A [MS=3a-loser-game(losers=2,ownTricks=11,game=5D,contract=4S)] | (twicerebiddable('C') and losers <= 2) \| (C_compgame) \| (cansacrifice('C')) | T=C |  | 29 |
| 5C | _(unnamed — the Requires expression is the definition)_ | (C >= 7 and hcp >= 16) \| (C >= 7 and loserlevel >= 5) | minhcp=15 |  | 30 |
| 5D | Board: 880009, Hand: .AKT983.AK9853.A [MS=3a-loser-game(losers=2,ownTricks=11,game=5D,contract=4S)] | (twicerebiddable('D') and losers <= 2) \| (D_compgame) \| (cansacrifice('D')) | T=D |  | 29 |
| 5D | _(unnamed — the Requires expression is the definition)_ | (D >= 7 and hcp >= 16) \| (D >= 7 and loserlevel >= 5) | minhcp=15 |  | 30 |
| 5H | Hand: .AKQJT9653.K3.62 (GameEval) | (cansacrifice('H')) |  |  | 43 |
| X | Penalty | (penalty) |  | Takeout4NOver4S | 23 |
| X | Penalty - strong balanced hand with spade length | (hcp >= 16 and S >= 2 and S <= 3 and balanced) | minhcp = 16, penaltyInterest | Takeout4NOver4S | 120 |

#### `5C`

| Call | Means | Requires | Post-condition | Convention | Pri |
|---|---|---|---|---|---|
| P | _(unnamed — the Requires expression is the definition)_ | (true) |  |  |  |
| 5H | Hand: AK87.AKQ76542.3. (GameEval) | (cansacrifice('H')) |  |  | 44 |
| 5S | Hand: AK87.AKQ76542.3. (GameEval) | (cansacrifice('S')) |  |  | 44 |
| X | Hand: 973.A52.AKT83.93 (PenaltyDouble) | (penalty) |  |  | 90 |

#### `5D`

_Same rule set as `5C` — the service returns an identical table for this position._

#### `5H`

| Call | Means | Requires | Post-condition | Convention | Pri |
|---|---|---|---|---|---|
| P | _(unnamed — the Requires expression is the definition)_ | (true) |  |  |  |
| 5S | Hand: AKQ76542.A.A62.7 (GameEval) | (S_compgame) |  |  | 44 |
| X | Hand: AQJ7.95.AK73.K92 (PenaltyDouble) | (penalty) |  |  | 90 |

#### `5S`

| Call | Means | Requires | Post-condition | Convention | Pri |
|---|---|---|---|---|---|
| P | _(unnamed — the Requires expression is the definition)_ | (true) |  |  |  |
| X | Hand: AQJ7.95.AK73.K92 (PenaltyDouble) | (penalty) |  |  | 90 |

#### `6C`

| Call | Means | Requires | Post-condition | Convention | Pri |
|---|---|---|---|---|---|
| P | Default, when no other bid found | (makessense) |  |  | -1000 |
| X | Penalty | (penalty) |  |  | -900 |

#### `6D`

_Same rule set as `6C` — the service returns an identical table for this position._

#### `6H`

_Same rule set as `6C` — the service returns an identical table for this position._

#### `6S`

_Same rule set as `6C` — the service returns an identical table for this position._

#### `7C`

_Same rule set as `6C` — the service returns an identical table for this position._

#### `7D`

_Same rule set as `6C` — the service returns an identical table for this position._

#### `7H`

_Same rule set as `6C` — the service returns an identical table for this position._

#### `7S`

_Same rule set as `6C` — the service returns an identical table for this position._

#### `*`

| Call | Means | Requires | Post-condition | Convention | Pri |
|---|---|---|---|---|---|
| P | No opening bid | (hcp < 12 and not ruleof21) |  |  |  |
| 1C | 12-21 HCP, 3+ clubs | ((ruleof21 and hcp<= 21) and (clublongest or explicitshape == '4=3=3=3' or explicitshape == '3=4=3=3' or explicitshape == '4=4=2=3') ) \| ((HCP >= 12 and hcp<= 21) and (clublongest or explicitshape == '4=3=3=3' or explicitshape == '3=4=3=3' or explicitshape == '4=4=2=3') ) | minC=3 |  | 60 |
| 1D | 12-21 HCP, 3+ diamonds | ((ruleof21 and hcp<= 21) and (diamondlongest or explicitshape == '4=4=3=2')) \| ((HCP >= 12 and hcp<= 21) and (diamondlongest or explicitshape == '4=4=3=2')) | minD=3 |  | 65 |
| 1H | 4th seat opening, Rule of 15 (HCP + spades >= 15) | (fourthseatopening('H') and bestsuit('H')) | minhcp = 12 |  | 56 |
| 1H | Light opening, 11 HCP with 5-4 in the majors or a 6-card major | (lightmajoropening('H')) | minhcp = 12 |  | 61 |
| 1H | 12-21 HCP, 5+ hearts | (ruleof21 and hcp<= 21 and Opening1H) \| ((HCP >= 12 and hcp<= 21) and Opening1H) |  |  | 70 |
| 1S | 4th seat opening, Rule of 15 (HCP + spades >= 15) | (fourthseatopening('S') and bestsuit('S')) | minhcp = 12 |  | 57 |
| 1S | Light opening, 11 HCP with 5-4 in the majors or a 6-card major | (lightmajoropening('S')) | minhcp = 12 |  | 62 |
| 1S | 12-21 HCP, 5+ spades | (ruleof21 and hcp<= 21 and spades >= 5 and spadelongest) \| (hcp>= 12 and hcp<= 21 and Opening1S) |  |  | 75 |
| 1N | Balanced hand, 15-17 HCP | (Balanced and hcp>= 15 and hcp<= 16 and H == 5) \| (Balanced and hcp>= 15 and hcp<= 16 and S == 5) \| ((Balanced or semibalanced) and hcp>= 15 and hcp<= 17 and S <= 4 and H <= 4) |  |  | 120 |
| 2C* | Strong -- 0-1 losers, slam in our own hand | (losers <= 1 and hcp>= 16) | minhcp=18 |  | 112 |
| 2C* | Strong -- 2 losers, ~11 playing tricks | (losers <= 2 and hcp>= 16 and lengthlongestsuit >= 5) | minhcp=18 |  | 113 |
| 2C* | Strong | (hcp>= 18 and (not twosuited or hcp >= 20) and bestsuit('C') and C >= 6 and losers <= 2 and aces >= 2) \| (hcp>= 18 and (not twosuited or hcp >= 20) and bestsuit('D') and D >= 6 and losers <= 2 and aces >= 2) \| (hcp>= 18 and (not twosuited or hcp >= 20) and bestsuit('H') and H >= 6 and losers <= 3 and aces >= 2) \| (hcp>= 18 and (not twosuited or hcp >= 20) and bestsuit('S') and S >= 6 and losers <= 3 and aces >= 2) \| (hcp>= 22 and (balanced or semibalanced)) \| (hcp>= 22 and losers <= 5) | minhcp=18 |  | 118 |
| 2D | Weak 2 D | (hcp<= 11 and D == 6 and hcp> 4 and bestsuit('D') and HasTopHonors('D', 2, 3) and S <= 4 and H <= 4 and not ruleof21) \| (hcp<= 11 and D == 6 and hcp> 4 and bestsuit('D') and loserlevel >= 2 and D_points >= 6 and S <= 4 and H <= 4 and not ruleof21) | preempt,minhcp=6,loserlevel=2 |  | 60 |
| 2H | Weak 2 H | (hcp<= 11 and H == 6 and hcp> 4 and bestsuit('H') and HasTopHonors('H', 2, 3) and S <= 3 and not ruleof21) \| (hcp<= 11 and H == 6 and hcp> 4 and bestsuit('H') and loserlevel >= 2 and H_points >= 6 and S <= 4 and not ruleof21) | preempt,minhcp=6,loserlevel=2 |  | 60 |
| 2S | Weak 2 S | (hcp<= 11 and S == 6 and hcp> 4 and bestsuit('S') and HasTopHonors('S', 2, 3) and H <= 3 and not ruleof21) \| (hcp<= 11 and S == 6 and hcp> 4 and bestsuit('S') and loserlevel >= 2 and S_points >= 6 and H <= 4 and not ruleof21) | preempt,minhcp=6,loserlevel=2 |  | 60 |
| 2N | Balanced hand, 20-21 HCP | (balish and hcp>= 20 and hcp<= 21) | minS=2, minH=2, minD=2, minC=2 |  | 122 |
| 3C | Preempt, good suit | (C >= 7 and hcp>= 5 and hcp<= 10 and TwiceRebiddable('C') and loserlevel >= 3 and H <= 4 and S <= 4 and not ruleof21) | preempt, maxlosers=7 |  | 83 |
| 3C | Preempt | (clubs >= 7 and hcp>= 5 and hcp<= 11 and totalpoints >= 6 and not ruleof21 and H <= 4 and S <= 4) | preempt, minhcp=7, maxlosers=7 |  | 85 |
| 3D | Preempt, good suit | (D >= 7 and hcp>= 5 and hcp<= 10 and TwiceRebiddable('D') and loserlevel >= 3 and H <= 4 and S <= 4 and not ruleof21) | preempt, maxlosers=7 |  | 83 |
| 3D | Preempt | (diamonds >= 7 and hcp>= 5 and hcp<= 11 and totalpoints >= 6 and not ruleof21 and H <= 4 and S <= 4 ) | preempt, maxlosers=7 |  | 86 |
| 3H | Preempt, good suit | (H >= 7 and hcp>= 5 and hcp<= 10 and TwiceRebiddable('H') and loserlevel >= 3 and S <= 4 and not ruleof21) | preempt, maxlosers=7 |  | 84 |
| 3H | Preempt | (hearts >= 7 and hcp>= 5 and hcp<= 11 and totalpoints >= 6 and not ruleof21 and S <= 4) | preempt, maxlosers=7 |  | 87 |
| 3S | Preempt, good suit | (S >= 7 and hcp>= 5 and hcp<= 10 and TwiceRebiddable('S') and loserlevel >= 3 and H <= 4 and not ruleof21) | preempt, maxlosers=7 |  | 84 |
| 3S | Preempt | (spades >= 7 and hcp>= 5 and hcp<= 11 and totalpoints >= 6 and not ruleof21 and H <= 4) | preempt, maxlosers=7 |  | 88 |
| 3N | Balanced hand, 25-27 HCP | (balish and hcp>= 25 and hcp<= 27 and H<= 4 and S <= 4) |  |  | 130 |
| 4C | Preempt | (C >= 7 and hcp>= 5 and hcp<= 11 and loserlevel >= 4 and H <= 4 and S <= 4 and not ruleof21) \| (C >= 8 and hcp>= 5 and hcp<= 11 and loserlevel >= 3 and H <= 4 and S <= 4 and not ruleof21) | preempt, loserlevel=4 |  | 97 |
| 4D | Preempt | (D >= 7 and hcp>= 5 and hcp<= 11 and loserlevel >= 4 and H <= 4 and S <= 4 and not ruleof21) \| (D >= 8 and hcp>= 5 and hcp<= 11 and loserlevel >= 3 and H <= 4 and S <= 4 and not ruleof21) | preempt, loserlevel=4 |  | 97 |
| 4H | Preempt | (H >= 8 and hcp>= 5 and hcp<= 11 and loserlevel >= 4 and S <= 4) \| (H >= 7 and hcp>= 7 and hcp<= 11 and loserlevel >= 4 and S <= 4) | preempt, loserlevel=4 |  | 128 |
| 4S | Preempt | (S >= 8 and hcp>= 5 and hcp<= 11 and loserlevel >= 4 and H <= 4) \| (S >= 7 and hcp>= 7 and hcp<= 11 and loserlevel >= 4 and H <= 4) | preempt, loserlevel=4 |  | 128 |
| 5C | Preempt -- 8+ C; 6-11 HCP assumed | (C >= 8 and hcp>= 6 and hcp<= 11 and loserlevel >= 5 and H <= 4 and S <= 4) | preempt, loserlevel=5 |  | 98 |
| 5D | Preempt -- 8+ D; 6-11 HCP assumed | (D >= 8 and hcp>= 6 and hcp<= 11 and loserlevel >= 5 and H <= 4 and S <= 4) | preempt, loserlevel=5 |  | 98 |
| 5H | Preempt -- 9+ H; 6-11 HCP assumed | (H >= 9 and hcp>= 6 and hcp<= 11 and loserlevel >= 5 and S <= 4) | preempt, loserlevel=5 |  | 129 |
| 5S | Preempt -- 9+ S; 6-11 HCP assumed | (S >= 9 and hcp>= 6 and hcp<= 11 and loserlevel >= 5 and H <= 4) | preempt, loserlevel=5 |  | 129 |
| 6C | Strong rebiddable C; 32+ total points | (clubs >= 9 and totalpoints >= 32) |  |  | 10 |
| 6D | Strong rebiddable D; 32+ total points | (diamonds >= 9 and totalpoints >= 32) |  |  | 11 |
| 6H | Strong rebiddable H; 32+ total points | (hearts >= 9 and totalpoints >= 32) |  |  | 12 |
| 6S | Strong rebiddable S; 32+ total points | (spades >= 9 and totalpoints >= 32) |  |  | 13 |
| 6N | 33-34 HCP | (balanced and hcp>= 33 and hcp<= 34) |  |  | 14 |
| 7C | 31+ HCP; strong rebiddable C; 35+ total points | (clubs >= 9 and hcp>= 31 and totalpoints >= 35) |  |  | 15 |
| 7D | 31+ HCP; strong rebiddable D; 35+ total points | (diamonds >= 9 and hcp>= 31 and totalpoints >= 35) |  |  | 23 |
| 7H | 31+ HCP; strong rebiddable H; 35+ total points | (hearts >= 9 and hcp>= 31 and totalpoints >= 35) |  |  | 24 |
| 7S | 31+ HCP; strong rebiddable S; 35+ total points | (spades >= 9 and hcp>= 31 and totalpoints >= 35) |  |  | 25 |
| 7N | 36+ HCP; 35+ total points | (balanced and hcp>= 36 and totalpoints >= 35) |  |  | 26 |

#### `1N`

| Call | Means | Requires | Post-condition | Convention | Pri |
|---|---|---|---|---|---|
| P | _(unnamed — the Requires expression is the definition)_ | (true) |  |  | 10 |
| 2C* | Cappelletti - single suited | (totalpoints >= 10 and lengthlongestsuit >= 6 and singlesuited and hcp >= 10) \| (totalpoints >= 10 and lengthlongestsuit >= 7 and hcp >= 10) | minhcp=10,maxhcp=20 | Cappelletti | 50 |
| 2D* | Cappelletti - majors | (H >= 5 and S >= 5 and hcp >= 10) | maxhcp=20 | Cappelletti | 90 |
| 2H* | Cappelletti - H and a minor | (H >= 5 and (C >= 4 or D >= 4) and loserlevel >= 2 and totalpoints >= 12 and hcp >= 10) | maxhcp=17 | Cappelletti | 60 |
| 2S* | Cappelletti - S and a minor | (S >= 5 and (C >= 4 or D >= 4) and loserlevel >= 2 and totalpoints >= 12 and hcp >= 10) | maxhcp=17 | Cappelletti | 60 |
| 2N* | Cappelletti - minors | (C >= 5 and D >= 5 and totalpoints >= 15 and hcp >= 10) | minhcp=10,maxhcp=17 | Cappelletti | 80 |
| 3C | Strong rebiddable, 14-16 totalpoints | (rebiddable('C') and C >= 7 and C_Points >= 14 and C_points <= 17) |  |  | 65 |
| 3D | Strong rebiddable, 14-16 totalpoints | (rebiddable('D') and D >= 7 and D_Points >= 14 and D_points <= 17) |  |  | 65 |
| 3H | Strong rebiddable, 14-16 totalpoints | (rebiddable('H') and H >= 7 and H_Points >= 14 and H_points <= 17) |  |  | 70 |
| 3S | Strong rebiddable, 14-16 totalpoints | (rebiddable('S') and S >= 7 and S_Points >= 14 and S_points <= 17) |  |  | 70 |
| 4C | Preempt | (rebiddable('C') and C >= 7 and hcp<= 10 and loserlevel >= 4) | minhcp = 7 |  | 75 |
| 4D | Preempt | (rebiddable('D') and D >= 7 and hcp<= 10 and loserlevel >= 4) | minhcp = 7 |  | 75 |
| 4H | Preempt | (rebiddable('H') and H >= 7 and hcp<= 10 and loserlevel >= 4) | minhcp = 7 |  | 80 |
| 4S | Preempt | (rebiddable('S') and S >= 7 and hcp<= 10 and loserlevel >= 4) | minhcp = 7 |  | 80 |
| X* | Penalty | (ispenalty and hcp >= 16) |  | 1NXPenalty | 60 |

#### `2N`

| Call | Means | Requires | Post-condition | Convention | Pri |
|---|---|---|---|---|---|
| P | _(unnamed — the Requires expression is the definition)_ | (true) |  |  |  |
| 3C | Hand: .QT764..KQJ76542 (Partscore) | (overcall('C')) |  |  | 21 |
| 3D | Hand: .QT764..KQJ76542 (Partscore) | (overcall('D')) |  |  | 21 |
| 3H | Hand: Q.QJT87632.3.AK6 (Partscore) | (overcall('H')) |  |  | 24 |
| 3S | Hand: Q.QJT87632.3.AK6 (Partscore) | (overcall('S')) |  |  | 24 |
| 4C | Hand: JT62.7.6.AKQJ863 (Overcall) | (fourlevelovercall('C')) |  |  | 31 |
| 4D | Hand: JT62.7.6.AKQJ863 (Overcall) | (fourlevelovercall('D')) |  |  | 31 |
| 4H | Hand: KQJT532.T.6.KQ85 (Overcall) | (fourlevelovercall('H')) |  |  | 54 |
| 4S | Hand: KQJT532.T.6.KQ85 (Overcall) | (fourlevelovercall('S')) |  |  | 54 |
| 5C | Hand: .A.KQT97652.QT97 (GameEval) | (C_compgame) |  |  | 51 |
| 5D | Hand: .A.KQT97652.QT97 (GameEval) | (D_compgame) |  |  | 51 |

#### `3N`

| Call | Means | Requires | Post-condition | Convention | Pri |
|---|---|---|---|---|---|
| P | _(unnamed — the Requires expression is the definition)_ | (true) |  |  |  |
| 4C | Hand: KJT3.Q.KJT7653.2 (Overcall) | (fourlevelovercall('C')) |  |  | 31 |
| 4D | Hand: KJT3.Q.KJT7653.2 (Overcall) | (fourlevelovercall('D')) |  |  | 31 |
| 4H | Hand: KT642.AKJT832..6 (Overcall) | (fourlevelovercall('H')) |  |  | 54 |
| 4S | Hand: KT642.AKJT832..6 (Overcall) | (fourlevelovercall('S')) |  |  | 54 |

#### `6N`

_Same rule set as `6C` — the service returns an identical table for this position._

#### `7N`

| Call | Means | Requires | Post-condition | Convention | Pri |
|---|---|---|---|---|---|
| P | Penalty | (true) |  |  |  |
| X | _(unnamed — the Requires expression is the definition)_ | (aces >= 1 and willbeonlead) |  |  | 10 |

### Continuations (two calls made)

#### `1C-P`

| Call | Means | Requires | Post-condition | Convention | Pri |
|---|---|---|---|---|---|
| P | hcp < 6 | (hcp < 6) |  |  |  |
| 1D | Nat | (hcp > 5 and (diamondlongest and not (diamonds >= 5 and (spadelongest or heartlongest)))) |  |  | 30 |
| 1H | 4+ H | (hcp > 4 and (h >= 4 and (heartlongest or clublongest) and not (H >= 5 and spadelongest))) |  |  | 20 |
| 1S | Nat | (hcp > 4 and S >= 4 and S >= H and S >= D and (spadelongest or clublongest or hcp < 12)) |  |  | 18 |
| 1N | 6-10 hcp | (hcp <= 10 and hcp>= 6 and spades < 4 and hearts < 4 and balanced) |  |  | 10 |
| 2C* | Inverted | (C >= 4 and hcp>= 10 and H < 4 and S < 4 and clublongest) |  | InvertedMinor | 80 |
| 2D* | Soloway | ((hcp >= 17 or diamondpoints >= 20) and (solid('D') or semisolid('D')) and singlesuited and controls >= 4) \| (D >= 5 and C >= 4 and hcp> 17 and controls >= 4 and S <= 3 and H <= 3) \| (D >= 5 and balanced and hcp> 17 and controls >= 4) \| (D >= 6 and singlesuited and hcp>= 17 and controls >= 4) | GF | Soloway | 100 |
| 2H* | Soloway | (hcp >= 16 and (solid('H') or semisolid('H') or H >= 7) and singlesuited and controls >= 4) \| (H >= 5 and C >= 4 and hcp> 17 and controls >= 4) \| (H >= 6 and balish and hcp>= 17 and controls >= 4) | GF | Soloway | 100 |
| 2S* | Soloway | (hcp >= 16 and (solid('S') or semisolid('S') or S >= 7) and singlesuited and controls >= 4) \| (S >= 5 and C >= 4 and hcp> 17 and controls >= 4) \| (S >= 6 and balish and hcp>= 17 and controls >= 4) | GF | Soloway | 100 |
| 2N | Invitational | ((balanced or semibalanced) and hcp>= 10 and hcp<= 12 and S < 4 and H < 4) |  |  | 65 |
| 3C | Preemptive | (C >= 5 and hcp< 10 and H < 4 and S < 4 and hcp >= 4 and clublongest) | minhcp=6 |  | 32 |
| 3D* | Splinter | (C >= 5 and D <= 1 and totalpoints >= 14 and H <= 3 and S <= 3 ) | T=C |  | 24 |
| 3H* | Splinter | (H <= 1 and totalpoints >= 14 and C >= 5 and S <= 3) | T=C |  | 150 |
| 3S* | Splinter | (S <= 1 and totalpoints >= 14 and C >= 5 and H <= 3) | T=C |  | 150 |
| 3N | Nat | (balanced and hcp> 12 and hcp< 16 and S < 4 and H < 4) |  |  | 60 |
| 4H | Preemptive | (H >= 7 and hcp<= 10 and hcp>= 6) |  |  | 50 |
| 4S | Preemptive | (S >= 7 and hcp<= 10 and hcp>= 6) |  |  | 50 |
| 4N* | RKC | (CanAsk_C_RKC) \| (C_slam) | T=C | RKC0314_C | 20 |
| 5C | _(unnamed — the Requires expression is the definition)_ | (C >= 7 and hcp<= 10 and hcp>= 5) |  |  | 51 |
| 5D | Preemptive | (D >= 8 and hcp<= 10 and hcp>= 5) |  |  | 72 |
| 5N* | GSForce | (CanAsk_C_GSF) | T=C | GSForce | 75 |
| 6C | To Play | (CanBid6_C) |  |  |  |
| 6C | Playing strength: one loser with a real solid suit or an agreed fit | ((realsolid('C') or trump('C')) and losers == 1) | T=C |  | 5 |
| 6C | Slam: own playing strength -- our hand alone rates to take twelve tricks | (monsterslam('C')) | T=C |  | 73 |
| 7C | Playing strength: no losers with a real solid suit or an agreed fit | ((realsolid('C') or trump('C')) and losers <= 0) | T=C |  | 6 |
| 7C | Grand slam: own playing strength -- our hand alone rates to take thirteen tricks | (monstergrand('C')) | T=C |  | 74 |
| 7N | To Play | (CanBid7NT) |  |  | 70 |

#### `1C-X`

| Call | Means | Requires | Post-condition | Convention | Pri |
|---|---|---|---|---|---|
| P | _(unnamed — the Requires expression is the definition)_ | (hcp <= 5) |  |  |  |
| 1D | Nat | (hcp >= 6 and diamondlongest and not game) |  |  | 62 |
| 1H | Free bid | (bestmajor('H') and H >= 4 and totalpoints >= 6 and not game) \| (bestmajor('H') and H >= 5 and hcp >= 10) | minhcp=6 |  | 54 |
| 1S | Free bid | (bestmajor('S') and S >= 4 and totalpoints >= 6 and not game) \| (bestmajor('S') and S >= 5 and hcp >= 10) | minhcp=6 |  | 54 |
| 1N | _(unnamed — the Requires expression is the definition)_ | (hcp <= 10 and hcp>= 6) |  |  | 12 |
| 2C | Free raise | (C >= 4 and totalpoints >= 7 and totalpoints <= 10) | minhcp=8 |  | 40 |
| 2H | 6+ H, 6-9 hcp | (totalpoints >= 6 and hcp< 10 and H >= 6) | minhcp=5 |  | 95 |
| 2S | 6+ S, 6-9 hcp | (totalpoints >= 6 and hcp< 10 and S >= 6) | minhcp=5 |  | 95 |
| 2N* | TruscottMinor, 10+ hcp, 5+ C | ((suitpoints('C') > 12 and hcp >= 9) and C >= 5 and H <= 4 and S <= 4) | minhcp=10 | TruscottMinor | 120 |
| 3C | Good suit, 7-10 hcp | (hcp >= 7 and hcp<= 10 and C >= 5) |  |  | 90 |
| 3H | 7+ H, 6-9 hcp | (totalpoints >= 6 and hcp< 10 and H >= 7) | minhcp=5 |  | 94 |
| 3S | 7+ S, 6-9 hcp | (totalpoints >= 6 and hcp< 10 and S >= 7) | minhcp=5 |  | 94 |
| 4C | Preemptive | (hcp >= 3 and hcp<= 6 and C >= 7) | minhcp=5 |  | 97 |
| 4H | 8+ H, 6-9 hcp | (totalpoints >= 6 and hcp< 10 and H >= 8) | minhcp=6 |  | 98 |
| 4S | 8+ S, 6-9 hcp | (totalpoints >= 6 and hcp< 10 and S >= 8) | minhcp=6 |  | 98 |
| XX | 10+ hcp | (hcp >= 10 and lengthlongestsuit <= 5 and controls >= 2) \| (hcp >= 10 and lengthlongestsuit <= 5 and controls >= 3) \| (hcp >= 11 and lengthlongestsuit <= 5) \| (hcp >= 12 and D >= 5) |  |  | 42 |

#### `1C-1D`

| Call | Means | Requires | Post-condition | Convention | Pri |
|---|---|---|---|---|---|
| P | _(unnamed — the Requires expression is the definition)_ | (hcp <= 9) \| (penalty) |  |  | 50 |
| 1H | _(unnamed — the Requires expression is the definition)_ | (H == 4 and hcp>= 6) \| (bestmajor('H') and H >= 5 and hcp>= 5) |  |  | 65 |
| 1S | _(unnamed — the Requires expression is the definition)_ | (S == 4 and hcp>= 6) \| (bestmajor('S') and S >= 5 and hcp>= 5) |  |  | 65 |
| 1N | _(unnamed — the Requires expression is the definition)_ | (hcp >= 7 and D >= 3 and hcp<= 10) \| (hcp >= 7 and stopper('D') and hcp<= 10) |  |  | 10 |
| 2C | Nat | (Hcp <= 9 and hcp>= 6 and C >= 4) |  |  | 15 |
| 2D* | Limit+ | (Hcp >= 10 and C >= 4) |  |  | 22 |
| 2H | Nat | (Hcp >= 12 and H >= 6) |  |  | 25 |
| 2S | Nat | (Hcp >= 12 and S >= 6) |  |  | 25 |
| 2N | Nat | (Hcp >= 10 and D >= 4 and hcp<= 12) \| (Hcp >= 10 and stopper('D') and hcp<= 11) |  |  | 30 |
| 3C | Nat | (Hcp <= 8 and clubpoints>= 6 and C >= 5) |  |  | 16 |
| 3H | Nat | (false) |  |  | -10 |
| 3S | Nat | (false) |  |  | -10 |
| 3N | Board: 123443, Hand: KQ8.QT5.AK97.KQT [MS=?] | ((game or NT_trickgame) and not slammish and stoppersOK) |  |  | -4 |
| 3N | Nat | (Hcp >= 12 and D >= 4 and hcp<= 17 and C <= 3) \| (Hcp >= 12 and stopper('D') and hcp<= 17 and (C <= 3 or shape=='4333' or shape == '4432')) |  |  | 40 |
| 4H | Nat | (Hcp <= 10 and hcp >= 6 and H >= 7) |  |  | 85 |
| 4S | Nat | (Hcp <= 10 and hcp >= 6 and S >= 7) |  |  | 85 |
| 4N* | RKC | ((C >= 5) AND (CanAsk_C_RKC)) \| ((C >= 5) AND (clubslam)) | T=C | RKC0314_C | 80 |
| 5N* | GSForce | ((C >= 5) AND (CanAsk_C_GSF)) | T=C | GSForce | 135 |
| 6C | To Play | ((C >= 5) AND (CanBid6_C)) |  |  | 60 |
| 6C | Playing strength: one loser with a real solid suit or an agreed fit | ((C >= 5) AND ((realsolid('C') or trump('C')) and losers == 1)) | T=C |  | 65 |
| 6C | Slam: own playing strength -- our hand alone rates to take twelve tricks | ((C >= 5) AND (monsterslam('C'))) | T=C |  | 133 |
| 7C | Playing strength: no losers with a real solid suit or an agreed fit | ((C >= 5) AND ((realsolid('C') or trump('C')) and losers <= 0)) | T=C |  | 66 |
| 7C | Grand slam: own playing strength -- our hand alone rates to take thirteen tricks | ((C >= 5) AND (monstergrand('C'))) | T=C |  | 134 |
| 7N | To Play | ((C >= 5) AND (CanBid7NT)) |  |  | 130 |
| X | Negative | (Hcp >= 6 and H == 4 and S == 4) |  |  | 54 |

#### `1C-1H`

| Call | Means | Requires | Post-condition | Convention | Pri |
|---|---|---|---|---|---|
| P | _(unnamed — the Requires expression is the definition)_ | (hcp <= 9) \| (hcp <= 6) \| (bestsuit('H') and H >= 5 and hcp >= 10) |  |  | 32 |
| 1S | Nat | (spadepoints >= 6 and S >= 5) | minhcp=5 |  | 80 |
| 1N | _(unnamed — the Requires expression is the definition)_ | (hcp >= 7 and H >= 3 and hcp<= 11) \| (hcp >= 7 and stopper('H') and hcp<= 10) |  |  | 21 |
| 2C | Nat | (Hcp <= 10 and hcp>= 6 and C >= 4) \| (Hcp <= 9 and C_points >= 6 and C >= 4 and hcp >= 5) \| (Hcp <= 9 and hcp>= 6 and C >= 4) |  |  | 15 |
| 2D | Nat | (Hcp >= 9 and D >= 5) \| (Hcp >= 9 and D >= 5 and HasTopHonors('H', 2, 5)) \| (Hcp >= 12 and D >= 4) \| (D >= 5 and hcp >= 12) |  |  | 55 |
| 2H* | Nat | (Hcp >= 18 and C >= 3 and S <= 3) \| (C_points >= 10 and C >= 4 and hcp >= 9 and S <= 3) |  |  | 58 |
| 2N | Nat | (Hcp >= 10 and H >= 4 and hcp<= 12) \| (Hcp >= 10 and stopper('H') and hcp<= 11) |  |  | 30 |
| 3C | Nat | (C >= 5 and hcp >= 4 and C_points <= 9) |  |  | 47 |
| 3D | Nat | (D >= 6 and hcp >= 13 and D_points <= 15) |  |  | 45 |
| 3S | Nat | (Hcp >= 15 and S >= 6) |  |  | 60 |
| 3N | Nat | (Hcp >= 12 and H >= 4 and hcp<= 17 and C <= 3) \| (Hcp >= 12 and stopper('H') and hcp<= 17 and C <= 3 and balish and S <= 3) |  |  | 75 |
| 4C | Nat | (C >= 6 and hcp <= 4 and C_points >= 7) | minhcp=0 |  | 67 |
| 4S | Nat | (hcp >= 6 and hcp<= 10 and S >= 7) |  |  | 100 |
| 4N* | RKC | ((C >= 5) AND (CanAsk_C_RKC)) \| ((C >= 5) AND (C_slam)) | T=C | RKC0314_C | 110 |
| 5N* | GSForce | ((C >= 5) AND (CanAsk_C_GSF)) | T=C | GSForce | 165 |
| 6C | To Play | ((C >= 5) AND (CanBid6_C)) |  |  | 90 |
| 6C | Playing strength: one loser with a real solid suit or an agreed fit | ((C >= 5) AND ((realsolid('C') or trump('C')) and losers == 1)) | T=C |  | 95 |
| 6C | Slam: own playing strength -- our hand alone rates to take twelve tricks | ((C >= 5) AND (monsterslam('C'))) | T=C |  | 163 |
| 7C | Playing strength: no losers with a real solid suit or an agreed fit | ((C >= 5) AND ((realsolid('C') or trump('C')) and losers <= 0)) | T=C |  | 96 |
| 7C | Grand slam: own playing strength -- our hand alone rates to take thirteen tricks | ((C >= 5) AND (monstergrand('C'))) | T=C |  | 164 |
| 7N | To Play | ((C >= 5) AND (CanBid7NT)) |  |  | 160 |
| X | Negative | (S_Points >= 6 and S >= 4 and hcp >= 4) | minhcp=5 |  | 55 |

#### `1C-1S`

| Call | Means | Requires | Post-condition | Convention | Pri |
|---|---|---|---|---|---|
| P | _(unnamed — the Requires expression is the definition)_ | (hcp <= 9) \| (hcp <= 6) \| (bestsuit('S') and S >= 5 and hcp >= 10) |  |  | 32 |
| 1N | _(unnamed — the Requires expression is the definition)_ | (hcp >= 7 and S >= 3 and hcp<= 11) \| (hcp >= 7 and stopper('S') and hcp<= 10) |  |  | 21 |
| 2C | Nat | (Hcp <= 10 and hcp>= 6 and C >= 4) \| (Hcp <= 9 and C_points >= 6 and C >= 4 and hcp >= 5) \| (Hcp <= 9 and hcp>= 6 and C >= 4) |  |  | 15 |
| 2D | Nat | (Hcp >= 9 and D >= 5) \| (Hcp >= 9 and D >= 5 and HasTopHonors('H', 2, 5)) \| (Hcp >= 12 and D >= 4) \| (D >= 5 and hcp >= 12) |  |  | 55 |
| 2H | _(unnamed — the Requires expression is the definition)_ | (H>= 6 and hcp>= 8) \| (H>= 5 and hcp>= 10) | minhcp=10 |  | 80 |
| 2S* | Nat | (Hcp >= 18 and C >= 3 and H <= 3) \| (C_points >= 10 and C >= 4 and hcp >= 9 and H <= 3) |  |  | 58 |
| 2N | Nat | (Hcp >= 10 and S >= 4 and hcp<= 12) \| (Hcp >= 10 and stopper('S') and hcp<= 11) |  |  | 30 |
| 3C | Nat | (C >= 5 and hcp >= 4 and C_points <= 9) |  |  | 47 |
| 3D | Nat | (D >= 6 and hcp >= 13 and D_points <= 15) |  |  | 45 |
| 3H | Nat | (Hcp >= 15 and H >= 6) |  |  | 60 |
| 3N | Nat | (Hcp >= 12 and S >= 4 and hcp<= 17 and C <= 3) \| (Hcp >= 12 and stopper('S') and hcp<= 17 and C <= 3 and balish and H <= 3) |  |  | 75 |
| 4C | Nat | (C >= 6 and hcp <= 4 and C_points >= 7) | minhcp=0 |  | 67 |
| 4H | Nat | (hcp >= 6 and hcp<= 10 and H >= 7) |  |  | 80 |
| 4N* | RKC | ((C >= 5) AND (CanAsk_C_RKC)) \| ((C >= 5) AND (C_slam)) | T=C | RKC0314_C | 110 |
| 5N* | GSForce | ((C >= 5) AND (CanAsk_C_GSF)) | T=C | GSForce | 165 |
| 6C | To Play | ((C >= 5) AND (CanBid6_C)) |  |  | 90 |
| 6C | Playing strength: one loser with a real solid suit or an agreed fit | ((C >= 5) AND ((realsolid('C') or trump('C')) and losers == 1)) | T=C |  | 95 |
| 6C | Slam: own playing strength -- our hand alone rates to take twelve tricks | ((C >= 5) AND (monsterslam('C'))) | T=C |  | 163 |
| 7C | Playing strength: no losers with a real solid suit or an agreed fit | ((C >= 5) AND ((realsolid('C') or trump('C')) and losers <= 0)) | T=C |  | 96 |
| 7C | Grand slam: own playing strength -- our hand alone rates to take thirteen tricks | ((C >= 5) AND (monstergrand('C'))) | T=C |  | 164 |
| 7N | To Play | ((C >= 5) AND (CanBid7NT)) |  |  | 160 |
| X | Negative | (H_Points >= 6 and H >= 4 and hcp >= 4) | minhcp=5 |  | 55 |

#### `1C-2C`

| Call | Means | Requires | Post-condition | Convention | Pri |
|---|---|---|---|---|---|
| P | _(unnamed — the Requires expression is the definition)_ | (hcp <= 11) |  | MichaelsCuebidMinorDefence |  |
| 2D | _(unnamed — the Requires expression is the definition)_ | (D >= 5 and hcp >= 7 and hcp <= 9) |  | MichaelsCuebidMinorDefence | 10 |
| 2H* | Limit raise or better in C | (hcp >= 10 and C >= 4) | F1 | MichaelsCuebidMinorDefence | 40 |
| 2S* | 5+ D, 10+ hcp | (hcp >= 10 and D >= 5) \| (hcp >= 10 and D >= 5 and C <= 4) | F1 | MichaelsCuebidMinorDefence | 45 |
| 2N | _(unnamed — the Requires expression is the definition)_ | (hcp >= 10 and stopper('S') and stopper('H') and hcp<= 12) |  | MichaelsCuebidMinorDefence | 50 |
| 3C | _(unnamed — the Requires expression is the definition)_ | (hcp >= 7 and C >= 4 and hcp<= 9) |  | MichaelsCuebidMinorDefence | 52 |
| 3H* | _(unnamed — the Requires expression is the definition)_ | (hcp >= 9 and C >= 4 and hcp<= 9) |  | MichaelsCuebidMinorDefence | 55 |
| 3S* | _(unnamed — the Requires expression is the definition)_ | (hcp >= 11 and C >= 5) |  | MichaelsCuebidMinorDefence | 56 |
| 3N | _(unnamed — the Requires expression is the definition)_ | (hcp >= 13 and stopper('S') and stopper('H') and hcp<= 20) |  | MichaelsCuebidMinorDefence | 57 |
| 4C | _(unnamed — the Requires expression is the definition)_ | (hcp >= 4 and C >= 6 and hcp<= 9) |  | MichaelsCuebidMinorDefence | 53 |
| 4H* | _(unnamed — the Requires expression is the definition)_ | (C >= 5 and C_points >= 17 and H <= 1) |  | MichaelsCuebidMinorDefence | 58 |
| 4S* | _(unnamed — the Requires expression is the definition)_ | (C >= 5 and C_points >= 17 and S <= 1) |  | MichaelsCuebidMinorDefence | 58 |
| 4N* | RKC | ((C >= 5) AND (CanAsk_C_RKC)) \| ((C >= 5) AND (C_slam)) | T=C | RKC0314_C | 80 |
| 5C | _(unnamed — the Requires expression is the definition)_ | (cansacrifice('C',false)) |  | MichaelsCuebidMinorDefence | 54 |
| 5N* | GSForce | ((C >= 5) AND (CanAsk_C_GSF)) | T=C | GSForce | 135 |
| 6C | To Play | ((C >= 5) AND (CanBid6_C)) |  |  | 60 |
| 6C | Playing strength: one loser with a real solid suit or an agreed fit | ((C >= 5) AND ((realsolid('C') or trump('C')) and losers == 1)) | T=C |  | 65 |
| 6C | Slam: own playing strength -- our hand alone rates to take twelve tricks | ((C >= 5) AND (monsterslam('C'))) | T=C |  | 133 |
| 7C | Playing strength: no losers with a real solid suit or an agreed fit | ((C >= 5) AND ((realsolid('C') or trump('C')) and losers <= 0)) | T=C |  | 66 |
| 7C | Grand slam: own playing strength -- our hand alone rates to take thirteen tricks | ((C >= 5) AND (monstergrand('C'))) | T=C |  | 134 |
| 7N | To Play | ((C >= 5) AND (CanBid7NT)) |  |  | 130 |
| X | _(unnamed — the Requires expression is the definition)_ | (hcp >= 12) | penaltyInterest | MichaelsCuebidMinorDefence | 10 |

#### `1C-2D`

| Call | Means | Requires | Post-condition | Convention | Pri |
|---|---|---|---|---|---|
| P | _(unnamed — the Requires expression is the definition)_ | (hcp <= 11) \| (D >= 4) \| (hcp <= 8) |  |  |  |
| 2H | _(unnamed — the Requires expression is the definition)_ | (bestmajor('H') and hcp >= 9 and H >= 5) |  |  | 60 |
| 2S | _(unnamed — the Requires expression is the definition)_ | (bestmajor('S') and hcp >= 9 and S >= 5) |  |  | 60 |
| 2N | _(unnamed — the Requires expression is the definition)_ | (hcp >= 10 and hcp<= 12 and stopper('D')) |  |  | 45 |
| 3C | _(unnamed — the Requires expression is the definition)_ | (clubpoints >= 9 and hcp<= 11 and C >= 4) |  |  | 10 |
| 3D* | _(unnamed — the Requires expression is the definition)_ | (hcp >= 12 and C >= 4) \| (hcp >= 11 and C >= 5) |  |  | 20 |
| 3N | _(unnamed — the Requires expression is the definition)_ | (hcp >= 12 and stopper('D')) |  |  | 50 |
| X | _(unnamed — the Requires expression is the definition)_ | (hcp >= 10 and S >= 3 and H >= 4) \| (hcp >= 10 and S >= 4 and H >= 3) \| (hcp >= 12 and S >= 3 and H >= 3) \| (hcp >= 8 and S >= 5 and H >= 5) \| (hcp >= 10 and S >= 4 and H >= 4) |  |  | 51 |

#### `1C-2H`

| Call | Means | Requires | Post-condition | Convention | Pri |
|---|---|---|---|---|---|
| P | _(unnamed — the Requires expression is the definition)_ | (hcp <= 11) \| (penalty) \| (hcp <= 9) |  |  |  |
| 2S | _(unnamed — the Requires expression is the definition)_ | (spadepoints >= 11 and S >= 5) |  |  | 70 |
| 2N | _(unnamed — the Requires expression is the definition)_ | (hcp >= 10 and stopper('H') and hcp<= 12) |  |  | 10 |
| 3C | _(unnamed — the Requires expression is the definition)_ | (C_points >= 9 and hcp<= 11 and C >= 5) \| (hcp >= 9 and hcp<= 11 and C >= 4) | minhcp=9 |  | 20 |
| 3D | _(unnamed — the Requires expression is the definition)_ | (hcp >= 10 and D >= 5) \| (hcp >= 11 and D >= 5) | F1 |  | 30 |
| 3H* | Board: T812491, Hand: 9432.K98.AKT5.Q6 [MS=?] | (game and not stopper('H')) |  |  | -5 |
| 3H* | _(unnamed — the Requires expression is the definition)_ | (hcp >= 12 and C >= 3) \| (hcp >= 11 and C >= 4) |  |  | 55 |
| 3S | _(unnamed — the Requires expression is the definition)_ | (hcp >= 11 and S >= 5 and S >= D) | F1 |  | 65 |
| 3N | _(unnamed — the Requires expression is the definition)_ | (hcp >= 13 and stopper('H') and not slammish) |  |  | 67 |
| 4S | _(unnamed — the Requires expression is the definition)_ | (S_game and rebiddable('S')) | T=S |  | 53 |
| 4N* | RKC | ((C >= 5) AND (CanAsk_C_RKC)) \| ((C >= 5) AND (C_slam)) | T=C | RKC0314_C | 90 |
| 5N* | GSForce | ((C >= 5) AND (CanAsk_C_GSF)) | T=C | GSForce | 145 |
| 6C | To Play | ((C >= 5) AND (CanBid6_C)) |  |  | 70 |
| 6C | Playing strength: one loser with a real solid suit or an agreed fit | ((C >= 5) AND ((realsolid('C') or trump('C')) and losers == 1)) | T=C |  | 75 |
| 6C | Slam: own playing strength -- our hand alone rates to take twelve tricks | ((C >= 5) AND (monsterslam('C'))) | T=C |  | 143 |
| 7C | Playing strength: no losers with a real solid suit or an agreed fit | ((C >= 5) AND ((realsolid('C') or trump('C')) and losers <= 0)) | T=C |  | 76 |
| 7C | Grand slam: own playing strength -- our hand alone rates to take thirteen tricks | ((C >= 5) AND (monstergrand('C'))) | T=C |  | 144 |
| 7N | To Play | ((C >= 5) AND (CanBid7NT)) |  |  | 140 |
| X | _(unnamed — the Requires expression is the definition)_ | (hcp >= 13 and S >= 3) \| (totalpoints >= 9 and S >= 4) |  |  | 60 |

#### `1C-2S`

| Call | Means | Requires | Post-condition | Convention | Pri |
|---|---|---|---|---|---|
| P | _(unnamed — the Requires expression is the definition)_ | (hcp <= 11) \| (penalty) \| (hcp <= 9) |  |  |  |
| 2N | _(unnamed — the Requires expression is the definition)_ | (hcp >= 10 and stopper('S') and hcp<= 12) |  |  | 10 |
| 3C | _(unnamed — the Requires expression is the definition)_ | (C_points >= 9 and hcp<= 11 and C >= 5) \| (hcp >= 9 and hcp<= 11 and C >= 4) | minhcp=9 |  | 20 |
| 3D | _(unnamed — the Requires expression is the definition)_ | (hcp >= 10 and D >= 5) \| (hcp >= 11 and D >= 5) | F1 |  | 30 |
| 3H | _(unnamed — the Requires expression is the definition)_ | (hcp >= 9 and H >= 5 and heartlongest) \| (hcp >= 11 and H >= 5 and H >= D) | F1 |  | 65 |
| 3S* | Board: T812491, Hand: 9432.K98.AKT5.Q6 [MS=?] | (game and not stopper('S')) |  |  | -5 |
| 3S* | _(unnamed — the Requires expression is the definition)_ | (hcp >= 12 and C >= 3) \| (hcp >= 11 and C >= 4) |  |  | 55 |
| 3N | _(unnamed — the Requires expression is the definition)_ | (hcp >= 13 and stopper('S') and not slammish) |  |  | 67 |
| 4H | _(unnamed — the Requires expression is the definition)_ | (H_game and rebiddable('H')) | T=H |  | 53 |
| 4N* | RKC | ((C >= 5) AND (CanAsk_C_RKC)) \| ((C >= 5) AND (C_slam)) | T=C | RKC0314_C | 90 |
| 5N* | GSForce | ((C >= 5) AND (CanAsk_C_GSF)) | T=C | GSForce | 145 |
| 6C | To Play | ((C >= 5) AND (CanBid6_C)) |  |  | 70 |
| 6C | Playing strength: one loser with a real solid suit or an agreed fit | ((C >= 5) AND ((realsolid('C') or trump('C')) and losers == 1)) | T=C |  | 75 |
| 6C | Slam: own playing strength -- our hand alone rates to take twelve tricks | ((C >= 5) AND (monsterslam('C'))) | T=C |  | 143 |
| 7C | Playing strength: no losers with a real solid suit or an agreed fit | ((C >= 5) AND ((realsolid('C') or trump('C')) and losers <= 0)) | T=C |  | 76 |
| 7C | Grand slam: own playing strength -- our hand alone rates to take thirteen tricks | ((C >= 5) AND (monstergrand('C'))) | T=C |  | 144 |
| 7N | To Play | ((C >= 5) AND (CanBid7NT)) |  |  | 140 |
| X | _(unnamed — the Requires expression is the definition)_ | (hcp >= 13 and H >= 3) \| (totalpoints >= 9 and H >= 4) |  |  | 60 |

#### `1C-3C`

| Call | Means | Requires | Post-condition | Convention | Pri |
|---|---|---|---|---|---|
| P | _(unnamed — the Requires expression is the definition)_ | (hcp <= 9) |  |  |  |
| 3N | _(unnamed — the Requires expression is the definition)_ | (game and stopper('C')) |  |  | 10 |
| X | _(unnamed — the Requires expression is the definition)_ | (hcp >= 10) |  |  |  |

#### `1C-3D`

| Call | Means | Requires | Post-condition | Convention | Pri |
|---|---|---|---|---|---|
| P | _(unnamed — the Requires expression is the definition)_ | (hcp <= 9) |  |  |  |
| 3H | _(unnamed — the Requires expression is the definition)_ | (bestmajor('H') and H >= 6 and hcp >= 10) \| (bestmajor('H') and H >= 5 and hcp >= 12) | F1 |  | 20 |
| 3S | _(unnamed — the Requires expression is the definition)_ | (bestmajor('S') and S >= 6 and hcp >= 10) \| (bestmajor('S') and S >= 5 and hcp >= 12) | F1 |  | 20 |
| 3N | _(unnamed — the Requires expression is the definition)_ | (hcp >= 12 and stopper('D')) |  |  | 30 |
| 4H | Board: 20260508_MP_007_BFD--2026-05-08 | (H_game and rebiddable('H')) | T=H |  | 54 |
| 4S | Board: 20260508_MP_007_BFD--2026-05-08 | (S_game and rebiddable('S')) | T=S |  | 54 |
| X | _(unnamed — the Requires expression is the definition)_ | (hcp >= 10) |  |  | 10 |

#### `1C-3H`

| Call | Means | Requires | Post-condition | Convention | Pri |
|---|---|---|---|---|---|
| P | _(unnamed — the Requires expression is the definition)_ | (hcp <= 12) \| (H >= 4) \| (hcp <= 8) |  |  |  |
| 3S | _(unnamed — the Requires expression is the definition)_ | (S >= 5 and hcp>= 12 and HasTopHonors('S', 1, 2)) \| (S >= 6 and hcp>= 12) | GF |  | 100 |
| 3N | _(unnamed — the Requires expression is the definition)_ | (stopper('H') and hcp>= 12 and not slammish) \| (doublestopper('H') and hcp>= 12 and not slammish) |  |  | 50 |
| 4C | _(unnamed — the Requires expression is the definition)_ | (hcp >= 10 and C >= 4 and hcp<= 14) |  |  | 12 |
| 4D | _(unnamed — the Requires expression is the definition)_ | (hcp >= 12 and D >= 6) | F1 |  | 16 |
| 4H* | _(unnamed — the Requires expression is the definition)_ | (hcp >= 10 and C >= 4 and C_points >= 14) |  |  | 52 |
| 4S | _(unnamed — the Requires expression is the definition)_ | (hcp >= 10 and S >= 6 and C_points >= 14) |  |  | 56 |
| 4N* | RKC | ((C >= 4) AND (CanAsk_C_RKC)) \| ((C >= 4) AND (C_slam)) | T=C | RKC0314_C | 50 |
| 5C | _(unnamed — the Requires expression is the definition)_ | (hcp >= 15 and C >= 4 and hcp<= 18) |  |  | 27 |
| 5N* | GSForce | ((C >= 4) AND (CanAsk_C_GSF)) | T=C | GSForce | 105 |
| 6C | To Play | ((C >= 4) AND (CanBid6_C)) |  |  | 30 |
| 6C | Playing strength: one loser with a real solid suit or an agreed fit | ((C >= 4) AND ((realsolid('C') or trump('C')) and losers == 1)) | T=C |  | 35 |
| 6C | Slam: own playing strength -- our hand alone rates to take twelve tricks | ((C >= 4) AND (monsterslam('C'))) | T=C |  | 103 |
| 6S | _(unnamed — the Requires expression is the definition)_ | (S >= 8 and losers <= 3) |  |  | 66 |
| 7C | Playing strength: no losers with a real solid suit or an agreed fit | ((C >= 4) AND ((realsolid('C') or trump('C')) and losers <= 0)) | T=C |  | 36 |
| 7C | Grand slam: own playing strength -- our hand alone rates to take thirteen tricks | ((C >= 4) AND (monstergrand('C'))) | T=C |  | 104 |
| 7N | To Play | ((C >= 4) AND (CanBid7NT)) |  |  | 100 |
| X | _(unnamed — the Requires expression is the definition)_ | (hcp >= 12) \| (hcp >= 10 and H <= 2) |  |  | 10 |

#### `1C-3S`

| Call | Means | Requires | Post-condition | Convention | Pri |
|---|---|---|---|---|---|
| P | _(unnamed — the Requires expression is the definition)_ | (hcp <= 12) \| (S >= 4) \| (hcp <= 8) |  |  |  |
| 3N | _(unnamed — the Requires expression is the definition)_ | (stopper('S') and hcp>= 12 and not slammish) \| (doublestopper('S') and hcp>= 12 and not slammish) |  |  | 50 |
| 4C | _(unnamed — the Requires expression is the definition)_ | (hcp >= 10 and C >= 4 and hcp<= 14) |  |  | 12 |
| 4D | _(unnamed — the Requires expression is the definition)_ | (hcp >= 12 and D >= 6) | F1 |  | 16 |
| 4H | _(unnamed — the Requires expression is the definition)_ | (hcp >= 10 and H >= 6 and C_points >= 14) |  |  | 56 |
| 4S* | _(unnamed — the Requires expression is the definition)_ | (hcp >= 10 and C >= 4 and C_points >= 14) |  |  | 52 |
| 4N* | RKC | ((C >= 4) AND (CanAsk_C_RKC)) \| ((C >= 4) AND (C_slam)) | T=C | RKC0314_C | 50 |
| 5C | _(unnamed — the Requires expression is the definition)_ | (hcp >= 15 and C >= 4 and hcp<= 18) |  |  | 27 |
| 5N* | GSForce | ((C >= 4) AND (CanAsk_C_GSF)) | T=C | GSForce | 105 |
| 6C | To Play | ((C >= 4) AND (CanBid6_C)) |  |  | 30 |
| 6C | Playing strength: one loser with a real solid suit or an agreed fit | ((C >= 4) AND ((realsolid('C') or trump('C')) and losers == 1)) | T=C |  | 35 |
| 6C | Slam: own playing strength -- our hand alone rates to take twelve tricks | ((C >= 4) AND (monsterslam('C'))) | T=C |  | 103 |
| 6H | _(unnamed — the Requires expression is the definition)_ | (H >= 8 and losers <= 3) |  |  | 66 |
| 7C | Playing strength: no losers with a real solid suit or an agreed fit | ((C >= 4) AND ((realsolid('C') or trump('C')) and losers <= 0)) | T=C |  | 36 |
| 7C | Grand slam: own playing strength -- our hand alone rates to take thirteen tricks | ((C >= 4) AND (monstergrand('C'))) | T=C |  | 104 |
| 7N | To Play | ((C >= 4) AND (CanBid7NT)) |  |  | 100 |
| X | _(unnamed — the Requires expression is the definition)_ | (hcp >= 12) \| (hcp >= 10 and S <= 2) |  |  | 10 |

#### `1C-4D`

| Call | Means | Requires | Post-condition | Convention | Pri |
|---|---|---|---|---|---|
| P | _(unnamed — the Requires expression is the definition)_ | (true) |  |  |  |
| 4H | Board: 740761, Hand: KQT632.AQT53.J.4 | (fourlevelovercall('H')) |  |  | 53 |
| 4H | Hand: K94.KQJ98532.T8. (GameEval) | (H_game) |  |  | 54 |
| 4H | _(unnamed — the Requires expression is the definition)_ | (strongrebiddable('H') and hcp >= 10) |  |  | 54 |
| 4S | Board: 740761, Hand: KQT632.AQT53.J.4 | (fourlevelovercall('S')) |  |  | 53 |
| 4S | Hand: K94.KQJ98532.T8. (GameEval) | (S_game) |  |  | 54 |
| 4S | _(unnamed — the Requires expression is the definition)_ | (strongrebiddable('S') and hcp >= 10) |  |  | 54 |
| 5C | Hand: AT963.QJ2..A8532 (GameEval) | (C_game) |  |  | 51 |
| X | _(unnamed — the Requires expression is the definition)_ | (hcp >= 13) \| (penalty) |  |  | 90 |

#### `1C-4H`

| Call | Means | Requires | Post-condition | Convention | Pri |
|---|---|---|---|---|---|
| P | _(unnamed — the Requires expression is the definition)_ | (true) | maxhcp = 10 |  |  |
| 4S | Board: T429174, Hand: KQJ975.2..AKQT94 [MS=3a-loser-game(losers=2,ownTricks=11,game=4S,contract=4H)] | (fourlevelovercall('S') or cansacrifice('S')) |  |  | 54 |
| 4N* | RKC | (CanAsk_C_RKC) \| (C_slam) | T=C | RKC0314_C | 50 |
| 5C | Board: 853767, Hand: .QJT653.8.QT7543 | (cansacrifice('C')) |  |  | 9 |
| 5C | _(unnamed — the Requires expression is the definition)_ | (C >= 5 and hcp>= 12) |  |  | 10 |
| 5D | _(unnamed — the Requires expression is the definition)_ | (cansacrifice('D')) |  |  | 43 |
| 5S | Hand: 7.AKJ87532.A7.J4 (GameEval) | (cansacrifice('S')) |  |  | 45 |
| 5N* | GSForce | (CanAsk_C_GSF) | T=C | GSForce | 105 |
| 6C | To Play | (CanBid6_C) |  |  | 30 |
| 6C | Playing strength: one loser with a real solid suit or an agreed fit | ((realsolid('C') or trump('C')) and losers == 1) | T=C |  | 35 |
| 6C | Slam: own playing strength -- our hand alone rates to take twelve tricks | (monsterslam('C')) | T=C |  | 103 |
| 6D | Board: 631652, Hand: .AQJ.2.AKJT98654 [MS=3a-loser-game(losers=2,ownTricks=11,game=5C,contract=4S)] | ((D_slam and StrongRebiddable('D')) or monsterslam('D')) | T=D |  | 72 |
| 7C | Playing strength: no losers with a real solid suit or an agreed fit | ((realsolid('C') or trump('C')) and losers <= 0) | T=C |  | 36 |
| 7C | Grand slam: own playing strength -- our hand alone rates to take thirteen tricks | (monstergrand('C')) | T=C |  | 104 |
| 7N | To Play | (CanBid7NT) |  |  | 100 |
| X | Cooperative, game values | (competitivedouble and H <= 3) |  |  | 5 |

#### `1C-4S`

| Call | Means | Requires | Post-condition | Convention | Pri |
|---|---|---|---|---|---|
| P | _(unnamed — the Requires expression is the definition)_ | (true) | maxhcp = 10 |  |  |
| 4N* | RKC | (CanAsk_C_RKC) \| (C_slam) | T=C | RKC0314_C | 50 |
| 5C | Board: 853767, Hand: .QJT653.8.QT7543 | (cansacrifice('C')) |  |  | 9 |
| 5C | _(unnamed — the Requires expression is the definition)_ | (C >= 5 and hcp>= 12) |  |  | 10 |
| 5D | _(unnamed — the Requires expression is the definition)_ | (cansacrifice('D')) |  |  | 43 |
| 5H | Hand: 7.AKJ87532.A7.J4 (GameEval) | (cansacrifice('H')) |  |  | 45 |
| 5N* | GSForce | (CanAsk_C_GSF) | T=C | GSForce | 105 |
| 6C | To Play | (CanBid6_C) |  |  | 30 |
| 6C | Playing strength: one loser with a real solid suit or an agreed fit | ((realsolid('C') or trump('C')) and losers == 1) | T=C |  | 35 |
| 6C | Slam: own playing strength -- our hand alone rates to take twelve tricks | (monsterslam('C')) | T=C |  | 103 |
| 6D | Board: 631652, Hand: .AQJ.2.AKJT98654 [MS=3a-loser-game(losers=2,ownTricks=11,game=5C,contract=4S)] | ((D_slam and StrongRebiddable('D')) or monsterslam('D')) | T=D |  | 72 |
| 7C | Playing strength: no losers with a real solid suit or an agreed fit | ((realsolid('C') or trump('C')) and losers <= 0) | T=C |  | 36 |
| 7C | Grand slam: own playing strength -- our hand alone rates to take thirteen tricks | (monstergrand('C')) | T=C |  | 104 |
| 7N | To Play | (CanBid7NT) |  |  | 100 |
| X | Cooperative, game values | (competitivedouble and S <= 3) |  |  | 5 |

#### `1C-5D`

| Call | Means | Requires | Post-condition | Convention | Pri |
|---|---|---|---|---|---|
| P | _(unnamed — the Requires expression is the definition)_ | (not game) |  |  |  |
| 5H | Board: 613666, Hand: KQJ762.AQJ943..Q | (cansacrifice('H')) \| (H_compgame) | minhcp=13 |  | 45 |
| 5S | Board: 613666, Hand: KQJ762.AQJ943..Q | (cansacrifice('S')) \| (S_compgame) | minhcp=13 |  | 45 |
| 6C | Hand: AK62.KT95..KT754 (GameEval) | (CanAsk_C_RKC) | T=C |  | 71 |
| X | _(unnamed — the Requires expression is the definition)_ | (penalty) |  |  | 10 |

#### `1C-6D`

| Call | Means | Requires | Post-condition | Convention | Pri |
|---|---|---|---|---|---|
| P | Board: 162038 | (true) |  |  |  |

#### `1C-6H`

| Call | Means | Requires | Post-condition | Convention | Pri |
|---|---|---|---|---|---|
| P | Board: T66527 | (true) |  |  |  |

#### `1C-6S`

_Same rule set as `1C-6H` — the service returns an identical table for this position._

#### `1C-7H`

| Call | Means | Requires | Post-condition | Convention | Pri |
|---|---|---|---|---|---|
| P | Board: 657508 | (true) |  |  |  |

#### `1C-7S`

_Same rule set as `1C-7H` — the service returns an identical table for this position._

#### `1C-1N`

| Call | Means | Requires | Post-condition | Convention | Pri |
|---|---|---|---|---|---|
| P | _(unnamed — the Requires expression is the definition)_ | (true) |  |  |  |
| 2C | _(unnamed — the Requires expression is the definition)_ | (competitive('C')) |  |  | 5 |
| 2D | _(unnamed — the Requires expression is the definition)_ | (twicerebiddable('D') and hcp >= 3 and hcp <= 8) |  |  | 17 |
| 2H | 6+ H | (H >= 6 and hcp<= 8 and losers <= 9 and hcp >= 3) | minhcp=5 |  | 10 |
| 2S | 6+ S | (S >= 6 and hcp<= 8 and losers <= 9 and hcp >= 3) | minhcp=5 |  | 10 |
| 3D | Board: 20260508_MP_006_BFD--2026-05-08 | (competitivevalues and twicerebiddable('D') and not game) |  |  | 22 |
| 4H | Board: 489919, Hand: 5.KQJT762.J9.KQ8 [MS=C-missed-game(cur=3D,target=4H)] | (semisolid('H') and game) |  |  | 53 |
| 4S | Board: 489919, Hand: 5.KQJT762.J9.KQ8 [MS=C-missed-game(cur=3D,target=4H)] | (semisolid('S') and game) |  |  | 53 |
| X | Penalty | (hcp >= 9) \| (penalty) | penaltyInterest |  | 50 |

#### `1C-2N`

| Call | Means | Requires | Post-condition | Convention | Pri |
|---|---|---|---|---|---|
| P | _(unnamed — the Requires expression is the definition)_ | (hcp <= 10) |  | UnusualNTDefence |  |
| 3C | _(unnamed — the Requires expression is the definition)_ | (C >= 4 and C_points >= 7 and C_points <= 11) |  | UnusualNTDefence | 10 |
| 3D* | _(unnamed — the Requires expression is the definition)_ | (C >= 4 and C_points >= 12) |  | UnusualNTDefence | 15 |
| 3H* | 5+ S, 10+ hcp | ( S >= 5 and hcp>= 10) |  | UnusualNTDefence | 30 |
| 3S | _(unnamed — the Requires expression is the definition)_ | (hcp >= 7 and S >= 6 and hcp < 10) |  | UnusualNTDefence | 40 |
| 3N | _(unnamed — the Requires expression is the definition)_ | (hcp >= 13 and stopper('D') and stopper('H') and hcp<= 20) |  | UnusualNTDefence | 50 |
| 4S | _(unnamed — the Requires expression is the definition)_ | (S_game and rebiddable('S')) |  | UnusualNTDefence | 54 |
| 4N* | RKC | (CanAsk_C_RKC) \| (C_slam) | T=C | RKC0314_C | 80 |
| 5N* | GSForce | (CanAsk_C_GSF) | T=C | GSForce | 135 |
| 6C | To Play | (CanBid6_C) |  |  | 60 |
| 6C | Playing strength: one loser with a real solid suit or an agreed fit | ((realsolid('C') or trump('C')) and losers == 1) | T=C |  | 65 |
| 6C | Slam: own playing strength -- our hand alone rates to take twelve tricks | (monsterslam('C')) | T=C |  | 133 |
| 7C | Playing strength: no losers with a real solid suit or an agreed fit | ((realsolid('C') or trump('C')) and losers <= 0) | T=C |  | 66 |
| 7C | Grand slam: own playing strength -- our hand alone rates to take thirteen tricks | (monstergrand('C')) | T=C |  | 134 |
| 7N | To Play | (CanBid7NT) |  |  | 130 |
| X | _(unnamed — the Requires expression is the definition)_ | (hcp >= 11) | penaltyInterest | UnusualNTDefence | 5 |

#### `1D-P`

| Call | Means | Requires | Post-condition | Convention | Pri |
|---|---|---|---|---|---|
| P | hcp < 6 | (hcp < 6) |  |  |  |
| 1H | Nat | (hcp > 4 and ((H == 4) OR (H >=5 and not spadelongest)) and H >= S and not (clublongest and clubs > hearts and hcp>= 12)) \| (hcp > 4 and H >= 4 and (diamondlongest)) |  |  | 90 |
| 1S | Nat | (hcp > 4 and S >= 4 and S>= H and (spadelongest or hcp < 12)) \| (hcp > 4 and S >= 4 and (diamondlongest)) |  |  | 90 |
| 1N | 6-10 hcp | (hcp <= 10 and hcp>= 6 and spades < 4 and hearts < 4 and balanced) |  |  | 10 |
| 1N | Invite | (C >= 5 and hcp<= 10 and hcp>= 6 and H < 4 and S < 4) |  |  | 20 |
| 2C | Nat | (hcp > 11 and C >= 4 and clublongest and not heartlongest and not spadelongest) | GF |  | 80 |
| 2D* | Inverted | (D >= 4 and hcp>= 10 and H < 4 and S < 4 and (diamondlongest or hcp < 12)) |  | InvertedMinor | 100 |
| 2H* | Soloway | (hcp >= 16 and (solid('H') or semisolid('H') or H >= 7) and singlesuited and controls >= 4) \| (H >= 5 and D >= 4 and hcp> 17 and controls >= 4) \| (H >= 6 and balish and hcp>= 17 and controls >= 4) | GF | Soloway | 100 |
| 2S* | Soloway | (hcp >= 16 and (solid('S') or semisolid('S') or S >= 7) and singlesuited and controls >= 4) \| (S >= 5 and D >= 4 and hcp> 17 and controls >= 4) \| (S >= 6 and balish and hcp>= 17 and controls >= 4) | GF | Soloway | 100 |
| 2N | Invitational | ((balanced or semibalanced) and hcp>= 10 and hcp<= 12 and S < 4 and H < 4) |  |  | 65 |
| 3C | Invite | (C >= 6 and hcp>= 9 and hcp<= 11 and H < 4 and S < 4) |  |  | 16 |
| 3D | Preemptive | (D >= 5 and hcp >= 4 and hcp< 10 and H < 4 and S < 4 and diamondlongest) | minhcp=6 |  | 18 |
| 3H* | Splinter | (H <= 1 and totalpoints >= 14 and D >= 5 and S <= 3) | T=D |  | 150 |
| 3S* | Splinter | (S <= 1 and totalpoints >= 14 and D >= 5 and H <= 3) | T=D |  | 150 |
| 3N | Nat | (balanced and hcp> 12 and hcp< 16 and S < 4 and H < 4) |  |  | 60 |
| 4H | Preemptive | (H >= 7 and hcp<= 10 and hcp>= 6) |  |  | 50 |
| 4S | Preemptive | (S >= 7 and hcp<= 10 and hcp>= 6) |  |  | 50 |
| 4N* | RKC | (CanAsk_D_RKC) \| (D_slam) | T=D | RKC0314_D | 20 |
| 5C | Preemptive | (C >= 8 and hcp<= 10 and hcp>= 5) |  |  | 72 |
| 5D | _(unnamed — the Requires expression is the definition)_ | (D >= 7 and hcp<= 10 and hcp>= 5) |  |  | 51 |
| 5N* | GSForce | (CanAsk_D_GSF) | T=D | GSForce | 75 |
| 6D | To Play | (CanBid6_D) |  |  |  |
| 6D | Playing strength: one loser with a real solid suit or an agreed fit | ((realsolid('D') or trump('D')) and losers == 1) | T=D |  | 5 |
| 6D | Slam: own playing strength -- our hand alone rates to take twelve tricks | (monsterslam('D')) | T=D |  | 73 |
| 7D | Playing strength: no losers with a real solid suit or an agreed fit | ((realsolid('D') or trump('D')) and losers <= 0) | T=D |  | 6 |
| 7D | Grand slam: own playing strength -- our hand alone rates to take thirteen tricks | (monstergrand('D')) | T=D |  | 74 |
| 7N | To Play | (CanBid7NT) |  |  | 70 |

#### `1D-X`

| Call | Means | Requires | Post-condition | Convention | Pri |
|---|---|---|---|---|---|
| P | _(unnamed — the Requires expression is the definition)_ | (hcp <= 5) |  |  |  |
| 1H | Free bid | (bestmajor('H') and H >= 4 and totalpoints >= 6 and not game) \| (bestmajor('H') and H >= 5 and hcp >= 10) | minhcp=6 |  | 54 |
| 1S | Free bid | (bestmajor('S') and S >= 4 and totalpoints >= 6 and not game) \| (bestmajor('S') and S >= 5 and hcp >= 10) | minhcp=6 |  | 54 |
| 1N | _(unnamed — the Requires expression is the definition)_ | (hcp <= 10 and hcp>= 6) |  |  | 12 |
| 2C | Nat | (hcp >= 9 and clublongest and C >= 5 and hcp <= 11) |  |  | 10 |
| 2D | Free raise | (D >= 4 and totalpoints >= 7 and totalpoints <= 10) | minhcp=8 |  | 40 |
| 2H | 6+ H, 6-9 hcp | (totalpoints >= 6 and hcp< 10 and H >= 6) | minhcp=5 |  | 95 |
| 2S | 6+ S, 6-9 hcp | (totalpoints >= 6 and hcp< 10 and S >= 6) | minhcp=5 |  | 95 |
| 2N* | TruscottMinor, 10+ hcp, 5+ D | ((suitpoints('D') > 12 and hcp >= 9) and D >= 5 and H <= 4 and S <= 4) | minhcp=10 | TruscottMinor | 120 |
| 3D | Good suit, 7-10 hcp | (hcp >= 7 and hcp<= 10 and D >= 5) |  |  | 90 |
| 3H | 7+ H, 6-9 hcp | (totalpoints >= 6 and hcp< 10 and H >= 7) | minhcp=5 |  | 94 |
| 3S | 7+ S, 6-9 hcp | (totalpoints >= 6 and hcp< 10 and S >= 7) | minhcp=5 |  | 94 |
| 4D | Preemptive | (hcp >= 3 and hcp<= 6 and D >= 7) | minhcp=5 |  | 97 |
| 4H | 8+ H, 6-9 hcp | (totalpoints >= 6 and hcp< 10 and H >= 8) | minhcp=6 |  | 98 |
| 4S | 8+ S, 6-9 hcp | (totalpoints >= 6 and hcp< 10 and S >= 8) | minhcp=6 |  | 98 |
| XX | 10+ hcp | (hcp >= 10 and lengthlongestsuit <= 5 and controls >= 2) \| (hcp >= 10 and lengthlongestsuit <= 5 and controls >= 3) \| (hcp >= 11 and lengthlongestsuit <= 5) \| (hcp >= 12 and C >= 5) |  |  | 42 |

#### `1D-1H`

| Call | Means | Requires | Post-condition | Convention | Pri |
|---|---|---|---|---|---|
| P | _(unnamed — the Requires expression is the definition)_ | (hcp <= 9) \| (hcp <= 6) \| (bestsuit('H') and H >= 5 and hcp >= 10) |  |  | 32 |
| 1S | Nat | (spadepoints >= 6 and S >= 5) | minhcp=5 |  | 80 |
| 1N | _(unnamed — the Requires expression is the definition)_ | (hcp >= 7 and H >= 3 and hcp<= 11) \| (hcp >= 7 and stopper('H') and hcp<= 10) |  |  | 21 |
| 2C | Nat | (Hcp >= 9 and C >= 5) \| (Hcp >= 9 and C >= 5 and HasTopHonors('H', 2, 5)) \| (Hcp >= 12 and C >= 4) \| (C >= 5 and hcp >= 12) |  |  | 55 |
| 2D | Nat | (Hcp <= 10 and hcp>= 6 and D >= 4) \| (Hcp <= 9 and D_points >= 6 and D >= 4 and hcp >= 5) \| (Hcp <= 9 and hcp>= 6 and D >= 4) |  |  | 15 |
| 2H* | Nat | (Hcp >= 18 and D >= 3 and S <= 3) \| (D_points >= 10 and D >= 4 and hcp >= 9 and S <= 3) |  |  | 58 |
| 2N | Nat | (Hcp >= 10 and H >= 4 and hcp<= 12) \| (Hcp >= 10 and stopper('H') and hcp<= 11) |  |  | 30 |
| 3C | Nat | (C >= 6 and hcp >= 13 and C_points <= 15) |  |  | 45 |
| 3D | Nat | (D >= 5 and hcp >= 4 and D_points <= 9) |  |  | 47 |
| 3S | Nat | (Hcp >= 15 and S >= 6) |  |  | 60 |
| 3N | Nat | (Hcp >= 12 and H >= 4 and hcp<= 17 and D <= 3) \| (Hcp >= 12 and stopper('H') and hcp<= 17 and D <= 3 and balish and S <= 3) |  |  | 75 |
| 4D | Nat | (D >= 6 and hcp <= 4 and D_points >= 7) | minhcp=0 |  | 67 |
| 4S | Nat | (hcp >= 6 and hcp<= 10 and S >= 7) |  |  | 100 |
| 4N* | RKC | ((D >= 5) AND (CanAsk_D_RKC)) \| ((D >= 5) AND (D_slam)) | T=D | RKC0314_D | 110 |
| 5N* | GSForce | ((D >= 5) AND (CanAsk_D_GSF)) | T=D | GSForce | 165 |
| 6D | To Play | ((D >= 5) AND (CanBid6_D)) |  |  | 90 |
| 6D | Playing strength: one loser with a real solid suit or an agreed fit | ((D >= 5) AND ((realsolid('D') or trump('D')) and losers == 1)) | T=D |  | 95 |
| 6D | Slam: own playing strength -- our hand alone rates to take twelve tricks | ((D >= 5) AND (monsterslam('D'))) | T=D |  | 163 |
| 7D | Playing strength: no losers with a real solid suit or an agreed fit | ((D >= 5) AND ((realsolid('D') or trump('D')) and losers <= 0)) | T=D |  | 96 |
| 7D | Grand slam: own playing strength -- our hand alone rates to take thirteen tricks | ((D >= 5) AND (monstergrand('D'))) | T=D |  | 164 |
| 7N | To Play | ((D >= 5) AND (CanBid7NT)) |  |  | 160 |
| X | Negative | (S_Points >= 6 and S >= 4 and hcp >= 4) | minhcp=5 |  | 55 |

#### `1D-1S`

| Call | Means | Requires | Post-condition | Convention | Pri |
|---|---|---|---|---|---|
| P | _(unnamed — the Requires expression is the definition)_ | (hcp <= 9) \| (hcp <= 6) \| (bestsuit('S') and S >= 5 and hcp >= 10) |  |  | 32 |
| 1N | _(unnamed — the Requires expression is the definition)_ | (hcp >= 7 and S >= 3 and hcp<= 11) \| (hcp >= 7 and stopper('S') and hcp<= 10) |  |  | 21 |
| 2C | Nat | (Hcp >= 9 and C >= 5) \| (Hcp >= 9 and C >= 5 and HasTopHonors('H', 2, 5)) \| (Hcp >= 12 and C >= 4) \| (C >= 5 and hcp >= 12) |  |  | 55 |
| 2D | Nat | (Hcp <= 10 and hcp>= 6 and D >= 4) \| (Hcp <= 9 and D_points >= 6 and D >= 4 and hcp >= 5) \| (Hcp <= 9 and hcp>= 6 and D >= 4) |  |  | 15 |
| 2H | _(unnamed — the Requires expression is the definition)_ | (H>= 6 and hcp>= 8) \| (H>= 5 and hcp>= 10) | minhcp=10 |  | 80 |
| 2S* | Nat | (Hcp >= 18 and D >= 3 and H <= 3) \| (D_points >= 10 and D >= 4 and hcp >= 9 and H <= 3) |  |  | 58 |
| 2N | Nat | (Hcp >= 10 and S >= 4 and hcp<= 12) \| (Hcp >= 10 and stopper('S') and hcp<= 11) |  |  | 30 |
| 3C | Nat | (C >= 6 and hcp >= 13 and C_points <= 15) |  |  | 45 |
| 3D | Nat | (D >= 5 and hcp >= 4 and D_points <= 9) |  |  | 47 |
| 3H | Nat | (Hcp >= 15 and H >= 6) |  |  | 60 |
| 3N | Nat | (Hcp >= 12 and S >= 4 and hcp<= 17 and D <= 3) \| (Hcp >= 12 and stopper('S') and hcp<= 17 and D <= 3 and balish and H <= 3) |  |  | 75 |
| 4D | Nat | (D >= 6 and hcp <= 4 and D_points >= 7) | minhcp=0 |  | 67 |
| 4H | Nat | (hcp >= 6 and hcp<= 10 and H >= 7) |  |  | 80 |
| 4N* | RKC | ((D >= 5) AND (CanAsk_D_RKC)) \| ((D >= 5) AND (D_slam)) | T=D | RKC0314_D | 110 |
| 5N* | GSForce | ((D >= 5) AND (CanAsk_D_GSF)) | T=D | GSForce | 165 |
| 6D | To Play | ((D >= 5) AND (CanBid6_D)) |  |  | 90 |
| 6D | Playing strength: one loser with a real solid suit or an agreed fit | ((D >= 5) AND ((realsolid('D') or trump('D')) and losers == 1)) | T=D |  | 95 |
| 6D | Slam: own playing strength -- our hand alone rates to take twelve tricks | ((D >= 5) AND (monsterslam('D'))) | T=D |  | 163 |
| 7D | Playing strength: no losers with a real solid suit or an agreed fit | ((D >= 5) AND ((realsolid('D') or trump('D')) and losers <= 0)) | T=D |  | 96 |
| 7D | Grand slam: own playing strength -- our hand alone rates to take thirteen tricks | ((D >= 5) AND (monstergrand('D'))) | T=D |  | 164 |
| 7N | To Play | ((D >= 5) AND (CanBid7NT)) |  |  | 160 |
| X | Negative | (H_Points >= 6 and H >= 4 and hcp >= 4) | minhcp=5 |  | 55 |

#### `1D-2C`

| Call | Means | Requires | Post-condition | Convention | Pri |
|---|---|---|---|---|---|
| P | _(unnamed — the Requires expression is the definition)_ | (hcp <= 11 and C >= 4) \| (C >= 4 and hcp>= 10) \| (hcp <= 10) \| (hcp <= 8 or C >= 5) |  |  |  |
| 2D | _(unnamed — the Requires expression is the definition)_ | (hcp >= 6 and D >= 4) |  |  | 52 |
| 2H | _(unnamed — the Requires expression is the definition)_ | (bestmajor('H') and H >= 5 and hcp >= 9 and S <= 3) \| (bestmajor('H') and H >= 6 and hcp >= 10) \| (bestmajor('H') and H >= 5 and hcp >= 12) | F1 |  | 65 |
| 2S | _(unnamed — the Requires expression is the definition)_ | (bestmajor('S') and S >= 5 and hcp >= 9 and H <= 3) \| (bestmajor('S') and S >= 6 and hcp >= 10) \| (bestmajor('S') and S >= 5 and hcp >= 12) | F1 |  | 65 |
| 2N | _(unnamed — the Requires expression is the definition)_ | (stopper('C') and hcp>= 9 and hcp<= 11) |  |  | 32 |
| 3C* | _(unnamed — the Requires expression is the definition)_ | (D >= 4 and diamondpoints >= 10) |  |  | 55 |
| 3D | _(unnamed — the Requires expression is the definition)_ | (D >= 5 and diamondpoints >= 6 and diamondpoints <= 9) |  |  | 58 |
| 3H | _(unnamed — the Requires expression is the definition)_ | (bestmajor('H') and H >= 6 and hcp >= 15 and singlesuited) | GF |  | 62 |
| 3S | _(unnamed — the Requires expression is the definition)_ | (bestmajor('S') and S >= 6 and hcp >= 15 and singlesuited) | GF |  | 62 |
| 3N | _(unnamed — the Requires expression is the definition)_ | (stopper('C') and hcp>= 12) |  |  | 30 |
| 4H | _(unnamed — the Requires expression is the definition)_ | (H >= 7 and hcp <= 10 and hcp >= 6) |  |  | 64 |
| 4S | _(unnamed — the Requires expression is the definition)_ | (S >= 7 and hcp <= 10 and hcp >= 6) |  |  | 64 |
| 4N* | RKC | (CanAsk_D_RKC) \| (diamondslam) | T=D | RKC0314_D | 80 |
| 5N* | GSForce | (CanAsk_D_GSF) | T=D | GSForce | 135 |
| 6D | To Play | (CanBid6_D) |  |  | 60 |
| 6D | Playing strength: one loser with a real solid suit or an agreed fit | ((realsolid('D') or trump('D')) and losers == 1) | T=D |  | 65 |
| 6D | Slam: own playing strength -- our hand alone rates to take twelve tricks | (monsterslam('D')) | T=D |  | 133 |
| 7D | Playing strength: no losers with a real solid suit or an agreed fit | ((realsolid('D') or trump('D')) and losers <= 0) | T=D |  | 66 |
| 7D | Grand slam: own playing strength -- our hand alone rates to take thirteen tricks | (monstergrand('D')) | T=D |  | 134 |
| 7N | To Play | (CanBid7NT) |  |  | 130 |
| X | _(unnamed — the Requires expression is the definition)_ | (H >= 3 and hcp>= 9 and S >= 3) \| (H >= 4 and hcp>= 9 and S >= 4) |  |  | 44 |

#### `1D-2D`

| Call | Means | Requires | Post-condition | Convention | Pri |
|---|---|---|---|---|---|
| P | _(unnamed — the Requires expression is the definition)_ | (hcp <= 11) |  | MichaelsCuebidMinorDefence |  |
| 2H* | Limit raise or better in D | (hcp >= 10 and D >= 4) | F1 | MichaelsCuebidMinorDefence | 40 |
| 2S* | 5+ C, 10+ hcp | (hcp >= 10 and C >= 5) \| (hcp >= 10 and C >= 5 and D <= 4) | F1 | MichaelsCuebidMinorDefence | 45 |
| 2N | _(unnamed — the Requires expression is the definition)_ | (hcp >= 10 and stopper('S') and stopper('H') and hcp<= 12) |  | MichaelsCuebidMinorDefence | 50 |
| 3C | _(unnamed — the Requires expression is the definition)_ | (hcp >= 7 and C >= 6 and hcp<= 10) |  | MichaelsCuebidMinorDefence | 50 |
| 3D | _(unnamed — the Requires expression is the definition)_ | (hcp >= 7 and D >= 4 and hcp<= 9) |  | MichaelsCuebidMinorDefence | 52 |
| 3H* | _(unnamed — the Requires expression is the definition)_ | (hcp >= 9 and D >= 4 and hcp<= 9) |  | MichaelsCuebidMinorDefence | 55 |
| 3S* | _(unnamed — the Requires expression is the definition)_ | (hcp >= 11 and D >= 5) |  | MichaelsCuebidMinorDefence | 56 |
| 3N | _(unnamed — the Requires expression is the definition)_ | (hcp >= 13 and stopper('S') and stopper('H') and hcp<= 20) |  | MichaelsCuebidMinorDefence | 57 |
| 4D | _(unnamed — the Requires expression is the definition)_ | (hcp >= 4 and D >= 6 and hcp<= 9) |  | MichaelsCuebidMinorDefence | 53 |
| 4H* | _(unnamed — the Requires expression is the definition)_ | (D >= 5 and D_points >= 17 and H <= 1) |  | MichaelsCuebidMinorDefence | 58 |
| 4S* | _(unnamed — the Requires expression is the definition)_ | (D >= 5 and D_points >= 17 and S <= 1) |  | MichaelsCuebidMinorDefence | 58 |
| 4N* | RKC | ((D >= 5) AND (CanAsk_D_RKC)) \| ((D >= 5) AND (D_slam)) | T=D | RKC0314_D | 80 |
| 5D | _(unnamed — the Requires expression is the definition)_ | (cansacrifice('D',false)) |  | MichaelsCuebidMinorDefence | 54 |
| 5N* | GSForce | ((D >= 5) AND (CanAsk_D_GSF)) | T=D | GSForce | 135 |
| 6D | To Play | ((D >= 5) AND (CanBid6_D)) |  |  | 60 |
| 6D | Playing strength: one loser with a real solid suit or an agreed fit | ((D >= 5) AND ((realsolid('D') or trump('D')) and losers == 1)) | T=D |  | 65 |
| 6D | Slam: own playing strength -- our hand alone rates to take twelve tricks | ((D >= 5) AND (monsterslam('D'))) | T=D |  | 133 |
| 7D | Playing strength: no losers with a real solid suit or an agreed fit | ((D >= 5) AND ((realsolid('D') or trump('D')) and losers <= 0)) | T=D |  | 66 |
| 7D | Grand slam: own playing strength -- our hand alone rates to take thirteen tricks | ((D >= 5) AND (monstergrand('D'))) | T=D |  | 134 |
| 7N | To Play | ((D >= 5) AND (CanBid7NT)) |  |  | 130 |
| X | _(unnamed — the Requires expression is the definition)_ | (hcp >= 12) | penaltyInterest | MichaelsCuebidMinorDefence | 10 |

#### `1D-2H`

| Call | Means | Requires | Post-condition | Convention | Pri |
|---|---|---|---|---|---|
| P | _(unnamed — the Requires expression is the definition)_ | (hcp <= 11) \| (penalty) \| (hcp <= 9) |  |  |  |
| 2S | _(unnamed — the Requires expression is the definition)_ | (spadepoints >= 11 and S >= 5) |  |  | 70 |
| 2N | _(unnamed — the Requires expression is the definition)_ | (hcp >= 10 and stopper('H') and hcp<= 12) |  |  | 10 |
| 3C | _(unnamed — the Requires expression is the definition)_ | (hcp >= 10 and C >= 5) \| (hcp >= 11 and C >= 5) \| (C >= 4 and hcp>= 12) | F1 |  | 50 |
| 3D | _(unnamed — the Requires expression is the definition)_ | (D_points >= 9 and hcp<= 11 and D >= 5) \| (hcp >= 9 and hcp<= 11 and D >= 4) | minhcp=9 |  | 20 |
| 3H* | Board: T812491, Hand: 9432.K98.AKT5.Q6 [MS=?] | (game and not stopper('H')) |  |  | -5 |
| 3H* | _(unnamed — the Requires expression is the definition)_ | (hcp >= 12 and D >= 3) \| (hcp >= 11 and D >= 4) |  |  | 55 |
| 3S | _(unnamed — the Requires expression is the definition)_ | (hcp >= 11 and S >= 5 and S >= C) | F1 |  | 65 |
| 3N | _(unnamed — the Requires expression is the definition)_ | (hcp >= 13 and stopper('H') and not slammish) |  |  | 67 |
| 4S | _(unnamed — the Requires expression is the definition)_ | (S_game and rebiddable('S')) | T=S |  | 53 |
| 4N* | RKC | ((D >= 5) AND (CanAsk_D_RKC)) \| ((D >= 5) AND (D_slam)) | T=D | RKC0314_D | 90 |
| 5N* | GSForce | ((D >= 5) AND (CanAsk_D_GSF)) | T=D | GSForce | 145 |
| 6D | To Play | ((D >= 5) AND (CanBid6_D)) |  |  | 70 |
| 6D | Playing strength: one loser with a real solid suit or an agreed fit | ((D >= 5) AND ((realsolid('D') or trump('D')) and losers == 1)) | T=D |  | 75 |
| 6D | Slam: own playing strength -- our hand alone rates to take twelve tricks | ((D >= 5) AND (monsterslam('D'))) | T=D |  | 143 |
| 7D | Playing strength: no losers with a real solid suit or an agreed fit | ((D >= 5) AND ((realsolid('D') or trump('D')) and losers <= 0)) | T=D |  | 76 |
| 7D | Grand slam: own playing strength -- our hand alone rates to take thirteen tricks | ((D >= 5) AND (monstergrand('D'))) | T=D |  | 144 |
| 7N | To Play | ((D >= 5) AND (CanBid7NT)) |  |  | 140 |
| X | _(unnamed — the Requires expression is the definition)_ | (hcp >= 13 and S >= 3) \| (totalpoints >= 9 and S >= 4) |  |  | 60 |

#### `1D-2S`

| Call | Means | Requires | Post-condition | Convention | Pri |
|---|---|---|---|---|---|
| P | _(unnamed — the Requires expression is the definition)_ | (hcp <= 11) \| (penalty) \| (hcp <= 9) |  |  |  |
| 2N | _(unnamed — the Requires expression is the definition)_ | (hcp >= 10 and stopper('S') and hcp<= 12) |  |  | 10 |
| 3C | _(unnamed — the Requires expression is the definition)_ | (hcp >= 10 and C >= 5) \| (hcp >= 11 and C >= 5) \| (C >= 4 and hcp>= 12) | F1 |  | 50 |
| 3D | _(unnamed — the Requires expression is the definition)_ | (D_points >= 9 and hcp<= 11 and D >= 5) \| (hcp >= 9 and hcp<= 11 and D >= 4) | minhcp=9 |  | 20 |
| 3H | _(unnamed — the Requires expression is the definition)_ | (hcp >= 9 and H >= 5 and heartlongest) \| (hcp >= 11 and H >= 5 and H >= C) | F1 |  | 65 |
| 3S* | Board: T812491, Hand: 9432.K98.AKT5.Q6 [MS=?] | (game and not stopper('S')) |  |  | -5 |
| 3S* | _(unnamed — the Requires expression is the definition)_ | (hcp >= 12 and D >= 3) \| (hcp >= 11 and D >= 4) |  |  | 55 |
| 3N | _(unnamed — the Requires expression is the definition)_ | (hcp >= 13 and stopper('S') and not slammish) |  |  | 67 |
| 4H | _(unnamed — the Requires expression is the definition)_ | (H_game and rebiddable('H')) | T=H |  | 53 |
| 4N* | RKC | ((D >= 5) AND (CanAsk_D_RKC)) \| ((D >= 5) AND (D_slam)) | T=D | RKC0314_D | 90 |
| 5N* | GSForce | ((D >= 5) AND (CanAsk_D_GSF)) | T=D | GSForce | 145 |
| 6D | To Play | ((D >= 5) AND (CanBid6_D)) |  |  | 70 |
| 6D | Playing strength: one loser with a real solid suit or an agreed fit | ((D >= 5) AND ((realsolid('D') or trump('D')) and losers == 1)) | T=D |  | 75 |
| 6D | Slam: own playing strength -- our hand alone rates to take twelve tricks | ((D >= 5) AND (monsterslam('D'))) | T=D |  | 143 |
| 7D | Playing strength: no losers with a real solid suit or an agreed fit | ((D >= 5) AND ((realsolid('D') or trump('D')) and losers <= 0)) | T=D |  | 76 |
| 7D | Grand slam: own playing strength -- our hand alone rates to take thirteen tricks | ((D >= 5) AND (monstergrand('D'))) | T=D |  | 144 |
| 7N | To Play | ((D >= 5) AND (CanBid7NT)) |  |  | 140 |
| X | _(unnamed — the Requires expression is the definition)_ | (hcp >= 13 and H >= 3) \| (totalpoints >= 9 and H >= 4) |  |  | 60 |

#### `1D-3C`

| Call | Means | Requires | Post-condition | Convention | Pri |
|---|---|---|---|---|---|
| P | _(unnamed — the Requires expression is the definition)_ | (true) \| (hcp <= 9) |  |  |  |
| 3D | _(unnamed — the Requires expression is the definition)_ | (D >= 5 and D_points >= 9 and hcp <= 10) \| (competitive('D') and hcp >= 7) |  |  | 22 |
| 3H | _(unnamed — the Requires expression is the definition)_ | (bestmajor('H') and H >= 6 and hcp >= 10) \| (bestmajor('H') and H >= 5 and hcp >= 12) | F1 |  | 20 |
| 3S | _(unnamed — the Requires expression is the definition)_ | (bestmajor('S') and S >= 6 and hcp >= 10) \| (bestmajor('S') and S >= 5 and hcp >= 12) | F1 |  | 20 |
| 3N | _(unnamed — the Requires expression is the definition)_ | (hcp >= 12 and stopper('C')) |  |  | 30 |
| 4H | Board: 20260508_MP_007_BFD--2026-05-08 | (H_game and rebiddable('H')) | T=H |  | 54 |
| 4S | Board: 20260508_MP_007_BFD--2026-05-08 | (S_game and rebiddable('S')) | T=S |  | 54 |
| X | _(unnamed — the Requires expression is the definition)_ | (hcp >= 10) |  |  | 10 |

#### `1D-3D`

| Call | Means | Requires | Post-condition | Convention | Pri |
|---|---|---|---|---|---|
| P | _(unnamed — the Requires expression is the definition)_ | (hcp <= 9) |  |  |  |
| 3N | _(unnamed — the Requires expression is the definition)_ | (game and stopper('D')) |  |  | 10 |
| X | _(unnamed — the Requires expression is the definition)_ | (hcp >= 10) |  |  |  |

#### `1D-3H`

| Call | Means | Requires | Post-condition | Convention | Pri |
|---|---|---|---|---|---|
| P | _(unnamed — the Requires expression is the definition)_ | (hcp <= 12) \| (H >= 4) \| (hcp <= 8) |  |  |  |
| 3S | _(unnamed — the Requires expression is the definition)_ | (S >= 5 and hcp>= 12 and HasTopHonors('S', 1, 2)) \| (S >= 6 and hcp>= 12) | GF |  | 100 |
| 3N | _(unnamed — the Requires expression is the definition)_ | (stopper('H') and hcp>= 12 and not slammish) \| (doublestopper('H') and hcp>= 12 and not slammish) |  |  | 50 |
| 4C | _(unnamed — the Requires expression is the definition)_ | (hcp >= 12 and C >= 6) | F1 |  | 16 |
| 4D | _(unnamed — the Requires expression is the definition)_ | (hcp >= 10 and D >= 4 and hcp<= 14) |  |  | 12 |
| 4H* | _(unnamed — the Requires expression is the definition)_ | (hcp >= 10 and D >= 4 and D_points >= 14) |  |  | 52 |
| 4S | _(unnamed — the Requires expression is the definition)_ | (hcp >= 10 and S >= 6 and D_points >= 14) |  |  | 56 |
| 4N* | RKC | ((D >= 4) AND (CanAsk_D_RKC)) \| ((D >= 4) AND (D_slam)) | T=D | RKC0314_D | 50 |
| 5D | _(unnamed — the Requires expression is the definition)_ | (hcp >= 15 and D >= 4 and hcp<= 18) |  |  | 27 |
| 5N* | GSForce | ((D >= 4) AND (CanAsk_D_GSF)) | T=D | GSForce | 105 |
| 6D | To Play | ((D >= 4) AND (CanBid6_D)) |  |  | 30 |
| 6D | Playing strength: one loser with a real solid suit or an agreed fit | ((D >= 4) AND ((realsolid('D') or trump('D')) and losers == 1)) | T=D |  | 35 |
| 6D | Slam: own playing strength -- our hand alone rates to take twelve tricks | ((D >= 4) AND (monsterslam('D'))) | T=D |  | 103 |
| 6S | _(unnamed — the Requires expression is the definition)_ | (S >= 8 and losers <= 3) |  |  | 66 |
| 7D | Playing strength: no losers with a real solid suit or an agreed fit | ((D >= 4) AND ((realsolid('D') or trump('D')) and losers <= 0)) | T=D |  | 36 |
| 7D | Grand slam: own playing strength -- our hand alone rates to take thirteen tricks | ((D >= 4) AND (monstergrand('D'))) | T=D |  | 104 |
| 7N | To Play | ((D >= 4) AND (CanBid7NT)) |  |  | 100 |
| X | _(unnamed — the Requires expression is the definition)_ | (hcp >= 12) \| (hcp >= 10 and H <= 2) |  |  | 10 |

#### `1D-3S`

| Call | Means | Requires | Post-condition | Convention | Pri |
|---|---|---|---|---|---|
| P | _(unnamed — the Requires expression is the definition)_ | (hcp <= 12) \| (S >= 4) \| (hcp <= 8) |  |  |  |
| 3N | _(unnamed — the Requires expression is the definition)_ | (stopper('S') and hcp>= 12 and not slammish) \| (doublestopper('S') and hcp>= 12 and not slammish) |  |  | 50 |
| 4C | _(unnamed — the Requires expression is the definition)_ | (hcp >= 12 and C >= 6) | F1 |  | 16 |
| 4D | _(unnamed — the Requires expression is the definition)_ | (hcp >= 10 and D >= 4 and hcp<= 14) |  |  | 12 |
| 4H | _(unnamed — the Requires expression is the definition)_ | (hcp >= 10 and H >= 6 and D_points >= 14) |  |  | 56 |
| 4S* | _(unnamed — the Requires expression is the definition)_ | (hcp >= 10 and D >= 4 and D_points >= 14) |  |  | 52 |
| 4N* | RKC | ((D >= 4) AND (CanAsk_D_RKC)) \| ((D >= 4) AND (D_slam)) | T=D | RKC0314_D | 50 |
| 5D | _(unnamed — the Requires expression is the definition)_ | (hcp >= 15 and D >= 4 and hcp<= 18) |  |  | 27 |
| 5N* | GSForce | ((D >= 4) AND (CanAsk_D_GSF)) | T=D | GSForce | 105 |
| 6D | To Play | ((D >= 4) AND (CanBid6_D)) |  |  | 30 |
| 6D | Playing strength: one loser with a real solid suit or an agreed fit | ((D >= 4) AND ((realsolid('D') or trump('D')) and losers == 1)) | T=D |  | 35 |
| 6D | Slam: own playing strength -- our hand alone rates to take twelve tricks | ((D >= 4) AND (monsterslam('D'))) | T=D |  | 103 |
| 6H | _(unnamed — the Requires expression is the definition)_ | (H >= 8 and losers <= 3) |  |  | 66 |
| 7D | Playing strength: no losers with a real solid suit or an agreed fit | ((D >= 4) AND ((realsolid('D') or trump('D')) and losers <= 0)) | T=D |  | 36 |
| 7D | Grand slam: own playing strength -- our hand alone rates to take thirteen tricks | ((D >= 4) AND (monstergrand('D'))) | T=D |  | 104 |
| 7N | To Play | ((D >= 4) AND (CanBid7NT)) |  |  | 100 |
| X | _(unnamed — the Requires expression is the definition)_ | (hcp >= 12) \| (hcp >= 10 and S <= 2) |  |  | 10 |

#### `1D-4C`

| Call | Means | Requires | Post-condition | Convention | Pri |
|---|---|---|---|---|---|
| P | _(unnamed — the Requires expression is the definition)_ | (true) |  |  |  |
| 4D | Hand: J3.65.KJT9642.K3 (Partscore) | (competitive('D')) |  |  | 32 |
| 4H | Board: 740761, Hand: KQT632.AQT53.J.4 | (fourlevelovercall('H')) |  |  | 53 |
| 4H | Hand: K94.KQJ98532.T8. (GameEval) | (H_game) |  |  | 54 |
| 4H | _(unnamed — the Requires expression is the definition)_ | (strongrebiddable('H') and hcp >= 10) |  |  | 54 |
| 4S | Board: 740761, Hand: KQT632.AQT53.J.4 | (fourlevelovercall('S')) |  |  | 53 |
| 4S | Hand: K94.KQJ98532.T8. (GameEval) | (S_game) |  |  | 54 |
| 4S | _(unnamed — the Requires expression is the definition)_ | (strongrebiddable('S') and hcp >= 10) |  |  | 54 |
| 5D | Hand: AT963.QJ2..A8532 (GameEval) | (D_game) |  |  | 51 |
| X | _(unnamed — the Requires expression is the definition)_ | (hcp >= 13) \| (penalty) |  |  | 90 |

#### `1D-4H`

| Call | Means | Requires | Post-condition | Convention | Pri |
|---|---|---|---|---|---|
| P | _(unnamed — the Requires expression is the definition)_ | (true) | maxhcp = 10 |  |  |
| 4S | Board: T429174, Hand: KQJ975.2..AKQT94 [MS=3a-loser-game(losers=2,ownTricks=11,game=4S,contract=4H)] | (fourlevelovercall('S') or cansacrifice('S')) |  |  | 54 |
| 4N* | RKC | (CanAsk_D_RKC) \| (D_slam) | T=D | RKC0314_D | 50 |
| 5C | _(unnamed — the Requires expression is the definition)_ | (cansacrifice('C')) |  |  | 43 |
| 5D | Board: 853767, Hand: .QJT653.8.QT7543 | (cansacrifice('D')) |  |  | 9 |
| 5D | _(unnamed — the Requires expression is the definition)_ | (D >= 5 and hcp>= 12) |  |  | 10 |
| 5S | Hand: 7.AKJ87532.A7.J4 (GameEval) | (cansacrifice('S')) |  |  | 45 |
| 5N* | GSForce | (CanAsk_D_GSF) | T=D | GSForce | 105 |
| 6C | Board: 631652, Hand: .AQJ.2.AKJT98654 [MS=3a-loser-game(losers=2,ownTricks=11,game=5C,contract=4S)] | ((C_slam and StrongRebiddable('C')) or monsterslam('C')) | T=C |  | 72 |
| 6D | To Play | (CanBid6_D) |  |  | 30 |
| 6D | Playing strength: one loser with a real solid suit or an agreed fit | ((realsolid('D') or trump('D')) and losers == 1) | T=D |  | 35 |
| 6D | Slam: own playing strength -- our hand alone rates to take twelve tricks | (monsterslam('D')) | T=D |  | 103 |
| 7D | Playing strength: no losers with a real solid suit or an agreed fit | ((realsolid('D') or trump('D')) and losers <= 0) | T=D |  | 36 |
| 7D | Grand slam: own playing strength -- our hand alone rates to take thirteen tricks | (monstergrand('D')) | T=D |  | 104 |
| 7N | To Play | (CanBid7NT) |  |  | 100 |
| X | Cooperative, game values | (competitivedouble and H <= 3) |  |  | 5 |

#### `1D-4S`

| Call | Means | Requires | Post-condition | Convention | Pri |
|---|---|---|---|---|---|
| P | _(unnamed — the Requires expression is the definition)_ | (true) | maxhcp = 10 |  |  |
| 4N* | RKC | (CanAsk_D_RKC) \| (D_slam) | T=D | RKC0314_D | 50 |
| 5C | _(unnamed — the Requires expression is the definition)_ | (cansacrifice('C')) |  |  | 43 |
| 5D | Board: 853767, Hand: .QJT653.8.QT7543 | (cansacrifice('D')) |  |  | 9 |
| 5D | _(unnamed — the Requires expression is the definition)_ | (D >= 5 and hcp>= 12) |  |  | 10 |
| 5H | Hand: 7.AKJ87532.A7.J4 (GameEval) | (cansacrifice('H')) |  |  | 45 |
| 5N* | GSForce | (CanAsk_D_GSF) | T=D | GSForce | 105 |
| 6C | Board: 631652, Hand: .AQJ.2.AKJT98654 [MS=3a-loser-game(losers=2,ownTricks=11,game=5C,contract=4S)] | ((C_slam and StrongRebiddable('C')) or monsterslam('C')) | T=C |  | 72 |
| 6D | To Play | (CanBid6_D) |  |  | 30 |
| 6D | Playing strength: one loser with a real solid suit or an agreed fit | ((realsolid('D') or trump('D')) and losers == 1) | T=D |  | 35 |
| 6D | Slam: own playing strength -- our hand alone rates to take twelve tricks | (monsterslam('D')) | T=D |  | 103 |
| 7D | Playing strength: no losers with a real solid suit or an agreed fit | ((realsolid('D') or trump('D')) and losers <= 0) | T=D |  | 36 |
| 7D | Grand slam: own playing strength -- our hand alone rates to take thirteen tricks | (monstergrand('D')) | T=D |  | 104 |
| 7N | To Play | (CanBid7NT) |  |  | 100 |
| X | Cooperative, game values | (competitivedouble and S <= 3) |  |  | 5 |

#### `1D-5C`

| Call | Means | Requires | Post-condition | Convention | Pri |
|---|---|---|---|---|---|
| P | _(unnamed — the Requires expression is the definition)_ | (true) \| (not game) |  |  |  |
| 5D | Board: 771710, Hand: A7.864.KQ76543.K | (cansacrifice('D')) |  |  | 52 |
| 5H | Board: 613666, Hand: KQJ762.AQJ943..Q | (cansacrifice('H')) \| (H_compgame) | minhcp=13 |  | 45 |
| 5S | Board: 613666, Hand: KQJ762.AQJ943..Q | (cansacrifice('S')) \| (S_compgame) | minhcp=13 |  | 45 |
| 6D | Hand: AK62.KT95..KT754 (GameEval) | (CanAsk_D_RKC) | T=D |  | 71 |
| X | _(unnamed — the Requires expression is the definition)_ | (penalty) |  |  | 10 |

#### `1D-6C`

_Same rule set as `1C-6D` — the service returns an identical table for this position._

#### `1D-6H`

_Same rule set as `1C-6H` — the service returns an identical table for this position._

#### `1D-6S`

_Same rule set as `1C-6H` — the service returns an identical table for this position._

#### `1D-7H`

_Same rule set as `1C-7H` — the service returns an identical table for this position._

#### `1D-7S`

_Same rule set as `1C-7H` — the service returns an identical table for this position._

#### `1D-1N`

| Call | Means | Requires | Post-condition | Convention | Pri |
|---|---|---|---|---|---|
| P | _(unnamed — the Requires expression is the definition)_ | (true) |  |  |  |
| 2C | _(unnamed — the Requires expression is the definition)_ | (twicerebiddable('C') and hcp >= 3 and hcp <= 8) |  |  | 17 |
| 2D | _(unnamed — the Requires expression is the definition)_ | (competitive('D')) |  |  | 5 |
| 2H | 6+ H | (H >= 6 and hcp<= 8 and losers <= 9 and hcp >= 3) | minhcp=5 |  | 10 |
| 2S | 6+ S | (S >= 6 and hcp<= 8 and losers <= 9 and hcp >= 3) | minhcp=5 |  | 10 |
| 3C | Board: 20260508_MP_006_BFD--2026-05-08 | (competitivevalues and twicerebiddable('C') and not game) |  |  | 22 |
| 4H | Board: 489919, Hand: 5.KQJT762.J9.KQ8 [MS=C-missed-game(cur=3D,target=4H)] | (semisolid('H') and game) |  |  | 53 |
| 4S | Board: 489919, Hand: 5.KQJT762.J9.KQ8 [MS=C-missed-game(cur=3D,target=4H)] | (semisolid('S') and game) |  |  | 53 |
| X | Penalty | (hcp >= 9) \| (penalty) | penaltyInterest |  | 50 |

#### `1D-2N`

| Call | Means | Requires | Post-condition | Convention | Pri |
|---|---|---|---|---|---|
| P | _(unnamed — the Requires expression is the definition)_ | (hcp <= 10) |  | UnusualNTDefence |  |
| 3C* | _(unnamed — the Requires expression is the definition)_ | (D >= 4 and D_points >= 12) |  | UnusualNTDefence | 15 |
| 3D | _(unnamed — the Requires expression is the definition)_ | (D >= 4 and D_points >= 7 and D_points <= 11) |  | UnusualNTDefence | 10 |
| 3H* | 5+ S, 10+ hcp | ( S >= 5 and hcp>= 10) |  | UnusualNTDefence | 30 |
| 3S | _(unnamed — the Requires expression is the definition)_ | (hcp >= 7 and S >= 6 and hcp < 10) |  | UnusualNTDefence | 40 |
| 3N | _(unnamed — the Requires expression is the definition)_ | (hcp >= 13 and stopper('C') and stopper('H') and hcp<= 20) |  | UnusualNTDefence | 50 |
| 4S | _(unnamed — the Requires expression is the definition)_ | (S_game and rebiddable('S')) |  | UnusualNTDefence | 54 |
| 4N* | RKC | (CanAsk_D_RKC) \| (D_slam) | T=D | RKC0314_D | 80 |
| 5N* | GSForce | (CanAsk_D_GSF) | T=D | GSForce | 135 |
| 6D | To Play | (CanBid6_D) |  |  | 60 |
| 6D | Playing strength: one loser with a real solid suit or an agreed fit | ((realsolid('D') or trump('D')) and losers == 1) | T=D |  | 65 |
| 6D | Slam: own playing strength -- our hand alone rates to take twelve tricks | (monsterslam('D')) | T=D |  | 133 |
| 7D | Playing strength: no losers with a real solid suit or an agreed fit | ((realsolid('D') or trump('D')) and losers <= 0) | T=D |  | 66 |
| 7D | Grand slam: own playing strength -- our hand alone rates to take thirteen tricks | (monstergrand('D')) | T=D |  | 134 |
| 7N | To Play | (CanBid7NT) |  |  | 130 |
| X | _(unnamed — the Requires expression is the definition)_ | (hcp >= 11) | penaltyInterest | UnusualNTDefence | 5 |

#### `1H-P`

| Call | Means | Requires | Post-condition | Convention | Pri |
|---|---|---|---|---|---|
| P | 5- hcp | (hcp <= 5) |  |  |  |
| 1S | 4+ spades, 5+ hcp | (totalpoints >= 6 and spades >= 4 and (spadelongest or hcp < 12)) | minhcp=5 |  | 60 |
| 1N | Forcing | (hcp <= 12 and H < 4 and hcp>= 6) |  |  | 10 |
| 2C | 4+ clubs, 12+ hcp | (hcp >= 12 and clublongest and clubs > spades and (clubs > diamonds or clubs == 4)) | GF |  | 18 |
| 2D | 4+ diamonds, 12+ hcp | (hcp >= 12 and diamondlongest and diamonds > spades and (diamonds > clubs or diamonds >= 5)) | GF |  | 20 |
| 2H | 3+ H, 6-9 hcp | ((totalpoints >= 6 and hcp< 10 and H >= 3) or (hcp >= 5 and hcp< 10 and H >= 4)) | minhcp=6 |  | 70 |
| 2S* | Soloway | (hcp >= 16 and (solid('S') or S >= 7) and singlesuited and controls >= 4 and H <= 2) \| (S >= 5 and H >= 4 and hcp> 17 and controls >= 4) \| (S >= 6 and balish and hcp>= 17 and controls >= 4 and H <= 2) | GF | Soloway | 100 |
| 2N* | Jacoby, GF, 4+ H | ((H_points >= 12 and hcp >= 12) and H >= 4) | GF, T=H | Jacoby2NT | 120 |
| 3C | Nat, Inv, 10-12 hcp | (hcp >= 10 and hcp< 12 and C >= 6 and S <= 3 and H <= 2) |  |  | 90 |
| 3D | Nat, Inv, 10-12 hcp | (hcp >= 10 and hcp< 12 and D >= 6 and S <= 3 and H <= 2) |  |  | 90 |
| 3H | Nat, Inv, 10-12 | (hcp >= 9 and hcp< 12 and H >= 4 ) |  |  | 100 |
| 3S* | Splinter, 4+ H, 0-1 S | (hcp >= 10 and hcp <= 14 and S <= 1 and H >= 4) | T=H | Splinter | 125 |
| 3N | Balanced, choice of games | (hcp >= 12 and hcp<= 15 and H == 3 and balanced and stoppersOK ) |  |  | 80 |
| 4C* | Splinter, 4+ H, 0-1 C | (hcp >= 10 and hcp <= 14 and C <= 1 and H >= 4) | T=H | Splinter | 125 |
| 4D* | Splinter, 4+ H, 0-1 D | (hcp >= 10 and hcp <= 14 and D <= 1 and H >= 4) | T=H | Splinter | 125 |
| 4H | preemptive | (hcp <= 8 and H >= 5) | minhcp=0,maxhcp=18 |  | 72 |
| 4S | preemptive | (hcp <= 10 and S >= 7 and hcp >= 6) | minhcp=6 |  | 74 |
| 4N* | RKC | ((H >= 3) AND (CanAsk_H_RKC)) \| ((H >= 3) AND (H_slam)) | T=H | RKC0314_H | 20 |
| 5N* | GSForce | ((H >= 3) AND (CanAsk_H_GSF)) | T=H | GSForce | 75 |
| 6H | To Play | ((H >= 3) AND (CanBid6_H)) |  |  |  |
| 6H | Playing strength: one loser with a real solid suit or an agreed fit | ((H >= 3) AND ((realsolid('H') or trump('H')) and losers == 1)) | T=H |  | 5 |
| 6H | Slam: own playing strength -- our hand alone rates to take twelve tricks | ((H >= 3) AND (monsterslam('H'))) | T=H |  | 73 |
| 7H | Playing strength: no losers with a real solid suit or an agreed fit | ((H >= 3) AND ((realsolid('H') or trump('H')) and losers <= 0)) | T=H |  | 6 |
| 7H | Grand slam: own playing strength -- our hand alone rates to take thirteen tricks | ((H >= 3) AND (monstergrand('H'))) | T=H |  | 74 |
| 7N | To Play | ((H >= 3) AND (CanBid7NT)) |  |  | 70 |

#### `1H-X`

| Call | Means | Requires | Post-condition | Convention | Pri |
|---|---|---|---|---|---|
| P | _(unnamed — the Requires expression is the definition)_ | (true) |  |  |  |
| 1S | 4+ S | (S >= 4 and hcp <= 9 and hcp >= 6 and H <= 2) \| (S >= 6 and hcp >= 6) |  |  | 35 |
| 1N | _(unnamed — the Requires expression is the definition)_ | (hcp < 10 and hcp>= 7) |  |  | 10 |
| 2C | Free bid | (bestminor('C') and C >= 5 and totalpoints >= 9 and hcp <= 11 and hcp >= 7) | minhcp=8,maxhcp=11 |  | 28 |
| 2D | Free bid | (bestminor('D') and D >= 5 and totalpoints >= 9 and hcp <= 11 and hcp >= 7) | minhcp=8,maxhcp=11 |  | 28 |
| 2H | 3+ H, 6-9 hcp | (H_points >= 4 and H >= 5) \| ((totalpoints >= 6 and hcp< 10 and H >= 3) or (hcp >= 5 and hcp< 10 and H >= 4)) | minhcp=6,maxhcp=9 |  | 45 |
| 2S | Preemptive | (twicerebiddable('S') and hcp <= 7) | minhcp=4 |  | 40 |
| 2N* | TruscottMajor, 10+ hcp, 4+ H | ((suitpoints('H') > 12 or hcp >= 10) and H >= 3) | minhcp=10 | TruscottMajor | 120 |
| 3C | Good suit, 7-10 hcp | (hcp >= 7 and hcp<= 10 and C >= 6 and rebiddable('C')) |  |  | 40 |
| 3D | Good suit, 7-10 hcp | (hcp >= 7 and hcp<= 10 and D >= 6 and rebiddable('D')) |  |  | 40 |
| 3H | Board: 4333, Hand: J863.Q963.J7.732 | (preemptive('H')) | minhcp=3,maxhcp=7 |  | 49 |
| 3S* | Splinter, 4+ H, 0-1 S | (hcp >= 10 and hcp <= 14 and S <= 1 and H >= 4) | T=H | Splinter | 125 |
| 3N | Nat | (H == 2 and S == 3 and stopper('S') and stopper('C') and stopper('D') and hcp >= 14 and hcp <= 17) |  |  | 70 |
| 4C* | Splinter, 4+ H, 0-1 C | (hcp >= 10 and hcp <= 14 and C <= 1 and H >= 4) | T=H | Splinter | 125 |
| 4D* | Splinter, 4+ H, 0-1 D | (hcp >= 10 and hcp <= 14 and D <= 1 and H >= 4) | T=H | Splinter | 125 |
| 4H | 4+ H, 6-9 hcp | ((H_points >= 7 and hcp< 10 and H >= 5)) | minhcp=5,maxhcp=9 |  | 55 |
| 4S | Board: 869093, Hand: KQ976543.9..8764 | (cansacrifice('S', false)) |  |  | 53 |
| XX | 10+ hcp | (hcp >= 10 and S <= 5) \| (hcp >= 10) |  |  | 25 |

#### `1H-1S`

| Call | Means | Requires | Post-condition | Convention | Pri |
|---|---|---|---|---|---|
| P | Nat | (hcp <= 9) \| (S >= 5) |  |  |  |
| 1N | Nat | (hcp < 10 and S >= 4 and hcp>= 7) \| (hcp < 10 and stopper('S') and hcp>= 7) |  |  | 20 |
| 2C | 6+ C | (totalpoints >= 9 and C >= 6) |  |  | -1 |
| 2C | 4+ clubs, 10+ hcp | (totalpoints >= 10 and clublongest and clubs >= spades) | minhcp=9 |  | 30 |
| 2C | _(unnamed — the Requires expression is the definition)_ | (bestminor('C') and C >= 5 and hcp >= 12) |  |  | 39 |
| 2D | 6+ D | (totalpoints >= 9 and D >= 6) |  |  | -1 |
| 2D | 4+ diamonds, 10+ hcp | (totalpoints >= 10 and diamondlongest and diamonds >= spades) | minhcp=9 |  | 34 |
| 2D | _(unnamed — the Requires expression is the definition)_ | (bestminor('D') and D >= 5 and hcp >= 12) |  |  | 39 |
| 2H | 3+ hearts, 6-9 hcp | (hcp >= 6 and hcp< 10 and hearts >= 3) |  |  | 40 |
| 2S* | Invitational or better | (heartpoints >= 9 and hcp >= 9 and hearts >= 4 ) \| (heartpoints >= 10 and hcp >= 9 and hearts >= 3 ) | T=H |  | 120 |
| 2N | Nat | (hcp >= 10 and hcp<= 12 and stopper('S')) |  |  | 35 |
| 3H | 4+ hearts, preemptive | (heartpoints >= 6 and hcp <= 8 and hearts >= 4) |  |  | 100 |
| 3S* | Splinter | (heartpoints >= 13 and hcp >= 11 and hearts >= 4 and S <= 1) | T=H |  | 125 |
| 3N | Nat | (hcp >= 13 and hcp<= 17 and stopper('S')) |  |  | 85 |
| 4H | 5+ hearts, preemptive | (heartpoints >= 5 and hcp <= 8 and hearts >= 5) |  |  | 110 |
| X | Negative | (hcp > 5 and clubs >= 4 and diamonds >= 4) | minhcp=8 |  | 38 |

#### `1H-2C`

| Call | Means | Requires | Post-condition | Convention | Pri |
|---|---|---|---|---|---|
| P | _(unnamed — the Requires expression is the definition)_ | (true) \| (C >= 4 and hcp>= 10) \| (hcp <= 8 or C >= 5) \| (penalty) |  |  | 20 |
| 2D | _(unnamed — the Requires expression is the definition)_ | (D >= 4 and totalpoints >= 10 and hcp >= 8) \| (D >= 5 and totalpoints >= 10 and hcp >= 8) \| (D >= 5 and hcp>= 9) |  |  | 30 |
| 2H | _(unnamed — the Requires expression is the definition)_ | (H >= 3 and hcp<= 9 and H_points >= 6) |  |  | 80 |
| 2S | _(unnamed — the Requires expression is the definition)_ | (S >= 5 and hcp>= 9) \| (S >= 5 and totalpoints >= 10 and hcp >= 8) |  |  | 60 |
| 2N | _(unnamed — the Requires expression is the definition)_ | (stopper('C') and hcp>= 9 and hcp<= 11) |  |  | 32 |
| 3C* | _(unnamed — the Requires expression is the definition)_ | (H >= 3 and hcp>= 10) | T=H |  | 70 |
| 3D | _(unnamed — the Requires expression is the definition)_ | (D >= 6 and hcp>= 15) | GF |  | 20 |
| 3H | _(unnamed — the Requires expression is the definition)_ | (H >= 4 and hcp<= 7 and H_points >= 5) |  |  | 54 |
| 3N | _(unnamed — the Requires expression is the definition)_ | (doublestopper('C') and hcp>= 10 and not slammish and balish) \| (stopper('C') and hcp>= 12 and not slammish and balish) |  |  | 34 |
| 4C* | Splinter, 4+ H, 0-1 C | (hcp >= 10 and hcp <= 14 and C <= 1 and H >= 4) | T=H | Splinter | 125 |
| 4H | _(unnamed — the Requires expression is the definition)_ | (H >= 5 and hcp<= 9 and H_points >= 4) |  |  | 82 |
| 4N* | RKC | ((H >= 3) AND (CanAsk_H_RKC)) \| ((H >= 3) AND (H_slam)) | T=H | RKC0314_H | 110 |
| 5N* | GSForce | ((H >= 3) AND (CanAsk_H_GSF)) | T=H | GSForce | 165 |
| 6H | To Play | ((H >= 3) AND (CanBid6_H)) |  |  | 90 |
| 6H | Playing strength: one loser with a real solid suit or an agreed fit | ((H >= 3) AND ((realsolid('H') or trump('H')) and losers == 1)) | T=H |  | 95 |
| 6H | Slam: own playing strength -- our hand alone rates to take twelve tricks | ((H >= 3) AND (monsterslam('H'))) | T=H |  | 163 |
| 7H | Playing strength: no losers with a real solid suit or an agreed fit | ((H >= 3) AND ((realsolid('H') or trump('H')) and losers <= 0)) | T=H |  | 96 |
| 7H | Grand slam: own playing strength -- our hand alone rates to take thirteen tricks | ((H >= 3) AND (monstergrand('H'))) | T=H |  | 164 |
| 7N | To Play | ((H >= 3) AND (CanBid7NT)) |  |  | 160 |
| X | _(unnamed — the Requires expression is the definition)_ | (S >= 4 and hcp>= 8) \| (S >= 5 and hcp>= 7) \| (S >= 6 and hcp>= 6) |  |  | 46 |

#### `1H-2D`

| Call | Means | Requires | Post-condition | Convention | Pri |
|---|---|---|---|---|---|
| P | _(unnamed — the Requires expression is the definition)_ | (true) \| (D >= 4 and hcp>= 10) \| (hcp <= 8 or D >= 5) \| (penalty) |  |  | 20 |
| 2H | _(unnamed — the Requires expression is the definition)_ | (H >= 3 and hcp<= 9 and H_points >= 6) |  |  | 80 |
| 2S | _(unnamed — the Requires expression is the definition)_ | (S >= 5 and totalpoints >= 10 and hcp >= 8) |  |  | 60 |
| 2N | _(unnamed — the Requires expression is the definition)_ | (stopper('D') and hcp>= 9 and hcp<= 11) |  |  | 32 |
| 3C | _(unnamed — the Requires expression is the definition)_ | (C >= 5 and hcp>= 10) | F1 |  | 20 |
| 3D* | _(unnamed — the Requires expression is the definition)_ | (H >= 3 and hcp>= 10) | T=H |  | 70 |
| 3H | _(unnamed — the Requires expression is the definition)_ | (H >= 4 and hcp<= 7 and H_points >= 5) |  |  | 54 |
| 3N | _(unnamed — the Requires expression is the definition)_ | (doublestopper('D') and hcp>= 10 and not slammish and balish) \| (stopper('D') and hcp>= 12 and not slammish and balish) |  |  | 34 |
| 4D* | Splinter, 4+ H, 0-1 D | (hcp >= 10 and hcp <= 14 and D <= 1 and H >= 4) | T=H | Splinter | 125 |
| 4H | _(unnamed — the Requires expression is the definition)_ | (H >= 5 and hcp<= 9 and H_points >= 4) |  |  | 82 |
| 4N* | RKC | ((H >= 3) AND (CanAsk_H_RKC)) \| ((H >= 3) AND (H_slam)) | T=H | RKC0314_H | 110 |
| 5N* | GSForce | ((H >= 3) AND (CanAsk_H_GSF)) | T=H | GSForce | 165 |
| 6H | To Play | ((H >= 3) AND (CanBid6_H)) |  |  | 90 |
| 6H | Playing strength: one loser with a real solid suit or an agreed fit | ((H >= 3) AND ((realsolid('H') or trump('H')) and losers == 1)) | T=H |  | 95 |
| 6H | Slam: own playing strength -- our hand alone rates to take twelve tricks | ((H >= 3) AND (monsterslam('H'))) | T=H |  | 163 |
| 7H | Playing strength: no losers with a real solid suit or an agreed fit | ((H >= 3) AND ((realsolid('H') or trump('H')) and losers <= 0)) | T=H |  | 96 |
| 7H | Grand slam: own playing strength -- our hand alone rates to take thirteen tricks | ((H >= 3) AND (monstergrand('H'))) | T=H |  | 164 |
| 7N | To Play | ((H >= 3) AND (CanBid7NT)) |  |  | 160 |
| X | _(unnamed — the Requires expression is the definition)_ | (S >= 4 and hcp>= 8) \| (S >= 5 and hcp>= 7) \| (S >= 6 and hcp>= 6) |  |  | 46 |

#### `1H-2H`

| Call | Means | Requires | Post-condition | Convention | Pri |
|---|---|---|---|---|---|
| P | Could be penalty | (S >= 4) |  | MichaelsCuebidMajorDefence | -1 |
| P | _(unnamed — the Requires expression is the definition)_ | ((hcp <= 11 and H <= 3) or totalpoints <= 7) |  | MichaelsCuebidMajorDefence |  |
| 2S* | _(unnamed — the Requires expression is the definition)_ | (H >= 4 and heartpoints >= 14) \| (H >= 3 and hcp >= 10) |  | MichaelsCuebidMajorDefence | 60 |
| 3C | _(unnamed — the Requires expression is the definition)_ | (C >= 5 and hcp<= 10 and hcp>= 7) |  | MichaelsCuebidMajorDefence | 30 |
| 3D | _(unnamed — the Requires expression is the definition)_ | (D >= 5 and hcp<= 10 and hcp>= 7) |  | MichaelsCuebidMajorDefence | 30 |
| 3H | _(unnamed — the Requires expression is the definition)_ | (H >= 3 and totalpoints <= 10 and totalpoints >= 8) |  | MichaelsCuebidMajorDefence | 35 |
| 3S* | _(unnamed — the Requires expression is the definition)_ | (H >= 3 and totalpoints >= 10 and hcp >= 9) |  | MichaelsCuebidMajorDefence | 38 |
| 3N | Nat | (hcp >= 12 and stopper('S')) |  | MichaelsCuebidMajorDefence | 20 |
| 4H | _(unnamed — the Requires expression is the definition)_ | (H >= 3 and totalpoints >= 10 and H_points <= 14) \| (H >= 5 and totalpoints >= 4 and H_points <= 14) \| (H >= 4 and totalpoints >= 10 and H_points <= 14) |  | MichaelsCuebidMajorDefence | 50 |
| 5C | _(unnamed — the Requires expression is the definition)_ | (C >= 8 and losers <= 5) |  | MichaelsCuebidMajorDefence | 55 |
| 5D | _(unnamed — the Requires expression is the definition)_ | (D >= 8 and losers <= 5) |  | MichaelsCuebidMajorDefence | 55 |
| X | _(unnamed — the Requires expression is the definition)_ | (hcp >= 12) |  | MichaelsCuebidMajorDefence | 10 |

#### `1H-2S`

| Call | Means | Requires | Post-condition | Convention | Pri |
|---|---|---|---|---|---|
| P | _(unnamed — the Requires expression is the definition)_ | (hcp <= 11) \| (hcp <= 9) \| (S >= 5 and hcp>= 8) |  |  | 20 |
| 2N | _(unnamed — the Requires expression is the definition)_ | (hcp >= 10 and hcp<= 12 and stopper('S')) |  |  | 10 |
| 3C | _(unnamed — the Requires expression is the definition)_ | (bestminor('C') and C >= 5 and hcp>= 11) \| (bestminor('C') and C >= 6 and hcp>= 12) | F1 |  | 39 |
| 3D | _(unnamed — the Requires expression is the definition)_ | (bestminor('D') and D >= 5 and hcp>= 11) \| (bestminor('D') and D >= 6 and hcp>= 12) | F1 |  | 40 |
| 3H | Board: 615952, Hand: 8642.A53.KJ.AT32 | (competitive('H')) |  |  | 23 |
| 3H | _(unnamed — the Requires expression is the definition)_ | (H >= 3 and heartpoints >= 7 and hcp<= 10) | minhcp=7,maxhcp=10 |  | 24 |
| 3S* | _(unnamed — the Requires expression is the definition)_ | (H >= 3 and heartgame and hcp >= 10) | GF, T=H |  | 44 |
| 3N | _(unnamed — the Requires expression is the definition)_ | (hcp >= 12 and stopper('S')) |  |  | 22 |
| 4H | _(unnamed — the Requires expression is the definition)_ | (H >= 3 and heartgame and hcp < 10) |  |  | 42 |
| X | _(unnamed — the Requires expression is the definition)_ | (hcp >= 12 and C >= 3 and D >= 3) \| (hcp >= 9 and C >= 4 and D >= 4) |  |  | 38 |

#### `1H-3C`

| Call | Means | Requires | Post-condition | Convention | Pri |
|---|---|---|---|---|---|
| P | _(unnamed — the Requires expression is the definition)_ | (hcp <= 11) |  |  |  |
| 3D | _(unnamed — the Requires expression is the definition)_ | (totalpoints >= 12 and D >= 5) |  |  | 20 |
| 3H | _(unnamed — the Requires expression is the definition)_ | (hcp >= 7 and hcp<= 10 and H >= 3) |  |  | 41 |
| 3S | _(unnamed — the Requires expression is the definition)_ | (hcp >= 12 and S >= 5) | F1 |  | 35 |
| 3N | _(unnamed — the Requires expression is the definition)_ | (hcp >= 12 and stopper('C') and hcp <= 18) |  |  | 20 |
| 4C* | _(unnamed — the Requires expression is the definition)_ | (hcp >= 13 and H >= 2) \| (hcp >= 13 and H >= 3) |  |  | 56 |
| 4H | _(unnamed — the Requires expression is the definition)_ | (hcp >= 11 and hcp<= 12 and H >= 2) \| (H >= 4 and H_points >= 10 and hcp <10) \| (hcp >= 11 and hcp<= 12 and H >= 3) \| (hcp >= 9 and hcp<= 12 and H >= 4) |  |  | 43 |
| 4S | _(unnamed — the Requires expression is the definition)_ | (hcp >= 10 and S >= 7) |  |  | 15 |
| 4N* | RKC | (CanAsk_H_RKC) \| (H_slam) | T=H | RKC0314_H | 80 |
| 5N* | GSForce | (CanAsk_H_GSF) | T=H | GSForce | 135 |
| 6H | To Play | (CanBid6_H) |  |  | 60 |
| 6H | Playing strength: one loser with a real solid suit or an agreed fit | ((realsolid('H') or trump('H')) and losers == 1) | T=H |  | 65 |
| 6H | Slam: own playing strength -- our hand alone rates to take twelve tricks | (monsterslam('H')) | T=H |  | 133 |
| 7H | Playing strength: no losers with a real solid suit or an agreed fit | ((realsolid('H') or trump('H')) and losers <= 0) | T=H |  | 66 |
| 7H | Grand slam: own playing strength -- our hand alone rates to take thirteen tricks | (monstergrand('H')) | T=H |  | 134 |
| 7N | To Play | (CanBid7NT) |  |  | 130 |
| X | _(unnamed — the Requires expression is the definition)_ | (S >= 4 and hcp>= 10) |  |  | 10 |

#### `1H-3D`

| Call | Means | Requires | Post-condition | Convention | Pri |
|---|---|---|---|---|---|
| P | _(unnamed — the Requires expression is the definition)_ | (hcp <= 11) |  |  |  |
| 3H | _(unnamed — the Requires expression is the definition)_ | (hcp >= 7 and hcp<= 10 and H >= 3) |  |  | 41 |
| 3S | _(unnamed — the Requires expression is the definition)_ | (hcp >= 12 and S >= 5) | F1 |  | 35 |
| 3N | _(unnamed — the Requires expression is the definition)_ | (hcp >= 12 and stopper('D') and hcp <= 18) |  |  | 20 |
| 4C | _(unnamed — the Requires expression is the definition)_ | (C >= 6 and hcp>= 10) | F1 |  | 5 |
| 4D* | _(unnamed — the Requires expression is the definition)_ | (hcp >= 13 and H >= 2) \| (hcp >= 13 and H >= 3) |  |  | 56 |
| 4H | _(unnamed — the Requires expression is the definition)_ | (hcp >= 11 and hcp<= 12 and H >= 2) \| (H >= 4 and H_points >= 10 and hcp <10) \| (hcp >= 11 and hcp<= 12 and H >= 3) \| (hcp >= 9 and hcp<= 12 and H >= 4) |  |  | 43 |
| 4S | _(unnamed — the Requires expression is the definition)_ | (hcp >= 10 and S >= 7) |  |  | 15 |
| 4N* | RKC | (CanAsk_H_RKC) \| (H_slam) | T=H | RKC0314_H | 80 |
| 5N* | GSForce | (CanAsk_H_GSF) | T=H | GSForce | 135 |
| 6H | To Play | (CanBid6_H) |  |  | 60 |
| 6H | Playing strength: one loser with a real solid suit or an agreed fit | ((realsolid('H') or trump('H')) and losers == 1) | T=H |  | 65 |
| 6H | Slam: own playing strength -- our hand alone rates to take twelve tricks | (monsterslam('H')) | T=H |  | 133 |
| 7H | Playing strength: no losers with a real solid suit or an agreed fit | ((realsolid('H') or trump('H')) and losers <= 0) | T=H |  | 66 |
| 7H | Grand slam: own playing strength -- our hand alone rates to take thirteen tricks | (monstergrand('H')) | T=H |  | 134 |
| 7N | To Play | (CanBid7NT) |  |  | 130 |
| X | _(unnamed — the Requires expression is the definition)_ | (S >= 4 and hcp>= 10) |  |  | 10 |

#### `1H-3S`

| Call | Means | Requires | Post-condition | Convention | Pri |
|---|---|---|---|---|---|
| P | _(unnamed — the Requires expression is the definition)_ | (true) |  |  |  |
| 3N | _(unnamed — the Requires expression is the definition)_ | (game and stopper('S')) \| (stopper('S') and game) |  |  | 15 |
| 4C | _(unnamed — the Requires expression is the definition)_ | (hcp >= 10 and bestminor('C') and C >= 6) \| (C >= 6 and hcp >= 12) | F1 |  | 40 |
| 4D | _(unnamed — the Requires expression is the definition)_ | (hcp >= 10 and bestminor('D') and D >= 6) \| (D >= 6 and hcp >= 12) | F1 |  | 40 |
| 4H | _(unnamed — the Requires expression is the definition)_ | (H >= 3 and heartpoints >= 10 and not slammish) \| (preemptive('H')) \| (H >= 3 and H_points >= 10) |  |  | 50 |
| 4S* | _(unnamed — the Requires expression is the definition)_ | (H >= 3 and slammish) |  |  | 30 |
| 4N* | RKC | ((H >= 3) AND (CanAsk_H_RKC)) \| ((H >= 3) AND (heartslam)) | T=H | RKC0314_H | 80 |
| 5C | _(unnamed — the Requires expression is the definition)_ | (C >= 7 and hcp <= 12 and hcp >= 6 and H <= 2) |  |  | 30 |
| 5D | _(unnamed — the Requires expression is the definition)_ | (D >= 7 and hcp <= 12 and hcp >= 6 and H <= 2) |  |  | 30 |
| 5N* | GSForce | ((H >= 3) AND (CanAsk_H_GSF)) | T=H | GSForce | 135 |
| 6H | To Play | ((H >= 3) AND (CanBid6_H)) |  |  | 60 |
| 6H | Playing strength: one loser with a real solid suit or an agreed fit | ((H >= 3) AND ((realsolid('H') or trump('H')) and losers == 1)) | T=H |  | 65 |
| 6H | Slam: own playing strength -- our hand alone rates to take twelve tricks | ((H >= 3) AND (monsterslam('H'))) | T=H |  | 133 |
| 7H | Playing strength: no losers with a real solid suit or an agreed fit | ((H >= 3) AND ((realsolid('H') or trump('H')) and losers <= 0)) | T=H |  | 66 |
| 7H | Grand slam: own playing strength -- our hand alone rates to take thirteen tricks | ((H >= 3) AND (monstergrand('H'))) | T=H |  | 134 |
| 7N | To Play | ((H >= 3) AND (CanBid7NT)) |  |  | 130 |
| X | _(unnamed — the Requires expression is the definition)_ | (H >= 2 and hcp >= 10) \| (game) |  |  | 5 |
| X | T/O | (hcp >= 13 and C >= 3 and D >= 3) \| (hcp >= 10 and C >= 4 and D >= 4) |  |  | 10 |

#### `1H-4C`

| Call | Means | Requires | Post-condition | Convention | Pri |
|---|---|---|---|---|---|
| P | _(unnamed — the Requires expression is the definition)_ | (hcp <= 11) |  |  |  |
| 4H | _(unnamed — the Requires expression is the definition)_ | (hcp >= 11 and hcp<= 12 and H >= 2) \| (hcp >= 9 and hcp<= 16 and H >= 3) |  |  | 25 |
| 4S | _(unnamed — the Requires expression is the definition)_ | (hcp >= 12 and S >= 6) |  |  | 30 |
| 4N* | RKC | (CanAsk_H_RKC) \| (H_slam) | T=H | RKC0314_H | 80 |
| 5D | Board: 2 | (((D_compgame and (Fit('D') or D >= 6)) or (twicerebiddable('D') and losers <= 2)) or cansacrifice('D', false)) |  |  | 52 |
| 5N* | GSForce | (CanAsk_H_GSF) | T=H | GSForce | 135 |
| 6H | To Play | (CanBid6_H) |  |  | 60 |
| 6H | Playing strength: one loser with a real solid suit or an agreed fit | ((realsolid('H') or trump('H')) and losers == 1) | T=H |  | 65 |
| 6H | Slam: own playing strength -- our hand alone rates to take twelve tricks | (monsterslam('H')) | T=H |  | 133 |
| 7H | Playing strength: no losers with a real solid suit or an agreed fit | ((realsolid('H') or trump('H')) and losers <= 0) | T=H |  | 66 |
| 7H | Grand slam: own playing strength -- our hand alone rates to take thirteen tricks | (monstergrand('H')) | T=H |  | 134 |
| 7N | To Play | (CanBid7NT) |  |  | 130 |
| X | _(unnamed — the Requires expression is the definition)_ | (hcp >= 10) |  |  | 10 |

#### `1H-4D`

| Call | Means | Requires | Post-condition | Convention | Pri |
|---|---|---|---|---|---|
| P | _(unnamed — the Requires expression is the definition)_ | (hcp <= 11) |  |  |  |
| 4H | _(unnamed — the Requires expression is the definition)_ | (hcp >= 11 and hcp<= 12 and H >= 2) \| (hcp >= 9 and hcp<= 16 and H >= 3) |  |  | 25 |
| 4S | _(unnamed — the Requires expression is the definition)_ | (hcp >= 12 and S >= 6) |  |  | 30 |
| 4N* | RKC | (CanAsk_H_RKC) \| (H_slam) | T=H | RKC0314_H | 80 |
| 5C | Board: 2 | (((C_compgame and (Fit('C') or C >= 6)) or (twicerebiddable('C') and losers <= 2)) or cansacrifice('C', false)) |  |  | 52 |
| 5N* | GSForce | (CanAsk_H_GSF) | T=H | GSForce | 135 |
| 6H | To Play | (CanBid6_H) |  |  | 60 |
| 6H | Playing strength: one loser with a real solid suit or an agreed fit | ((realsolid('H') or trump('H')) and losers == 1) | T=H |  | 65 |
| 6H | Slam: own playing strength -- our hand alone rates to take twelve tricks | (monsterslam('H')) | T=H |  | 133 |
| 7H | Playing strength: no losers with a real solid suit or an agreed fit | ((realsolid('H') or trump('H')) and losers <= 0) | T=H |  | 66 |
| 7H | Grand slam: own playing strength -- our hand alone rates to take thirteen tricks | (monstergrand('H')) | T=H |  | 134 |
| 7N | To Play | (CanBid7NT) |  |  | 130 |
| X | _(unnamed — the Requires expression is the definition)_ | (hcp >= 10) |  |  | 10 |

#### `1H-4S`

| Call | Means | Requires | Post-condition | Convention | Pri |
|---|---|---|---|---|---|
| P | _(unnamed — the Requires expression is the definition)_ | (not game) |  |  |  |
| 4N* | RKC | (CanAsk_H_RKC) \| (heartslam) | T=H | RKC0314_H | 80 |
| 5C | _(unnamed — the Requires expression is the definition)_ | (game and C >= 7) |  |  | 20 |
| 5D | _(unnamed — the Requires expression is the definition)_ | (game and D >= 7) |  |  | 20 |
| 5H | _(unnamed — the Requires expression is the definition)_ | (heartgame and H >= 4) |  |  | 30 |
| 5N* | GSForce | (CanAsk_H_GSF) | T=H | GSForce | 135 |
| 6H | To Play | (CanBid6_H) |  |  | 60 |
| 6H | Playing strength: one loser with a real solid suit or an agreed fit | ((realsolid('H') or trump('H')) and losers == 1) | T=H |  | 65 |
| 6H | Slam: own playing strength -- our hand alone rates to take twelve tricks | (monsterslam('H')) | T=H |  | 133 |
| 7H | Playing strength: no losers with a real solid suit or an agreed fit | ((realsolid('H') or trump('H')) and losers <= 0) | T=H |  | 66 |
| 7H | Grand slam: own playing strength -- our hand alone rates to take thirteen tricks | (monstergrand('H')) | T=H |  | 134 |
| 7N | To Play | (CanBid7NT) |  |  | 130 |
| X | _(unnamed — the Requires expression is the definition)_ | (game) |  |  | 10 |

#### `1H-5C`

| Call | Means | Requires | Post-condition | Convention | Pri |
|---|---|---|---|---|---|
| P | _(unnamed — the Requires expression is the definition)_ | (true) |  |  |  |
| 5H | Hand: AQ9732.KJ8652..5 (GameEval) | (cansacrifice('H')) |  |  | 44 |
| 5S | Board: 959424, Hand: AKQ953.A6.QJ75.7 | (S_compgame) |  |  | 43 |
| X | _(unnamed — the Requires expression is the definition)_ | (penalty) |  |  | 10 |

#### `1H-5D`

| Call | Means | Requires | Post-condition | Convention | Pri |
|---|---|---|---|---|---|
| P | _(unnamed — the Requires expression is the definition)_ | (not slammish) \| (true) |  |  |  |
| 5H | _(unnamed — the Requires expression is the definition)_ | (H >= 3 and hcp >= 12) |  |  |  |
| 5H | Hand: AQ9732.KJ8652..5 (GameEval) | (cansacrifice('H')) |  |  | 44 |
| 5S | Board: 959424, Hand: AKQ953.A6.QJ75.7 | (S_compgame) |  |  | 43 |
| X | _(unnamed — the Requires expression is the definition)_ | (hcp >= 13) \| (penalty) |  |  | 10 |

#### `1H-6C`

| Call | Means | Requires | Post-condition | Convention | Pri |
|---|---|---|---|---|---|
| P | Board: 463710 | (true) |  |  |  |

#### `1H-6D`

_Same rule set as `1H-6C` — the service returns an identical table for this position._

#### `1H-6S`

| Call | Means | Requires | Post-condition | Convention | Pri |
|---|---|---|---|---|---|
| P | Board: T4915 | (true) |  |  |  |

#### `1H-1N`

| Call | Means | Requires | Post-condition | Convention | Pri |
|---|---|---|---|---|---|
| P | _(unnamed — the Requires expression is the definition)_ | (hcp <= 8) |  |  | 10 |
| 2C | 6+ C, 5-8 hcp | (hcp <= 8 and hcp>= 5 and C >= 6) |  |  | 20 |
| 2D | 6+ D, 5-8 hcp | (hcp <= 8 and hcp>= 5 and D >= 6) |  |  | 20 |
| 2H | 3+ H, 6-10 hcp | (hcp <= 10 and H_points>= 5 and H >= 3) | minhcp=6 |  | 40 |
| 2S | 6+ S, 5-8 hcp | (hcp <= 8 and hcp>= 5 and S >= 6) |  |  | 30 |
| 3H | 3+ H, 6-10 hcp | (hcp <= 10 and hcp>= 5 and H >= 4) \| (hcp <= 10 and hcp>= 5 and H >= 5) | minhcp=6 |  | 60 |
| 3S | Board: 20260509_MP_006_WFI-Tournament | (loserlevel >= 3 and twicerebiddable('S') and not game) |  |  | 23 |
| 4H | _(unnamed — the Requires expression is the definition)_ | (H_points >= 11 and H >= 4) |  |  | 65 |
| 4S | _(unnamed — the Requires expression is the definition)_ | (S_points >= 11 and H >= 7) |  |  | 63 |
| X | Penalty | (ispenalty and hcp >= 9 and H <= 3) |  |  | 5 |

#### `1H-2N`

| Call | Means | Requires | Post-condition | Convention | Pri |
|---|---|---|---|---|---|
| P | _(unnamed — the Requires expression is the definition)_ | (hcp <= 8) |  | UnusualNTDefence |  |
| 3C* | Limit+ in H | (H >= 3 and hcp>= 10) |  | UnusualNTDefence | 60 |
| 3D* | 5+ S, 10+ hcp | (S >= 5 and hcp>= 10) |  | UnusualNTDefence | 50 |
| 3H | Competitive | (H >= 3 and hcp<= 9 and hcp>= 7) |  | UnusualNTDefence | 30 |
| 3S | _(unnamed — the Requires expression is the definition)_ | (S >= 6 and hcp<= 9 and hcp>= 7) |  | UnusualNTDefence | 25 |
| 3N | _(unnamed — the Requires expression is the definition)_ | (stopper('C') and stopper ('D') and hcp>= 12 and H <= 2) |  | UnusualNTDefence | 40 |
| 4H | _(unnamed — the Requires expression is the definition)_ | (H >= 4 and hcp<= 9 and H_points >= 6) |  | UnusualNTDefence | 33 |
| 4S | _(unnamed — the Requires expression is the definition)_ | (S >= 7 and hcp<= 9 and hcp>= 7) |  | UnusualNTDefence | 35 |
| 4N* | RKC | (CanAsk_H_RKC) \| (H_slam) | T=H | RKC0314_H | 80 |
| 5N* | GSForce | (CanAsk_H_GSF) | T=H | GSForce | 135 |
| 6H | To Play | (CanBid6_H) |  |  | 60 |
| 6H | Playing strength: one loser with a real solid suit or an agreed fit | ((realsolid('H') or trump('H')) and losers == 1) | T=H |  | 65 |
| 6H | Slam: own playing strength -- our hand alone rates to take twelve tricks | (monsterslam('H')) | T=H |  | 133 |
| 7H | Playing strength: no losers with a real solid suit or an agreed fit | ((realsolid('H') or trump('H')) and losers <= 0) | T=H |  | 66 |
| 7H | Grand slam: own playing strength -- our hand alone rates to take thirteen tricks | (monstergrand('H')) | T=H |  | 134 |
| 7N | To Play | (CanBid7NT) |  |  | 130 |
| X | _(unnamed — the Requires expression is the definition)_ | (hcp >= 9) |  | UnusualNTDefence | 10 |

#### `1S-P`

| Call | Means | Requires | Post-condition | Convention | Pri |
|---|---|---|---|---|---|
| P | 5- hcp | (hcp <= 5) |  |  |  |
| 1N | Forcing | (hcp <= 12 and S < 4 and hcp>= 6) |  |  | 10 |
| 2C | Nat GF | (hcp >= 12 and clublongest and ((clubs > diamonds and clubs > hearts) or clubs== 4)) \| (hcp >= 12 and explicitshape == '3=4=3=3') | GF |  | 20 |
| 2D | Nat GF | (hcp >= 12 and diamondlongest and (diamonds > hearts or diamonds== 4)and (diamonds > clubs or diamonds >= 5)) | GF |  | 22 |
| 2H | 5+ hearts, 12+ hcp | ((heartpoints >= 14 and hcp >= 10) and heartlongest and hearts >= 5) | GF |  | 90 |
| 2S | 3+ S, 6-9 hcp | ((totalpoints >= 6 and hcp< 10 and S >= 3) or (hcp >= 5 and hcp< 10 and S >= 4)) | minhcp=6 |  | 70 |
| 2N* | Jacoby, GF, 4+ S | ((S_points >= 12 and hcp >= 12) and S >= 4) | GF, T=S | Jacoby2NT | 120 |
| 3C | Nat, Inv, 10-12 hcp | (hcp >= 10 and hcp< 12 and C >= 6 and H <= 3 and S <= 2) |  |  | 90 |
| 3D | Nat, Inv, 10-12 hcp | (hcp >= 10 and hcp< 12 and D >= 6 and H <= 3 and S <= 2) |  |  | 90 |
| 3H | Nat, Inv, 10-12 hcp | (hcp >= 10 and hcp< 12 and hearts >= 6 ) |  |  | 100 |
| 3S | Nat, Inv, 10-12 | (hcp >= 9 and hcp< 12 and S >= 4 ) |  |  | 100 |
| 3N | Balanced, choice of games | (hcp >= 12 and hcp<= 15 and S == 3 and balanced and stoppersOK ) |  |  | 80 |
| 4C* | Splinter, 4+ S, 0-1 C | (hcp >= 10 and hcp <= 14 and C <= 1 and S >= 4) | T=S | Splinter | 125 |
| 4D* | Splinter, 4+ S, 0-1 D | (hcp >= 10 and hcp <= 14 and D <= 1 and S >= 4) | T=S | Splinter | 125 |
| 4H* | Splinter, 4+ S, 0-1 H | (hcp >= 10 and hcp <= 14 and H <= 1 and S >= 4) | T=S | Splinter | 125 |
| 4S | preemptive | (hcp <= 8 and S >= 5) | minhcp=0,maxhcp=18 |  | 72 |
| 4N* | RKC | ((S >= 3) AND (CanAsk_S_RKC)) \| ((S >= 3) AND (S_slam)) | T=S | RKC0314_S | 20 |
| 5N* | GSForce | ((S >= 3) AND (CanAsk_S_GSF)) | T=S | GSForce | 75 |
| 6S | To Play | ((S >= 3) AND (CanBid6_S)) |  |  |  |
| 6S | Playing strength: one loser with a real solid suit or an agreed fit | ((S >= 3) AND ((realsolid('S') or trump('S')) and losers == 1)) | T=S |  | 5 |
| 6S | Slam: own playing strength -- our hand alone rates to take twelve tricks | ((S >= 3) AND (monsterslam('S'))) | T=S |  | 73 |
| 7S | Playing strength: no losers with a real solid suit or an agreed fit | ((S >= 3) AND ((realsolid('S') or trump('S')) and losers <= 0)) | T=S |  | 6 |
| 7S | Grand slam: own playing strength -- our hand alone rates to take thirteen tricks | ((S >= 3) AND (monstergrand('S'))) | T=S |  | 74 |
| 7N | To Play | ((S >= 3) AND (CanBid7NT)) |  |  | 70 |

#### `1S-X`

| Call | Means | Requires | Post-condition | Convention | Pri |
|---|---|---|---|---|---|
| P | _(unnamed — the Requires expression is the definition)_ | (true) |  |  |  |
| 1N | _(unnamed — the Requires expression is the definition)_ | (hcp < 10 and hcp>= 7) |  |  | 10 |
| 2C | Free bid | (bestminor('C') and C >= 5 and totalpoints >= 9 and hcp <= 11 and hcp >= 7) | minhcp=8,maxhcp=11 |  | 28 |
| 2D | Free bid | (bestminor('D') and D >= 5 and totalpoints >= 9 and hcp <= 11 and hcp >= 7) | minhcp=8,maxhcp=11 |  | 28 |
| 2H | Free bid | (H >= 5 and totalpoints >= 9 and totalpoints <= 11) |  |  | 40 |
| 2S | 3+ S, 6-9 hcp | (S_points >= 4 and S >= 5) \| ((totalpoints >= 6 and hcp< 10 and S >= 3) or (hcp >= 5 and hcp< 10 and S >= 4)) | minhcp=6,maxhcp=9 |  | 45 |
| 2N* | TruscottMajor, 10+ hcp, 4+ H | ((suitpoints('S') > 12 or hcp >= 10) and S >= 3) | minhcp=10 | TruscottMajor | 120 |
| 3C | Good suit, 7-10 hcp | (hcp >= 7 and hcp<= 10 and C >= 6 and rebiddable('C')) |  |  | 40 |
| 3D | Good suit, 7-10 hcp | (hcp >= 7 and hcp<= 10 and D >= 6 and rebiddable('D')) |  |  | 40 |
| 3S | Board: 4333, Hand: J863.Q963.J7.732 | (preemptive('S')) | minhcp=3,maxhcp=7 |  | 49 |
| 3N | Nat | (S == 2 and H == 3 and stopper('H') and stopper('C') and stopper('D') and hcp >= 14 and hcp <= 17) |  |  | 70 |
| 4C* | Splinter, 4+ S, 0-1 C | (hcp >= 10 and hcp <= 14 and C <= 1 and S >= 4) | T=S | Splinter | 125 |
| 4D* | Splinter, 4+ S, 0-1 D | (hcp >= 10 and hcp <= 14 and D <= 1 and S >= 4) | T=S | Splinter | 125 |
| 4H* | Splinter, 4+ S, 0-1 H | (hcp >= 10 and hcp <= 14 and H <= 1 and S >= 4) | T=S | Splinter | 125 |
| 4S | 4+ S, 6-9 hcp | ((S_points >= 7 and hcp< 10 and S >= 5)) | minhcp=5,maxhcp=9 |  | 55 |
| XX | 10+ hcp | (hcp >= 10) |  |  | 25 |

#### `1S-2C`

| Call | Means | Requires | Post-condition | Convention | Pri |
|---|---|---|---|---|---|
| P | _(unnamed — the Requires expression is the definition)_ | (true) \| (C >= 4 and hcp>= 10) \| (hcp <= 8 or C >= 5) \| (penalty) |  |  | 20 |
| 2D | _(unnamed — the Requires expression is the definition)_ | (D >= 4 and totalpoints >= 10 and hcp >= 8) \| (D >= 5 and totalpoints >= 10 and hcp >= 8) \| (D >= 5 and hcp>= 9) |  |  | 30 |
| 2H | _(unnamed — the Requires expression is the definition)_ | (H >= 5 and hcp>= 9) \| (H >= 5 and totalpoints >= 10 and hcp >= 8) |  |  | 60 |
| 2S | _(unnamed — the Requires expression is the definition)_ | (S >= 3 and hcp<= 9 and S_points >= 6) |  |  | 80 |
| 2N | _(unnamed — the Requires expression is the definition)_ | (stopper('C') and hcp>= 9 and hcp<= 11) |  |  | 32 |
| 3C* | _(unnamed — the Requires expression is the definition)_ | (S >= 3 and hcp>= 10) | T=S |  | 70 |
| 3D | _(unnamed — the Requires expression is the definition)_ | (D >= 6 and hcp>= 15) | GF |  | 20 |
| 3S | _(unnamed — the Requires expression is the definition)_ | (S >= 4 and hcp<= 7 and S_points >= 5) |  |  | 54 |
| 3N | _(unnamed — the Requires expression is the definition)_ | (doublestopper('C') and hcp>= 10 and not slammish and balish) \| (stopper('C') and hcp>= 12 and not slammish and balish) |  |  | 34 |
| 4C* | Splinter, 4+ S, 0-1 C | (hcp >= 10 and hcp <= 14 and C <= 1 and S >= 4) | T=S | Splinter | 125 |
| 4S | _(unnamed — the Requires expression is the definition)_ | (S >= 5 and hcp<= 9 and S_points >= 4) |  |  | 82 |
| 4N* | RKC | ((S >= 3) AND (CanAsk_S_RKC)) \| ((S >= 3) AND (S_slam)) | T=S | RKC0314_S | 110 |
| 5N* | GSForce | ((S >= 3) AND (CanAsk_S_GSF)) | T=S | GSForce | 165 |
| 6S | To Play | ((S >= 3) AND (CanBid6_S)) |  |  | 90 |
| 6S | Playing strength: one loser with a real solid suit or an agreed fit | ((S >= 3) AND ((realsolid('S') or trump('S')) and losers == 1)) | T=S |  | 95 |
| 6S | Slam: own playing strength -- our hand alone rates to take twelve tricks | ((S >= 3) AND (monsterslam('S'))) | T=S |  | 163 |
| 7S | Playing strength: no losers with a real solid suit or an agreed fit | ((S >= 3) AND ((realsolid('S') or trump('S')) and losers <= 0)) | T=S |  | 96 |
| 7S | Grand slam: own playing strength -- our hand alone rates to take thirteen tricks | ((S >= 3) AND (monstergrand('S'))) | T=S |  | 164 |
| 7N | To Play | ((S >= 3) AND (CanBid7NT)) |  |  | 160 |
| X | _(unnamed — the Requires expression is the definition)_ | (H >= 4 and hcp>= 8) \| (H >= 5 and hcp>= 7) \| (H >= 6 and hcp>= 6) |  |  | 46 |

#### `1S-2D`

| Call | Means | Requires | Post-condition | Convention | Pri |
|---|---|---|---|---|---|
| P | _(unnamed — the Requires expression is the definition)_ | (true) \| (D >= 4 and hcp>= 10) \| (hcp <= 8 or D >= 5) \| (penalty) |  |  | 20 |
| 2H | _(unnamed — the Requires expression is the definition)_ | (H >= 5 and totalpoints >= 10 and hcp >= 8) |  |  | 60 |
| 2S | _(unnamed — the Requires expression is the definition)_ | (S >= 3 and hcp<= 9 and S_points >= 6) |  |  | 80 |
| 2N | _(unnamed — the Requires expression is the definition)_ | (stopper('D') and hcp>= 9 and hcp<= 11) |  |  | 32 |
| 3C | _(unnamed — the Requires expression is the definition)_ | (C >= 5 and hcp>= 10) | F1 |  | 20 |
| 3D* | _(unnamed — the Requires expression is the definition)_ | (S >= 3 and hcp>= 10) | T=S |  | 70 |
| 3S | _(unnamed — the Requires expression is the definition)_ | (S >= 4 and hcp<= 7 and S_points >= 5) |  |  | 54 |
| 3N | _(unnamed — the Requires expression is the definition)_ | (doublestopper('D') and hcp>= 10 and not slammish and balish) \| (stopper('D') and hcp>= 12 and not slammish and balish) |  |  | 34 |
| 4D* | Splinter, 4+ S, 0-1 D | (hcp >= 10 and hcp <= 14 and D <= 1 and S >= 4) | T=S | Splinter | 125 |
| 4S | _(unnamed — the Requires expression is the definition)_ | (S >= 5 and hcp<= 9 and S_points >= 4) |  |  | 82 |
| 4N* | RKC | ((S >= 3) AND (CanAsk_S_RKC)) \| ((S >= 3) AND (S_slam)) | T=S | RKC0314_S | 110 |
| 5N* | GSForce | ((S >= 3) AND (CanAsk_S_GSF)) | T=S | GSForce | 165 |
| 6S | To Play | ((S >= 3) AND (CanBid6_S)) |  |  | 90 |
| 6S | Playing strength: one loser with a real solid suit or an agreed fit | ((S >= 3) AND ((realsolid('S') or trump('S')) and losers == 1)) | T=S |  | 95 |
| 6S | Slam: own playing strength -- our hand alone rates to take twelve tricks | ((S >= 3) AND (monsterslam('S'))) | T=S |  | 163 |
| 7S | Playing strength: no losers with a real solid suit or an agreed fit | ((S >= 3) AND ((realsolid('S') or trump('S')) and losers <= 0)) | T=S |  | 96 |
| 7S | Grand slam: own playing strength -- our hand alone rates to take thirteen tricks | ((S >= 3) AND (monstergrand('S'))) | T=S |  | 164 |
| 7N | To Play | ((S >= 3) AND (CanBid7NT)) |  |  | 160 |
| X | _(unnamed — the Requires expression is the definition)_ | (H >= 4 and hcp>= 8) \| (H >= 5 and hcp>= 7) \| (H >= 6 and hcp>= 6) |  |  | 46 |

#### `1S-2H`

| Call | Means | Requires | Post-condition | Convention | Pri |
|---|---|---|---|---|---|
| P | _(unnamed — the Requires expression is the definition)_ | (hcp <= 11) \| (hcp <= 8) |  |  |  |
| 2S | _(unnamed — the Requires expression is the definition)_ | (S >= 3 and hcp<= 9 and spadepoints >= 6) |  |  | 33 |
| 2N | _(unnamed — the Requires expression is the definition)_ | (stopper('H') and hcp>= 10 and hcp<= 11) |  |  | 30 |
| 3C | _(unnamed — the Requires expression is the definition)_ | (C >= 5 and hcp>= 10) \| (C >= 5 and totalpoints >= 13) | F1 \| minhcp=10 |  | 29 |
| 3D | _(unnamed — the Requires expression is the definition)_ | (D >= 5 and hcp>= 10) \| (D >= 5 and totalpoints >= 13) | F1 \| minhcp=10 |  | 29 |
| 3H* | _(unnamed — the Requires expression is the definition)_ | (S >= 3 and (hcp>= 10 or spadepoints >= 12)) | minhcp=10,GF,T=S |  | 32 |
| 3S | _(unnamed — the Requires expression is the definition)_ | (S >= 4 and hcp<= 8 and hcp >= 4) |  |  | 34 |
| 3N | _(unnamed — the Requires expression is the definition)_ | (H >= 4 and hcp>= 12 and not slammish) \| (stopper('H') and hcp>= 12 and not slammish) |  |  | 36 |
| 4H* | Splinter, 4+ S, 0-1 H | (slammish and H <= 1 and S >= 4) | T=S | Splinter | 125 |
| 4S | _(unnamed — the Requires expression is the definition)_ | (S >= 5 and hcp<= 8) |  |  | 40 |
| X | _(unnamed — the Requires expression is the definition)_ | (C >= 4 and D >= 4 and hcp>= 9) |  |  | 28 |

#### `1S-2S`

| Call | Means | Requires | Post-condition | Convention | Pri |
|---|---|---|---|---|---|
| P | Could be penalty | (H >= 4) |  | MichaelsCuebidMajorDefence | -1 |
| P | _(unnamed — the Requires expression is the definition)_ | ((hcp <= 11 and S <= 3) or totalpoints <= 7) |  | MichaelsCuebidMajorDefence |  |
| 3C | _(unnamed — the Requires expression is the definition)_ | (C >= 5 and hcp<= 10 and hcp>= 7) |  | MichaelsCuebidMajorDefence | 30 |
| 3D | _(unnamed — the Requires expression is the definition)_ | (D >= 5 and hcp<= 10 and hcp>= 7) |  | MichaelsCuebidMajorDefence | 30 |
| 3H* | _(unnamed — the Requires expression is the definition)_ | (S >= 3 and spadepoints >= 10 and hcp >= 8) \| (S >= 3 and totalpoints >= 10 and hcp >= 9) |  | MichaelsCuebidMajorDefence | 38 |
| 3S | _(unnamed — the Requires expression is the definition)_ | (S >= 3 and totalpoints <= 10 and totalpoints >= 8) |  | MichaelsCuebidMajorDefence | 35 |
| 3N | Nat | (hcp >= 12 and stopper('H')) |  | MichaelsCuebidMajorDefence | 20 |
| 4S | _(unnamed — the Requires expression is the definition)_ | (S >= 3 and totalpoints >= 10 and S_points <= 14) \| (S >= 5 and totalpoints >= 4 and S_points <= 14) \| (S >= 4 and totalpoints >= 10 and S_points <= 14) |  | MichaelsCuebidMajorDefence | 50 |
| 5C | _(unnamed — the Requires expression is the definition)_ | (C >= 8 and losers <= 5) |  | MichaelsCuebidMajorDefence | 55 |
| 5D | _(unnamed — the Requires expression is the definition)_ | (D >= 8 and losers <= 5) |  | MichaelsCuebidMajorDefence | 55 |
| X | _(unnamed — the Requires expression is the definition)_ | (hcp >= 12) |  | MichaelsCuebidMajorDefence | 10 |

#### `1S-3C`

| Call | Means | Requires | Post-condition | Convention | Pri |
|---|---|---|---|---|---|
| P | _(unnamed — the Requires expression is the definition)_ | (hcp <= 11) |  |  |  |
| 3D | _(unnamed — the Requires expression is the definition)_ | (totalpoints >= 12 and D >= 5) |  |  | 20 |
| 3H | _(unnamed — the Requires expression is the definition)_ | (hcp >= 12 and H >= 5) | F1 |  | 35 |
| 3S | _(unnamed — the Requires expression is the definition)_ | (hcp >= 7 and hcp<= 10 and S >= 3) |  |  | 41 |
| 3N | _(unnamed — the Requires expression is the definition)_ | (hcp >= 12 and stopper('C') and hcp <= 18) |  |  | 20 |
| 4C* | _(unnamed — the Requires expression is the definition)_ | (hcp >= 13 and S >= 2) \| (hcp >= 13 and S >= 3) |  |  | 56 |
| 4H | _(unnamed — the Requires expression is the definition)_ | (hcp >= 10 and H >= 7) |  |  | 15 |
| 4S | _(unnamed — the Requires expression is the definition)_ | (hcp >= 11 and hcp<= 12 and S >= 2) \| (S >= 4 and S_points >= 10 and hcp <10) \| (hcp >= 11 and hcp<= 12 and S >= 3) \| (hcp >= 9 and hcp<= 12 and S >= 4) |  |  | 43 |
| 4N* | RKC | (CanAsk_S_RKC) \| (S_slam) | T=S | RKC0314_S | 80 |
| 5N* | GSForce | (CanAsk_S_GSF) | T=S | GSForce | 135 |
| 6S | To Play | (CanBid6_S) |  |  | 60 |
| 6S | Playing strength: one loser with a real solid suit or an agreed fit | ((realsolid('S') or trump('S')) and losers == 1) | T=S |  | 65 |
| 6S | Slam: own playing strength -- our hand alone rates to take twelve tricks | (monsterslam('S')) | T=S |  | 133 |
| 7S | Playing strength: no losers with a real solid suit or an agreed fit | ((realsolid('S') or trump('S')) and losers <= 0) | T=S |  | 66 |
| 7S | Grand slam: own playing strength -- our hand alone rates to take thirteen tricks | (monstergrand('S')) | T=S |  | 134 |
| 7N | To Play | (CanBid7NT) |  |  | 130 |
| X | _(unnamed — the Requires expression is the definition)_ | (H >= 4 and hcp>= 10) |  |  | 10 |

#### `1S-3D`

| Call | Means | Requires | Post-condition | Convention | Pri |
|---|---|---|---|---|---|
| P | _(unnamed — the Requires expression is the definition)_ | (hcp <= 11) |  |  |  |
| 3H | _(unnamed — the Requires expression is the definition)_ | (hcp >= 12 and H >= 5) | F1 |  | 35 |
| 3S | _(unnamed — the Requires expression is the definition)_ | (hcp >= 7 and hcp<= 10 and S >= 3) |  |  | 41 |
| 3N | _(unnamed — the Requires expression is the definition)_ | (hcp >= 12 and stopper('D') and hcp <= 18) |  |  | 20 |
| 4C | _(unnamed — the Requires expression is the definition)_ | (C >= 6 and hcp>= 10) | F1 |  | 5 |
| 4D* | _(unnamed — the Requires expression is the definition)_ | (hcp >= 13 and S >= 2) \| (hcp >= 13 and S >= 3) |  |  | 56 |
| 4H | _(unnamed — the Requires expression is the definition)_ | (hcp >= 10 and H >= 7) |  |  | 15 |
| 4S | _(unnamed — the Requires expression is the definition)_ | (hcp >= 11 and hcp<= 12 and S >= 2) \| (S >= 4 and S_points >= 10 and hcp <10) \| (hcp >= 11 and hcp<= 12 and S >= 3) \| (hcp >= 9 and hcp<= 12 and S >= 4) |  |  | 43 |
| 4N* | RKC | (CanAsk_S_RKC) \| (S_slam) | T=S | RKC0314_S | 80 |
| 5N* | GSForce | (CanAsk_S_GSF) | T=S | GSForce | 135 |
| 6S | To Play | (CanBid6_S) |  |  | 60 |
| 6S | Playing strength: one loser with a real solid suit or an agreed fit | ((realsolid('S') or trump('S')) and losers == 1) | T=S |  | 65 |
| 6S | Slam: own playing strength -- our hand alone rates to take twelve tricks | (monsterslam('S')) | T=S |  | 133 |
| 7S | Playing strength: no losers with a real solid suit or an agreed fit | ((realsolid('S') or trump('S')) and losers <= 0) | T=S |  | 66 |
| 7S | Grand slam: own playing strength -- our hand alone rates to take thirteen tricks | (monstergrand('S')) | T=S |  | 134 |
| 7N | To Play | (CanBid7NT) |  |  | 130 |
| X | _(unnamed — the Requires expression is the definition)_ | (H >= 4 and hcp>= 10) |  |  | 10 |

#### `1S-3H`

| Call | Means | Requires | Post-condition | Convention | Pri |
|---|---|---|---|---|---|
| P | _(unnamed — the Requires expression is the definition)_ | (true) |  |  |  |
| 3S | Board: 299999, Hand: 87543.972.QJ.AJ8 [MS=E-competitive(Spades)] | (competitive('S')) |  |  | 24 |
| 3N | _(unnamed — the Requires expression is the definition)_ | (game and stopper('H')) |  |  | 10 |
| 4C | Board: 158470, Hand: .J5.Q8754.AKJ853 [MS=E2-overcall(Clubs)] [authored] | (rebiddable('C') and hcp >= 10 and bestsuit('C')) | F1 |  | 31 |
| 4C | _(unnamed — the Requires expression is the definition)_ | (C >= 6 and hcp >= 12) | F1 |  | 40 |
| 4D | Board: 158470, Hand: .J5.Q8754.AKJ853 [MS=E2-overcall(Clubs)] [authored] | (rebiddable('D') and hcp >= 10 and bestsuit('D')) | F1 |  | 31 |
| 4D | _(unnamed — the Requires expression is the definition)_ | (D >= 6 and hcp >= 12) | F1 |  | 40 |
| 4H* | _(unnamed — the Requires expression is the definition)_ | (S >= 3 and spadegame and hcp >= 12) |  |  | 20 |
| 4S | _(unnamed — the Requires expression is the definition)_ | (preemptive('S')) \| (S >= 3 and S_points >= 10) |  |  | 50 |
| 4S | Board: 610918, Hand: Q8632..JT84.9532 [MS=4-undisclosed-fit-game(target=4S,myLen=5,partnerShown=5)] | (S_compgame) |  |  | 54 |
| 5C | _(unnamed — the Requires expression is the definition)_ | (C >= 7 and hcp <= 12 and hcp >= 6 and S <= 2) |  |  | 30 |
| 5D | _(unnamed — the Requires expression is the definition)_ | (D >= 7 and hcp <= 12 and hcp >= 6 and S <= 2) |  |  | 30 |
| 6C | _(unnamed — the Requires expression is the definition)_ | (C_slam) |  |  | 56 |
| 6D | _(unnamed — the Requires expression is the definition)_ | (D_slam) |  |  | 56 |
| X | _(unnamed — the Requires expression is the definition)_ | (S >= 2 and hcp >= 10) \| (game) |  |  | 5 |

#### `1S-4C`

| Call | Means | Requires | Post-condition | Convention | Pri |
|---|---|---|---|---|---|
| P | _(unnamed — the Requires expression is the definition)_ | (hcp <= 11) |  |  |  |
| 4H | _(unnamed — the Requires expression is the definition)_ | (hcp >= 12 and H >= 6) |  |  | 30 |
| 4S | _(unnamed — the Requires expression is the definition)_ | (hcp >= 11 and hcp<= 12 and S >= 2) \| (hcp >= 9 and hcp<= 16 and S >= 3) |  |  | 25 |
| 4N* | RKC | (CanAsk_S_RKC) \| (S_slam) | T=S | RKC0314_S | 80 |
| 5D | Board: 2 | (((D_compgame and (Fit('D') or D >= 6)) or (twicerebiddable('D') and losers <= 2)) or cansacrifice('D', false)) |  |  | 52 |
| 5N* | GSForce | (CanAsk_S_GSF) | T=S | GSForce | 135 |
| 6S | To Play | (CanBid6_S) |  |  | 60 |
| 6S | Playing strength: one loser with a real solid suit or an agreed fit | ((realsolid('S') or trump('S')) and losers == 1) | T=S |  | 65 |
| 6S | Slam: own playing strength -- our hand alone rates to take twelve tricks | (monsterslam('S')) | T=S |  | 133 |
| 7S | Playing strength: no losers with a real solid suit or an agreed fit | ((realsolid('S') or trump('S')) and losers <= 0) | T=S |  | 66 |
| 7S | Grand slam: own playing strength -- our hand alone rates to take thirteen tricks | (monstergrand('S')) | T=S |  | 134 |
| 7N | To Play | (CanBid7NT) |  |  | 130 |
| X | _(unnamed — the Requires expression is the definition)_ | (hcp >= 10) |  |  | 10 |

#### `1S-4D`

| Call | Means | Requires | Post-condition | Convention | Pri |
|---|---|---|---|---|---|
| P | _(unnamed — the Requires expression is the definition)_ | (hcp <= 11) |  |  |  |
| 4H | _(unnamed — the Requires expression is the definition)_ | (hcp >= 12 and H >= 6) |  |  | 30 |
| 4S | _(unnamed — the Requires expression is the definition)_ | (hcp >= 11 and hcp<= 12 and S >= 2) \| (hcp >= 9 and hcp<= 16 and S >= 3) |  |  | 25 |
| 4N* | RKC | (CanAsk_S_RKC) \| (S_slam) | T=S | RKC0314_S | 80 |
| 5C | Board: 2 | (((C_compgame and (Fit('C') or C >= 6)) or (twicerebiddable('C') and losers <= 2)) or cansacrifice('C', false)) |  |  | 52 |
| 5N* | GSForce | (CanAsk_S_GSF) | T=S | GSForce | 135 |
| 6S | To Play | (CanBid6_S) |  |  | 60 |
| 6S | Playing strength: one loser with a real solid suit or an agreed fit | ((realsolid('S') or trump('S')) and losers == 1) | T=S |  | 65 |
| 6S | Slam: own playing strength -- our hand alone rates to take twelve tricks | (monsterslam('S')) | T=S |  | 133 |
| 7S | Playing strength: no losers with a real solid suit or an agreed fit | ((realsolid('S') or trump('S')) and losers <= 0) | T=S |  | 66 |
| 7S | Grand slam: own playing strength -- our hand alone rates to take thirteen tricks | (monstergrand('S')) | T=S |  | 134 |
| 7N | To Play | (CanBid7NT) |  |  | 130 |
| X | _(unnamed — the Requires expression is the definition)_ | (hcp >= 10) |  |  | 10 |

#### `1S-4H`

| Call | Means | Requires | Post-condition | Convention | Pri |
|---|---|---|---|---|---|
| P | _(unnamed — the Requires expression is the definition)_ | (true) |  |  |  |
| 4S | Board: 403800, Hand: KT953.83.JT864.T [MS=4-sacrifice(Spades)] | (cansacrifice('S') or S_compgame) |  |  | 19 |
| 4S | _(unnamed — the Requires expression is the definition)_ | (S >= 3 and spadepoints >= 10) |  |  | 20 |
| 5C | Board: 737675, Hand: Q..KQJ985432.Q94 [MS=4-sacrifice(Diamonds)] | (cansacrifice('C') or C_compgame) |  |  | 51 |
| 5D | Board: 737675, Hand: Q..KQJ985432.Q94 [MS=4-sacrifice(Diamonds)] | (cansacrifice('D') or D_compgame) |  |  | 51 |
| X | _(unnamed — the Requires expression is the definition)_ | (game) \| (penalty) |  |  | 15 |

#### `1S-5C`

| Call | Means | Requires | Post-condition | Convention | Pri |
|---|---|---|---|---|---|
| P | _(unnamed — the Requires expression is the definition)_ | (true) |  |  |  |
| 5D | Hand: .T2.AKQ9876542.2 (GameEval) | (cansacrifice('D')) |  |  | 52 |
| 5H | Board: 989271, Hand: A95.AKQJ952.954. | (H_compgame) |  |  | 43 |
| 5H | Board: 959424, Hand: AKQ953.A6.QJ75.7 | (H_compgame) |  |  | 43 |
| 5S | Hand: AQ9732.KJ8652..5 (GameEval) | (cansacrifice('S')) |  |  | 44 |
| X | _(unnamed — the Requires expression is the definition)_ | (penalty) |  |  | 10 |

#### `1S-5D`

| Call | Means | Requires | Post-condition | Convention | Pri |
|---|---|---|---|---|---|
| P | _(unnamed — the Requires expression is the definition)_ | (not slammish) \| (true) |  |  |  |
| 5H | Board: 959424, Hand: AKQ953.A6.QJ75.7 | (H_compgame) |  |  | 43 |
| 5S | _(unnamed — the Requires expression is the definition)_ | (S >= 3 and hcp >= 12) |  |  |  |
| 5S | Hand: AQ9732.KJ8652..5 (GameEval) | (cansacrifice('S')) |  |  | 44 |
| X | _(unnamed — the Requires expression is the definition)_ | (hcp >= 13) \| (penalty) |  |  | 10 |

#### `1S-6C`

_Same rule set as `1H-6C` — the service returns an identical table for this position._

#### `1S-6D`

_Same rule set as `1H-6C` — the service returns an identical table for this position._

#### `1S-6H`

_Same rule set as `1H-6S` — the service returns an identical table for this position._

#### `1S-1N`

| Call | Means | Requires | Post-condition | Convention | Pri |
|---|---|---|---|---|---|
| P | _(unnamed — the Requires expression is the definition)_ | (hcp <= 8) |  |  | 10 |
| 2C | 6+ C, 5-8 hcp | (hcp <= 8 and hcp>= 5 and C >= 6) |  |  | 20 |
| 2D | 6+ D, 5-8 hcp | (hcp <= 8 and hcp>= 5 and D >= 6) |  |  | 20 |
| 2H | 6+ H, 5-8 hcp | (hcp <= 8 and hcp>= 5 and H >= 6) |  |  | 30 |
| 2S | 3+ S, 6-10 hcp | (hcp <= 10 and S_points>= 5 and S >= 3) | minhcp=6 |  | 40 |
| 3H | Board: 20260509_MP_006_WFI-Tournament | (loserlevel >= 3 and twicerebiddable('H') and not game) |  |  | 23 |
| 3S | 3+ S, 6-10 hcp | (hcp <= 10 and hcp>= 5 and S >= 4) \| (hcp <= 10 and hcp>= 5 and S >= 5) | minhcp=6 |  | 60 |
| 4H | _(unnamed — the Requires expression is the definition)_ | (H_points >= 11 and S >= 7) |  |  | 63 |
| 4S | _(unnamed — the Requires expression is the definition)_ | (S_points >= 11 and S >= 4) |  |  | 65 |
| X | Penalty | (ispenalty and hcp >= 9 and S <= 3) |  |  | 5 |

#### `1S-2N`

| Call | Means | Requires | Post-condition | Convention | Pri |
|---|---|---|---|---|---|
| P | _(unnamed — the Requires expression is the definition)_ | (hcp <= 8) |  | UnusualNTDefence |  |
| 3C* | Limit+ in S | (S >= 3 and hcp>= 10) |  | UnusualNTDefence | 60 |
| 3D* | 5+ H, 10+ hcp | (H >= 5 and hcp>= 10) |  | UnusualNTDefence | 50 |
| 3H | _(unnamed — the Requires expression is the definition)_ | (H >= 6 and hcp<= 9 and hcp>= 7) |  | UnusualNTDefence | 25 |
| 3S | Competitive | (S >= 3 and hcp<= 9 and hcp>= 7) |  | UnusualNTDefence | 30 |
| 3N | _(unnamed — the Requires expression is the definition)_ | (stopper('C') and stopper ('D') and hcp>= 12 and S <= 2) |  | UnusualNTDefence | 40 |
| 4H | _(unnamed — the Requires expression is the definition)_ | (H >= 7 and hcp<= 9 and hcp>= 7) |  | UnusualNTDefence | 35 |
| 4S | _(unnamed — the Requires expression is the definition)_ | (S >= 4 and hcp<= 9 and S_points >= 6) |  | UnusualNTDefence | 33 |
| 4N* | RKC | (CanAsk_S_RKC) \| (S_slam) | T=S | RKC0314_S | 80 |
| 5N* | GSForce | (CanAsk_S_GSF) | T=S | GSForce | 135 |
| 6S | To Play | (CanBid6_S) |  |  | 60 |
| 6S | Playing strength: one loser with a real solid suit or an agreed fit | ((realsolid('S') or trump('S')) and losers == 1) | T=S |  | 65 |
| 6S | Slam: own playing strength -- our hand alone rates to take twelve tricks | (monsterslam('S')) | T=S |  | 133 |
| 7S | Playing strength: no losers with a real solid suit or an agreed fit | ((realsolid('S') or trump('S')) and losers <= 0) | T=S |  | 66 |
| 7S | Grand slam: own playing strength -- our hand alone rates to take thirteen tricks | (monstergrand('S')) | T=S |  | 134 |
| 7N | To Play | (CanBid7NT) |  |  | 130 |
| X | _(unnamed — the Requires expression is the definition)_ | (hcp >= 9) |  | UnusualNTDefence | 10 |

#### `2C-P`

| Call | Means | Requires | Post-condition | Convention | Pri |
|---|---|---|---|---|---|
| 2D* | Waiting / Negative | (true) |  |  |  |
| 2H | 5+ cards in Major, 8+ hcp | (H >= 5 and hcp>= 7 and IsGoodSuit('H') and H == lengthlongestsuit) | GF |  | 40 |
| 2S | 5+ cards in Major, 8+ hcp | (S >= 5 and hcp>= 7 and IsGoodSuit('S') and S == lengthlongestsuit) | GF |  | 40 |
| 2N | 8+ hcp, bal | (hcp >= 8 and (balanced or semibalanced)) | GF |  | 20 |
| 3C | 5+ cards in C, 8+ hcp | (C >= 5 and hcp>= 7 and IsGoodSuit('C') and singlesuited) \| (C >= 7 and hcp>= 7 and IsGoodSuit('C')) | GF |  | 33 |
| 3D | 5+ cards in D, 8+ hcp | (D >= 5 and hcp>= 7 and IsGoodSuit('D') and singlesuited) \| (D >= 7 and hcp>= 7 and IsGoodSuit('D')) | GF |  | 33 |
| 6N | To Play | (CanBid6NT) |  |  | 11 |
| 7N | To Play | (CanBid7NT) |  |  | 13 |

#### `2C-2D`

| Call | Means | Requires | Post-condition | Convention | Pri |
|---|---|---|---|---|---|
| P | _(unnamed — the Requires expression is the definition)_ | (true) | F1 |  |  |
| 2H | Hand: 53.QJ98654..J854 (DominantSuit) | (rebiddable('H') and hcp >= 8) |  |  | 19 |
| 2S | Hand: 53.QJ98654..J854 (DominantSuit) | (rebiddable('S') and hcp >= 8) |  |  | 19 |
| 2N | Hand: 92.6.T865432.Q53 (Partscore) | (stopper('D') and hcp >= 8) |  |  | 20 |
| 3C | Hand: 3.74.A8.T9876432 (Partscore) | (C >= 6 and hcp >= 8) |  |  | 21 |
| 3D* | Board: 127332, Hand: J4.Q32.75.KJT642 | (D <= 1 and hcp >= 6) |  |  | 22 |
| X | _(unnamed — the Requires expression is the definition)_ | (penalty) | F1 |  | 40 |

#### `2C-2H`

| Call | Means | Requires | Post-condition | Convention | Pri |
|---|---|---|---|---|---|
| P | _(unnamed — the Requires expression is the definition)_ | (hcp <= 7) |  |  |  |
| 2S | _(unnamed — the Requires expression is the definition)_ | (S >= 5 and hcp>= 8) |  |  | 20 |
| 2N | _(unnamed — the Requires expression is the definition)_ | (stopper('H') and hcp>= 8) | GF |  | 10 |
| 3C | _(unnamed — the Requires expression is the definition)_ | (bestminor('C') and C >= 6 and hcp>= 7) \| (bestminor('C') and C >= 5 and hcp>= 8) | GF |  | 20 |
| 3D | _(unnamed — the Requires expression is the definition)_ | (bestminor('D') and D >= 6 and hcp>= 7) \| (bestminor('D') and D >= 5 and hcp>= 8) | GF |  | 20 |
| 3H* | _(unnamed — the Requires expression is the definition)_ | (not stopper('H') and game) | GF |  | 5 |
| X | Penalty | (H >= 5 or penalty) | penaltyInterest |  | 30 |

#### `2C-2S`

| Call | Means | Requires | Post-condition | Convention | Pri |
|---|---|---|---|---|---|
| P | _(unnamed — the Requires expression is the definition)_ | (hcp <= 7) |  |  |  |
| 2N | _(unnamed — the Requires expression is the definition)_ | (stopper('S') and hcp>= 8) | GF |  | 10 |
| 3C | _(unnamed — the Requires expression is the definition)_ | (bestminor('C') and C >= 6 and hcp>= 7) \| (bestminor('C') and C >= 5 and hcp>= 8) | GF |  | 20 |
| 3D | _(unnamed — the Requires expression is the definition)_ | (bestminor('D') and D >= 6 and hcp>= 7) \| (bestminor('D') and D >= 5 and hcp>= 8) | GF |  | 20 |
| 3H | _(unnamed — the Requires expression is the definition)_ | (H >= 5 and hcp>= 8) |  |  | 70 |
| 3S* | _(unnamed — the Requires expression is the definition)_ | (not stopper('S') and game) | GF |  | 5 |
| X | Penalty | (S >= 5 or penalty) | penaltyInterest |  | 30 |

#### `2C-3C`

| Call | Means | Requires | Post-condition | Convention | Pri |
|---|---|---|---|---|---|
| P | _(unnamed — the Requires expression is the definition)_ | (hcp <= 7) |  |  |  |
| 3H | _(unnamed — the Requires expression is the definition)_ | (biddable('H') and hcp >= 8) |  |  | 5 |
| 3S | _(unnamed — the Requires expression is the definition)_ | (biddable('S') and hcp >= 8) |  |  | 5 |
| X | Penalty | (C >= 5 or penalty) | penaltyInterest |  | 30 |

#### `2C-3H`

| Call | Means | Requires | Post-condition | Convention | Pri |
|---|---|---|---|---|---|
| P | _(unnamed — the Requires expression is the definition)_ | (true) \| (penalty) |  |  | 90 |
| 3N | _(unnamed — the Requires expression is the definition)_ | (game and stoppersOK) |  |  | 55 |
| 4S | Board: 181208, Hand: KQ8764.J.6.KQ752 | (fourlevelovercall('S')) |  |  | 51 |
| 4S | Hand: KQT76543.8.Q874. (GameEval) | (S_game) |  |  | 53 |
| 5D | Hand: T9.2.KJT87653.72 (GameEval) | (cansacrifice('D', false)) |  |  | 52 |

#### `2C-3S`

| Call | Means | Requires | Post-condition | Convention | Pri |
|---|---|---|---|---|---|
| P | _(unnamed — the Requires expression is the definition)_ | (true) \| (penalty) |  |  | 90 |
| 3N | _(unnamed — the Requires expression is the definition)_ | (game and stoppersOK) |  |  | 55 |
| 4H | Board: 181208, Hand: KQ8764.J.6.KQ752 | (fourlevelovercall('H')) |  |  | 51 |
| 4H | Hand: KQT76543.8.Q874. (GameEval) | (H_game) |  |  | 53 |
| 5D | Hand: T9.2.KJT87653.72 (GameEval) | (cansacrifice('D', false)) |  |  | 52 |

#### `2C-4D`

| Call | Means | Requires | Post-condition | Convention | Pri |
|---|---|---|---|---|---|
| P | _(unnamed — the Requires expression is the definition)_ | (true) |  |  |  |

#### `2C-4H`

| Call | Means | Requires | Post-condition | Convention | Pri |
|---|---|---|---|---|---|
| P | _(unnamed — the Requires expression is the definition)_ | (hcp >= 8) |  |  | 20 |
| X | Negative | (hcp <= 7) |  |  | 10 |

#### `2C-4S`

_Same rule set as `2C-4H` — the service returns an identical table for this position._

#### `2C-5D`

| Call | Means | Requires | Post-condition | Convention | Pri |
|---|---|---|---|---|---|
| P | Board: 145926 | (true) |  |  |  |

#### `2D-P`

| Call | Means | Requires | Post-condition | Convention | Pri |
|---|---|---|---|---|---|
| P | _(unnamed — the Requires expression is the definition)_ | (true) |  |  |  |
| 2H | Nat, forcing | (hcp >= 14 and H >= 5) |  |  | 76 |
| 2S | Nat, forcing | (hcp >= 14 and S >= 5) |  |  | 76 |
| 2N* | FeatureAsk, 15+ hcp | (hcp >= 15) |  | FeatureAskDiamond | 70 |
| 3D | Board: 14644, Hand: K.Q43.AK73.QT432 | (competitive('D')) |  |  | 25 |
| 3D | Preemptive | (hcp >= 10 and diamonds >= 2 and hcp <= 13) \| (diamondpoints >= 7 and diamonds >= 3 and diamondpoints <= 10) | minhcp=6,maxhcp=12 |  | 66 |
| 3H | Nat, forcing | (totalpoints >= 20 and H >= 6 and singlesuited and losers >= 4 and hcp <= 18) |  |  | 80 |
| 3S | Nat, forcing | (totalpoints >= 20 and S >= 6 and singlesuited and losers >= 4 and hcp <= 18) |  |  | 80 |
| 3N | Nat | (hcp >= 18 and hcp<= 21) |  |  | 30 |
| 4D | Preemptive | (diamondpoints >= 7 and diamonds >= 4 and diamondpoints <= 11) |  |  | 68 |
| 4H | Board: 457585, Hand: KQ98642.AT762..2 | (H_game and rebiddable('H')) |  |  | 53 |
| 4H | Nat | (hcp >= 17 and H >= 6 and singlesuited and not slammish ) |  |  | 75 |
| 4H | _(unnamed — the Requires expression is the definition)_ | (twicerebiddable('H') and losers <= 4 and not slammish) | T=H, minhcp=15 |  | 84 |
| 4S | Board: 457585, Hand: KQ98642.AT762..2 | (S_game and rebiddable('S')) |  |  | 53 |
| 4S | Nat | (hcp >= 17 and S >= 6 and singlesuited and not slammish ) |  |  | 75 |
| 4S | _(unnamed — the Requires expression is the definition)_ | (twicerebiddable('S') and losers <= 4 and not slammish) | T=S, minhcp=15 |  | 84 |
| 4N* | RKC | ((D >= 2) AND (CanAsk_D_RKC)) \| ((D >= 2) AND (diamondslam)) | T=D | RKC0314_D | 60 |
| 5C | Hand: A.JT2..AKJT97654 (GameEval) | (C_game and not slammish) |  |  | 71 |
| 5D | Board: 510754, Hand: AQ852.5.K9743.74 | (preemptgame('D')) \| (covergame('D')) |  |  | 35 |
| 5D | _(unnamed — the Requires expression is the definition)_ | (diamondpoints >= 7 and diamonds >= 6) \| (D >= 3 and D_points >= 15) \| (D_game) \| (diamondpoints >= 7 and diamonds >= 5 and diamondpoints <= 13) | T=D |  | 70 |
| 5N* | GSForce | ((D >= 2) AND (CanAsk_D_GSF)) | T=D | GSForce | 115 |
| 6D | To Play | ((D >= 2) AND (CanBid6_D)) |  |  | 40 |
| 6D | Playing strength: one loser with a real solid suit or an agreed fit | ((D >= 2) AND ((realsolid('D') or trump('D')) and losers == 1)) | T=D |  | 45 |
| 6D | Slam: own playing strength -- our hand alone rates to take twelve tricks | ((D >= 2) AND (monsterslam('D'))) | T=D |  | 113 |
| 6N | To Play | (CanBid6NT) |  |  | 50 |
| 7D | Playing strength: no losers with a real solid suit or an agreed fit | ((D >= 2) AND ((realsolid('D') or trump('D')) and losers <= 0)) | T=D |  | 46 |
| 7D | Grand slam: own playing strength -- our hand alone rates to take thirteen tricks | ((D >= 2) AND (monstergrand('D'))) | T=D |  | 114 |
| 7N | To Play | (CanBid7NT) \| ((D >= 2) AND (CanBid7NT)) |  |  | 110 |

#### `2D-X`

| Call | Means | Requires | Post-condition | Convention | Pri |
|---|---|---|---|---|---|
| P | _(unnamed — the Requires expression is the definition)_ | (true) |  |  |  |
| 2H | Nat, forcing | (hcp >= 14 and H >= 5) |  |  | 76 |
| 2S | Nat, forcing | (hcp >= 14 and S >= 5) |  |  | 76 |
| 2N* | FeatureAsk, 15+ hcp | (hcp >= 15) |  | FeatureAskDiamond | 70 |
| 3D | Board: 14644, Hand: K.Q43.AK73.QT432 | (competitive('D')) |  |  | 25 |
| 3D | Preemptive | (hcp >= 10 and diamonds >= 2 and hcp <= 13) \| (diamondpoints >= 7 and diamonds >= 3 and diamondpoints <= 10) | minhcp=6,maxhcp=12 |  | 66 |
| 3H | Nat, forcing | (totalpoints >= 20 and H >= 6 and singlesuited and losers >= 4 and hcp <= 18) |  |  | 80 |
| 3S | Nat, forcing | (totalpoints >= 20 and S >= 6 and singlesuited and losers >= 4 and hcp <= 18) |  |  | 80 |
| 3N | Nat | (hcp >= 18 and hcp<= 21) |  |  | 30 |
| 4D | Hand: AT4.QT842.AT85.5 (LOTTRaise) | (preemptive('D')) |  |  | 32 |
| 4D | Preemptive | (diamondpoints >= 7 and diamonds >= 4 and diamondpoints <= 11) |  |  | 68 |
| 4H | Board: 457585, Hand: KQ98642.AT762..2 | (H_game and rebiddable('H')) |  |  | 53 |
| 4H | Nat | (hcp >= 17 and H >= 6 and singlesuited and not slammish ) |  |  | 75 |
| 4H | _(unnamed — the Requires expression is the definition)_ | (twicerebiddable('H') and losers <= 4 and not slammish) | T=H, minhcp=15 |  | 84 |
| 4S | Board: 457585, Hand: KQ98642.AT762..2 | (S_game and rebiddable('S')) |  |  | 53 |
| 4S | Nat | (hcp >= 17 and S >= 6 and singlesuited and not slammish ) |  |  | 75 |
| 4S | _(unnamed — the Requires expression is the definition)_ | (twicerebiddable('S') and losers <= 4 and not slammish) | T=S, minhcp=15 |  | 84 |
| 4N* | RKC | ((D >= 2) AND (CanAsk_D_RKC)) \| ((D >= 2) AND (diamondslam)) | T=D | RKC0314_D | 60 |
| 5C | Hand: A.JT2..AKJT97654 (GameEval) | (C_game and not slammish) |  |  | 71 |
| 5D | Board: 510754, Hand: AQ852.5.K9743.74 | (preemptgame('D')) \| (covergame('D')) |  |  | 35 |
| 5D | _(unnamed — the Requires expression is the definition)_ | (diamondpoints >= 7 and diamonds >= 6) \| (D >= 3 and D_points >= 15) \| (D_compgame) \| (D_game) \| (preemptgame('D')) \| (diamondpoints >= 7 and diamonds >= 5 and diamondpoints <= 13) | T=D |  | 70 |
| 5N* | GSForce | ((D >= 2) AND (CanAsk_D_GSF)) | T=D | GSForce | 115 |
| 6D | To Play | ((D >= 2) AND (CanBid6_D)) |  |  | 40 |
| 6D | Playing strength: one loser with a real solid suit or an agreed fit | ((D >= 2) AND ((realsolid('D') or trump('D')) and losers == 1)) | T=D |  | 45 |
| 6D | Slam: own playing strength -- our hand alone rates to take twelve tricks | ((D >= 2) AND (monsterslam('D'))) | T=D |  | 113 |
| 6N | To Play | (CanBid6NT) |  |  | 50 |
| 7D | Playing strength: no losers with a real solid suit or an agreed fit | ((D >= 2) AND ((realsolid('D') or trump('D')) and losers <= 0)) | T=D |  | 46 |
| 7D | Grand slam: own playing strength -- our hand alone rates to take thirteen tricks | ((D >= 2) AND (monstergrand('D'))) | T=D |  | 114 |
| 7N | To Play | (CanBid7NT) \| ((D >= 2) AND (CanBid7NT)) |  |  | 110 |

#### `2D-2H`

| Call | Means | Requires | Post-condition | Convention | Pri |
|---|---|---|---|---|---|
| P | _(unnamed — the Requires expression is the definition)_ | (true) |  |  |  |
| 2S | Board: 134642, Hand: AKQT53.Q6.QJ.J96 | (twicerebiddable('S') and hcp >= 12) |  |  | 9 |
| 2S | _(unnamed — the Requires expression is the definition)_ | (competitive('S')) | minhcp=10,maxhcp=14 |  | 10 |
| 2N | Board: Challengebyhwaugh74_3e253394_b4 | (hcp >= 15 and stopper('H')) |  |  | 41 |
| 3C | Board: T203714, Hand: J32.KQ.7.AKQJ976 | (loserlevel >= 3 and twicerebiddable('C')) | maxhcp=12 |  | 19 |
| 3D | _(unnamed — the Requires expression is the definition)_ | (competitive('D')) \| (D >= 3 and hcp >= 7 and hcp <= 14) | minhcp=5,maxhcp=11 |  | 5 |
| 3H* | Nat, forcing | (hcp >= 17 and D >= 2) |  |  | 22 |
| 3S | Nat, forcing | (totalpoints >= 20 and S >= 5) | F1 |  | 20 |
| 3N | Nat | (hcp >= 17 and hcp<= 21 and stopper('H')) |  |  | 25 |
| 4D | _(unnamed — the Requires expression is the definition)_ | (D >= 4 and hcp >= 7 and hcp <= 11) |  |  | 15 |
| 4S | Hand: AKQ965.KT64.9.K2 (GameEval) | (S_compgame) |  |  | 53 |
| 4S | Nat | (hcp >= 17 and S >= 6 and not slammish) \| (hcp >= 10 and S >= 7 and not slammish) |  |  | 60 |
| 4N* | RKC | (CanAsk_D_RKC) \| (diamondslam) | T=D | RKC0314_D | 60 |
| 5C | Board: 739726, Hand: T3.A5.K.AKQ87652 | (C_game and rebiddable('C')) |  |  | 50 |
| 5C | Hand: 74.K6..AKQT98653 (GameEval) | (cansacrifice('C', false)) |  |  | 51 |
| 5D | _(unnamed — the Requires expression is the definition)_ | (D >= 4 and hcp >= 12) \| (D_compgame) \| (preemptgame('D')) |  |  | 70 |
| 5N* | GSForce | (CanAsk_D_GSF) | T=D | GSForce | 115 |
| 6D | To Play | (CanBid6_D) |  |  | 40 |
| 6D | Playing strength: one loser with a real solid suit or an agreed fit | ((realsolid('D') or trump('D')) and losers == 1) | T=D |  | 45 |
| 6D | Slam: own playing strength -- our hand alone rates to take twelve tricks | (monsterslam('D')) | T=D |  | 113 |
| 7D | Playing strength: no losers with a real solid suit or an agreed fit | ((realsolid('D') or trump('D')) and losers <= 0) | T=D |  | 46 |
| 7D | Grand slam: own playing strength -- our hand alone rates to take thirteen tricks | (monstergrand('D')) | T=D |  | 114 |
| 7N | To Play | (CanBid7NT) |  |  | 110 |
| X | Hand: AJ942.AJ6.AT.J76 (PenaltyDouble) | (penalty) |  |  | 90 |

#### `2D-2S`

| Call | Means | Requires | Post-condition | Convention | Pri |
|---|---|---|---|---|---|
| P | _(unnamed — the Requires expression is the definition)_ | (true) |  |  |  |
| 2N | Board: Challengebyhwaugh74_3e253394_b4 | (hcp >= 15 and stopper('S')) |  |  | 41 |
| 3C | Board: T203714, Hand: J32.KQ.7.AKQJ976 | (loserlevel >= 3 and twicerebiddable('C')) | maxhcp=12 |  | 19 |
| 3D | _(unnamed — the Requires expression is the definition)_ | (competitive('D')) \| (D >= 3 and hcp >= 7 and hcp <= 14) | minhcp=5,maxhcp=11 |  | 5 |
| 3H | Nat, forcing | (totalpoints >= 20 and H >= 5) | F1 |  | 20 |
| 3S* | Nat, forcing | (hcp >= 17 and D >= 2) |  |  | 22 |
| 3N | Nat | (hcp >= 17 and hcp<= 21 and stopper('S')) |  |  | 25 |
| 4D | _(unnamed — the Requires expression is the definition)_ | (D >= 4 and hcp >= 7 and hcp <= 11) |  |  | 15 |
| 4H | Hand: AKQ965.KT64.9.K2 (GameEval) | (H_compgame) |  |  | 53 |
| 4H | Nat | (hcp >= 17 and H >= 6 and not slammish) \| (hcp >= 10 and H >= 7 and not slammish) |  |  | 60 |
| 4N* | RKC | (CanAsk_D_RKC) \| (diamondslam) | T=D | RKC0314_D | 60 |
| 5C | Board: 739726, Hand: T3.A5.K.AKQ87652 | (C_game and rebiddable('C')) |  |  | 50 |
| 5C | Hand: 74.K6..AKQT98653 (GameEval) | (cansacrifice('C', false)) |  |  | 51 |
| 5D | _(unnamed — the Requires expression is the definition)_ | (D >= 4 and hcp >= 12) \| (D_compgame) \| (preemptgame('D')) |  |  | 70 |
| 5N* | GSForce | (CanAsk_D_GSF) | T=D | GSForce | 115 |
| 6D | To Play | (CanBid6_D) |  |  | 40 |
| 6D | Playing strength: one loser with a real solid suit or an agreed fit | ((realsolid('D') or trump('D')) and losers == 1) | T=D |  | 45 |
| 6D | Slam: own playing strength -- our hand alone rates to take twelve tricks | (monsterslam('D')) | T=D |  | 113 |
| 7D | Playing strength: no losers with a real solid suit or an agreed fit | ((realsolid('D') or trump('D')) and losers <= 0) | T=D |  | 46 |
| 7D | Grand slam: own playing strength -- our hand alone rates to take thirteen tricks | (monstergrand('D')) | T=D |  | 114 |
| 7N | To Play | (CanBid7NT) |  |  | 110 |
| X | Hand: AJ942.AJ6.AT.J76 (PenaltyDouble) | (penalty) |  |  | 90 |

#### `2D-3C`

| Call | Means | Requires | Post-condition | Convention | Pri |
|---|---|---|---|---|---|
| P | _(unnamed — the Requires expression is the definition)_ | (true) |  |  |  |
| 3D | _(unnamed — the Requires expression is the definition)_ | (competitive('D')) |  |  | 10 |
| 3D | Preemptive | (diamondpoints >= 7 and diamonds >= 3 and diamondpoints <= 10) |  |  | 66 |
| 3H | Board: 173240, Hand: AKT862.KJT5..KJ7 | (overcall('H')) |  |  | 79 |
| 3H | Nat, forcing | (totalpoints >= 20 and H >= 6 and singlesuited) | F1 |  | 80 |
| 3S | Board: 173240, Hand: AKT862.KJT5..KJ7 | (overcall('S')) |  |  | 79 |
| 3S | Nat, forcing | (totalpoints >= 20 and S >= 6 and singlesuited) | F1 |  | 80 |
| 3N | Nat | (hcp >= 18 and hcp<= 21) |  |  | 30 |
| 4D | Preemptive | (diamondpoints >= 7 and diamonds >= 4 and diamondpoints <= 11) |  |  | 68 |
| 4H | Board: 35530, Hand: QJT7654.AKT92..T | (fourlevelovercall('H')) | minhcp=15 |  | 53 |
| 4H | Hand: AK98.AQJ98753.9. (GameEval) | (H_game) |  |  | 54 |
| 4H | Nat | (hcp >= 17 and H >= 6 and singlesuited and not slammish ) |  |  | 75 |
| 4S | Board: 35530, Hand: QJT7654.AKT92..T | (fourlevelovercall('S')) | minhcp=15 |  | 53 |
| 4S | Hand: AK98.AQJ98753.9. (GameEval) | (S_game) |  |  | 54 |
| 4S | Nat | (hcp >= 17 and S >= 6 and singlesuited and not slammish ) |  |  | 75 |
| 4N* | RKC | ((D >= 2) AND (CanAsk_D_RKC)) \| ((D >= 2) AND (diamondslam)) | T=D | RKC0314_D | 60 |
| 5D | Hand: Q865.AKQ95.K854. (GameEval) | (D_game) |  |  | 52 |
| 5D | _(unnamed — the Requires expression is the definition)_ | (D_compgame) \| (preemptgame('D')) \| (diamondpoints >= 7 and diamonds >= 5 and diamondpoints <= 13) |  |  | 70 |
| 5N* | GSForce | ((D >= 2) AND (CanAsk_D_GSF)) | T=D | GSForce | 115 |
| 6D | To Play | ((D >= 2) AND (CanBid6_D)) |  |  | 40 |
| 6D | Playing strength: one loser with a real solid suit or an agreed fit | ((D >= 2) AND ((realsolid('D') or trump('D')) and losers == 1)) | T=D |  | 45 |
| 6D | Slam: own playing strength -- our hand alone rates to take twelve tricks | ((D >= 2) AND (monsterslam('D'))) | T=D |  | 113 |
| 6N | To Play | (CanBid6NT) |  |  | 50 |
| 7D | Playing strength: no losers with a real solid suit or an agreed fit | ((D >= 2) AND ((realsolid('D') or trump('D')) and losers <= 0)) | T=D |  | 46 |
| 7D | Grand slam: own playing strength -- our hand alone rates to take thirteen tricks | ((D >= 2) AND (monstergrand('D'))) | T=D |  | 114 |
| 7N | To Play | (CanBid7NT) \| ((D >= 2) AND (CanBid7NT)) |  |  | 110 |
| X | _(unnamed — the Requires expression is the definition)_ | (penalty) |  |  | 90 |

#### `2D-3D`

| Call | Means | Requires | Post-condition | Convention | Pri |
|---|---|---|---|---|---|
| P | _(unnamed — the Requires expression is the definition)_ | (not diamondgame) |  | MichaelsCuebid2XDefence |  |
| 3N | Nat | (hcp >= 18 and hcp<= 21 and stopper('H') and stopper('S')) |  | MichaelsCuebid2XDefence | 20 |
| 4D | Nat | (D >= 3 and hcp<= 10) |  | MichaelsCuebid2XDefence | 30 |
| 4N* | RKC | (CanAsk_C_RKC) \| (CanAsk_D_RKC) \| (C_slam) \| (D_slam) | T=C \| T=D | RKC0314_C \| RKC0314_D | 80 |
| 5D | Board: 35503, Hand: .62.AQ4.AKQT6542 | (D_game) |  | MichaelsCuebid2XDefence | 4 |
| 5D | Nat | (D >= 2 and hcp>= 18) \| (D >= 4 and hcp>= 10) |  | MichaelsCuebid2XDefence | 40 |
| 5D | _(unnamed — the Requires expression is the definition)_ | (D_compgame) \| (preemptgame('D')) |  | MichaelsCuebid2XDefence | 70 |
| 5N* | GSForce | (CanAsk_C_GSF) \| (CanAsk_D_GSF) | T=C \| T=D | GSForce | 135 |
| 6C | To Play | (CanBid6_C) |  | MichaelsCuebid2XDefence | 60 |
| 6C | Playing strength: one loser with a real solid suit or an agreed fit | ((realsolid('C') or trump('C')) and losers == 1) | T=C | MichaelsCuebid2XDefence | 65 |
| 6C | Slam: own playing strength -- our hand alone rates to take twelve tricks | (monsterslam('C')) | T=C | MichaelsCuebid2XDefence | 133 |
| 6D | To Play | (CanBid6_D) |  | MichaelsCuebid2XDefence | 60 |
| 6D | Playing strength: one loser with a real solid suit or an agreed fit | ((realsolid('D') or trump('D')) and losers == 1) | T=D | MichaelsCuebid2XDefence | 65 |
| 6D | Slam: own playing strength -- our hand alone rates to take twelve tricks | (monsterslam('D')) | T=D | MichaelsCuebid2XDefence | 133 |
| 7C | Playing strength: no losers with a real solid suit or an agreed fit | ((realsolid('C') or trump('C')) and losers <= 0) | T=C | MichaelsCuebid2XDefence | 66 |
| 7C | Grand slam: own playing strength -- our hand alone rates to take thirteen tricks | (monstergrand('C')) | T=C | MichaelsCuebid2XDefence | 134 |
| 7D | Playing strength: no losers with a real solid suit or an agreed fit | ((realsolid('D') or trump('D')) and losers <= 0) | T=D | MichaelsCuebid2XDefence | 66 |
| 7D | Grand slam: own playing strength -- our hand alone rates to take thirteen tricks | (monstergrand('D')) | T=D | MichaelsCuebid2XDefence | 134 |
| 7N | To Play | (CanBid7NT) |  | MichaelsCuebid2XDefence | 130 |
| X | Board: 20260722_MP_005_BF-SB-Individual | (suitshowing('D')) |  | MichaelsCuebid2XDefence | 6 |

#### `2D-3H`

| Call | Means | Requires | Post-condition | Convention | Pri |
|---|---|---|---|---|---|
| P | _(unnamed — the Requires expression is the definition)_ | (true) |  |  |  |
| 3N | Nat | (hcp >= 18 and hcp<= 21) |  |  | 30 |
| 4D | Preemptive | (diamondpoints >= 7 and diamonds >= 4 and diamondpoints <= 11) |  |  | 68 |
| 4S | Nat | (hcp >= 17 and S >= 6 and singlesuited and not slammish ) |  |  | 75 |
| 4N* | RKC | ((D >= 2) AND (CanAsk_D_RKC)) \| ((D >= 2) AND (diamondslam)) | T=D | RKC0314_D | 60 |
| 5D | _(unnamed — the Requires expression is the definition)_ | (D_compgame) \| (preemptgame('D')) \| (diamondpoints >= 7 and diamonds >= 5 and diamondpoints <= 13) |  |  | 70 |
| 5N* | GSForce | ((D >= 2) AND (CanAsk_D_GSF)) | T=D | GSForce | 115 |
| 6D | To Play | ((D >= 2) AND (CanBid6_D)) |  |  | 40 |
| 6D | Playing strength: one loser with a real solid suit or an agreed fit | ((D >= 2) AND ((realsolid('D') or trump('D')) and losers == 1)) | T=D |  | 45 |
| 6D | Slam: own playing strength -- our hand alone rates to take twelve tricks | ((D >= 2) AND (monsterslam('D'))) | T=D |  | 113 |
| 6N | To Play | (CanBid6NT) |  |  | 50 |
| 7D | Playing strength: no losers with a real solid suit or an agreed fit | ((D >= 2) AND ((realsolid('D') or trump('D')) and losers <= 0)) | T=D |  | 46 |
| 7D | Grand slam: own playing strength -- our hand alone rates to take thirteen tricks | ((D >= 2) AND (monstergrand('D'))) | T=D |  | 114 |
| 7N | To Play | (CanBid7NT) \| ((D >= 2) AND (CanBid7NT)) |  |  | 110 |

#### `2D-3S`

| Call | Means | Requires | Post-condition | Convention | Pri |
|---|---|---|---|---|---|
| P | _(unnamed — the Requires expression is the definition)_ | (true) |  |  |  |
| 3N | Nat | (hcp >= 18 and hcp<= 21) |  |  | 30 |
| 4D | Preemptive | (diamondpoints >= 7 and diamonds >= 4 and diamondpoints <= 11) |  |  | 68 |
| 4H | Nat | (hcp >= 17 and H >= 6 and singlesuited and not slammish ) |  |  | 75 |
| 4N* | RKC | ((D >= 2) AND (CanAsk_D_RKC)) \| ((D >= 2) AND (diamondslam)) | T=D | RKC0314_D | 60 |
| 5D | _(unnamed — the Requires expression is the definition)_ | (D_compgame) \| (preemptgame('D')) \| (diamondpoints >= 7 and diamonds >= 5 and diamondpoints <= 13) |  |  | 70 |
| 5N* | GSForce | ((D >= 2) AND (CanAsk_D_GSF)) | T=D | GSForce | 115 |
| 6D | To Play | ((D >= 2) AND (CanBid6_D)) |  |  | 40 |
| 6D | Playing strength: one loser with a real solid suit or an agreed fit | ((D >= 2) AND ((realsolid('D') or trump('D')) and losers == 1)) | T=D |  | 45 |
| 6D | Slam: own playing strength -- our hand alone rates to take twelve tricks | ((D >= 2) AND (monsterslam('D'))) | T=D |  | 113 |
| 6N | To Play | (CanBid6NT) |  |  | 50 |
| 7D | Playing strength: no losers with a real solid suit or an agreed fit | ((D >= 2) AND ((realsolid('D') or trump('D')) and losers <= 0)) | T=D |  | 46 |
| 7D | Grand slam: own playing strength -- our hand alone rates to take thirteen tricks | ((D >= 2) AND (monstergrand('D'))) | T=D |  | 114 |
| 7N | To Play | (CanBid7NT) \| ((D >= 2) AND (CanBid7NT)) |  |  | 110 |

#### `2D-4C`

| Call | Means | Requires | Post-condition | Convention | Pri |
|---|---|---|---|---|---|
| P | _(unnamed — the Requires expression is the definition)_ | (true) |  |  |  |
| 4D | Board: 35, Hand: A652.KJ82.J765.8 [MS=E-competitive(Diamonds)] | (competitive('D')) |  |  | 67 |
| 4D | Preemptive | (diamondpoints >= 7 and diamonds >= 4 and diamondpoints <= 11) |  |  | 68 |
| 4H | Nat | (hcp >= 17 and H >= 6 and singlesuited and not slammish ) |  |  | 75 |
| 4S | Nat | (hcp >= 17 and S >= 6 and singlesuited and not slammish ) |  |  | 75 |
| 4N* | RKC | ((D >= 2) AND (CanAsk_D_RKC)) \| ((D >= 2) AND (diamondslam)) | T=D | RKC0314_D | 60 |
| 5D | _(unnamed — the Requires expression is the definition)_ | (D_compgame) \| (preemptgame('D')) \| (diamondpoints >= 7 and diamonds >= 5 and diamondpoints <= 13) |  |  | 70 |
| 5N* | GSForce | ((D >= 2) AND (CanAsk_D_GSF)) | T=D | GSForce | 115 |
| 6D | To Play | ((D >= 2) AND (CanBid6_D)) |  |  | 40 |
| 6D | Playing strength: one loser with a real solid suit or an agreed fit | ((D >= 2) AND ((realsolid('D') or trump('D')) and losers == 1)) | T=D |  | 45 |
| 6D | Slam: own playing strength -- our hand alone rates to take twelve tricks | ((D >= 2) AND (monsterslam('D'))) | T=D |  | 113 |
| 6N | To Play | (CanBid6NT) |  |  | 50 |
| 7D | Playing strength: no losers with a real solid suit or an agreed fit | ((D >= 2) AND ((realsolid('D') or trump('D')) and losers <= 0)) | T=D |  | 46 |
| 7D | Grand slam: own playing strength -- our hand alone rates to take thirteen tricks | ((D >= 2) AND (monstergrand('D'))) | T=D |  | 114 |
| 7N | To Play | (CanBid7NT) \| ((D >= 2) AND (CanBid7NT)) |  |  | 110 |

#### `2D-4H`

| Call | Means | Requires | Post-condition | Convention | Pri |
|---|---|---|---|---|---|
| P | _(unnamed — the Requires expression is the definition)_ | (true) |  |  |  |
| 4S | Hand: AKQT9873..T32.K4 (GameEval) | (cansacrifice('S')) |  |  | 54 |
| 4S | _(unnamed — the Requires expression is the definition)_ | (cansacrifice('S') and isvalidbid('4S')) |  |  | 68 |
| 4N* | RKC | ((D >= 2) AND (CanAsk_D_RKC)) \| ((D >= 2) AND (diamondslam)) | T=D | RKC0314_D | 60 |
| 5C | Board: 888479, Hand: KQJ932...AKJ8532 [MS=3a-loser-game(losers=2,ownTricks=11,game=4S,contract=4H)] | (cansacrifice('C') or C_compgame or (twicerebiddable('C') and losers <= 2)) |  |  | 50 |
| 5C | Board: 888479, Hand: KQJ932...AKJ8532 | (cansacrifice('C')) |  |  | 51 |
| 5D | Board: 279862, Hand: KQ8..QT74.AKJ873 | (cansacrifice('D')) |  |  | 52 |
| 5D | Board: 882697, Hand: .AK2.A9864.KQ865 | (cansacrifice('D')) |  |  | 69 |
| 5D | _(unnamed — the Requires expression is the definition)_ | (D_compgame) \| (preemptgame('D')) \| (diamondpoints >= 7 and diamonds >= 5 and diamondpoints <= 13) |  |  | 70 |
| 5S | _(unnamed — the Requires expression is the definition)_ | (cansacrifice('S')) |  |  | 67 |
| 5N* | GSForce | ((D >= 2) AND (CanAsk_D_GSF)) | T=D | GSForce | 115 |
| 6D | To Play | ((D >= 2) AND (CanBid6_D)) |  |  | 40 |
| 6D | Playing strength: one loser with a real solid suit or an agreed fit | ((D >= 2) AND ((realsolid('D') or trump('D')) and losers == 1)) | T=D |  | 45 |
| 6D | Slam: own playing strength -- our hand alone rates to take twelve tricks | ((D >= 2) AND (monsterslam('D'))) | T=D |  | 113 |
| 6N | To Play | (CanBid6NT) |  |  | 50 |
| 7D | Playing strength: no losers with a real solid suit or an agreed fit | ((D >= 2) AND ((realsolid('D') or trump('D')) and losers <= 0)) | T=D |  | 46 |
| 7D | Grand slam: own playing strength -- our hand alone rates to take thirteen tricks | ((D >= 2) AND (monstergrand('D'))) | T=D |  | 114 |
| 7N | To Play | (CanBid7NT) \| ((D >= 2) AND (CanBid7NT)) |  |  | 110 |
| X | _(unnamed — the Requires expression is the definition)_ | (penalty) |  |  | 10 |

#### `2D-4S`

| Call | Means | Requires | Post-condition | Convention | Pri |
|---|---|---|---|---|---|
| P | _(unnamed — the Requires expression is the definition)_ | (true) |  |  |  |
| 4N* | RKC | ((D >= 2) AND (CanAsk_D_RKC)) \| ((D >= 2) AND (diamondslam)) | T=D | RKC0314_D | 60 |
| 5D | Board: 882697, Hand: .AK2.A9864.KQ865 | (cansacrifice('D')) |  |  | 69 |
| 5D | _(unnamed — the Requires expression is the definition)_ | (D_compgame) \| (preemptgame('D')) \| (diamondpoints >= 7 and diamonds >= 5 and diamondpoints <= 13) |  |  | 70 |
| 5H | _(unnamed — the Requires expression is the definition)_ | (cansacrifice('H')) |  |  | 67 |
| 5N* | GSForce | ((D >= 2) AND (CanAsk_D_GSF)) | T=D | GSForce | 115 |
| 6D | To Play | ((D >= 2) AND (CanBid6_D)) |  |  | 40 |
| 6D | Playing strength: one loser with a real solid suit or an agreed fit | ((D >= 2) AND ((realsolid('D') or trump('D')) and losers == 1)) | T=D |  | 45 |
| 6D | Slam: own playing strength -- our hand alone rates to take twelve tricks | ((D >= 2) AND (monsterslam('D'))) | T=D |  | 113 |
| 6N | To Play | (CanBid6NT) |  |  | 50 |
| 7D | Playing strength: no losers with a real solid suit or an agreed fit | ((D >= 2) AND ((realsolid('D') or trump('D')) and losers <= 0)) | T=D |  | 46 |
| 7D | Grand slam: own playing strength -- our hand alone rates to take thirteen tricks | ((D >= 2) AND (monstergrand('D'))) | T=D |  | 114 |
| 7N | To Play | (CanBid7NT) \| ((D >= 2) AND (CanBid7NT)) |  |  | 110 |
| X | _(unnamed — the Requires expression is the definition)_ | (penalty) |  |  | 10 |

#### `2D-6C`

| Call | Means | Requires | Post-condition | Convention | Pri |
|---|---|---|---|---|---|
| P | Board: 845839 | (true) |  |  |  |

#### `2D-6H`

| Call | Means | Requires | Post-condition | Convention | Pri |
|---|---|---|---|---|---|
| P | Board: T842822 | (true) |  |  |  |

#### `2D-6S`

_Same rule set as `2D-6H` — the service returns an identical table for this position._

#### `2D-2N`

| Call | Means | Requires | Post-condition | Convention | Pri |
|---|---|---|---|---|---|
| P | _(unnamed — the Requires expression is the definition)_ | (true) |  |  |  |
| 3C | Hand: Q52.KJ8..KQJT652 (DominantSuit) | (StrongRebiddable('C') and not game) |  |  | 21 |
| 3D | _(unnamed — the Requires expression is the definition)_ | (competitive('D')) |  |  | 5 |
| 3D | Preemptive | (diamondpoints >= 7 and diamonds >= 3 and diamondpoints <= 10) |  |  | 66 |
| 3H | _(unnamed — the Requires expression is the definition)_ | (competitive('H')) | minhcp=10,maxhcp=14 |  | 1 |
| 3H | Board: 104656, Hand: AKJT962.KJ732..5 [MS=3a-loser-game(losers=3,ownTricks=10,game=4S,contract=2N)] | (twicerebiddable('H') and hcp >= 12) |  |  | 41 |
| 3H | Nat, forcing | (totalpoints >= 20 and H >= 6 and singlesuited) |  |  | 80 |
| 3S | _(unnamed — the Requires expression is the definition)_ | (competitive('S')) | minhcp=10,maxhcp=14 |  | 1 |
| 3S | Board: 104656, Hand: AKJT962.KJ732..5 [MS=3a-loser-game(losers=3,ownTricks=10,game=4S,contract=2N)] | (twicerebiddable('S') and hcp >= 12) |  |  | 41 |
| 3S | Nat, forcing | (totalpoints >= 20 and S >= 6 and singlesuited) |  |  | 80 |
| 3N | Nat | (hcp >= 18 and hcp<= 21) |  |  | 30 |
| 4D | Preemptive | (diamondpoints >= 7 and diamonds >= 4 and diamondpoints <= 11) |  |  | 68 |
| 4H | Hand: AKQT42.873.4.KQ4 (GameEval) | (H_game) |  |  | 54 |
| 4H | Nat | (hcp >= 17 and H >= 6 and singlesuited and not slammish ) |  |  | 75 |
| 4S | Hand: AKQT42.873.4.KQ4 (GameEval) | (S_game) |  |  | 54 |
| 4S | Nat | (hcp >= 17 and S >= 6 and singlesuited and not slammish ) |  |  | 75 |
| 4N* | RKC | ((D >= 2) AND (CanAsk_D_RKC)) \| ((D >= 2) AND (diamondslam)) | T=D | RKC0314_D | 60 |
| 5D | _(unnamed — the Requires expression is the definition)_ | (diamondpoints >= 7 and diamonds >= 6) \| (D_compgame) \| (preemptgame('D')) \| (diamondpoints >= 7 and diamonds >= 5 and diamondpoints <= 13) |  |  | 70 |
| 5N* | GSForce | ((D >= 2) AND (CanAsk_D_GSF)) | T=D | GSForce | 115 |
| 6D | To Play | ((D >= 2) AND (CanBid6_D)) |  |  | 40 |
| 6D | Playing strength: one loser with a real solid suit or an agreed fit | ((D >= 2) AND ((realsolid('D') or trump('D')) and losers == 1)) | T=D |  | 45 |
| 6D | Slam: own playing strength -- our hand alone rates to take twelve tricks | ((D >= 2) AND (monsterslam('D'))) | T=D |  | 113 |
| 6N | To Play | (CanBid6NT) |  |  | 50 |
| 7D | Playing strength: no losers with a real solid suit or an agreed fit | ((D >= 2) AND ((realsolid('D') or trump('D')) and losers <= 0)) | T=D |  | 46 |
| 7D | Grand slam: own playing strength -- our hand alone rates to take thirteen tricks | ((D >= 2) AND (monstergrand('D'))) | T=D |  | 114 |
| 7N | To Play | (CanBid7NT) \| ((D >= 2) AND (CanBid7NT)) |  |  | 110 |
| X | _(unnamed — the Requires expression is the definition)_ | (penalty) |  |  | 20 |

#### `2D-3N`

| Call | Means | Requires | Post-condition | Convention | Pri |
|---|---|---|---|---|---|
| P | _(unnamed — the Requires expression is the definition)_ | (true) |  |  |  |
| 4C | Hand: QJ9.K6.8.QJ87643 (Partscore) | (cansacrifice('C')) |  |  | 31 |
| 4D | Preemptive | (diamondpoints >= 7 and diamonds >= 4 and diamondpoints <= 11) |  |  | 68 |
| 4H | Nat | (hcp >= 17 and H >= 6 and singlesuited and not slammish ) |  |  | 75 |
| 4S | Nat | (hcp >= 17 and S >= 6 and singlesuited and not slammish ) |  |  | 75 |
| 4N* | RKC | ((D >= 2) AND (CanAsk_D_RKC)) \| ((D >= 2) AND (diamondslam)) | T=D | RKC0314_D | 60 |
| 5D | _(unnamed — the Requires expression is the definition)_ | (D_compgame) \| (preemptgame('D')) \| (diamondpoints >= 7 and diamonds >= 5 and diamondpoints <= 13) |  |  | 70 |
| 5N* | GSForce | ((D >= 2) AND (CanAsk_D_GSF)) | T=D | GSForce | 115 |
| 6D | To Play | ((D >= 2) AND (CanBid6_D)) |  |  | 40 |
| 6D | Playing strength: one loser with a real solid suit or an agreed fit | ((D >= 2) AND ((realsolid('D') or trump('D')) and losers == 1)) | T=D |  | 45 |
| 6D | Slam: own playing strength -- our hand alone rates to take twelve tricks | ((D >= 2) AND (monsterslam('D'))) | T=D |  | 113 |
| 6N | To Play | (CanBid6NT) |  |  | 50 |
| 7D | Playing strength: no losers with a real solid suit or an agreed fit | ((D >= 2) AND ((realsolid('D') or trump('D')) and losers <= 0)) | T=D |  | 46 |
| 7D | Grand slam: own playing strength -- our hand alone rates to take thirteen tricks | ((D >= 2) AND (monstergrand('D'))) | T=D |  | 114 |
| 7N | To Play | (CanBid7NT) \| ((D >= 2) AND (CanBid7NT)) |  |  | 110 |
| X | _(unnamed — the Requires expression is the definition)_ | (penalty) |  |  | 90 |

#### `2H-P`

| Call | Means | Requires | Post-condition | Convention | Pri |
|---|---|---|---|---|---|
| P | _(unnamed — the Requires expression is the definition)_ | (not game) |  |  |  |
| 2S | _(unnamed — the Requires expression is the definition)_ | (hcp >= 13 and spades >= 5 and spadelongest and H <= 1) | F1 |  | 68 |
| 2N* | FeatureAsk, 15+ hcp | (hcp >= 15) \| (hcp >= 13 and controls >= 5) |  | FeatureAskMajor | 60 |
| 3C | _(unnamed — the Requires expression is the definition)_ | (bestminor('C') and C >= 5 and hcp >= 17 ) |  |  | 22 |
| 3D | _(unnamed — the Requires expression is the definition)_ | (bestminor('D') and D >= 5 and hcp >= 17 ) |  |  | 22 |
| 3H | Preemptive | (H_points >= 6 and hcp <= 9 and H >= 3) \| (competitive('H')) | minhcp=6,maxhcp=11 |  | 40 |
| 3S | _(unnamed — the Requires expression is the definition)_ | (spadepoints >= 20 and spades >= 6 and singlesuited) | GF |  | 20 |
| 3N | Nat | (H <= 1 and hcp >= 18 and not slammish) |  |  | 30 |
| 4H | _(unnamed — the Requires expression is the definition)_ | (H_compgame) \| (preemptgame('H')) |  |  | 70 |
| 4H | Nat | (preemptgame('H') or covergame('H')) \| (H_compgame and H >= 3 and hcp <= 17) \| (hcp >= 12 and hcp <= 17 and H >= 3 and not slammish) \| (hcp >= 10 and hcp <= 17 and H >= 4 and not slammish) | minhcp=2,maxhcp=17 |  | 80 |
| 4S | _(unnamed — the Requires expression is the definition)_ | (twicerebiddable('S') and H <= 1 and not slammish and losers <= 4) \| (S_points >= 20 and S >= 6 and singlesuited and H <= 1 and not slammish) |  |  | 79 |
| 4N* | RKC | ((H >= 2) AND (CanAsk_H_RKC)) \| ((H >= 2) AND (H_slam)) | T=H | RKC0314_H | 120 |
| 5N* | GSForce | ((H >= 2) AND (CanAsk_H_GSF)) | T=H | GSForce | 175 |
| 6H | To Play | ((H >= 2) AND (CanBid6_H)) |  |  | 100 |
| 6H | Playing strength: one loser with a real solid suit or an agreed fit | ((H >= 2) AND ((realsolid('H') or trump('H')) and losers == 1)) | T=H |  | 105 |
| 6H | Slam: own playing strength -- our hand alone rates to take twelve tricks | ((H >= 2) AND (monsterslam('H'))) | T=H |  | 173 |
| 7H | Playing strength: no losers with a real solid suit or an agreed fit | ((H >= 2) AND ((realsolid('H') or trump('H')) and losers <= 0)) | T=H |  | 106 |
| 7H | Grand slam: own playing strength -- our hand alone rates to take thirteen tricks | ((H >= 2) AND (monstergrand('H'))) | T=H |  | 174 |
| 7N | To Play | ((H >= 2) AND (CanBid7NT)) |  |  | 170 |

#### `2H-X`

_Same rule set as `2H-P` — the service returns an identical table for this position._

#### `2H-2S`

| Call | Means | Requires | Post-condition | Convention | Pri |
|---|---|---|---|---|---|
| P | _(unnamed — the Requires expression is the definition)_ | (true) |  |  |  |
| 2N | Nat Inv | (hcp >= 16 and stopper('S') and hcp <= 19) |  |  | 10 |
| 3C | Board: 803008, Hand: A2.7.AKQJT93.J52 | (overcall('C')) |  |  | 21 |
| 3C | _(unnamed — the Requires expression is the definition)_ | (competitive('C')) |  |  | 24 |
| 3D | Board: 803008, Hand: A2.7.AKQJT93.J52 | (overcall('D')) |  |  | 21 |
| 3D | _(unnamed — the Requires expression is the definition)_ | (competitive('D')) |  |  | 24 |
| 3H | _(unnamed — the Requires expression is the definition)_ | (competitive('H')) \| (hcp >= 3 and hcp<= 11 and H <= 3) \| (hcp >= 7 and hcp<= 11 and H >= 2) | minhcp=7,maxhcp=11 |  | 25 |
| 3N | Nat | (H <= 1 and hcp>= 18 and stopper('S') and not slammish) \| (H <= 1 and solid('C') and stopper('S') and not slammish) \| (H <= 1 and solid('D') and stopper('S') and not slammish) | minhcp=14,maxhcp=22 |  | 34 |
| 4H | Nat | (hcp >= 12 and H >= 3) \| (H_game) \| (S_game) \| (preemptive('H')) \| (cansacrifice('H', false)) |  |  | 43 |
| 4H | _(unnamed — the Requires expression is the definition)_ | (H_compgame) \| (preemptgame('H')) |  |  | 70 |
| 4N* | RKC | ((H >= 2) AND (CanAsk_H_RKC)) \| ((H >= 2) AND (heartslam)) | T=H | RKC0314_H | 70 |
| 5C | Hand: T.Q.KQT.AKQJ9632 (GameEval) | (C_game) |  |  | 51 |
| 5D | Hand: T.Q.KQT.AKQJ9632 (GameEval) | (D_game) |  |  | 51 |
| 5N* | GSForce | ((H >= 2) AND (CanAsk_H_GSF)) | T=H | GSForce | 125 |
| 6H | To Play | ((H >= 2) AND (CanBid6_H)) |  |  | 50 |
| 6H | Playing strength: one loser with a real solid suit or an agreed fit | ((H >= 2) AND ((realsolid('H') or trump('H')) and losers == 1)) | T=H |  | 55 |
| 6H | Slam: own playing strength -- our hand alone rates to take twelve tricks | ((H >= 2) AND (monsterslam('H'))) | T=H |  | 123 |
| 7H | Playing strength: no losers with a real solid suit or an agreed fit | ((H >= 2) AND ((realsolid('H') or trump('H')) and losers <= 0)) | T=H |  | 56 |
| 7H | Grand slam: own playing strength -- our hand alone rates to take thirteen tricks | ((H >= 2) AND (monstergrand('H'))) | T=H |  | 124 |
| 7N | To Play | ((H >= 2) AND (CanBid7NT)) |  |  | 120 |
| X | Hand: AK932.43.8743.AT (PenaltyDouble) | (penalty) |  |  | 90 |

#### `2H-3C`

| Call | Means | Requires | Post-condition | Convention | Pri |
|---|---|---|---|---|---|
| P | _(unnamed — the Requires expression is the definition)_ | (true) |  |  |  |
| 3D | Board: 786012, Hand: KQ973.2.AQJ6432. | (overcall('D')) |  |  | 9 |
| 3H | Board: 1176, Hand: AK63.Q54.T9.Q732 | (competitive('H')) |  |  | 11 |
| 3H | Preemptive | (hcp >= 3 and hcp<= 9 and H >= 2 and H <= 4) |  |  | 12 |
| 3S | Nat | (hcp >= 15 and S >= 5) |  |  | 10 |
| 3N | Nat | (H <= 1 and hcp>= 18 and not slammish and stopper('D')) |  |  | 40 |
| 4D | Board: 259605, Hand: 9.KJ83..AQJ98653 | (fourlevelovercall('C')) |  |  | 29 |
| 4H | Nat | (hcp >= 14 and H >= 2) \| (hcp >= 12 and H >= 3) \| (hcp >= 10 and H >= 4 and not slammish) \| (preemptgame('H')) |  |  | 30 |
| 4H | Board: 387307, Hand: A65.AK9843.8542. [MS=4-undisclosed-fit-game(target=4S,myLen=3,partnerShown=6)] | (preemptgame('H') or covergame('H') or H_compgame) |  |  | 61 |
| 4H | _(unnamed — the Requires expression is the definition)_ | (H_compgame) \| (preemptgame('H')) |  |  | 70 |
| 4S | Board: 321449, Hand: KQ9876432..8.KT7 | (S_compgame and rebiddable('S')) |  |  | 53 |
| 4N* | RKC | (CanAsk_H_RKC) \| (H_slam) | T=H | RKC0314_H | 80 |
| 5D | Board: 786012, Hand: KQ973.2.AQJ6432. | (D_compgame) |  |  | 19 |
| 5N* | GSForce | (CanAsk_H_GSF) | T=H | GSForce | 135 |
| 6H | To Play | (CanBid6_H) |  |  | 60 |
| 6H | Playing strength: one loser with a real solid suit or an agreed fit | ((realsolid('H') or trump('H')) and losers == 1) | T=H |  | 65 |
| 6H | Slam: own playing strength -- our hand alone rates to take twelve tricks | (monsterslam('H')) | T=H |  | 133 |
| 7H | Playing strength: no losers with a real solid suit or an agreed fit | ((realsolid('H') or trump('H')) and losers <= 0) | T=H |  | 66 |
| 7H | Grand slam: own playing strength -- our hand alone rates to take thirteen tricks | (monstergrand('H')) | T=H |  | 134 |
| 7N | To Play | (CanBid7NT) |  |  | 130 |
| X | _(unnamed — the Requires expression is the definition)_ | (penalty) |  |  | 5 |

#### `2H-3D`

| Call | Means | Requires | Post-condition | Convention | Pri |
|---|---|---|---|---|---|
| P | _(unnamed — the Requires expression is the definition)_ | (true) |  |  |  |
| 3H | Board: 1176, Hand: AK63.Q54.T9.Q732 | (competitive('H')) |  |  | 11 |
| 3H | Preemptive | (hcp >= 3 and hcp<= 9 and H >= 2 and H <= 4) |  |  | 12 |
| 3S | Nat | (hcp >= 15 and S >= 5) |  |  | 10 |
| 3N | Nat | (H <= 1 and hcp>= 18 and not slammish and stopper('D')) |  |  | 40 |
| 4C | Board: 259605, Hand: 9.KJ83..AQJ98653 | (fourlevelovercall('C')) |  |  | 29 |
| 4H | Nat | (hcp >= 14 and H >= 2) \| (hcp >= 12 and H >= 3) \| (hcp >= 10 and H >= 4 and not slammish) \| (preemptgame('H')) |  |  | 30 |
| 4H | Board: 387307, Hand: A65.AK9843.8542. [MS=4-undisclosed-fit-game(target=4S,myLen=3,partnerShown=6)] | (preemptgame('H') or covergame('H') or H_compgame) |  |  | 61 |
| 4S | Board: 321449, Hand: KQ9876432..8.KT7 | (S_compgame and rebiddable('S')) |  |  | 53 |
| 4N* | RKC | (CanAsk_H_RKC) \| (H_slam) | T=H | RKC0314_H | 80 |
| 5N* | GSForce | (CanAsk_H_GSF) | T=H | GSForce | 135 |
| 6H | To Play | (CanBid6_H) |  |  | 60 |
| 6H | Playing strength: one loser with a real solid suit or an agreed fit | ((realsolid('H') or trump('H')) and losers == 1) | T=H |  | 65 |
| 6H | Slam: own playing strength -- our hand alone rates to take twelve tricks | (monsterslam('H')) | T=H |  | 133 |
| 7H | Playing strength: no losers with a real solid suit or an agreed fit | ((realsolid('H') or trump('H')) and losers <= 0) | T=H |  | 66 |
| 7H | Grand slam: own playing strength -- our hand alone rates to take thirteen tricks | (monstergrand('H')) | T=H |  | 134 |
| 7N | To Play | (CanBid7NT) |  |  | 130 |
| X | _(unnamed — the Requires expression is the definition)_ | (penalty) |  |  | 5 |

#### `2H-3H`

| Call | Means | Requires | Post-condition | Convention | Pri |
|---|---|---|---|---|---|
| P | _(unnamed — the Requires expression is the definition)_ | (not game) |  | MichaelsCuebid2XDefence |  |
| 3N | Hand: K8.K8.KQ642.AKJ9 (GameEval) | (game and stoppersOK) |  | MichaelsCuebid2XDefence | 55 |
| 4H | _(unnamed — the Requires expression is the definition)_ | (H >= 3 and hcp >= 14) \| (H_compgame) \| (preemptgame('H')) |  | MichaelsCuebid2XDefence | 70 |
| 4N* | RKC | ((H >= 2) AND (CanAsk_D_RKC)) \| ((H >= 2) AND (diamondslam)) | T=D | RKC0314_D | 80 |
| 5N* | GSForce | ((H >= 2) AND (CanAsk_D_GSF)) | T=D | GSForce | 135 |
| 6D | To Play | ((H >= 2) AND (CanBid6_D)) |  | MichaelsCuebid2XDefence | 60 |
| 6D | Playing strength: one loser with a real solid suit or an agreed fit | ((H >= 2) AND ((realsolid('D') or trump('D')) and losers == 1)) | T=D | MichaelsCuebid2XDefence | 65 |
| 6D | Slam: own playing strength -- our hand alone rates to take twelve tricks | ((H >= 2) AND (monsterslam('D'))) | T=D | MichaelsCuebid2XDefence | 133 |
| 7D | Playing strength: no losers with a real solid suit or an agreed fit | ((H >= 2) AND ((realsolid('D') or trump('D')) and losers <= 0)) | T=D | MichaelsCuebid2XDefence | 66 |
| 7D | Grand slam: own playing strength -- our hand alone rates to take thirteen tricks | ((H >= 2) AND (monstergrand('D'))) | T=D | MichaelsCuebid2XDefence | 134 |
| 7N | To Play | ((H >= 2) AND (CanBid7NT)) |  | MichaelsCuebid2XDefence | 130 |

#### `2H-3S`

| Call | Means | Requires | Post-condition | Convention | Pri |
|---|---|---|---|---|---|
| P | _(unnamed — the Requires expression is the definition)_ | (true) |  |  |  |
| 4C | Board: 156871, Hand: J7.T8.6.AKQJ8732 | (fourlevelovercall('C')) |  |  | 31 |
| 4D | Board: 156871, Hand: J7.T8.6.AKQJ8732 | (fourlevelovercall('D')) |  |  | 31 |
| 4H | _(unnamed — the Requires expression is the definition)_ | (H >= 4 and hcp >= 6) \| (H_compgame) \| (preemptgame('H')) |  |  | 70 |
| X | Board: T651381, Hand: AQJT5.Q.J42.A752 | (penalty) |  |  | 90 |

#### `2H-4C`

| Call | Means | Requires | Post-condition | Convention | Pri |
|---|---|---|---|---|---|
| P | _(unnamed — the Requires expression is the definition)_ | (true) |  |  |  |
| 4H | _(unnamed — the Requires expression is the definition)_ | (H >= 4 and hcp >= 6) \| (H_compgame) \| (preemptgame('H')) |  |  | 70 |

#### `2H-4D`

_Same rule set as `2H-4C` — the service returns an identical table for this position._

#### `2H-4H`

| Call | Means | Requires | Post-condition | Convention | Pri |
|---|---|---|---|---|---|
| P | _(unnamed — the Requires expression is the definition)_ | (true) |  | MichaelsCuebid2XDefence |  |

#### `2H-4S`

| Call | Means | Requires | Post-condition | Convention | Pri |
|---|---|---|---|---|---|
| P | _(unnamed — the Requires expression is the definition)_ | (makessense) |  |  | 30 |
| 4N* | RKC | ((H >= 2) AND (CanAsk_H_RKC)) \| ((H >= 2) AND (heartslam)) | T=H | RKC0314_H | 80 |
| 5C | _(unnamed — the Requires expression is the definition)_ | (cansacrifice('C')) |  |  |  |
| 5D | _(unnamed — the Requires expression is the definition)_ | (cansacrifice('D')) |  |  |  |
| 5H | _(unnamed — the Requires expression is the definition)_ | (cansacrifice('H')) |  |  | 20 |
| 5N* | GSForce | ((H >= 2) AND (CanAsk_H_GSF)) | T=H | GSForce | 135 |
| 6H | To Play | ((H >= 2) AND (CanBid6_H)) |  |  | 60 |
| 6H | Playing strength: one loser with a real solid suit or an agreed fit | ((H >= 2) AND ((realsolid('H') or trump('H')) and losers == 1)) | T=H |  | 65 |
| 6H | Slam: own playing strength -- our hand alone rates to take twelve tricks | ((H >= 2) AND (monsterslam('H'))) | T=H |  | 133 |
| 7H | Playing strength: no losers with a real solid suit or an agreed fit | ((H >= 2) AND ((realsolid('H') or trump('H')) and losers <= 0)) | T=H |  | 66 |
| 7H | Grand slam: own playing strength -- our hand alone rates to take thirteen tricks | ((H >= 2) AND (monstergrand('H'))) | T=H |  | 134 |
| 7N | To Play | ((H >= 2) AND (CanBid7NT)) |  |  | 130 |
| X | _(unnamed — the Requires expression is the definition)_ | (penalty) |  |  | 10 |

#### `2H-6C`

| Call | Means | Requires | Post-condition | Convention | Pri |
|---|---|---|---|---|---|
| P | Board: 58436 | (true) |  |  |  |

#### `2H-6D`

_Same rule set as `2H-6C` — the service returns an identical table for this position._

#### `2H-6S`

| Call | Means | Requires | Post-condition | Convention | Pri |
|---|---|---|---|---|---|
| P | Board: 572905 | (true) |  |  |  |

#### `2H-7C`

| Call | Means | Requires | Post-condition | Convention | Pri |
|---|---|---|---|---|---|
| P | Board: T158849 | (true) |  |  |  |

#### `2H-7D`

_Same rule set as `2H-7C` — the service returns an identical table for this position._

#### `2H-2N`

| Call | Means | Requires | Post-condition | Convention | Pri |
|---|---|---|---|---|---|
| P | _(unnamed — the Requires expression is the definition)_ | (true) \| (H_game and H >= 2) |  |  | 20 |
| 3C | Hand: T.A42.4.AJT76542 (Partscore) | (competitive('C')) |  |  | 22 |
| 3D | Hand: T.A42.4.AJT76542 (Partscore) | (competitive('D')) |  |  | 22 |
| 3H | _(unnamed — the Requires expression is the definition)_ | (competitive('H')) |  |  | 15 |
| 3S | _(unnamed — the Requires expression is the definition)_ | (competitive('S')) |  |  | 10 |
| 3N | _(unnamed — the Requires expression is the definition)_ | (game and stoppersOK) |  |  | 55 |
| 4H | _(unnamed — the Requires expression is the definition)_ | (H_compgame) \| (preemptgame('H')) |  |  | 70 |
| 4S | Hand: 6.AQJT8743.KQJ2. (GameEval) | (S_game) |  |  | 53 |
| 5C | Hand: A.T.AQJT.AQT8653 (GameEval) | (TwiceRebiddable('C') and Hcp >= 17) |  |  | 51 |
| 5D | Hand: A.T.AQJT.AQT8653 (GameEval) | (TwiceRebiddable('D') and Hcp >= 17) |  |  | 51 |
| X | _(unnamed — the Requires expression is the definition)_ | (penalty) |  |  | 90 |

#### `2H-3N`

| Call | Means | Requires | Post-condition | Convention | Pri |
|---|---|---|---|---|---|
| P | _(unnamed — the Requires expression is the definition)_ | (true) |  |  |  |
| 4C | Hand: .J74.AQ2.K765432 (Partscore) | (cansacrifice('C')) |  |  | 31 |
| 4D | Hand: .J74.AQ2.K765432 (Partscore) | (cansacrifice('D')) |  |  | 31 |
| 4H | _(unnamed — the Requires expression is the definition)_ | (cansacrifice('H')) \| (H_compgame) \| (preemptgame('H')) |  |  | 70 |
| 4S | Board: 711040, Hand: KQJ654.6.Q.AT643 | (fourlevelovercall('S')) |  |  | 53 |
| X | _(unnamed — the Requires expression is the definition)_ | (penalty) |  |  | 20 |

#### `2H-4N`

| Call | Means | Requires | Post-condition | Convention | Pri |
|---|---|---|---|---|---|
| P | _(unnamed — the Requires expression is the definition)_ | (true) |  | UnusualNT2XDefence |  |
| 5H | Board: 687993, Hand: A8.AKQ986.5.T952 [MS=4-sacrifice(Hearts)] | (cansacrifice('H')) \| (H_compgame) |  | UnusualNT2XDefence | 47 |
| 5S | Board: 476469, Hand: AKQJ9862.75.K6.A [MS=E2b-game-overcall(Spades)] | (cansacrifice('S')) \| (S_compgame) \| (twicerebiddable('S') and losers <= 2) |  | UnusualNT2XDefence | 45 |

#### `2S-P`

| Call | Means | Requires | Post-condition | Convention | Pri |
|---|---|---|---|---|---|
| P | _(unnamed — the Requires expression is the definition)_ | (not game) |  |  |  |
| 2N* | FeatureAsk, 15+ hcp | (hcp >= 15) \| (hcp >= 13 and controls >= 5) |  | FeatureAskMajor | 60 |
| 3C | _(unnamed — the Requires expression is the definition)_ | (bestminor('C') and C >= 5 and hcp >= 17 ) |  |  | 22 |
| 3D | _(unnamed — the Requires expression is the definition)_ | (bestminor('D') and D >= 5 and hcp >= 17 ) |  |  | 22 |
| 3H | _(unnamed — the Requires expression is the definition)_ | (hcp >= 17 and hearts >= 6) | F1 |  | 69 |
| 3S | Preemptive | (S_points >= 6 and hcp <= 9 and S >= 3) \| (competitive('S')) | minhcp=6,maxhcp=11 |  | 40 |
| 3N | Nat | (S <= 1 and hcp >= 18 and not slammish) |  |  | 30 |
| 4H | _(unnamed — the Requires expression is the definition)_ | (twicerebiddable('H') and S <= 1 and not slammish and losers <= 4) \| (H_points >= 20 and H >= 6 and singlesuited and S <= 1 and not slammish) |  |  | 79 |
| 4S | _(unnamed — the Requires expression is the definition)_ | (S_compgame) \| (preemptgame('S')) |  |  | 70 |
| 4S | Nat | (preemptgame('S') or covergame('S')) \| (S_compgame and S >= 3 and hcp <= 17) \| (hcp >= 12 and hcp <= 17 and S >= 3 and not slammish) \| (hcp >= 10 and hcp <= 17 and S >= 4 and not slammish) | minhcp=2,maxhcp=17 |  | 80 |
| 4N* | RKC | ((S >= 2) AND (CanAsk_S_RKC)) \| ((S >= 2) AND (S_slam)) | T=S | RKC0314_S | 120 |
| 5N* | GSForce | ((S >= 2) AND (CanAsk_S_GSF)) | T=S | GSForce | 175 |
| 6S | To Play | ((S >= 2) AND (CanBid6_S)) |  |  | 100 |
| 6S | Playing strength: one loser with a real solid suit or an agreed fit | ((S >= 2) AND ((realsolid('S') or trump('S')) and losers == 1)) | T=S |  | 105 |
| 6S | Slam: own playing strength -- our hand alone rates to take twelve tricks | ((S >= 2) AND (monsterslam('S'))) | T=S |  | 173 |
| 7S | Playing strength: no losers with a real solid suit or an agreed fit | ((S >= 2) AND ((realsolid('S') or trump('S')) and losers <= 0)) | T=S |  | 106 |
| 7S | Grand slam: own playing strength -- our hand alone rates to take thirteen tricks | ((S >= 2) AND (monstergrand('S'))) | T=S |  | 174 |
| 7N | To Play | ((S >= 2) AND (CanBid7NT)) |  |  | 170 |

#### `2S-X`

_Same rule set as `2S-P` — the service returns an identical table for this position._

#### `2S-3C`

| Call | Means | Requires | Post-condition | Convention | Pri |
|---|---|---|---|---|---|
| P | _(unnamed — the Requires expression is the definition)_ | (true) |  |  |  |
| 3D | Board: 786012, Hand: KQ973.2.AQJ6432. | (overcall('D')) |  |  | 9 |
| 3H | Nat | (hcp >= 15 and H >= 5) |  |  | 10 |
| 3S | Board: 1176, Hand: AK63.Q54.T9.Q732 | (competitive('S')) |  |  | 11 |
| 3S | Preemptive | (hcp >= 3 and hcp<= 9 and S >= 2 and S <= 4) |  |  | 12 |
| 3N | Nat | (S <= 1 and hcp>= 18 and not slammish and stopper('D')) |  |  | 40 |
| 4D | Board: 259605, Hand: 9.KJ83..AQJ98653 | (fourlevelovercall('C')) |  |  | 29 |
| 4H | Board: 321449, Hand: KQ9876432..8.KT7 | (H_compgame and rebiddable('H')) |  |  | 53 |
| 4S | Nat | (hcp >= 14 and S >= 2) \| (hcp >= 12 and S >= 3) \| (hcp >= 10 and S >= 4 and not slammish) \| (preemptgame('S')) |  |  | 30 |
| 4S | Board: 387307, Hand: A65.AK9843.8542. [MS=4-undisclosed-fit-game(target=4S,myLen=3,partnerShown=6)] | (preemptgame('S') or covergame('S') or S_compgame) |  |  | 61 |
| 4S | _(unnamed — the Requires expression is the definition)_ | (S_compgame) \| (preemptgame('S')) |  |  | 70 |
| 4N* | RKC | (CanAsk_S_RKC) \| (S_slam) | T=S | RKC0314_S | 80 |
| 5D | Board: 786012, Hand: KQ973.2.AQJ6432. | (D_compgame) |  |  | 19 |
| 5N* | GSForce | (CanAsk_S_GSF) | T=S | GSForce | 135 |
| 6S | To Play | (CanBid6_S) |  |  | 60 |
| 6S | Playing strength: one loser with a real solid suit or an agreed fit | ((realsolid('S') or trump('S')) and losers == 1) | T=S |  | 65 |
| 6S | Slam: own playing strength -- our hand alone rates to take twelve tricks | (monsterslam('S')) | T=S |  | 133 |
| 7S | Playing strength: no losers with a real solid suit or an agreed fit | ((realsolid('S') or trump('S')) and losers <= 0) | T=S |  | 66 |
| 7S | Grand slam: own playing strength -- our hand alone rates to take thirteen tricks | (monstergrand('S')) | T=S |  | 134 |
| 7N | To Play | (CanBid7NT) |  |  | 130 |
| X | _(unnamed — the Requires expression is the definition)_ | (penalty) |  |  | 5 |

#### `2S-3D`

| Call | Means | Requires | Post-condition | Convention | Pri |
|---|---|---|---|---|---|
| P | _(unnamed — the Requires expression is the definition)_ | (true) |  |  |  |
| 3H | Nat | (hcp >= 15 and H >= 5) |  |  | 10 |
| 3S | Board: 1176, Hand: AK63.Q54.T9.Q732 | (competitive('S')) |  |  | 11 |
| 3S | Preemptive | (hcp >= 3 and hcp<= 9 and S >= 2 and S <= 4) |  |  | 12 |
| 3N | Nat | (S <= 1 and hcp>= 18 and not slammish and stopper('D')) |  |  | 40 |
| 4C | Board: 259605, Hand: 9.KJ83..AQJ98653 | (fourlevelovercall('C')) |  |  | 29 |
| 4H | Board: 321449, Hand: KQ9876432..8.KT7 | (H_compgame and rebiddable('H')) |  |  | 53 |
| 4S | Nat | (hcp >= 14 and S >= 2) \| (hcp >= 12 and S >= 3) \| (hcp >= 10 and S >= 4 and not slammish) \| (preemptgame('S')) |  |  | 30 |
| 4S | Board: 387307, Hand: A65.AK9843.8542. [MS=4-undisclosed-fit-game(target=4S,myLen=3,partnerShown=6)] | (preemptgame('S') or covergame('S') or S_compgame) |  |  | 61 |
| 4N* | RKC | (CanAsk_S_RKC) \| (S_slam) | T=S | RKC0314_S | 80 |
| 5N* | GSForce | (CanAsk_S_GSF) | T=S | GSForce | 135 |
| 6S | To Play | (CanBid6_S) |  |  | 60 |
| 6S | Playing strength: one loser with a real solid suit or an agreed fit | ((realsolid('S') or trump('S')) and losers == 1) | T=S |  | 65 |
| 6S | Slam: own playing strength -- our hand alone rates to take twelve tricks | (monsterslam('S')) | T=S |  | 133 |
| 7S | Playing strength: no losers with a real solid suit or an agreed fit | ((realsolid('S') or trump('S')) and losers <= 0) | T=S |  | 66 |
| 7S | Grand slam: own playing strength -- our hand alone rates to take thirteen tricks | (monstergrand('S')) | T=S |  | 134 |
| 7N | To Play | (CanBid7NT) |  |  | 130 |
| X | _(unnamed — the Requires expression is the definition)_ | (penalty) |  |  | 5 |

#### `2S-3H`

| Call | Means | Requires | Post-condition | Convention | Pri |
|---|---|---|---|---|---|
| P | _(unnamed — the Requires expression is the definition)_ | (true) |  |  |  |
| 3S | Board: 704218, Hand: Q943.T96.94.AK84 | (competitive('S')) |  |  | 4 |
| 3S | competitive | (hcp >= 3 and hcp<= 9 and S >= 2 and S <= 3) \| (hcp >= 3 and hcp<= 12 and S >= 2 and S <= 3) |  |  | 40 |
| 3N | Nat | (S <= 1 and hcp>= 18 and not slammish and stopper('H')) |  |  | 15 |
| 4C | Board: 636914, Hand: 4.A4.AKQ9542.T64 | (fourlevelovercall('C')) |  |  | 29 |
| 4C | Board: 603327, Hand: 6.A.AT954.AKT872 | (twicerebiddable('C') and losers <= 3) | minhcp=14 |  | 31 |
| 4D | Board: 636914, Hand: 4.A4.AKQ9542.T64 | (fourlevelovercall('D')) |  |  | 29 |
| 4D | Board: 603327, Hand: 6.A.AT954.AKT872 | (twicerebiddable('D') and losers <= 3) | minhcp=14 |  | 31 |
| 4H* | Nat | (S >= 2 and hcp >= 18) | T=S, F1 |  | 43 |
| 4S | Board: 27409, Hand: QT873.Q.QJT6.Q74 | (preemptgame('S')) |  |  | 19 |
| 4S | Nat | (hcp >= 10 and S >= 4 and not slammish) \| (S >= 2 and hcp >= 13) |  |  | 30 |
| 4S | Board: 856894, Hand: A8754.7.76.KQ865 [MS=4-undisclosed-fit-game(target=4S,myLen=5,partnerShown=6)] | (preemptgame('S') or covergame('S') or S_compgame) |  |  | 51 |
| 4N* | RKC | (CanAsk_S_RKC) \| (spadeslam) | T=S | RKC0314_S | 70 |
| 5N* | GSForce | (CanAsk_S_GSF) | T=S | GSForce | 125 |
| 6S | To Play | (CanBid6_S) |  |  | 50 |
| 6S | Playing strength: one loser with a real solid suit or an agreed fit | ((realsolid('S') or trump('S')) and losers == 1) | T=S |  | 55 |
| 6S | Slam: own playing strength -- our hand alone rates to take twelve tricks | (monsterslam('S')) | T=S |  | 123 |
| 7S | Playing strength: no losers with a real solid suit or an agreed fit | ((realsolid('S') or trump('S')) and losers <= 0) | T=S |  | 56 |
| 7S | Grand slam: own playing strength -- our hand alone rates to take thirteen tricks | (monstergrand('S')) | T=S |  | 124 |
| 7N | To Play | (CanBid7NT) |  |  | 120 |
| X | Board: 541513, Hand: 7.KQ62.AKJ53.KJ4 | (penalty) |  |  | 90 |

#### `2S-3S`

| Call | Means | Requires | Post-condition | Convention | Pri |
|---|---|---|---|---|---|
| P | _(unnamed — the Requires expression is the definition)_ | (not game) |  | MichaelsCuebid2XDefence |  |
| 3N | Hand: K8.K8.KQ642.AKJ9 (GameEval) | (game and stoppersOK) |  | MichaelsCuebid2XDefence | 55 |
| 4S | _(unnamed — the Requires expression is the definition)_ | (S >= 3 and hcp >= 14) \| (S_compgame) \| (preemptgame('S')) |  | MichaelsCuebid2XDefence | 70 |
| 4N* | RKC | ((S >= 2) AND (CanAsk_D_RKC)) \| ((S >= 2) AND (diamondslam)) | T=D | RKC0314_D | 80 |
| 5N* | GSForce | ((S >= 2) AND (CanAsk_D_GSF)) | T=D | GSForce | 135 |
| 6D | To Play | ((S >= 2) AND (CanBid6_D)) |  | MichaelsCuebid2XDefence | 60 |
| 6D | Playing strength: one loser with a real solid suit or an agreed fit | ((S >= 2) AND ((realsolid('D') or trump('D')) and losers == 1)) | T=D | MichaelsCuebid2XDefence | 65 |
| 6D | Slam: own playing strength -- our hand alone rates to take twelve tricks | ((S >= 2) AND (monsterslam('D'))) | T=D | MichaelsCuebid2XDefence | 133 |
| 7D | Playing strength: no losers with a real solid suit or an agreed fit | ((S >= 2) AND ((realsolid('D') or trump('D')) and losers <= 0)) | T=D | MichaelsCuebid2XDefence | 66 |
| 7D | Grand slam: own playing strength -- our hand alone rates to take thirteen tricks | ((S >= 2) AND (monstergrand('D'))) | T=D | MichaelsCuebid2XDefence | 134 |
| 7N | To Play | ((S >= 2) AND (CanBid7NT)) |  | MichaelsCuebid2XDefence | 130 |

#### `2S-4C`

| Call | Means | Requires | Post-condition | Convention | Pri |
|---|---|---|---|---|---|
| P | _(unnamed — the Requires expression is the definition)_ | (true) |  |  |  |
| 4S | _(unnamed — the Requires expression is the definition)_ | (S >= 4 and hcp >= 6) \| (S_compgame) \| (preemptgame('S')) |  |  | 70 |

#### `2S-4D`

_Same rule set as `2S-4C` — the service returns an identical table for this position._

#### `2S-4H`

| Call | Means | Requires | Post-condition | Convention | Pri |
|---|---|---|---|---|---|
| P | _(unnamed — the Requires expression is the definition)_ | (true) |  |  |  |
| 4S | Board: 691899, Hand: 96542.K9654.84.9 | (cansacrifice('S')) |  |  | 19 |
| 4S | Nat | (hcp >= 8 and S >= 4 and not slammish) \| (S >= 2 and hcp >= 13) |  |  | 30 |
| 4S | _(unnamed — the Requires expression is the definition)_ | (S_compgame) \| (preemptgame('S')) |  |  | 70 |
| 4N* | RKC | (CanAsk_S_RKC) \| (spadeslam) | T=S | RKC0314_S | 70 |
| 5C | Nat | (cansacrifice('C')) |  |  | 15 |
| 5D | Nat | (cansacrifice('D')) |  |  | 15 |
| 5N* | GSForce | (CanAsk_S_GSF) | T=S | GSForce | 125 |
| 6S | To Play | (CanBid6_S) |  |  | 50 |
| 6S | Playing strength: one loser with a real solid suit or an agreed fit | ((realsolid('S') or trump('S')) and losers == 1) | T=S |  | 55 |
| 6S | Slam: own playing strength -- our hand alone rates to take twelve tricks | (monsterslam('S')) | T=S |  | 123 |
| 7S | Playing strength: no losers with a real solid suit or an agreed fit | ((realsolid('S') or trump('S')) and losers <= 0) | T=S |  | 56 |
| 7S | Grand slam: own playing strength -- our hand alone rates to take thirteen tricks | (monstergrand('S')) | T=S |  | 124 |
| 7N | To Play | (CanBid7NT) |  |  | 120 |
| X | Hand: K.6.AKJ9864.AK75 (PenaltyDouble) | (penalty) |  |  | 90 |

#### `2S-4S`

_Same rule set as `2H-4H` — the service returns an identical table for this position._

#### `2S-6C`

_Same rule set as `2H-6C` — the service returns an identical table for this position._

#### `2S-6D`

_Same rule set as `2H-6C` — the service returns an identical table for this position._

#### `2S-6H`

_Same rule set as `2H-6S` — the service returns an identical table for this position._

#### `2S-7C`

_Same rule set as `2H-7C` — the service returns an identical table for this position._

#### `2S-7D`

_Same rule set as `2H-7C` — the service returns an identical table for this position._

#### `2S-2N`

| Call | Means | Requires | Post-condition | Convention | Pri |
|---|---|---|---|---|---|
| P | _(unnamed — the Requires expression is the definition)_ | (true) \| (S_game and S >= 2) |  |  | 20 |
| 3C | Hand: T.A42.4.AJT76542 (Partscore) | (competitive('C')) |  |  | 22 |
| 3D | Hand: T.A42.4.AJT76542 (Partscore) | (competitive('D')) |  |  | 22 |
| 3H | _(unnamed — the Requires expression is the definition)_ | (competitive('H')) |  |  | 10 |
| 3S | _(unnamed — the Requires expression is the definition)_ | (competitive('S')) |  |  | 15 |
| 3N | _(unnamed — the Requires expression is the definition)_ | (game and stoppersOK) |  |  | 55 |
| 4H | Hand: 6.AQJT8743.KQJ2. (GameEval) | (H_game) |  |  | 53 |
| 4S | _(unnamed — the Requires expression is the definition)_ | (S_compgame) \| (preemptgame('S')) |  |  | 70 |
| 5C | Hand: A.T.AQJT.AQT8653 (GameEval) | (TwiceRebiddable('C') and Hcp >= 17) |  |  | 51 |
| 5D | Hand: A.T.AQJT.AQT8653 (GameEval) | (TwiceRebiddable('D') and Hcp >= 17) |  |  | 51 |
| X | _(unnamed — the Requires expression is the definition)_ | (penalty) |  |  | 90 |

#### `2S-3N`

| Call | Means | Requires | Post-condition | Convention | Pri |
|---|---|---|---|---|---|
| P | _(unnamed — the Requires expression is the definition)_ | (true) |  |  |  |
| 4C | Hand: .J74.AQ2.K765432 (Partscore) | (cansacrifice('C')) |  |  | 31 |
| 4D | Hand: .J74.AQ2.K765432 (Partscore) | (cansacrifice('D')) |  |  | 31 |
| 4H | Board: 711040, Hand: KQJ654.6.Q.AT643 | (fourlevelovercall('H')) |  |  | 53 |
| 4S | _(unnamed — the Requires expression is the definition)_ | (cansacrifice('S')) \| (S_compgame) \| (preemptgame('S')) |  |  | 70 |
| X | _(unnamed — the Requires expression is the definition)_ | (penalty) |  |  | 20 |

#### `2S-4N`

| Call | Means | Requires | Post-condition | Convention | Pri |
|---|---|---|---|---|---|
| P | _(unnamed — the Requires expression is the definition)_ | (true) |  | UnusualNT2XDefence |  |
| 5H | Board: 476469, Hand: AKQJ9862.75.K6.A [MS=E2b-game-overcall(Spades)] | (cansacrifice('H')) \| (H_compgame) \| (twicerebiddable('H') and losers <= 2) |  | UnusualNT2XDefence | 45 |
| 5S | Board: 687993, Hand: A8.AKQ986.5.T952 [MS=4-sacrifice(Hearts)] | (cansacrifice('S')) \| (S_compgame) |  | UnusualNT2XDefence | 47 |

#### `3C-P`

| Call | Means | Requires | Post-condition | Convention | Pri |
|---|---|---|---|---|---|
| P | Pass preempt | (true) |  |  |  |
| 3D | Board: T176035, Hand: 7.KQT42.AKQT854. [MS=3a-loser-game(losers=2,ownTricks=11,game=5D,contract=3C)] | (twicerebiddable('D') and hcp >= 12) |  |  | 24 |
| 3D | _(unnamed — the Requires expression is the definition)_ | (twicerebiddable('D') and hcp >= 16) | F1 |  | 25 |
| 3H | _(unnamed — the Requires expression is the definition)_ | (twicerebiddable('H') and hcp >= 12 and bestmajor('H')) \| (rebiddable('H') and bestmajor('H') and hcp >= 15) | F1 |  | 36 |
| 3S | _(unnamed — the Requires expression is the definition)_ | (twicerebiddable('S') and hcp >= 12 and bestmajor('S')) \| (rebiddable('S') and bestmajor('S') and hcp >= 15) | F1 |  | 36 |
| 3N | Board: 373524, Hand: AQ952.AK8.AKT83. | (hcp >= 15 and not slammish and balish) |  |  | 22 |
| 3N | Board: 571312, Hand: KQJ7.AKQ6..AQJ42 [MS=C-pre2-low-partscore-game-values(at=3D,combinedHcp=27)] | (game and not slammish and stoppersOK) |  |  | 55 |
| 4C | Board: 334057, Hand: AQT76..A953.KJ85 | (competitive('C') and hcp <= 15) | minhcp=7,maxhcp=12 |  | 19 |
| 4C | _(unnamed — the Requires expression is the definition)_ | (C >= 2 and hcp<= 10 and C_points >= 6) |  |  | 20 |
| 4D | Board: 355143, Hand: 8.AKQ42.6.KQT732 [MS=3a-loser-game(losers=3,ownTricks=10,game=4H,contract=3D)] | (fourlevelovercall('D')) |  |  | 37 |
| 4H | _(unnamed — the Requires expression is the definition)_ | (H >= 7 and losers <= 4 and not slammish) |  |  | 35 |
| 4H | Hand: A.QJT96543.AJT.Q (GameEval) | (H_game) |  |  | 54 |
| 4S | _(unnamed — the Requires expression is the definition)_ | (S >= 7 and losers <= 4 and not slammish) |  |  | 35 |
| 4S | Hand: A.QJT96543.AJT.Q (GameEval) | (S_game) |  |  | 54 |
| 4N* | RKC | (CanAsk_C_RKC) \| (C_slam) | T=C | RKC0314_C | 60 |
| 5C | Board: 3320, Hand: A74.T9.KJ92.KJ43 | (preemptgame('C')) |  |  | 31 |
| 5C | Board: 266857, Hand: J.AJ654.AJT64.QT [MS=3-cover-game-raise(target=5C,partnerRange=7-11)] | (covergame('C')) |  |  | 41 |
| 5C | _(unnamed — the Requires expression is the definition)_ | (hcp >= 18 and C >= 1) \| (minorgameisbetter('C')) \| (C_game and C >= 2) \| (cansacrifice('C',false)) \| (C_compgame) \| (preemptgame('C')) |  |  | 70 |
| 5D | Hand: .A72.AKQJ95432.T (GameEval) | (cansacrifice('D', false)) |  |  | 52 |
| 5N* | GSForce | (CanAsk_C_GSF) | T=C | GSForce | 115 |
| 6C | To Play | (CanBid6_C) |  |  | 40 |
| 6C | Playing strength: one loser with a real solid suit or an agreed fit | ((realsolid('C') or trump('C')) and losers == 1) | T=C |  | 45 |
| 6C | Slam: own playing strength -- our hand alone rates to take twelve tricks | (monsterslam('C')) | T=C |  | 113 |
| 7C | Playing strength: no losers with a real solid suit or an agreed fit | ((realsolid('C') or trump('C')) and losers <= 0) | T=C |  | 46 |
| 7C | Grand slam: own playing strength -- our hand alone rates to take thirteen tricks | (monstergrand('C')) | T=C |  | 114 |
| 7N | To Play | (CanBid7NT) |  |  | 110 |

#### `3C-X`

| Call | Means | Requires | Post-condition | Convention | Pri |
|---|---|---|---|---|---|
| P | Board: 780222, Hand: K764.9.AQ98752.A [MS=false(C-missed-game(cur=3C,target=5D))] | (true) |  |  |  |
| P | Pass preempt | (true) |  |  |  |
| 3D | _(unnamed — the Requires expression is the definition)_ | (twicerebiddable('D') and HasTopHonors('D', 2, 3) ) | minhcp=5, maxhcp= 14 |  | 10 |
| 3H | _(unnamed — the Requires expression is the definition)_ | (twicerebiddable('H') and hcp >= 12 and bestmajor('H')) \| (rebiddable('H') and bestmajor('H') and hcp >= 15) | F1 |  | 36 |
| 3S | _(unnamed — the Requires expression is the definition)_ | (twicerebiddable('S') and hcp >= 12 and bestmajor('S')) \| (rebiddable('S') and bestmajor('S') and hcp >= 15) | F1 |  | 36 |
| 3N | Board: 373524, Hand: AQ952.AK8.AKT83. | (hcp >= 15 and not slammish and balish and stoppersOK) |  |  | 22 |
| 3N | Board: 571312, Hand: KQJ7.AKQ6..AQJ42 [MS=C-pre2-low-partscore-game-values(at=3D,combinedHcp=27)] | (game and not slammish and stoppersOK) |  |  | 55 |
| 4C | Board: 334057, Hand: AQT76..A953.KJ85 | (competitive('C') and hcp <= 15) | minhcp=7,maxhcp=12 |  | 19 |
| 4C | _(unnamed — the Requires expression is the definition)_ | (C >= 2 and hcp<= 10 and C_points >= 6) |  |  | 20 |
| 4D | Board: 355143, Hand: 8.AKQ42.6.KQT732 [MS=3a-loser-game(losers=3,ownTricks=10,game=4H,contract=3D)] | (fourlevelovercall('D')) |  |  | 37 |
| 4H | _(unnamed — the Requires expression is the definition)_ | (H >= 7 and losers <= 4 and not slammish) |  |  | 35 |
| 4H | Hand: A.QJT96543.AJT.Q (GameEval) | (H_game) |  |  | 54 |
| 4S | _(unnamed — the Requires expression is the definition)_ | (S >= 7 and losers <= 4 and not slammish) |  |  | 35 |
| 4S | Hand: A.QJT96543.AJT.Q (GameEval) | (S_game) |  |  | 54 |
| 4N* | RKC | (CanAsk_C_RKC) \| (C_slam) | T=C | RKC0314_C | 60 |
| 5C | Board: 3320, Hand: A74.T9.KJ92.KJ43 | (preemptgame('C')) |  |  | 31 |
| 5C | Board: 266857, Hand: J.AJ654.AJT64.QT [MS=3-cover-game-raise(target=5C,partnerRange=7-11)] | (covergame('C')) |  |  | 41 |
| 5C | _(unnamed — the Requires expression is the definition)_ | (hcp >= 18 and C >= 1) \| (minorgameisbetter('C')) \| (C_game and C >= 2) \| (cansacrifice('C',false)) \| (C_compgame) \| (preemptgame('C')) |  |  | 70 |
| 5D | Board: T176035, Hand: 7.KQT42.AKQT854. [MS=3a-loser-game(losers=2,ownTricks=11,game=5D,contract=3C)] | (solid('D') and losers <= 2) |  |  | 24 |
| 5D | Hand: .A72.AKQJ95432.T (GameEval) | (cansacrifice('D', false)) |  |  | 52 |
| 5N* | GSForce | (CanAsk_C_GSF) | T=C | GSForce | 115 |
| 6C | To Play | (CanBid6_C) |  |  | 40 |
| 6C | Playing strength: one loser with a real solid suit or an agreed fit | ((realsolid('C') or trump('C')) and losers == 1) | T=C |  | 45 |
| 6C | Slam: own playing strength -- our hand alone rates to take twelve tricks | (monsterslam('C')) | T=C |  | 113 |
| 7C | Playing strength: no losers with a real solid suit or an agreed fit | ((realsolid('C') or trump('C')) and losers <= 0) | T=C |  | 46 |
| 7C | Grand slam: own playing strength -- our hand alone rates to take thirteen tricks | (monstergrand('C')) | T=C |  | 114 |
| 7N | To Play | (CanBid7NT) |  |  | 110 |

#### `3C-3D`

| Call | Means | Requires | Post-condition | Convention | Pri |
|---|---|---|---|---|---|
| P | _(unnamed — the Requires expression is the definition)_ | (C <= 3 or clubpoints <= 5) |  |  |  |
| 4C | _(unnamed — the Requires expression is the definition)_ | (C >= 3 and clubpoints >= 6 and not game) |  |  | 10 |
| 4N* | RKC | ((C >= 3) AND (CanAsk_C_RKC)) \| ((C >= 3) AND (clubslam)) | T=C | RKC0314_C | 60 |
| 5C | _(unnamed — the Requires expression is the definition)_ | (shouldsacrifice('C')) \| (C >= 4 and hcp >= 11 and not slammish) \| (C_compgame) \| (preemptgame('C')) |  |  | 70 |
| 5N* | GSForce | ((C >= 3) AND (CanAsk_C_GSF)) | T=C | GSForce | 115 |
| 6C | To Play | ((C >= 3) AND (CanBid6_C)) |  |  | 40 |
| 6C | Playing strength: one loser with a real solid suit or an agreed fit | ((C >= 3) AND ((realsolid('C') or trump('C')) and losers == 1)) | T=C |  | 45 |
| 6C | Slam: own playing strength -- our hand alone rates to take twelve tricks | ((C >= 3) AND (monsterslam('C'))) | T=C |  | 113 |
| 7C | Playing strength: no losers with a real solid suit or an agreed fit | ((C >= 3) AND ((realsolid('C') or trump('C')) and losers <= 0)) | T=C |  | 46 |
| 7C | Grand slam: own playing strength -- our hand alone rates to take thirteen tricks | ((C >= 3) AND (monstergrand('C'))) | T=C |  | 114 |
| 7N | To Play | ((C >= 3) AND (CanBid7NT)) |  |  | 110 |

#### `3C-3H`

| Call | Means | Requires | Post-condition | Convention | Pri |
|---|---|---|---|---|---|
| P | _(unnamed — the Requires expression is the definition)_ | (true) \| (not game) |  |  |  |
| 3S | _(unnamed — the Requires expression is the definition)_ | (competitive('S')) |  |  | 24 |
| 3N | To play, good hand opposite preempt | (hcp >= 15 and stopper('H')) |  |  | 30 |
| 4C | _(unnamed — the Requires expression is the definition)_ | (competitive('C')) |  |  | 20 |
| 4H | _(unnamed — the Requires expression is the definition)_ | (H >= 7 and losers <= 4 and not slammish) |  |  | 35 |
| 4N* | RKC | (CanAsk_C_RKC) \| (C_slam) | T=C | RKC0314_C | 60 |
| 5C | _(unnamed — the Requires expression is the definition)_ | (C >= 4 and hcp<= 10) \| (C_game and C >= 2) \| (C_compgame) \| (preemptgame('C')) |  |  | 70 |
| 5D | _(unnamed — the Requires expression is the definition)_ | (D_game and rebiddable('D')) | T=D |  | 52 |
| 5N* | GSForce | (CanAsk_C_GSF) | T=C | GSForce | 115 |
| 6C | To Play | (CanBid6_C) |  |  | 40 |
| 6C | Playing strength: one loser with a real solid suit or an agreed fit | ((realsolid('C') or trump('C')) and losers == 1) | T=C |  | 45 |
| 6C | Slam: own playing strength -- our hand alone rates to take twelve tricks | (monsterslam('C')) | T=C |  | 113 |
| 7C | Playing strength: no losers with a real solid suit or an agreed fit | ((realsolid('C') or trump('C')) and losers <= 0) | T=C |  | 46 |
| 7C | Grand slam: own playing strength -- our hand alone rates to take thirteen tricks | (monstergrand('C')) | T=C |  | 114 |
| 7N | To Play | (CanBid7NT) |  |  | 110 |
| X | _(unnamed — the Requires expression is the definition)_ | (penalty) |  |  | 90 |

#### `3C-3S`

| Call | Means | Requires | Post-condition | Convention | Pri |
|---|---|---|---|---|---|
| P | _(unnamed — the Requires expression is the definition)_ | (not game) |  |  |  |
| 3N | To play, good hand opposite preempt | (hcp >= 15 and stopper('S')) |  |  | 30 |
| 4C | _(unnamed — the Requires expression is the definition)_ | (competitive('C')) |  |  | 20 |
| 4S | _(unnamed — the Requires expression is the definition)_ | (S >= 7 and losers <= 4 and not slammish) |  |  | 35 |
| 4N* | RKC | (CanAsk_C_RKC) \| (C_slam) | T=C | RKC0314_C | 60 |
| 5C | _(unnamed — the Requires expression is the definition)_ | (C >= 4 and hcp<= 10) \| (C_game and C >= 2) \| (C_compgame) \| (preemptgame('C')) |  |  | 70 |
| 5D | _(unnamed — the Requires expression is the definition)_ | (D_game and rebiddable('D')) | T=D |  | 52 |
| 5N* | GSForce | (CanAsk_C_GSF) | T=C | GSForce | 115 |
| 6C | To Play | (CanBid6_C) |  |  | 40 |
| 6C | Playing strength: one loser with a real solid suit or an agreed fit | ((realsolid('C') or trump('C')) and losers == 1) | T=C |  | 45 |
| 6C | Slam: own playing strength -- our hand alone rates to take twelve tricks | (monsterslam('C')) | T=C |  | 113 |
| 7C | Playing strength: no losers with a real solid suit or an agreed fit | ((realsolid('C') or trump('C')) and losers <= 0) | T=C |  | 46 |
| 7C | Grand slam: own playing strength -- our hand alone rates to take thirteen tricks | (monstergrand('C')) | T=C |  | 114 |
| 7N | To Play | (CanBid7NT) |  |  | 110 |
| X | _(unnamed — the Requires expression is the definition)_ | (penalty) |  |  | 90 |

#### `3C-4C`

| Call | Means | Requires | Post-condition | Convention | Pri |
|---|---|---|---|---|---|
| P | _(unnamed — the Requires expression is the definition)_ | (C <= 3 or C_points <= 9) |  | MichaelsCuebid3XDefence |  |
| 4H | _(unnamed — the Requires expression is the definition)_ | (H >= 7 and loserlevel >= 4) |  | MichaelsCuebid3XDefence | 10 |
| 4S | _(unnamed — the Requires expression is the definition)_ | (S >= 7 and loserlevel >= 4) |  | MichaelsCuebid3XDefence | 10 |
| 5C | _(unnamed — the Requires expression is the definition)_ | (C >= 4 and C_points >= 10) \| (C_compgame) \| (preemptgame('C')) |  | MichaelsCuebid3XDefence | 70 |

#### `3C-4H`

| Call | Means | Requires | Post-condition | Convention | Pri |
|---|---|---|---|---|---|
| P | _(unnamed — the Requires expression is the definition)_ | (true) |  |  |  |
| 4S | Board: 572753, Hand: QJ98763.K653.6.A | (fourlevelovercall('S')) |  |  | 54 |
| 4S | Board: 5012, Hand: 2.AQJ87643.AQ94. | (cansacrifice('S') and isvalidbid('4S')) |  |  | 63 |
| 5C | Board: 650374, Hand: QJT8.T93.T76.654 | (cansacrifice('C')) |  |  | 51 |
| 5C | _(unnamed — the Requires expression is the definition)_ | (C_compgame) \| (preemptgame('C')) |  |  | 70 |
| 5D | Board: 999125, Hand: KJ.KQJ9.AQJ9643. | (cansacrifice('D')) |  |  | 53 |
| 5S | Board: 5012, Hand: 2.AQJ87643.AQ94. | (cansacrifice('S')) |  |  | 43 |
| X | Board: 127717, Hand: K9864.AQ7643.JT. | (penalty) |  |  | 90 |

#### `3C-4S`

| Call | Means | Requires | Post-condition | Convention | Pri |
|---|---|---|---|---|---|
| P | _(unnamed — the Requires expression is the definition)_ | (true) |  |  |  |
| 5C | Board: 650374, Hand: QJT8.T93.T76.654 | (cansacrifice('C')) |  |  | 51 |
| 5C | _(unnamed — the Requires expression is the definition)_ | (C_compgame) \| (preemptgame('C')) |  |  | 70 |
| 5D | Board: 999125, Hand: KJ.KQJ9.AQJ9643. | (cansacrifice('D')) |  |  | 53 |
| 5H | Board: 5012, Hand: 2.AQJ87643.AQ94. | (cansacrifice('H')) |  |  | 43 |
| X | Board: 127717, Hand: K9864.AQ7643.JT. | (penalty) |  |  | 90 |

#### `3C-6H`

| Call | Means | Requires | Post-condition | Convention | Pri |
|---|---|---|---|---|---|
| P | Board: T182276 | (true) |  |  |  |

#### `3C-6S`

_Same rule set as `3C-6H` — the service returns an identical table for this position._

#### `3C-3N`

| Call | Means | Requires | Post-condition | Convention | Pri |
|---|---|---|---|---|---|
| P | _(unnamed — the Requires expression is the definition)_ | (true) |  |  |  |
| 4C | Hand: AKQ543.KQJ5.3.76 (Partscore) | (cansacrifice('C')) |  |  | 31 |
| 4D | Board: 784669, Hand: 4.A7654..AQT9843 | (fourlevelovercall('D')) |  |  | 32 |
| 4H | Board: 387215, Hand: T.AQJT9754.KJT.8 | (fourlevelovercall('H')) |  |  | 54 |
| 4S | Board: 387215, Hand: T.AQJT9754.KJT.8 | (fourlevelovercall('S')) |  |  | 54 |
| 5C | _(unnamed — the Requires expression is the definition)_ | (C_compgame) \| (preemptgame('C')) |  |  | 70 |
| X | _(unnamed — the Requires expression is the definition)_ | (penalty) |  |  | 90 |

#### `3D-P`

| Call | Means | Requires | Post-condition | Convention | Pri |
|---|---|---|---|---|---|
| P | Pass preempt | (true) |  |  |  |
| 3H | _(unnamed — the Requires expression is the definition)_ | (twicerebiddable('H') and hcp >= 12 and bestmajor('H')) \| (rebiddable('H') and bestmajor('H') and hcp >= 15) | F1 |  | 36 |
| 3S | _(unnamed — the Requires expression is the definition)_ | (twicerebiddable('S') and hcp >= 12 and bestmajor('S')) \| (rebiddable('S') and bestmajor('S') and hcp >= 15) | F1 |  | 36 |
| 3N | Board: 373524, Hand: AQ952.AK8.AKT83. | (hcp >= 15 and not slammish and balish) |  |  | 22 |
| 3N | Board: 571312, Hand: KQJ7.AKQ6..AQJ42 [MS=C-pre2-low-partscore-game-values(at=3D,combinedHcp=27)] | (game and not slammish and stoppersOK) |  |  | 55 |
| 4C | _(unnamed — the Requires expression is the definition)_ | (twicerebiddable('C') and hcp >= 16) | F1 |  | 25 |
| 4C | Board: 355143, Hand: 8.AKQ42.6.KQT732 [MS=3a-loser-game(losers=3,ownTricks=10,game=4H,contract=3D)] | (fourlevelovercall('C')) |  |  | 37 |
| 4D | Board: 334057, Hand: AQT76..A953.KJ85 | (competitive('D') and hcp <= 15) | minhcp=7,maxhcp=12 |  | 19 |
| 4D | _(unnamed — the Requires expression is the definition)_ | (D >= 2 and hcp<= 10 and D_points >= 6) |  |  | 20 |
| 4H | _(unnamed — the Requires expression is the definition)_ | (H >= 7 and losers <= 4 and not slammish) |  |  | 35 |
| 4H | Hand: A.QJT96543.AJT.Q (GameEval) | (H_game) |  |  | 54 |
| 4S | _(unnamed — the Requires expression is the definition)_ | (S >= 7 and losers <= 4 and not slammish) |  |  | 35 |
| 4S | Hand: A.QJT96543.AJT.Q (GameEval) | (S_game) |  |  | 54 |
| 4N* | RKC | (CanAsk_D_RKC) \| (D_slam) | T=D | RKC0314_D | 60 |
| 5C | Hand: .A72.AKQJ95432.T (GameEval) | (cansacrifice('C', false)) |  |  | 52 |
| 5D | Board: 3320, Hand: A74.T9.KJ92.KJ43 | (preemptgame('D')) |  |  | 31 |
| 5D | Board: 266857, Hand: J.AJ654.AJT64.QT [MS=3-cover-game-raise(target=5C,partnerRange=7-11)] | (covergame('D')) |  |  | 41 |
| 5D | _(unnamed — the Requires expression is the definition)_ | (hcp >= 18 and D >= 1) \| (minorgameisbetter('D')) \| (D_game and D >= 2) \| (cansacrifice('D',false)) \| (D_compgame) \| (preemptgame('D')) |  |  | 70 |
| 5N* | GSForce | (CanAsk_D_GSF) | T=D | GSForce | 115 |
| 6D | To Play | (CanBid6_D) |  |  | 40 |
| 6D | Playing strength: one loser with a real solid suit or an agreed fit | ((realsolid('D') or trump('D')) and losers == 1) | T=D |  | 45 |
| 6D | Slam: own playing strength -- our hand alone rates to take twelve tricks | (monsterslam('D')) | T=D |  | 113 |
| 7D | Playing strength: no losers with a real solid suit or an agreed fit | ((realsolid('D') or trump('D')) and losers <= 0) | T=D |  | 46 |
| 7D | Grand slam: own playing strength -- our hand alone rates to take thirteen tricks | (monstergrand('D')) | T=D |  | 114 |
| 7N | To Play | (CanBid7NT) |  |  | 110 |

#### `3D-X`

| Call | Means | Requires | Post-condition | Convention | Pri |
|---|---|---|---|---|---|
| P | Board: 380166, Hand: .QJ8432..KQJT542 [MS=false(3a-loser-game(losers=3,ownTricks=10,game=4H,contract=3D))] | (true) |  |  |  |
| P | Pass preempt | (true) |  |  |  |
| 3H | _(unnamed — the Requires expression is the definition)_ | (twicerebiddable('H') and hcp >= 12 and bestmajor('H')) \| (rebiddable('H') and bestmajor('H') and hcp >= 15) | F1 |  | 36 |
| 3S | _(unnamed — the Requires expression is the definition)_ | (twicerebiddable('S') and hcp >= 12 and bestmajor('S')) \| (rebiddable('S') and bestmajor('S') and hcp >= 15) | F1 |  | 36 |
| 3N | Board: 373524, Hand: AQ952.AK8.AKT83. | (hcp >= 15 and not slammish and balish and stoppersOK) |  |  | 22 |
| 3N | Board: 571312, Hand: KQJ7.AKQ6..AQJ42 [MS=C-pre2-low-partscore-game-values(at=3D,combinedHcp=27)] | (game and not slammish and stoppersOK) |  |  | 55 |
| 4C | _(unnamed — the Requires expression is the definition)_ | (twicerebiddable('C') and hcp >= 16) | F1 |  | 25 |
| 4C | Board: 355143, Hand: 8.AKQ42.6.KQT732 [MS=3a-loser-game(losers=3,ownTricks=10,game=4H,contract=3D)] | (fourlevelovercall('C')) |  |  | 37 |
| 4D | Board: 334057, Hand: AQT76..A953.KJ85 | (competitive('D') and hcp <= 15) | minhcp=7,maxhcp=12 |  | 19 |
| 4D | _(unnamed — the Requires expression is the definition)_ | (D >= 2 and hcp<= 10 and D_points >= 6) |  |  | 20 |
| 4H | _(unnamed — the Requires expression is the definition)_ | (H >= 7 and losers <= 4 and not slammish) |  |  | 35 |
| 4H | Hand: A.QJT96543.AJT.Q (GameEval) | (H_game) |  |  | 54 |
| 4S | _(unnamed — the Requires expression is the definition)_ | (S >= 7 and losers <= 4 and not slammish) |  |  | 35 |
| 4S | Hand: A.QJT96543.AJT.Q (GameEval) | (S_game) |  |  | 54 |
| 4N* | RKC | (CanAsk_D_RKC) \| (D_slam) | T=D | RKC0314_D | 60 |
| 5C | Hand: .A72.AKQJ95432.T (GameEval) | (cansacrifice('C', false)) |  |  | 52 |
| 5D | Board: 3320, Hand: A74.T9.KJ92.KJ43 | (preemptgame('D')) |  |  | 31 |
| 5D | Board: 266857, Hand: J.AJ654.AJT64.QT [MS=3-cover-game-raise(target=5C,partnerRange=7-11)] | (covergame('D')) |  |  | 41 |
| 5D | _(unnamed — the Requires expression is the definition)_ | (hcp >= 18 and D >= 1) \| (minorgameisbetter('D')) \| (D_game and D >= 2) \| (cansacrifice('D',false)) \| (D_compgame) \| (preemptgame('D')) |  |  | 70 |
| 5N* | GSForce | (CanAsk_D_GSF) | T=D | GSForce | 115 |
| 6D | To Play | (CanBid6_D) |  |  | 40 |
| 6D | Playing strength: one loser with a real solid suit or an agreed fit | ((realsolid('D') or trump('D')) and losers == 1) | T=D |  | 45 |
| 6D | Slam: own playing strength -- our hand alone rates to take twelve tricks | (monsterslam('D')) | T=D |  | 113 |
| 7D | Playing strength: no losers with a real solid suit or an agreed fit | ((realsolid('D') or trump('D')) and losers <= 0) | T=D |  | 46 |
| 7D | Grand slam: own playing strength -- our hand alone rates to take thirteen tricks | (monstergrand('D')) | T=D |  | 114 |
| 7N | To Play | (CanBid7NT) |  |  | 110 |

#### `3D-3H`

| Call | Means | Requires | Post-condition | Convention | Pri |
|---|---|---|---|---|---|
| P | Pass preempt | (true) |  |  |  |
| P | _(unnamed — the Requires expression is the definition)_ | (true) \| (not game) |  |  |  |
| 3S | _(unnamed — the Requires expression is the definition)_ | (competitive('S')) |  |  | 24 |
| 3N | To play, good hand opposite preempt | (hcp >= 15 and stopper('H')) |  |  | 30 |
| 4C | _(unnamed — the Requires expression is the definition)_ | (C >= 7 and hcp<= 10) |  |  | 20 |
| 4D | _(unnamed — the Requires expression is the definition)_ | (D >= 3 and hcp<= 10) \| (competitive('D')) |  |  | 20 |
| 4H | _(unnamed — the Requires expression is the definition)_ | (H >= 7 and losers <= 4 and not slammish) |  |  | 35 |
| 4N* | RKC | (CanAsk_C_RKC) \| (CanAsk_D_RKC) \| (C_slam) \| (D_slam) | T=C \| T=D | RKC0314_C \| RKC0314_D | 60 |
| 5C | _(unnamed — the Requires expression is the definition)_ | (C_game and rebiddable('C')) | T=C |  | 52 |
| 5D | _(unnamed — the Requires expression is the definition)_ | (D >= 4 and hcp<= 10) \| (D >= 2 and C_game) \| (D >= 2 and D_game) \| (D_game and D >= 2) \| (D_compgame) \| (preemptgame('D')) |  |  | 70 |
| 5N* | GSForce | (CanAsk_C_GSF) \| (CanAsk_D_GSF) | T=C \| T=D | GSForce | 115 |
| 6C | To Play | (CanBid6_C) |  |  | 40 |
| 6C | Playing strength: one loser with a real solid suit or an agreed fit | ((realsolid('C') or trump('C')) and losers == 1) | T=C |  | 45 |
| 6C | Slam: own playing strength -- our hand alone rates to take twelve tricks | (monsterslam('C')) | T=C |  | 113 |
| 6D | To Play | (CanBid6_D) |  |  | 40 |
| 6D | Playing strength: one loser with a real solid suit or an agreed fit | ((realsolid('D') or trump('D')) and losers == 1) | T=D |  | 45 |
| 6D | Slam: own playing strength -- our hand alone rates to take twelve tricks | (monsterslam('D')) | T=D |  | 113 |
| 7C | Playing strength: no losers with a real solid suit or an agreed fit | ((realsolid('C') or trump('C')) and losers <= 0) | T=C |  | 46 |
| 7C | Grand slam: own playing strength -- our hand alone rates to take thirteen tricks | (monstergrand('C')) | T=C |  | 114 |
| 7D | Playing strength: no losers with a real solid suit or an agreed fit | ((realsolid('D') or trump('D')) and losers <= 0) | T=D |  | 46 |
| 7D | Grand slam: own playing strength -- our hand alone rates to take thirteen tricks | (monstergrand('D')) | T=D |  | 114 |
| 7N | To Play | (CanBid7NT) |  |  | 110 |
| X | _(unnamed — the Requires expression is the definition)_ | (penalty) |  |  | 90 |

#### `3D-3S`

| Call | Means | Requires | Post-condition | Convention | Pri |
|---|---|---|---|---|---|
| P | Pass preempt | (true) |  |  |  |
| P | _(unnamed — the Requires expression is the definition)_ | (not game) |  |  |  |
| 3N | To play, good hand opposite preempt | (hcp >= 15 and stopper('S')) |  |  | 30 |
| 4C | _(unnamed — the Requires expression is the definition)_ | (C >= 7 and hcp<= 10) |  |  | 20 |
| 4D | _(unnamed — the Requires expression is the definition)_ | (D >= 3 and hcp<= 10) \| (competitive('D')) |  |  | 20 |
| 4S | _(unnamed — the Requires expression is the definition)_ | (S >= 7 and losers <= 4 and not slammish) |  |  | 35 |
| 4N* | RKC | (CanAsk_C_RKC) \| (CanAsk_D_RKC) \| (C_slam) \| (D_slam) | T=C \| T=D | RKC0314_C \| RKC0314_D | 60 |
| 5C | _(unnamed — the Requires expression is the definition)_ | (C_game and rebiddable('C')) | T=C |  | 52 |
| 5D | _(unnamed — the Requires expression is the definition)_ | (D >= 4 and hcp<= 10) \| (D >= 2 and C_game) \| (D >= 2 and D_game) \| (D_game and D >= 2) \| (D_compgame) \| (preemptgame('D')) |  |  | 70 |
| 5N* | GSForce | (CanAsk_C_GSF) \| (CanAsk_D_GSF) | T=C \| T=D | GSForce | 115 |
| 6C | To Play | (CanBid6_C) |  |  | 40 |
| 6C | Playing strength: one loser with a real solid suit or an agreed fit | ((realsolid('C') or trump('C')) and losers == 1) | T=C |  | 45 |
| 6C | Slam: own playing strength -- our hand alone rates to take twelve tricks | (monsterslam('C')) | T=C |  | 113 |
| 6D | To Play | (CanBid6_D) |  |  | 40 |
| 6D | Playing strength: one loser with a real solid suit or an agreed fit | ((realsolid('D') or trump('D')) and losers == 1) | T=D |  | 45 |
| 6D | Slam: own playing strength -- our hand alone rates to take twelve tricks | (monsterslam('D')) | T=D |  | 113 |
| 7C | Playing strength: no losers with a real solid suit or an agreed fit | ((realsolid('C') or trump('C')) and losers <= 0) | T=C |  | 46 |
| 7C | Grand slam: own playing strength -- our hand alone rates to take thirteen tricks | (monstergrand('C')) | T=C |  | 114 |
| 7D | Playing strength: no losers with a real solid suit or an agreed fit | ((realsolid('D') or trump('D')) and losers <= 0) | T=D |  | 46 |
| 7D | Grand slam: own playing strength -- our hand alone rates to take thirteen tricks | (monstergrand('D')) | T=D |  | 114 |
| 7N | To Play | (CanBid7NT) |  |  | 110 |
| X | _(unnamed — the Requires expression is the definition)_ | (penalty) |  |  | 90 |

#### `3D-4C`

| Call | Means | Requires | Post-condition | Convention | Pri |
|---|---|---|---|---|---|
| P | _(unnamed — the Requires expression is the definition)_ | (true) |  |  |  |
| 4D | Board: 283324, Hand: KQJ.QJ9862.KQ3.A | (competitive('D')) |  |  | 9 |
| 4D | _(unnamed — the Requires expression is the definition)_ | (D >= 3 and hcp<= 10) |  |  | 10 |
| 4H | Board: 823532, Hand: AQJ8.AJT9632..QJ | (fourlevelovercall('H')) |  |  | 53 |
| 4H | Hand: AK8543.AKQT76.5. (GameEval) | (H_game) |  |  | 54 |
| 4S | Board: 823532, Hand: AQJ8.AJT9632..QJ | (fourlevelovercall('S')) |  |  | 53 |
| 4S | Hand: AK8543.AKQT76.5. (GameEval) | (S_game) |  |  | 54 |
| 4N* | RKC | (CanAsk_D_RKC) \| (diamondslam) | T=D | RKC0314_D | 60 |
| 5D | Hand: KQJ.QJ9862.KQ3.A (GameEval) | (D_game) |  |  | 52 |
| 5D | _(unnamed — the Requires expression is the definition)_ | (D >= 4 and hcp<= 10) \| (D_compgame) \| (preemptgame('D')) |  |  | 70 |
| 5N* | GSForce | (CanAsk_D_GSF) | T=D | GSForce | 115 |
| 6D | To Play | (CanBid6_D) |  |  | 40 |
| 6D | Playing strength: one loser with a real solid suit or an agreed fit | ((realsolid('D') or trump('D')) and losers == 1) | T=D |  | 45 |
| 6D | Slam: own playing strength -- our hand alone rates to take twelve tricks | (monsterslam('D')) | T=D |  | 113 |
| 7D | Playing strength: no losers with a real solid suit or an agreed fit | ((realsolid('D') or trump('D')) and losers <= 0) | T=D |  | 46 |
| 7D | Grand slam: own playing strength -- our hand alone rates to take thirteen tricks | (monstergrand('D')) | T=D |  | 114 |
| 7N | To Play | (CanBid7NT) |  |  | 110 |
| X | _(unnamed — the Requires expression is the definition)_ | (penalty) |  |  | 90 |

#### `3D-4D`

| Call | Means | Requires | Post-condition | Convention | Pri |
|---|---|---|---|---|---|
| P | _(unnamed — the Requires expression is the definition)_ | (D <= 3 or D_points <= 9) |  | MichaelsCuebid3XDefence |  |
| 4H | _(unnamed — the Requires expression is the definition)_ | (H >= 7 and loserlevel >= 4) |  | MichaelsCuebid3XDefence | 10 |
| 4S | _(unnamed — the Requires expression is the definition)_ | (S >= 7 and loserlevel >= 4) |  | MichaelsCuebid3XDefence | 10 |
| 5D | _(unnamed — the Requires expression is the definition)_ | (D >= 4 and D_points >= 10) \| (D_compgame) \| (preemptgame('D')) |  | MichaelsCuebid3XDefence | 70 |

#### `3D-4H`

| Call | Means | Requires | Post-condition | Convention | Pri |
|---|---|---|---|---|---|
| P | _(unnamed — the Requires expression is the definition)_ | (true) |  |  |  |
| 4S | Board: 83283, Hand: AKQT532.5.J.Q532 | (Solid('S')) | T=S |  | 54 |
| 4S | Board: 372443, Hand: AQT6542.2.Q.A642 | (TwiceRebiddable('S') and losers <= 4) | T=S |  | 55 |
| 4S | Board: 884275, Hand: AQJT8542..6.Q632 | (cansacrifice('S')) |  |  | 56 |
| 4S | Board: 5012, Hand: 2.AQJ87643.AQ94. | (cansacrifice('S') and isvalidbid('4S')) |  |  | 63 |
| 5C | Board: 999125, Hand: KJ.KQJ9.AQJ9643. | (cansacrifice('C')) |  |  | 53 |
| 5D | Board: 650374, Hand: QJT8.T93.T76.654 | (cansacrifice('D')) |  |  | 51 |
| 5D | _(unnamed — the Requires expression is the definition)_ | (D_compgame) \| (preemptgame('D')) |  |  | 70 |
| 5S | Board: 5012, Hand: 2.AQJ87643.AQ94. | (cansacrifice('S')) |  |  | 43 |
| X | Board: 127717, Hand: K9864.AQ7643.JT. | (penalty) |  |  | 90 |

#### `3D-4S`

| Call | Means | Requires | Post-condition | Convention | Pri |
|---|---|---|---|---|---|
| P | _(unnamed — the Requires expression is the definition)_ | (true) |  |  |  |
| 5C | Board: 999125, Hand: KJ.KQJ9.AQJ9643. | (cansacrifice('C')) |  |  | 53 |
| 5D | Board: 650374, Hand: QJT8.T93.T76.654 | (cansacrifice('D')) |  |  | 51 |
| 5D | _(unnamed — the Requires expression is the definition)_ | (D_compgame) \| (preemptgame('D')) |  |  | 70 |
| 5H | Board: 5012, Hand: 2.AQJ87643.AQ94. | (cansacrifice('H')) |  |  | 43 |
| X | Board: 127717, Hand: K9864.AQ7643.JT. | (penalty) |  |  | 90 |

#### `3D-5C`

| Call | Means | Requires | Post-condition | Convention | Pri |
|---|---|---|---|---|---|
| P | _(unnamed — the Requires expression is the definition)_ | (true) |  |  |  |
| 5D | _(unnamed — the Requires expression is the definition)_ | (cansacrifice('D')) \| (D_compgame) \| (preemptgame('D')) |  |  | 70 |
| X | _(unnamed — the Requires expression is the definition)_ | (penalty) |  |  | 20 |

#### `3D-6H`

_Same rule set as `3C-6H` — the service returns an identical table for this position._

#### `3D-6S`

_Same rule set as `3C-6H` — the service returns an identical table for this position._

#### `3D-3N`

| Call | Means | Requires | Post-condition | Convention | Pri |
|---|---|---|---|---|---|
| P | _(unnamed — the Requires expression is the definition)_ | (true) |  |  |  |
| 4C | Board: 784669, Hand: 4.A7654..AQT9843 | (fourlevelovercall('C')) |  |  | 32 |
| 4D | Hand: AKQ543.KQJ5.3.76 (Partscore) | (cansacrifice('D')) |  |  | 31 |
| 4H | Board: 387215, Hand: T.AQJT9754.KJT.8 | (fourlevelovercall('H')) |  |  | 54 |
| 4S | Board: 387215, Hand: T.AQJT9754.KJT.8 | (fourlevelovercall('S')) |  |  | 54 |
| 5D | _(unnamed — the Requires expression is the definition)_ | (D_compgame) \| (preemptgame('D')) |  |  | 70 |
| X | _(unnamed — the Requires expression is the definition)_ | (penalty) |  |  | 90 |

#### `3H-P`

| Call | Means | Requires | Post-condition | Convention | Pri |
|---|---|---|---|---|---|
| P | _(unnamed — the Requires expression is the definition)_ | (true) |  |  |  |
| 3N | To play, good hand opposite preempt | (hcp >= 15) \| (hcp >= 15 and stoppersOK) |  |  | 40 |
| 4C | Board: T586803, Hand: ..AK9874.AK98765 [MS=3a-loser-game(losers=2,ownTricks=11,game=5D,contract=3S)] | (fourlevelovercall('C')) |  |  | 29 |
| 4C | _(unnamed — the Requires expression is the definition)_ | (strongrebiddable('C') and H < 1 and losers <= 3) | F1 |  | 30 |
| 4D | Board: T586803, Hand: ..AK9874.AK98765 [MS=3a-loser-game(losers=2,ownTricks=11,game=5D,contract=3S)] | (fourlevelovercall('D')) |  |  | 29 |
| 4D | _(unnamed — the Requires expression is the definition)_ | (strongrebiddable('D') and H < 1 and losers <= 3) | F1 |  | 30 |
| 4H | Board: 859922, Hand: AQJ87.4..AKT9732 [MS=3a-loser-game(losers=3,ownTricks=10,game=4S,contract=3H)] | (preemptgame('H') or covergame('H')) |  |  | 58 |
| 4H | Board: 2991, Hand: 853.KQ6.KT32.T74 | (H >= 3 and totalpoints >= 7) |  |  | 59 |
| 4H | _(unnamed — the Requires expression is the definition)_ | (H >= 2 and totalpoints >= 9) | minhcp=9,maxhcp=18 |  | 60 |
| 4S | Board: 909468, Hand: .AKJ9852.AQ986.2 [MS=3a-loser-game(losers=3,ownTricks=10,game=4H,contract=3S)] | (losers <= 3 and (Fit('S') or S >= 6)) | T=S |  | 47 |
| 4S | Board: 881780, Hand: .AQJ9854.AK7643. | (S_game) |  |  | 48 |
| 4S | Board: 759309, Hand: AQJ8643..A7632.Q | (S_game and rebiddable('S')) |  |  | 49 |
| 4S | Board: 134768, Hand: KQJ8742.2.AQJ7.9 | (strongrebiddable('S') and losers <= 4) |  |  | 52 |
| 4N* | RKC | (CanAsk_H_RKC) \| (H_slam) | T=H | RKC0314_H | 90 |
| 5C | Board: 142180, Hand: .8.AKQJT8432.A72 | (cansacrifice('C', false)) |  |  | 50 |
| 5C | Hand: .8.AKQJT8432.A72 (GameEval) | (C_game) |  |  | 51 |
| 5D | Board: 142180, Hand: .8.AKQJT8432.A72 | (cansacrifice('D', false)) |  |  | 50 |
| 5D | Hand: .8.AKQJT8432.A72 (GameEval) | (D_game) |  |  | 51 |
| 5N* | GSForce | (CanAsk_H_GSF) | T=H | GSForce | 145 |
| 6H | To Play | (CanBid6_H) |  |  | 70 |
| 6H | Playing strength: one loser with a real solid suit or an agreed fit | ((realsolid('H') or trump('H')) and losers == 1) | T=H |  | 75 |
| 6H | Slam: own playing strength -- our hand alone rates to take twelve tricks | (monsterslam('H')) | T=H |  | 143 |
| 7H | Playing strength: no losers with a real solid suit or an agreed fit | ((realsolid('H') or trump('H')) and losers <= 0) | T=H |  | 76 |
| 7H | Grand slam: own playing strength -- our hand alone rates to take thirteen tricks | (monstergrand('H')) | T=H |  | 144 |
| 7N | To Play | (CanBid7NT) |  |  | 140 |

#### `3H-X`

_Same rule set as `3H-P` — the service returns an identical table for this position._

#### `3H-3S`

| Call | Means | Requires | Post-condition | Convention | Pri |
|---|---|---|---|---|---|
| P | _(unnamed — the Requires expression is the definition)_ | (true) |  |  |  |
| 3N | To play, good hand opposite preempt | (hcp >= 15 and stopper('S')) |  |  | 10 |
| 4C | Board: 358703, Hand: J93..KJ76.AKQ543 | (fourlevelovercall('C')) |  |  | 31 |
| 4D | Board: 358703, Hand: J93..KJ76.AKQ543 | (fourlevelovercall('D')) |  |  | 31 |
| 4H | _(unnamed — the Requires expression is the definition)_ | (H >= 2 and heartpoints >= 9) \| (H_compgame) \| (preemptgame('H')) |  |  | 70 |
| 4N* | RKC | (CanAsk_H_RKC) \| (heartslam) | T=H | RKC0314_H | 60 |
| 5N* | GSForce | (CanAsk_H_GSF) | T=H | GSForce | 115 |
| 6H | To Play | (CanBid6_H) |  |  | 40 |
| 6H | Playing strength: one loser with a real solid suit or an agreed fit | ((realsolid('H') or trump('H')) and losers == 1) | T=H |  | 45 |
| 6H | Slam: own playing strength -- our hand alone rates to take twelve tricks | (monsterslam('H')) | T=H |  | 113 |
| 7H | Playing strength: no losers with a real solid suit or an agreed fit | ((realsolid('H') or trump('H')) and losers <= 0) | T=H |  | 46 |
| 7H | Grand slam: own playing strength -- our hand alone rates to take thirteen tricks | (monstergrand('H')) | T=H |  | 114 |
| 7N | To Play | (CanBid7NT) |  |  | 110 |
| X | Hand: KQT853..AJ854.82 (PenaltyDouble) | (penalty) |  |  | 90 |

#### `3H-4C`

| Call | Means | Requires | Post-condition | Convention | Pri |
|---|---|---|---|---|---|
| P | _(unnamed — the Requires expression is the definition)_ | (not game) |  |  |  |
| 4H | _(unnamed — the Requires expression is the definition)_ | (H >= 3 and H_points >= 10) \| (H_compgame) \| (preemptgame('H')) |  |  | 70 |

#### `3H-4D`

_Same rule set as `3H-4C` — the service returns an identical table for this position._

#### `3H-4H`

| Call | Means | Requires | Post-condition | Convention | Pri |
|---|---|---|---|---|---|
| P | _(unnamed — the Requires expression is the definition)_ | (not game) |  | MichaelsCuebid3XDefence |  |

#### `3H-4S`

| Call | Means | Requires | Post-condition | Convention | Pri |
|---|---|---|---|---|---|
| P | _(unnamed — the Requires expression is the definition)_ | (true) |  |  |  |
| 5H | Board: T478361, Hand: AK74.AT7.J.AQ973 [MS=4-missed-game-implicit-fit(target=4H,fit=10,unlimited)] | (cansacrifice('H')) \| (H_compgame) |  |  | 45 |
| X | _(unnamed — the Requires expression is the definition)_ | (penalty) |  |  | 10 |

#### `3H-6C`

| Call | Means | Requires | Post-condition | Convention | Pri |
|---|---|---|---|---|---|
| P | Board: T66026 | (true) |  |  |  |

#### `3H-6D`

_Same rule set as `3H-6C` — the service returns an identical table for this position._

#### `3H-6S`

| Call | Means | Requires | Post-condition | Convention | Pri |
|---|---|---|---|---|---|
| P | Board: T926820 | (true) |  |  |  |

#### `3H-3N`

| Call | Means | Requires | Post-condition | Convention | Pri |
|---|---|---|---|---|---|
| P | _(unnamed — the Requires expression is the definition)_ | (not game) |  |  |  |
| 4C | Board: DailyMP2026-08-21Field_aa4b1a3f_b8_t5 | (fourlevelovercall('C') or cansacrifice('C')) | maxhcp = 15 |  | 31 |
| 4D | Board: DailyMP2026-08-21Field_aa4b1a3f_b8_t5 | (fourlevelovercall('D') or cansacrifice('D')) | maxhcp = 15 |  | 31 |
| 4H | _(unnamed — the Requires expression is the definition)_ | (preemptgame('H')) |  |  | 10 |

#### `3H-4N`

| Call | Means | Requires | Post-condition | Convention | Pri |
|---|---|---|---|---|---|
| P | _(unnamed — the Requires expression is the definition)_ | (not game) |  |  |  |

#### `3S-P`

| Call | Means | Requires | Post-condition | Convention | Pri |
|---|---|---|---|---|---|
| P | _(unnamed — the Requires expression is the definition)_ | (true) |  |  |  |
| 3N | To play, good hand opposite preempt | (hcp >= 15) \| (hcp >= 15 and stoppersOK) |  |  | 40 |
| 4C | Board: T586803, Hand: ..AK9874.AK98765 [MS=3a-loser-game(losers=2,ownTricks=11,game=5D,contract=3S)] | (fourlevelovercall('C')) |  |  | 29 |
| 4C | _(unnamed — the Requires expression is the definition)_ | (strongrebiddable('C') and S < 1 and losers <= 3) | F1 |  | 30 |
| 4D | Board: T586803, Hand: ..AK9874.AK98765 [MS=3a-loser-game(losers=2,ownTricks=11,game=5D,contract=3S)] | (fourlevelovercall('D')) |  |  | 29 |
| 4D | _(unnamed — the Requires expression is the definition)_ | (strongrebiddable('D') and S < 1 and losers <= 3) | F1 |  | 30 |
| 4H | Board: 909468, Hand: .AKJ9852.AQ986.2 [MS=3a-loser-game(losers=3,ownTricks=10,game=4H,contract=3S)] | (losers <= 3 and (Fit('H') or H >= 6)) | T=H |  | 47 |
| 4H | Board: 881780, Hand: .AQJ9854.AK7643. | (H_game) |  |  | 48 |
| 4H | Board: 759309, Hand: AQJ8643..A7632.Q | (H_game and rebiddable('H')) |  |  | 49 |
| 4H | Board: 134768, Hand: KQJ8742.2.AQJ7.9 | (strongrebiddable('H') and losers <= 4) |  |  | 52 |
| 4S | Board: 859922, Hand: AQJ87.4..AKT9732 [MS=3a-loser-game(losers=3,ownTricks=10,game=4S,contract=3H)] | (preemptgame('S') or covergame('S')) |  |  | 58 |
| 4S | Board: 2991, Hand: 853.KQ6.KT32.T74 | (S >= 3 and totalpoints >= 7) |  |  | 59 |
| 4S | _(unnamed — the Requires expression is the definition)_ | (S >= 2 and totalpoints >= 9) | minhcp=9,maxhcp=18 |  | 60 |
| 4N* | RKC | (CanAsk_S_RKC) \| (S_slam) | T=S | RKC0314_S | 90 |
| 5C | Board: 142180, Hand: .8.AKQJT8432.A72 | (cansacrifice('C', false)) |  |  | 50 |
| 5C | Hand: .8.AKQJT8432.A72 (GameEval) | (C_game) |  |  | 51 |
| 5D | Board: 142180, Hand: .8.AKQJT8432.A72 | (cansacrifice('D', false)) |  |  | 50 |
| 5D | Hand: .8.AKQJT8432.A72 (GameEval) | (D_game) |  |  | 51 |
| 5N* | GSForce | (CanAsk_S_GSF) | T=S | GSForce | 145 |
| 6S | To Play | (CanBid6_S) |  |  | 70 |
| 6S | Playing strength: one loser with a real solid suit or an agreed fit | ((realsolid('S') or trump('S')) and losers == 1) | T=S |  | 75 |
| 6S | Slam: own playing strength -- our hand alone rates to take twelve tricks | (monsterslam('S')) | T=S |  | 143 |
| 7S | Playing strength: no losers with a real solid suit or an agreed fit | ((realsolid('S') or trump('S')) and losers <= 0) | T=S |  | 76 |
| 7S | Grand slam: own playing strength -- our hand alone rates to take thirteen tricks | (monstergrand('S')) | T=S |  | 144 |
| 7N | To Play | (CanBid7NT) |  |  | 140 |

#### `3S-X`

| Call | Means | Requires | Post-condition | Convention | Pri |
|---|---|---|---|---|---|
| P | _(unnamed — the Requires expression is the definition)_ | (true) |  |  |  |
| 3N | To play, good hand opposite preempt | (hcp >= 15) \| (hcp >= 15 and stoppersOK) |  |  | 40 |
| 4C | Board: T586803, Hand: ..AK9874.AK98765 [MS=3a-loser-game(losers=2,ownTricks=11,game=5D,contract=3S)] | (fourlevelovercall('C')) |  |  | 29 |
| 4C | _(unnamed — the Requires expression is the definition)_ | (strongrebiddable('C') and S < 1 and losers <= 3) | F1 |  | 30 |
| 4D | Board: T586803, Hand: ..AK9874.AK98765 [MS=3a-loser-game(losers=2,ownTricks=11,game=5D,contract=3S)] | (fourlevelovercall('D')) |  |  | 29 |
| 4D | _(unnamed — the Requires expression is the definition)_ | (strongrebiddable('D') and S < 1 and losers <= 3) | F1 |  | 30 |
| 4H | _(unnamed — the Requires expression is the definition)_ | (strongrebiddable('H') and S < 1 and losers <= 3) |  |  | 32 |
| 4H | Board: 909468, Hand: .AKJ9852.AQ986.2 [MS=3a-loser-game(losers=3,ownTricks=10,game=4H,contract=3S)] | (losers <= 3 and (Fit('H') or H >= 6)) | T=H |  | 47 |
| 4H | Board: 881780, Hand: .AQJ9854.AK7643. | (H_game) |  |  | 48 |
| 4H | Board: 759309, Hand: AQJ8643..A7632.Q | (H_game and rebiddable('H')) |  |  | 49 |
| 4H | Board: 134768, Hand: KQJ8742.2.AQJ7.9 | (strongrebiddable('H') and losers <= 4) |  |  | 52 |
| 4S | Board: 859922, Hand: AQJ87.4..AKT9732 [MS=3a-loser-game(losers=3,ownTricks=10,game=4S,contract=3H)] | (preemptgame('S') or covergame('S')) |  |  | 58 |
| 4S | Board: 2991, Hand: 853.KQ6.KT32.T74 | (S >= 3 and totalpoints >= 7) |  |  | 59 |
| 4S | _(unnamed — the Requires expression is the definition)_ | (S_compgame) \| (S >= 2 and totalpoints >= 9) \| (preemptgame('S')) | minhcp=9,maxhcp=18 |  | 70 |
| 4N* | RKC | (CanAsk_S_RKC) \| (S_slam) | T=S | RKC0314_S | 90 |
| 5C | Board: 142180, Hand: .8.AKQJT8432.A72 | (cansacrifice('C', false)) |  |  | 50 |
| 5C | Hand: .8.AKQJT8432.A72 (GameEval) | (C_game) |  |  | 51 |
| 5D | Board: 142180, Hand: .8.AKQJT8432.A72 | (cansacrifice('D', false)) |  |  | 50 |
| 5D | Hand: .8.AKQJT8432.A72 (GameEval) | (D_game) |  |  | 51 |
| 5N* | GSForce | (CanAsk_S_GSF) | T=S | GSForce | 145 |
| 6S | To Play | (CanBid6_S) |  |  | 70 |
| 6S | Playing strength: one loser with a real solid suit or an agreed fit | ((realsolid('S') or trump('S')) and losers == 1) | T=S |  | 75 |
| 6S | Slam: own playing strength -- our hand alone rates to take twelve tricks | (monsterslam('S')) | T=S |  | 143 |
| 7S | Playing strength: no losers with a real solid suit or an agreed fit | ((realsolid('S') or trump('S')) and losers <= 0) | T=S |  | 76 |
| 7S | Grand slam: own playing strength -- our hand alone rates to take thirteen tricks | (monstergrand('S')) | T=S |  | 144 |
| 7N | To Play | (CanBid7NT) |  |  | 140 |

#### `3S-4C`

| Call | Means | Requires | Post-condition | Convention | Pri |
|---|---|---|---|---|---|
| P | _(unnamed — the Requires expression is the definition)_ | (not game) |  |  |  |
| 4S | _(unnamed — the Requires expression is the definition)_ | (S >= 3 and S_points >= 10) \| (S_compgame) \| (preemptgame('S')) |  |  | 70 |

#### `3S-4D`

_Same rule set as `3S-4C` — the service returns an identical table for this position._

#### `3S-4H`

| Call | Means | Requires | Post-condition | Convention | Pri |
|---|---|---|---|---|---|
| P | _(unnamed — the Requires expression is the definition)_ | (true) |  |  |  |
| 4S | Board: 714968, Hand: 8742..QJ742.AJ42 | (cansacrifice('S') or S_compgame) |  |  | 9 |
| 4S | _(unnamed — the Requires expression is the definition)_ | (S >= 3 and hcp >= 10) \| (S >= 2 and hcp >= 14) \| (S >= 1 and hcp >= 16) \| (S_compgame) \| (preemptgame('S')) |  |  | 70 |
| 5S | Board: T478361, Hand: AK74.AT7.J.AQ973 [MS=4-missed-game-implicit-fit(target=4H,fit=10,unlimited)] | (cansacrifice('S')) \| (S_compgame) |  |  | 45 |
| X | _(unnamed — the Requires expression is the definition)_ | (penalty) |  |  | 10 |

#### `3S-4S`

_Same rule set as `3H-4H` — the service returns an identical table for this position._

#### `3S-6C`

_Same rule set as `3H-6C` — the service returns an identical table for this position._

#### `3S-6D`

_Same rule set as `3H-6C` — the service returns an identical table for this position._

#### `3S-6H`

_Same rule set as `3H-6S` — the service returns an identical table for this position._

#### `3S-3N`

| Call | Means | Requires | Post-condition | Convention | Pri |
|---|---|---|---|---|---|
| P | _(unnamed — the Requires expression is the definition)_ | (not game) |  |  |  |
| 4C | Board: DailyMP2026-08-21Field_aa4b1a3f_b8_t5 | (fourlevelovercall('C') or cansacrifice('C')) | maxhcp = 15 |  | 31 |
| 4D | Board: DailyMP2026-08-21Field_aa4b1a3f_b8_t5 | (fourlevelovercall('D') or cansacrifice('D')) | maxhcp = 15 |  | 31 |
| 4S | _(unnamed — the Requires expression is the definition)_ | (preemptgame('S')) |  |  | 10 |

#### `3S-4N`

_Same rule set as `3H-4N` — the service returns an identical table for this position._

#### `4C-P`

| Call | Means | Requires | Post-condition | Convention | Pri |
|---|---|---|---|---|---|
| P | _(unnamed — the Requires expression is the definition)_ | (hcp <= 16 or aces <= 1) |  |  |  |
| 4H | _(unnamed — the Requires expression is the definition)_ | (H >= 7 and totalpoints >= 17) |  |  | 70 |
| 4S | _(unnamed — the Requires expression is the definition)_ | (S >= 7 and totalpoints >= 17) |  |  | 70 |
| 4N* | _(unnamed — the Requires expression is the definition)_ | (coverslam('C')) | T=C | RKC0314_C | 76 |
| 4N* | RKC | (CanAsk_C_RKC) \| (C_slam) | T=C | RKC0314_C | 80 |
| 5C | _(unnamed — the Requires expression is the definition)_ | (C >= 3 and not slammish ) \| (aces == 2 and hcp>= 16 or aces == 3 and hcp<= 17) \| (C_compgame) \| (preemptgame('C') or covergame('C')) | minhcp=5, maxhcp=18 |  | 69 |
| 5N* | GSForce | (CanAsk_C_GSF) | T=C | GSForce | 135 |
| 6C | _(unnamed — the Requires expression is the definition)_ | (C >= 1 and aces >= 4 ) \| (C >= 2 and aces >= 4 ) \| (C >= 2 and hcp>= 20 ) \| (aces == 3 and hcp>= 18 ) |  |  | 55 |
| 6C | To Play | (CanBid6_C) |  |  | 60 |
| 6C | Playing strength: one loser with a real solid suit or an agreed fit | ((realsolid('C') or trump('C')) and losers == 1) | T=C |  | 65 |
| 6C | Slam: own playing strength -- our hand alone rates to take twelve tricks | (monsterslam('C')) | T=C |  | 133 |
| 7C | _(unnamed — the Requires expression is the definition)_ | (aces == 4 and hcp>= 20 ) |  |  | 58 |
| 7C | Playing strength: no losers with a real solid suit or an agreed fit | ((realsolid('C') or trump('C')) and losers <= 0) | T=C |  | 66 |
| 7C | Grand slam: own playing strength -- our hand alone rates to take thirteen tricks | (monstergrand('C')) | T=C |  | 134 |
| 7N | To Play | (CanBid7NT) |  |  | 130 |

#### `4C-X`

_Same rule set as `4C-P` — the service returns an identical table for this position._

#### `4C-4H`

| Call | Means | Requires | Post-condition | Convention | Pri |
|---|---|---|---|---|---|
| P | _(unnamed — the Requires expression is the definition)_ | (true) |  |  |  |
| 5C | Board: T724877, Hand: AT8.AJT7.J972.A9 | (cansacrifice('C') or C_compgame) |  |  | 50 |
| 5C | Hand: AQJ5.8764.9.Q654 (GameEval) | (cansacrifice('C')) |  |  | 51 |
| 5C | _(unnamed — the Requires expression is the definition)_ | (C_compgame) \| (preemptgame('C')) |  |  | 70 |
| 5D | Board: 722642, Hand: QT2.A95.KQJT872. | (cansacrifice('D')) |  |  | 52 |
| 5S | Hand: J9.AKQJT972.K8.3 (GameEval) | (cansacrifice('S')) |  |  | 43 |
| X | _(unnamed — the Requires expression is the definition)_ | (penalty) |  |  | 10 |

#### `4C-4S`

| Call | Means | Requires | Post-condition | Convention | Pri |
|---|---|---|---|---|---|
| P | _(unnamed — the Requires expression is the definition)_ | (true) |  |  |  |
| 5C | Board: T724877, Hand: AT8.AJT7.J972.A9 | (cansacrifice('C') or C_compgame) |  |  | 50 |
| 5C | Hand: AQJ5.8764.9.Q654 (GameEval) | (cansacrifice('C')) |  |  | 51 |
| 5C | _(unnamed — the Requires expression is the definition)_ | (C_compgame) \| (preemptgame('C')) |  |  | 70 |
| 5D | Board: 722642, Hand: QT2.A95.KQJT872. | (cansacrifice('D')) |  |  | 52 |
| 5H | Hand: J9.AKQJT972.K8.3 (GameEval) | (cansacrifice('H')) |  |  | 43 |
| X | _(unnamed — the Requires expression is the definition)_ | (penalty) |  |  | 10 |

#### `4C-5C`

| Call | Means | Requires | Post-condition | Convention | Pri |
|---|---|---|---|---|---|
| P | Let partner decide | (true) |  | MichaelsCuebid4XDefence |  |

#### `4D-P`

| Call | Means | Requires | Post-condition | Convention | Pri |
|---|---|---|---|---|---|
| P | _(unnamed — the Requires expression is the definition)_ | (hcp <= 16 or aces <= 1) |  |  |  |
| 4H | _(unnamed — the Requires expression is the definition)_ | (H >= 7 and totalpoints >= 17) |  |  | 70 |
| 4S | _(unnamed — the Requires expression is the definition)_ | (S >= 7 and totalpoints >= 17) |  |  | 70 |
| 4N* | _(unnamed — the Requires expression is the definition)_ | (coverslam('D')) | T=D | RKC0314_D | 76 |
| 4N* | RKC | (CanAsk_D_RKC) \| (D_slam) | T=D | RKC0314_D | 80 |
| 5D | _(unnamed — the Requires expression is the definition)_ | (D >= 3 and not slammish ) \| (aces == 2 and hcp>= 16 or aces == 3 and hcp<= 17) \| (D_compgame) \| (preemptgame('D') or covergame('D')) | minhcp=5, maxhcp=18 |  | 69 |
| 5N* | GSForce | (CanAsk_D_GSF) | T=D | GSForce | 135 |
| 6D | _(unnamed — the Requires expression is the definition)_ | (D >= 1 and aces >= 4 ) \| (D >= 2 and aces >= 4 ) \| (D >= 2 and hcp>= 20 ) \| (aces == 3 and hcp>= 18 ) |  |  | 55 |
| 6D | To Play | (CanBid6_D) |  |  | 60 |
| 6D | Playing strength: one loser with a real solid suit or an agreed fit | ((realsolid('D') or trump('D')) and losers == 1) | T=D |  | 65 |
| 6D | Slam: own playing strength -- our hand alone rates to take twelve tricks | (monsterslam('D')) | T=D |  | 133 |
| 7D | _(unnamed — the Requires expression is the definition)_ | (aces == 4 and hcp>= 20 ) |  |  | 58 |
| 7D | Playing strength: no losers with a real solid suit or an agreed fit | ((realsolid('D') or trump('D')) and losers <= 0) | T=D |  | 66 |
| 7D | Grand slam: own playing strength -- our hand alone rates to take thirteen tricks | (monstergrand('D')) | T=D |  | 134 |
| 7N | To Play | (CanBid7NT) |  |  | 130 |

#### `4D-X`

_Same rule set as `4D-P` — the service returns an identical table for this position._

#### `4D-4H`

| Call | Means | Requires | Post-condition | Convention | Pri |
|---|---|---|---|---|---|
| P | _(unnamed — the Requires expression is the definition)_ | (true) |  |  |  |
| 4S | Hand: AKQT9864.53.K2.7 (GameEval) | (cansacrifice('S')) |  |  | 54 |
| 5C | Board: 722642, Hand: QT2.A95.KQJT872. | (cansacrifice('C')) |  |  | 52 |
| 5D | Board: T724877, Hand: AT8.AJT7.J972.A9 | (cansacrifice('D') or D_compgame) |  |  | 50 |
| 5D | Hand: AQJ5.8764.9.Q654 (GameEval) | (cansacrifice('D')) |  |  | 51 |
| 5D | Board: T225276, Hand: AK96.A3.AJ.T8763 | (cansacrifice('D') or D_compgame) |  |  | 52 |
| 5D | _(unnamed — the Requires expression is the definition)_ | (D_compgame) \| (preemptgame('D')) |  |  | 70 |
| 5S | Hand: J9.AKQJT972.K8.3 (GameEval) | (cansacrifice('S')) |  |  | 43 |
| X | _(unnamed — the Requires expression is the definition)_ | (penalty) |  |  | 10 |

#### `4D-4S`

| Call | Means | Requires | Post-condition | Convention | Pri |
|---|---|---|---|---|---|
| P | _(unnamed — the Requires expression is the definition)_ | (true) |  |  |  |
| 5C | Board: 722642, Hand: QT2.A95.KQJT872. | (cansacrifice('C')) |  |  | 52 |
| 5D | Board: T724877, Hand: AT8.AJT7.J972.A9 | (cansacrifice('D') or D_compgame) |  |  | 50 |
| 5D | Hand: AQJ5.8764.9.Q654 (GameEval) | (cansacrifice('D')) |  |  | 51 |
| 5D | _(unnamed — the Requires expression is the definition)_ | (D_compgame) \| (preemptgame('D')) |  |  | 70 |
| 5H | Hand: J9.AKQJT972.K8.3 (GameEval) | (cansacrifice('H')) |  |  | 43 |
| X | _(unnamed — the Requires expression is the definition)_ | (penalty) |  |  | 10 |

#### `4D-5C`

| Call | Means | Requires | Post-condition | Convention | Pri |
|---|---|---|---|---|---|
| P | _(unnamed — the Requires expression is the definition)_ | (true) |  |  |  |
| 5D | _(unnamed — the Requires expression is the definition)_ | (D_compgame) \| (preemptgame('D')) |  |  | 70 |
| X | Board: ?, Hand: KT862.A9.J.J6543 | (penalty) |  |  | 90 |

#### `4D-5D`

_Same rule set as `4C-5C` — the service returns an identical table for this position._

#### `4H-P`

| Call | Means | Requires | Post-condition | Convention | Pri |
|---|---|---|---|---|---|
| P | _(unnamed — the Requires expression is the definition)_ | (aces <= 2 or hcp <= 16) |  |  | 20 |
| 4N* | RKC | (CanAsk_H_RKC) \| (H_slam) | T=H | RKC0314_H | 30 |
| 4N* | RKC -- cover cards absorb partner's losers to twelve tricks | (coverslam('H')) | T=H | RKC0314_H | 76 |
| 5N* | GSForce | (CanAsk_H_GSF) | T=H | GSForce | 85 |
| 6H | To Play | (CanBid6_H) |  |  | 10 |
| 6H | Playing strength: one loser with a real solid suit or an agreed fit | ((realsolid('H') or trump('H')) and losers == 1) | T=H |  | 15 |
| 6H | _(unnamed — the Requires expression is the definition)_ | (aces >= 3 and hcp>= 17) | minhcp=17, maxhcp=20 |  | 30 |
| 6H | Slam: own playing strength -- our hand alone rates to take twelve tricks | (monsterslam('H')) | T=H |  | 83 |
| 7H | Playing strength: no losers with a real solid suit or an agreed fit | ((realsolid('H') or trump('H')) and losers <= 0) | T=H |  | 16 |
| 7H | _(unnamed — the Requires expression is the definition)_ | (aces == 4 and hcp>= 17) | minhcp=17, maxhcp=24 |  | 40 |
| 7H | Grand slam: own playing strength -- our hand alone rates to take thirteen tricks | (monstergrand('H')) | T=H |  | 84 |
| 7N | To Play | (CanBid7NT) |  |  | 80 |

#### `4H-X`

_Same rule set as `4H-P` — the service returns an identical table for this position._

#### `4H-4S`

| Call | Means | Requires | Post-condition | Convention | Pri |
|---|---|---|---|---|---|
| P | Hand: AQ94.53.432.KT87 (PassEval) | (true) |  |  |  |
| 5H | Hand: AQ63.532.T9875.5 (GameEval) | (cansacrifice('H')) |  |  | 43 |
| X | Hand: AQT63.J.6532.A87 (PenaltyDouble) | (penalty) |  |  | 90 |

#### `4H-5C`

| Call | Means | Requires | Post-condition | Convention | Pri |
|---|---|---|---|---|---|
| P | _(unnamed — the Requires expression is the definition)_ | (true) |  |  |  |
| 5H | Board: 633303, Hand: KT5.A963..AJT732 | (cansacrifice('H')) |  |  | 44 |
| X | Hand: AQ764.84.Q852.K2 (PenaltyDouble) | (penalty) |  |  | 90 |

#### `4H-5D`

_Same rule set as `4H-5C` — the service returns an identical table for this position._

#### `4H-5S`

| Call | Means | Requires | Post-condition | Convention | Pri |
|---|---|---|---|---|---|
| P | _(unnamed — the Requires expression is the definition)_ | (true) |  |  |  |
| X | Hand: A543.86.JT652.J5 (PenaltyDouble) | (penalty) |  |  | 90 |

#### `4H-4N`

| Call | Means | Requires | Post-condition | Convention | Pri |
|---|---|---|---|---|---|
| P | _(unnamed — the Requires expression is the definition)_ | (true) |  | UnusualNT4XDefence |  |
| 5H | Board: 154085, Hand: T98.AKQT.T642.75 | (cansacrifice('H')) |  | UnusualNT4XDefence | 44 |
| 5S | Board: T701920, Hand: .AK876532.AK3.62 [MS=4-missed-game-implicit-fit(target=4H,fit=8,unlimited)] | (cansacrifice('S') or S_compgame) |  | UnusualNT4XDefence | 43 |

#### `4S-P`

| Call | Means | Requires | Post-condition | Convention | Pri |
|---|---|---|---|---|---|
| P | _(unnamed — the Requires expression is the definition)_ | (aces <= 2 or hcp <= 16) |  |  | 20 |
| 4N* | RKC | (CanAsk_S_RKC) \| (S_slam) | T=S | RKC0314_S | 30 |
| 4N* | RKC -- cover cards absorb partner's losers to twelve tricks | (coverslam('S')) | T=S | RKC0314_S | 76 |
| 5N* | GSForce | (CanAsk_S_GSF) | T=S | GSForce | 85 |
| 6S | To Play | (CanBid6_S) |  |  | 10 |
| 6S | Playing strength: one loser with a real solid suit or an agreed fit | ((realsolid('S') or trump('S')) and losers == 1) | T=S |  | 15 |
| 6S | _(unnamed — the Requires expression is the definition)_ | (aces >= 3 and hcp>= 17) | minhcp=17, maxhcp=20 |  | 30 |
| 6S | Slam: own playing strength -- our hand alone rates to take twelve tricks | (monsterslam('S')) | T=S |  | 83 |
| 7S | Playing strength: no losers with a real solid suit or an agreed fit | ((realsolid('S') or trump('S')) and losers <= 0) | T=S |  | 16 |
| 7S | _(unnamed — the Requires expression is the definition)_ | (aces == 4 and hcp>= 17) | minhcp=17, maxhcp=24 |  | 40 |
| 7S | Grand slam: own playing strength -- our hand alone rates to take thirteen tricks | (monstergrand('S')) | T=S |  | 84 |
| 7N | To Play | (CanBid7NT) |  |  | 80 |

#### `4S-X`

| Call | Means | Requires | Post-condition | Convention | Pri |
|---|---|---|---|---|---|
| P | Board: 812272 | (true) |  |  |  |
| 4N* | RKC | (CanAsk_S_RKC) \| (S_slam) | T=S | RKC0314_S | 30 |
| 4N* | RKC -- cover cards absorb partner's losers to twelve tricks | (coverslam('S')) | T=S | RKC0314_S | 76 |
| 5N* | GSForce | (CanAsk_S_GSF) | T=S | GSForce | 85 |
| 6S | To Play | (CanBid6_S) |  |  | 10 |
| 6S | Playing strength: one loser with a real solid suit or an agreed fit | ((realsolid('S') or trump('S')) and losers == 1) | T=S |  | 15 |
| 6S | _(unnamed — the Requires expression is the definition)_ | (aces >= 3 and hcp>= 17) | minhcp=17, maxhcp=20 |  | 30 |
| 6S | Slam: own playing strength -- our hand alone rates to take twelve tricks | (monsterslam('S')) | T=S |  | 83 |
| 7S | Playing strength: no losers with a real solid suit or an agreed fit | ((realsolid('S') or trump('S')) and losers <= 0) | T=S |  | 16 |
| 7S | _(unnamed — the Requires expression is the definition)_ | (aces == 4 and hcp>= 17) | minhcp=17, maxhcp=24 |  | 40 |
| 7S | Grand slam: own playing strength -- our hand alone rates to take thirteen tricks | (monstergrand('S')) | T=S |  | 84 |
| 7N | To Play | (CanBid7NT) |  |  | 80 |

#### `4S-5C`

| Call | Means | Requires | Post-condition | Convention | Pri |
|---|---|---|---|---|---|
| P | _(unnamed — the Requires expression is the definition)_ | (true) |  |  |  |
| 5S | Board: 633303, Hand: KT5.A963..AJT732 | (cansacrifice('S')) |  |  | 44 |
| X | Hand: AQ764.84.Q852.K2 (PenaltyDouble) | (penalty) |  |  | 90 |

#### `4S-5D`

_Same rule set as `4S-5C` — the service returns an identical table for this position._

#### `4S-5H`

_Same rule set as `4H-5S` — the service returns an identical table for this position._

#### `4S-4N`

| Call | Means | Requires | Post-condition | Convention | Pri |
|---|---|---|---|---|---|
| P | _(unnamed — the Requires expression is the definition)_ | (true) |  | UnusualNT4XDefence |  |
| 5H | Board: T701920, Hand: .AK876532.AK3.62 [MS=4-missed-game-implicit-fit(target=4H,fit=8,unlimited)] | (cansacrifice('H') or H_compgame) |  | UnusualNT4XDefence | 43 |
| 5S | Board: 154085, Hand: T98.AKQT.T642.75 | (cansacrifice('S')) |  | UnusualNT4XDefence | 44 |

#### `5C-P`

| Call | Means | Requires | Post-condition | Convention | Pri |
|---|---|---|---|---|---|
| P | Board: 866835, Hand: AK95.AKJ..AKQ752 | (true) |  |  |  |
| 6C | Board: 866835, Hand: AK95.AKJ..AKQ752 | (CanBid6_C) |  |  | 10 |
| 6N | Board: 866835, Hand: AK95.AKJ..AKQ752 | (CanBid6Nt) |  |  | 5 |

#### `5C-X`

_Same rule set as `5C-P` — the service returns an identical table for this position._

#### `5C-5H`

| Call | Means | Requires | Post-condition | Convention | Pri |
|---|---|---|---|---|---|
| P | _(unnamed — the Requires expression is the definition)_ | (true) |  |  |  |
| X | Board: 124877, Hand: AT8.AJT7.J972.A9 | (penalty) |  |  | 90 |

#### `5C-5S`

_Same rule set as `5C-5H` — the service returns an identical table for this position._

#### `5D-P`

| Call | Means | Requires | Post-condition | Convention | Pri |
|---|---|---|---|---|---|
| P | Board: 866835, Hand: AK95.AKJ..AKQ752 | (true) |  |  |  |
| 6D | Board: 866835, Hand: AK95.AKJ..AKQ752 | (CanBid6_D) |  |  | 10 |
| 6N | Board: 866835, Hand: AK95.AKJ..AKQ752 | (CanBid6Nt) |  |  | 5 |

#### `5D-X`

_Same rule set as `5D-P` — the service returns an identical table for this position._

#### `5D-5H`

_Same rule set as `5C-5H` — the service returns an identical table for this position._

#### `5D-5S`

_Same rule set as `5C-5H` — the service returns an identical table for this position._

#### `5H-P`

| Call | Means | Requires | Post-condition | Convention | Pri |
|---|---|---|---|---|---|
| P | Board: 866835, Hand: AK95.AKJ..AKQ752 | (true) |  |  |  |
| 6C | Board: 866835, Hand: AK95.AKJ..AKQ752 | (CanBid6_C) |  |  | 10 |
| 6D | Board: 866835, Hand: AK95.AKJ..AKQ752 | (CanBid6_D) |  |  | 10 |

#### `5H-X`

_Same rule set as `5H-P` — the service returns an identical table for this position._

#### `5H-5S`

| Call | Means | Requires | Post-condition | Convention | Pri |
|---|---|---|---|---|---|
| P | Board: T121896 | (true) |  |  |  |

#### `5S-P`

_Same rule set as `5H-P` — the service returns an identical table for this position._

#### `5S-X`

_Same rule set as `5H-P` — the service returns an identical table for this position._

#### `6C-P`

| Call | Means | Requires | Post-condition | Convention | Pri |
|---|---|---|---|---|---|
| P | _(unnamed — the Requires expression is the definition)_ | (true) |  |  | 10 |

#### `6C-X`

_Same rule set as `6C-P` — the service returns an identical table for this position._

#### `6D-P`

_Same rule set as `6C-P` — the service returns an identical table for this position._

#### `6D-X`

_Same rule set as `6C-P` — the service returns an identical table for this position._

#### `6H-P`

_Same rule set as `6C-P` — the service returns an identical table for this position._

#### `6H-X`

_Same rule set as `6C-P` — the service returns an identical table for this position._

#### `6S-P`

_Same rule set as `6C-P` — the service returns an identical table for this position._

#### `6S-X`

_Same rule set as `6C-P` — the service returns an identical table for this position._

#### `7C-P`

_Same rule set as `6C-P` — the service returns an identical table for this position._

#### `7C-X`

_Same rule set as `6C-P` — the service returns an identical table for this position._

#### `7D-P`

_Same rule set as `6C-P` — the service returns an identical table for this position._

#### `7D-X`

_Same rule set as `6C-P` — the service returns an identical table for this position._

#### `7H-P`

_Same rule set as `6C-P` — the service returns an identical table for this position._

#### `7H-X`

_Same rule set as `6C-P` — the service returns an identical table for this position._

#### `7S-P`

_Same rule set as `6C-P` — the service returns an identical table for this position._

#### `7S-X`

_Same rule set as `6C-P` — the service returns an identical table for this position._

#### `1N-P`

| Call | Means | Requires | Post-condition | Convention | Pri |
|---|---|---|---|---|---|
| P | 0-7 HCP, no 5-card Major to transfer, or other non-fitting hand | (hcp < 8) |  |  |  |
| 2C* | Asking for majors | ((H == 4 or S == 4) and hcp >= 8 and H + S <= 8) \| (hcp >= 8 and hcp <= 9) |  | Stayman | 80 |
| 2C* | Smolen: Asking for majors with 5-4 | (hcp >= 10 and spades >= 4 and hearts >= 4 and hearts + spades >= 9) |  | Stayman | 100 |
| 2D* | Jacoby, Transfer to Hearts (5+ Hearts) | (H >= 5) \| (H >= 5 and S>= 5 and hcp< 9 and hcp> 6) |  | JacobyTransfer | 95 |
| 2H* | Jacoby, Transfer to Spades (5+ Spades) | (S >= 5) |  | JacobyTransfer | 90 |
| 2S* | MinorStayman -- both minors, no 4-card major | (C >= 5 and D >= 4 and H <= 3 and S <= 3 and totalpoints >= 10) \| (D >= 5 and C >= 4 and H <= 3 and S <= 3 and totalpoints >= 10) | GF | MinorStayman | 80 |
| 2S* | MinorStayman -- 4-4 minors with slam interest | (C >= 4 and D >= 4 and H <= 3 and S <= 3 and totalpoints >= 15) | GF | MinorStayman | 80 |
| 2N* | MinorTransfer | (C >= 6 and (hcp >= 13 or hcp <= 7)) | minhcp=0 | MinorTransfer | 80 |
| 3C* | MinorTransfer | (D >= 6 and (hcp >= 13 or hcp <= 7)) | minhcp=0 | MinorTransfer | 80 |
| 3D* | Splinter | (D <= 1 and H == 4 and S == 4 and CombinedHcpMin >= 23 and C >= 4) |  | SplinterOver1N | 120 |
| 3H* | Splinter | (H <= 1 and S == 4 and CombinedHcpMin >= 23 and C >= 3 and D >= 3) |  | SplinterOver1N | 120 |
| 3S* | Splinter | (S <= 1 and H == 4 and CombinedHcpMin >= 23 and C >= 3 and D >= 3) |  | SplinterOver1N | 120 |
| 3N | To Play, 10+ HCP, no 5-card Major | (hcp>= 8 and C >= 7 and not slammish) \| (hcp>= 8 and D >= 7 and not slammish) \| (hcp>= 10 and H < 5 and S < 5 and not slammish) \| (hcp>= 8 and hcp<= 10 and C >= 6 and (IsGoodSuit('C') or HasTopHonors('C', 3, 5))) \| (hcp>= 8 and hcp<= 10 and D >= 6 and (IsGoodSuit('D') or HasTopHonors('D', 3, 5))) |  |  | 86 |
| 4C* | Gerber | (slammish) |  | Gerber | 20 |
| 4D* | Texas Transfer to Hearts | (hearts >= 6 and ((not slammish and heartgame) or (slammish))) | T=H | Texas | 120 |
| 4H* | Texas Transfer to Spades | (spades >= 6 and ((not slammish and spadegame) or (slammish))) | T=S | Texas | 120 |
| 4S | _(unnamed — the Requires expression is the definition)_ | (false) |  |  | -1 |
| 4N | Quantitative | (CanBid4N_Quant) |  | Quantitative | 40 |
| 5N* | GSForce | (CanBid5N_GSForce) |  | GSForce | 72 |
| 6N | To Play | (CanBid6NT) |  |  | 71 |
| 7N | To Play | (CanBid7NT) |  |  | 74 |

#### `2N-P`

| Call | Means | Requires | Post-condition | Convention | Pri |
|---|---|---|---|---|---|
| P | 0-3 HCP, no 5-card Major | (hcp < 4) |  |  | 10 |
| 3C* | Asking for majors | ((H >= 4 or S >= 4) and CombinedPointsMin >= 23) |  | Stayman2N | 80 |
| 3C* | Smolen: Asking for majors with 5-4 | (hcp >= 4 and spades >= 4 and hearts >= 4 and hearts + spades >= 9) |  | Stayman2N | 100 |
| 3D* | Jacoby, Transfer to Hearts (5+ Hearts) | (H >= 5) |  | JacobyTransfer2N | 90 |
| 3H* | Jacoby, Transfer to Spades (5+ Spades) | (S >= 5) |  | JacobyTransfer2N | 90 |
| 3S* | MinorStayman | (C >= 4 and D >= 4 and CombinedPointsMin >= 31 ) \| (C >= 5 and D >= 5 and CombinedPointsMin >= 25) |  | MinorStayman2N | 80 |
| 3N | Nat | (hcp > 3 and not slammish) |  |  | 50 |
| 4C* | Gerber | (slammish) |  | Gerber | 22 |
| 4D* | Texas Transfer to Hearts | (hearts >= 6 and ((not slammish and totalpoints >= 4) or (slammish))) | T=H | Texas | 120 |
| 4H* | Texas Transfer to Spades | (spades >= 6 and ((not slammish and totalpoints >= 4) or (slammish))) | T=S | Texas | 120 |
| 4N | Quantitative | (CanBid4N_Quant) |  | Quantitative | 60 |
| 5N* | GSForce | (CanBid5N_GSForce) |  | GSForce | 92 |
| 6N | To Play | (CanBid6NT) |  |  | 91 |
| 7N | To Play | (CanBid7NT) |  |  | 94 |

#### `3N-P`

| Call | Means | Requires | Post-condition | Convention | Pri |
|---|---|---|---|---|---|
| P | _(unnamed — the Requires expression is the definition)_ | (hcp <= 7) |  |  |  |
| 4C* | Gerber | (slammish) |  | Gerber | 22 |
| 4D* | Texas Transfer to Hearts | (hearts >= 6) | T=H | Texas | 120 |
| 4H* | Texas Transfer to Spades | (spades >= 6) | T=S | Texas | 120 |
| 4N | Quantitative | (CanBid4N_Quant) |  | Quantitative | 30 |
| 5N* | GSForce | (CanBid5N_GSForce) |  | GSForce | 62 |
| 6C | Hand: 6.J76.QT9732.J85 (GameEval) | (C_slam) | T=C |  | 71 |
| 6D | Hand: 6.J76.QT9732.J85 (GameEval) | (D_slam) | T=D |  | 71 |
| 6N | To Play | (CanBid6NT) |  |  | 61 |
| 7N | To Play | (CanBid7NT) |  |  | 64 |

#### `6N-P`

_Same rule set as `6C-P` — the service returns an identical table for this position._

#### `7N-P`

_Same rule set as `6C-P` — the service returns an identical table for this position._

#### `1N-X`

| Call | Means | Requires | Post-condition | Convention | Pri |
|---|---|---|---|---|---|
| P | _(unnamed — the Requires expression is the definition)_ | (true) |  |  |  |
| 2C* | Asking for majors | ((H == 4 or S == 4) and hcp >= 8 and H + S <= 8) \| (hcp >= 8 and hcp <= 9) |  | Stayman | 80 |
| 2C* | Smolen: Asking for majors with 5-4 | (hcp >= 10 and spades >= 4 and hearts >= 4 and hearts + spades >= 9) |  | Stayman | 100 |
| 2D* | Jacoby, Transfer to Hearts (5+ Hearts) | (H >= 5) \| (H >= 5 and S>= 5 and hcp< 9 and hcp> 6) |  | JacobyTransfer | 95 |
| 2H* | Jacoby, Transfer to Spades (5+ Spades) | (S >= 5) |  | JacobyTransfer | 90 |
| 2S* | MinorStayman -- both minors, no 4-card major | (C >= 5 and D >= 4 and H <= 3 and S <= 3 and totalpoints >= 10) \| (D >= 5 and C >= 4 and H <= 3 and S <= 3 and totalpoints >= 10) | GF | MinorStayman | 80 |
| 2S* | MinorStayman -- 4-4 minors with slam interest | (C >= 4 and D >= 4 and H <= 3 and S <= 3 and totalpoints >= 15) | GF | MinorStayman | 80 |
| 2N* | MinorTransfer | (C >= 6 and (hcp >= 13 or hcp <= 7)) | minhcp=0 | MinorTransfer | 80 |
| 3C* | MinorTransfer | (D >= 6 and (hcp >= 13 or hcp <= 7)) | minhcp=0 | MinorTransfer | 80 |
| 3D* | Splinter | (D <= 1 and H == 4 and S == 4 and CombinedHcpMin >= 23 and C >= 4) |  | SplinterOver1N | 120 |
| 3H* | Splinter | (H <= 1 and S == 4 and CombinedHcpMin >= 23 and C >= 3 and D >= 3) |  | SplinterOver1N | 120 |
| 3S* | Splinter | (S <= 1 and H == 4 and CombinedHcpMin >= 23 and C >= 3 and D >= 3) |  | SplinterOver1N | 120 |
| 3N | Board: 412018, Hand: QT2.5.T65.AKJ853 | (game and not slammish and stoppersOK) |  |  | 19 |
| 3N | _(unnamed — the Requires expression is the definition)_ | (hcp >= 11) |  |  | 20 |
| 4C* | Gerber | (slammish) |  | Gerber | 20 |
| 4D* | Texas Transfer to Hearts | (hearts >= 6 and ((not slammish and heartgame) or (slammish))) | T=H | Texas | 120 |
| 4H* | Texas Transfer to Spades | (spades >= 6 and ((not slammish and spadegame) or (slammish))) | T=S | Texas | 120 |
| 4N | Quantitative | (CanBid4N_Quant) |  | Quantitative | 70 |
| 5N* | GSForce | (CanBid5N_GSForce) |  | GSForce | 102 |
| 6N | To Play | (CanBid6NT) |  |  | 101 |
| 7N | To Play | (CanBid7NT) |  |  | 104 |
| XX* | Long minor | (C >= 5 and hcp <= 3) \| (D >= 5 and hcp <= 3) \| (C >= 6 and hcp <= 5 and not C_compgame) \| (D >= 6 and hcp <= 5 and not D_compgame) |  |  | 90 |

#### `6N-X`

_Same rule set as `6C-P` — the service returns an identical table for this position._

#### `7N-X`

| Call | Means | Requires | Post-condition | Convention | Pri |
|---|---|---|---|---|---|
| P | Penalty | (true) |  |  |  |

#### `1N-2C`

| Call | Means | Requires | Post-condition | Convention | Pri |
|---|---|---|---|---|---|
| P | _(unnamed — the Requires expression is the definition)_ | (true) \| (nogame) |  |  |  |
| 2D* | Jacoby, Transfer to Hearts (5+ Hearts) | (H >= 5 and heartpoints >= 6) |  | JacobyTransfer | 90 |
| 2H* | Jacoby, Transfer to Spades (5+ Spades) | (S >= 5 and spadepoints >= 6) |  | JacobyTransfer | 90 |
| 2S* | MinorStayman -- both minors, no 4-card major | (C >= 5 and D >= 4 and H <= 3 and S <= 3 and totalpoints >= 10) \| (D >= 5 and C >= 4 and H <= 3 and S <= 3 and totalpoints >= 10) | GF | MinorStayman | 80 |
| 2S* | MinorStayman -- 4-4 minors with slam interest | (C >= 4 and D >= 4 and H <= 3 and S <= 3 and totalpoints >= 15) | GF | MinorStayman | 80 |
| 2N* | MinorTransfer | (C >= 6 and (hcp >= 13 or (hcp >= 4 and hcp<= 7))) | minhcp=0 | MinorTransfer | 80 |
| 3C* | MinorTransfer | (D >= 6 and (hcp >= 13 or (hcp >= 4 and hcp<= 7))) | minhcp=0 | MinorTransfer | 80 |
| 3D* | Splinter | (D <= 1 and H == 4 and S == 4 and CombinedHcpMin >= 23 and C >= 4) |  | SplinterOver1N | 120 |
| 3H* | Splinter | (H <= 1 and S == 4 and CombinedHcpMin >= 23 and C >= 3 and D >= 3) |  | SplinterOver1N | 120 |
| 3S* | Splinter | (S <= 1 and H == 4 and CombinedHcpMin >= 23 and C >= 3 and D >= 3) |  | SplinterOver1N | 120 |
| 3N | Board: T1030197, Hand: J85.53.J86.AK654 [MS=?] [authored] | (NTInvite) |  |  | 1 |
| 3N | Board: 640342, Hand: 84.832.A93.KQT74 [MS=?] | ((game or NT_trickgame) and not slammish and stoppersOK) |  |  | 55 |
| 3N | _(unnamed — the Requires expression is the definition)_ | (hcp >= 8 and C >= 6) \| (hcp >= 8 and D >= 6) \| (game) |  |  | 60 |
| 4C* | Gerber | (slammish) |  | Gerber | 20 |
| 4D* | Texas Transfer to Hearts | (hearts >= 6 and ((not slammish and CombinedHeartPointsMin >= 24) or (slammish))) | T=H | Texas | 120 |
| 4H* | Texas Transfer to Spades | (spades >= 6 and ((not slammish and CombinedSpadePointsMin >= 24) or (slammish))) | T=S | Texas | 120 |
| 4N | Quantitative | (CanBid4N_Quant) |  | Quantitative | 40 |
| 5C | _(unnamed — the Requires expression is the definition)_ | (C_game) |  |  | 50 |
| 5D | _(unnamed — the Requires expression is the definition)_ | (D_game) |  |  | 50 |
| 5N* | GSForce | (CanBid5N_GSForce) |  | GSForce | 72 |
| 6N | To Play | (CanBid6NT) |  |  | 71 |
| 7N | To Play | (CanBid7NT) |  |  | 74 |
| X* | Asking for majors | (NTinvite and not NT_Trickgame) \| ((H == 4 or S == 4) and hcp >= 8 and H + S <= 8) |  | Stayman | 80 |

#### `1N-2D`

| Call | Means | Requires | Post-condition | Convention | Pri |
|---|---|---|---|---|---|
| P | _(unnamed — the Requires expression is the definition)_ | (hcp <= 8) |  |  |  |
| 2N* | Lebensohl1N | (C >= 6 and hcp<= 8 and hcp >= 5) \| (D >= 6 and hcp<= 8 and hcp >= 5) |  | Lebensohl1N | 95 |
| 3H* | Lebensohl1N | (hcp >= 9 and stopper('H') and not stopper('S')) |  | Lebensohl1N | 95 |
| 3S* | Lebensohl1N | (hcp >= 9 and stopper('S') and not stopper('H')) |  | Lebensohl1N | 95 |
| 3N | _(unnamed — the Requires expression is the definition)_ | (hcp >= 9) \| (hcp >= 9 and stoppersOK) |  |  | 100 |
| 4N | Quantitative | (CanBid4N_Quant) |  | Quantitative | 40 |
| 5C | _(unnamed — the Requires expression is the definition)_ | (C >= 7 and C_points >= 10) |  |  | 20 |
| 5D | _(unnamed — the Requires expression is the definition)_ | (D >= 7 and D_points >= 10) |  |  | 20 |
| 5N* | GSForce | (CanBid5N_GSForce) |  | GSForce | 72 |
| 6N | To Play | (CanBid6NT) |  |  | 71 |
| 7N | To Play | (CanBid7NT) |  |  | 74 |

#### `1N-2H`

| Call | Means | Requires | Post-condition | Convention | Pri |
|---|---|---|---|---|---|
| P | _(unnamed — the Requires expression is the definition)_ | (hcp <= 8) |  |  |  |
| 2S | _(unnamed — the Requires expression is the definition)_ | (S >= 5 and hcp <= 6 and hcp >= 4) |  |  | 10 |
| 2N* | Lebensohl1N | (hcp >= 9 and stopper('H')) \| (hcp >= 7 and S >= 5 and hcp <= 8) \| (hcp >= 7 and C >= 5 and hcp <= 8) \| (hcp >= 7 and D >= 5 and hcp <= 8) |  | Lebensohl1N | 95 |
| 3C | _(unnamed — the Requires expression is the definition)_ | (C >= 5 and hcp >= 9) |  |  | 25 |
| 3D | _(unnamed — the Requires expression is the definition)_ | (D >= 5 and hcp >= 9) |  |  | 25 |
| 3S | _(unnamed — the Requires expression is the definition)_ | (S >= 5 and hcp >= 9) |  |  | 35 |
| 3N | _(unnamed — the Requires expression is the definition)_ | (hcp >= 9 and not stopper('H')) |  |  | 20 |
| 4S | _(unnamed — the Requires expression is the definition)_ | (S == 5 and S_Points >= 10 and hcp >= 8) \| (S >= 6 and S_compgame and not slammish) |  |  | 96 |
| 4N | Quantitative | (CanBid4N_Quant) |  | Quantitative | 140 |
| 5N* | GSForce | (CanBid5N_GSForce) |  | GSForce | 172 |
| 6N | To Play | (CanBid6NT) |  |  | 171 |
| 7N | To Play | (CanBid7NT) |  |  | 174 |
| X | _(unnamed — the Requires expression is the definition)_ | (hcp >= 8 and S >= 4 and C >= 2 and D >= 2) |  |  | 15 |

#### `1N-2S`

| Call | Means | Requires | Post-condition | Convention | Pri |
|---|---|---|---|---|---|
| P | _(unnamed — the Requires expression is the definition)_ | (hcp <= 8) |  |  |  |
| 2N* | Lebensohl1N | (hcp >= 9 and stopper('S')) \| (hcp >= 7 and H >= 5 and hcp <= 8) \| (hcp >= 7 and C >= 5 and hcp <= 8) \| (hcp >= 7 and D >= 5 and hcp <= 8) |  | Lebensohl1N | 95 |
| 3C | _(unnamed — the Requires expression is the definition)_ | (C >= 5 and hcp >= 9) |  |  | 25 |
| 3D | _(unnamed — the Requires expression is the definition)_ | (D >= 5 and hcp >= 9) |  |  | 25 |
| 3H | _(unnamed — the Requires expression is the definition)_ | (H >= 5 and hcp >= 9) |  |  | 35 |
| 3N | _(unnamed — the Requires expression is the definition)_ | (hcp >= 9 and not stopper('S')) |  |  | 20 |
| 4H | _(unnamed — the Requires expression is the definition)_ | (H == 5 and H_Points >= 10 and hcp >= 8) \| (H >= 6 and H_compgame and not slammish) |  |  | 96 |
| 4N | Quantitative | (CanBid4N_Quant) |  | Quantitative | 140 |
| 5N* | GSForce | (CanBid5N_GSForce) |  | GSForce | 172 |
| 6N | To Play | (CanBid6NT) |  |  | 171 |
| 7N | To Play | (CanBid7NT) |  |  | 174 |
| X | _(unnamed — the Requires expression is the definition)_ | (hcp >= 8 and H >= 4 and C >= 2 and D >= 2) |  |  | 15 |

#### `1N-3C`

| Call | Means | Requires | Post-condition | Convention | Pri |
|---|---|---|---|---|---|
| P | _(unnamed — the Requires expression is the definition)_ | (true) \| (hcp <= 8) |  |  | 10 |
| 3D | _(unnamed — the Requires expression is the definition)_ | (D >= 5 and hcp >= 8) | GF |  | 30 |
| 3H | _(unnamed — the Requires expression is the definition)_ | (H >= 5 and H_points >= 10 and hcp<= 15) |  |  | 38 |
| 3S | _(unnamed — the Requires expression is the definition)_ | (S >= 5 and S_points >= 10 and hcp<= 15) |  |  | 38 |
| 3N | _(unnamed — the Requires expression is the definition)_ | (hcp >= 9 and stopper('C')) |  |  | 32 |
| 3N | Board: 436382, Hand: J5.KQJ54.Q843.Q6 | (game and not slammish and stoppersOK) |  |  | 39 |
| 4D | Board: 625475, Hand: 874.A7.73.AJT965 [MS=E-competitive(Clubs)] | ((D >= 6 and competitivevalues) or competitive('D')) \| (D >= 6 and competitivevalues) |  |  | 33 |
| 4H | _(unnamed — the Requires expression is the definition)_ | (H >= 6 and H_points >= 10 and hcp<= 15) |  |  | 50 |
| 4S | _(unnamed — the Requires expression is the definition)_ | (S >= 6 and S_points >= 10 and hcp<= 15) |  |  | 50 |
| 4N | Quantitative | (CanBid4N_Quant) |  | Quantitative | 40 |
| 5D | Hand: Q865.K4.3.AT9832 (GameEval) | (D_game) |  |  | 52 |
| 5N* | GSForce | (CanBid5N_GSForce) |  | GSForce | 72 |
| 6D | Slam in our minor | (D_slam or monsterslam('D') or D_bestslam) | T=D, minhcp=13 |  | 53 |
| 6H | Slam in our minor | (H_slam or monsterslam('H') or H_bestslam) | T=H, minhcp=13 |  | 54 |
| 6S | Slam in our minor | (S_slam or monsterslam('S') or S_bestslam) | T=S, minhcp=13 |  | 54 |
| 6N | To Play | (CanBid6NT) |  |  | 71 |
| 7N | To Play | (CanBid7NT) |  |  | 74 |
| X | T/O | (hcp >= 9 and S >= 4 and H >= 4 and D >= 1) \| (hcp >= 9 and S >= 3 and H >= 3 and D >= 3) \| (hcp >= 9 and S >= 4 and H >= 4 and D >= 3) |  |  | 15 |

#### `2N-3C`

| Call | Means | Requires | Post-condition | Convention | Pri |
|---|---|---|---|---|---|
| P | Hand: AT873.AK2.T543.8 (PassEval) | (true) |  |  |  |
| 3H | Board: T525405, Hand: 4.T98754.8.T9876 | (competitive('H')) |  |  | 24 |
| 3S | Board: T525405, Hand: 4.T98754.8.T9876 | (competitive('S')) |  |  | 24 |
| 3N | Hand: 9843.Q7543.2.K64 (GameEval) | (game and not slammish and stoppersOK) |  |  | 55 |
| 4D | Board: T606698, Hand: J7.5.J74.JT98765 [MS=E-competitive(Clubs)] | ((D >= 6 and competitivevalues) or competitive('D')) |  |  | 31 |
| 4D | Board: T606698, Hand: J7.5.J74.JT98765 | (D >= 6 and competitivevalues) |  |  | 32 |
| 4H | Hand: JT87543.J7.86.76 (GameEval) | (H_game) |  |  | 54 |
| 4S | Hand: JT87543.J7.86.76 (GameEval) | (S_game) |  |  | 54 |
| 5D | Board: 41449, Hand: 96.Q98.K87543.T5 | (D_game) |  |  | 52 |

#### `1N-3D`

| Call | Means | Requires | Post-condition | Convention | Pri |
|---|---|---|---|---|---|
| P | _(unnamed — the Requires expression is the definition)_ | (true) \| (hcp <= 8) |  |  | 10 |
| 3H | _(unnamed — the Requires expression is the definition)_ | (H >= 5 and H_points >= 10 and hcp<= 15) |  |  | 38 |
| 3S | _(unnamed — the Requires expression is the definition)_ | (S >= 5 and S_points >= 10 and hcp<= 15) |  |  | 38 |
| 3N | _(unnamed — the Requires expression is the definition)_ | (hcp >= 9 and stopper('D')) |  |  | 32 |
| 3N | Board: 436382, Hand: J5.KQJ54.Q843.Q6 | (game and not slammish and stoppersOK) |  |  | 39 |
| 4C | Board: 625475, Hand: 874.A7.73.AJT965 [MS=E-competitive(Clubs)] | ((C >= 6 and competitivevalues) or competitive('C')) \| (C >= 6 and competitivevalues) |  |  | 33 |
| 4H | _(unnamed — the Requires expression is the definition)_ | (H >= 6 and H_points >= 10 and hcp<= 15) |  |  | 50 |
| 4S | _(unnamed — the Requires expression is the definition)_ | (S >= 6 and S_points >= 10 and hcp<= 15) |  |  | 50 |
| 4N | Quantitative | (CanBid4N_Quant) |  | Quantitative | 40 |
| 5C | Hand: Q865.K4.3.AT9832 (GameEval) | (C_game) |  |  | 52 |
| 5N* | GSForce | (CanBid5N_GSForce) |  | GSForce | 72 |
| 6C | Slam in our minor | (C_slam or monsterslam('C') or C_bestslam) | T=C, minhcp=13 |  | 53 |
| 6H | Slam in our minor | (H_slam or monsterslam('H') or H_bestslam) | T=H, minhcp=13 |  | 54 |
| 6S | Slam in our minor | (S_slam or monsterslam('S') or S_bestslam) | T=S, minhcp=13 |  | 54 |
| 6N | To Play | (CanBid6NT) |  |  | 71 |
| 7N | To Play | (CanBid7NT) |  |  | 74 |
| X | T/O | (hcp >= 9 and S >= 4 and H >= 4 and C >= 1) \| (hcp >= 9 and S >= 3 and H >= 3 and C >= 3) \| (hcp >= 9 and S >= 4 and H >= 4 and C >= 3) |  |  | 15 |

#### `2N-3D`

| Call | Means | Requires | Post-condition | Convention | Pri |
|---|---|---|---|---|---|
| P | Hand: AT873.AK2.T543.8 (PassEval) | (true) |  |  |  |
| 3H | Board: T525405, Hand: 4.T98754.8.T9876 | (competitive('H')) |  |  | 24 |
| 3S | Board: T525405, Hand: 4.T98754.8.T9876 | (competitive('S')) |  |  | 24 |
| 3N | Hand: 9843.Q7543.2.K64 (GameEval) | (game and not slammish and stoppersOK) |  |  | 55 |
| 4C | Board: T606698, Hand: J7.5.J74.JT98765 [MS=E-competitive(Clubs)] | ((C >= 6 and competitivevalues) or competitive('C')) |  |  | 31 |
| 4C | Board: T606698, Hand: J7.5.J74.JT98765 | (C >= 6 and competitivevalues) |  |  | 32 |
| 4H | Hand: JT87543.J7.86.76 (GameEval) | (H_game) |  |  | 54 |
| 4S | Hand: JT87543.J7.86.76 (GameEval) | (S_game) |  |  | 54 |
| 5C | Board: 41449, Hand: 96.Q98.K87543.T5 | (C_game) |  |  | 52 |

#### `1N-3H`

| Call | Means | Requires | Post-condition | Convention | Pri |
|---|---|---|---|---|---|
| P | _(unnamed — the Requires expression is the definition)_ | (hcp <= 8) |  |  | -3 |
| 3S | Board: 169368, Hand: J97543..T53.6542 | (competitive('S')) |  |  | 24 |
| 3N | _(unnamed — the Requires expression is the definition)_ | (hcp >= 9) \| (hcp >= 9 and stopper('H')) |  |  | 20 |
| 4C | Board: 594933, Hand: 7.743.A3.K987643 | (C >= 6 and hcp >= 8) |  |  | 39 |
| 4C | _(unnamed — the Requires expression is the definition)_ | (C >= 6 and slammish) | slamtry |  | 40 |
| 4D | Board: 594933, Hand: 7.743.A3.K987643 | (D >= 6 and hcp >= 8) |  |  | 39 |
| 4D | _(unnamed — the Requires expression is the definition)_ | (D >= 6 and slammish) | slamtry |  | 40 |
| 4S | Board: 574477, Hand: 4.KT7652.84.AT97 | ((S_compgame and S >= 6) or cansacrifice('S', false)) |  |  | 29 |
| 4S | _(unnamed — the Requires expression is the definition)_ | (S >= 6 and hcp>= 8 and hcp<= 15) |  |  | 30 |
| 4S | Board: 969818, Hand: AKT874.95.T98.87 | ((S_compgame and S >= 6) or cansacrifice('S', false)) |  |  | 54 |
| 4N | Quantitative | (CanBid4N_Quant) |  | Quantitative | 40 |
| 5C | Board: 691474, Hand: 9.2.AQJT5432.J96 | ((C_compgame and C >= 6) or cansacrifice('C', false)) |  |  | 51 |
| 5D | Board: 691474, Hand: 9.2.AQJT5432.J96 | ((D_compgame and D >= 6) or cansacrifice('D', false)) |  |  | 51 |
| 5N* | GSForce | (CanBid5N_GSForce) |  | GSForce | 72 |
| 6C | Slam in our minor | (C_slam or monsterslam('C') or C_bestslam) | T=C, minhcp=13 |  | 53 |
| 6D | Slam in our minor | (D_slam or monsterslam('D') or D_bestslam) | T=D, minhcp=13 |  | 53 |
| 6S | Slam in our minor | (S_slam or monsterslam('S') or S_bestslam) | T=S, minhcp=13 |  | 55 |
| 6N | To Play | (CanBid6NT) |  |  | 71 |
| 7N | To Play | (CanBid7NT) |  |  | 74 |
| X | T/O | (game and S >= 3) \| (hcp >= 9 and S >= 4) \| (hcp >= 9 and S >= 4 and C >= 3 and D >= 3) |  |  | 10 |

#### `2N-3H`

| Call | Means | Requires | Post-condition | Convention | Pri |
|---|---|---|---|---|---|
| P | _(unnamed — the Requires expression is the definition)_ | (true) |  |  |  |
| P | Hand: T75.K.J754.87532 (PassEval) | (true) |  |  |  |
| 3S | Board: 899375, Hand: 986532.82.92.T43 | (competitive('S')) |  |  | 24 |
| 3N | Hand: J652.86.K43.JT72 (GameEval) | (game and not slammish and stoppersOK) |  |  | 55 |
| 4C | Board: 868460, Hand: 74.982.2.KJT8765 [MS=E-competitive(Clubs)] | ((C >= 6 and competitivevalues) or competitive('C')) \| (C >= 6 and competitivevalues) |  |  | 31 |
| 4C | Board: 204070, Hand: 5.J983.K86532.65 [MS=E-competitive(Diamonds)] | ((C >= 6 and competitivevalues) or competitive('C')) |  |  | 31 |
| 4D | Board: 868460, Hand: 74.982.2.KJT8765 [MS=E-competitive(Clubs)] | ((D >= 6 and competitivevalues) or competitive('D')) \| (D >= 6 and competitivevalues) |  |  | 31 |
| 4D | Board: 204070, Hand: 5.J983.K86532.65 [MS=E-competitive(Diamonds)] | ((D >= 6 and competitivevalues) or competitive('D')) |  |  | 31 |
| 4S | Hand: JT98762.T.T4.T95 (GameEval) | (S_game) |  |  | 53 |
| 5C | Hand: 6.J.92.KT8765432 (GameEval) | (C_game and C >= 6) |  |  | 51 |
| 5D | Hand: 6.J.92.KT8765432 (GameEval) | (D_game and D >= 6) |  |  | 51 |

#### `1N-3S`

| Call | Means | Requires | Post-condition | Convention | Pri |
|---|---|---|---|---|---|
| P | _(unnamed — the Requires expression is the definition)_ | (hcp <= 8) |  |  | -3 |
| 3N | _(unnamed — the Requires expression is the definition)_ | (hcp >= 9) \| (hcp >= 9 and stopper('S')) |  |  | 20 |
| 4C | Board: 594933, Hand: 7.743.A3.K987643 | (C >= 6 and hcp >= 8) |  |  | 39 |
| 4C | _(unnamed — the Requires expression is the definition)_ | (C >= 6 and slammish) | slamtry |  | 40 |
| 4D | Board: 594933, Hand: 7.743.A3.K987643 | (D >= 6 and hcp >= 8) |  |  | 39 |
| 4D | _(unnamed — the Requires expression is the definition)_ | (D >= 6 and slammish) | slamtry |  | 40 |
| 4H | Board: 574477, Hand: 4.KT7652.84.AT97 | ((H_compgame and H >= 6) or cansacrifice('H', false)) |  |  | 29 |
| 4H | _(unnamed — the Requires expression is the definition)_ | (H >= 6 and hcp>= 8 and hcp<= 15) |  |  | 30 |
| 4N | Quantitative | (CanBid4N_Quant) |  | Quantitative | 40 |
| 5C | Board: 691474, Hand: 9.2.AQJT5432.J96 | ((C_compgame and C >= 6) or cansacrifice('C', false)) |  |  | 51 |
| 5D | Board: 691474, Hand: 9.2.AQJT5432.J96 | ((D_compgame and D >= 6) or cansacrifice('D', false)) |  |  | 51 |
| 5N* | GSForce | (CanBid5N_GSForce) |  | GSForce | 72 |
| 6C | Slam in our minor | (C_slam or monsterslam('C') or C_bestslam) | T=C, minhcp=13 |  | 53 |
| 6D | Slam in our minor | (D_slam or monsterslam('D') or D_bestslam) | T=D, minhcp=13 |  | 53 |
| 6H | Slam in our minor | (H_slam or monsterslam('H') or H_bestslam) | T=H, minhcp=13 |  | 55 |
| 6N | To Play | (CanBid6NT) |  |  | 71 |
| 7N | To Play | (CanBid7NT) |  |  | 74 |
| X | T/O | (game and H >= 3) \| (hcp >= 9 and H >= 4) \| (hcp >= 9 and H >= 4 and C >= 3 and D >= 3) |  |  | 10 |

#### `2N-3S`

| Call | Means | Requires | Post-condition | Convention | Pri |
|---|---|---|---|---|---|
| P | Hand: T75.K.J754.87532 (PassEval) | (true) |  |  |  |
| 3N | Hand: J652.86.K43.JT72 (GameEval) | (game and not slammish and stoppersOK) |  |  | 55 |
| 4C | Board: 868460, Hand: 74.982.2.KJT8765 [MS=E-competitive(Clubs)] | ((C >= 6 and competitivevalues) or competitive('C')) \| (C >= 6 and competitivevalues) |  |  | 31 |
| 4D | Board: 868460, Hand: 74.982.2.KJT8765 [MS=E-competitive(Clubs)] | ((D >= 6 and competitivevalues) or competitive('D')) \| (D >= 6 and competitivevalues) |  |  | 31 |
| 4H | Hand: JT98762.T.T4.T95 (GameEval) | (H_game) |  |  | 53 |
| 5C | Hand: 6.J.92.KT8765432 (GameEval) | (C_game and C >= 6) |  |  | 51 |
| 5D | Hand: 6.J.92.KT8765432 (GameEval) | (D_game and D >= 6) |  |  | 51 |

#### `1N-4C`

| Call | Means | Requires | Post-condition | Convention | Pri |
|---|---|---|---|---|---|
| P | _(unnamed — the Requires expression is the definition)_ | (hcp <= 9) |  |  |  |
| 4H | _(unnamed — the Requires expression is the definition)_ | (H >= 6 and hcp>= 10 and hcp<= 15) |  |  | 20 |
| 4S | _(unnamed — the Requires expression is the definition)_ | (S >= 6 and hcp>= 10 and hcp<= 15) |  |  | 20 |
| 4N | Quantitative | (CanBid4N_Quant) |  | Quantitative | 40 |
| 5N* | GSForce | (CanBid5N_GSForce) |  | GSForce | 72 |
| 6D | Slam in our minor | (D_slam or monsterslam('D') or D_bestslam) | T=D, minhcp=13 |  | 53 |
| 6H | Slam in our minor | (H_slam or monsterslam('H') or H_bestslam) | T=H, minhcp=13 |  | 55 |
| 6S | Slam in our minor | (S_slam or monsterslam('S') or S_bestslam) | T=S, minhcp=13 |  | 55 |
| 6N | To Play | (CanBid6NT) |  |  | 71 |
| 7N | To Play | (CanBid7NT) |  |  | 74 |
| X | _(unnamed — the Requires expression is the definition)_ | (hcp >= 10) |  |  | 10 |

#### `2N-4C`

| Call | Means | Requires | Post-condition | Convention | Pri |
|---|---|---|---|---|---|
| P | _(unnamed — the Requires expression is the definition)_ | (true) |  |  |  |
| 4H | Hand: T985432.K64.2.53 (GameEval) | (H_game) |  |  | 54 |
| 4S | Hand: T985432.K64.2.53 (GameEval) | (S_game) |  |  | 54 |

#### `3N-4C`

_Same rule set as `2C-4D` — the service returns an identical table for this position._

#### `1N-4D`

| Call | Means | Requires | Post-condition | Convention | Pri |
|---|---|---|---|---|---|
| P | _(unnamed — the Requires expression is the definition)_ | (hcp <= 9) |  |  |  |
| 4H | _(unnamed — the Requires expression is the definition)_ | (H >= 6 and hcp>= 10 and hcp<= 15) |  |  | 20 |
| 4S | _(unnamed — the Requires expression is the definition)_ | (S >= 6 and hcp>= 10 and hcp<= 15) |  |  | 20 |
| 4N | Quantitative | (CanBid4N_Quant) |  | Quantitative | 40 |
| 5N* | GSForce | (CanBid5N_GSForce) |  | GSForce | 72 |
| 6C | Slam in our minor | (C_slam or monsterslam('C') or C_bestslam) | T=C, minhcp=13 |  | 53 |
| 6H | Slam in our minor | (H_slam or monsterslam('H') or H_bestslam) | T=H, minhcp=13 |  | 55 |
| 6S | Slam in our minor | (S_slam or monsterslam('S') or S_bestslam) | T=S, minhcp=13 |  | 55 |
| 6N | To Play | (CanBid6NT) |  |  | 71 |
| 7N | To Play | (CanBid7NT) |  |  | 74 |
| X | _(unnamed — the Requires expression is the definition)_ | (hcp >= 10) |  |  | 10 |

#### `2N-4D`

_Same rule set as `2N-4C` — the service returns an identical table for this position._

#### `3N-4D`

_Same rule set as `2C-4D` — the service returns an identical table for this position._

#### `1N-4H`

| Call | Means | Requires | Post-condition | Convention | Pri |
|---|---|---|---|---|---|
| P | _(unnamed — the Requires expression is the definition)_ | (hcp <= 9) |  |  |  |
| 4N | Quantitative | (CanBid4N_Quant) |  | Quantitative | 40 |
| 5N* | GSForce | (CanBid5N_GSForce) |  | GSForce | 72 |
| 6C | Slam in our minor | (C_slam or monsterslam('C') or C_bestslam) | T=C, minhcp=13 |  | 53 |
| 6D | Slam in our minor | (D_slam or monsterslam('D') or D_bestslam) | T=D, minhcp=13 |  | 53 |
| 6S | Slam in our minor | (S_slam or monsterslam('S') or S_bestslam) | T=S, minhcp=13 |  | 55 |
| 6N | To Play | (CanBid6NT) |  |  | 71 |
| 7N | To Play | (CanBid7NT) |  |  | 74 |
| X | _(unnamed — the Requires expression is the definition)_ | (hcp >= 10) |  |  | 10 |

#### `2N-4H`

| Call | Means | Requires | Post-condition | Convention | Pri |
|---|---|---|---|---|---|
| P | _(unnamed — the Requires expression is the definition)_ | (true) |  |  |  |
| 5C | Hand: 7.J4.T743.QJ9853 (GameEval) | (cansacrifice('C')) |  |  | 51 |
| 5D | Hand: 7.J4.T743.QJ9853 (GameEval) | (cansacrifice('D')) |  |  | 51 |
| 6S | Hand: 2.AT9862.Q943.93 (GameEval) | (S_slam) | T=S |  | 73 |
| X | Hand: AQ872.K.J42.T762 (PenaltyDouble) | (penalty) |  |  | 90 |

#### `3N-4H`

| Call | Means | Requires | Post-condition | Convention | Pri |
|---|---|---|---|---|---|
| P | Board: 120423 | (true) |  |  |  |

#### `1N-4S`

| Call | Means | Requires | Post-condition | Convention | Pri |
|---|---|---|---|---|---|
| P | _(unnamed — the Requires expression is the definition)_ | (hcp <= 9) |  |  |  |
| 4N | Quantitative | (CanBid4N_Quant) |  | Quantitative | 40 |
| 5N* | GSForce | (CanBid5N_GSForce) |  | GSForce | 72 |
| 6C | Slam in our minor | (C_slam or monsterslam('C') or C_bestslam) | T=C, minhcp=13 |  | 53 |
| 6D | Slam in our minor | (D_slam or monsterslam('D') or D_bestslam) | T=D, minhcp=13 |  | 53 |
| 6H | Slam in our minor | (H_slam or monsterslam('H') or H_bestslam) | T=H, minhcp=13 |  | 55 |
| 6N | To Play | (CanBid6NT) |  |  | 71 |
| 7N | To Play | (CanBid7NT) |  |  | 74 |
| X | _(unnamed — the Requires expression is the definition)_ | (hcp >= 10) |  |  | 10 |

#### `2N-4S`

| Call | Means | Requires | Post-condition | Convention | Pri |
|---|---|---|---|---|---|
| P | _(unnamed — the Requires expression is the definition)_ | (true) |  |  |  |
| 5C | Hand: 7.J4.T743.QJ9853 (GameEval) | (cansacrifice('C')) |  |  | 51 |
| 5D | Hand: 7.J4.T743.QJ9853 (GameEval) | (cansacrifice('D')) |  |  | 51 |
| 6H | Hand: 2.AT9862.Q943.93 (GameEval) | (H_slam) | T=H |  | 73 |
| X | Hand: AQ872.K.J42.T762 (PenaltyDouble) | (penalty) |  |  | 90 |

#### `3N-4S`

_Same rule set as `3N-4H` — the service returns an identical table for this position._

#### `1N-2N`

| Call | Means | Requires | Post-condition | Convention | Pri |
|---|---|---|---|---|---|
| P | _(unnamed — the Requires expression is the definition)_ | (not game) |  |  |  |
| 3C* | _(unnamed — the Requires expression is the definition)_ | (H >= 5 and game) |  |  | 10 |
| 3D* | _(unnamed — the Requires expression is the definition)_ | (S >= 5 and game) |  |  | 15 |
| 3H | _(unnamed — the Requires expression is the definition)_ | (bestmajor('H') and H >= 5 and H_points >= 7 and H_points <= 9) |  |  | 20 |
| 3S | _(unnamed — the Requires expression is the definition)_ | (bestmajor('S') and S >= 5 and S_points >= 7 and S_points <= 9) |  |  | 20 |
| 4H | _(unnamed — the Requires expression is the definition)_ | (bestmajor('H') and H >= 6 and H_points >= 10 and not slammish) |  |  | 30 |
| 4S | _(unnamed — the Requires expression is the definition)_ | (bestmajor('S') and S >= 6 and S_points >= 10 and not slammish) |  |  | 30 |
| X | _(unnamed — the Requires expression is the definition)_ | (game) |  |  | 5 |
