# Platform operations runbook

## Incident containment

1. Confirm the alert and preserve API audit/Falco evidence.
2. Isolate the workload with a temporary namespace or workload-specific deny
   policy approved by Security.
3. Revoke Vault leases and rotate affected credentials.
4. Quarantine the image digest in the registry and preserve the pod spec.
5. Restore only from a reviewed, signed image; document every action.

## Routine operations

- Rotate Vault and mesh certificates before expiry; verify trust chains.
- Back up encrypted etcd snapshots to immutable storage and test restore
  quarterly.
- Review HPA saturation, quota headroom, failed admissions, and policy drift.
- During upgrades, drain one failure domain at a time while respecting PDBs.

## 5x growth plan

Keep prod quotas and HPA ceilings under review, add worker capacity by failure
domain, and load-test payment and fraud paths before raising limits. Retain
smaller dev/staging pools and use the same signed digest promotion path.
