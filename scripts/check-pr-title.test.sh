#!/usr/bin/env sh
# Table test for check-pr-title.sh. No framework: the gate has no dependencies
# and neither does its test.
set -u

here=$(dirname "$0")
subject="$here/check-pr-title.sh"
failures=0

expect() {
  want=$1
  title=$2
  sh "$subject" "$title" >/dev/null 2>&1
  got=$?
  if [ "$got" -ne "$want" ]; then
    printf 'FAIL want=%s got=%s title=%s\n' "$want" "$got" "$title" >&2
    failures=$((failures + 1))
  fi
}

# Accepted
expect 0 'feat: add calendar view'
expect 0 'fix(web): stop the list from collapsing'
expect 0 'feat(api)!: drop the v1 endpoints'
expect 0 'revert: feat(api): add pagination'
expect 0 'chore(deps): bump node to 22'
expect 0 'docs: explain the sync model'

# Rejected: unknown type
expect 1 'feature: add calendar view'
expect 1 'Add calendar view'
expect 1 'FEAT: add calendar view'

# Rejected: no description
expect 1 'feat:'
expect 1 'feat: '

# Length boundary. Build the strings instead of typing them: a literal run of
# 66 versus 67 'a' characters is a transcription risk, and a miscounted
# fixture fails in a way that looks like a bug in the gate.
pad() {
  i=0
  s=''
  while [ "$i" -lt "$1" ]; do
    s="${s}a"
    i=$((i + 1))
  done
  printf '%s' "$s"
}

expect 0 "feat: $(pad 66)"   # 'feat: ' is 6 chars, so this is exactly 72
expect 1 "feat: $(pad 67)"   # 73, one over

# Shell metacharacters are text, never code. If the gate executed this, the
# marker file would exist.
rm -f /tmp/check-pr-title-pwned
expect 1 'oops: $(touch /tmp/check-pr-title-pwned)'
if [ -f /tmp/check-pr-title-pwned ]; then
  echo 'FAIL the gate executed its input' >&2
  failures=$((failures + 1))
fi

# Called wrong
expect 2 ''

if [ "$failures" -gt 0 ]; then
  printf '%s failing case(s)\n' "$failures" >&2
  exit 1
fi
echo 'all cases pass'
