provider "aws" {
    region = "us-west-2"
    access_key = ""
    secret_key = ""
}

resource "aws_instance" "myec2" {
    ami = "ami-0e999cbd62129e3b1"
    instance_type = var.instancetype
}