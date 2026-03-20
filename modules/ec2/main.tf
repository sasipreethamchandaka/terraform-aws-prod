############################################
# 📌 SECURITY GROUP FOR PRIVATE EC2
############################################
resource "aws_security_group" "ec2_sg" {
  name   = "ec2-sg"
  vpc_id = var.vpc_id

  ingress {
    description = "Allow HTTP from ALB"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    security_groups = [var.alb_sg_id]  # 🔥 only ALB can access
  }

  ingress {
    description = "Allow SSH from Bastion"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    security_groups = [var.bastion_sg_id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

############################################
# 📌 LAUNCH TEMPLATE
############################################
resource "aws_launch_template" "app" {
  name_prefix   = "app-template"
  image_id      = var.ami_id
  instance_type = var.instance_type

  key_name = "my-key"

  network_interfaces {
    associate_public_ip_address = false
    security_groups             = [aws_security_group.ec2_sg.id]
  }

  user_data = base64encode(<<-EOF
              #!/bin/bash
              apt update -y
              apt install nginx -y
              systemctl start nginx
              systemctl enable nginx
              EOF
  )
}

############################################
# 📌 AUTO SCALING GROUP
############################################
resource "aws_autoscaling_group" "app" {
  desired_capacity = 2
  max_size         = 3
  min_size         = 1

  vpc_zone_identifier = var.private_subnets

  target_group_arns = [var.target_group_arn]   # 🔥 attach to ALB

  launch_template {
    id      = aws_launch_template.app.id
    version = "$Latest"
  }
}
