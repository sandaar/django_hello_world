#!/bin/bash
LB_NAME_TAG="StagingLoadbalancer"
LB_APPLICATION_NAME="LoadbalancerApp"
LB_DEPLOYMENT_GROUP_NAME="Loadbalancer"
DEPLOYMENT_DESCRIPTION="staging deployment"
S3_LOCATION=general_deploy_bucket
APPLICATION_NAME="HelloWorld"
DEPLOYMENT_GROUP_NAME="Staging"

./maintenance.sh on
aws deploy push --application-name $LB_APPLICATION_NAME --s3-location s3://$S3_LOCATION/LoadbalancerApp.zip --ignore-hidden-files --source nginx
aws deploy create-deployment --application-name $LB_APPLICATION_NAME --deployment-config-name CodeDeployDefault.OneAtATime --deployment-group-name $LB_DEPLOYMENT_GROUP_NAME --description "$DEPLOYMENT_DESCRIPTION" --s3-location bucket=$S3_LOCATION,bundleType=zip,key=LoadbalancerApp.zip

lb_dns_name=$(aws ec2 describe-instances --filter Name=tag:Name,Values=$LB_NAME_TAG --query "Reservations[].Instances[][PublicDnsName]" --output=text)
while [[ $(curl -s -o /dev/null -w "%{http_code}" $lb_dns_name) != 503 ]]; do
  sleep 2
  echo "switching loadbalancer to maintenance mode"
done
echo "done"

aws deploy push --application-name $APPLICATION_NAME --s3-location s3://$S3_LOCATION/App.zip --ignore-hidden-files --source app
aws deploy create-deployment --application-name $APPLICATION_NAME --deployment-config-name CodeDeployDefault.OneAtATime --deployment-group-name $DEPLOYMENT_GROUP_NAME --description "$DEPLOYMENT_DESCRIPTION" --s3-location bucket=$S3_LOCATION,bundleType=zip,key=App.zip 

./maintenance.sh off
aws deploy push --application-name $LB_APPLICATION_NAME --s3-location s3://general_deploy_bucket/LoadbalancerApp.zip --ignore-hidden-files --source nginx
aws deploy create-deployment --application-name $LB_APPLICATION_NAME --deployment-config-name CodeDeployDefault.OneAtATime --deployment-group-name $LB_DEPLOYMENT_GROUP_NAME --description "$DEPLOYMENT_DESCRIPTION" --s3-location bucket=$S3_LOCATION,bundleType=zip,key=LoadbalancerApp.zip
while [[ $(curl -s -o /dev/null -w "%{http_code}" $lb_dns_name) != 200 ]]; do
  sleep 2
  echo "switching OFF maintenance mode"
done
echo "done"

