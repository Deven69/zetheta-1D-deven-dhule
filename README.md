# Operation Fortress

Security-hardened Kubernetes platform for the FinServ Digital microservices platform.

## Repository map

- `docs/architecture/` - topology and design decisions
- `namespaces/`, `resource-quotas/`, `limit-ranges/` - tenancy boundaries
- `rbac/`, `network-policies/`, `pod-security/` - cluster security controls
- `vault/`, `admission-control/`, `audit/`, `service-mesh/` - advanced controls
- `helm/` - reusable service deployment chart and environment values
- `monitoring/`, `operations/`, `compliance/` - operational and audit evidence
- `scripts/` - offline and cluster validation helpers

## Validation

```powershell
.\scripts\validate-manifests.ps1
```

For a live cluster, also run `kubectl auth can-i`, `kubectl diff`, and the
configured kubeconform/yamllint checks described in `operations/`.

This repository contains declarative examples. Vault, admission controllers,
service mesh, Falco, Prometheus, and an HA control plane must be installed and
configured by the platform team before production use.
