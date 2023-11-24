# why default ones? well I am that lazy bro!!
data "aws_vpc" "default" {
    default = true
}

data "aws_subnets" "default" {
    filter {
        name   = "vpc-id"
        values = [ "${data.aws_vpc.default.id}" ]
    }
}