# RBAC matrix

All roles are namespace-scoped unless explicitly marked cluster-scoped.

| Persona | Scope | Allowed | Explicitly denied |
|---|---|---|---|
| Platform Admin | cluster | lifecycle, policy, nodes | direct secret values by default |
| Namespace Admin | one namespace | workloads, config, events | RBAC and namespace mutation |
| Developer | one namespace | get/list/watch workloads and logs | exec, secrets, RBAC |
| CI/CD service account | one namespace | apply workloads and services | nodes, RBAC, secrets |
| Security Auditor | cluster read-only | policy, RBAC, audit metadata | workload mutation and secret values |
| Monitoring service account | cluster read-only | discovery and metrics endpoints | mutation and secret access |

Bindings must be mapped to identity-provider groups in production. Do not bind
human users to `system:masters`.
