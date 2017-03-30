APPLICATION_NAME="HelloWorld"
DEPLOYMENT_GROUP_NAME="Staging"
STACK_NAME="TestStack"

aws deploy delete-deployment-group --application-name $APPLICATION_NAME --deployment-group-name $DEPLOYMENT_GROUP_NAME
aws cloudformation delete-stack --stack-name $STACK_NAME
