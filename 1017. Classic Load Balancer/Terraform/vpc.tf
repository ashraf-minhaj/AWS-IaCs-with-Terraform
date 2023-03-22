resource "aws_vpc" "phitron_vpc" {
    cidr_block              = "10.0.0.0/16"
    instance_tenancy        = "default"
    enable_dns_support      = true
    enable_dns_hostnames    = true
    # enable_classiclink      = false
    tags = {
        name                = "${local.component}-vpc-${var.component_postfix}"
    }
}

# public subnets
resource "aws_subnet" "phitron_vpc_pub1" {
    vpc_id                  = aws_vpc.phitron_vpc.id
    cidr_block              = "10.0.2.0/24"
    map_public_ip_on_launch = true
    availability_zone       = "${var.aws_region}a"
    tags = {
        name                = "${local.component}-vpc-pub1-${var.component_postfix}"
    }
}

resource "aws_subnet" "phitron_vpc_pub2" {
    vpc_id                  = aws_vpc.phitron_vpc.id
    cidr_block              = "10.0.3.0/24"
    map_public_ip_on_launch = true
    availability_zone       = "${var.aws_region}b"
    tags = {
        name                = "${local.component}-vpc-pub2-${var.component_postfix}"
    }
}

resource "aws_internet_gateway" "phitron_vpc_gw" {
    vpc_id                  = aws_vpc.phitron_vpc.id
    tags = {
        name                = "${local.component}-internet-gw-${var.component_postfix}"
    }
}

resource "aws_route_table" "phitron_route_table" {
    vpc_id                  = aws_vpc.phitron_vpc.id
    route {
        cidr_block          = "0.0.0.0/0"                  # all IPs
        gateway_id          = aws_internet_gateway.phitron_vpc_gw.id
    }
    tags = {
        name                = "${local.component}-vpc-rtable-${var.component_postfix}"
    }
}

# routing association between routetable and subnets
resource "aws_route_table_association" "subnet_1a" {
    subnet_id               = aws_subnet.phitron_vpc_pub1.id
    route_table_id          = aws_route_table.phitron_route_table.id
}

resource "aws_route_table_association" "subnet_1b" {
    subnet_id               = aws_subnet.phitron_vpc_pub2.id
    route_table_id          = aws_route_table.phitron_route_table.id
}