# EC2
resource "aws_security_group" "sg_ec2" {
  
}

# EKS
resource "aws_security_group" "sg_eks" {
    name = "web sg"
}

# RDS
resource "aws_security_group" "sg_rds" {
    name = "${var.project_name}-sg-rds"
    vpc_id = "${aws_vpc.olivesafety-vpc-ap-01.id}"
    ingress = {
        from_port = 3306
        protocol = "tcp"
        to_port = 3306
    }
}

# ELB
resource "aws_security_group" "sg_external_alb" {
    name = "external alb sg"
}

resource "aws_security_group" "sg_internal_alb" {
    name = "internal alb sg"
}