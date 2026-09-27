#!/bin/sh
# bin/lib.sh — shared internals for the Grimoire tools.
#
# POSIX sh only. No bashisms, no arrays, no `local` (POSIX has no `local`;
# we use prefixed globals and accept it). No external dependencies beyond
# awk and date(1). Never evals note content — see docs/DESIGN-DECISIONS.md.
#
# Sourced, not executed.

# ── civil date arithmetic ────────────────────────────────────────────────────
#
# Hinnant's days_from_civil / civil_from_days: exact integer proleptic
# Gregorian conversion, valid for any year, no date(1) involvement. We need this
# because GNU date and BSD date disagree about `-d`, and because the whole
# point of the scheduler is that its output is a fact you can check by reading.
#
# awk's `/` is floating-point and `int()` truncates toward zero, so every
# division below is wrapped in int() to reproduce C's integer semantics. The
# `- 399` / `- 146096` offsets are what make that truncation correct for
# negative numerators.

g_days_from_civil() {
    awk -v y="$1" -v m="$2" -v d="$3" 'BEGIN {
        if (m <= 2) y = y - 1
        era = int((y >= 0 ? y : y - 399) / 400)
        yoe = y - era * 400
        if (m > 2) mp = m - 3; else mp = m + 9
        doy = int((153 * mp + 2) / 5) + d - 1
        doe = yoe * 365 + int(yoe / 4) - int(yoe / 100) + doy
        print era * 146097 + doe - 719468
    }'
}

g_civil_from_days() {
    awk -v z="$1" 'BEGIN {
        z = z + 719468
        era = int((z >= 0 ? z : z - 146096) / 146097)
        doe = z - era * 146097
        yoe = int((doe - int(doe / 1460) + int(doe / 36524) - int(doe / 146096)) / 365)
        yy = yoe + era * 400
        doy = doe - (365 * yoe + int(yoe / 4) - int(yoe / 100))
        mp = int((5 * doy + 2) / 153)
        d = doy - int((153 * mp + 2) / 5) + 1
        if (mp < 10) m = mp + 3; else m = mp - 9
        y = yy
        if (m <= 2) y = y + 1
        printf "%04d-%02d-%02d\n", y, m, d
    }'
}

# days since 1970-01-01 for an ISO date
g_days_from_iso() {
    case "$1" in
        [0-9][0-9][0-9][0-9]-[0-9][0-9]-[0-9][0-9]) ;;
        *) return 1 ;;
    esac
    g_days_from_civil "$(printf '%s' "$1" | cut -c1-4)" \
                      "$(printf '%s' "$1" | cut -c6-7)" \
                      "$(printf '%s' "$1" | cut -c9-10)"
}

g_iso_from_days() { g_civil_from_days "$1"; }

g_today_iso() { date +%Y-%m-%d; }

# date + N days, where N may be negative
g_iso_plus_days() {
    _g_iso="$1"; _g_n="$2"
    _g_d=$(g_days_from_iso "$_g_iso") || return 1
    g_iso_from_days $((_g_d + _g_n))
}

# Signed distance in days: days($2) - days($1). Negative when $2 is earlier.
g_days_diff() {
    _g_a=$(g_days_from_iso "$1") || return 1
    _g_b=$(g_days_from_iso "$2") || return 1
    echo $((_g_b - _g_a))
}

# -1 if $1 is earlier than $2, 1 if later, 0 if equal. Returns 1 on a non-ISO
# argument.
g_days_between() {
    _g_d=$(g_days_diff "$2" "$1") || return 1
    if [ "$_g_d" -lt 0 ]; then echo -1; elif [ "$_g_d" -gt 0 ]; then echo 1; else echo 0; fi
}

g_iso_valid() {
    case "$1" in
        [0-9][0-9][0-9][0-9]-[0-9][0-9]-[0-9][0-9]) return 0 ;;
        *) return 1 ;;
    esac
}

# ── frontmatter ──────────────────────────────────────────────────────────────
#
# The schema is deliberately flat: top-level `key: scalar` lines and `key:`
# followed by indented `- item` lines. Anything else is a malformed note and we
# fail loudly rather than guessing. A YAML parser is not a dependency of a
# system whose thesis is having no dependencies.

# Is this file frontmatter-bearing at all?
g_has_frontmatter() {
    [ -f "$1" ] || return 1
    [ "$(head -n 1 "$1" 2>/dev/null)" = "---" ]
}

# g_fm_get never fails; g_fm_get_strict exits 0=scalar 1=absent 3=list.
g_fm_get_strict() {    _g_f="$1"; _g_k="$2"
    g_has_frontmatter "$_g_f" || return 2
    awk -v key="$_g_k" '
        NR == 1 { next }
        /^---[[:space:]]*$/ { exit }
        index($0, key ":") == 1 {
            v = substr($0, length(key) + 2)
            gsub(/^[[:space:]]+/, "", v)
            gsub(/[[:space:]]+$/, "", v)
            if (v == "") { found = "list"; exit }
            found = "scalar"; print v; exit
        }
        END {
            if (found == "") exit 1
            if (found == "list") exit 3
        }
    ' "$_g_f"
}

