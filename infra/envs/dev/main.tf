module "vpc" {
  source   = "../../modules/vpc"
  vpc_cidr = var.vpc_cidr
  vpc_name = "project-one"
}

module "subnets" {
  source              = "../../modules/subnets"
  vpc_id              = module.vpc.vpc_id
  vpc_name            = "project-one"
  public_subnet_cidr  = var.public_subnet_cidr
  private_subnet_cidr = var.private_subnet_cidr
  az                  = var.az
}

module "internet_gateway" {
  source   = "../../modules/internet-gateway"
  vpc_id   = module.vpc.vpc_id
  vpc_name = "project-one"
}

module "nat_gateway" {
  source          = "../../modules/nat-gateway"
  public_subnet_id = module.subnets.public_subnet_id
  vpc_name         = "project-one"
}

module "route_tables" {
  source           = "../../modules/route-tables"
  vpc_id           = module.vpc.vpc_id
  vpc_name         = "project-one"
  igw_id           = module.internet_gateway.igw_id
  nat_gateway_id   = module.nat_gateway.nat_gateway_id
  public_subnet_id = module.subnets.public_subnet_id
  private_subnet_id = module.subnets.private_subnet_id
}

module "security_groups" {
  source   = "../../modules/security-groups"
  vpc_id   = module.vpc.vpc_id
  vpc_name = "project-one"
}

