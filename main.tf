#Define Provider
provider "aws" {
  region = var.AWS_REGION
}

module "poc-vpc" {
  source = "./modules/vpc"

  ENVIRONMENT = var.ENVIRONMENT
  AWS_REGION  = var.AWS_REGION
}

module "poc-rds" {
  source      = "./modules/rds"

    ENVIRONMENT = var.ENVIRONMENT
    AWS_REGION  = var.AWS_REGION
    vpc_id = module.poc-vpc.my_vpc_id
    vpc_private_subnet1 = module.poc-vpc.private_subnet1_id
    vpc_private_subnet2 = module.poc-vpc.private_subnet2_id
    depends_on = [module.poc-vpc]
}
module "poc-webserver" {
  source = "./modules/webserver"

    ENVIRONMENT         = var.ENVIRONMENT
    AWS_REGION          = var.AWS_REGION
    AMI                 = var.AMI
    INSTANCE_TYPE       = var.INSTANCE_TYPE
    vpc_private_subnet1 = module.poc-vpc.private_subnet1_id
    vpc_private_subnet2 = module.poc-vpc.private_subnet2_id
    vpc_id              = module.poc-vpc.my_vpc_id
    vpc_public_subnet1  = module.poc-vpc.public_subnet1_id
    vpc_public_subnet2  = module.poc-vpc.public_subnet2_id
    depends_on = [module.poc-vpc]
}

output "load_balancer_output" {
  description = "Load Balancer"
  value       = module.poc-webserver.load_balancer_output
}