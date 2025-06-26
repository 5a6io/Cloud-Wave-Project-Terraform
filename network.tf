resource "aws_vpc" "olivesafety_vpc" {
    cidr_block = ""
    enable_dns_support = true
    enable_dns_hostnames = false
    instance_tenancy = "default"
}

resource "aws_subnet" "olivesafety_pubsub" {
    availability_zone = ""
    cidr_block = ""
    vpc_id = "${aws_vpc.olivesafety_vpc.id}"
    map_public_ip_on_launch = true
}