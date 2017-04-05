STACK_NAME="BuildServerStack"
MIN_COUNT=1
MAX_COUNT=1
INSTANCE_TYPE="t1.micro"
KEY_NAME="aws_personal"
OS="Linux"
CF_TEMPLATE_BODY="file://$(pwd)/cf_build_server.json"
NAME_TAG="BuildServer"

aws cloudformation create-stack --stack-name $STACK_NAME --template-body $CF_TEMPLATE_BODY --parameters ParameterKey=Name,ParameterValue=$NAME_TAG ParameterKey=MinCount,ParameterValue=$MIN_COUNT ParameterKey=MaxCount,ParameterValue=$MAX_COUNT ParameterKey=InstanceType,ParameterValue=$INSTANCE_TYPE ParameterKey=KeyPairName,ParameterValue=$KEY_NAME ParameterKey=OperatingSystem,ParameterValue=$OS ParameterKey=SSHLocation,ParameterValue=0.0.0.0/0  --capabilities CAPABILITY_IAM
while [[ $(aws cloudformation describe-stacks --stack-name $STACK_NAME --query "Stacks[0].StackStatus" --output text) != "CREATE_COMPLETE" ]]; do
    sleep 5
    echo "stack creation in progress"
done
echo "stack creation completed"
# get app instances private ips and update nginx conf
build_server_dns_name=$(aws ec2 describe-instances --filter Name=tag:Name,Values=$NAME_TAG --query "Reservations[].Instances[][PublicDnsName]" --output=text)
echo "Build server dns name: $build_server_dns_name"
