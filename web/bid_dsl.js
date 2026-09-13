/**
 * bid_dsl.js — parser for the Bid system DSL.
 *
 * JS port of eval_vs_dds.load_decision_net_dsl: parses both exported formats
 *   one-line:  RULE <id> PRIORITY <n> ACTION <call> WHEN c1, c2, ...
 *   block:     RULE <id>: / CALL: / PRIORITY: / CONDITION: / NEGATIVE: True
 *   plus:      INTERSECTION <id> ^ <id>: / RESOLVED_CALL: <call>
 */
(function (api) {
    'use strict';

    const Call = api.Call;

    function parseValue(text) {
        let s = text.trim();
        if ((s.startsWith("'") && s.endsWith("'")) ||
            (s.startsWith('"') && s.endsWith('"'))) {
            return s.slice(1, -1);
        }
        if (/^\[.*\]$/.test(s)) {
            const inner = s.slice(1, -1).trim();
            if (!inner) return [];
            return inner.split(',').map(p => parseValue(p));
        }
        if (s === 'True') return true;
        if (s === 'False') return false;
        if (s === 'None') return null;
        if (/^-?\d+\.\d+$/.test(s)) return parseFloat(s);
        if (/^-?\d+$/.test(s)) return parseInt(s, 10);
        return s;
    }

    function parseCondition(text) {
        const m = text.trim().match(/^(\w+)\s*(==|!=|>=|<=|>|<|not_in|in)\s*(.+)$/);
        if (!m) throw new Error('Bad condition: ' + JSON.stringify(text));
        return {key: m[1], op: m[2], value: parseValue(m[3]), raw: text.trim()};
    }

    /** Split 'a >= 5, b in [1, 2], c == "X"' on top-level commas (port of
     *  eval_vs_dds._split_conditions: quote- and bracket-aware). */
    function splitConditions(text) {
        const parts = [];
        let depth = 0, quote = null, cur = '';
        for (const ch of text) {
            if (quote) {
                cur += ch;
                if (ch === quote) quote = null;
                continue;
            }
            if (ch === "'" || ch === '"') {
                quote = ch;
                cur += ch;
            } else if (ch === '[') {
                depth++;
                cur += ch;
            } else if (ch === ']') {
                depth--;
                cur += ch;
            } else if (ch === ',' && depth === 0) {
                parts.push(cur.trim());
                cur = '';
            } else {
                cur += ch;
            }
        }
        if (cur.trim()) parts.push(cur.trim());
        return parts.filter(p => p);
    }

    /**
     * Rebuild an ID3 tree from the indented SPLIT/LEAF block emitted by
     * DecisionNet.export_tree_lines (mirror of eval_vs_dds.parse_id3_tree).
     *   SPLIT <feature> <= <threshold>   followed by two children at indent+2
     *   LEAF <call>
     * Returns null for an empty or malformed block.
     */
    function parseTree(rows) {
        const clean = rows.filter(r => r.trim());
        if (!clean.length) return null;
        const depth = s => s.length - s.replace(/^\s+/, '').length;
        const base = depth(clean[0]);
        let pos = 0;

        function build(expect) {
            if (pos >= clean.length) return null;
            const line = clean[pos];
            if (depth(line) !== expect) return null;
            const text = line.trim();
            pos++;
            if (text.startsWith('LEAF')) {
                const t = text.slice(4).trim();
                try { return {leaf: true, call: Call.parse(t)}; } catch (e) { return null; }
            }
            const m = text.match(/^SPLIT\s+(\w+)\s*<=\s*(-?[\d.]+)(?:\s+fallback\s+(\S+))?$/);
            if (!m) return null;
            let fallback = null;
            if (m[3]) { try { fallback = Call.parse(m[3]); } catch (e) { fallback = null; } }
            return {
                leaf: false, feature: m[1], threshold: parseFloat(m[2]),
                fallback, left: build(expect + 2), right: build(expect + 2)
            };
        }

        return build(base);
    }

    /**
     * Walk a parsed tree.  Mirrors ID3Node.predict: an absent split feature
     * returns the node's majority fallback (so a changed feature set degrades
     * to the majority call instead of an arbitrary direction), and a missing
     * branch yields null so the caller keeps the full candidate set.
     */
    function predictTree(node, features) {
        while (node && !node.leaf) {
            const v = features ? features[node.feature] : undefined;
            if (v === undefined || v === null) return node.fallback || null;
            node = (v <= node.threshold) ? node.left : node.right;
        }
        return node ? node.call : null;
    }

    /**
     * Parse the DSL text into
     *   {name, rules: [...], intersections: {key: call}, refinements: {key: fn}}.
     * rules: {ruleId, call: Call, conditions: [...], isNegative, priority}
     */
    function parse(text, name) {
        const lines = String(text).split(/\r?\n/);
        const net = {name: name || 'ParsedSystem', rules: [], intersections: {}};

        let i = 0;
        while (i < lines.length) {
            const stripped = lines[i].trim();
            if (!stripped || stripped.startsWith('#')) { i++; continue; }

            const oneLine = stripped.match(/^RULE\s+(\S+)\s+PRIORITY\s+(-?\d+)\s+ACTION\s+(\S+)\s+WHEN\s+(.+)$/);
            if (oneLine) {
                const [, rid, prio, action, conds] = oneLine;
                net.rules.push({
                    ruleId: rid,
                    call: Call.parse(action),
                    conditions: splitConditions(conds).map(parseCondition),
                    isNegative: false,
                    priority: parseInt(prio, 10)
                });
                i++;
                continue;
            }

            const blockRule = stripped.match(/^RULE\s+(.+?):$/);
            if (blockRule) {
                const rid = blockRule[1].trim();
                let call = null, prio = 10, conditions = [], isNeg = false;
                i++;
                while (i < lines.length) {
                    const sub = lines[i].trim();
                    if (sub.startsWith('RULE ') || sub.startsWith('INTERSECTION')) break;
                    if (sub.startsWith('CALL:')) call = Call.parse(sub.split('CALL:')[1].trim());
                    else if (sub.startsWith('PRIORITY:')) prio = parseInt(sub.split('PRIORITY:')[1].trim(), 10);
                    else if (sub.startsWith('NEGATIVE:')) isNeg = sub.split('NEGATIVE:')[1].trim() === 'True';
                    else if (sub.startsWith('CONDITION:')) conditions.push(parseCondition(sub.split('CONDITION:').slice(1).join(':')));
                    i++;
                }
                if (call !== null) {
                    net.rules.push({ruleId: rid, call, conditions, isNegative: isNeg, priority: prio});
                }
                continue;
            }

            const inter = stripped.match(/^INTERSECTION\s+(.+?):$/);
            if (inter) {
                const ruleIds = inter[1].split('^').map(t => t.trim());
                let resolved = null;
                let tree = null;
                i++;
                while (i < lines.length) {
                    const raw = lines[i];
                    const sub = raw.trim();
                    if (sub.startsWith('RULE ') || sub.startsWith('INTERSECTION')) break;
                    if (sub === 'TREE:') {
                        const block = [];
                        i++;
                        while (i < lines.length) {
                            const r2 = lines[i];
                            if (!r2.trim()) { i++; continue; }
                            if ((r2.length - r2.replace(/^\s+/, '').length) >= 4) {
                                block.push(r2);
                                i++;
                            } else break;
                        }
                        tree = parseTree(block);
                        continue;
                    }
                    if (sub.startsWith('RESOLVED_CALL:')) {
                        resolved = Call.parse(sub.split('RESOLVED_CALL:')[1].trim());
                    }
                    i++;
                }
                if (ruleIds.length > 1) {
                    const key = ruleIds.slice().sort().join('^');
                    if (tree) {
                        net.refinements = net.refinements || {};
                        net.refinements[key] = features => predictTree(tree, features);
                    } else if (resolved !== null) {
                        net.intersections[key] = resolved;
                    }
                }
                continue;
            }
            i++;
        }

        // mirror DecisionNet.add_rule: skip exact duplicate rules (same id,
        // call, priority, negative flag, conditions) — the pre-fix exporter
        // double-wrote negative rules and squared them across save cycles
        const seen = new Set();
        net.rules = net.rules.filter(r => {
            const body = JSON.stringify([r.ruleId, r.call.toString(), r.priority,
                r.isNegative, r.conditions.map(c => [c.key, c.op, String(c.value)])]);
            if (seen.has(body)) return false;
            seen.add(body);
            return true;
        });
        return net;
    }

    api.DSL = {parse, parseCondition, parseValue, splitConditions,
               parseTree, predictTree};
})(typeof globalThis !== 'undefined' ? (globalThis.BidWeb = globalThis.BidWeb || {}) : (window.BidWeb = window.BidWeb || {}));
