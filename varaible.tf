
variable "ENVIRONMENT" {
  type    = string
  default = "development"
}

variable "AMI" {
  type = string
  default = "ami-05fb0b8c1424f266b"
}

variable "AWS_REGION" {
  default = "us-east-2"
}

variable "INSTANCE_TYPE" {
  default = "t2.micro"
}