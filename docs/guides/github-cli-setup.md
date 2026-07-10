---
title: "Guide — GitHub CLI Setup"
---

# Guide — GitHub CLI Setup

[← Home](../index.md)

The **GitHub CLI** (`gh`) lets you work with issues, pull requests, workflows, and releases
from the terminal — which is how the labs drive the GitHub side of the workflow.

## Install `gh`

- **Official instructions:** <https://github.com/cli/cli#installation>
- **Windows (winget):** `winget install GitHub.cli`
- **macOS (Homebrew):** `brew install gh`
- **Linux:** see the apt/dnf instructions at the link above.

Verify:

```bash
gh --version
```

## Sign in

```bash
gh auth login
```

Answer the prompts:

1. **What account?** Choose **GitHub Enterprise Cloud** (or your server host, e.g.
   `github.your-company.com`).
2. **Protocol:** choose **HTTPS**.
3. **Authenticate Git with your GitHub credentials?** **Yes** — this lets `git push`/`pull`
   use your `gh` login.
4. **How to log in?** Browser is easiest; use the **device code** if a browser can't open.

Confirm:

```bash
gh auth status
```

You should see your host and username with a green check.

### Enterprise host tip

If your company uses **GitHub Enterprise Server**, pass the host explicitly:

```bash
gh auth login --hostname github.your-company.com
```

`gh` then defaults to that host in the repo you're working in.

## Handy commands you'll use today

```bash
gh repo clone <owner>/<repo>          # clone
gh repo fork <owner>/<repo> --clone   # fork + clone
gh issue create ...                   # open an issue (Lab 01)
gh pr create ...                      # open a pull request (Lab 04)
gh pr checks                          # see CI status on a PR (Lab 06)
gh pr merge --squash --delete-branch  # merge (Lab 07)
gh release create v1.1.0 --generate-notes   # release (Lab 08)
```

Full list in the [GitHub CLI cheat sheet](../cheatsheets/gh-cli.md).

## Troubleshooting sign-in

- **Browser won't open** → choose the one-time **device code** flow.
- **Behind a proxy** → set `HTTPS_PROXY`; see [Troubleshooting](../troubleshooting.md).
- **Wrong host** → re-run `gh auth login --hostname <your-host>`.

> 💡 **Copilot Connection:** GitHub also offers `gh` extensions and Copilot in the CLI. The
> Copilot workshop covers those; the core `gh` commands here are all the labs require.
