---
title: "Instructor — Demo Script"
---

# Instructor — Demo Script

[← Home](../index.md)

A word-for-word-ish script for the **single demo** you run before turning attendees loose.
Do the whole feature once, fast (~12–15 min), narrating the spine. Then attendees repeat it
as the labs.

> Run this on a **throwaway repo/fork** so attendees' repos stay clean. Have two terminals
> and a browser open. Dry-run it once before class.

## 0. Set the stage (30s)

> "We're one developer at a permitting agency. Product wants: *schedule an inspection for
> an existing permit*. Watch how that idea becomes shipped software using the GitHub
> workflow — the same loop you'll each run next."

Show the board diagram: `Issue → Branch → Commit → PR → Review → Workflow → Merge → Release`.

## 1. Issue (1 min)

```bash
gh issue create \
  --title "Add the ability to schedule an inspection for an existing permit" \
  --label "enhancement" \
  --body "POST /permits/{id}/inspections; 201/400/404; covered by a test; CI green."
```

> "The issue is the *why*. Note the number — everything links back to it."

## 2. Branch (30s)

```bash
git switch main && git pull
git switch -c feature/1-schedule-inspection
```

> "Never build on main. This branch is my sandbox."

## 3. Commit — the feature (4–5 min)

Open the three files and paste from the [Solution Key](solution-key.md):

- `Models/Permit.cs` → add `Inspection`, `ScheduleInspectionRequest`, `Inspections` list.
- `Store/PermitStore.cs` → add `AddInspection`.
- `Program.cs` → add the `POST /permits/{id}/inspections` endpoint.

Then the test file `tests/.../InspectionsEndpointsTests.cs`.

```bash
dotnet test    # narrate: 5 → 8 passing
```

```bash
git add src/ tests/
git commit -m "feat: add schedule-inspection endpoint and tests

Refs #1"
git push -u origin feature/1-schedule-inspection
```

> "Small, green, well-described commit. Tests ship *with* the feature."

## 4. Pull Request (1 min)

```bash
gh pr create --base main \
  --title "Add endpoint to schedule an inspection for a permit" \
  --body "Adds POST /permits/{id}/inspections. Closes #1"
gh pr view --web
```

> "The PR is the proposal + the conversation. `Closes #1` links and will auto-close the
> issue."

## 5. Review (2 min)

In the browser, add one line comment (e.g., *"Nice — 404 before body validation, good"*),
then:

```bash
gh pr review --approve --body "LGTM — tests cover the key paths."
```

> "Review is the human quality gate — correctness, clarity, safety."

## 6. Workflow / CI (1–2 min)

```bash
gh pr checks
gh run watch
```

> "CI built and tested on a clean machine. This is what 'works on my machine' becomes when
> it's real."

(Optional: briefly break a test, push, show ❌, revert, show ✅.)

## 7. Merge (1 min)

```bash
gh pr merge --squash --delete-branch
gh issue view 1     # CLOSED
git switch main && git pull
```

> "Squash → one clean commit on main. Issue closed automatically. Branch gone."

## 8. Release (1 min)

```bash
gh release create v1.1.0 --title "CivicPermit v1.1.0" --generate-notes
gh release view v1.1.0 --web
```

> "Baseline was v1.0.0; a backward-compatible feature is v1.1.0. Notes generated from the
> PR — another reason good PR titles matter."

## Close (30s)

> "Idea to shipped release, fully traceable, fully tested, safely merged. Now you'll each do
> exactly this — starting with Lab 00."

## Reset for the next cohort

Delete the demo release/tag and branch on the throwaway repo, or use a fresh fork:

```bash
gh release delete v1.1.0 --yes
git push origin :refs/tags/v1.1.0
```
