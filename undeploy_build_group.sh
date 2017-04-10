APPLICATION_NAME="BuildApp"
DEPLOYMENT_GROUP_NAME="BuildAppDeploymentGroup"

aws deploy delete-deployment-group --application-name $APPLICATION_NAME --deployment-group-name $DEPLOYMENT_GROUP_NAME
