# Incident response playbook

## Prepare

Maintain owners, escalation contacts, immutable audit storage, Falco alerting,
Vault lease revocation, and quarterly restore exercises.

## Detect

Correlate API audit, Falco, admission, and mesh telemetry. Preserve the alert,
pod spec, image digest, service account, namespace, and Vault lease.

## Contain

For a network scan followed by attempted reading of production Secrets and
exfiltration, isolate the workload with a deny policy, block egress, suspend
the service account, revoke Vault leases, and quarantine the image digest.

## Eradicate

Rebuild from reviewed source, rotate credentials, remove persistence, rescan
dependencies, and require Kyverno signature and digest admission.

## Recover

Restore from a signed image and verified backup in stages. Monitor audit,
Falco, egress, error rate, and business reconciliation before reopening traffic.

## Lessons Learned

Within five business days, document the timeline, blast radius, evidence
retention, control gaps, owners, and dates for corrective actions.
