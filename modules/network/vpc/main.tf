# VPC
resource "aws_vpc" "this" {
    cidr_block =  var.vpc_cidr #"10.0.1.0/24"
    enable_dns_support = true
    enable_dns_hostnames = false
    instance_tenancy = "default"
    tags = merge(var.common_tags, {
        Name = "${var.project_name}-vpc"
    })
}