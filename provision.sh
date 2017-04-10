#!/bin/bash
# run this script from the build server as update_nginx_conf.sh is using GNU sed
STACK_NAME="TestStack"
APP_MIN_COUNT=3
APP_MAX_COUNT=3
INSTANCE_TYPE="t1.micro"
KEY_NAME="aws_personal"
OS="Linux"
CF_TEMPLATE_BODY="file://$(pwd)/cf_app_lb_servers.json"
APP_NAME_TAG="StagingApp"


aws cloudformation create-stack --stack-name $STACK_NAME --template-body $CF_TEMPLATE_BODY --parameters ParameterKey=AppName,ParameterValue=$APP_NAME_TAG ParameterKey=AppMinCount,ParameterValue=$APP_MIN_COUNT ParameterKey=AppMaxCount,ParameterValue=$APP_MAX_COUNT ParameterKey=InstanceType,ParameterValue=$INSTANCE_TYPE ParameterKey=KeyPairName,ParameterValue=$KEY_NAME ParameterKey=OperatingSystem,ParameterValue=$OS ParameterKey=SSHLocation,ParameterValue=0.0.0.0/0  --capabilities CAPABILITY_IAM
while [[ $(aws cloudformation describe-stacks --stack-name $STACK_NAME --query "Stacks[0].StackStatus" --output text) != "CREATE_COMPLETE" ]]; do
    sleep 5
    echo "stack creation in progress"
done
echo "stack creation completed"
# get app instances private ips and update nginx conf
sleep 5 # wait for instances private ips to be reserved otherwise will get None
$(pwd)/update_nginx_conf.sh
