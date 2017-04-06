#!/bin/bash

DEPLOYMENT_DESCRIPTION="staging deployment"
S3_LOCATION=general_deploy_bucket
APPLICATION_NAME="HelloWorld"
DEPLOYMENT_GROUP_NAME="Staging"
ROOT=/build


$ROOT/maintenance.sh on

aws deploy push --application-name $APPLICATION_NAME --s3-location s3://$S3_LOCATION/App.zip --ignore-hidden-files --source $ROOT/app
output=$(aws deploy create-deployment --application-name $APPLICATION_NAME --deployment-config-name CodeDeployDefault.OneAtATime --deployment-group-name $DEPLOYMENT_GROUP_NAME --description "$DEPLOYMENT_DESCRIPTION" --s3-location bucket=$S3_LOCATION,bundleType=zip,key=App.zip)
deployment_id=$(echo "$output" | sed '2q;d' | awk -v FS="(\"deploymentId\": \"|\")" '{print $2}')

# wait for deployment completion
cmd="aws deploy get-deployment --deployment-id $deployment_id --query "deploymentInfo.status" --output text"
status=$(eval $cmd)
while ! [[ $status =~ ^(Failed|Succeeded|Stopped|Skipped)$ ]]; do
    sleep 5
    echo "deployment status $status"
    status=$(eval $cmd)
done
echo "deployment completed with status $status"

$ROOT/maintenance.sh off
