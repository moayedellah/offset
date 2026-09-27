#!/bin/sh
# tests/lint-tests.sh — every lint rule, in both directions, with isolation.
#
# For each rule we build a vault that is clean, break exactly one thing, and
# assert that the *only* rule that fires is the one we broke. That isolation is
# the point: without it, a broken check can hide behind a neighbour and a
# half-linter looks like a whole one.
#
# The runner also fails if any rule in L1..L12 was never exercised, so deleting
# a test block cannot quietly delete a check.

set -u
HERE=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)
ROOT=$(CDPATH= cd -- "$HERE/.." && pwd)
G="$ROOT/bin/g-lint"

WORK=""
RP=""
PASS=0
FAIL=0
COVERED=""

WORK=$(mktemp -d "${TMPDIR:-/tmp}/g-lint-tests.XXXXXX") || { printf 'cannot create work dir\n' >&2; exit 1; }

cleanup() { [ -n "$WORK" ] && rm -rf "$WORK"; }
trap cleanup EXIT INT TERM

ok()   { PASS=$((PASS + 1)); printf '  ok   %s\n' "$1"; }
bad()  { FAIL=$((FAIL + 1)); printf '  FAIL %s\n' "$1"; [ -n "${2:-}" ] && printf '         %s\n' "$2"; }
mark() { COVERED="$COVERED $1"; }

# note <relpath> <type> <id> [extra frontmatter lines...]
note() {
    _p="$WORK/$1"; _t="$2"; _i="$3"; shift 3
    mkdir -p "$(dirname "$_p")"
    {
        printf -- '---\n'
        printf 'type: %s\n' "$_t"
        printf 'id: %s\n' "$_i"
        printf 'title: note %s\n' "$_i"
        printf 'created: 2026-01-01\n'
        printf 'updated: 2026-01-01\n'
        for _l in "$@"; do printf '%s\n' "$_l"; done
        printf -- '---\n\n# %s\n' "$_i"
    } > "$_p"
}

base_vault() {
    rm -rf "$WORK"; mkdir -p "$WORK"
    note subject.md              subject    subj  'state: unseen' 'milestone_earned: false'
    note sources/s/s1.md         source     src1  'locator_hint: chapter 1'
    note sources/s/s2.md         source     src2  'locator_hint: chapter 2'
    note claims/s/c1.md          claim      c1    'state: proven' 'status: compiled' \
        'unlocked_by: att1' 'source: src1' 'locator: chapter 1' 'kind: source' \
        'due: 2099-01-01' 'last_review: 2026-01-01' 'lapses: 0' 'stability: 1d' 'difficulty: 5'
    note attempts/s/att1.md      attempt    att1  'claim: c1' 'outcome: failed' 'artifact: scratch.md'
    note proofs/s/pr1.md         proof      pr1   'claim: c1' 'rung: recall' \
        'artifact: scratch.md' 'verified: 2026-01-01'
    note errors/s/e1.md          error      e1    'recorded_at: 2026-01-01' \
        'resolution: open' 'supersedes: null'
    note predictions/s/p1.md     prediction p1    'statement: a guess' 'date: 2026-01-01' \
        'outcome: open' 'refuted_by: null'
    note practices/pr.md         practice   pr    'cadence: 3x/week' 'state: proven' \
        'due: 2099-01-01' 'last_review: 2026-01-01' 'lapses: 0' 'stability: 1d' \
        'difficulty: 5' 'proof: null'
}

hit_rules() { printf '%s\n' "$1" | sed -n 's/.*: L\([0-9][0-9]*\) .*/L\1/p' | LC_ALL=C sort -u; }

# expect_only <rule> <label> — current $WORK must trip exactly <rule>
expect_only() {
    _want="$1"; _label="$2"
    mark "$_want"
    _out=$("$G" --vault "$WORK" 2>&1) || true
    _hit=$(hit_rules "$_out")
    if [ "$_hit" = "$_want" ]; then
        ok "$_label ($_want)"
    else
        bad "$_label" "expected only [$_want], got [$(printf '%s' "$_hit" | tr '\n' ' ')]"
    fi
}

expect_clean() {
    _label="$1"
    _out=$("$G" --vault "$WORK" 2>&1) || true
    _hit=$(hit_rules "$_out")
    if [ -z "$_hit" ]; then
        ok "$_label (clean)"
    else
        bad "$_label" "expected clean, got [$(printf '%s' "$_hit" | tr '\n' ' ')]"
    fi
}

