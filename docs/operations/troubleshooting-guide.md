# Troubleshooting guide

Start with `kubectl get events`, workload status, `kubectl logs`, readiness
probes, policy reports, and mesh telemetry. Developers have logs access but no
production exec or Secret access. Escalate an admission or network denial to
Platform Security with the namespace, image digest, and timestamp.
