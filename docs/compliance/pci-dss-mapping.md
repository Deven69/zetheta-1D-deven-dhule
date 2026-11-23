# PCI DSS v4.0 mapping

| Requirement | FinServ Digital control | Evidence |
|---|---|---|
| 1 | Default-deny policies and controlled ingress | `k8s/network-policies/default-deny.yaml` |
| 2 | Restricted PSS and hardened containers | `k8s/namespaces/prod-namespaces.yaml`, `k8s/sample-deployments/payment-gateway.yaml` |
| 3 | Vault-managed credentials and encrypted backups | `docs/security/vault-architecture.md`, `docs/operations/platform-operations-runbook.md` |
| 4 | Strict service-mesh mTLS | `k8s/service-mesh/strict-mtls.yaml` |
| 5 | Falco detections and image admission | `k8s/audit/falco-rules.yaml`, `k8s/admission-control/kyverno-policies.yaml` |
| 6 | Signed, digest-pinned images and controlled delivery | `k8s/admission-control/kyverno-policies.yaml`, `k8s/rbac/roles.yaml` |
| 7 | Least-privilege namespace and cluster RBAC | `k8s/rbac/roles.yaml`, `docs/security/rbac-matrix.md` |
| 8 | SSO groups, short-lived service accounts, Vault identity | `k8s/rbac/roles.yaml`, `k8s/vault/vault-policies/payments.hcl` |
| 9 | Workload isolation and restricted filesystem access | `k8s/pod-security/deployment-template.yaml` |
| 10 | API audit and runtime evidence retention | `k8s/audit/audit-policy.yaml`, `k8s/audit/falco-rules.yaml` |
| 11 | HPA, monitoring, and recurring validation | `k8s/monitoring/payments.yaml`, `scripts/validate-manifests.sh` |
| 12 | Governance, runbooks, and incident response | `docs/operations/platform-operations-runbook.md`, `docs/security/incident-response-playbook.md` |

This is a design evidence map, not an assessor certification.
