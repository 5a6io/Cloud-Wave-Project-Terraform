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