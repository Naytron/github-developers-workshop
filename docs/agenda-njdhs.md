---
title: NJ DHS — 2-Day Agenda
---

# NJ DHS — 2-Day Agenda (2 × 3 hours)

[← Home](index.md) · [Standard 6-hour agenda](agenda.md)

A delivery plan for **NJ DHS**: **2 days × 3 hours (6 hours total)** for **~50 attendees of
mixed experience**. The standard workshop is a single ~6.5-hour core teach (Modules 0–8)
built as one continuous story:

```
Issue → Branch → Commit → Pull Request → Review → Workflow → Merge → Release → Secure
```

Because 6 hours is slightly less than the core teach time, this plan compresses via two
levers instead of cutting the story: **enforced pre-work** (so Day 1 isn't consumed by
setup) and a **clean day-break at the "code is in review" checkpoint** — Day 1 covers the
developer *inner loop*, Day 2 the *outer loop* (automation, merge, release, security).

**Priority: breadth** — complete the full arc Issue → Release, with Security delivered as a
lighter, demo-forward segment. The advanced **architect track** (Modules 9–13) is **not part
of this plan** and is **not** used to fill or extend any block — it exists purely as an
**optional add-on** anyone can pursue on their own afterward if they want more.

---

## Mandatory pre-work (day before)

Send every attendee the **[Before the Workshop](before.md)** page 2–3 days prior:

- Install **Git**, **.NET 10 SDK**, **GitHub CLI (`gh`)**; verify each prints a version.
- `gh auth login` to GitHub Enterprise and confirm `gh auth status`.
- Clone their personal training repo and run `dotnet test` until they see **`Passed!`**.

> With 50 people, unresolved setup is the biggest schedule killer. Treat a green
> `dotnet test` as the entry ticket. Offer a **30-minute setup office hour** the afternoon
> before Day 1 (or open the room 30 min early) so Module 0 stays at 30 minutes.

---

## Day 1 — The developer inner loop (Issue → Review)

**Goal:** every attendee opens an Issue, branches, implements the feature, writes a test,
and gets a PR into review. Ends at a natural checkpoint — the feature is code-complete and
under review.

| Time | Block | Module | Lab |
| ---- | ----- | ------ | --- |
| 0:00–0:30 | Welcome, the CivicPermit story & setup check | [Module 0](modules/00-welcome-and-setup.md) | [Lab 0](labs/lab-00-setup.md) |
| 0:30–1:10 | The GitHub workflow & Issues | [Module 1](modules/01-github-workflow-and-issues.md) | [Lab 1](labs/lab-01-open-the-issue.md) |
| 1:10–1:50 | Branching & Commits | [Module 2](modules/02-branching-and-commits.md) | [Lab 2.1](labs/lab-02-1-branch-and-first-commit.md) |
| 1:50–2:05 | ☕ Break | — | — |
| 2:05–2:45 | Implement the endpoint + xUnit test, open a PR | [Module 2](modules/02-branching-and-commits.md) → [3](modules/03-pull-requests-and-review.md) | [Lab 2.2](labs/lab-02-2-implement-endpoint-and-test.md), [Lab 3.1](labs/lab-03-1-open-pull-request.md) |
| 2:45–3:00 | Review in practice (feedback loop) | [Module 3](modules/03-pull-requests-and-review.md) | [Lab 3.2](labs/lab-03-2-review-and-address-feedback.md) |

**Day 1 exit ticket:** an open PR with a passing local test. Anyone behind uses the
`solutions/` reference implementation to catch up before Day 2.

---

## Day 2 — The outer loop (Automate → Merge → Release → Secure)

**Goal:** complete the story — CI runs on the PR, branch protection enforces the check,
merge, cut a release, and add a security baseline. Open with a short recap so returning
mixed-level attendees re-anchor.

| Time | Block | Module | Lab |
| ---- | ----- | ------ | --- |
| 0:00–0:15 | Recap & re-anchor (where the PR stands) | [Module 3](modules/03-pull-requests-and-review.md) recap | — |
| 0:15–1:00 | GitHub Actions (CI) — author the workflow | [Module 4](modules/04-github-actions-ci.md) | [Lab 4](labs/lab-04-author-ci-workflow.md) |
| 1:00–1:40 | Branch protection & Merge | [Module 5](modules/05-branch-protection-and-merge.md) | [Lab 5](labs/lab-05-branch-protection-and-merge.md) |
| 1:40–1:55 | ☕ Break | — | — |
| 1:55–2:20 | Releases | [Module 6](modules/06-releases.md) | [Lab 6](labs/lab-06-cut-a-release.md) |
| 2:20–2:50 | Secure development (demo-forward, lighter lab) | [Module 7](modules/07-secure-development.md) | [Lab 7](labs/lab-07-secure-development.md) |
| 2:50–3:00 | Wrap-up, next steps & Copilot preview | [Module 8](modules/08-wrap-up-and-next-steps.md) | — |

**Day 2 exit ticket:** merged PR behind a required check + a tagged release.

---

## Facilitating 50 mixed-level attendees

- **Helpers/TAs:** staff **3–4 floaters** (≈1:15 ratio) to unblock during labs; most lost
  time is a handful of people stuck on the same setup/auth snag.
- **Pairing:** pair less-experienced with more-experienced attendees to self-level and keep
  pace during hands-on labs.
- **Fast finishers:** keep advanced attendees engaged *within the day's material* — the
  **💡 Copilot Connection** callouts, hardening their test/PR description, exploring the
  reference `solutions/`, or pairing to unblock others. Do **not** pull the advanced
  architect labs into the session to fill time; those remain a purely optional post-workshop
  add-on.
- **Sync checkpoints:** use green `dotnet test`, "PR opened," and "PR merged" as room-wide
  checkpoints — don't advance the teach until ~80% reach each.
- **Safety net:** the `solutions/` folder lets anyone who falls behind rejoin at the next
  module boundary without derailing the group.
- **Timeboxing:** if a lab runs long, demo the remainder from the front and share the
  reference solution rather than eating the next module's time.

---

## Optional add-ons (not part of this 2-day plan)

These are **not scheduled or counted** in the 6 hours above. They exist only as extras a
team can choose to pursue separately later:

- **Architect hardening labs** (Modules 9–13: environments/approvals, OIDC deploys,
  reusable workflows, rulesets-as-code, security policy automation) — several are plan- or
  cloud-gated; best delivered as a separate architect session, not mixed into this cohort.
- **GitHub Copilot deep-dive** — a separate follow-up workshop; previewed in Module 8.

## Notes & assumptions

- Assumes attendees complete pre-work. If not, Day 1 Module 0 may need +15–30 min and the
  Review block compresses to a demo.
- Times are a guide; the instructor adjusts to the room. Each 3-hour day includes one
  15-minute break — a block this size with 50 people should not run breakless.
