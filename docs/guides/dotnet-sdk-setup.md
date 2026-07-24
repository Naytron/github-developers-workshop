---
title: "Guide — .NET SDK Setup"
---

# Guide — .NET SDK Setup

[← Home](../index.md)

CivicPermit targets **.NET 10 (LTS)**. You need the **SDK** (not just the runtime) to
build, test, and run it.

## Install the .NET 10 SDK

- **Official installer:** <https://dotnet.microsoft.com/download/dotnet/10.0> — choose the
  **SDK** for your OS/architecture.
- **Windows (winget):** `winget install Microsoft.DotNet.SDK.10`
- **macOS (Homebrew):** `brew install dotnet-sdk`
- **Linux:** follow the distro instructions at the link above.

> Use your organization's software portal if it provides the .NET SDK — it may be the
> approved path in locked-down environments.

## Verify

```bash
dotnet --version      # should start with 10.
dotnet --list-sdks    # confirm a 10.x SDK is present
```

This repo pins the SDK band in `global.json`:

```json
{
  "sdk": {
    "version": "10.0.100",
    "rollForward": "latestFeature",
    "allowPrerelease": false
  }
}
```

That means: use the latest installed **10.0.x** SDK, and don't fall back to a preview. If
you only have a preview installed, install a stable 10.0.x SDK.

> ⚠️ **You need at least `10.0.100`.** `rollForward: latestFeature` only rolls *up* to a
> newer 10.0.x feature band — never down. An older SDK (e.g. `10.0.050`) makes `dotnet
> restore`/`build` fail with an SDK-resolution error. Check with `dotnet --list-sdks` and
> install a `10.0.1xx` (or later) build if yours is lower.

## The commands you'll use

Run these from the repository root:

```bash
dotnet restore                                  # download NuGet packages
dotnet build                                    # compile
dotnet test                                     # run xUnit tests
dotnet run --project src/CivicPermit.Api        # start the API
dotnet publish src/CivicPermit.Api -c Release -o ./publish   # produce a deployable build
```

See the [dotnet CLI cheat sheet](../cheatsheets/dotnet-cli.md) for more.

## What "NuGet only" means

The app restores its dependencies from **NuGet** (the .NET package registry) via
`dotnet restore`. There are **no** global tools, no NPM, and no other installs. If your
org uses a private NuGet feed or proxy and restore fails, see the NuGet section of
[Troubleshooting](../troubleshooting.md).

## Running the API

```bash
dotnet run --project src/CivicPermit.Api
```

Watch the console for a line like `Now listening on: http://localhost:5150`. Then, in a
second terminal:

```bash
curl http://localhost:5150/permits
```

```powershell
Invoke-RestMethod http://localhost:5150/permits
```

Press `Ctrl+C` to stop.

## VS Code integration (optional)

Install **VS Code** and the **C# Dev Kit** extension for build/debug/test in the editor —
see [VS Code setup](vscode-setup.md). The CLI commands above work identically with or
without an IDE.

> 💡 **Copilot Connection:** With the SDK in place, the Copilot workshop can add an AI pair
> that scaffolds endpoints and tests for you. Today the CLI is all you need.
