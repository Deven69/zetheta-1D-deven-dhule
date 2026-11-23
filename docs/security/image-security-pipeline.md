# Image security pipeline

FinServ Digital builds a minimal non-root image, scans source and dependencies,
signs the immutable digest with Cosign, and promotes the same digest through
dev, staging, and prod. Kyverno enforces the digest and signature at admission.
