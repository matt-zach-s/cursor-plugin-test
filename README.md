# cursor-plugin-test

Nuon [Bring Your Own Cloud](https://nuon.co) app configuration for deploying [Apache Superset](https://superset.apache.org/) on AWS: EKS (sandbox), PostgreSQL (RDS), Redis (ElastiCache), and the official Superset Helm chart.

## What gets deployed

- **Sandbox** — `nuonco/aws-eks-sandbox` (cluster, VPC integration, Nuon DNS).
- **RDS** — Terraform module in `components/rds-postgres/` (metadata DB for Superset).
- **Redis** — Terraform module in `components/redis/` (cache and Celery broker).
- **Superset** — Helm chart from `https://apache.github.io/superset/`, values in `components/values/superset/values.yaml`.

Chart subcharts for PostgreSQL and Redis are disabled in Helm values; connections point at the Terraform components instead.

## Repository layout

| Path | Purpose |
|------|---------|
| `metadata.toml` | App metadata |
| `inputs.toml` | Customer inputs (DNS, Superset, scaling, DB, Redis, resources, infra sizing) |
| `sandbox.toml`, `sandbox.tfvars` | EKS sandbox and cluster tuning |
| `runner.toml` | Deployment runner (AWS, Helm driver) |
| `stack.toml` | CloudFormation stack for VPC + runner |
| `secrets.toml` | App secrets (placeholder) |
| `policies.toml` | Cluster policy (Kyverno) |
| `break_glass.toml` | Break-glass IAM roles |
| `permissions/` | Provision, maintenance, and deprovision IAM roles + boundaries |
| `actions/` | Manual kubectl helpers (health, status, restart) |
| `components/0-rds-cluster.toml` | RDS Terraform component |
| `components/1-redis.toml` | Redis Terraform component |
| `components/2-superset.toml` | Superset Helm component (depends on `rds_cluster`, `redis`) |
| `components/rds-postgres/`, `components/redis/` | Terraform source for those components |
| `components/values/superset/values.yaml` | Templated Helm values |

## Prerequisites

- [Nuon CLI](https://docs.nuon.co) installed and authenticated.
- This directory linked as a Nuon app (or use the app that points at this repo).

## Sync the configuration

From this directory:

```bash
nuon apps sync
```

Or the shorthand:

```bash
nuon sync
```

Resolve any validation errors before relying on deploys.

## Pushing to GitHub

The remote is expected to be `matt-zach-s/cursor-plugin-test`. Commit and push your changes when you want them on GitHub:

```bash
git add -A
git commit -m "Describe your change"
git push origin main
```

Consider excluding machine-local files (for example `.claude/settings.local.json`) from commits if you do not want them in the repo.

## Upstream chart

Superset Helm chart source: [apache/superset — `helm/superset`](https://github.com/apache/superset/tree/master/helm/superset).
