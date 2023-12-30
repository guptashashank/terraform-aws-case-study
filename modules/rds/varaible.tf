variable "AWS_REGION" {
    type        = string
    default     = "us-east-2"
}

variable "BACKUP_RETENTION_PERIOD" {
    default = "0"
}

variable "PUBLICLY_ACCESSIBLE" {
    default = "false"
}

variable "POC_RDS_USERNAME" {
    default = "testdb"
}

variable "POC_RDS_PASSWORD" {
    default = "testdb12345"
}

variable "POC_RDS_ALLOCATED_STORAGE" {
    type = string
    default = "20"
}

variable "POC_RDS_ENGINE" {
    type = string
    default = "mysql"
}

variable "POC_RDS_ENGINE_VERSION" {
    type = string
    default = "8.0.28"
}

variable "DB_INSTANCE_CLASS" {
    type = string
    default = "db.t2.micro"
}

variable "ENVIRONMENT" {
  type        = string
  default     = "Development"
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

variable "POC_VPC_PUBLIC_SUBNET1_CIDR_BLOCK" {
  type        = string
  default     = "10.0.101.0/24"
}

variable "POC_VPC_PUBLIC_SUBNET2_CIDR_BLOCK" {
  type        = string
  default     = "10.0.102.0/24"
}