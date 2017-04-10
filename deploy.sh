APPLICATION_NAME="BuildApp"
DEPLOYMENT_GROUP_NAME="BuildAppDeploymentGroup"
NAME_TAG="BuildServer"
SERVICE_ROLE_ARN="arn:aws:iam::767256184518:role/CodeDeployServiceRole"
DEPLOYMENT_DESCRIPTION="build app deployment"
GITHUB_REPO="sandaar/django_hello_world"
COMMIT_ID="f673158b47cc11d61599b4461dae47ba63c83ee7"

#aws deploy create-deployment-group --application-name $APPLICATION_NAME --ec2-tag-filters Key=Name,Type=KEY_AND_VALUE,Value=$NAME_TAG --deployment-group-name $DEPLOYMENT_GROUP_NAME --service-role-arn $SERVICE_ROLE_ARN 
aws deploy create-deployment --application-name $APPLICATION_NAME --deployment-config-name CodeDeployDefault.OneAtATime --deployment-group-name $DEPLOYMENT_GROUP_NAME --description "$DEPLOYMENT_DESCRIPTION" --github-location repository=$GITHUB_REPO,commitId=$COMMIT_ID
