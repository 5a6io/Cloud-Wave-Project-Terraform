# EC2
# resource "aws_security_group" "sg_ec2" {
#     name = "${var.project_name}-sg-ec2"
#     vpc_id = var.vpc_id
#     tags = merge(var.common_tags, {
#         name = "${var.project_name}-sg-ec2"
#     })
# }

# resource "aws_vpc_security_group_ingress_rule" "ec2_ingress" {
#     security_group_id = aws_security_group.sg_ec2
#     from_port = 
#     ip_protocol = 
#     to_port = 
#     tags = merge(var.common_tags, {
#         Name = "${var.project_name}-ec2-ingress"
#     })
# }

# EKS
resource "aws_security_group" "sg_eks" {
    name = "${var.project_name}-sg-eks"
    vpc_id = var.vpc_id

    tags = merge(var.common_tags, {
        name = "${var.project_name}-sg-eks"
    })
}

resource "aws_vpc_security_group_ingress_rule" "eks_ingress" {
    security_group_id = aws_security_group.sg_eks.id
    from_port = 443
    ip_protocol = "tcp"
    to_port = 80
    tags = merge(var.common_tags, {
        Name = "${var.project_name}-eks-ingress"
    })
}

# RDS
resource "aws_security_group" "sg_rds" {
    name = "${var.project_name}-sg-rds"
    vpc_id = var.vpc_id
    tags = merge(var.common_tags, {
        Name = "${var.project_name}-sg-rds"
    })
}

resource "aws_vpc_security_group_ingress_rule" "rds_ingress" {
    count = length(var.cidr)
    security_group_id = aws_security_group.sg_rds.id
    cidr_ipv4 = var.cidr[count.index]
    from_port = 3306
    ip_protocol = "tcp"
    to_port = 3306
    tags = merge(var.common_tags, {
    Name = "${var.project_name}-rds-ingress"
  })
}

# # ELB
# resource "aws_security_group" "sg_external_alb" {
#     name = "${var.project_name}-sg-external-alb"
#     vpc_id = var.vpc_id
#     tags = merge(var.common_tags, {
#         Name = "${var.project_name}-sg-external-alb"
#     })
# }

# resource "aws_vpc_security_group_ingress_rule" "external_alb_rule" {
#   security_group_id = aws_security_group.sg_external_alb.id
#   from_port = 443
#   ip_protocol = "tcp"
#   to_port = 80
#   tags = merge(var.common_tags, {
#     Name = "${var.project_name}-external-alb-ingress"
#   })
# }

# resource "aws_security_group" "sg_internal_alb" {
#     name = "${var.project_name}-sg-internal-alb"
#     vpc_id = var.vpc_id
#     tags = merge(var.common_tags, {
#         Name = "${var.project_name}-sg-internal-alb"
#     })
# }

# #
# resource "aws_vpc_security_group_ingress_rule" "internal_alb_rule" {
#   security_group_id = aws_security_group.sg_external_alb.id
#   from_port = 80
#   ip_protocol = "tcp"
#   to_port = 80
#   tags = merge(var.common_tags, {
#     Name = "${var.project_name}-external-alb-ingress"
#   })
# }