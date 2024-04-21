resource "aws_lb_target_group" "alb" {
  port        = 80
  protocol    = "HTTP"
  vpc_id      = module.step3_vpc.vpc_id
  target_type = "instance"

  health_check {
    path                = "/"
    protocol            = "HTTP"
    port                = "80"
    interval            = 30
    timeout             = 5
    healthy_threshold   = 2
    unhealthy_threshold = 2
  }

  tags = merge(local.tags, { Name = "${var.name}-alb-target-group" })

}

resource "aws_lb" "alb" {
  internal                   = false
  load_balancer_type         = "application"
  security_groups            = [aws_security_group.alb.id]
  subnets                    = module.step3_vpc.public_subnets
  enable_deletion_protection = true
  tags                       = merge(local.tags, { Name = "${var.name}-alb" })
}
resource "aws_security_group" "alb" {
  name   = "${var.name}-alb-sg"
  vpc_id = module.step3_vpc.vpc_id

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(local.tags, { Name = "${var.name}-alb-sg" })

}

resource "aws_lb_listener" "alb" {
  load_balancer_arn = aws_lb.alb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.alb.arn
  }
}

resource "aws_lb_target_group_attachment" "alb" {
  #for_each         = module.step3_ec2  # Ітерація по EC2 інстансам
  target_group_arn = aws_lb_target_group.alb.arn # Вказуємо цільову групу
  target_id        = module.step3_ec2[local.first_instance_key].ec2_id
  port             = 80
}
locals {
  ec2_keys = keys(module.step3_ec2)

  # Отримуємо перший ключ зі списку
  first_instance_key = element(local.ec2_keys, 0)
}
