module "network" {
  source                  = "./module/network"
  vpc_cidr_block          = "10.0.0.0/16"
  availability_zones      = ["us-east-1a", "us-east-1b"]
  vpc_name                = "my-vpc1"
  public_subnet_names     = ["public-subnet-1"]
  private_subnet_names    = ["private-subnet-1"]
  igw_name                = "my-igw"
  public_route_table_name = "public-route-table"
  private_route_table_name = "private-route-table"
}

module "instances" {
  source             = "./module/instances"
  vpc_id             = module.network.vpc_id
  public_subnet_ids  = module.network.public_subnet_ids
  private_subnet_ids = module.network.private_subnet_ids
 # security_group_id  = module.security.aws_security_group.example.id
}

module "databases" {
  source             = "./module/databases"
  private_subnet_ids = module.network.private_subnet_ids
  security_group_id  = module.security.aws_security_group.example.id
}

module "security" {
  source = "./module/security"
  vpc_id = module.network.vpc_id
}
