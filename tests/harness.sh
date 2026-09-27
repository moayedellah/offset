#!/bin/sh
# tests/harness.sh — zero-dependency assertion harness and civil-date pinning.
#
# Exits non-zero if any assertion fails. No framework: a repo that claims to
# have no dependencies cannot pull in a test framework to prove it.

. "$(dirname "$0")/../bin/lib.sh"

T_PASS=0
T_FAIL=0

t_group() { printf '\n%s\n' "$1"; }

t_pass() { T_PASS=$((T_PASS + 1)); printf '  ok   %s\n' "$1"; }
t_fail() {
    T_FAIL=$((T_FAIL + 1))
    printf '  FAIL %s\n' "$1"
    [ -n "$2" ] && printf '         %s\n' "$2"
}

assert_eq() {
    # assert_eq <expected> <actual> <label>
    if [ "$1" = "$2" ]; then t_pass "$3"; else t_fail "$3" "expected [$1] got [$2]"; fi
}

assert_ne() {
    if [ "$1" != "$2" ]; then t_pass "$3"; else t_fail "$3" "both values were [$1]"; fi
}

assert_ok() {
    if "$@" >/dev/null 2>&1; then t_pass "$*"; else t_fail "$*" "expected exit 0"; fi
}

assert_fails() {
    if "$@" >/dev/null 2>&1; then t_fail "$*" "expected non-zero exit"; else t_pass "$* (correctly failed)"; fi
}

assert_file_contains() {
    if grep -qF -- "$2" "$1" 2>/dev/null; then
        t_pass "$1 contains '$2'"
    else
        t_fail "$1 contains '$2'" "not found"
    fi
}

assert_file_lacks() {
    if grep -qF -- "$2" "$1" 2>/dev/null; then
        t_fail "$1 lacks '$2'" "found it"
    else
        t_pass "$1 lacks '$2'"
    fi
}

# ── civil date arithmetic ────────────────────────────────────────────────────

t_group "days_from_civil — known values"

assert_eq 0      "$(g_days_from_civil 1970 1 1)"  "epoch 1970-01-01 = 0"
assert_eq 11017  "$(g_days_from_civil 2000 3 1)"  "2000-03-01 = 11017 (2000 is leap, Feb 29 counts)"
assert_eq -25508 "$(g_days_from_civil 1900 3 1)"  "1900-03-01 (1900 is NOT a leap century)"
assert_eq 47541  "$(g_days_from_civil 2100 3 1)"  "2100-03-01 (2100 is NOT a leap century)"
assert_eq 19782  "$(g_days_from_civil 2024 2 29)" "2024-02-29 leap day"
assert_eq 18262  "$(g_days_from_civil 2020 1 1)"  "2020-01-01"

t_group "civil_from_days — inverse"

assert_eq "1970-01-01" "$(g_civil_from_days 0)"    "days 0 = 1970-01-01"
assert_eq "2000-03-01" "$(g_civil_from_days 11017)" "days 11017 = 2000-03-01"
assert_eq "2024-02-29" "$(g_civil_from_days 19782)" "days 19782 = 2024-02-29"

t_group "round-trip — 400 consecutive days from 2020-01-01 (covers 2020-02-29)"

_rt_ok=1
_rt_i=0
while [ "$_rt_i" -lt 400 ]; do
    _d=$(g_iso_plus_days 2020-01-01 "$_rt_i")
    _n=$(g_days_from_iso "$_d") || { _rt_ok=0; echo "         unparseable: $_d"; break; }
    _b=$(g_civil_from_days "$_n")
    if [ "$_b" != "$_d" ]; then _rt_ok=0; echo "         mismatch at +$_rt_i: $_d -> $_n -> $_b"; break; fi
    _rt_i=$((_rt_i + 1))
done
assert_eq 1 "$_rt_ok" "iso -> days -> iso is stable for 400 days"

t_group "round-trip — across the non-leap century boundaries"

for _edge in 1899-12-31 1900-01-01 1900-02-28 1900-03-01 2099-12-31 2100-01-01 2100-02-28 2100-03-01 1600-02-29 2400-02-29; do
    _n=$(g_days_from_iso "$_edge") || { _rt_ok=0; break; }
    assert_eq "$_edge" "$(g_civil_from_days "$_n")" "$_edge round-trips"
done

t_group "arithmetic helpers"

assert_eq "2026-09-28" "$(g_iso_plus_days 2026-09-27 1)"    "plus one day"
assert_eq "2026-09-26" "$(g_iso_plus_days 2026-09-27 -1)"   "minus one day crosses month end"
assert_eq "2027-01-01" "$(g_iso_plus_days 2026-12-31 1)"    "plus one day crosses year end"
assert_eq "2024-03-01" "$(g_iso_plus_days 2024-02-29 1)"    "plus one day off a leap day"
assert_eq 0  "$(g_days_between 2026-09-27 2026-09-27)"      "same day is 0"
assert_eq -1 "$(g_days_between 2026-09-27 2026-09-28)"      "earlier is -1"
assert_eq 1  "$(g_days_between 2026-09-28 2026-09-27)"      "later is 1"
assert_eq 365 "$(g_days_diff 2025-09-27 2026-09-27)"        "a common year span is 365 days"
assert_eq 366 "$(g_days_diff 2023-09-27 2024-09-27)"        "a span containing 2024-02-29 is 366 days"
assert_eq 365 "$(g_days_diff 2024-09-27 2025-09-27)"        "a span starting AFTER a leap day is 365"
assert_eq -1 "$(g_days_diff 2026-09-28 2026-09-27)"         "diff is signed, not absolute"

t_group "date validation"

assert_ok   g_iso_valid 2026-09-27
assert_fails g_iso_valid 2026-9-27
assert_fails g_iso_valid "not-a-date"
assert_fails g_days_from_iso "nope"

# ── summary ──────────────────────────────────────────────────────────────────

printf '\n%s\n' "─────────────────────────────────────────"
printf 'passed: %s   failed: %s\n' "$T_PASS" "$T_FAIL"
[ "$T_FAIL" -eq 0 ] || exit 1
exit 0
