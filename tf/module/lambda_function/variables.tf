variable "env" {}
variable "project" {}
variable "name" {}
variable "description" {}
variable "filename" {}
variable "role" {}
variable "handler" { default = "main" }
variable "runtime" { default = "provided.al2023" }
variable "publish" { default = "true" }
variable "timeout" { default = 120 }
variable "retention_in_days" { default = 3 }
