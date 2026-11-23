$ErrorActionPreference = 'Stop'
$root = Split-Path -Parent $PSScriptRoot

if (Get-Command yamllint -ErrorAction SilentlyContinue) {
    yamllint -d '{extends: relaxed, rules: {line-length: disable}}' `
        (Join-Path $root 'k8s') `
        (Get-ChildItem (Join-Path $root 'helm') -Filter 'values-*.yaml').FullName
} else {
    Write-Warning 'yamllint is not installed; YAML lint was skipped.'
}

if (Get-Command kubeconform -ErrorAction SilentlyContinue) {
    Get-ChildItem (Join-Path $root 'k8s') -Recurse -Filter *.yaml |
        Where-Object {
            $_.FullName -notmatch '[\\/]falco-rules[\\/]' -and
            $_.FullName -notmatch '[\\/]dashboard-specs[\\/]'
        } | ForEach-Object {
            kubeconform -strict -ignore-missing-schemas -summary $_.FullName
        }
    if ($LASTEXITCODE -ne 0) {
        throw 'kubeconform validation failed.'
    }
} else {
    Write-Warning 'kubeconform is not installed; schema validation was skipped.'
}

if (Get-Command helm -ErrorAction SilentlyContinue) {
    helm lint (Join-Path $root 'helm') -f (Join-Path $root 'helm/values-prod.yaml')
} else {
    Write-Warning 'helm is not installed; chart lint was skipped.'
}

Write-Output 'Manifest validation completed. Install missing tools for full validation.'
