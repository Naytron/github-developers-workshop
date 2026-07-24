---
title: "Cheat Sheet — GitHub CLI (gh)"
---

# Cheat Sheet — GitHub CLI (`gh`)

[← Home](../index.md) · Guide: [GitHub CLI setup](../guides/github-cli-setup.md)

## Auth

```bash
gh auth login                       # sign in (choose Enterprise host + HTTPS)
gh auth login --hostname <host>     # explicit Enterprise Server host
gh auth status                      # who am I / which host?
```

## Repositories

```bash
gh repo clone <owner>/<repo>            # clone
gh repo fork <owner>/<repo> --clone     # fork + clone
gh repo view --web                      # open the repo in a browser
```

> 🧩 **Two placeholder styles, on purpose.** `<owner>/<repo>` means *type your real values*
> (e.g. `contoso/civicpermit`). Further down, `gh api` commands use `{owner}/{repo}` — that
> is a literal token `gh` **auto-fills from the current repo**, so leave those braces as-is.

## Issues

```bash
gh issue create --title "..." --label "enhancement" --body "..."
gh issue list
gh issue view <number>
gh issue view <number> --web
gh issue close <number>
```

## Pull requests

```bash
gh pr create --base main --title "..." --body "..."
gh pr list
gh pr view [<number>] [--web]
gh pr diff [<number>]
gh pr checkout <number>              # check out a PR branch locally
gh pr checks [<number>]             # CI status
gh pr review <number> --approve --body "LGTM"
gh pr review <number> --request-changes --body "..."
gh pr review <number> --comment --body "..."
gh pr merge <number> --squash --delete-branch
```

## Actions / workflows

```bash
gh workflow list
gh workflow view <name>
gh run list --limit 5
gh run watch                        # follow the latest run live
gh run view --log-failed            # jump to failing logs
```

## Releases

```bash
gh release create v1.1.0 --title "CivicPermit v1.1.0" --generate-notes
gh release create v1.1.0 <asset.zip> --generate-notes   # attach an asset
gh release upload v1.1.0 <asset.zip>                     # add an asset later
gh release view v1.1.0 [--web]
gh release list
```

## Handy shortcuts

```bash
gh browse                                  # open the repo in the browser at the current branch
gh browse -b main                          # ...at a specific branch
gh browse src/CivicPermit.Api/Program.cs   # open a specific file
gh browse <number>                         # open issue/PR #<number>
gh browse --settings                       # jump to repo Settings
gh browse --releases                       # jump to the Releases page

gh issue develop <number> --checkout       # create a branch linked to an issue and switch to it

gh pr create --fill                        # draft title/body from your commits
gh pr checks --watch                       # live-follow checks until they finish
gh pr status                               # your PRs at a glance
gh pr merge --auto --squash --delete-branch  # auto-merge when required checks pass

gh run rerun --failed                      # re-run only the failed jobs

gh alias set co 'pr checkout'              # then: gh co <number>
gh config set editor "code --wait"         # use VS Code for gh drafts
```

## Raw API (for settings not yet in gh subcommands)

```bash
# Flags span lines with a trailing \ in Bash — in PowerShell swap each \ for a backtick (`).
# Enable a required status check on main (classic protection):
gh api -X PUT repos/{owner}/{repo}/branches/main/protection \
  -f "required_status_checks[strict]=true" \
  -f "required_status_checks[contexts][]=Build & Test (CivicPermit)" \
  -f "enforce_admins=true" \
  -f "required_pull_request_reviews[required_approving_review_count]=1" \
  -f "restrictions=null"

# List Dependabot alerts (requires Advanced Security):
gh api repos/{owner}/{repo}/dependabot/alerts
```

> Run these from inside the repo so `gh` fills in `{owner}/{repo}` automatically.
