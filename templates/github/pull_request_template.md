Closes #[issue-number]

## What changed

[2–3 sentences: what was built and why]

## Implementation notes

**Key decisions:** [any deviation from the issue spec or ADR.md patterns, with reason — "none, implemented as specced" if straightforward]

**Risky areas:** [call sites, shared components, or anything that could regress — "none identified" if clean]

**How to test / E2E auth:** [exact commands to run locally, or auth method the reviewer needs]

## Checklist

- [ ] Behaviour: product change / bug fix / no observable change
- [ ] New dependencies: yes / no — [justification if yes]
- [ ] New env vars: yes / no — [name + purpose + added to Vercel if yes]
- [ ] Migrations: yes / no — [backwards compatible? rollback plan if yes]
- [ ] Touches core flows: yes / no — [which flows]
- [ ] E2E required: yes / no
- [ ] Issue AC updated if scope changed during implementation

## Test evidence

- Unit / integration: ✅ / N/A — [what was covered]
- Smoke E2E: ✅ / N/A — [flow covered]
- Full E2E: ✅ / N/A — [suite / scenario covered]

Preview URL: [url] — Commit: [SHA]
