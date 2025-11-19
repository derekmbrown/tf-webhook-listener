#!/bin/bash

ENV=$1

envs=("dev" "qa" "prod")
if [ -z "$ENV" ] || [[ ! " ${envs[@]} " =~ " ${ENV} " ]]; then
  echo "ENV missing or invalid."
  exit
fi

TF_FOLDER=tf/$ENV

LOG_NAME=$(terraform -chdir=$TF_FOLDER output -raw function_log_group_name)
FORMAT_LOG_NAME=${LOG_NAME//\"/}

cd $TF_FOLDER && \
  awslogs get $FORMAT_LOG_NAME ALL --start='1h ago' --timestamp --watch