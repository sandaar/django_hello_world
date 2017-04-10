#!/bin/bash
APPLICATION_NAME="HelloWorld"
DEPLOYMENT_GROUP_NAME="Staging"
LB_APPLICATION_NAME="LoadbalancerApp"
LB_DEPLOYMENT_GROUP_NAME="Loadbalancer"


aws deploy delete-deployment-group --application-name $APPLICATION_NAME --deployment-group-name $DEPLOYMENT_GROUP_NAME
aws deploy delete-deployment-group --application-name $LB_APPLICATION_NAME --deployment-group-name $LB_DEPLOYMENT_GROUP_NAME
