#!/usr/bin/env bash
#
# Centralized configuration for agentic-dev.
# All scripts and hooks source this file to resolve configurable values.
#
# Resolution order (highest wins):
#   1. Environment variable  (e.g. export AGENTIC_DEV_E2E_CMD="…")
#   2. Project config file   (.claude/agentic-dev.json in the repo root)
#   3. Built-in default      (hardcoded below)
#
# The project config file lets teams commit settings per-repo so every
# developer and agent gets the same values without shell setup.

# ── Project config file ─────────────────────────────────────────────────────
# Locate the repo root (works inside worktrees too).
_AGENTIC_DEV_REPO_ROOT="$(git rev-parse --show-toplevel 2>/dev/null || true)"
_AGENTIC_DEV_PROJECT_CONFIG="${_AGENTIC_DEV_REPO_ROOT:+$_AGENTIC_DEV_REPO_ROOT/.claude/agentic-dev.json}"

# _cfg <json_key> — read a value from the project config file (empty if missing)
_cfg() {
  if [ -n "$_AGENTIC_DEV_PROJECT_CONFIG" ] && [ -f "$_AGENTIC_DEV_PROJECT_CONFIG" ]; then
    jq -r --arg k "$1" '.[$k] // empty' "$_AGENTIC_DEV_PROJECT_CONFIG" 2>/dev/null || true
  fi
}

# ── Branch configuration ────────────────────────────────────────────────────
AGENTIC_DEV_BASE_BRANCH="${AGENTIC_DEV_BASE_BRANCH:-$(_cfg baseBranch)}"
AGENTIC_DEV_BASE_BRANCH="${AGENTIC_DEV_BASE_BRANCH:-preview}"
AGENTIC_DEV_PROTECTED_BRANCHES="${AGENTIC_DEV_PROTECTED_BRANCHES:-$(_cfg protectedBranches)}"
AGENTIC_DEV_PROTECTED_BRANCHES="${AGENTIC_DEV_PROTECTED_BRANCHES:-main|${AGENTIC_DEV_BASE_BRANCH}}"

# ── Build system commands ───────────────────────────────────────────────────
AGENTIC_DEV_TEST_CMD="${AGENTIC_DEV_TEST_CMD:-$(_cfg testCmd)}"
AGENTIC_DEV_TEST_CMD="${AGENTIC_DEV_TEST_CMD:-npm test}"
AGENTIC_DEV_LINT_CMD="${AGENTIC_DEV_LINT_CMD:-$(_cfg lintCmd)}"
AGENTIC_DEV_LINT_CMD="${AGENTIC_DEV_LINT_CMD:-npm run lint}"
AGENTIC_DEV_BUILD_CMD="${AGENTIC_DEV_BUILD_CMD:-$(_cfg buildCmd)}"
AGENTIC_DEV_BUILD_CMD="${AGENTIC_DEV_BUILD_CMD:-npm run build}"
AGENTIC_DEV_INSTALL_CMD="${AGENTIC_DEV_INSTALL_CMD:-$(_cfg installCmd)}"
AGENTIC_DEV_INSTALL_CMD="${AGENTIC_DEV_INSTALL_CMD:-npm install}"
AGENTIC_DEV_DEV_CMD="${AGENTIC_DEV_DEV_CMD:-$(_cfg devCmd)}"
AGENTIC_DEV_DEV_CMD="${AGENTIC_DEV_DEV_CMD:-npm run dev}"
AGENTIC_DEV_E2E_CMD="${AGENTIC_DEV_E2E_CMD:-$(_cfg e2eCmd)}"
AGENTIC_DEV_E2E_CMD="${AGENTIC_DEV_E2E_CMD:-npm run test:e2e}"

# ── Path detection ──────────────────────────────────────────────────────────
AGENTIC_DEV_CI_WORKFLOW="${AGENTIC_DEV_CI_WORKFLOW:-$(_cfg ciWorkflow)}"
AGENTIC_DEV_CI_WORKFLOW="${AGENTIC_DEV_CI_WORKFLOW:-}"
AGENTIC_DEV_CI_PATHS="${AGENTIC_DEV_CI_PATHS:-$(_cfg ciPaths)}"
AGENTIC_DEV_CI_PATHS="${AGENTIC_DEV_CI_PATHS:-src/ app/ e2e/ package.json tsconfig.json}"
AGENTIC_DEV_E2E_PATHS="${AGENTIC_DEV_E2E_PATHS:-$(_cfg e2ePaths)}"
AGENTIC_DEV_E2E_PATHS="${AGENTIC_DEV_E2E_PATHS:-^(app/api/|app/lib/|src/api/|src/lib/|e2e/|tests/e2e/)}"

# ── Optional integrations ──────────────────────────────────────────────────
AGENTIC_DEV_ADR_PATH="${AGENTIC_DEV_ADR_PATH:-$(_cfg adrPath)}"
AGENTIC_DEV_ADR_PATH="${AGENTIC_DEV_ADR_PATH:-}"
AGENTIC_DEV_PR_TEMPLATE="${AGENTIC_DEV_PR_TEMPLATE:-$(_cfg prTemplate)}"
AGENTIC_DEV_PR_TEMPLATE="${AGENTIC_DEV_PR_TEMPLATE:-.github/pull_request_template.md}"
AGENTIC_DEV_ISSUE_TEMPLATES="${AGENTIC_DEV_ISSUE_TEMPLATES:-$(_cfg issueTemplates)}"
AGENTIC_DEV_ISSUE_TEMPLATES="${AGENTIC_DEV_ISSUE_TEMPLATES:-.github/ISSUE_TEMPLATE/}"
