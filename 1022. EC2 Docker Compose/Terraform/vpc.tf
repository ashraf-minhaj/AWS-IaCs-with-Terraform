# use default ones for testing only
data "aws_vpc" "vpc" {
  default = true
}

data "aws_subnets" "subnet" {
  filter {
    name   = "vpc-id"
    values = ["${data.aws_vpc.vpc.id}"]
  }
}

# # Define the VPC data source
# data "aws_vpc" "vpc" {
#   id = var.vpc_id
# }

# resource "aws_subnet" "subnet_pub1" {
#   vpc_id                  = data.aws_vpc.vpc.id
#   cidr_block              = var.subnet_cidr_1a
#   availability_zone       = "${var.aws_region}a"
#   map_public_ip_on_launch = true
#   tags = {
#     Name = "${var.component_prefix}-${var.component_name}-pub1a-${var.component_postfix}"
#     app  = "${var.component_prefix}"
#     env  = "${var.component_postfix}"
#   }
# }

# resource "aws_subnet" "subnet_pub2" {
#   vpc_id                  = data.aws_vpc.vpc.id
#   cidr_block              = var.subnet_cidr_1b
#   availability_zone       = "${var.aws_region}b"
#   map_public_ip_on_launch = true
#   tags = {
#     Name = "${var.component_prefix}-${var.component_name}-pub1b-${var.component_postfix}"
#     app  = "${var.component_prefix}"
#     env  = "${var.component_postfix}"
#   }
# }

# data "aws_internet_gateway" "vpc_int_gw" {
#   internet_gateway_id = var.internet_gateway
# }

# resource "aws_route_table" "route_table" {
#   vpc_id = data.aws_vpc.vpc.id
#   route {
#     cidr_block = "0.0.0.0/0" # all IPs
#     gateway_id = data.aws_internet_gateway.vpc_int_gw.id
#   }
#   tags = {
#     app  = "${var.component_prefix}"
#     Name = "${var.component_prefix}-${var.component_name}-rourtetable-${var.component_postfix}"
#     env  = "${var.component_postfix}"
#   }
# }

# # routing association between routetable and subnets
# resource "aws_route_table_association" "subnet_1a" {
#   subnet_id      = aws_subnet.subnet_pub1.id
#   route_table_id = aws_route_table.route_table.id
# }

# resource "aws_route_table_association" "subnet_1b" {
#   subnet_id      = aws_subnet.subnet_pub2.id
#   route_table_id = aws_route_table.route_table.id
# }
