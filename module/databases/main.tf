module "network" {
  source = "../network"
}

resource "aws_kms_key" "example" {
  description = "Example KMS Key"
}

resource "aws_db_subnet_group" "example" {
  name        = "my-db-subnet-group"
  description = "My DB Subnet Group"
  subnet_ids  = [
    module.network.aws_subnet.private[0].id,  # Make sure this subnet is in one AZ
    # Add more subnets if needed
  ]
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

  db_subnet_group_name          = aws_db_subnet_group.example.name
}
