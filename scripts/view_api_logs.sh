#!/bin/bash

ENV=$1
TF_FOLDER=tf/$ENV

LOG_NAME=$(terraform -chdir=$TF_FOLDER output -raw apigw_log_group_name)
FORMAT_LOG_NAME=${LOG_NAME//\"/}

cd $TF_FOLDER && \
  awslogs get $FORMAT_LOG_NAME ALL --start='1h ago' --timestamp --watch