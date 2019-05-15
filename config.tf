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
