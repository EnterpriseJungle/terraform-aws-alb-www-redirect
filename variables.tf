variable "zone_name" {}
variable "cert_arn" {}

variable "subnets" {
  type = "list"
}

variable "securitygroups" {
  type = "list"
}
