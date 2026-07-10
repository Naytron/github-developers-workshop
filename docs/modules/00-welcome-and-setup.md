---
title: "Module 0 — Welcome & Setup"
---

# Module 0 — Welcome & Setup

⏱️ **30 minutes** · Paired lab: [Lab 00 — Setup](../labs/lab-00-setup.md) · [← Home](../index.md)

## Goals

By the end of this module you will:

- Understand what we're building and why (the CivicPermit story).
- Have Git, the .NET 10 SDK, and the GitHub CLI working on your machine.
- Have a local clone of the workshop repo that **builds and tests green**.

## The story we'll tell all day

Everything today follows **one developer working one real feature request** on a small
government app called **CivicPermit** (a Residential Permit & Inspection Tracker). We
carry that single story through the whole GitHub workflow:

```
Issue → Branch → Commit → Pull Request → Review → Workflow → Merge → Release
```

The feature is always the same:

> **"Add the ability to schedule an inspection for an existing permit."**

## Meet CivicPermit

- A single **ASP.NET Core Minimal API** on **.NET 10 (LTS)**.
- An **in-memory store** — no database, no cloud, no PII. It runs anywhere `dotnet` runs.
- Tests in **xUnit**, restored with **NuGet only**.

Current endpoints:

| Method | Route | Description |
| ------ | ----- | ----------- |
| `GET`  | `/permits` | List all permits |
| `POST` | `/permits` | Intake a new permit |
| `GET`  | `/permits/{id}` | Get a single permit |
| `POST` | `/permits/{id}/inspections` | **We'll add this together** |

## The three tools

| Tool | Role today |
| ---- | ---------- |
| **Git** | Version control on your laptop |
| **.NET 10 SDK** | `dotnet build` / `test` / `run` / `publish` |
| **GitHub CLI (`gh`)** | Issues, PRs, and releases from the terminal |

If you prepared with the [Before the Workshop](../before.md) page, you're ready. If not,
we'll fix it now in the lab.

## Why "workflow" beats "commands"

Git and GitHub have hundreds of commands. You'll use about a dozen 95% of the time. This
workshop teaches the **workflow** — the small, repeatable loop professional teams run all
day — not an encyclopedia of flags.

## Common pitfalls

- **Wrong .NET version.** `dotnet --version` must start with `10.`. See [.NET SDK setup](../guides/dotnet-sdk-setup.md).
- **`gh` not signed in.** Run `gh auth status`; if it errors, run `gh auth login`.
- **Corporate proxy.** If `dotnet restore` or `git clone` hangs, see [Troubleshooting](../troubleshooting.md).

> 💡 **Copilot Connection:** Later, in the Copilot workshop, this same setup gains an AI
> pair that can explain errors and suggest fixes inline. Today we build the fundamentals
> by hand so those suggestions make sense.

## ➡️ Now do the lab

[**Lab 00 — Setup**](../labs/lab-00-setup.md)
