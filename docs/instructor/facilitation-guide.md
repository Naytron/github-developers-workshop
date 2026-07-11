---
title: "Instructor — Facilitation Guide"
---

# Instructor — Facilitation Guide

[← Home](../index.md)

Everything you need to run this workshop confidently. Read this once end to end before
delivery.

## Audience & outcomes

- **Audience:** enterprise development teams new to (or standardizing on) the GitHub
  workflow, on **GitHub Enterprise**. Developers of any language — the C# is intentionally
  tiny and readable.
- **Outcome:** every attendee takes one feature from **Issue → Release** and can repeat the
  loop on their own repos.

## Before the day

- [ ] Send attendees the [Before the Workshop](../before.md) link **48 hours ahead**.
- [ ] Decide the repo model (see "Repo model" below) and pre-create anything needed.
- [ ] Confirm attendees can reach GitHub Enterprise and install Git, .NET 10 SDK, `gh`.
- [ ] Dry-run the [Demo Script](demo-script.md) on the exact environment you'll teach on.
- [ ] Confirm **Actions** and (for Module 7) **security features** are available on the
      plan; if not, plan those as demos.
- [ ] Have the [Solution Key](solution-key.md) open in a private window for quick unblocking.
- [ ] (Optional) Pre-create **catch-up checkpoints** so stragglers can resync between labs —
      see [Catch-up checkpoints](#catch-up-checkpoints-optional) below.

## Repo model — pick one

| Model | How | Pros / cons |
| ----- | --- | ----------- |
| **Fork per attendee** (recommended) | Each attendee `gh repo fork --clone`. | Full admin on their fork → they can do branch protection & security labs. Must **enable Actions** on the fork (Lab 06 Step 0). |
| **One repo per attendee in a training org** | Pre-create `attendee-XX` repos from this template. | No fork friction; you manage cleanup. |
| **Shared repo, branch per attendee** | Everyone pushes branches to one repo. | Simplest to set up; but only admins can do Lab 07/09 — run those as demos. |

> The labs are written for the **fork** model but call out where shared-repo attendees do a
> lab as a demo instead.

## Catch-up checkpoints (optional)

If an attendee falls behind, the fastest recovery is to jump to a known-good starting point
rather than debug live. Two options:

- **Reference solution (always available).** The finished feature lives in
  [`solutions/`](../../solutions/README.md); copy those files over the starters to reach the
  post-Lab-03 state (see the copy commands in that README).
- **Per-lab checkpoint tags (recommended prep).** Before the day, walk the labs once on a
  clean clone and tag the *end state* of each lab, then push the tags to the shared repo:

  ```bash
  # after finishing each lab on your prep clone:
  git tag checkpoint/lab-02      # ...through checkpoint/lab-08
  git push origin --tags
  ```

  A lagging attendee resyncs with `git switch -c catchup checkpoint/lab-03` (or the lab they
  need) and continues from there. Point them at the tag for the lab **they're about to start**.

## Timing — two deliveries

### A) Full day with breaks (~7.75h calendar, ~6h teach)

Use the published [agenda](../agenda.md) as-is.

### B) Tight 6h clock-to-clock

Compress by trimming demos and running some labs in pairs:

| Time | Block |
| ---- | ----- |
| 0:00 | Module 0 + Lab 00 (25m) |
| 0:25 | Module 1 + Lab 01 (35m) |
| 1:00 | Module 2 + Lab 02 (35m) |
| 1:35 | ☕ 10m |
| 1:45 | Module 3 + Labs 03–04 (65m) |
| 2:50 | Lab 05 review (25m) |
| 3:15 | 🍽️ 30m |
| 3:45 | Module 4 + Lab 06 (55m) |
| 4:40 | Module 5 + Lab 07 (40m) |
| 5:20 | Module 6 + Lab 08 (20m) |
| 5:40 | Module 7 + Lab 09 (highlights, 15m) |
| 5:55 | Wrap-up (5m) |

## Per-module facilitation notes

### Module 0 — Setup
- **Goal:** everyone green on `dotnet test` before you move on. This is the #1 predictor of
  a smooth day.
- Circulate; use [Troubleshooting](../troubleshooting.md). Pair fast finishers with
  stragglers.

### Module 1 — Workflow & Issues
- Draw the 8-step spine on the board and **refer back to it all day**.
- Emphasize acceptance criteria = definition of done. Keep everyone's issue title identical
  so later labs line up.

### Module 2 — Branching & Commits
- Watch for commits on `main`; the [Solution Key](solution-key.md) has the recovery steps.
- Reinforce the branch name `feature/<issue-number>-schedule-inspection`.

### Module 3 — PRs & Review (Labs 03–05)
- Lab 03 is the longest hands-on. Set a hard time box; anyone stuck copies from
  [`solutions/`](../../solutions/README.md).
- For Lab 05, pair people. Solo attendees self-review (still valuable).

### Module 4 — Actions/CI
- The big gotcha: **Actions disabled on forks**. Do Lab 06 Step 0 as a group.
- Demo a **red** run then a fix so the value lands.

### Module 5 — Branch protection & Merge
- Requires admin. Fork attendees have it; shared-repo attendees watch you demo.
- Note the "can't approve your own PR" reality; either pair-approve or set required
  approvals to 0 for the exercise.

### Module 6 — Releases
- Keep it crisp. `--generate-notes` is the wow moment; tie it back to good PR titles.

### Module 7 — Secure development
- Availability varies by plan. Have a backup **screenshot/demo** if toggles are missing.
- Frame security as "the same PR loop, with guardrails."

### Module 8 — Wrap-up
- Close the loop on the board. Point to the [After](../after.md) page and the upcoming
  Copilot workshop.

## Copilot teasers — how to handle

Keep the **💡 Copilot Connection** callouts to a sentence. If asked to go deeper: *"Great
question — that's exactly what the follow-up Copilot workshop covers."* Never make a lab
depend on Copilot; some attendees won't have it enabled.

## Facilitation tips

- **Green-before-next:** insist on `dotnet test` passing before advancing.
- **Same numbers:** have attendees announce their issue/PR numbers; it prevents confusion.
- **Time-box labs** and show the solution rather than letting stragglers stall the room.
- **Narrate the spine** at every transition: "We opened the Issue; now we Branch."

## Reset / re-run

To reset the sample app to the starter state between cohorts:

```bash
git switch main && git pull
# The starter has no inspections endpoint; solutions/ holds the reference.
dotnet test   # expect Passed: 5 on a clean starter
```
