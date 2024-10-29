resource "aws_vpc" "vpc" {
  cidr_block           = var.vpc_cidr
  instance_tenancy     = "default"
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    app  = "${var.component_prefix}"
    env  = "${var.component_postfix}"
    Name = local.vpc_name
  }
}

resource "aws_internet_gateway" "vpc_int_gw" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    app  = "${var.component_prefix}"
    env  = "${var.component_postfix}"
    Name = local.igw_name
  }
}

# public subnets
resource "aws_subnet" "public_subnets" {
  count                   = length(var.public_subnet_cidr_blocks)
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = var.public_subnet_cidr_blocks[count.index]
  availability_zone       = element(var.availability_zones, count.index)
  map_public_ip_on_launch = true

  tags = {
    app  = "${var.component_prefix}"
    env  = "${var.component_postfix}"
    Name = "${var.component_prefix}-pubsub-${count.index}-${var.component_postfix}"
  }
}

# public subnets
resource "aws_subnet" "private_subnets" {
  count                   = length(var.private_subnet_cidr_blocks)
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = var.private_subnet_cidr_blocks[count.index]
  availability_zone       = element(var.availability_zones, count.index)
  map_public_ip_on_launch = false

  tags = {
    app  = "${var.component_prefix}"
    env  = "${var.component_postfix}"
    Name = "${var.component_prefix}-prvsub-${count.index}-${var.component_postfix}"
  }
}

resource "aws_eip" "nat_eip" {
  count = length(var.private_subnet_cidr_blocks)
  vpc   = true
}

resource "aws_nat_gateway" "nat_gateway" {
  depends_on    = [aws_internet_gateway.vpc_int_gw]
  count         = length(var.private_subnet_cidr_blocks)
  allocation_id = aws_eip.nat_eip[count.index].id
  subnet_id     = aws_subnet.public_subnets[count.index].id

  tags = {
    Name = "${var.component_prefix}-nat-${count.index}-${var.component_postfix}"
  }
}

resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.vpc.id
  route {
    cidr_block = "0.0.0.0/0" # all IPs
    gateway_id = aws_internet_gateway.vpc_int_gw.id
  }

  tags = {
    app  = "${var.component_prefix}"
    env  = "${var.component_postfix}"
    Name = local.pub_rt_name
  }
}

resource "aws_route_table" "private_route_table" {
  depends_on = [aws_nat_gateway.nat_gateway]
  count      = length(var.private_subnet_cidr_blocks) # > 0 ? 1 : 0 # create only if there is more than 0 private subnets
  vpc_id     = aws_vpc.vpc.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat_gateway[count.index].id
  }

  tags = {
    app  = "${var.component_prefix}"
    env  = "${var.component_postfix}"
    Name = "${var.component_prefix}-prvrt-${count.index}-${var.component_postfix}"
  }
}

# routing association between routetable and subnets
resource "aws_route_table_association" "public_subnets_association" {
  count          = length(var.public_subnet_cidr_blocks)
  subnet_id      = aws_subnet.public_subnets[count.index].id
  route_table_id = aws_route_table.public_route_table.id
}

# Routing association between private route table and private subnets
resource "aws_route_table_association" "private_subnets_association" {
  count          = length(var.private_subnet_cidr_blocks)
  subnet_id      = aws_subnet.private_subnets[count.index].id
  route_table_id = aws_route_table.private_route_table[count.index].id
}