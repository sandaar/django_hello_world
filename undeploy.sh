APPLICATION_NAME="HelloWorld"
DEPLOYMENT_GROUP_NAME="Staging"

aws deploy delete-deployment-group --application-name $APPLICATION_NAME --deployment-group-name $DEPLOYMENT_GROUP_NAME
