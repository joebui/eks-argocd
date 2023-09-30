data "aws_caller_identity" "current" {}

# data "aws_vpc" "app" {
#   filter {
#     name   = "tag:Name"
#     values = [var.vpc_name]
#   }
# }

# data "aws_subnets" "public" {
#   filter {
#     name   = "vpc-id"
#     values = [data.aws_vpc.app.id]
#   }

#   tags = {
#     Name = var.public_subnet_name_prefix
#   }
# }
