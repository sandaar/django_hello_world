#!/bin/bash

DEPLOYMENT_DESCRIPTION="staging deployment"
S3_LOCATION=general_deploy_bucket
APPLICATION_NAME="HelloWorld"
DEPLOYMENT_GROUP_NAME="Staging"
ROOT=/build


#$ROOT/maintenance.sh on

aws deploy push --application-name $APPLICATION_NAME --s3-location s3://$S3_LOCATION/App.zip --ignore-hidden-files --source $ROOT/app
aws deploy create-deployment --application-name $APPLICATION_NAME --deployment-config-name CodeDeployDefault.OneAtATime --deployment-group-name $DEPLOYMENT_GROUP_NAME --description "$DEPLOYMENT_DESCRIPTION" --s3-location bucket=$S3_LOCATION,bundleType=zip,key=App.zip 

#$ROOT/maintenance.sh off

