#!/usr/bin/env bash
set -uo pipefail
#
# Pre-push checklist: test → lint → build (in order).
# Reports which step failed instead of silently exiting.
#
# Usage:  scripts/pre-push-checks.sh

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
source "$SCRIPT_DIR/config.sh"

FAILED_STEP=""

run_step() {
  local label="$1" cmd="$2"
  echo "$label"
  if ! eval "$cmd"; then
    FAILED_STEP="$label"
    echo ""
    echo "FAILED at: $label"
    echo "Command:   $cmd"
    return 1
  fi
}

echo "=== Pre-push checks ==="

run_step "1/3 Running tests..." "$AGENTIC_DEV_TEST_CMD" &&
run_step "2/3 Running lint & type-check..." "$AGENTIC_DEV_LINT_CMD" &&
run_step "3/3 Running production build..." "$AGENTIC_DEV_BUILD_CMD"

if [ -n "$FAILED_STEP" ]; then
  echo ""
  echo "=== Pre-push checks FAILED ==="
  exit 1
fi

echo ""
echo "=== All pre-push checks passed ==="

# Write sentinel for the push-ready hook (SHA-pinned so stale checks are rejected)
git rev-parse HEAD > "$(git rev-parse --git-dir)/.pre-push-passed" 2>/dev/null || true
