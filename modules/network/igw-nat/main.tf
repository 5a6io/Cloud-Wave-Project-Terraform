# Internet Gateway
resource "aws_internet_gateway" "this" {
    vpc_id = var.vpc_id
    tags = merge(var.common_tags, {
        Name = "${var.project_name}-igw"
    })
}

# Public Route Table + Internet Gateway
resource "aws_route_table" "rtb_pub" {
    vpc_id = var.vpc_id

    tags = merge(var.common_tags, {
        Name = "${var.project_name}-route-pub-${each.key + 1}"
    })
}

resource "aws_route" "rt_pub_route" {
    route_table_id = aws_route_table.rtb-pub-01
    destination_cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
}

resource "aws_route_table_association" "pub_association" {
    count = length(var.pub_sub_ids)
    route_table_id = aws_route_table.rtb_pub.id
    subnet_id = each.value.id[count.index]
}

# NAT
resource "aws_eip" "this" {
  count = var.multi_nat ? lenght(var.pub_sub_ids) : 1
  domain = "vpc"
  tags = merge(var.common_tags, {
    Name = "${var.project_name}-eip-nat-${count.index + 1}"
  })
}

resource "aws_nat_gateway" "this" {
    count = var.multi_nat ? length(var.pub_sub_ids) : 1
    subnet_id = var.pub_sub_ids[count.index]
    allocation_id = aws_eip.this[count.index].id
    tags = merge(var.common_tags, {
        Name = "${var.project_name}-nat-${count.index + 1}"
    })

    depends_on = [ aws_internet_gateway.this ]
}

# Private Route Table + NAT
resource "aws_route_table" "rtb_pri" {
    count = var.multi_nat ? length(var.pri_sub_ids) : 1
    vpc_id = var.vpc_id
    tags = merge(var.common_tags, {
        Name = "${var.project_name}-rtb-pri-${count.index + 1}"
    })
}

resource "aws_route" "rt_pri_rtb" {
  count = var.multi_nat ? length(var.pri_sub_ids) : 1
  route_table_id = aws_route_table.rtb_pri[count.index].id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id = aws_nat_gateway.this[var.multi_nat ? count.index : 0].id
}

resource "aws_route_table_association" "pri_association" {
  count = length(var.pri_sub_ids)
  route_table_id = aws_route_table.rtb_pri[var.multi_nat ? count.index : 0].id
  subnet_id = var.pri_sub_ids[count.index]
}