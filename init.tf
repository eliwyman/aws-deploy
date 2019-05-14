provider "aws" {
  region     = "us-east-2"
}

resource "aws_instance" "example" {
  ami           = "ami-0cd3dfa4e37921605"
  instance_type = "t2.nano"
}
