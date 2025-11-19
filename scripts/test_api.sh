#!/bin/bash

ENV=$1
BODY=$2

envs=("dev" "qa" "prod")
if [ -z "$ENV" ] || [[ ! " ${envs[@]} " =~ " ${ENV} " ]]; then
  echo "ENV missing or invalid."
  exit
fi

if [ -z "$BODY" ]; then
  BODY='{"message": "hello, world"}'
fi

TF_FOLDER=tf/$ENV

API_TOKEN=$(terraform -chdir=$TF_FOLDER output -raw apigw_external_api_key)

ENDPOINT=$(terraform -chdir=$TF_FOLDER output apigw_external_invoke_url)

FORMAT_ENDPOINT=${ENDPOINT//\"/}
FULL_ENDPOINT="$FORMAT_ENDPOINT/webhook"

echo $BODY | http POST $FULL_ENDPOINT x-api-key:$API_TOKEN