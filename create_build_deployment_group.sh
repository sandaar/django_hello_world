#!/bin/bash
APPLICATION_NAME="BuildApp"
DEPLOYMENT_GROUP_NAME="BuildAppDeploymentGroup"
NAME_TAG="BuildServer"
SERVICE_ROLE_ARN="arn:aws:iam::767256184518:role/CodeDeployServiceRole"
DEPLOYMENT_DESCRIPTION="build app deployment"
GITHUB_REPO="sandaar/django_hello_world"
COMMIT_ID="16acde271a395caae07521cfdd8de3e6427b215c"

aws deploy create-deployment-group --application-name $APPLICATION_NAME --ec2-tag-filters Key=Name,Type=KEY_AND_VALUE,Value=$NAME_TAG --deployment-group-name $DEPLOYMENT_GROUP_NAME --service-role-arn $SERVICE_ROLE_ARN 
