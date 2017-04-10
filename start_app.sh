#!/bin/bash

DEPLOYMENT_DESCRIPTION="staging deployment"
S3_LOCATION=general_deploy_bucket
APPLICATION_NAME="HelloWorld"
DEPLOYMENT_GROUP_NAME="Staging"
ROOT=/build


$ROOT/maintenance.sh on

$ROOT/deploy_app.sh

$ROOT/maintenance.sh off
