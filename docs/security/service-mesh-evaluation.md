# Service mesh evaluation

Istio is selected for this design because it provides mature strict mTLS,
authorization policies, telemetry, and canary routing through the Kubernetes
Gateway and VirtualService APIs. Linkerd remains a lower-complexity option for
teams prioritizing a smaller control plane over advanced traffic policy.

Production must set `PeerAuthentication` to `STRICT` after sidecar injection
coverage is verified.
