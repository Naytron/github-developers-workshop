---
title: "Guide — VS Code Setup (Optional)"
---

# Guide — VS Code Setup (Optional)

[← Home](../index.md)

VS Code is **optional** — every lab works with a plain terminal — but it makes editing,
building, debugging, and reviewing more comfortable.

## Install VS Code

- Download: <https://code.visualstudio.com/> (or your org's software portal).

## Recommended extensions

This repo suggests a few extensions via `.vscode/extensions.json`. When you open the folder
in VS Code, accept the prompt to install recommendations, or install these manually:

| Extension | Why |
| --------- | --- |
| **C# Dev Kit** (`ms-dotnettools.csdevkit`) | C# editing, build, test, and debug. |
| **GitHub Pull Requests** (`github.vscode-pull-request-github`) | Review and manage PRs in the editor. |
| **GitHub Actions** (`github.vscode-github-actions`) | View and edit workflows with schema help. |

> The **C# Dev Kit** is optional per the workshop's tooling rules. If your org doesn't
> license it, the base **C#** extension plus the terminal still cover everything.

## Open the project

```bash
cd github-developers-workshop
code .
```

## Build, test, run from the editor

This repo ships tasks and a launch config in `.vscode/`:

- **Build:** `Terminal → Run Task → build` (or `Ctrl/Cmd+Shift+B`).
- **Test:** `Terminal → Run Task → test`, or use the **Testing** panel from C# Dev Kit.
- **Run/Debug:** press **F5** → *Run CivicPermit API* (defined in `.vscode/launch.json`).
  It builds, launches the API, and opens the URL.

## Source control in VS Code

The **Source Control** panel (the branch icon) lets you stage, commit, and push without
the terminal. The **GitHub Pull Requests** extension adds a panel to create and review PRs
in-editor — a nice complement to the `gh` commands in the labs.

## If you prefer the terminal

Totally fine. Every lab lists the exact `git`, `gh`, and `dotnet` commands, so you can do
the entire workshop from a shell.

> 💡 **Copilot Connection:** VS Code is also where GitHub Copilot lives. The follow-up
> Copilot workshop builds on this same setup — installing the editor now sets you up for
> both.
