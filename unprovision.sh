STACK_NAME="TestStack"

./undeploy.sh
aws cloudformation delete-stack --stack-name $STACK_NAME
