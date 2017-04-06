#!/bin/bash

LB_NAME_TAG="StagingLoadbalancer"
LB_APPLICATION_NAME="LoadbalancerApp"
LB_DEPLOYMENT_GROUP_NAME="Loadbalancer"
DEPLOYMENT_DESCRIPTION="staging deployment"
S3_LOCATION=general_deploy_bucket
ROOT=/build
PAGE_LOCATION=$ROOT/nginx
MESSAGE=""
CODE=200


if [ $1 = "on" ] && [ -f $PAGE_LOCATION/maintenance_off.html ]; then
  mv $PAGE_LOCATION/maintenance_off.html $PAGE_LOCATION/maintenance_on.html;
  MESSAGE="switching loadbalancer to maintenance mode";
  CODE=503
elif [ $1 = "off" ] && [ -f $PAGE_LOCATION/maintenance_on.html ]; then
  mv $PAGE_LOCATION/maintenance_on.html $PAGE_LOCATION/maintenance_off.html;
  MESSAGE="switching OFF maintenance mode";
  CODE=200
else
  echo "nothing was changed";
  exit 0;
fi

aws deploy push --application-name $LB_APPLICATION_NAME --s3-location s3://$S3_LOCATION/LoadbalancerApp.zip --ignore-hidden-files --source $ROOT/nginx
aws deploy create-deployment --application-name $LB_APPLICATION_NAME --deployment-config-name CodeDeployDefault.OneAtATime --deployment-group-name $LB_DEPLOYMENT_GROUP_NAME --description "$DEPLOYMENT_DESCRIPTION" --s3-location bucket=$S3_LOCATION,bundleType=zip,key=LoadbalancerApp.zip

lb_dns_name=$(aws ec2 describe-instances --filter Name=tag:Name,Values=$LB_NAME_TAG --query "Reservations[].Instances[][PublicDnsName]" --output=text)
while [[ $(curl -s -o /dev/null -w "%{http_code}" $lb_dns_name) != $CODE ]]; do
  sleep 2
  echo "$MESSAGE"
done
echo "done switching $1 maintenance mode"