printf 'lint rule isolation\n\n'

# ── the baseline must be clean before any rule can be blamed ────────────────

base_vault
expect_clean "baseline vault"

# ── per-rule breaks ─────────────────────────────────────────────────────────

printf '\nL1 Closed Book\n'
base_vault
note claims/s/c1.md claim c1 'state: proven' 'status: compiled' \
    'unlocked_by: null' 'source: src1' 'locator: chapter 1' 'kind: source' \
    'due: 2099-01-01' 'last_review: 2026-01-01' 'lapses: 0' 'stability: 1d' 'difficulty: 5'
expect_only L1 "compiled claim with no unlocked_by"

printf '\nL2 no summary as first contact\n'
base_vault
note sources/s/s2.md source src2 'locator_hint: chapter 2' 'summary: the gist of it'
expect_only L2 "source summarised before any attempt"

printf '\nL3 provenance\n'
base_vault
note claims/s/c1.md claim c1 'state: proven' 'status: compiled' \
    'unlocked_by: att1' 'source: src1' 'locator: null' 'kind: source' \
    'due: 2099-01-01' 'last_review: 2026-01-01' 'lapses: 0' 'stability: 1d' 'difficulty: 5'
expect_only L3 "compiled claim with no locator"

printf '\nL4 exposure is not mastery\n'
base_vault; rm -f "$WORK/proofs/s/pr1.md"
expect_only L4 "proven with no proof note"

printf '\nL4b rung penalty\n'
base_vault
note proofs/s/pr1.md proof pr1 'claim: c1' 'rung: transfer' \
    'artifact: scratch.md' 'verified: 2026-01-01'
note attempts/s/att2.md attempt att2 'claim: c1' 'outcome: failed' 'artifact: scratch.md'
perl -pi -e 's/^created: 2026-01-01$/created: 2026-06-01/; s/^updated: 2026-01-01$/updated: 2026-06-01/' \
    "$WORK/attempts/s/att2.md"
expect_only L4 "proven at transfer, then failed later"

printf '\nL4c milestone without transfer\n'
base_vault
note subject.md subject subj 'state: unseen' 'milestone_earned: true'
expect_only L4 "milestone claimed with no transfer proof"

printf '\nL5 the ledger\n'
base_vault
note errors/s/e1.md error e1 'recorded_at: 2026-01-01' 'resolution: erased' 'supersedes: null'
expect_only L5 "resolution erased"

printf '\nL5b dangling supersedes\n'
base_vault
note errors/s/e2.md error e2 'recorded_at: 2026-01-01' 'resolution: superseded' 'supersedes: ghost'
expect_only L5 "supersedes pointing at nothing"

printf '\nL6 due honesty\n'
base_vault
note claims/s/c1.md claim c1 'state: proven' 'status: compiled' \
    'unlocked_by: att1' 'source: src1' 'locator: chapter 1' 'kind: source' \
    'due: 2020-01-01' 'last_review: 2020-01-01' 'lapses: 0' 'stability: 1d' 'difficulty: 5'
expect_only L6 "proven but past due"

printf '\nL7 link integrity\n'
base_vault
note predictions/s/p1.md prediction p1 'statement: a guess' 'date: 2026-01-01' \
    'outcome: refuted' 'refuted_by: ghost'
expect_only L7 "reference to a note that does not exist"

printf '\nL8 durability\n'
base_vault
printf '{"state": "cached"}\n' > "$WORK/claims/s/cache.json"
expect_only L8 "non-markdown state inside the vault"

printf '\nL9 schema\n'
base_vault
note claims/s/c1.md claim c1 'state: proven' 'status: compiled' \
    'unlocked_by: att1' 'source: src1' 'locator: chapter 1' 'kind: source' \
    'due: 2099-01-01' 'last_review: 2026-01-01' 'lapses: 0' 'stability: 1d' \
    'difficulty: 5' 'bogus: 1'
expect_only L9 "unknown frontmatter field"

printf '\nL9b illegal enum\n'
# Attached to an `unseen` claim on purpose: a bad rung on the proof backing a
# `proven` claim is correctly BOTH L9 and L4, which would break isolation.
base_vault
note claims/s/c2.md claim c2 'state: unseen' 'status: draft' \
    'unlocked_by: null' 'source: null' 'locator: null' 'kind: null' \
    'due: null' 'last_review: null' 'lapses: 0' 'stability: 1d' 'difficulty: 5'
