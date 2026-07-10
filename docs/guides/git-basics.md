---
title: "Guide — Git Basics"
---

# Guide — Git Basics

[← Home](../index.md)

A short, practical primer on the Git concepts this workshop uses. For a one-page command
reference, see the [Git cheat sheet](../cheatsheets/git-commands.md).

## Install Git

- **Windows:** download from <https://git-scm.com/download/win> (or your org's software
  portal). Includes **Git Bash**, a handy terminal.
- **macOS:** `xcode-select --install`, or download from git-scm.com.
- **Linux:** `sudo apt install git` / `sudo dnf install git`.

Verify:

```bash
git --version
```

## One-time configuration

Set your identity (used in commit metadata) and a sensible default branch name:

```bash
git config --global user.name  "Your Name"
git config --global user.email "you@example.com"
git config --global init.defaultBranch main
git config --global pull.rebase false     # simple merge on pull
```

## The mental model

Git has four "places" your work moves through:

```
Working directory  →  Staging area (index)  →  Local repo  →  Remote (GitHub)
      (edit)              (git add)            (git commit)     (git push)
```

- **Working directory:** the files you edit.
- **Staging area:** changes you've marked for the next commit (`git add`).
- **Local repository:** your commit history on your machine.
- **Remote:** the shared copy on GitHub (`origin`).

## The everyday loop

```bash
git switch main && git pull              # start from the latest
git switch -c feature/123-my-change      # branch
# ... edit files ...
git add <files>                          # stage
git commit -m "feat: do the thing"       # commit
git push -u origin feature/123-my-change # publish
```

## Branches

A branch is a movable pointer to a commit. `main` is shared; feature branches are where
you work.

```bash
git switch -c feature/x   # create + switch
git switch main           # switch back
git branch --show-current # where am I?
git branch                # list local branches
```

## Inspecting history & changes

```bash
git status                # what's changed / staged
git diff                  # unstaged changes
git diff --staged         # staged changes
git log --oneline -10     # recent commits
```

## Undoing things (safely)

```bash
git restore <file>              # discard unstaged changes to a file
git restore --staged <file>     # unstage (keep edits)
git commit --amend              # fix the most recent commit message/content
git revert <sha>                # make a NEW commit that undoes an old one
```

> Prefer `revert` over history-rewriting on shared branches. See
> [Troubleshooting](../troubleshooting.md) for "I committed on main" and similar.

## Remotes

```bash
git remote -v             # show remotes
git fetch                 # download refs without merging
git pull                  # fetch + merge into current branch
git push                  # upload current branch
```

## Glossary

| Term | Meaning |
| ---- | ------- |
| **Commit** | A snapshot + message. |
| **Branch** | A named line of commits. |
| **Remote** | A hosted copy (GitHub), usually `origin`. |
| **Clone** | A full local copy of a repo. |
| **Fork** | Your own server-side copy of someone else's repo. |
| **HEAD** | Your current position (usually the tip of a branch). |

> 💡 **Copilot Connection:** In the Copilot workshop, Copilot can explain unfamiliar Git
> errors and suggest the exact command to recover. The fundamentals here make those
> suggestions easy to trust.
