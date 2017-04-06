#!/bin/bash
APP_NAME_TAG="StagingApp"

private_ips=$(aws ec2 describe-instances --filter Name=tag:Name,Values=$APP_NAME_TAG --query "Reservations[].Instances[][PrivateIpAddress]" --output=text)
printf "app servers private ips:\n$private_ips\n"
result=""
for ip in $private_ips; do
  result+="  server $ip:8000;\n";
done
sed "s/SERVERS/$result/g" nginx/app.conf.template > nginx/conf.d/app.conf