# Convenience: value, or empty string. Never fails.
g_fm_get() { g_fm_get_strict "$@" 2>/dev/null || :; }

# 0 if the key is present at all (scalar or list), 1 if absent.
g_fm_has() {
    _g_f="$1"; _g_k="$2"
    g_has_frontmatter "$_g_f" || return 1
    awk -v key="$_g_k" '
        NR == 1 { next }
        /^---[[:space:]]*$/ { exit }
        index($0, key ":") == 1 { found = 1; exit }
        END { exit (found ? 0 : 1) }
    ' "$_g_f"
}

# g_fm_get, but the literal `null` reads as absent — flat YAML has no other
# null (an empty value parses as a list key). Use this for every
# "is this filled in?" test; using g_fm_get instead silently disables Law 1.
g_fm_getn() {
    _g_v=$(g_fm_get "$@")
    if [ "$_g_v" = "null" ]; then _g_v=""; fi
    printf '%s' "$_g_v"
}

# Top-level keys, one per line, in file order.
g_fm_keys() {
    g_has_frontmatter "$1" || return 1
    awk '
        NR == 1 { next }
        /^---[[:space:]]*$/ { exit }
        /^[A-Za-z_][A-Za-z0-9_]*:/ {
            k = $0; sub(/:.*$/, "", k); print k
        }
    ' "$1"
}

# Does the key hold a list (value-less key followed by indented dashes)?
g_fm_is_list() {
    _g_f="$1"; _g_k="$2"
    g_has_frontmatter "$_g_f" || return 1
    awk -v key="$_g_k" '
        NR == 1 { next }
        /^---[[:space:]]*$/ { exit }
        $0 == key ":" { found = 1; exit }
        END { exit (found ? 0 : 1) }
    ' "$_g_f"
}

# Atomic set of a scalar key. Refuses to touch a list key. Inserts before the
# closing `---` when the key is absent, so position within the block is
# preserved for keys that already exist.
g_fm_set() {
    _g_f="$1"; _g_k="$2"; _g_v="$3"
    g_has_frontmatter "$_g_f" || { echo "g_fm_set: $1: no frontmatter" >&2; return 2; }
    if g_fm_is_list "$_g_f" "$_g_k"; then
        echo "g_fm_set: $1: '$2' is a list key; refusing to overwrite" >&2
        return 3
    fi
    _g_tmp="$_g_f.g-tmp.$$"
    awk -v key="$_g_k" -v val="$_g_v" '
        NR == 1 { print; next }
        /^---[[:space:]]*$/ {
            if (!done) { print key ": " val; done = 1 }
            print
            next
        }
        !done && index($0, key ":") == 1 { print key ": " val; done = 1; next }
        { print }
    ' "$_g_f" > "$_g_tmp" || { rm -f "$_g_tmp"; return 4; }
    mv "$_g_tmp" "$_g_f"
}

# Body text after the closing `---`, with leading blank lines stripped.
g_body() {
    g_has_frontmatter "$1" || return 1
    awk '
        NR == 1 { infm = 1; next }
        infm && /^---[[:space:]]*$/ { infm = 0; body = 1; next }
        body { print }
    ' "$1"
}

# ── layout ───────────────────────────────────────────────────────────────────

# type -> directory. `subject` is vault-root; the rest live in a per-type
# directory, optionally under a <subject>/ subdirectory.
g_type_dir() {
    case "$1" in
        subject)    echo "" ;;
        source)     echo "sources" ;;
        claim)      echo "claims" ;;
        proof)      echo "proofs" ;;
        attempt)    echo "attempts" ;;
        error)      echo "errors" ;;
        prediction) echo "predictions" ;;
        insight)    echo "insights" ;;
        practice)   echo "practices" ;;
        audit)      echo "audits" ;;
        *)          return 1 ;;
    esac
}

# Does this type nest under a <subject>/ directory?
g_type_nests() {
    case "$1" in
        source|claim|proof|attempt|error|prediction|insight) return 0 ;;
        *) return 1 ;;
    esac
}

# ── output ───────────────────────────────────────────────────────────────────

G_ERRORS=0

g_err() {
    # g_err <file> <line> <RULE> <message...>
    printf '%s:%s: %s %s\n' "$1" "$2" "$3" "$4"
    G_ERRORS=$((G_ERRORS + 1))
}

g_die() {
    printf 'g: %s\n' "$1" >&2
    exit "${2:-1}"
}

# g_fm_line_of never fails; g_fm_line_of_strict exits 0=found 1=absent.
g_fm_line_of_strict() {
    awk -v key="$2" '
        NR == 1 { next }
        /^---[[:space:]]*$/ { exit }
        index($0, key ":") == 1 { print NR; exit }
    ' "$1"
}

g_fm_line_of() { g_fm_line_of_strict "$@" 2>/dev/null || echo 1; }
