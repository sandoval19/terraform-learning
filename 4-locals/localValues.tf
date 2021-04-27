# provider "aws" {
#     region = "us-west-2"
#     access_key = ""
#     secret_key = ""
# }

# locals {
#     common_tags = {
#         Owner = "Devops Team"
#         servide = "backend"
#     }
# }

# resource "aws_instance" "app-dev" {
#     ami = "ami-0e999cbd62129e3b1"
#     instance_type = "t2.micro"
#     tags = local.common_tags
# }

# resource "aws_instance" "db-dev" {
#     ami = "ami-0e999cbd62129e3b1"
#     instance_type = "t2.micro"
#     tags = local.common_tags
# }
