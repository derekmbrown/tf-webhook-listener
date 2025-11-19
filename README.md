# tf-webhook-processor

Terraform repository to showcase a simple webhook setup AWS.

## Setup:
- Export the following `TF_*` env variables to terminal:

```shell
export TF_VAR_account_id=<AWS_ACCOUNT_ID>
export TF_VAR_region=<AWS_REGION>
```

## Makefile (example usage):

```shell
# Plan Terraform in dev account
make init ENV=dev

# Plan Terraform in dev account
make plan ENV=dev

# Apply Terraform in dev account
make apply ENV=dev

# Apply Terraform in dev account without approval
make apply_auto ENV=dev

# Destroy Terraform in dev account
make destroy ENV=dev

# Destroy Terraform in dev account without approval
make destroy_auto ENV=dev

# Test api in dev account
make test_api ENV=dev

# View api logs in dev account
make view_api_logs ENV=dev

# View lambda function logs in dev account
make view_function_logs ENV=dev

# Upload lambda function to dev account
make upload_function ENV=dev
```

## Tools:
```shell
# terraform: The official Terraform binary
brew tap hashicorp/tap
brew install hashicorp/tap/terraform

# tfswitch: An easy way to switch to different versions of Terraform
brew install warrensbox/tap/tfswitch

# http: A user-friendly cURL replacement
brew install httpie

# awslogs: A simple tool to query cloudwatch logs
brew install awslogs
```