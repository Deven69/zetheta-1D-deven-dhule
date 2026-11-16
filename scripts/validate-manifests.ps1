$ErrorActionPreference = 'Stop'
$root = Split-Path -Parent $PSScriptRoot

if (Get-Command yamllint -ErrorAction SilentlyContinue) {
    yamllint (Join-Path $root 'namespaces'), (Join-Path $root 'rbac'),
        (Join-Path $root 'network-policies'), (Join-Path $root 'pod-security'),
        (Join-Path $root 'admission-control'), (Join-Path $root 'audit'),
        (Join-Path $root 'service-mesh'), (Join-Path $root 'monitoring')
} else {
    Write-Warning 'yamllint is not installed; YAML lint was skipped.'
}

if (Get-Command kubeconform -ErrorAction SilentlyContinue) {
    Get-ChildItem $root -Recurse -Filter *.yaml | ForEach-Object {
        kubeconform -strict -summary $_.FullName
    }
} else {
    Write-Warning 'kubeconform is not installed; schema validation was skipped.'
}

if (Get-Command helm -ErrorAction SilentlyContinue) {
    helm lint (Join-Path $root 'helm/finserv-service')
} else {
    Write-Warning 'helm is not installed; chart lint was skipped.'
}

Write-Output 'Manifest validation completed. Install missing tools for full validation.'
