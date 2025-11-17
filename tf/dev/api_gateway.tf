module "api_gw_test" {
  source = "../module/api_gateway"

  # Base settings
  account_id = local.account_id
  env        = local.env
  project    = local.project
  region     = local.region

  external_uri = "arn:aws:apigateway:${local.region}:lambda:path/2015-03-31/functions/arn:aws:lambda:${local.region}:${local.account_id}:function:test-dev-listener/invocations"
}