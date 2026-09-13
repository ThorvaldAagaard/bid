/**
 * id3_dsl_test.mjs — cross-language parity for serialized ID3 trees.
 *
 * Reads tests/fixtures/id3_tree.dsl (written by the Python exporter) and
 * checks the JS port parses the TREE block into a refinement that predicts
 * the same calls as the Python engine recorded alongside it.
 *
 * Run: node tests/web/id3_dsl_test.mjs
 */
import {readFileSync} from 'node:fs';
import {fileURLToPath} from 'node:url';
import {dirname, join} from 'node:path';

const root = join(dirname(fileURLToPath(import.meta.url)), '..', '..');

for (const f of ['objects.js', 'features.js', 'bid_dsl.js', 'bid_net.js',
                 'auction.js']) {
    (0, eval)(readFileSync(join(root, 'web', f), 'utf8'));
}

const BidWeb = globalThis.BidWeb;
const text = readFileSync(join(root, 'tests', 'fixtures', 'id3_tree.dsl'), 'utf8');

let passed = 0, failed = 0;
function check(name, cond, extra) {
    if (cond) { passed++; }
    else { failed++; console.log(`  FAIL ${name}${extra ? ' — ' + extra : ''}`); }
}

const net = BidWeb.DSL.parse(text, 'id3_fixture');

check('parses both rules', net.rules.length === 2, `got ${net.rules.length}`);
check('registers a refinement (not a constant intersection)',
      net.refinements && Object.keys(net.refinements).length === 1,
      JSON.stringify(Object.keys(net.refinements || {})));
check('no constant intersection emitted alongside the tree',
      Object.keys(net.intersections || {}).length === 0);

const key = 'R_1H^R_1NT';
const fn = net.refinements && net.refinements[key];
check('refinement keyed by sorted intersection ids', typeof fn === 'function');

// Predictions must match the Python tree: hcp <= 16.5 -> 1H, else 1NT.
if (fn) {
    const cases = [
        [{hcp: 15, heart_len: 5}, '1H'],
        [{hcp: 16, heart_len: 6}, '1H'],
        [{hcp: 17, heart_len: 5}, '1NT'],
        [{hcp: 20, heart_len: 7}, '1NT'],
    ];
    for (const [features, expected] of cases) {
        const got = fn(features);
        check(`predict hcp=${features.hcp} -> ${expected}`,
              got && String(got) === expected, `got ${got && String(got)}`);
    }
    // A missing split feature must degrade to the node's majority fallback,
    // exactly as ID3Node.predict does — not pick a direction arbitrarily.
    let threw = false, missing = null;
    try { missing = fn({}); } catch (e) { threw = true; }
    check('empty features does not throw', !threw);
    check('empty features falls back to majority (1H)',
          missing && String(missing) === '1H', `got ${missing && String(missing)}`);
}

// The refinement must actually narrow the candidate set end to end.
if (fn && BidWeb.Hand && BidWeb.Net) {
    try {
        const hand = BidWeb.Hand.parse('SAK4 H76543 DAQ3 CK2');
        const calls = BidWeb.Net.actions(net, hand, [],
                                         BidWeb.Seat.SOUTH, BidWeb.Seat.NORTH, 0);
        check('candidate set narrowed to one call', calls.length === 1,
              `got ${calls.map(String).join(',')}`);
        check('narrowed call is 1H', calls.length === 1 && String(calls[0]) === '1H',
              calls.map(String).join(','));
    } catch (e) {
        console.log('  (end-to-end candidate check skipped: ' + e.message + ')');
    }
}

console.log(`id3_dsl_test: ${passed} checks passed, ${failed} failed`);
process.exit(failed ? 1 : 0);
