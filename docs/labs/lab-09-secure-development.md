---
title: "Lab 09 — Secure the Repository"
---

# Lab 09 — Secure the Repository

⏱️ ~30 min · Module: [Secure Development](../modules/07-secure-development.md) · [← Home](../index.md)

**Goal:** turn on GitHub's built-in security features for CivicPermit — Dependabot, secret
scanning, and code scanning — and see how findings flow through the same PR loop.

> Some toggles need **admin** rights and depend on your **GitHub Enterprise** plan. Where a
> step may be unavailable, it's flagged — treat those as instructor demos.

## Step 1 — Confirm the Dependabot config ships

The repo already includes `.github/dependabot.yml` for two ecosystems (NuGet and GitHub
Actions). Confirm it's there:

```bash
cat .github/dependabot.yml
```

```powershell
Get-Content .github/dependabot.yml
```

## Step 2 — Enable Dependabot alerts & security updates

```bash
gh repo view --web
```

**Settings → Advanced Security** (or **Code security**):

- Enable **Dependabot alerts**.
- Enable **Dependabot security updates** (auto-opens fix PRs).
- **Dependabot version updates** is driven by the `dependabot.yml` you just saw.

When Dependabot opens a PR, your **required CI check** from Lab 07 runs on it — an
automated fix *plus* proof it still builds and tests.

Check for any alerts from the CLI:

```bash
gh api repos/{owner}/{repo}/dependabot/alerts --jq '.[].security_advisory.summary' 2>/dev/null || echo "No alerts (or Advanced Security not enabled)"
```

```powershell
$alerts = gh api repos/{owner}/{repo}/dependabot/alerts --jq ".[].security_advisory.summary" 2>$null
if ($LASTEXITCODE -ne 0 -or [string]::IsNullOrWhiteSpace($alerts)) {
  "No alerts (or Advanced Security not enabled)"
} else {
  $alerts
}
```

## Step 3 — Enable secret scanning + push protection

In the same **Code security** settings:

- Enable **Secret scanning**.
- Enable **Push protection** — this *blocks* a push that contains a detected secret.

CivicPermit intentionally has **no secrets** (in-memory store, no external services). To
see push protection in a safe way, ask your instructor before testing with a **fake**
sample token; never commit a real one.

## Step 4 — Enable code scanning (CodeQL default setup)

Still in **Code security**:

- Under **Code scanning**, choose **Set up → Default**.
- GitHub detects the repo's languages (C#) and configures **CodeQL** for you — **no
  third-party action required**.
- The first scan runs automatically; results land in the **Security** tab and as PR
  annotations.

```bash
gh api repos/{owner}/{repo}/code-scanning/alerts --jq 'length' 2>/dev/null || echo "Code scanning not enabled yet"
```

```powershell
$codeScanningCount = gh api repos/{owner}/{repo}/code-scanning/alerts --jq "length" 2>$null
if ($LASTEXITCODE -ne 0) {
  "Code scanning not enabled yet"
} else {
  $codeScanningCount
}
```

## Step 5 — Tour the Security tab

```bash
gh repo view --web    # → Security
```

You'll find a single home for:

- **Dependabot** alerts and update PRs.
- **Secret scanning** alerts.
- **Code scanning** (CodeQL) results.
- Your **security policy** and advisories.

Triaging here uses the exact same skills as triaging issues and PRs.

## Step 6 — (Optional) Add a security policy

A `SECURITY.md` tells people how to report a vulnerability:

```bash
mkdir -p .github
cat > SECURITY.md <<'EOF'
# Security Policy

This is a training repository for a fictional app (CivicPermit). It contains no real
data, credentials, or services.

To report a concern with the workshop materials, open an issue using the feature-request
template, or contact your workshop instructor.
EOF

git switch -c chore/add-security-policy
git add SECURITY.md
git commit -m "docs: add SECURITY.md"
git push -u origin chore/add-security-policy
gh pr create --base main --title "Add SECURITY.md" --body "Adds a security policy for the workshop repo."
```

```powershell
$securityPolicy = @"
# Security Policy

This is a training repository for a fictional app (CivicPermit). It contains no real
data, credentials, or services.

To report a concern with the workshop materials, open an issue using the feature-request
template, or contact your workshop instructor.
"@

Set-Content -Path SECURITY.md -Value $securityPolicy -NoNewline

git switch -c chore/add-security-policy
git add SECURITY.md
git commit -m "docs: add SECURITY.md"
git push -u origin chore/add-security-policy
gh pr create --base main --title "Add SECURITY.md" --body "Adds a security policy for the workshop repo."
```

Notice: even a security **doc** flows through the same Issue → PR → Review → Merge loop.

## ✅ Checkpoint

- [ ] `dependabot.yml` is present and understood.
- [ ] Dependabot alerts/updates are enabled (or demoed).
- [ ] Secret scanning + push protection are enabled (or demoed).
- [ ] Code scanning (CodeQL default setup) is enabled (or demoed).
- [ ] You toured the **Security** tab.

## Troubleshooting

- **A toggle is missing** → your plan/org may not include that feature, or an org admin
  must enable it. Note it and continue.
- **Code scanning shows nothing** → the first scan may still be running; check the Actions
  tab.
- More in [Troubleshooting](../troubleshooting.md).

> 💡 **Copilot Connection:** In the Copilot workshop you'll see **Copilot Autofix** propose
> code changes for scanning alerts. Enabling and triaging the findings today is what makes
> those fixes meaningful.

## 🏁 That's the workshop

Head to [Wrap-up & next steps](../modules/08-wrap-up-and-next-steps.md).
