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