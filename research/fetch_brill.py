#!/usr/bin/env python3
"""Snapshot The Brill bidding system into a single markdown file.

    python3 research/fetch_brill.py                  # writes system/brill.md
    python3 research/fetch_brill.py --depth 3        # deeper (much slower)
    python3 research/fetch_brill.py --from-cache x.json

What this does and why it is needed
----------------------------------
The site https://brillsystem.aalborgdata.dk is only TWO static pages:

* `index.html`  -- the prose summary (leads, openings, responding, competing,
  slam bidding, conventions).
* `browse.html` -- a JavaScript shell with no rules in it. It calls
  https://brillservice.aalborgdata.dk/getresponses?auction=<sequence>
  and renders the answer.

Two traps, both of which cost time to find:

1. The server is CATCH-ALL. `/sitemap.xml` and `/robots.txt` both return
   `index.html` with HTTP 200, so pages cannot be discovered by probing and
   there is no sitemap to read.
2. The query parameter is `auction=`, not `bid=`. Passing `bid=` returns the
   44 opening bids for EVERY input, which looks like it works and is wrong.

`/version` reports ruleCount ~1,037,464, so the tree cannot be walked
exhaustively. --depth 2 (the default) fetches every opening and every response
to every opening: 384 auctions, ~3.5k call definitions, under a minute.
--depth 3 is roughly 22,000 auctions -- hours, and a very large file.

Reading a position
------------------
The leading call may be ours or the opponents':

* `1H`   -- the opponents opened 1H and we are to act: overcalls, cue-bids,
            takeout doubles and passes.
* `1H-P` -- our 1H opening, next hand passed, partner to respond.

Both seats therefore appear at every level.

~31% of rows carry no authored description; the `requires` expression is then
the whole definition, and the table says so rather than leaving a blank.
"""
import argparse
import datetime
import html
import json
import os
import re
import sys
import time
import urllib.parse
import urllib.request
from concurrent.futures import ThreadPoolExecutor
from html.parser import HTMLParser

SITE = "https://brillsystem.aalborgdata.dk"
API = "https://brillservice.aalborgdata.dk"
UA = {"User-Agent": "Mozilla/5.0 (compatible; research)"}
REPO_ROOT = os.path.abspath(os.path.join(os.path.dirname(__file__), ".."))


# --------------------------------------------------------------------- fetch
def _get(url, timeout=30, tries=3):
    last = None
    for i in range(tries):
        try:
            req = urllib.request.Request(url, headers=UA)
            with urllib.request.urlopen(req, timeout=timeout) as r:
                return r.read().decode("utf-8", "replace")
        except Exception as e:          # noqa: BLE001 - report and retry
            last = e
            time.sleep(0.6 * (i + 1))
    print(f"  ! {url}: {type(last).__name__}: {last}", file=sys.stderr)
    return None


def get_json(url, **kw):
    raw = _get(url, **kw)
    return json.loads(raw) if raw else None


def fetch_rules(auction, tries=3):
    url = API + "/getresponses?" + urllib.parse.urlencode({"auction": auction})
    raw = _get(url, tries=tries)
    return json.loads(raw) if raw else None


def child(parent, bid):
    """'*' + '1H' -> '1H-*' ;  '1H-*' + '1S' -> '1H-1S-*'."""
    return (parent[:-1] if parent.endswith("*") else parent + "-") + bid + "-*"


def crawl(max_calls, workers, cache_path=None):
    if cache_path and os.path.exists(cache_path):
        print(f"using cache {cache_path}")
        return json.load(open(cache_path))
    t0 = time.time()
    root = fetch_rules("*")
    if root is None:
        sys.exit("could not reach the Brill service")
    out = {"*": root}
    print(f"root: {len(root)} opening responses", flush=True)
    frontier = ["*"]
    for depth in range(1, max_calls + 1):
        targets = sorted({child(p, r["bid"])
                          for p in frontier for r in (out.get(p) or [])
                          if child(p, r["bid"]) not in out})
        print(f"depth {depth}: {len(targets)} auctions "
              f"({time.time()-t0:.0f}s)", flush=True)
        if not targets:
            break
        done = 0
        with ThreadPoolExecutor(max_workers=workers) as ex:
            for auction, data in zip(targets, ex.map(fetch_rules, targets)):
                out[auction] = data
                done += 1
                if done % 250 == 0:
                    print(f"   {done}/{len(targets)}", flush=True)
        print(f"   done ({time.time()-t0:.0f}s)", flush=True)
        frontier = [t for t in targets if out.get(t)]
    if cache_path:
        json.dump(out, open(cache_path, "w"))
        print(f"cached -> {cache_path}")
    return out


# ------------------------------------------------------------------ html->md
SKIP = {"script", "style"}
BLOCK = {"p", "div", "section", "ul", "ol", "table", "tr", "h1", "h2", "h3",
         "h4", "li", "header", "footer"}
HEAD = {"h1": "# ", "h2": "## ", "h3": "### ", "h4": "#### "}


