#!/usr/bin/env sh
# Validate a Conventional Commits subject line.
#
# No Node, no package manager, no install step: this gate runs in repositories
# that have not chosen a stack yet, and it must not be the reason one is
# chosen. The title arrives as "$1" and is only ever matched against, never
# evaluated — a PR title is author-controlled text.
set -u

max=72
types='feat|fix|chore|docs|refactor|test|perf|ci|build|style|revert'
pattern="^($types)(\([a-z0-9._/-]+\))?!?: .+"

if [ "$#" -ne 1 ] || [ -z "$1" ]; then
  echo 'usage: check-pr-title.sh "<title>"' >&2
  exit 2
fi

title=$1

if ! printf '%s' "$title" | grep -Eq "$pattern"; then
  echo "error: not a Conventional Commits subject: $title" >&2
  echo "expected: type(scope)?!?: description" >&2
  echo "types: $types" >&2
  exit 1
fi

length=${#title}
if [ "$length" -gt "$max" ]; then
  echo "error: subject is $length characters, limit is $max" >&2
  exit 1
fi

exit 0
