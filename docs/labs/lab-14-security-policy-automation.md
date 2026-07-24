---
title: "Lab 14 — Security Policy Automation"
---

# Lab 14 — Security Policy Automation

⏱️ ~30 min · Optional architect extension · Module: [Security Policy Automation](../modules/13-security-policy-automation.md) · [← Home](../index.md)

**Goal:** turn "we turned security on once" into a **continuous, evidence-producing check**.
You'll run a scheduled workflow that audits the repo's security baseline via `gh api`, publishes
an artifact for auditors, and fails/warns when a control is missing.

> ⚠️ **Plan gating:** on **private** repos, secret scanning, push protection, and code scanning
> require **GitHub Advanced Security (GHAS)**. **Public** repos get code + secret scanning free.
> See the [prerequisites matrix](../guides/advanced-track-prerequisites.md).

## Step 1 — Read the shipped audit workflow

The repo ships `.github/workflows/security-audit.yml`. Skim it:

```bash
cat .github/workflows/security-audit.yml
```

```powershell
Get-Content .github/workflows/security-audit.yml
```

Note two triggers — `workflow_dispatch` (on demand) and `schedule` (weekly drift check) — and a
Bash step that queries security settings, then uploads `security-audit.md`.

## Step 2 — Run it on demand

```bash
gh workflow run security-audit.yml --ref <your-branch>
gh run watch
```

```powershell
gh workflow run security-audit.yml --ref <your-branch>
gh run watch
```

## Step 3 — Read the evidence artifact

```bash
run_id=$(gh run list --workflow security-audit.yml --limit 1 --json databaseId --jq '.[0].databaseId')
gh run download "$run_id" --name security-audit
cat security-audit.md
```

```powershell
$run_id = gh run list --workflow security-audit.yml --limit 1 --json databaseId --jq ".[0].databaseId"
gh run download $run_id --name security-audit
Get-Content security-audit.md
```

You now have a dated, downloadable posture report — audit evidence, not a screenshot.

## Step 4 — The token scope trap (important)

Some rows may say **"⚠️ not found / no access"** even when the feature *is* enabled. The default
`GITHUB_TOKEN` often lacks `security_events`/admin scope to read those endpoints.

To read them, provide a PAT as the `AUDIT_TOKEN` secret:

```bash
gh secret set AUDIT_TOKEN --body "<your-fine-grained-PAT-with-security-read>"
```

```powershell
gh secret set AUDIT_TOKEN --body "<your-fine-grained-PAT-with-security-read>"
```

> 🧠 **Teaching moment / irony:** automating security here **reintroduces a stored secret** (the
> PAT) — the exact thing OIDC (Lab 11) and environment scoping (Lab 10) work to eliminate. Scope
> the PAT tightly, set an expiry, and prefer read-only. This tension is the lesson.

## Step 5 — Make a missing control fail (optional)

Turn the audit into a **gate**: edit the Bash step to `exit 1` when a required control is
missing, so a scheduled run (or a PR check) goes red on drift. Re-run and confirm the failure is
actionable in the logs.

## ✅ Checkpoint

- [ ] The audit workflow ran on demand.
- [ ] You downloaded and read `security-audit.md`.
- [ ] You can explain why some rows show "no access" and how a scoped PAT fixes it.
- [ ] You understand the stored-secret irony and how to mitigate it.
- [ ] (Optional) A missing control makes the workflow fail.

## Troubleshooting

- **All security rows show "no access"** → `GITHUB_TOKEN` lacks scope; add a scoped `AUDIT_TOKEN`
  PAT (Step 4). On private repos without GHAS, the features simply aren't available.
- **The scheduled run never fired** → GitHub **auto-disables scheduled workflows after ~60 days
  of repo inactivity**, and schedules can be delayed under load. Trigger manually to confirm the
  workflow itself is fine.
- **`gh: command not found` in the job** → `gh` is preinstalled on GitHub-hosted runners; on
  self-hosted runners install it first.
- More in [Troubleshooting](../troubleshooting.md).

> 💡 **Copilot Connection:** ask Copilot to extend the audit to a new control (e.g. verifying a
> ruleset exists) and to explain which `gh api` scope each check requires.

## 🏁 End of the advanced track

You've layered enterprise controls on top of the core workflow: approval gates, keyless deploys,
centralized pipelines, governance-as-code, and continuous security evidence. Return to
[Wrap-up & next steps](../modules/08-wrap-up-and-next-steps.md).
