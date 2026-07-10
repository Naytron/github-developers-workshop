---
title: "Troubleshooting"
---

# Troubleshooting

[← Home](index.md)

Common problems, with copy-paste fixes. Grouped by phase.

## Setup & tooling

### `dotnet --version` isn't 10.x

Install the **.NET 10 SDK** (not just the runtime): [.NET SDK setup](guides/dotnet-sdk-setup.md).
Then:

```bash
dotnet --list-sdks     # confirm a 10.0.x SDK is listed
```

If only a **preview** SDK is installed, install a stable 10.0.x — this repo's `global.json`
sets `allowPrerelease: false` and will refuse a preview.

### `dotnet restore` hangs or fails (corporate proxy / private feed)

Your org may route NuGet through a proxy or private feed.

```bash
# Point at the public feed explicitly (if allowed):
dotnet nuget list source
dotnet restore --source https://api.nuget.org/v3/index.json

# Or set proxy env vars for the shell:
export HTTPS_PROXY=http://proxy.your-company.com:8080
export HTTP_PROXY=http://proxy.your-company.com:8080
```

If your org uses an internal feed, ask IT for the feed URL and add it to a `NuGet.config`.
Still stuck? Flag your instructor — this is environment-specific.

### `gh` won't sign in / can't open a browser

```bash
gh auth login --hostname <your-enterprise-host>
```

Choose the **device code** option when prompted, and enter the code in any browser. Verify:

```bash
gh auth status
```

Behind a proxy? Set `HTTPS_PROXY` (see above) before running `gh`.

### `git clone` / `git push` asks for a password repeatedly

Let `gh` manage Git auth:

```bash
gh auth setup-git
```

Then use HTTPS remotes (the default with `gh repo clone`).

## Branching & commits

### I committed on `main`

Move the commit to a branch and restore `main`:

```bash
git switch -c feature/<issue#>-schedule-inspection
git switch main
git reset --hard origin/main
git switch feature/<issue#>-schedule-inspection
```

### `git push` says "no upstream branch"

First push needs `-u`:

```bash
git push -u origin feature/<issue#>-schedule-inspection
```

### My PR shows files I didn't mean to change

You committed build output or unrelated edits.

```bash
git status
git restore --staged <file>     # unstage
git checkout -- <file>          # discard unwanted edits (careful)
```

Ensure `bin/` and `obj/` are ignored — they are, via [.gitignore](../.gitignore).

## Build & test

### `dotnet build` fails after editing the feature

- Re-read the endpoint and model in [Lab 03](labs/lab-03-implement-endpoint-and-test.md).
- Compare against the [Solution Key](instructor/solution-key.md).
- Fast path: copy the reference files from [`solutions/`](../solutions/README.md) and re-test.

### Tests fail with a serialization or 415 error on POST

Send JSON with the right content type:

```bash
curl -X POST http://localhost:5150/permits/1/inspections \
  -H "Content-Type: application/json" \
  -d '{"inspectionType":"Framing","scheduledFor":"2026-08-15"}'
```

In tests, use `PostAsJsonAsync(...)` (it sets the header for you).

### The app starts on a different port

That's fine — read the console line `Now listening on: http://localhost:PORT` and use that
port in your `curl` commands.

## GitHub Actions / CI

### No workflow runs appear

- **Forks disable Actions by default.** Enable: repo **Settings → Actions → General →
  Allow all actions → Save** (Lab 06 Step 0).
- Confirm the workflow is on the branch you pushed: `git log --oneline -- .github/workflows`.

### `setup-dotnet` fails on the runner

Pin the SDK line:

```yaml
- uses: actions/setup-dotnet@v4
  with:
    dotnet-version: '10.0.x'
```

### The required check never turns green

- The workflow must trigger on `pull_request` (ours does).
- The **required check name** must match the job's display name exactly
  (**Build & Test (CivicPermit)** after Lab 06).

## Merging & protection

### Merge button is disabled

- A **required status check** is red — fix and push.
- A **required review** is missing — get an approval.
- "**Require up to date**" is on — update your branch from `main`:

```bash
git switch feature/<issue#>-schedule-inspection
git fetch origin
git merge origin/main       # resolve any conflicts, commit, push
```

### I can't approve my own PR

Expected. Pair with someone, ask the instructor, or temporarily set required approvals to
`0` for the exercise.

## Releases

### `tag already exists`

Pick the next version:

```bash
gh release create v1.1.1 --generate-notes
```

### Release notes are empty

The feature must be merged as a **PR into `main`** before you tag. Merge first, then create
the release.

## Security features (Module 7)

### A security toggle is missing

Secret scanning and code scanning depend on your **GitHub Enterprise plan** and org
settings. If a toggle isn't there, an **org admin** may need to enable it — note it and
continue as an instructor demo.

### Code scanning shows no results

The first CodeQL scan may still be running — check the **Actions** tab, then revisit the
**Security** tab.

---

Still stuck? Grab your instructor. If it's environment-specific (proxy, feed, plan), that's
expected — note it and move on so the room keeps pace.