class Markdowniser(HTMLParser):
    def __init__(self):
        super().__init__(convert_charrefs=False)
        self.out, self.buf = [], ""
        self.row, self.rows = [], []
        self.in_table = False
        self.in_skip = 0
        self.list_depth = 0
        self.in_li = False
        self._head = ""

    def flush_buf(self, prefix=""):
        txt = re.sub(r"\s+", " ", self.buf).strip()
        self.buf = ""
        if not txt:
            return
        if self.in_li:
            self.out.append("  " * max(self.list_depth - 1, 0) + "- " + txt)
            self.in_li = False
        else:
            self.out.append(prefix + txt)
        self.out.append("")

    def handle_starttag(self, tag, attrs):
        if tag in SKIP:
            self.in_skip += 1
        elif tag in HEAD:
            self.buf = ""
            self._head = HEAD[tag]
        elif tag == "table":
            self.flush_buf()
            self.in_table, self.rows = True, []
        elif tag == "tr":
            self.row = []
        elif tag in ("td", "th"):
            self.buf = ""
        elif tag == "li":
            self.buf = ""
            self.in_li = True
        elif tag in ("ul", "ol"):
            self.flush_buf()
            self.list_depth += 1
        elif tag == "br":
            self.buf += " "

    def handle_endtag(self, tag):
        if tag in SKIP:
            self.in_skip = max(0, self.in_skip - 1)
        elif tag in HEAD:
            self.flush_buf(self._head)
            self.out.append("")
        elif tag in ("td", "th"):
            self.row.append(re.sub(r"\s+", " ", self.buf).strip())
            self.buf = ""
        elif tag == "tr":
            if self.row:
                self.rows.append(self.row)
            self.row = []
        elif tag == "table":
            self._emit_table()
            self.in_table = False
        elif tag == "li":
            if self.buf.strip():
                self.flush_buf()
            self.in_li = False
        elif tag in ("ul", "ol"):
            self.flush_buf()
            self.list_depth = max(0, self.list_depth - 1)
            if self.list_depth == 0:
                self.out.append("")
        elif tag in BLOCK:
            self.flush_buf()

    def handle_data(self, data):
        if not self.in_skip:
            self.buf += data

    def handle_entityref(self, name):
        self.buf += html.unescape("&%s;" % name)

    def handle_charref(self, name):
        self.buf += html.unescape("&#%s;" % name)

    def _emit_table(self):
        if not self.rows:
            return
        head, body = self.rows[0], self.rows[1:]
        self.out.append("| " + " | ".join(head) + " |")
        self.out.append("|" + "|".join(["---"] * len(head)) + "|")
        for r in body:
            self.out.append("| " + " | ".join((r + [""] * len(head))[:len(head)]) + " |")
        self.out.append("")


def html_to_markdown(raw):
    body = raw[raw.find("<body"):]
    p = Markdowniser()
    p.feed(body)
    p.flush_buf()
    return re.sub(r"\n{3,}", "\n\n", "\n".join(p.out)).strip() + "\n"


# ------------------------------------------------------------------ ordering
_STRAIN = {"C": 0, "D": 1, "H": 2, "S": 3, "N": 4}


def _bid_rank(tok):
    tok = tok.rstrip("*")
    if tok == "P":
        return (0, 0)
    if tok in ("X", "R"):
        return (0, 1)
    m = re.match(r"^(\d)(NT|[SHDC])$", tok)
    return (int(m.group(1)), _STRAIN.get(m.group(2)[0], 9)) if m else (99, 0)


def auction_key(a):
    toks = [t for t in (a[:-2] if a.endswith("-*") else a).split("-") if t]
    return (len(toks), [_bid_rank(t) for t in toks], toks)


def cell(s):
    return re.sub(r"\s+", " ", str(s or "").replace("|", r"\|").replace("\n", " ")).strip()


UNNAMED = "_(unnamed — the Requires expression is the definition)_"


def table(rows):
    out = ["| Call | Means | Requires | Post-condition | Convention | Pri |",
           "|---|---|---|---|---|---|"]
    for r in rows:
        means = (r.get("resolvedMeans") or r.get("means") or "").strip()
        out.append("| {} | {} | {} | {} | {} | {} |".format(
            cell(r.get("displayBid") or r.get("bid")),
            cell(means) or UNNAMED,
            cell(r.get("requires")),
            cell(r.get("postCondition")),
            cell(r.get("convention")),
            cell(r.get("priority"))))
    out.append("")
    return out


