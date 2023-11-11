provider "aws" {
  region = "us-east-1" # Change to your desired AWS region
}

module "network" {
  source              = "./module/network"
  vpc_cidr_block      = "10.0.0.0/16"
  availability_zones  = ["us-west-2a", "us-west-2b"]
}

module "instances" {
  source              = "./module/instances"
  vpc_id              = module.network.vpc_id
  public_subnet_ids   = module.network.public_subnet_ids
  private_subnet_ids  = module.network.private_subnet_ids
}

module "databases" {
  source              = "./module/databases"
  vpc_id              = module.network.vpc_id
  private_subnet_ids  = module.network.private_subnet_ids
}

module "security" {
  source              = "./module/security"
  vpc_id              = module.network.vpc_id
}
