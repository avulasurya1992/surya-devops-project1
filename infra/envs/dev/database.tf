module "rds" {
  source             = "../../modules/rds"
  private_subnet_ids = [module.subnets.private_subnet_id]
  app_sg_id          = module.security_groups.app_sg_id
  vpc_id             = module.project_one_vpc.vpc_id
  project_name       = "project-one"
}

