output "target_group_arn" { value = aws_lb_target_group.project_one_tg.arn }
output "asg_name" { value = aws_autoscaling_group.project_one_asg.name }
