APPLICATION_NAME="HelloWorld"
DEPLOYMENT_GROUP_NAME="Staging"
TAG_VALUE="StagingApp"
SERVICE_ROLE_ARN="arn:aws:iam::767256184518:role/CodeDeployServiceRole"
DEPLOYMENT_DESCRIPTION="staging deployment"
GITHUB_REPO="sandaar/django_hello_world"
COMMIT_ID="fa0dcfe320081144a5a1c41c79c5d5cde11a9d14"

aws deploy create-deployment-group --application-name $APPLICATION_NAME --ec2-tag-filters Key=Name,Type=KEY_AND_VALUE,Value=$TAG_VALUE --deployment-group-name $DEPLOYMENT_GROUP_NAME --service-role-arn $SERVICE_ROLE_ARN 
aws deploy create-deployment --application-name $APPLICATION_NAME --deployment-config-name CodeDeployDefault.OneAtATime --deployment-group-name $DEPLOYMENT_GROUP_NAME --description "$DEPLOYMENT_DESCRIPTION" --github-location repository=$GITHUB_REPO,commitId=$COMMIT_ID
