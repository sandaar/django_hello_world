APPLICATION_NAME="HelloWorld"
DEPLOYMENT_GROUP_NAME="Staging"
STACK_NAME="TestStack"
INSTANCE_COUNT=1
INSTANCE_TYPE="t1.micro"
KEY_NAME="aws_personal"
OS="Linux"
TAG_VALUE="Staging"
CF_TEMPLATE_BODY="file://$(pwd)/cf.json"
SERVICE_ROLE_ARN="arn:aws:iam::767256184518:role/CodeDeployServiceRole"
DEPLOYMENT_DESCRIPTION="staging deployment"
GITHUB_REPO="sandaar/django_hello_world"
COMMIT_ID="355b7f8560b0bc56ba79b2ad292a15c29ae2e2aa"
DEPLOYMENT_TYPE="BLUE_GREEN"
DEPLOYMENT_OPTION="WITHOUT_TRAFFIC_CONTROL"

# aws deploy create-deployment-group --application-name $APPLICATION_NAME --ec2-tag-filters Key=Name,Type=KEY_AND_VALUE,Value=$TAG_VALUE --deployment-group-name $DEPLOYMENT_GROUP_NAME --service-role-arn $SERVICE_ROLE_ARN 
aws deploy create-deployment --application-name $APPLICATION_NAME --deployment-config-name CodeDeployDefault.OneAtATime --deployment-group-name $DEPLOYMENT_GROUP_NAME --description "$DEPLOYMENT_DESCRIPTION" --github-location repository=$GITHUB_REPO,commitId=$COMMIT_ID
