#!/bin/bash

LB_NAME_TAG="StagingLoadbalancer"
LB_APPLICATION_NAME="LoadbalancerApp"
LB_DEPLOYMENT_GROUP_NAME="Loadbalancer"
DEPLOYMENT_DESCRIPTION="staging deployment"
S3_LOCATION=general_deploy_bucket
ROOT=/build


aws deploy push --application-name $LB_APPLICATION_NAME --s3-location s3://$S3_LOCATION/LoadbalancerApp.zip --ignore-hidden-files --source $ROOT/nginx
output=$(aws deploy create-deployment --application-name $LB_APPLICATION_NAME --deployment-config-name CodeDeployDefault.OneAtATime --deployment-group-name $LB_DEPLOYMENT_GROUP_NAME --description "$DEPLOYMENT_DESCRIPTION" --s3-location bucket=$S3_LOCATION,bundleType=zip,key=LoadbalancerApp.zip)
deployment_id=$(echo "$output" | sed '2q;d' | awk -v FS="(\"deploymentId\": \"|\")" '{print $2}')

# wait for deployment completion
cmd="aws deploy get-deployment --deployment-id $deployment_id --query "deploymentInfo.status" --output text"
status=$(eval $cmd)
while ! [[ $status =~ ^(Failed|Succeeded|Stopped|Skipped)$ ]]; do
    sleep 5
    echo "lb deployment status $status"
    status=$(eval $cmd)
done
echo "lb deployment completed with status $status"
