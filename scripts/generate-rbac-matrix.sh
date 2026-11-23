#!/usr/bin/env bash
set -euo pipefail

repo_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
output="${1:-$repo_root/docs/security/rbac-matrix.md}"
cat > "$output" <<'EOF'
# RBAC matrix

| Persona | Scope | Allowed | Explicitly denied |
|---|---|---|---|
| Platform Admin | cluster | lifecycle and policy administration | routine Secret reads |
| Namespace Admin | one namespace | workloads, config, events | RBAC and namespace mutation |
| Developer | one namespace | workload reads and logs; exec only dev/staging | Secrets and production exec |
| CI/CD service account | one environment | deploy workloads and services | Secrets, nodes, and RBAC |
| Security Auditor | cluster read-only | policy, RBAC, and audit metadata | mutation and Secret values |
| Monitoring service account | cluster read-only | discovery and metrics | mutation, Secrets, and ConfigMaps |
EOF
printf 'Wrote %s\n' "$output"
