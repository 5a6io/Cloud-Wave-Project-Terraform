# 🍀Cloud Wave Group Project - Olive Safety

This code was reconstructed based on the content of the Cloud Wave group project. 

Group Project: https://github.com/5a6io/OliveSafety.git

I haven't original code. So, it may be different from that.

It was written separately by service.

## 🌟Terraform Code

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

### ⌨️vpc.tf
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
    availability_zone = "ap-northeast-2b"
    cidr_block = "10.0.1.96/27"
    vpc_id = "${aws_vpc.olivesafety_vpc.id}"
}

resource "aws_subnet" "olivesafety-sub-pri-03" {
    availability_zone = "ap-northeast-2c"
    cidr_block = "10.0.1.128/27"
    vpc_id = "${aws_vpc.olivesafety_vpc.id}"
}

resource "aws_subnet" "olivesafety-sub-pri-04" {
    availability_zone = "ap-northeast-2d"
    cidr_block = "10.0.1.160/27"
    vpc_id = "${aws_vpc.olivesafety_vpc.id}"
}

resource "aws_internet_gateway" "olivesafety-eks-igw" {
    vpc_id = aws_vpc.olivesafety-vpc-ap-01.id
}

resource "aws_internet_gateway_attachment" "olivesafety-eks-igw-attachment" {
    internet_gateway_id = aws_internet_gateway.olivesafety-eks-igw.id
    vpc_id = aws_vpc.olivesafety-vpc-ap-01.id
}

resource "aws_route_table" "olivesafety-rtb-pub-01" {
    vpc_id = "${aws_vpc.olivesafety-vpc-ap-01.id}"

    route {
        cidr_block = "10.0.1.0/27"
        gateway_id = aws_internet_gateway.olivesafety-eks-igw.id
    }
}

resource "aws_route" "olivesafety-pub-01-route" {
    route_table_id = aws_route_table.olivesafety-rtb-pub-01.id
    destination_cidr_block = "10.0.1.0/27"
}

resource "aws_route_table_association" "olivesafety-rtb-pub-01-association" {
    route_table_id = aws_route_table.olivesafety-rtb-pub-01.id
    subnet_id = aws_subnet.olivesafety-sub-pub-01.id
}

resource "aws_nat_gateway" "olivesafety-eks-nat-01" {
    subnet_id = aws_subnet.olivesafety-sub-pub-01.id
    allocation_id = ""
    depends_on = [ aws_internet_gateway.olivesafety-eks-igw.id ]
}

```

### ⌨️ec2.tf
```hcl
resource "aws_instance" "bastion" {
    ami = ""
    instance_type = "t3.micro"
    subnet_id = aws_subnet.olivesafety-sub-pub-01
    private_ip = aws_subnet.olivesafety-sub-pri-01
    key_name = ""
    vpc_security_group_ids = [aws_security_group.bastion_sg.id]

    tags = {
      name = "bastion"
    }
}

resource "aws_instance" "cicd" {

    tags = {
      name = "cicd"
    }
}

resource "aws_security_group" "bastion_sg" {
    description = "관리목적으로 제한된 사용자만 접근"
    name = "bastion sg"
    vpc_id = "${aws_vpc.olivesafety-vpc-ap-01.id}"
    
    ingress {
      cidr_blocks = ["0.0.0.0/0"]
      from_port = "22"
      protocol = "tcp"
      to_port = "22"
    }
}

resource "aws_security_group" "name" {
  
}
```

### ⌨️eks.tf
```hcl
resource "aws_security_group" "external_alb_sg" {
    name = "external alb sg"
}

resource "aws_security_group" "web_sg" {
    name = "web sg"
}

resource "aws_security_group" "internal_alb_sg" {
    name = "internal alb sg"
}

resource "aws_security_group" "was_sg" {
    name = "was sg"
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

resource "aws_lb" "web_lb" {
    name = ""
    internal = false
    load_balancer_type = "application"
    subnets = [  
      
    ]
    security_groups = [

    ]
    ip_address_type = "ipv4"
    access_logs {
      enabled = false
      bucket = ""
      prefix = ""
    }
    idle_timeout = "60"
    enable_deletion_protection = "false"
    enable_http2 = "true"
    enable_cross_zone_load_balancing = "true"
}

resource "aws_lb_listener" "web_lb" {
    load_balancer_arn = "arn:aws:elasticloadbalancing:ap-northeast-1::loadbalancer/app/"
    port = 80
    protocol = "HTTP"

    default_action {
      fixed_response {
        content_type = "text/plain"
        status_code = "404"
      }
      type = "fixed-response"
    }
}

resource "aws_lb_target_group" "instance" {
    health_check {
      interval = 30
      path = "/"
      port = "traffic-port"
      protocol = "HTTP"
      timeout = 5
      unhealthy_threshold = 2
      healthy_threshold = 5
      matcher = "200"
    }
    port = 80
    protocol = "HTTP"
    target_type = "instance"
    vpc_id = "${aws_vpc.olivesafety-vpc-ap-01.id}"
    name = "DR"
}

resource "aws_lb_target_group" "web_lb_tg" {
    health_check {
      interval = 15
      path = "/"
      port = "traffic-port"
      protocol = "HTTP"
      timeout = 5
      unhealthy_threshold = 2
      healthy_threshold = 2
      matcher = "200"
    }
    port = 8080
    protocol = "HTTP"
    target_type = "ip"
    vpc_id = "${aws_vpc.olivesafety-vpc-ap-01.id}"
    name = "web_lb"
}
```

### ⌨️rds.tf
```hcl
resource "aws_security_group" "db_sg" {
    name = "db sg"
    vpc_id = "${aws_vpc.olivesafety-vpc-ap-01.id}"
    ingress = {
        security_groups = []
        from_port = 3306
        protocol = "tcp"
        to_port = 3306
    }
}

resource "aws_rds_cluster" "primarydb" {
  database_name = "primary db"
  cluster_identifier = "olivesafety-aurora-mysql-secondary-cluster"
  db_cluster_parameter_group_name = "default.aurora-mysql8.0"
  db_subnet_group_name = ""
  engine = "aurora-mysql"
  port = 3306
  
}
```

