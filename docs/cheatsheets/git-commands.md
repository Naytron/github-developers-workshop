---
title: "Cheat Sheet — Git"
---

# Cheat Sheet — Git

[← Home](../index.md) · Guide: [Git basics](../guides/git-basics.md)

## Setup (once)

```bash
git config --global user.name  "Your Name"
git config --global user.email "you@example.com"
git config --global init.defaultBranch main
```

## Start work

```bash
# 'latest main' chains two commands — Bash uses &&, PowerShell uses ;
git switch main && git pull                  # Bash
git switch main;  git pull                   # PowerShell
git switch -c feature/42-schedule-inspection # new branch (either shell)
git branch --show-current                    # which branch am I on?
```

## The commit loop

```bash
git status                 # what changed?
git add <file> ...         # stage specific files
git add -A                 # stage everything
git commit -m "feat: ..."  # commit staged changes
git push -u origin <branch> # first push (sets upstream)
git push                    # subsequent pushes
```

## Inspect

```bash
git diff                   # unstaged changes
git diff --staged          # staged changes
git log --oneline -10      # recent history
git show <sha>             # a specific commit
```

## Undo / recover

```bash
git restore <file>            # discard unstaged edits
git restore --staged <file>   # unstage but keep edits
git commit --amend            # edit the last commit
git revert <sha>              # new commit that undoes <sha>
git reset --hard origin/main  # DANGER: match local to remote main (loses local changes)
```

## Branches

```bash
git branch                 # list local branches
git switch <branch>        # switch
git switch -c <branch>     # create + switch
git branch -d <branch>     # delete a merged branch
git push origin --delete <branch>  # delete remote branch
```

## Sync with remote

```bash
git fetch                  # download refs, don't merge
git pull                   # fetch + merge current branch
git remote -v              # show remotes
```

## Move a commit off `main` (common oops)

```bash
git switch -c feature/42-schedule-inspection  # make a branch at current commit
git switch main
git reset --hard origin/main                  # restore main
git switch feature/42-schedule-inspection     # your commit is safe here
```

## Tags (for releases)

```bash
git tag v1.1.0             # lightweight tag on current commit
git push origin v1.1.0     # publish the tag
git tag                    # list tags
```
