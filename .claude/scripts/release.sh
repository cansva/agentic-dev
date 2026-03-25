#!/usr/bin/env bash
# Usage: release.sh <version> <changelog_body_file>
# All three JSON/MD updates + commit + tag + GitHub release.
set -euo pipefail

VERSION="${1:?version required}"
NOTES_FILE="${2:?changelog body file required}"

REPO_ROOT="$(git -C "$(dirname "$0")" rev-parse --show-toplevel)"
cd "$REPO_ROOT"

PLUGIN_JSON="plugins/agentic-dev/.claude-plugin/plugin.json"
MARKETPLACE_JSON=".claude-plugin/marketplace.json"
CHANGELOG="CHANGELOG.md"

# 1. Bump plugin.json
tmp=$(mktemp)
jq --arg v "$VERSION" '.version = $v' "$PLUGIN_JSON" > "$tmp" && mv "$tmp" "$PLUGIN_JSON"

# 2. Bump marketplace.json
tmp=$(mktemp)
jq --arg v "$VERSION" '(.plugins[] | select(.name == "agentic-dev")).version = $v' "$MARKETPLACE_JSON" > "$tmp" && mv "$tmp" "$MARKETPLACE_JSON"

# 3. Prepend CHANGELOG entry
TODAY=$(date +%Y-%m-%d)
HEADER="## ${VERSION} — ${TODAY}"
BODY=$(cat "$NOTES_FILE")
ENTRY="${HEADER}"$'\n\n'"${BODY}"$'\n'

# Insert after "# Changelog\n"
tmp=$(mktemp)
awk -v entry="$ENTRY" '
  /^# Changelog/ { print; found=1; next }
  found && /^$/ { print; print entry; found=0; next }
  { print }
' "$CHANGELOG" > "$tmp" && mv "$tmp" "$CHANGELOG"

# 4. Commit + tag + release
git add "$PLUGIN_JSON" "$MARKETPLACE_JSON" "$CHANGELOG"
git commit -m "chore(release): agentic-dev v${VERSION}"
git tag "v${VERSION}"
git push --follow-tags

gh release create "v${VERSION}" \
  --title "agentic-dev v${VERSION}" \
  --notes-file "$NOTES_FILE"

echo "Released v${VERSION}"
