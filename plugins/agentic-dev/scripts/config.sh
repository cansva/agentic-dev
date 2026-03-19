#!/usr/bin/env bash
#
# Centralized configuration for agentic-dev.
# All scripts and hooks source this file to resolve configurable values.
#
# Override any variable by setting it in your environment (e.g. .env, shell
# profile, or CI). Defaults match the original hardcoded values so existing
# setups are unaffected.

# ── Branch configuration ────────────────────────────────────────────────────
AGENTIC_DEV_BASE_BRANCH="${AGENTIC_DEV_BASE_BRANCH:-preview}"
AGENTIC_DEV_PROTECTED_BRANCHES="${AGENTIC_DEV_PROTECTED_BRANCHES:-main|${AGENTIC_DEV_BASE_BRANCH}}"

# ── Build system commands ───────────────────────────────────────────────────
AGENTIC_DEV_TEST_CMD="${AGENTIC_DEV_TEST_CMD:-npm test}"
AGENTIC_DEV_LINT_CMD="${AGENTIC_DEV_LINT_CMD:-npm run lint}"
AGENTIC_DEV_BUILD_CMD="${AGENTIC_DEV_BUILD_CMD:-npm run build}"
AGENTIC_DEV_INSTALL_CMD="${AGENTIC_DEV_INSTALL_CMD:-npm install}"
AGENTIC_DEV_DEV_CMD="${AGENTIC_DEV_DEV_CMD:-npm run dev}"
AGENTIC_DEV_E2E_CMD="${AGENTIC_DEV_E2E_CMD:-npm run test:e2e}"

# ── Path detection ──────────────────────────────────────────────────────────
AGENTIC_DEV_CI_WORKFLOW="${AGENTIC_DEV_CI_WORKFLOW:-}"
AGENTIC_DEV_CI_PATHS="${AGENTIC_DEV_CI_PATHS:-src/ app/ e2e/ package.json tsconfig.json}"
AGENTIC_DEV_E2E_PATHS="${AGENTIC_DEV_E2E_PATHS:-^(app/api/|app/lib/|src/api/|src/lib/|e2e/|tests/e2e/)}"

# ── Optional integrations ──────────────────────────────────────────────────
AGENTIC_DEV_ADR_PATH="${AGENTIC_DEV_ADR_PATH:-}"
AGENTIC_DEV_PR_TEMPLATE="${AGENTIC_DEV_PR_TEMPLATE:-.github/pull_request_template.md}"
AGENTIC_DEV_ISSUE_TEMPLATES="${AGENTIC_DEV_ISSUE_TEMPLATES:-.github/ISSUE_TEMPLATE/}"
