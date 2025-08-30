# Looks up latest Amazon Linux 2023 AMI (x86_64) in us-east-1
data "aws_ami" "project_one_amazon_linux_2023" {
most_recent = true
owners = ["amazon"]
filter {
name = "name"
values = ["al2023-ami-*-x86_64"]
}
}


# IAM role + instance profile so we can use SSM Session Manager (no SSH required)
resource "aws_iam_role" "project_one_ec2_role" {
name = "project-one-ec2-role"
assume_role_policy = jsonencode({
Version = "2012-10-17",
Statement = [{
Effect = "Allow",
Principal = { Service = "ec2.amazonaws.com" },
Action = "sts:AssumeRole"
}]
})
}


resource "aws_iam_role_policy_attachment" "project_one_ssm_core_attach" {
role = aws_iam_role.project_one_ec2_role.name
policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}


resource "aws_iam_instance_profile" "project_one_instance_profile" {
name = "project-one-ec2-instance-profile"
role = aws_iam_role.project_one_ec2_role.name
}


# Simple user data to run a tiny web server on the app port
locals {
project_one_user_data = <<-EOF
#!/bin/bash
set -eux
dnf update -y || yum update -y || true
dnf install -y python3 || yum install -y python3 || true
cat > /opt/app.py <<'PY'
from http.server import BaseHTTPRequestHandler, HTTPServer
class H(BaseHTTPRequestHandler):
def do_GET(self):
self.send_response(200)
self.send_header('Content-type','text/plain')
self.end_headers()
self.wfile.write(b"project-one: hello from EC2 ASG!\n")
HTTPServer(("0.0.0.0", ${var.app_port}), H).serve_forever()
PY
nohup python3 /opt/app.py >/var/log/project-one-app.log 2>&1 &
EOF
}


resource "aws_launch_template" "project_one_launch_template" {
name_prefix = "project-one-lt-"
image_id = data.aws_ami.project_one_amazon_linux_2023.id
instance_type = var.instance_type
key_name = var.key_name


iam_instance_profile {
name = aws_iam_instance_profile.project_one_instance_profile.name
}


network_interfaces {
security_groups = [var.app_sg_id]
}


user_data = base64encode(local.project_one_user_data)


tag_specifications {
resource_type = "instance"
tags = merge(var.tags, { Name = "project-one-ec2" })
}
}
