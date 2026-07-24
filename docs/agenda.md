---
title: 6-Hour Agenda
---

# 6-Hour Agenda

[← Home](index.md)

This workshop is designed as a single day with two breaks and a lunch. Times are a guide;
your instructor will adjust to the room. Every module pairs a short teach with a hands-on
lab that advances the **same** feature story.

| Time | Block | Module | Lab |
| ---- | ----- | ------ | --- |
| 0:00–0:30 | Welcome & setup | [Module 0](modules/00-welcome-and-setup.md) | [Lab 0](labs/lab-00-setup.md) |
| 0:30–1:15 | The workflow & Issues | [Module 1](modules/01-github-workflow-and-issues.md) | [Lab 1](labs/lab-01-open-the-issue.md) |
| 1:15–2:00 | Branching & Commits | [Module 2](modules/02-branching-and-commits.md) | [Lab 2.1](labs/lab-02-1-branch-and-first-commit.md) |
| 2:00–2:15 | ☕ Break | — | — |
| 2:15–3:00 | Implement & open a PR | [Module 2](modules/02-branching-and-commits.md) → [3](modules/03-pull-requests-and-review.md) | [Lab 2.2](labs/lab-02-2-implement-endpoint-and-test.md), [Lab 3.1](labs/lab-03-1-open-pull-request.md) |
| 3:00–3:30 | Review in practice | [Module 3](modules/03-pull-requests-and-review.md) | [Lab 3.2](labs/lab-03-2-review-and-address-feedback.md) |
| 3:30–4:15 | 🍽️ Lunch | — | — |
| 4:15–5:15 | GitHub Actions (CI) | [Module 4](modules/04-github-actions-ci.md) | [Lab 4](labs/lab-04-author-ci-workflow.md) |
| 5:15–6:00 | Branch protection & Merge | [Module 5](modules/05-branch-protection-and-merge.md) | [Lab 5](labs/lab-05-branch-protection-and-merge.md) |
| 6:00–6:15 | ☕ Break | — | — |
| 6:15–6:45 | Releases | [Module 6](modules/06-releases.md) | [Lab 6](labs/lab-06-cut-a-release.md) |
| 6:45–7:30 | Secure development | [Module 7](modules/07-secure-development.md) | [Lab 7](labs/lab-07-secure-development.md) |
| 7:30–7:45 | Wrap-up & next steps | [Module 8](modules/08-wrap-up-and-next-steps.md) | — |

> The teach-time total is ~6 hours; breaks and lunch bring the calendar day to ~7.75
> hours.

## Optional architect extension (~2.5 hours)

For architect-focused cohorts, continue with these advanced hardening modules — each has a
companion lab. Review the [prerequisites & difficulty matrix](guides/advanced-track-prerequisites.md)
first, as several labs are plan- or cloud-gated.

1. [Environments & approvals](modules/09-environments-and-approvals.md) → [Lab 9](labs/lab-09-environments-and-approvals.md)
2. [OIDC deployments](modules/10-oidc-deployments.md) → [Lab 10](labs/lab-10-oidc-azure-deploy.md)
3. [Reusable workflows](modules/11-reusable-workflows.md) → [Lab 11](labs/lab-11-reusable-workflows.md)
4. [Rulesets as code](modules/12-rulesets-as-code.md) → [Lab 12](labs/lab-12-rulesets-as-code.md)
5. [Security policy automation](modules/13-security-policy-automation.md) → [Lab 13](labs/lab-13-security-policy-automation.md)

## The story you'll build

```
Issue   →  Branch   →  Commit   →  Pull Request  →  Review   →  Workflow  →  Merge   →  Release
Lab 1      Lab 2.1     Lab 2.2      Lab 3.1          Lab 3.2     Lab 4        Lab 5      Lab 6
```

All of it delivers one feature to CivicPermit:
**"Add the ability to schedule an inspection for an existing permit."**
