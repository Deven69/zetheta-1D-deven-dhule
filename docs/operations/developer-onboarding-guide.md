# Developer onboarding

1. Request membership in the environment-specific identity-provider group.
2. Authenticate with the approved SSO and select the assigned context.
3. Build an image with the secure Dockerfile, scan it, sign it with Cosign, and
   push it to the approved registry.
4. Pin the image digest in the environment values file and deploy with Helm.
5. Use `kubectl get pods` and `kubectl logs` for read-only diagnostics. Never
   copy secrets into manifests or use `kubectl exec` in production.
6. Configuration belongs in Vault paths owned by the service domain.

Troubleshooting starts with events, readiness probes, service endpoints,
network-policy evidence, and mesh telemetry. Escalate policy denials to the
platform team rather than weakening a control.
