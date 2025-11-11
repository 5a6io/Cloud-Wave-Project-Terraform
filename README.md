# 🍀Cloud Wave Group Project - Olive Safety

This code was reconstructed based on the content of the Cloud Wave group project. 

Group Project: https://github.com/5a6io/OliveSafety.git

I haven't original code. So, it may be different from that.

It was written separately by modules and environments.

Currently, It's still in the process of writing.

## 🗂️Directory Structure

```bash
.
├── env
│   ├── dr-tokyo
│   │   ├── backend.tf
│   │   ├── main.tf
│   │   └── variables.tf
│   └── prod-seoul
│       ├── backend.tf
│       ├── main.tf
│       └── variables.tf
├── global
│   ├── providers.tf
│   └── remote_state.tf
├── modules
│   ├── compute
│   │   ├── ec2
│   │   └── eks-cluster
│   ├── data
│   │   ├── elasticache
│   │   └── rds
│   ├── messaging
│   │   └── sqs
│   ├── monitoring
│   │   └── cloudwatch
│   ├── network
│   │   ├── main.tf
│   │   ├── outputs.tf
│   │   └── variables.tf
│   └── security
│       ├── iam
│       └── security-group
└── stacks
    ├── 00_providers.tf
    ├── 01_security.tf
    ├── 02_network.tf
    ├── 03_compute.tf
    ├── 04_data.tf
    ├── 05_messaging.tf
    ├── 06_edge.tf
    └── 07_monitoring.tf
```
