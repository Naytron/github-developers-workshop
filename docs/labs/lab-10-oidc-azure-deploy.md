---
title: "Lab 10 — OIDC Deployments (Azure)"
---

# Lab 10 — OIDC Deployments (Azure)

⏱️ ~40 min · Optional architect extension · Module: [OIDC Deployments](../modules/10-oidc-deployments.md) · [← Home](../index.md)

**Goal:** deploy to Azure with **zero stored cloud credentials**. GitHub mints a short-lived
OpenID Connect (OIDC) token at run time; Azure trades it for an access token via a **federated
credential**. You'll wire `azure/login`, remove static secrets, and prove a keyless deploy.

> ⚠️ **This lab needs real Azure access.** You must be able to create an **Entra app
> registration** and a **federated credential**, and assign an Azure role. Most attendees
> don't have tenant rights → run as an **instructor demo** in a sandbox subscription. See the
> [prerequisites matrix](../guides/advanced-track-prerequisites.md). Do Lab 9 first — this
> lab reuses the `production` environment.

## The trust model (read before clicking)

```
GitHub Actions run  --OIDC token (subject claim)-->  Entra federated credential  -->  Azure token
```

There are **no secrets** in this chain — only the app registration's **IDs** (client, tenant,
subscription), which are identifiers, not credentials.

## Step 1 — Create the app registration + service principal

```bash
az ad app create --display-name "civicpermit-oidc" --query appId -o tsv
# capture the appId, then:
az ad sp create --id <APP_ID>
```

## Step 2 — Add the federated credential (the exact part)

The **subject** must match the workflow's trigger **exactly**. The ship-ready workflow
(`deploy-oidc-azure.yml`) deploys through the `production` environment, so use the environment
subject:

```
repo:<ORG>/<REPO>:environment:production
```

```bash
# Bash
az ad app federated-credential create --id <APP_ID> --parameters '{
  "name": "civicpermit-prod",
  "issuer": "https://token.actions.githubusercontent.com",
  "subject": "repo:<ORG>/<REPO>:environment:production",
  "audiences": ["api://AzureADTokenExchange"]
}'

# PowerShell
$fc = @{
  name      = "civicpermit-prod"
  issuer    = "https://token.actions.githubusercontent.com"
  subject   = "repo:<ORG>/<REPO>:environment:production"
  audiences = @("api://AzureADTokenExchange")
} | ConvertTo-Json
az ad app federated-credential create --id <APP_ID> --parameters $fc
```

> 🧠 **Subject claim reference** (pick the one matching your trigger — a mismatch is the #1
> failure):
> - Branch: `repo:<ORG>/<REPO>:ref:refs/heads/main`
> - Environment: `repo:<ORG>/<REPO>:environment:production`
> - Pull request: `repo:<ORG>/<REPO>:pull_request`
>
> **Fork PRs receive no id-token by design** — you cannot OIDC-deploy from a forked PR.

## Step 3 — Grant the service principal a role

```bash
# PowerShell: swap the trailing \ for a backtick `
az role assignment create --assignee <APP_ID> --role "Contributor" \
  --scope /subscriptions/<SUBSCRIPTION_ID>/resourceGroups/<RG_NAME>
```

## Step 4 — Store the (non-secret) IDs

```bash
# Bash
gh secret set AZURE_CLIENT_ID --env production --body "<APP_ID>"
gh secret set AZURE_TENANT_ID --env production --body "$(az account show --query tenantId -o tsv)"
gh secret set AZURE_SUBSCRIPTION_ID --env production --body "$(az account show --query id -o tsv)"

# PowerShell
gh secret set AZURE_CLIENT_ID --env production --body "<APP_ID>"
gh secret set AZURE_TENANT_ID --env production --body (az account show --query tenantId -o tsv)
gh secret set AZURE_SUBSCRIPTION_ID --env production --body (az account show --query id -o tsv)
```

## Step 5 — Inspect the workflow's OIDC wiring

Open `.github/workflows/deploy-oidc-azure.yml`. The three lines that make OIDC work:

```yaml
permissions:
  id-token: write        # NOT granted by default — required to request the OIDC token
  contents: read
# ...
    - uses: azure/login@v2
      with:
        client-id: ${{ secrets.AZURE_CLIENT_ID }}
        tenant-id: ${{ secrets.AZURE_TENANT_ID }}
        subscription-id: ${{ secrets.AZURE_SUBSCRIPTION_ID }}
```

## Step 6 — Deploy keyless

```bash
gh workflow run deploy-oidc-azure.yml --ref main
gh run watch
```

Approve the environment gate (from Lab 9). The `az account show` step proves you authenticated
**without any stored cloud key**.

## ✅ Checkpoint

- [ ] App registration + federated credential exist.
- [ ] Federated **subject** matches the workflow trigger (environment subject).
- [ ] `id-token: write` is set on the deploy job only.
- [ ] No Azure client secret / access key is stored in GitHub.
- [ ] Deploy authenticated and ran (or was demoed).

## Troubleshooting

- **`AADSTS700213` / "No matching federated identity record found"** → the subject claim
  doesn't match the trigger. Recheck Step 2 against the reference box.
- **`Error: Unable to get ACTIONS_ID_TOKEN_REQUEST_URL`** → you forgot `id-token: write`.
- **Works on push but not on a PR** → fork PRs get no id-token; use branch/environment triggers.
- **Just created the credential and it fails** → allow a minute for propagation; there's also a
  per-app cap on federated credentials.
- More in [Troubleshooting](../troubleshooting.md) and the
  [prerequisites matrix](../guides/advanced-track-prerequisites.md).

> 💡 **Copilot Connection:** ask Copilot to explain the difference between a federated
> credential and a client secret, and to generate the subject claim for a given trigger — then
> verify it against your repo/org names.

## Next

Continue to [Lab 11 — Reusable Workflows](lab-11-reusable-workflows.md).
