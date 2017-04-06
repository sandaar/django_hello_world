APPLICATION_NAME="LoadbalancerApp"
DEPLOYMENT_GROUP_NAME="Loadbalancer"
TAG_VALUE="StagingLoadbalancer"
SERVICE_ROLE_ARN="arn:aws:iam::767256184518:role/CodeDeployServiceRole"
DEPLOYMENT_DESCRIPTION="staging deployment"
S3_LOCATION=general_deploy_bucket

aws deploy create-deployment-group --application-name $APPLICATION_NAME --ec2-tag-filters Key=Name,Type=KEY_AND_VALUE,Value=$TAG_VALUE --deployment-group-name $DEPLOYMENT_GROUP_NAME --service-role-arn $SERVICE_ROLE_ARN 
#aws deploy create-deployment --application-name $APPLICATION_NAME --deployment-config-name CodeDeployDefault.OneAtATime --deployment-group-name $DEPLOYMENT_GROUP_NAME --description "$DEPLOYMENT_DESCRIPTION" --s3-location bucket=$S3_LOCATION,bundleType=zip,key=LoadbalancerApp.zip
