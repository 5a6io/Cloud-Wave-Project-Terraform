# output "sg_ec2" {
#   value = aws_security_group.sg_ec2.id
# }

output "sg_eks" {
  value = aws_security_group.sg_eks.id
}

output "sg_rds" {
  value = aws_security_group.sg_rds.id
}