# Operation Fortress Submission

## Executive summary

Operation Fortress applies defense in depth to the FinServ Digital platform:
environment isolation, least-privilege RBAC, default-deny network policy,
Vault-backed secrets, Pod Security Standards, signed-image admission, audit
logging, runtime detection, strict mTLS, autoscaling, and documented recovery.

## Acceptance evidence

| Area | Evidence |
|---|---|
| Architecture | `docs/architecture/cluster-architecture.md` |
| Tenancy | `namespaces/`, `resource-quotas/`, `limit-ranges/` |
| RBAC | `rbac/`, `docs/security/rbac-matrix.md` |
| Network isolation | `network-policies/`, `docs/security/network-flow.md` |
| Secrets | `vault/` |
| Supply chain | `admission-control/`, `Dockerfiles/` |
| Runtime security | `pod-security/`, `audit/` |
| Operations | `operations/`, `monitoring/hpa/` |
| Compliance | `compliance/pci-dss-mapping.md` |

## ADR decision log

1. Separate namespaces per environment and domain.
2. Default-deny ingress and egress with explicit service dependencies.
3. Restricted PSS for production; Baseline for non-production.
4. Vault Agent Injector instead of static application secrets.
5. Multi-stage, non-root, minimal container images.
6. Kyverno-style signature and vulnerability admission controls.
7. Istio selected for mTLS and progressive delivery capabilities.
8. HPA with conservative resource requests for payment services.
9. API audit policy records secret metadata and mutation request bodies.
10. etcd snapshots are encrypted, tested, and stored outside the cluster.

## Innovation / patent-worthy concept

The platform combines dependency-derived network policy generation with
domain-scoped Vault identities and admission-time workload attestations. A
service's declared dependency graph becomes a machine-verifiable security
contract that can be reconciled whenever the platform topology changes.
