#!/usr/bin/env bash
set -euo pipefail
#
# Watch a CI run on a branch and block until it completes.
#
# Uses the unified CI workflow discovery from config.sh.
# Exits 0 if CI passes, 1 if it fails, 2 if no run found.
#
# Usage:  scripts/ci-watch.sh <BRANCH> [REPO]

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
source "$SCRIPT_DIR/config.sh"

BRANCH="${1:?Usage: ci-watch.sh <BRANCH> [REPO]}"
REPO="${2:-$(gh repo view --json nameWithOwner --jq '.nameWithOwner')}"

CI_WORKFLOW=$(agentic_dev_discover_ci_workflow "$BRANCH" "$REPO")

if [ -z "$CI_WORKFLOW" ]; then
  echo "NOTE: No CI workflow found — skipping CI watch."
  exit 0
fi

echo "Watching CI workflow '$CI_WORKFLOW' on branch '$BRANCH'..."

# Wait for a run to appear (up to 2 minutes)
RUN_ID=""
for i in $(seq 1 20); do
  RUN_ID=$(gh run list --workflow="$CI_WORKFLOW" --branch="$BRANCH" \
    --repo "$REPO" -L 1 --json databaseId --jq '.[0].databaseId // ""' 2>/dev/null || true)
  [ -n "$RUN_ID" ] && break
  sleep 6
done

if [ -z "$RUN_ID" ]; then
  echo "WARNING: CI run for '$CI_WORKFLOW' did not appear after 2 minutes."
  exit 2
fi

echo "Found CI run #$RUN_ID — waiting for completion..."

# gh run watch blocks until the run finishes
if gh run watch "$RUN_ID" --repo "$REPO" --exit-status; then
  echo "CI passed."
  exit 0
else
  CONCLUSION=$(gh run view "$RUN_ID" --repo "$REPO" --json conclusion --jq '.conclusion // "unknown"' 2>/dev/null || echo "unknown")
  echo "CI failed (conclusion: $CONCLUSION)."
  exit 1
fi