note proofs/s/pr2.md proof pr2 'claim: c2' 'rung: vibes' \
    'artifact: scratch.md' 'verified: 2026-01-01'
expect_only L9 "illegal rung value"

printf '\nL9c updated before created\n'
base_vault
note claims/s/c1.md claim c1 'state: unseen' 'status: draft' \
    'unlocked_by: null' 'source: null' 'locator: null' 'kind: null' \
    'due: null' 'last_review: null' 'lapses: 0' 'stability: 1d' 'difficulty: 5'
perl -pi -e 's/^updated: 2026-01-01$/updated: 2020-01-01/' "$WORK/claims/s/c1.md"
expect_only L9 "updated precedes created"

printf '\nL11 anti-gamification\n'
base_vault
note errors/s/e1.md error e1 'recorded_at: 2026-01-01' 'resolution: open' \
    'supersedes: null' 'score: 7'
expect_only L11 "a score field in the vault"

# ── repository-scoped rules ─────────────────────────────────────────────────

printf '\nL10 portability\n'
base_vault
RP="$WORK/repo"; mkdir -p "$RP/docs"
cat > "$RP/CITATIONS.md" <<'EOF'
## good_one

- **Grade**: SAFE
- **Verification**: full text read
- **Finding**: a stand-in for the real ledger in this fixture.
EOF
printf 'placeholder\n' > "$RP/AGENTS.md"
_out=$("$G" --repo-root "$RP" 2>&1) || true
mark L10
[ -z "$(hit_rules "$_out")" ] && ok "small AGENTS.md passes L10" \
    || bad "small AGENTS.md" "$(hit_rules "$_out")"

{ printf 'x%.0s' $(seq 1 33000); printf '\n'; } > "$RP/AGENTS.md"
_out=$("$G" --repo-root "$RP" 2>&1) || true
_hit=$(hit_rules "$_out")
if [ "$_hit" = "L10" ]; then ok "AGENTS.md over 32768 bytes trips L10"
else bad "AGENTS.md over 32768 bytes" "got [$(printf '%s' "$_hit" | tr '\n' ' ')]"; fi

printf '\nL12 citation honesty\n'
rm -f "$RP/AGENTS.md"; printf 'placeholder\n' > "$RP/AGENTS.md"
printf 'A clean doc citing [cite: good_one].\n' > "$RP/docs/clean.md"
_out=$("$G" --repo-root "$RP" 2>&1) || true
mark L12
[ -z "$(hit_rules "$_out")" ] && ok "a resolvable, permitted citation passes L12" \
    || bad "good citation" "$(hit_rules "$_out")"

printf 'A doc citing [cite: missing_paper].\n' > "$RP/docs/unresolvable.md"
_out=$("$G" --repo-root "$RP" 2>&1) || true
_hit=$(hit_rules "$_out")
if [ "$_hit" = "L12" ]; then ok "an unresolvable citation trips L12"
else bad "unresolvable citation" "got [$(printf '%s' "$_hit" | tr '\n' ' ')]"; fi

rm -f "$RP/docs/unresolvable.md"
cat >> "$RP/CITATIONS.md" <<'EOF'

## banned_one

- **Grade**: DO-NOT-CLAIM
- **Verification**: not found
- **Finding**: a stand-in for a fabricated citation.
EOF
printf 'A doc citing [cite: banned_one].\n' > "$RP/docs/banned.md"
_out=$("$G" --repo-root "$RP" 2>&1) || true
_hit=$(hit_rules "$_out")
if [ "$_hit" = "L12" ]; then ok "a DO-NOT-CLAIM citation trips L12"
else bad "DO-NOT-CLAIM citation" "got [$(printf '%s' "$_hit" | tr '\n' ' ')]"; fi

# ── coverage self-check ─────────────────────────────────────────────────────

printf '\ncoverage\n'
_missing=""
for r in L1 L2 L3 L4 L5 L6 L7 L8 L9 L10 L11 L12; do
    case " $COVERED " in
        *" $r "*) ;;
        *) _missing="$_missing $r" ;;
    esac
done
if [ -z "$_missing" ]; then
    ok "every rule L1..L12 was exercised"
else
    bad "coverage" "untested rules:$_missing"
fi

printf '\n%s\n' "─────────────────────────────────────────"
printf 'passed: %s   failed: %s\n' "$PASS" "$FAIL"
[ "$FAIL" -eq 0 ] || exit 1
exit 0
