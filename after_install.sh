#!/bin/bash
NAME_TAG="StagingLoadbalancer"
APPLICATION_NAME="LoadbalancerApp"
DEPLOYMENT_GROUP_NAME="Loadbalancer"
DEPLOYMENT_DESCRIPTION="staging deployment"
S3_LOCATION=deploy_bucket

./maintenance.sh off
aws deploy push --application-name LoadbalancerApp --s3-location s3://lb_deploy_bucket/LoadbalancerApp.zip --ignore-hidden-files --source nginx
aws deploy create-deployment --application-name $APPLICATION_NAME --deployment-config-name CodeDeployDefault.OneAtATime --deployment-group-name $DEPLOYMENT_GROUP_NAME --description "$DEPLOYMENT_DESCRIPTION" --s3-location bucket=$S3_LOCATION,bundleType=zip,key=LoadbalancerApp.zip
lb_dns_name=$(aws ec2 describe-instances --filter Name=tag:Name,Values=$NAME_TAG --query "Reservations[].Instances[][PublicDnsName]" --output=text)
while [[ $(curl -s -o /dev/null -w "%{http_code}" $lb_dns_name) != 200 ]]; do
  sleep 2
  echo "switching OFF maintenance mode"
done
echo "done"

