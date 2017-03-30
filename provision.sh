STACK_NAME="TestStack"
INSTANCE_COUNT=1
INSTANCE_TYPE="t1.micro"
KEY_NAME="aws_personal"
OS="Linux"
TAG_VALUE="Staging"
CF_TEMPLATE_BODY="file://$(pwd)/cf.json"

aws cloudformation create-stack --stack-name $STACK_NAME --template-body $CF_TEMPLATE_BODY --parameters ParameterKey=InstanceCount,ParameterValue=$INSTANCE_COUNT ParameterKey=InstanceType,ParameterValue=$INSTANCE_TYPE ParameterKey=KeyPairName,ParameterValue=$KEY_NAME ParameterKey=OperatingSystem,ParameterValue=$OS ParameterKey=SSHLocation,ParameterValue=0.0.0.0/0 ParameterKey=TagKey,ParameterValue=Name ParameterKey=TagValue,ParameterValue=$TAG_VALUE   --capabilities CAPABILITY_IAM
while [[ $(aws cloudformation describe-stacks --stack-name $STACK_NAME --query "Stacks[0].StackStatus" --output text) != "CREATE_COMPLETE" ]]; do
    sleep 5
    echo "stack creation in progress"
done
echo "stack creation completed"

