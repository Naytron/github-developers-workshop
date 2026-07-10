---
title: "Instructor — Module Notes"
---

# Instructor — Module Notes

[← Home](../index.md)

Concise talking points, likely questions, and the "one thing to land" per module. Pairs
with the [Facilitation Guide](facilitation-guide.md) and [Demo Script](demo-script.md).

---

## Module 0 — Setup

- **Land this:** everyone green on `dotnet test` before moving on.
- **Say:** "Today is about the *workflow*, not memorizing commands."
- **Q: Why .NET / C#?** It's the smallest readable app that builds and tests with zero
  infra. The workflow is language-agnostic.
- **Q: Do I need VS Code?** No — the terminal covers every lab.

## Module 1 — Workflow & Issues

- **Land this:** the issue captures *why*; acceptance criteria define *done*.
- **Draw** the 8-step spine; you'll reference it all day.
- **Q: Isn't an issue overhead?** It's the audit trail and the coordination point — the
  thing that ties branch, PR, and release together.

## Module 2 — Branching & Commits

- **Land this:** branch per feature; small, green, well-described commits.
- **Watch for:** commits on `main` (recovery in the [Solution Key](solution-key.md)).
- **Q: `switch` vs `checkout`?** `switch` is the modern, purpose-built command; `checkout`
  still works and appears in older docs.
- **Q: Squash later anyway — why care about commits?** Good local commits make review and
  bisecting easier; the squash is the *public* summary.

## Module 3 — PRs & Review

- **Land this:** a PR is code + conversation + automation; review is the human gate.
- **Time-box Lab 03.** Anyone stuck copies from [`solutions/`](../../solutions/README.md).
- **Q: How big should a PR be?** Small enough to review in one sitting — ours is one
  endpoint + a test.
- **Q: Self-approve?** You can't approve your own PR; pair up or have the instructor
  approve.

## Module 4 — Actions / CI

- **Land this:** CI proves it builds/tests on a clean machine, on every change.
- **Gotcha:** Actions **disabled on forks** — do Lab 06 Step 0 together.
- **Q: Why only GitHub-owned actions?** Enterprise-lockdown safety and supply-chain hygiene.
  For build/test/release you don't need Marketplace actions.
- **Q: Self-hosted runners?** Out of scope; mention they exist for private networks.

## Module 5 — Branch protection & Merge

- **Land this:** rules turn intentions into enforcement; the required check is the safety
  net.
- **Rulesets vs classic:** rulesets are the direction of travel; either is fine here.
- **Q: Include admins?** For real protection, yes (`enforce_admins`). Decide deliberately.
- **Q: Which merge strategy?** We recommend squash for one-feature-one-commit history.

## Module 6 — Releases

- **Land this:** tag = pointer; release = tag + notes + assets. SemVer picks the number.
- **Wow moment:** `--generate-notes`. Tie it to good PR titles.
- **Q: Manual vs workflow release?** Show both; both are GitHub-owned tooling. `release.yml`
  needs `contents: write`.

## Module 7 — Secure development

- **Land this:** security findings flow through the *same* PR loop; enable the native
  features.
- **Plan-dependent:** have screenshots ready if secret/code scanning toggles are missing.
- **Q: Third-party scanners?** Not needed here — Dependabot, secret scanning, and CodeQL
  are native.
- **Q: Push protection false positives?** Rare; there's an override flow, but never commit
  real secrets to test.

## Module 8 — Wrap-up

- **Land this:** they did the whole loop; they can repeat it.
- Point to [After](../after.md) and the upcoming **Copilot** workshop.

---

## Copilot teasers — consistent handling

- Keep each callout to one sentence.
- If pressed: "That's exactly what the follow-up Copilot workshop covers."
- Never gate a lab on Copilot; some attendees won't have it.

## Frequently hit issues (fast pointers)

| Symptom | Pointer |
| ------- | ------- |
| `dotnet` isn't 10.x | [.NET SDK setup](../guides/dotnet-sdk-setup.md) |
| `restore` hangs | NuGet/proxy section of [Troubleshooting](../troubleshooting.md) |
| No CI runs | Actions disabled on fork — Lab 06 Step 0 |
| Committed on main | [Solution Key](solution-key.md) → recovery |
| Can't merge | Required check red / review missing |
