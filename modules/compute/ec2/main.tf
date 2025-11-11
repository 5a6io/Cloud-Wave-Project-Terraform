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