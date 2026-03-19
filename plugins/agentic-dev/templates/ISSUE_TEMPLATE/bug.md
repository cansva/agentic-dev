---
name: Bug
about: Something broken that needs correcting
labels: bug
---

## What's broken

[Observable description of the failure]

## Evidence

[Sentry link, screenshot, error message, or steps to reproduce]

## Expected behaviour

[What should happen instead]

## Acceptance Criteria

- [ ] AC1 — [observable confirmation the fix is in place]

## Out of Scope

- [at least one explicit deferral]

## Risky Areas

- [What could break outside this scope? Adjacent components, shared state, other flows. Explicitly state why none are expected if genuinely clear.]

## Dependencies

- Env vars: none / [name + purpose]
- Migrations: none / [description + backwards compatible? + rollback plan]
- Feature flags: none / [name]

## Spec quality gate

- [ ] All ACs are observable (user-facing outcome, not internal behaviour)
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
