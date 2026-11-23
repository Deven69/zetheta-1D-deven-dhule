# Developer onboarding

1. Request the environment-specific SSO group and select the approved context.
2. Build, scan, sign, and push the image with
   `Dockerfiles/sample-service.Dockerfile`.
3. Pin the immutable digest in the matching file under `helm/` and deploy.
4. Configure the service's Vault path and let Vault Agent inject a short-lived
   lease into the in-memory volume; never copy values into YAML or local files.
5. Use `kubectl get pods` and `kubectl logs` for diagnostics. Production has no
   developer exec access; escalate policy denials instead of weakening controls.

Troubleshooting starts with events, readiness probes, service endpoints,
network-policy evidence, and mesh telemetry. Escalate policy denials to the
platform team rather than weakening a control.
