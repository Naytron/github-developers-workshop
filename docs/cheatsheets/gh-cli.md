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

## Raw API (for settings not yet in gh subcommands)

```bash
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
