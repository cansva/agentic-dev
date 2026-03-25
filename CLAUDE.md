# agentic-dev

## /release

Cut a new release. Do not accept a version number from the user — determine it yourself.

### Step 1 — determine the version

1. Run `git describe --tags --abbrev=0` to get the current version tag.
2. Run `git log <tag>..HEAD --oneline` to list commits since the last release.
3. Apply semver rules to decide the bump:
   - **patch** — only fixes, docs, chore, refactor
   - **minor** — any new feature or behaviour visible to users/consumers
   - **major** — breaking change (removed commands, changed config schema, incompatible output)
4. State the chosen version and the reason before proceeding.

### Step 2 — write the changelog entry

Write a concise changelog body (no version header line — the script adds that):

```
<one-line summary of the release>

### <Section> (only include sections that have changes)
- <bullet>
```

Use the same style as existing entries in `CHANGELOG.md`.

### Step 3 — execute the script

1. Write the changelog body to a temp file: `NOTES=$(mktemp) && cat > "$NOTES" << 'EOF' ... EOF`
2. Run: `bash .claude/scripts/release.sh <version> "$NOTES"`
3. Confirm the release URL from `gh release create` output.
