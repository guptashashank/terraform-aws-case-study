#Define Subnet Group for RDS Service
resource "aws_db_subnet_group" "poc-rds-subnet-group" {

    name          = "${var.ENVIRONMENT}-poc-db-snet"
    description   = "Allowed subnets for DB cluster instances"
    subnet_ids    = [
      "${var.vpc_private_subnet1}",
      "${var.vpc_private_subnet2}",
    ]
    tags = {
        Name         = "${var.ENVIRONMENT}_poc_db_subnet"
    }
}

#Define Security Groups for RDS Instances
resource "aws_security_group" "poc-rds-sg" {

  name = "${var.ENVIRONMENT}-poc-rds-sg"
  description = "Created for poc"
  vpc_id      = var.vpc_id

  ingress {
    from_port = 3306
    to_port = 3306
    protocol = "tcp"
    cidr_blocks = ["${var.POC_VPC_PUBLIC_SUBNET1_CIDR_BLOCK}","${var.POC_VPC_PUBLIC_SUBNET2_CIDR_BLOCK}"]

  }

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

    tags = {
    Name = "${var.ENVIRONMENT}-poc-rds-sg"
   }
}

resource "aws_db_instance" "poc-rds" {
  identifier = "${var.ENVIRONMENT}-poc-rds"
  allocated_storage = var.POC_RDS_ALLOCATED_STORAGE
  storage_type = "gp2"
  engine = var.POC_RDS_ENGINE
  skip_final_snapshot = true
  engine_version = var.POC_RDS_ENGINE_VERSION
  instance_class = var.DB_INSTANCE_CLASS
  backup_retention_period = var.BACKUP_RETENTION_PERIOD
  publicly_accessible = var.PUBLICLY_ACCESSIBLE
  username = var.POC_RDS_USERNAME
  password = var.POC_RDS_PASSWORD
  vpc_security_group_ids = [aws_security_group.poc-rds-sg.id]
  db_subnet_group_name = aws_db_subnet_group.poc-rds-subnet-group.name
  multi_az = "false"
}

output "rds_prod_endpoint" {
  value = aws_db_instance.poc-rds.endpoint
}