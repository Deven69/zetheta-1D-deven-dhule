# Network flow specification

Every application namespace starts with deny-all ingress and egress. DNS to
CoreDNS, ingress to API Gateway, monitoring scrapes, Vault Agent traffic, and
the dependency edges below are the only permitted flows.

| Source | Destination | Port |
|---|---|---|
| api-gateway | payment-gateway, user-management, customer-support | 8443 |
| payment-gateway | transaction-processor, fraud-detection, notification | 8443 |
| transaction-processor | settlement, fraud-detection | 8443 |
| settlement | audit-log-aggregator | 8443 |
| refund-service | transaction-processor, notification | 8443 |
| recurring-payments | payment-gateway, transaction-processor | 8443 |
| risk services | declared risk dependencies | 8443 |
| customer services | declared customer dependencies | 8443 |
| report-generator | compliance-reporting, settlement | 8443 |
| health-monitor | all services | 9090 |
