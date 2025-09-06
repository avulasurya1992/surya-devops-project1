resource "aws_lb_target_group" "project_one_tg" {
name = "project-one-tg"
port = var.app_port
protocol = "HTTP"
vpc_id = var.vpc_id
target_type = "instance"


health_check {
path = var.health_check_path
protocol = "HTTP"
matcher = "200-399"
interval = 30
timeout = 5
healthy_threshold = 2
unhealthy_threshold = 2
}


tags = merge(var.tags, { Name = "project-one-tg" })
}


resource "aws_autoscaling_group" "project_one_asg" {
name = "project-one-asg"
desired_capacity = var.desired_capacity
max_size = var.max_size
min_size = var.min_size
vpc_zone_identifier = [var.private_subnet_id]
health_check_grace_period = 120
health_check_type = "ELB"


target_group_arns = [aws_lb_target_group.project_one_tg.arn]


launch_template {
id = var.launch_template_id
version = "$Latest"
}


tag {
key = "Name"
value = "project-one-asg-instance"
propagate_at_launch = true
}


lifecycle {
create_before_destroy = true
}
}
