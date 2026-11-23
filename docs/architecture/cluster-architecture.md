# Cluster architecture

Three independently operated HA Kubernetes clusters are used for development,
staging, and production. Each has three control-plane nodes, an odd-sized etcd
cluster, and failure-domain-spread worker pools.

## Node pools

| Pool | Purpose | Scheduling |
|---|---|---|
| system | CoreDNS, ingress, monitoring | tainted; platform tolerations |
| payments | PCI-sensitive workloads | dedicated nodes and encryption at rest |
| general | risk/customer services | topology spread constraints |
| platform | Vault, policy controllers, service mesh | dedicated platform workloads |

Production uses three availability zones, PodDisruptionBudgets, encrypted
persistent volumes, and private control-plane endpoints. Development and
staging retain the same namespace and policy model, but may use smaller pools.

## Recovery

etcd snapshots are encrypted with an external KMS, copied to immutable object
storage, and restored quarterly into an isolated recovery cluster. Application
data uses service-owned backups. Recovery objectives and evidence are recorded
in `docs/operations/platform-operations-runbook.md`.

```mermaid
flowchart TB
  internet((Internet)) --> edge[Private ingress / WAF]
  edge --> prod[Production HA cluster]
  edge --> stage[Staging HA cluster]
  edge --> dev[Development HA cluster]
  prod --> cp1[3 control planes + etcd]
  prod --> pools[system | payments | general | platform pools]
  pools --> ns[payments / risk / customer / platform namespaces]
```
