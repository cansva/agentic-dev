---
name: Refactor
about: Restructuring without changing observable behaviour
labels: refactor
---

## Why

[What problem does the current structure cause? Why refactor now?]

## What changes

[Description of the structural change — files, modules, patterns affected]

## Observable behaviour

**Must not change:** [list the behaviours that must remain identical before and after]

## Acceptance Criteria

- [ ] AC1 — [observable confirmation the refactor is complete]
- [ ] AC2 — [observable behaviour listed above is preserved]

## Out of Scope

- [at least one explicit deferral — e.g. "no functional changes in this PR"]

## Risky Areas

- [What could break outside this scope? Adjacent components, shared state, other flows. Explicitly state why none are expected if genuinely clear.]

## Dependencies

- Migrations: none / [description + backwards compatible? + rollback plan]
- Env vars: none / [name + purpose]
- Feature flags: none / [name]

## Spec quality gate

- [ ] All ACs are observable (preserved behaviour or structural outcome, not internal tooling)
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
