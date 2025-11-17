#!/bin/bash

ENV=$1
TF_FOLDER=tf/$ENV

# Capture api token into variable
API_TOKEN=$(terraform -chdir=$TF_FOLDER output -raw apigw_external_api_key)

# Capture endpoint url into variable
ENDPOINT=$(terraform -chdir=$TF_FOLDER output apigw_external_invoke_url)

# ...and format it
FORMAT_ENDPOINT=${ENDPOINT//\"/}
FULL_ENDPOINT="$FORMAT_ENDPOINT/webhook"

# Make test request
echo 'hello, world' | http POST $FULL_ENDPOINT x-api-key:$API_TOKEN