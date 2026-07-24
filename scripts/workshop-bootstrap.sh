#!/usr/bin/env bash
set -euo pipefail

organization=""
source_organization=""
codeowners_principal=""
apply_changes=false
skip_remote_checks=false

while [[ $# -gt 0 ]]; do
  case "$1" in
    --organization)
      organization="$2"
      shift 2
      ;;
    --source-organization)
      source_organization="$2"
      shift 2
      ;;
    --codeowners-principal)
      codeowners_principal="$2"
      shift 2
      ;;
    --apply-changes)
      apply_changes=true
      shift
      ;;
    --skip-remote-checks)
      skip_remote_checks=true
      shift
      ;;
    *)
      echo "Unknown argument: $1"
      exit 2
      ;;
  esac
done

if [[ -z "$organization" ]]; then
  echo "Missing required argument: --organization"
  exit 2
fi

if [[ -z "$source_organization" ]]; then
  source_organization="$organization"
fi

if [[ -z "$codeowners_principal" ]]; then
  codeowners_principal="@${organization}/workshop-maintainers"
fi

script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
repo_root="$(cd "${script_dir}/.." && pwd)"
cd "$repo_root"

editable_files=(
  "README.md"
  "docs/before.md"
  "docs/after.md"
  ".github/ISSUE_TEMPLATE/config.yml"
  ".github/CODEOWNERS"
)

replace_in_file() {
  local file="$1"
  local tmp_file
  tmp_file="$(mktemp)"

  local org_escaped src_org_escaped codeowners_escaped
  org_escaped="$(printf '%s' "$organization" | sed -e 's/[\/&|\\]/\\&/g')"
  src_org_escaped="$(printf '%s' "$source_organization" | sed -e 's/[\/&|\\]/\\&/g')"
  codeowners_escaped="$(printf '%s' "$codeowners_principal" | sed -e 's/[\/&|\\]/\\&/g')"

  sed \
    -e "s|<your-org>|${org_escaped}|g" \
    -e "s|<src-org>|${src_org_escaped}|g" \
    -e "s|@your-org/workshop-maintainers|${codeowners_escaped}|g" \
    "$file" > "$tmp_file"
  cat "$tmp_file" > "$file"
  rm -f "$tmp_file"
  echo "Updated: $file"
}

if [[ "$apply_changes" == true ]]; then
  echo "Applying placeholder replacements..."
  for file in "${editable_files[@]}"; do
    if [[ -f "$file" ]]; then
      replace_in_file "$file"
    fi
  done
else
  echo "Apply changes not requested: running validation-only mode."
fi

errors=()
warnings=()

for file in "${editable_files[@]}"; do
  if [[ ! -f "$file" ]]; then
    errors+=("Missing required file: $file")
    continue
  fi

  if grep -q "<your-org>" "$file"; then
    errors+=("Placeholder <your-org> still present in $file")
  fi
  if grep -q "<src-org>" "$file"; then
    errors+=("Placeholder <src-org> still present in $file")
  fi
  if grep -q "@your-org/workshop-maintainers" "$file"; then
    errors+=("Placeholder @your-org/workshop-maintainers still present in $file")
  fi
done

if [[ -f ".github/CODEOWNERS" ]]; then
  if grep -q "@your-org/workshop-maintainers" ".github/CODEOWNERS"; then
    errors+=("CODEOWNERS still contains @your-org/workshop-maintainers")
  fi

  owner_lines="$(grep -E '^[[:space:]]*[^#[:space:]].*@[A-Za-z0-9_.-]+' ".github/CODEOWNERS" || true)"
  if [[ -z "$owner_lines" ]]; then
    errors+=("CODEOWNERS has no active ownership rules")
  fi
fi

required_paths=(
  ".github/workflows/ci.yml"
  ".github/workflows/pages.yml"
  ".github/workflows/release.yml"
  ".github/dependabot.yml"
)

for required_path in "${required_paths[@]}"; do
  if [[ ! -f "$required_path" ]]; then
    errors+=("Missing required file: $required_path")
  fi
done

if [[ "$skip_remote_checks" == false ]]; then
  if ! command -v gh >/dev/null 2>&1; then
    warnings+=("GitHub CLI not found. Skipped remote checks.")
  elif ! gh auth status >/dev/null 2>&1; then
    warnings+=("gh auth status failed. Run 'gh auth login' to enable remote checks.")
  else
    name_with_owner="$(gh repo view --json nameWithOwner --jq .nameWithOwner 2>/dev/null || true)"
    if [[ -z "$name_with_owner" ]]; then
      warnings+=("Could not determine repository from gh repo view.")
    else
      default_branch="$(gh repo view --json defaultBranchRef --jq .defaultBranchRef.name 2>/dev/null || true)"
      if [[ -n "$default_branch" && "$default_branch" != "main" ]]; then
        warnings+=("Default branch is '$default_branch' (expected 'main' for workshop docs).")
      fi

      actions_enabled="$(gh api "repos/${name_with_owner}/actions/permissions" --jq .enabled 2>/dev/null || true)"
      if [[ -n "$actions_enabled" && "$actions_enabled" != "true" ]]; then
        warnings+=("GitHub Actions appears disabled for ${name_with_owner}.")
      fi

      ruleset_count="$(gh api "repos/${name_with_owner}/rulesets" --jq "length" 2>/dev/null || true)"
      if [[ -n "$ruleset_count" && "$ruleset_count" == "0" ]]; then
        warnings+=("No repository rulesets found. Add one before running Lab 07 at scale.")
      fi

      if ! gh api "repos/${name_with_owner}/pages" >/dev/null 2>&1; then
        warnings+=("GitHub Pages does not appear configured yet for ${name_with_owner}.")
      fi
    fi
  fi
fi

echo
echo "=== Workshop bootstrap preflight ==="
echo "Organization: ${organization}"
echo "Source organization: ${source_organization}"
echo "Codeowners principal: ${codeowners_principal}"

if [[ ${#warnings[@]} -gt 0 ]]; then
  echo
  echo "Warnings:"
  for warning in "${warnings[@]}"; do
    echo "- ${warning}"
  done
fi

if [[ ${#errors[@]} -gt 0 ]]; then
  echo
  echo "Errors:"
  for error in "${errors[@]}"; do
    echo "- ${error}"
  done
  exit 1
fi

echo
echo "Preflight passed."
