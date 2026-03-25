#!/usr/bin/env bash
set -euo pipefail
#
# Merge gate: anti-hallucination check.
#
# Verifies that a Codex review comment with VERDICT: approved exists on the PR
# AND was posted after the current head commit was pushed. This prevents merging
# on a PR that has been modified since it was last reviewed.
#
# Note on authenticity: verification is limited to comment body pattern matching
# (marker + structure). Any actor able to post a PR comment with the
# agentic-dev:codex-review:v1 marker can satisfy this gate. The gate's primary
# purpose is preventing the model from merging without having run the review
# scripts at all — not preventing a determined adversary from spoofing a comment.
#
# Exits 0 if a valid post-push approved comment is found, 1 otherwise.
#
# Usage:  scripts/merge-gate.sh <PR_NUMBER>

PR_NUMBER="${1:?Usage: merge-gate.sh <PR_NUMBER>}"
REPO=$(gh repo view --json nameWithOwner --jq '.nameWithOwner')

# Get the timestamp of the current PR head commit
HEAD_PUSHED_AT=$(gh pr view "$PR_NUMBER" --repo "$REPO" \
  --json headCommittedDate --jq '.headCommittedDate')

if [ -z "$HEAD_PUSHED_AT" ]; then
  echo "ERROR: Could not determine PR head commit date"
  exit 1
fi

# Find the most recent approval comment that post-dates the current head push
APPROVAL=$(gh api "repos/$REPO/issues/$PR_NUMBER/comments" \
  --jq --arg pushed "$HEAD_PUSHED_AT" '
    [.[]
      | select(.body | test("<!-- agentic-dev:codex-review:v1"))
      | select(.body | test("VERDICT:.*approved"; "i"))
      | select(.updated_at > $pushed)
    ] | last // empty
  ')

if [ -n "$APPROVAL" ]; then
  APPROVAL_TIME=$(echo "$APPROVAL" | jq -r '.updated_at')
  echo "Codex review: approved (comment posted $APPROVAL_TIME, after head push $HEAD_PUSHED_AT)"
  exit 0
else
  # Distinguish between "no approval ever" and "approval is stale"
  ANY_APPROVAL=$(gh api "repos/$REPO/issues/$PR_NUMBER/comments" \
    --jq '[.[] | select(.body | test("<!-- agentic-dev:codex-review:v1")) | select(.body | test("VERDICT:.*approved"; "i"))] | last // empty')

  if [ -n "$ANY_APPROVAL" ]; then
    STALE_TIME=$(echo "$ANY_APPROVAL" | jq -r '.updated_at')
    echo "Codex review: approval exists but is stale (approved at $STALE_TIME, head pushed at $HEAD_PUSHED_AT)"
    echo "New commits were pushed after the review — re-review required"
  else
    echo "Codex review: no approved comment found — review has not been run"
  fi
  exit 1
fi
