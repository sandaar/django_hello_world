# django_hello_world

AWS CloudFormation templates for app and loadbalancer ec2 instances (as AutoScalingGroups), instances come with AWS CodeDeploy agent, aws cli, docker installed and port 8000 open. 

gunicorn/Django HelloWorld dockerized app is getting deployed to app ec2 instances and nginx is used as a loadbalancer.

Any commit to this repo triggers build server to switch on maintenance mode on loadbalancer and deploys update on app instances then turns off maintenance mode on loadbalancer.

# to do
- [ ] app deployment rollback 
- [ ] add VPC
