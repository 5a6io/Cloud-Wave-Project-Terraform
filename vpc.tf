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
