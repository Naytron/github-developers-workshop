---
title: "Guide — Conventional Commits"
---

# Guide — Conventional Commits

[← Home](../index.md)

**Conventional Commits** is a simple convention for commit messages that makes history
readable and release notes automatable. It's **optional** for this workshop, but we use it
throughout because it's a great habit.

## The format

```
<type>(<optional scope>): <short summary>

<optional body — the "why", wrapped ~72 chars>

<optional footer — e.g. issue refs, breaking changes>
```

- The **summary** is in the **imperative mood**: *"add"*, not *"added"* / *"adds"*.
- Keep the summary under ~50 characters where you can.

## Common types

| Type | Use for | Example |
| ---- | ------- | ------- |
| `feat` | A new feature | `feat: add schedule-inspection endpoint` |
| `fix` | A bug fix | `fix: return 404 before validating body` |
| `docs` | Documentation only | `docs: clarify PR checklist` |
| `test` | Adding/adjusting tests | `test: cover unknown-permit case` |
| `chore` | Tooling/maintenance | `chore: start feature branch` |
| `ci` | CI/workflow changes | `ci: clarify job display name` |
| `refactor` | Code change, no behavior change | `refactor: extract inspection mapping` |

## Examples from this workshop

```
feat: add schedule-inspection endpoint and tests

Adds POST /permits/{id}/inspections with 201/400/404 behavior and
xUnit coverage.

Refs #42
```

```
ci: clarify CI job display name

Refs #42
```

## Linking issues

- `Refs #42` — associates the commit with issue 42.
- `Closes #42` (in a **PR** description) — closes issue 42 when the PR merges.

## Breaking changes

Signal a breaking change with a `!` after the type, and/or a footer:

```
feat!: change permit id to a GUID

BREAKING CHANGE: /permits/{id} now expects a GUID, not an int.
```

This maps to a **MAJOR** version bump in [SemVer](../modules/06-releases.md).

## Why bother?

- **Readable history:** you can scan what changed and why.
- **Automatable notes:** `gh release create --generate-notes` and many tools turn these
  into changelogs.
- **Consistency:** the whole team writes messages the same way.

> 💡 **Copilot Connection:** Copilot can propose a Conventional Commit message from your
> staged diff — including the type and a sensible summary. We explore that in the Copilot
> workshop; knowing the format here lets you judge its suggestions.
