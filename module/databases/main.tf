module "network" {
  source = "../network"

  vpc_cidr_block          = "10.0.0.0/16"
  availability_zones      = ["us-east-1a", "us-east-1b"]
  // other configurations...
}

module "security" {
  source = "../security"
  vpc_id = module.network.vpc_id
}

resource "aws_kms_key" "example" {
  description = "Example KMS Key"
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
  
  vpc_security_group_ids        = [module.security.security_group_id]

  subnet_ids                    = [module.network.public_subnet_ids[0]]
}
