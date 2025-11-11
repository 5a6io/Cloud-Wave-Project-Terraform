resource "aws_subnet" "public" {
  for_each = { for idx, cidr in var.pub_sub_cidr : idx => { cidr = cidr, az = var.availability_zones[idx]}}
  vpc_id = var.vpc_id
  cidr_block = each.value.cidr
  availability_zone = each.value.az
  map_public_ip_on_launch = true
  tags = merge(var.common_tags, {
    Name = "${var.project_name}-pub-sub-${each.key + 1}"
  })
}

resource "aws_subnet" "private" {
  for_each = { for idx, cidr in var.pri_sub_cidr : idx => {cidr = cidr, az = var.availability_zones[idx]}}
  vpc_id = var.vpc_id
  cidr_block = each.value.cidr
  availability_zone = each.value.az
  tags = merge(var.common_tags, {
    Name = "${var.project_name}-pri-sub-${each.key + 1}"
  })
}