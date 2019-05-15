provider "aws" {
  region     = "us-east-2"
}

resource "aws_instance" "example" {
  ami           = "ami-0653e888ec96eab9b"
  instance_type = "t2.nano"
  key_name	= "login"
}
