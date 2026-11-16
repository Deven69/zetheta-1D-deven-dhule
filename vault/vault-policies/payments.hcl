path "secret/data/payments/*" {
  capabilities = ["read"]
}

path "secret/metadata/payments/*" {
  capabilities = ["read", "list"]
}
