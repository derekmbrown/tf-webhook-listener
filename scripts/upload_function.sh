#!/bin/bash

ENV=$1

envs=("dev" "qa" "prod")
if [ -z "$ENV" ] || [[ ! " ${envs[@]} " =~ " ${ENV} " ]]; then
  echo "ENV missing or invalid."
  exit
fi

TF_FOLDER=tf/$ENV

FUNCTION_NAME=$(terraform -chdir=$TF_FOLDER output -raw function_name)

cd tf/functions/listener &&
  zip -r index.zip . &&
  aws lambda update-function-code \
    --function-name test-$ENV-listener \
    --zip-file fileb://index.zip \
    --output json > /dev/null