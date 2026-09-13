#!/usr/bin/env python3
"""
brill_parser.py — parse the Brill rule expressions captured in system/brill.md.

The Brill service returns, for every call in every auction, a `requires`
expression in its own little language.  Grammar (inferred from 3,515 real
expressions, and confirmed against the service's own rendering):

    expr   := alt
    alt    := conj ('|' conj)*          # '|' is OR, same precedence as 'or'
    conj   := unary ('and' unary)*
    unary  := 'not' unary | primary
    primary:= '(' expr ')' | atom
    atom   := cmp | call | name
    cmp    := sum (OP sum)?             # OP in == != >= <= > <
    sum    := term (('+'|'-') term)*
    term   := NUMBER | STRING | name | call
    call   := NAME '(' [args] ')'
    name   := bare identifier (may be a boolean predicate such as `balanced`)

Two spellings of OR appear in the wild ('or' and '|'); both are supported and
flattened into a single n-ary Or node so that DNF conversion is trivial.

Also exposes `rows_from_brill_md()` which re-reads the merged markdown file
(the canonical artefact) rather than re-crawling the service.
"""

import re
from dataclasses import dataclass, field
from typing import Any, Dict, List, Optional

# ---------------------------------------------------------------- AST nodes

@dataclass
class Node:
    pass

@dataclass
class And(Node):
    parts: List[Node]

@dataclass
class Or(Node):
    parts: List[Node]

@dataclass
class Not(Node):
    part: Node

@dataclass
class Cmp(Node):
    op: str
    left: Node
    right: Node

@dataclass
class BinOp(Node):
    op: str            # '+' or '-'
    left: Node
    right: Node

@dataclass
class Name(Node):
    name: str

@dataclass
class Call_(Node):
    name: str
    args: List[Node]

@dataclass
class Lit(Node):
    value: Any


# ---------------------------------------------------------------- tokenizer

_TOK = re.compile(r"""
    \s*(?:
      (?P<num>-?\d+(?:\.\d+)?)
    | (?P<str>'[^']*'|"[^"]*")
    | (?P<op>==|!=|>=|<=|>|<)
    | (?P<lparen>\()
    | (?P<rparen>\))
    | (?P<comma>,)
    | (?P<pipe>\|)
    | (?P<plus>[+-])
    | (?P<name>[A-Za-z_][A-Za-z_0-9]*)
    )
""", re.VERBOSE)


def tokenize(text: str):
    pos, out = 0, []
    while pos < len(text):
        if text[pos].isspace():
            pos += 1
            continue
        m = _TOK.match(text, pos)
        if not m:
            raise ValueError(f"cannot tokenize {text[pos:pos+40]!r} in {text!r}")
        out.append((m.lastgroup, m.group(m.lastgroup)))
        pos = m.end()
    return out


# ---------------------------------------------------------------- parser

class Parser:
    def __init__(self, text: str):
        self.text = text
        self.toks = tokenize(text)
        self.i = 0

    def peek(self):
        return self.toks[self.i] if self.i < len(self.toks) else (None, None)

    def next(self):
        t = self.peek()
        self.i += 1
        return t

    def eat(self, kind, value=None):
        k, v = self.peek()
        if k == kind and (value is None or v == value):
            self.i += 1
            return v
        return None

    def parse(self) -> Node:
        node = self.alt()
        if self.i != len(self.toks):
            raise ValueError(f"trailing tokens in {self.text!r}: {self.toks[self.i:]}")
        return node

    def alt(self) -> Node:
        parts = [self.conj()]
        while True:
            k, v = self.peek()
            if (k, v) == ("pipe", "|") or (k == "name" and v.lower() == "or"):
                self.next()
                parts.append(self.conj())
            else:
                break
        return parts[0] if len(parts) == 1 else Or(parts)

    def conj(self) -> Node:
        parts = [self.unary()]
        while True:
            k, v = self.peek()
            if k == "name" and v.lower() == "and":
                self.next()
                parts.append(self.unary())
            else:
                break
        return parts[0] if len(parts) == 1 else And(parts)

    def unary(self) -> Node:
        k, v = self.peek()
        if k == "name" and v.lower() == "not":
            self.next()
            return Not(self.unary())
        return self.primary()

    def primary(self) -> Node:
        if self.eat("lparen") is not None:
            node = self.alt()
            if self.eat("rparen") is None:
                raise ValueError(f"missing ) in {self.text!r}")
            return node
        return self.atom()

    def atom(self) -> Node:
        k, v = self.next()
        if k is None:
            raise ValueError(f"unexpected end of {self.text!r}")
        if k == "num":
            return Lit(float(v) if "." in v else int(v))
        if k == "str":
            return Lit(v[1:-1])
        if k == "name":
            if self.peek()[0] == "lparen":
                self.next()
                args = []
                if self.peek()[0] != "rparen":
                    args.append(self.alt())
                    while self.eat("comma") is not None:
                        args.append(self.alt())
                if self.eat("rparen") is None:
                    raise ValueError(f"missing ) after {v}( in {self.text!r}")
                # fall through to arith(): a call may be the LHS of a
                # comparison, e.g. suitpoints('C') > 12
                return self.arith(Call_(v, args))
            node = Name(v)
        else:
            raise ValueError(f"unexpected token {v!r} in {self.text!r}")

        # comparison / arithmetic tail
        return self.arith(node)

    def arith(self, left: Node) -> Node:
        k, v = self.peek()
        if k == "op":
            self.next()
            right = self.arith(self.simple())
            return Cmp(v, left, right)
        if k == "plus":
            self.next()
            right = self.simple()
            return self.arith(BinOp(v, left, right))
        return left

    def simple(self) -> Node:
        k, v = self.next()
        if k == "num":
            return Lit(float(v) if "." in v else int(v))
        if k == "str":
            return Lit(v[1:-1])
        if k == "name":
            if self.peek()[0] == "lparen":
                self.next()
                args = []
                if self.peek()[0] != "rparen":
                    args.append(self.alt())
                    while self.eat("comma") is not None:
                        args.append(self.alt())
                self.eat("rparen")
                return Call_(v, args)
            return Name(v)
        if k == "lparen":
            node = self.alt()
            self.eat("rparen")
            return node
        raise ValueError(f"unexpected {v!r} in {self.text!r}")


