module "network" {
  source              = "../network"
  vpc_cidr_block      = "10.0.0.0/16"
  availability_zones  = ["us-east-1a", "us-east-1b"]
  public_subnet_names = ["public-subnet-1", "public-subnet-2"]
  private_subnet_names = ["private-subnet-1"]
  igw_name            = "my-igw"
  create_internet_gateway = false  # Set to false to avoid creating a duplicate Internet Gateway
}

module "security" {
  source = "../security"
  vpc_id = module.network.vpc_id
}

resource "aws_kms_key" "example" {
  description = "Example KMS Key"
}

resource "aws_db_subnet_group" "example" {
  name        = "my-db-subnet-group"
  description = "My DB Subnet Group"
  subnet_ids  = module.network.private_subnet_ids
}



resource "aws_db_instance" "default" {
  allocated_storage             = 10
  identifier                    = "rds-db"
  db_name                       = "mydb"
  engine                        = "mysql"
  engine_version                = "5.7"
  instance_class                = "db.t3.micro"
  manage_master_user_password   = true
  master_user_secret_kms_key_id = aws_kms_key.example.key_id
  username                      = "foo"
  parameter_group_name          = "default.mysql5.7"

  vpc_security_group_ids        = var.create_security_group ? [module.security.security_group_id] : []
  
  db_subnet_group_name          = aws_db_subnet_group.example.name
}

