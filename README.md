# django_hello_world

AWS CloudFormation templates for app and loadbalancer ec2 instances (as AutoScalingGroups), instances come with AWS CodeDeploy agent, aws cli, docker installed and port 8000 open. 

gunicorn/Django HelloWorld dockerized app is getting deployed to app ec2 instances and nginx is used as a loadbalancer.

Any commit to this repo triggers build server to switch on maintenance mode on loadbalancer and deploys update on app instances then turns off maintenance mode on loadbalancer.

There are three deployment groups:
- BuildAppDeploymentGroup (tied to BuildApp and instances tagged by Name BuildServer)
- Staging (tied to HelloWorld and instances tagged by Name StagingApp)
- Loadbalancer (tied to LoadbalancerApp and instances tagged by Name StagingLoadbalancer)

Changes in this repo trigger new deployment in BuildAppDeploymentGroup which means this whole repo gets copied to the build server and start_app.sh in the root of this repo gets executed. start_app.sh creates new deployment of LoadbalancerApp which basically copies over modified files under nginx/ to the loadbalancer instance without disrupting nginx daemon. start_app.sh will wait for loadbalancer to serve maintenance page (HTTP Status code 503), after it will create new deployment of HelloWorld app on Staging deployment group instances and create another LoadbalancerApp deployment to turn off maintenance mode.

# to do
- [ ] app deployment rollback 
- [ ] add VPC
