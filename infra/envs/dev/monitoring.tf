module "monitoring" {
  source       = "../../modules/monitoring"
  asg_name     = module.compute_asg.asg_name
  alert_email  = "your-email@example.com"
  project_name = "project-one"
}

