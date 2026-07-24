---
title: After the Workshop
---

# After the Workshop

[← Home](index.md)

You've taken a feature from **Issue** to **Release**. Here's how to make it stick.

## Practice on your own

Repeat the whole loop with a **second** small feature on CivicPermit — for example:

- `GET /permits/{id}/inspections` — list the inspections for a permit.
- Add a `Notes` field to a permit and surface it in the API.
- Add validation that `ScheduledFor` can't be in the past.

For each: open an issue, branch, implement + test, open a PR, let CI run, merge, and cut a
release. The muscle memory is the point.

## Bring it back to your team

- **Adopt a branching convention.** See [Branching & Commits](modules/02-branching-and-commits.md).
- **Turn on branch protection** with a required status check on your default branch —
  see [Module 5](modules/05-branch-protection-and-merge.md).
- **Add a CI workflow** to every repo — start from [`ci.yml`](modules/04-github-actions-ci.md).
- **Enable the security features** you tried in [Lab 7](labs/lab-07-secure-development.md):
  Dependabot, secret scanning, and code scanning.

## Reference you can keep

- [Git cheat sheet](cheatsheets/git-commands.md)
- [GitHub CLI cheat sheet](cheatsheets/gh-cli.md)
- [dotnet CLI cheat sheet](cheatsheets/dotnet-cli.md)
- [Markdown & PR cheat sheet](cheatsheets/markdown-and-pr.md)
- [Actions YAML cheat sheet](cheatsheets/actions-yaml.md)

## Clean up (optional)

If you worked in a throwaway fork or training repo, leave your account tidy:

```bash
# Remove the local build artifacts from Lab 6:
# Bash
rm -rf ./publish ./CivicPermit.Api-*.zip
# PowerShell
Remove-Item -Recurse -Force ./publish, ./CivicPermit.Api-*.zip -ErrorAction SilentlyContinue

# Delete the test tag you pushed in Lab 6 (local + remote) — same in both shells:
git tag -d v1.1.1
git push origin :refs/tags/v1.1.1

# If you no longer need your fork, delete it (irreversible):
gh repo delete <your-org>/github-developers-workshop --yes
```

> Deleting a repo needs the `delete_repo` scope — run `gh auth refresh -s delete_repo` first.

## Keep learning

- [Wrap-up & next steps](modules/08-wrap-up-and-next-steps.md) — curated links to official docs.
- [Optional architect hardening track](index.md#optional-architect-hardening-track) — deeper guidance on enterprise controls.
- **GitHub Copilot workshop** — the natural next step. Watch for the *Copilot Connection*
  notes sprinkled through these materials; the follow-up workshop goes deep on each one.

---

Thanks for coming! Questions later? Open an issue in the workshop repo using the
[feature request template](labs/lab-01-open-the-issue.md).
