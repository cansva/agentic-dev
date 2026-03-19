---
name: Chore
about: Maintenance work — dependency updates, CI config, tooling, housekeeping
labels: chore
---

## Why

[What maintenance problem does this address? Why now?]

## What changes

[Description of the change — dependencies, CI pipelines, tooling, config affected]

## Observable behaviour

**Must not change:** [list the user-facing behaviours that must remain identical before and after]

## Acceptance Criteria

- [ ] AC1 — [observable confirmation the chore is complete]
- [ ] AC2 — [observable behaviour listed above is preserved]

## Out of Scope

- [at least one explicit deferral — e.g. "no functional changes in this PR"]

## Risky Areas

- [What could break outside this scope? Build pipelines, deploy flows, other environments. Explicitly state why none are expected if genuinely clear.]

## Dependencies

- Env vars: none / [name + purpose]
- Migrations: none / [description + backwards compatible? + rollback plan]
- Feature flags: none / [name]

## Spec quality gate

- [ ] All ACs are observable (build output, CI status, or preserved behaviour — not internal tooling)
- [ ] At least one explicit out-of-scope item declared
- [ ] Dependencies section complete (env vars, migrations, flags)
- [ ] Risky areas named, or explicitly state why none are expected

**Risk triggers — auth / permissions / schema / env / core flows:**

- [ ] Risk triggers assessed: none apply
- [ ] Auth: who can access this? Any new public endpoints or changed access rules?
- [ ] Schema: any renames or type changes? Is the migration backwards compatible?
- [ ] Env: new vars added to local `.env` + Vercel preview + prod?
- [ ] State transitions: failure path and edge cases specced, not just happy path?
- [ ] Core flows: which existing flows could be affected? Named in Risky Areas above?

_Either tick at least one trigger item, or tick "none apply."_