# --------------------------------------------------------------------- build
def build(rules, doc_md, ver, out_path):
    lines = doc_md.splitlines()
    doc = []
    for line in lines:
        if line.strip() == "# The Brill bidding system":
            continue
        if re.match(r"^#{1,4} ", line):
            line = "#" + line
        doc.append(line)
    doc = re.sub(r"\n{3,}", "\n\n", "\n".join(doc)).strip()

    auctions = sorted((a for a in rules if rules[a]), key=auction_key)
    n_rows = sum(len(v) for v in rules.values() if v)
    n_empty = sum(1 for v in rules.values() if v == [])
    n_unnamed = sum(1 for v in rules.values() if v
                    for r in v
                    if not (r.get("resolvedMeans") or r.get("means") or "").strip())
    rc = ver.get("ruleCount")
    rc_s = f"{rc:,}" if rc else "?"

    L = ["# The Brill bidding system", "",
         "> Merged, single-file snapshot of the Brill bidding system.", ">",
         f"> - **Source pages:** <{SITE}/index.html> (system summary) and "
         f"<{SITE}/browse.html> (rule browser)",
         f"> - **Rule data:** `GET {API}/getresponses?auction=<sequence>` — "
         "the endpoint `browse.html` itself calls.",
         f"> - **Fetched:** {datetime.date.today():%Y-%m-%d}",
         "> - **Service:** {} · {} · {} rules in the engine".format(
             ver.get("systemName", "Brill"), ver.get("version", "unknown"), rc_s),
         "> - **Scope:** the complete tree to **{} calls** deep — {} auctions, "
         "{} call definitions.".format(args.depth, len(rules), n_rows),
         ">",
         f"> The engine reports **{rc_s}** rules in total, so the tree cannot be "
         f"walked exhaustively. {n_empty} auctions here are terminal (a 7-level "
         f"call ends the bidding). {n_unnamed} rows carry no authored "
         "description; the `requires` expression is then the whole definition. "
         "Regenerate with `python3 research/fetch_brill.py`.",
         "", "## Contents", "",
         "- [Part 1 — System summary](#part-1--system-summary) — prose: "
         "openings, responding, competing, slam bidding, conventions, leads "
         "and signals.",
         "- [Part 2 — Rule tree](#part-2--rule-tree) — every call the system "
         "defines, with the requirement it was authored from.",
         "", "---", "", "## Part 1 — System summary", "", doc, "", "---", "",
         "## Part 2 — Rule tree", "",
         "Each table is one auction position; the rows are every call the "
         "system defines there, with the `requires` expression that guards it. "
         "A `*` after a call marks it artificial. `P` is pass, `X` is double.",
         "",
         "**How to read a position.** The leading call may be ours or the "
         "opponents', and the rows say which:",
         "",
         "- `1H` — the opponents opened 1H and we are to act. The rows are our "
         "competitive calls: overcalls, Michaels cue-bids, takeout doubles, "
         "and passes.",
         "- `1H-P` — our side opened 1H, the next hand passed, and partner is "
         "to respond. The rows are the responding hands.",
         "",
         "So both seats appear at every level: the bare sequence is the "
         "competitive one, and the same sequence with the intervening pass is "
         "our constructive auction.", ""]

    prev = None
    for a in auctions:
        depth = auction_key(a)[0]
        if depth != prev:
            L += ["### " + {0: "Opening bids", 1: "Responses (one call made)",
                            2: "Continuations (two calls made)",
                            3: "Continuations (three calls made)"}.get(
                                depth, f"{depth} calls"), ""]
            prev = depth
        L.append("#### `{}`".format("*" if a == "*" else a.rstrip("-*")))
        L.append("")
        if rules[a]:
            L += table(rules[a])
        else:
            L += ["_No continuations defined — this call ends the auction._", ""]

    text = re.sub(r"\n{4,}", "\n\n\n", "\n".join(L)).rstrip() + "\n"
    with open(out_path, "w", encoding="utf-8") as f:
        f.write(text)
    print(f"wrote {out_path}: {len(text.splitlines())} lines, {len(text):,} bytes")
    print(f"  {len(rules)} auctions, {n_rows} rows, {n_empty} terminal, "
          f"{n_unnamed} unnamed")


def main():
    global args
    ap = argparse.ArgumentParser(description=__doc__,
                                 formatter_class=argparse.RawDescriptionHelpFormatter)
    ap.add_argument("--depth", type=int, default=2,
                    help="calls deep to crawl (default 2; 3 is ~22k auctions)")
    ap.add_argument("--workers", type=int, default=6)
    ap.add_argument("--out", default=os.path.join(REPO_ROOT, "system", "brill.md"))
    ap.add_argument("--cache", default="/tmp/brill_rules.json",
                    help="cache the crawled JSON here")
    ap.add_argument("--from-cache", dest="from_cache",
                    help="rebuild from an existing JSON instead of refetching")
    args = ap.parse_args()

    print("fetching /version ...")
    ver = get_json(API + "/version") or {}
    print(f"  {ver.get('systemName','?')} {ver.get('version','?')} "
          f"({ver.get('ruleCount', 0):,} rules)")

    print("fetching index.html ...")
    raw = _get(SITE + "/index.html")
    if raw is None:
        sys.exit("could not fetch index.html")
    doc_md = html_to_markdown(raw)
    print(f"  {len(doc_md.splitlines())} lines of prose")

    rules = crawl(args.depth, args.workers,
                  cache_path=args.from_cache or args.cache)
    build(rules, doc_md, ver, args.out)


if __name__ == "__main__":
    main()
