---
title: "Module 8 — Wrap-up & Next Steps"
---

# Module 8 — Wrap-up & Next Steps

⏱️ **15 minutes** · [← Home](../index.md)

## What you did today

You took a single feature — **"schedule an inspection for a permit"** — through the entire
professional GitHub workflow:

```
Issue → Branch → Commit → Pull Request → Review → Workflow → Merge → Release
```

Along the way you:

- Opened a well-formed **issue** from a template.
- Created a **branch** and made clear **commits**.
- Implemented an endpoint and an **xUnit test** on CivicPermit.
- Opened a **pull request** and ran a **code review**.
- Authored a **CI workflow** with only GitHub-owned actions.
- Protected `main` with a **required status check** and **merged**.
- Cut a **release** with the GitHub CLI.
- Enabled **Dependabot, secret scanning, and code scanning**.

## Bring it home — a starter checklist for your repos

- [ ] Add a CI workflow (start from our [`ci.yml`](04-github-actions-ci.md)).
- [ ] Protect the default branch; require the CI check and at least one review.
- [ ] Add issue and PR templates and a `CODEOWNERS` file.
- [ ] Turn on Dependabot, secret scanning, and code scanning.
- [ ] Adopt a branch-naming and commit convention.

## Keep practicing

Repeat the loop with a second small feature (ideas on the
[After the Workshop](../after.md) page). Repetition is what turns this from "a class you
took" into "how you work."

## Optional architect hardening track

If your cohort needs deeper enterprise controls, continue with the advanced track (each module
has a hands-on lab; see the
[prerequisites & difficulty matrix](../guides/advanced-track-prerequisites.md)):

1. [Environments & approvals](09-environments-and-approvals.md) → [Lab 9](../labs/lab-09-environments-and-approvals.md)
2. [OIDC deployments](10-oidc-deployments.md) → [Lab 10](../labs/lab-10-oidc-azure-deploy.md)
3. [Reusable workflows](11-reusable-workflows.md) → [Lab 11](../labs/lab-11-reusable-workflows.md)
4. [Rulesets as code](12-rulesets-as-code.md) → [Lab 12](../labs/lab-12-rulesets-as-code.md)
5. [Security policy automation](13-security-policy-automation.md) → [Lab 13](../labs/lab-13-security-policy-automation.md)

## Official documentation

- **GitHub docs:** <https://docs.github.com>
- **GitHub Actions:** <https://docs.github.com/actions>
- **Repository security:** <https://docs.github.com/code-security>
- **GitHub CLI manual:** <https://cli.github.com/manual/>
- **.NET CLI:** <https://learn.microsoft.com/dotnet/core/tools/>

## Your next workshop: GitHub Copilot

Throughout today you saw **💡 Copilot Connection** notes at each place Copilot plugs into the
workflow — drafting issues and acceptance criteria, generating commit messages and PR
descriptions, reviewing code (and even opening PRs as a coding agent), writing tests, and
authoring workflow YAML. A follow-up **GitHub Copilot** workshop goes deep on each. You now
have the fundamentals that make Copilot's output easy to evaluate, direct, and trust.

---

Thank you! Please share feedback with your instructor, and keep the
[cheat sheets](../index.md#reference) handy.
