#!/bin/bash

ENV=$1

envs=("dev" "qa" "prod")
if [ -z "$ENV" ] || [[ ! " ${envs[@]} " =~ " ${ENV} " ]]; then
  echo "ENV missing or invalid."
  exit
fi

TF_FOLDER=tf/$ENV

FUNCTION_NAME=$(terraform -chdir=$TF_FOLDER output -raw function_name)

cd functions/listener &&
  GOOS=linux GOARCH=amd64 go build -o bootstrap index.go &&
  zip -r function.zip . &&
  aws lambda update-function-code \
    --function-name $FUNCTION_NAME \
    --zip-file fileb://function.zip \
    --output json > /dev/null