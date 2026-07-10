---
title: "Cheat Sheet — dotnet CLI"
---

# Cheat Sheet — dotnet CLI

[← Home](../index.md) · Guide: [.NET SDK setup](../guides/dotnet-sdk-setup.md)

Run these from the repository root unless noted.

## Info

```bash
dotnet --version         # active SDK version (should start with 10.)
dotnet --list-sdks       # installed SDKs
dotnet --info            # detailed environment info
```

## Restore / build / test

```bash
dotnet restore                          # download NuGet packages
dotnet build                            # compile (Debug by default)
dotnet build -c Release --no-restore    # release build, reuse restore
dotnet test                             # run all xUnit tests
dotnet test -c Release --no-build       # reuse a prior build
```

## Run the API

```bash
dotnet run --project src/CivicPermit.Api
# Watch the console for: Now listening on: http://localhost:5150
```

Hot reload during development:

```bash
dotnet watch --project src/CivicPermit.Api run
```

## Try the endpoints

```bash
curl http://localhost:5150/permits
curl http://localhost:5150/permits/1
curl -X POST http://localhost:5150/permits \
  -H "Content-Type: application/json" \
  -d '{"applicantName":"A. Carpenter","address":"42 Oak Ave","permitType":"Deck"}'
curl -X POST http://localhost:5150/permits/1/inspections \
  -H "Content-Type: application/json" \
  -d '{"inspectionType":"Framing","scheduledFor":"2026-08-15"}'
```

## Publish (for releases)

```bash
dotnet publish src/CivicPermit.Api -c Release -o ./publish
```

## Test filtering & output

```bash
dotnet test --filter "FullyQualifiedName~Inspections"    # only inspection tests
dotnet test --logger "trx;LogFileName=test-results.trx" \
            --results-directory ./TestResults            # save results (as CI does)
```

## Solution & project structure

```bash
dotnet sln list                                 # projects in the solution
dotnet build CivicPermit.sln                    # build the whole solution
```

> Everything restores from **NuGet only** — no global tools, no NPM, no other installs.
