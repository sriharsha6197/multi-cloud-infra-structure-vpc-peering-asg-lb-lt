resource "aws_vpc" "vpc" {
  cidr_block = var.vpc_cidr
  tags = {
    Name = "${var.env}-vpc"
  }
}
resource "aws_subnet" "public_subnet" {
  for_each = zipmap(range(length(var.public_subnets)),var.public_subnets)
  vpc_id     = aws_vpc.vpc.id
  cidr_block = each.value
  availability_zone = var.public_lb_azs[each.value]

  tags = {
    Name = "${var.env}-public-subnet-${each.key + 1}"
  }
}
resource "aws_subnet" "private_subnets" {
  for_each = zipmap(range(length(var.private_subnets)),var.private_subnets)
  vpc_id = aws_vpc.vpc.id
  cidr_block = each.value
  tags = {
    Name = "${var.env}-private_subnet-${each.key + 1}"
  }
}
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id
  tags = {
    Name = "${var.env}-igw"
  }
}
resource "aws_route_table" "public_route_tables" {
  for_each = zipmap(range(length(var.public_subnets)),var.public_subnets)
  vpc_id = aws_vpc.vpc.id
  route {
    cidr_block = var.public_rt_cidr_block
    gateway_id = aws_internet_gateway.igw.id
  }
  tags = {
    Name = "${var.env}-public_route_table-${each.key + 1}"
  }
}
resource "aws_route_table_association" "public_route_tables_association" {
  for_each = zipmap(range(length(var.public_subnets)),var.public_subnets)
  subnet_id = aws_subnet.public_subnet[each.key].id
  route_table_id = aws_route_table.public_route_tables[each.key].id
}
resource "aws_security_group" "security_group_instances" {
  name = "allow-all-sq"
  description = "allow-all-sg"
  vpc_id = aws_vpc.vpc.id
  tags = {
    Name = "${var.env}-sg"
  }
}
resource "aws_vpc_security_group_ingress_rule" "ingress_sg" {
  security_group_id = aws_security_group.security_group_instances.id
  cidr_ipv4 = var.public_rt_cidr_block
  for_each = zipmap(range(length(var.from_port)), var.from_port)
  from_port = each.value
  to_port = each.value
  ip_protocol = "tcp"
}
resource "aws_vpc_security_group_egress_rule" "egress_sg" {
  security_group_id = aws_security_group.security_group_instances.id
  cidr_ipv4 = var.public_rt_cidr_block
  ip_protocol = "-1"
}
resource "aws_eip" "eip" {
  for_each = zipmap(range(length(var.public_subnets)),var.public_subnets)
  domain = "vpc"
  tags = {
    Name = "${var.env}-eip-${each.key + 1}"
  }
}
resource "aws_nat_gateway" "nat_gw" {
  for_each = aws_eip.eip
  allocation_id = each.value.id
  subnet_id = aws_subnet.public_subnet[each.key].id
  tags = {
    Name = "${var.env}-nat-gw-${each.key + 1}"
  }
  depends_on = [ aws_internet_gateway.igw ]
}
resource "aws_route_table" "private_route_tables" {
  for_each = zipmap(range(length(var.private_subnets)),var.private_subnets)
  vpc_id = aws_vpc.vpc.id
  route {
    cidr_block = var.public_rt_cidr_block
    gateway_id = aws_nat_gateway.nat_gw[each.key].id
  }
  tags = {
    Name = "${var.env}-private-route-table-${each.key + 1}"
  }
}
resource "aws_route_table_association" "private_route_table_association" {
  for_each = zipmap(range(length(var.private_subnets)),var.private_subnets)
  subnet_id = aws_subnet.private_subnets[each.key].id
  route_table_id = aws_route_table.private_route_tables[each.key].id
}
resource "aws_vpc_peering_connection" "vpc_peering" {
  peer_owner_id = aws_vpc.vpc.owner_id
  peer_vpc_id = data.aws_vpc.default_vpc.id
  vpc_id = aws_vpc.vpc.id
  auto_accept = true
  tags = {
    Name = "VPC Peering connection between - ${aws_vpc.vpc.tags.Name} and ${data.aws_vpc.default_vpc.tags.Name}"
  }
}
resource "aws_route" "Peering_connection_private" {
  for_each = zipmap(range(length(var.private_subnets)),var.private_subnets)
  route_table_id = aws_route_table.private_route_tables[each.key].id
  destination_cidr_block = data.aws_vpc.default_vpc.cidr_block
  vpc_peering_connection_id = aws_vpc_peering_connection.vpc_peering.id
}
resource "aws_route" "Peering_connection_from_default_vpc" {
  route_table_id = data.aws_route_table.default.route_table_id
  destination_cidr_block = aws_vpc.vpc.cidr_block
  vpc_peering_connection_id = aws_vpc_peering_connection.vpc_peering.id 
}