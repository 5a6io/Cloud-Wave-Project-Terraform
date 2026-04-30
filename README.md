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
│   │   ├── backend.hcl.example
│   │   ├── backend.tf
│   │   ├── main.tf
│   │   ├── terraform.tfvars.example
│   │   └── variables.tf
│   └── prod-seoul
│       ├── backend.hcl.example
│       ├── backend.tf
│       ├── main.tf
│       ├── terraform.tfvars.example
│       └── variables.tf
├── global
│   ├── providers.tf
│   └── remote_state.tf
├── modules
│   ├── compute
│   │   ├── ec2
│   │   ├── eks-cluster
│   │   ├── eks-node-group
│   │   └── lambda
│   ├── data
│   │   ├── elasticache
│   │   ├── rds
│   │   └── s3
│   ├── edge
│   │   ├── cloudfront
│   │   ├── loadbalancer
│   │   └── route53
│   ├── messaging
│   │   ├── eventbridge
│   │   ├── sns
│   │   └── sqs
│   ├── monitoring
│   │   └── cloudwatch
│   ├── network
│   │   ├── igw-nat
│   │   ├── subnets
│   │   └── vpc
│   ├── security
│   │   ├── config
│   │   ├── detective
│   │   ├── guardduty
│   │   ├── iam
│   │   ├── inspector
│   │   ├── kms
│   │   ├── security-group
│   │   ├── security-hub
│   │   └── waf
│   └── web
│       ├── main.tf
│       ├── outputs.tf
│       └── variables.tf
└── stacks
    ├── 00-providers.tf
    ├── 01-network.tf
    ├── 02-security.tf
    ├── 03-compute.tf
    ├── 04-data.tf
    ├── 05-messaging.tf
    ├── 06-edge.tf
    ├── 07-monitoring.tf
    ├── 08-dr-tokyo.tf
    ├── 09-dr-route53-failover.tf
    ├── 99-outputs.tf
    ├── terraform.tfvars.example
    └── variables.tf
```