def parse_expr(text: str) -> Optional[Node]:
    """Parse one `requires` expression. Returns None if unparseable."""
    t = (text or "").strip()
    if not t or t in ("-", "—"):
        return None
    try:
        return Parser(t).parse()
    except Exception:
        return None


# ---------------------------------------------------------------- DNF

def to_dnf(node: Node) -> List[List[Node]]:
    """Convert to OR-of-ANDs of literals. Returns list of conjunctive clauses."""
    if isinstance(node, Or):
        out = []
        for p in node.parts:
            out.extend(to_dnf(p))
        return out
    if isinstance(node, And):
        clauses = [[]]
        for p in node.parts:
            sub = to_dnf(p)
            new = []
            for base in clauses:
                for s in sub:
                    new.append(base + s)
            clauses = new
        return clauses
    return [[node]]


def contradictions(clause: List[Node]) -> bool:
    """True if a conjunctive clause contains X and not X."""
    pos, neg = set(), set()
    for c in clause:
        if isinstance(c, Not) and isinstance(c.part, Name):
            neg.add(c.part.name)
        elif isinstance(c, Name):
            pos.add(c.name)
    return bool(pos & neg)


# ---------------------------------------------------------------- rows

@dataclass
class Row:
    auction: str            # e.g. "1H-P"  (the position; empty-auction is "P")
    call: str               # e.g. "2H*"
    means: str
    requires: str
    post: str
    convention: str
    pri: str
    expr: Any = field(default=None, repr=False)


_UNNAMED = "_(unnamed"


def _split_row(line: str) -> List[str]:
    parts = re.split(r"(?<!\\)\|", line)
    return [p.strip().replace("\\|", "|") for p in parts[1:-1]]


def rows_from_brill_md(path: str = "system/brill.md") -> List[Row]:
    lines = open(path, encoding="utf-8").read().split("\n")
    start = lines.index("## Part 2 — Rule tree")
    rows, auction = [], None
    for line in lines[start:]:
        if line.startswith("#### `"):
            auction = re.findall(r"`([^`]*)`", line)[0]
            continue
        if not line.startswith("| "):
            continue
        cells = re.split(r"(?<!\\)\|", line)
        if len(cells) - 2 != 6:
            continue
        c = [x.strip().replace("\\|", "|") for x in cells[1:-1]]
        if c[0] == "Call" or set(c[0]) <= set("-"):
            continue
        rows.append(Row(auction=auction, call=c[0], means=c[1], requires=c[2],
                        post=c[3], convention=c[4], pri=c[5]))
    return rows


if __name__ == "__main__":
    rs = rows_from_brill_md()
    ok = 0
    for r in rs:
        r.expr = parse_expr(r.requires)
        ok += r.expr is not None
    print(f"rows           : {len(rs)}")
    print(f"parsed ok      : {ok}  ({100*ok/len(rs):.1f}%)")
    bad = [r for r in rs if r.expr is None and r.requires.strip()]
    print(f"unparseable    : {len(bad)}")
    for r in bad[:5]:
        print("   ", r.auction, r.call, r.requires[:90])
