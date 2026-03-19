---
name: Feature
about: New functionality or meaningful behaviour change
labels: feature
---

## User Story

As a [user type], I want to [action] so that [outcome].

## Acceptance Criteria

- [ ] AC1 — [testable from UI or API contract, without inspecting internal state]
- [ ] AC2 — [testable from UI or API contract]

_ACs must collectively cover the stated user outcome._

## Out of Scope

- [at least one explicit deferral]

## Risky Areas

- [What could break outside this scope? Adjacent components, shared state, other flows. Explicitly state why none are expected if genuinely clear.]

## Dependencies

- Env vars: [name + purpose, or none]
- Migrations: none / [description + backwards compatible? + rollback plan]
- Feature flags: none / [name]
- Third-party services: none / [name + failure mode / fallback]

## Spec quality gate

- [ ] All ACs are testable from UI or API contract (not internal behaviour)
- [ ] ACs collectively cover the stated user outcome
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
