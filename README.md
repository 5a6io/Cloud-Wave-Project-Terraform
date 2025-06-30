# 🍀Cloud Wave Group Project - Olive Safety

This code was reconstructed based on the content of the Cloud Wave group project. 

Group Project: https://github.com/5a6io/OliveSafety.git

I haven't original code. So, it may be different from that.

I wrote the code by service.

## 🌟Terraform Code

### ⌨️ec2.tf
```hcl
resource "aws_security_group" "Bastion_SG" {
    description = "관리목적으로 제한된 사용자만 접근"
    name = "Bastion SG"
    vpc_id = "${aws_vpc.olivesafety-vpc-ap-01.id}"
    ingress {
      cidr_blocks = ""
      from_port = "22"
      protocol = "ssh"
      to_port = ""
    }
}
```

### ⌨️eks.tf
```hcl
resource "aws_security_group" "External_ALB_SG" {
    name = "External ALB SG"
}

resource "aws_security_group" "WEB_SG" {
    name = "WEB_SG"
}

resource "aws_security_group" "INTERNAL_ALB_SG" {
    name = "INTERNAL ALB SG"
}

resource "aws_security_group" "WAS_SG" {
    name = "WAS SG"
}

resource "aws_security_group" "DB_SG" {
    name = "DB SG"
}

resource "aws_eks_cluster" "olivesafety_cluster" {
    name = "olivesafety"

    access_config {
      authentication_mode = "API"
    }

    role_arn = ""
    version = "1.31"

    vpc_config {
      subnet_ids = [ 
        aws_subnet.olivesafety-sub-pub-01.id,
        aws_subnet.olivesafety-sub-pub-02.id,
        aws_subnet.olivesafety-sub-pri-01.id,
        aws_subnet.olivesafety-sub-pri-02.id,
        aws_subnet.olivesafety-sub-pri-03.id,
        aws_subnet.olivesafety-sub-pri-04.id
       ]
    }
}

resource "aws_eks_node_group" "app" {
    cluster_name = aws_eks_cluster.olivesafety_cluster.name
    node_group_name = "app"
    instance_types = "m5.large"
    node_role_arn = ""

    subnet_ids = [ 
      aws_subnet.olivesafety-sub-pri-01.id,
      aws_subnet.olivesafety-sub-pri-02.id,
      aws_subnet.olivesafety-sub-pri-03.id,
      aws_subnet.olivesafety-sub-pri-04.id
     ]

     scaling_config {
       desired_size = 2
       min_size = 2
       max_size = 2
     }

     update_config {
       max_unavailable = 1
     }

     depends_on = [ 

      ]
}

resource "aws_eks_node_group" "web" {
    cluster_name = aws_eks_cluster.olivesafety_cluster.name
    node_group_name = "web"
    instance_types = "t3.medium"
    node_role_arn = ""

    scaling_config {
      desired_size = 2
      min_size = 2
      max_size = 2
    }

    subnet_ids = [
      aws_subnet.olivesafety-sub-pri-01.id,
      aws_subnet.olivesafety-sub-pri-02.id,
      aws_subnet.olivesafety-sub-pri-03.id,
      aws_subnet.olivesafety-sub-pri-04.id
    ]

    update_config {
       max_unavailable = 1
     }
    
}
```

### ⌨️main.tf
```hcl
terraform {
  required_providers {
    aws = {
        source = "hashicorp/aws"
        version = "~> 3.0"
    }
  }

  required_version = ">= 1.2.0"
}
provider "aws" {
    region = "ap-northeast-2"
}
```

### ⌨️network.tf
```hcl
resource "aws_vpc" "olivesafety-vpc-ap-01" {
    cidr_block = "10.0.1.0/24"
    enable_dns_support = true
    enable_dns_hostnames = false
    instance_tenancy = "default"
}

resource "aws_subnet" "olivesafety-sub-pub-01" {
    availability_zone = "ap-northeast-2a"
    cidr_block = "10.0.1.0/27"
    vpc_id = "${aws_vpc.olivesafety_vpc.id}"
    map_public_ip_on_launch = true
}

resource "aws_subnet" "olivesafety-sub-pub-02" {
    availability_zone = "ap-northeast-2c"
    cidr_block = "10.0.1.32/27"
    vpc_id = "${aws_vpc.olivesafety_vpc.id}"
}

resource "aws_subnet" "olivesafety-sub-pri-01" {
    availability_zone = "ap-northeast-2a"
    cidr_block = "10.0.1.64/27"
    vpc_id = "${aws_vpc.olivesafety_vpc.id}"
}

resource "aws_subnet" "olivesafety-sub-pri-02" {
    availability_zone = "ap-northeast-2a"
    cidr_block = "10.0.1.96/27"
    vpc_id = "${aws_vpc.olivesafety_vpc.id}"
}

resource "aws_subnet" "olivesafety-sub-pri-03" {
    availability_zone = "ap-northeast-2a"
    cidr_block = "10.0.1.128/27"
    vpc_id = "${aws_vpc.olivesafety_vpc.id}"
}

resource "aws_subnet" "olivesafety-sub-pri-04" {
    availability_zone = "ap-northeast-2a"
    cidr_block = "10.0.1.160/27"
    vpc_id = "${aws_vpc.olivesafety_vpc.id}"
}

resource "aws_route_table" "olivesafety-rtb-pub" {
    vpc_id = "${aws_vpc.olivesafety-vpc-ap-01.id}"
}

resource "aws_route" "name" {
  
}

resource "aws_route_table_association" "name" {
  
}

resource "aws_nat_gateway" "name" {
  
}
```

### ⌨️variables.tf
```hcl

```

