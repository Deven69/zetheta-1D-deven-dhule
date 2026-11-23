# Operation Fortress

Operation Fortress is a security-hardened Kubernetes platform design for the
fictional fintech **FinServ Digital**. It specifies four domains
(payments, risk, customer, platform) across dev, staging, and prod, with
offline-validatable manifests, least-privilege RBAC, default-deny networking,
Vault identity, Kyverno admission, strict mTLS, runtime detection, and PCI
evidence. The platform is specified and validated offline; cluster installation
and provider controls are implementation work outside this design repository.

## Architecture at a glance

The platform uses one namespace per domain and environment, layered quotas and
limits, Restricted production PSS, digest-pinned signed images, and explicit
service dependencies. The intended visual overview is
`docs/architecture/cluster-diagram.png` and the dependency view is
`docs/architecture/service-dependency-map.png` (diagram assets remain to be
supplied).

## Repository map

- `docs/architecture/` - cluster, namespace, and dependency design
- `docs/security/` - RBAC, network, Vault, image, incident, and mesh controls
- `docs/compliance/` - PCI mapping, evidence package, and checklist
- `docs/operations/` - onboarding, runbook, and troubleshooting
- `k8s/` - namespaces, RBAC, network, PSS, quotas, Vault, Kyverno, audit, mesh, monitoring, and samples
- `helm/` - chart plus dev, staging, and prod values
- `Dockerfiles/sample-service.Dockerfile` - hardened build reference
- `scripts/` - offline validation and RBAC matrix generation

## Validation

```bash
./scripts/validate-manifests.sh
helm lint helm -f helm/values-prod.yaml
```

The validator runs yamllint and strict kubeconform while excluding Falco rules
and dashboard specifications from Kubernetes schema validation.

## Lab/day progress

| Area | Status |
|---|---|
| Layout and namespace model | Complete |
| RBAC and network baseline | Specified |
| Admission, audit, and runtime controls | Specified |
| Documentation and PCI evidence | In progress |
| Diagram PNGs and real screenshots | Outstanding inputs |

## Key decisions

Kyverno is the selected admission controller. Production uses Restricted PSS,
Vault Agent short-lived identities, default-deny networking, strict mTLS, and
immutable signed image digests. See the ADR decision log in
[`SUBMISSION.md`](SUBMISSION.md).

## Stakeholders served

CISO Priya receives traceable PCI evidence; Ananya and Vikram receive a
low-friction Helm, logs, and five-step secrets workflow; VP Sanjay receives
cost guardrails, runbooks, and a 5x-growth operating model.
