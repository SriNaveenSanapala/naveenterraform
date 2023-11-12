module "network" {
  source                  = "./module/network"
  vpc_cidr_block          = "10.0.0.0/16"
  availability_zones      = ["us-east-1a", "us-east-1b"]
  vpc_name                = "my-vpc1"
  public_subnet_names     = ["public-subnet-1", "public-subnet-2"]
  private_subnet_names    = ["private-subnet-1"]
  igw_name                = "my-igw"
  public_route_table_name = "public-route-table"
  private_route_table_name = "private-route-table"
  create_internet_gateway = false  # Set to false to avoid creating a duplicate Internet Gateway
}

module "databases" {
  source             = "./module/databases"
  private_subnet_ids = module.network.private_subnet_ids
  public_subnet_ids  = module.network.public_subnet_ids  # Include this line
  depends_on         = [module.network]
}

module "security" {
  source = "./module/security"
  vpc_id = module.network.vpc_id
  create_security_group = false 
}

module "instances" {
  source             = "./module/instances"
  vpc_id             = module.network.vpc_id
  public_subnet_ids  = module.network.public_subnet_ids
  private_subnet_ids = module.network.private_subnet_ids
}
