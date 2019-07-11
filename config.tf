resource "aws_launch_template" "eliwyman_ubuntu" {
  block_device_mappings {
    device_name 	= "/dev/sda1"

    ebs {
      encrypted		= "false"
      volume_size 	= 20
    }
  }

  iam_instance_profile {
	name		= "${aws_iam_instance_profile.test_profile.name}"
  }

  image_id		= "ami-0653e888ec96eab9b"
  instance_type 	= "t2.nano"
  key_name		= "login"

  monitoring {
    enabled = true
  }

  user_data		= "${base64encode(file("userdata.tpl"))}"
  vpc_security_group_ids = ["sg-3c83ff52"]

}

resource "aws_autoscaling_group" "eliwyman_asg" {

#  (Required only for EC2-Classic)
  availability_zones 		= ["us-east-2a"]

  desired_capacity   		= 2
  max_size           		= 4
  min_size           		= 2

  health_check_grace_period 	= 300
  health_check_type         	= "EC2"

  launch_template {
    id      = "${aws_launch_template.eliwyman_ubuntu.id}"
    version = "$Latest"
  }
}

resource "aws_autoscaling_policy" "eliwyman_asgp" {
  name                   = "eliwyman_test"
  cooldown               = 300
  autoscaling_group_name = "${aws_autoscaling_group.eliwyman_asg.name}"
  scaling_adjustment	 = 1
  adjustment_type	 = "ChangeInCapacity"
}

resource "aws_security_group" "alb" {
  name        = "terraform_alb_security_group"
  description = "Terraform load balancer security group"
  #vpc_id      = "${aws_vpc.vpc.id}"

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = "${var.allowed_cidr_blocks}"
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = "${var.allowed_cidr_blocks}"
  }

  # Allow all outbound traffic.
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags {
    Name = "terraform-example-alb-security-group"
  }
}

resource "aws_alb" "alb" {
  name            = "terraform-example-alb"
  security_groups = ["${aws_security_group.alb.id}"]
  tags {
    Name = "terraform-example-alb"
  }
}

resource "aws_alb_target_group" "group" {
  name     = "terraform-example-alb-target"
  port     = 80
  protocol = "HTTP"
  #vpc_id   = "${aws_vpc.vpc.id}"
  stickiness {
    type = "lb_cookie"
  }
  # Alter the destination of the health check to be the login page.
  health_check {
    path = "/login"
    port = 80
  }
}

resource "aws_alb_listener" "listener_http" {
  load_balancer_arn = "${aws_alb.alb.arn}"
  port              = "80"
  protocol          = "HTTP"

  default_action {
    target_group_arn = "${aws_alb_target_group.group.arn}"
    type             = "forward"
  }
}

resource "aws_alb_listener" "listener_https" {
  load_balancer_arn = "${aws_alb.alb.arn}"
  port              = "443"
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-2016-08"
  certificate_arn   = "${var.certificate_arn}"
  default_action {
    target_group_arn = "${aws_alb_target_group.group.arn}"
    type             = "forward"
  }
}

resource "aws_route53_record" "terraform" {
  zone_id = "${data.aws_route53_zone.zone.zone_id}"
  name    = "terraform.${var.route53_hosted_zone_name}"
  type    = "A"
  alias {
    name                   = "${aws_alb.alb.dns_name}"
    zone_id                = "${aws_alb.alb.zone_id}"
    evaluate_target_health = true
  }
}
