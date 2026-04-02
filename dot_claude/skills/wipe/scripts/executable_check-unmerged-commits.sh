#!/usr/bin/env bash
# Outputs commits on current branch that have NOT been merged into origin/main.
# A commit is considered merged if it appears in any MERGED PR for this branch.
# Handles squash merges correctly (unlike git cherry).
set -euo pipefail

BRANCH=$(git rev-parse --abbrev-ref HEAD)
LOCAL_COMMITS=$(git log --format="%H" "$(git merge-base origin/main HEAD)..HEAD")

if [ -z "$LOCAL_COMMITS" ]; then
  echo "(none)"
  exit 0
fi

MERGED_OIDS=$(gh pr list --state merged --head "$BRANCH" --json commits --jq '.[].commits[].oid' 2>/dev/null || true)

UNMERGED=""
while IFS= read -r hash; do
  [ -z "$hash" ] && continue
  if ! echo "$MERGED_OIDS" | grep -q "^$hash"; then
    UNMERGED="$UNMERGED$(git log --oneline -1 "$hash")\n"
  fi
done <<< "$LOCAL_COMMITS"

if [ -z "$UNMERGED" ]; then
  echo "(none)"
else
  printf "%b" "$UNMERGED"
fi
