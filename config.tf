provider "aws" {
  region     = "us-east-2"
}

resource "aws_instance" "example" {
  ami           = "ami-0653e888ec96eab9b"
  instance_type = "t2.nano"
  key_name	= "login"
  user_data	= "${file("userdata.tpl")}"
  iam_instance_profile = "${aws_iam_instance_profile.test_profile.name}"
}

resource "aws_autoscaling_group" "eliwyman_asg" {
  availability_zones = ["us-east-2"]
  desired_capacity   = 2
  max_size           = 4
  min_size           = 2

  launch_template {
    id      = "lt-0d2978ab4a1174ca1"
    version = "$Latest"
  }
}
