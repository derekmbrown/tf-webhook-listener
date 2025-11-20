variable "env" {}
variable "project" {}
variable "name" {}
variable "description" {}
variable "filename" {}
variable "role" {}
variable "handler" { default = "index.handler" }
variable "runtime" { default = "nodejs22.x" }
variable "publish" { default = "true" }
variable "timeout" { default = 120 }
variable "retention_in_days" { default = 3 }
