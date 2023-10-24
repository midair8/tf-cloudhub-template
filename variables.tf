variable "client_id" {
  type      = string
  sensitive = true
}
variable "client_secret" {
  type      = string
  sensitive = true
}
variable "org_id" {
  type = string
}
variable "env_name" {
  type = string
}
variable "owner_id" {
  type = string
}
variable "env_type" {
  type = string
}
variable "vpc_name" {
  type = string
}
variable "vpc_region" {
  type = string
}
variable "vpc_cidr_block" {
  type = string
}
variable "dlb_name" {
  type = string
}
# started, stopped, or restarted
variable "dlb_state" {
  type    = string
  default = "started"
}
variable "dlb_ip_whitelist" {
  type    = list(string)
  default = []
}
variable "dlb_http_mode" {
  type    = string
  default = "redirect"
}
variable "dlb_tlsv1" {
  type    = bool
  default = false
}
variable "dlb_ssl_endpoints_public_key_label" {
  type = string
}
variable "dlb_ssl_endpoints_public_key" {
  type      = string
  sensitive = true
}
variable "dlb_ssl_endpoints_private_key_label" {
  type = string
}
variable "dlb_ssl_endpoints_private_key" {
  type      = string
  sensitive = true
}