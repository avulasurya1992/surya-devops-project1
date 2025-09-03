# ============================================================================
# envs/dev/compute.tf (Wires EC2 LT -> ASG -> ALB using Phase 2 outputs)
# ============================================================================
# Assumes Phase 2 modules already exist in this env (vpc, subnets, security_groups)
# Using outputs from those modules:
# - module.subnets.public_subnet_id
# - module.subnets.private_subnet_id
# - module.vpc.vpc_id
# - module.security_groups.alb_sg_id
# - module.security_groups.app_sg_id


module "compute_ec2" {
  source        = "../../modules/ec2"
  app_sg_id     = module.security_groups.app_sg_id
  instance_type = "t3.micro"
  key_name      = null # or set to "project-one-key" if you created it
  app_port      = 8080
  tags = {
    Project = "project-one"
    Env     = "dev"
  }
}


module "compute_asg" {
  source             = "../../modules/autoscaling"
  vpc_id             = module.vpc.vpc_id
  private_subnet_id  = module.subnets.private_subnet_id
  launch_template_id = module.compute_ec2.launch_template_id


  app_port          = 8080
  health_check_path = "/"
  desired_capacity  = 1
  min_size          = 1
  max_size          = 2


  tags = {
    Project = "project-one"
    Env     = "dev"
  }
}


module "compute_alb" {
  source = "../../modules/alb"

  vpc_id             = module.vpc.vpc_id
  public_subnet_id   = module.subnets.public_subnet_id
  alb_sg_id          = module.security_groups.alb_sg_id
  public_subnet_id_2 = module.subnets.public_subnet_id_2
  target_group_arn   = module.compute_asg.target_group_arn
  #  project_name     = "project-one"
}


# Helpful outputs for testing
output "project_one_alb_dns" {
  value = module.compute_alb.alb_dns_name
}
