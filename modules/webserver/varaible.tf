variable "SSH_CIDR_WEB_SERVER" {
    type = string
    default = "0.0.0.0/0"
}

variable "INSTANCE_TYPE" {
  default = ""
}

variable "AMI" {
  type = string
  default = ""
}


variable "AWS_REGION" {
    type        = string
    default     = "us-east-2"
}

variable "ENVIRONMENT" {
  description = "AWS VPC Environment Name"
  type        = string
  default     = "Development"
}

variable "public_key_value" {
  type = string
  default = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQD3GAjP+/aOqYTBlpGpnD6jbo60lVYUAByNZX7Zf3T9zQQ17YsNi4piTmquxdiz/Y1K3Bg1D/I5LL9kP7c9EQRmh2/1PywiJAp2kkndtuVkFEbS7fZBnL1svjPQC0n4Rkg8wS0EKFCTwvGGj8g9gJ3qZZp9AnDSM+R9lY3m46Mx1QUsUtk/i2Jrs9ur/w9tWukATlJW1HeuXjJ2AXdaJEM8S/w7IJtvWI0Dxbtp8cyJJ/V6eOcog8v4g9NhR38VcNK1qa9kPfbbH3WVycpYAf1/dWUOs6993XYsoG3yp9Vyljbd9leK4uMz4Gd8W9r49eWdRgb9F0myHdOni/+urkwCKx/gZLXZQnP9ep4QWCIt+lBRcj+Y6bfknwn+dryZGgGuZYLgfoiPPJGGgMrq/lqSO8wCPyjKe/QbdcgEmlJiNGdKTe+Hb2ZVLVZiizwJWa/r8mnfVIgm3jAXR4do1nWlY4jzHSH3ZOZerd4Aho7b74guNjFzXjA8Q5ku/ZOJvDSoXhcX+L4Fd+j4Ug8T50FE4YuAeIWuqX2WAqXm+ysLkIGqv58UTde4e1LjHzeC3/Kbwmds/lUzUQzjSWFjlNXHUsvs+Z+Q35iMaBzO5Vno3eUC0fOPWdssxdxoMYvZOw1kb9nyTkxkKC63Oais0XvJxrRIBiYUeJe7jl3RfBQVRQ==" 
}

variable "vpc_private_subnet1" {
  type        = string
  default     = ""
}

variable "vpc_private_subnet2" {
  type        = string
  default     = ""
}

variable "vpc_id" {
  type        = string
  default     = ""
}


variable "vpc_public_subnet1" {
  type        = string
  default     = ""
}

variable "vpc_public_subnet2" {
  type        = string
  default     = ""
}