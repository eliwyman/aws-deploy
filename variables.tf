variable "region" {
  default = "us-east-2"
}
variable "alarms_email" {}

variable "allowed_cidr_blocks" {
  type = "list"
}

variable "certificate_arn" {}

variable "route53_hosted_zone_name" {}
