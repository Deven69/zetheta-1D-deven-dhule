#!/usr/bin/env bash
set -euo pipefail

repo_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
yamllint -d '{extends: relaxed, rules: {line-length: disable}}' \
  "$repo_root/k8s" "$repo_root"/helm/values-*.yaml

mapfile -d '' manifests < <(
  find "$repo_root/k8s" -name '*.yaml' \
    ! -path '*/falco-rules/*' \
    ! -path '*/dashboard-specs/*' -print0
)
kubeconform -strict -ignore-missing-schemas -summary "${manifests[@]}"
helm lint "$repo_root/helm" -f "$repo_root/helm/values-prod.yaml"
