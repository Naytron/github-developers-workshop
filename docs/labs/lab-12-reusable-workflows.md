---
title: "Lab 12 — Reusable Workflows"
---

# Lab 12 — Reusable Workflows

⏱️ ~30 min · Optional architect extension · Module: [Reusable Workflows](../modules/11-reusable-workflows.md) · [← Home](../index.md)

**Goal:** stop copy/pasting pipeline YAML. You'll call a **reusable** build/test workflow from a
thin caller, pass **inputs** and **secrets**, and understand the sharing and nesting limits that
bite at org scale.

> ℹ️ This lab works on **any plan** for **same-repo** reuse. True **cross-repo** reuse needs a
> second repo and, for private repos, Actions **access** settings — flagged below with a
> single-repo fallback. See the [prerequisites matrix](../guides/advanced-track-prerequisites.md).

## Step 1 — Look at the two shipped workflows

The repo already contains the pattern:

```bash
cat .github/workflows/reusable-dotnet-ci.yml    # the callee: on: workflow_call
cat .github/workflows/ci-via-reusable.yml        # the caller: uses: ./...
```

```powershell
Get-Content .github/workflows/reusable-dotnet-ci.yml
Get-Content .github/workflows/ci-via-reusable.yml
```

Notice the **callee** declares `on: workflow_call` with typed `inputs` and a `secrets` block,
and the **caller** is only a few lines.

## Step 2 — Run the caller

```bash
gh workflow run ci-via-reusable.yml --ref <your-branch>
gh run watch
```

```powershell
gh workflow run ci-via-reusable.yml --ref <your-branch>
gh run watch
```

It builds and tests CivicPermit through the reusable workflow — same result as `ci.yml`, but the
logic lives in one place.

## Step 3 — Add a required and an optional input

The callee already exposes `dotnet-version` (required) and `configuration` (optional, defaults
to `Release`). Prove the optional path by having the caller build **Debug**:

```yaml
# in ci-via-reusable.yml
    with:
      dotnet-version: "10.0.x"
      configuration: "Debug"   # exercise the optional input
```

Re-run and confirm the log shows a Debug build.

## Step 4 — Understand secret passing

Secrets are **not** inherited automatically. The caller uses:

```yaml
    secrets: inherit
```

Swap it for an **explicit** map to control exactly what the callee sees:

```yaml
    secrets:
      NUGET_AUTH_TOKEN: ${{ secrets.NUGET_AUTH_TOKEN }}
```

> 🧠 **Least privilege:** prefer explicit mapping in real orgs so a shared workflow can't read
> secrets it doesn't need. Also remember the callee's `GITHUB_TOKEN` **cannot exceed** the
> permissions the caller grants.

## Step 5 — (Optional) Cross-repo reuse

In production the reusable workflow lives in a shared repo:

```yaml
    uses: your-org/platform-workflows/.github/workflows/dotnet-ci.yml@main
```

> ⚠️ **Constraints:** the caller can nest reusable workflows **at most 4 levels** deep. A
> **private** reusable workflow must be made accessible under **Settings → Actions → General →
> Access**. No second repo today? Stay with the same-repo `uses: ./...` form — the mechanics are
> identical.

## ✅ Checkpoint

- [ ] You ran the caller and it built via the reusable workflow.
- [ ] You exercised both a required and an optional input.
- [ ] You can explain `secrets: inherit` vs an explicit secret map.
- [ ] You can state the 4-level nesting limit and the private-sharing requirement.

## Troubleshooting

- **`workflow was not found`** → check the `uses:` path/ref; same-repo needs `./` and a valid
  branch/tag.
- **Callee can't see a secret** → you used `inherit` in name only, or the explicit map omits it.
- **Permission denied on private cross-repo call** → set Actions **Access** on the callee repo.
- More in [Troubleshooting](../troubleshooting.md).

> 💡 **Copilot Connection:** ask Copilot to refactor a duplicated pipeline into a `workflow_call`
> workflow plus a caller, then review the generated `inputs`/`secrets` contract.

## Next

Continue to [Lab 13 — Rulesets as Code](lab-13-rulesets-as-code.md).
