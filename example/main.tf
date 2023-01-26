terraform {
  required_version = "~> 1.3.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
    tls = {
      source  = "hashicorp/tls"
      version = "~> 4.0"
    }
  }
}
provider "aws" {
  region = "us-west-2"
}
provider "tls" {
}

module "oidc" {
  source                      = "../"
  role_name                   = var.role_name
  role_description            = var.role_description
  policy_name                 = var.policy_name
  actions_for_policy          = var.actions_for_policy
  org_to_authorize            = var.org_to_authorize
  repo_to_authorize           = var.repo_to_authorize
  branch_to_authorize         = var.branch_to_authorize
  openid_connect_provider_arn = var.openid_connect_provider_arn
}

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
