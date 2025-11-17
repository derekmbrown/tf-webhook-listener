variable "env" {}
variable "project" {}
variable "name" {}
variable "description" {}
variable "filename" {}
variable "role" {}
variable "handler" { default = "index.handler" }
variable "runtime" { default = "nodejs18.x" }
variable "publish" { default = "true" }
variable "timeout" { default = 120 }
variable "server_endpoint" {}
variable "sns_topic_id" {}
variable "retention_in_days" { default = 3 }
