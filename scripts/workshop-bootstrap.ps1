[CmdletBinding()]
param(
    [Parameter(Mandatory = $true)]
    [string]$Organization,
    [string]$SourceOrganization,
    [string]$CodeownersPrincipal,
    [switch]$ApplyChanges,
    [switch]$SkipRemoteChecks
)

Set-StrictMode -Version Latest
$ErrorActionPreference = "Stop"

if ([string]::IsNullOrWhiteSpace($SourceOrganization))
{
    $SourceOrganization = $Organization
}

if ([string]::IsNullOrWhiteSpace($CodeownersPrincipal))
{
    $CodeownersPrincipal = "@$Organization/workshop-maintainers"
}

$repoRoot = (Resolve-Path (Join-Path $PSScriptRoot "..")).Path
Set-Location $repoRoot

$editableFiles = @(
    "README.md",
    "docs/before.md",
    "docs/after.md",
    ".github/ISSUE_TEMPLATE/config.yml",
    ".github/CODEOWNERS"
)

$replacementMap = @{
    "<your-org>" = $Organization
    "<src-org>" = $SourceOrganization
    "@your-org/workshop-maintainers" = $CodeownersPrincipal
}

function Update-FilePlaceholders
{
    param(
        [string]$RelativePath
    )

    $fullPath = Join-Path $repoRoot $RelativePath
    if (-not (Test-Path $fullPath))
    {
        return
    }

    $original = Get-Content -Path $fullPath -Raw
    $updated = $original
    foreach ($placeholder in $replacementMap.Keys)
    {
        $updated = $updated.Replace($placeholder, $replacementMap[$placeholder])
    }

    if ($updated -ne $original)
    {
        Set-Content -Path $fullPath -Value $updated -Encoding utf8
        Write-Host "Updated: $RelativePath"
    }
}

if ($ApplyChanges)
{
    Write-Host "Applying placeholder replacements..."
    foreach ($file in $editableFiles)
    {
        Update-FilePlaceholders -RelativePath $file
    }
}
else
{
    Write-Host "ApplyChanges not set: running validation-only mode."
}

$errors = [System.Collections.Generic.List[string]]::new()
$warnings = [System.Collections.Generic.List[string]]::new()

foreach ($file in $editableFiles)
{
    $fullPath = Join-Path $repoRoot $file
    if (-not (Test-Path $fullPath))
    {
        $errors.Add("Missing required file: $file")
        continue
    }

    $content = Get-Content -Path $fullPath -Raw
    foreach ($placeholder in @("<your-org>", "<src-org>", "@your-org/workshop-maintainers"))
    {
        if ($content.Contains($placeholder))
        {
            $errors.Add("Placeholder '$placeholder' still present in $file")
        }
    }
}

$codeownersPath = Join-Path $repoRoot ".github/CODEOWNERS"
if (Test-Path $codeownersPath)
{
    $codeowners = Get-Content -Path $codeownersPath -Raw
    if ($codeowners -match "@your-org/workshop-maintainers")
    {
        $errors.Add("CODEOWNERS still contains @your-org/workshop-maintainers")
    }

    $ownerLines = Get-Content -Path $codeownersPath | Where-Object {
        $_ -match '\S' -and -not $_.TrimStart().StartsWith("#")
    }

    if (-not $ownerLines)
    {
        $errors.Add("CODEOWNERS has no active ownership rules")
    }
    elseif (-not ($ownerLines | Where-Object { $_ -match '\s+@' }))
    {
        $errors.Add("CODEOWNERS rules do not include valid owner handles")
    }
}

foreach ($requiredPath in @(".github/workflows/ci.yml", ".github/workflows/pages.yml", ".github/workflows/release.yml", ".github/dependabot.yml"))
{
    if (-not (Test-Path (Join-Path $repoRoot $requiredPath)))
    {
        $errors.Add("Missing required file: $requiredPath")
    }
}

if (-not $SkipRemoteChecks)
{
    if (-not (Get-Command gh -ErrorAction SilentlyContinue))
    {
        $warnings.Add("GitHub CLI not found. Skipped remote checks.")
    }
    else
    {
        & gh auth status *> $null
        if ($LASTEXITCODE -ne 0)
        {
            $warnings.Add("gh auth status failed. Run 'gh auth login' to enable remote checks.")
        }
        else
        {
            $nameWithOwner = (& gh repo view --json nameWithOwner --jq .nameWithOwner 2>$null).Trim()
            if ($LASTEXITCODE -ne 0 -or [string]::IsNullOrWhiteSpace($nameWithOwner))
            {
                $warnings.Add("Could not determine repo from gh repo view.")
            }
            else
            {
                $defaultBranch = (& gh repo view --json defaultBranchRef --jq .defaultBranchRef.name 2>$null).Trim()
                if ($LASTEXITCODE -eq 0 -and $defaultBranch -ne "main")
                {
                    $warnings.Add("Default branch is '$defaultBranch' (expected 'main' for workshop docs).")
                }

                $actionsEnabled = (& gh api "repos/$nameWithOwner/actions/permissions" --jq .enabled 2>$null).Trim()
                if ($LASTEXITCODE -eq 0 -and $actionsEnabled -ne "true")
                {
                    $warnings.Add("GitHub Actions appears disabled for $nameWithOwner.")
                }
                elseif ($LASTEXITCODE -ne 0)
                {
                    $warnings.Add("Could not check Actions permissions via GitHub API.")
                }

                $rulesetCount = (& gh api "repos/$nameWithOwner/rulesets" --jq "length" 2>$null).Trim()
                if ($LASTEXITCODE -eq 0 -and [int]$rulesetCount -eq 0)
                {
                    $warnings.Add("No repository rulesets found. Add one before running Lab 07 at scale.")
                }
                elseif ($LASTEXITCODE -ne 0)
                {
                    $warnings.Add("Could not check repository rulesets via GitHub API.")
                }

                & gh api "repos/$nameWithOwner/pages" *> $null
                if ($LASTEXITCODE -ne 0)
                {
                    $warnings.Add("GitHub Pages does not appear configured yet for $nameWithOwner.")
                }
            }
        }
    }
}

Write-Host ""
Write-Host "=== Workshop bootstrap preflight ==="
Write-Host "Organization: $Organization"
Write-Host "SourceOrganization: $SourceOrganization"
Write-Host "CodeownersPrincipal: $CodeownersPrincipal"

if ($warnings.Count -gt 0)
{
    Write-Host ""
    Write-Host "Warnings:"
    foreach ($warning in $warnings)
    {
        Write-Host "- $warning"
    }
}

if ($errors.Count -gt 0)
{
    Write-Host ""
    Write-Host "Errors:"
    foreach ($errorText in $errors)
    {
        Write-Host "- $errorText"
    }
    exit 1
}

Write-Host ""
Write-Host "Preflight passed."
