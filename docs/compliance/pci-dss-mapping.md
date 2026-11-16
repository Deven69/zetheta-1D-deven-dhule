# PCI DSS v4.0 mapping

| Requirement | Kubernetes control | Evidence |
|---|---|---|
| 1 | Default-deny network policy and ingress boundaries | `network-policies/` |
| 2 | Restricted PSS, non-root, dropped capabilities | `pod-security/` |
| 3 | Vault, encrypted etcd backups, digest pinning | `vault/`, `operations/` |
| 4 | Strict service-mesh mTLS | `service-mesh/` |
| 5 | Falco runtime detection and image scanning | `audit/`, `admission-control/` |
| 6 | Signed images and controlled CI/CD role | `admission-control/`, `rbac/` |
| 7 | Least-privilege RBAC | `rbac/` |
| 8 | SSO groups, service accounts, Vault identity | `rbac/`, `vault/` |
| 9 | Private nodes, read-only filesystems, restricted access | `pod-security/` |
| 10 | Kubernetes API audit and Vault audit devices | `audit/`, `vault/` |
| 11 | HPA/health monitoring and recurring validation | `monitoring/`, `scripts/` |
| 12 | Runbooks, ownership, incident response, and review cadence | `operations/` |

This mapping is an evidence index, not a claim of independent assessor
certification. Cloud-provider and organizational controls remain required.
