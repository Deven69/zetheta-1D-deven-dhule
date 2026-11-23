# Vault integration

Workloads authenticate with Kubernetes ServiceAccount JWTs through the Vault
Kubernetes auth method. The Vault Agent Injector renders short-lived,
domain-scoped secrets into an in-memory volume; applications never receive a
long-lived Kubernetes Secret.

Vault audit devices must be enabled and shipped to an immutable, access
controlled destination. Policies are split by domain and deny cross-domain
paths. Rotation and revocation are documented in the operations runbook.
# Vault architecture

Each domain uses a namespace-bound workload identity and a short-lived Vault
lease. Vault Agent renders only the service's path into an in-memory volume;
applications never receive Kubernetes Secret values or static credentials.
