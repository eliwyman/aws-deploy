provider "aws" {
  region     = "us-east-2"
}

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

# placement {
#   availability_zone = "us-west-2a"
# }

  user_data		= "${base64encode(file("userdata.tpl"))}"
  vpc_security_group_ids = ["sg-3c83ff52"]

}

resource "aws_autoscaling_group" "eliwyman_asg" {

#  (Required only for EC2-Classic)
  availability_zones = ["us-east-2a"]

  desired_capacity   = 2
  max_size           = 4
  min_size           = 2

  launch_template {
    id      = "${aws_launch_template.eliwyman_ubuntu.id}"
    version = "$Latest"
  }
}
