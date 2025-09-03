resource "aws_lb" "project_one_alb" {
name = "project-one-alb"
load_balancer_type = "application"
security_groups = [var.alb_sg_id]
subnets = [var.public_subnet_id, var.public_subnet_id_2]


tags = merge(var.tags, { Name = "project-one-alb" })
}


resource "aws_lb_listener" "project_one_http_listener" {
load_balancer_arn = aws_lb.project_one_alb.arn
port = 80
protocol = "HTTP"


default_action {
type = "forward"
target_group_arn = var.target_group_arn
}
}
