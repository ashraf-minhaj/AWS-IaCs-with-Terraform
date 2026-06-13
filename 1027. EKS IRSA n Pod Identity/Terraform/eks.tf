# resource "aws_eks_cluster" "example" {
#   name     = "floci-local-eks"
#   role_arn = aws_iam_role.eks_role.arn

#   vpc_config {
#     subnet_ids = [
#       aws_subnet.subnet_a.id,
#       aws_subnet.subnet_b.id
#     ]
#   }
# }

# # FIXED: Correct Service principal name
# resource "aws_iam_role" "eks_role" {
#   name = "floci-eks-cluster-role"

#   assume_role_policy = jsonencode({
#     Version = "2012-10-17"
#     Statement = [
#       {
#         Action = "sts:AssumeRole"
#         Effect = "Allow"
#         Principal = {
#           Service = "eks.amazonaws.com"
#         }
#       }
#     ]
#   })
# }