# Operation Fortress submission

## Executive summary

Operation Fortress specifies a defense-in-depth Kubernetes platform for
FinServ Digital: isolated domain/environment namespaces, least-privilege RBAC,
default-deny networking, Vault-backed identity, Pod Security Standards,
Kyverno admission, audit logging, Falco detection, strict mTLS, autoscaling,
and documented recovery.

## ADR decision log

1. **Decision:** Use four domain namespaces in each environment. **Alternatives considered:** shared namespaces or one namespace per service. **Rationale:** Stable domain boundaries simplify ownership, quotas, and policy review. **Trade-offs accepted:** More namespace objects and policy maintenance.
2. **Decision:** Use default-deny ingress and egress. **Alternatives considered:** perimeter-only controls. **Rationale:** A compromised workload cannot move laterally by default. **Trade-offs accepted:** Every new dependency needs an allow rule.
3. **Decision:** Enforce Restricted PSS in prod and Baseline in non-prod. **Alternatives considered:** Restricted everywhere or no enforcement. **Rationale:** Production needs the strongest guardrail while developer iteration remains practical. **Trade-offs accepted:** Non-prod parity is slightly lower.
4. **Decision:** Use Vault Agent with short-lived leases. **Alternatives considered:** Kubernetes Secrets or static environment credentials. **Rationale:** Credentials are rotated and scoped to workload identity. **Trade-offs accepted:** Vault availability and injector operations are required.
5. **Decision:** Build minimal non-root images with read-only filesystems. **Alternatives considered:** general-purpose base images. **Rationale:** Smaller attack surface and stronger runtime isolation. **Trade-offs accepted:** Debugging requires logs and ephemeral diagnostics rather than shell access.
6. **Decision:** Select Kyverno as the admission controller. **Alternatives considered:** Gatekeeper/OPA and unguarded admission. **Rationale:** Kubernetes-native policies can enforce signed, digest-pinned images with readable rules. **Trade-offs accepted:** Policy lifecycle and webhook availability must be operated.
7. **Decision:** Use Istio strict mTLS for service traffic. **Alternatives considered:** application-managed TLS or no mesh. **Rationale:** Uniform identity and encryption support progressive delivery. **Trade-offs accepted:** Sidecars and certificate operations consume resources.
8. **Decision:** Use HPA with conservative requests. **Alternatives considered:** fixed overprovisioning or external autoscaling only. **Rationale:** It controls cost while absorbing normal payment peaks. **Trade-offs accepted:** Metrics quality and load tests are prerequisites.
9. **Decision:** Audit Secret metadata and mutation requests. **Alternatives considered:** no audit or full Secret bodies. **Rationale:** Metadata supports investigations without routinely storing values. **Trade-offs accepted:** Request-level evidence increases log volume.
10. **Decision:** Encrypt and quarterly-test external etcd backups. **Alternatives considered:** cluster-local snapshots only. **Rationale:** Recovery must survive control-plane loss and be demonstrable. **Trade-offs accepted:** KMS, immutable storage, and restore exercises add cost.
11. **Decision:** Pin one signed image digest through all environments. **Alternatives considered:** mutable tags per environment. **Rationale:** Promotion proves the tested artifact is the deployed artifact. **Trade-offs accepted:** Releases require explicit digest updates.
12. **Decision:** Keep validation offline and reproducible. **Alternatives considered:** live-cluster-only checks. **Rationale:** Reviewers can reproduce YAML and schema checks without credentials. **Trade-offs accepted:** Provider and runtime integration still need later testing.

## Stakeholder responses

### CISO Priya

The complete 12-requirement map is in
[`docs/compliance/pci-dss-mapping.md`](docs/compliance/pci-dss-mapping.md), with
evidence paths to [`k8s/`](k8s/) controls, audit policy, Falco, Vault, and
runbooks. [`docs/compliance/audit-evidence-package.md`](docs/compliance/audit-evidence-package.md)
defines the evidence index and retention approach.

### Developers Ananya and Vikram

The onboarding guide gives a five-step secrets workflow: join the SSO group,
select context, build/scan/sign, deploy the pinned digest with Helm, then read
logs and troubleshoot without production exec. See
[`docs/operations/developer-onboarding-guide.md`](docs/operations/developer-onboarding-guide.md)
and [`docs/operations/troubleshooting-guide.md`](docs/operations/troubleshooting-guide.md).
Helm values are environment-specific in [`helm/`](helm/), and logs are allowed
without Secret access in [`k8s/rbac/roles.yaml`](k8s/rbac/roles.yaml).

### VP Sanjay

**Plain-language status:** the platform design is complete enough for offline
review and validation; diagram PNGs and real operational screenshots remain
inputs before final submission. Cost is controlled with quotas, limits, HPA,
and smaller non-prod pools. The operating model and 5x growth actions are in
[`docs/operations/platform-operations-runbook.md`](docs/operations/platform-operations-runbook.md)
and [`docs/architecture/cluster-architecture.md`](docs/architecture/cluster-architecture.md).

## Evidence index

| Area | Evidence |
|---|---|
| Architecture | `docs/architecture/cluster-architecture.md` |
| Tenancy | `k8s/namespaces/`, `k8s/resource-quotas/`, `k8s/limit-ranges/` |
| RBAC | `k8s/rbac/`, `docs/security/rbac-matrix.md` |
| Network isolation | `k8s/network-policies/`, `docs/security/network-flow-diagram.md` |
| Secrets | `k8s/vault/`, `docs/security/vault-architecture.md` |
| Supply chain | `k8s/admission-control/`, `Dockerfiles/` |
| Runtime security | `k8s/pod-security/`, `k8s/audit/` |
| Operations | `docs/operations/`, `k8s/monitoring/` |
| Compliance | `docs/compliance/` |
