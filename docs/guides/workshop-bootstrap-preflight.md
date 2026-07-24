---
title: "Guide — Workshop Bootstrap + Preflight"
---

# Guide — Workshop Bootstrap + Preflight

[← Home](../index.md)

Use this guide before class to turn the template into your org-ready workshop repo.

## What this does

The bootstrap scripts can:

1. Replace instructor placeholders (for example `<your-org>`, `<src-org>`, and `@your-org/workshop-maintainers`).
2. Validate `CODEOWNERS`, required workflow files, and `dependabot.yml`.
3. Check GitHub repo settings with `gh` (auth, Actions enabled, default branch, rulesets, Pages).

## PowerShell (Windows/macOS/Linux)

From repo root:

```powershell
.\scripts\workshop-bootstrap.ps1 `
  -Organization contoso `
  -SourceOrganization Naytron `
  -CodeownersPrincipal "@contoso/workshop-maintainers" `
  -ApplyChanges
```

Dry-run validation only (no file edits):

```powershell
.\scripts\workshop-bootstrap.ps1 -Organization contoso
```

## Bash (macOS/Linux/WSL)

From repo root:

```bash
./scripts/workshop-bootstrap.sh \
  --organization contoso \
  --source-organization Naytron \
  --codeowners-principal @contoso/workshop-maintainers \
  --apply-changes
```

Dry-run validation only (no file edits):

```bash
./scripts/workshop-bootstrap.sh --organization contoso
```

## Typical prep flow

1. Run bootstrap with `--apply-changes` / `-ApplyChanges`.
2. Review diff and spot-check URLs in:
   - `README.md`
   - `docs/before.md`
   - `docs/after.md`
   - `.github/ISSUE_TEMPLATE/config.yml`
   - `.github/CODEOWNERS`
3. Push and open a PR.
4. Merge, then run a final no-change preflight to confirm clean state.

## Notes

- If `gh` is not installed or not authenticated, local file checks still run.
- Use `--skip-remote-checks` / `-SkipRemoteChecks` if your environment blocks GitHub API access.
