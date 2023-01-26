variable "role_name" {
  description = "nombre del role que asume tras autenticar"
  type        = string
}
variable "role_description" {
  type = string
}
variable "org_to_authorize" {
  type = string
}
variable "repo_to_authorize" {
  type = string
}
variable "branch_to_authorize" {
  type = string
}
variable "policy_name" {
  type = string
}
variable "actions_for_policy" {
  type = list(string)
}
variable "openid_connect_provider_arn" {
  description = "arn del openid para github"
  type        = string
}
