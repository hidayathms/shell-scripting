#!/bin/bash

# This script is going to create EC2 servers


# AMI_ID="ami-072983368f2a6eab5" Not the correct approach
# SecurityGroup_ID="sg-014143c52beef6877"

if [ -z $1 ] ; then
echo -e " Compnent name is needed "
exit 1
fi

COMPONENT=$1
HOSTEDZONEID="Z01822012WSURFZZ552LY"
AMI_ID=$(aws ec2 describe-images --filters "Name=name,Values=DevOps-LabImage-Centos-8" | jq ".Images[].ImageId" | sed -e 's/"//g')
SGID=$(aws ec2 describe-security-groups --filters "Name=group-name,Values=b56-allow-firewall" | jq ".SecurityGroups[].GroupId" | sed -e 's/"//g')
INSTANCE_TYPE="t3.micro"

# create_server(){
echo -e "****$COMPONENT Server in Progress *****!!!!"
PRIVATE_IP=$(aws ec2 run-instances --image-id ${AMI_ID} --instance-type ${INSTANCE_TYPE} --security-group-ids ${SGID} --tag-specifications "ResourceType=instance,Tags=[{Key=Name,Value=${COMPONENT}}]" | jq ".Instance[].PrivateIpAddress" | sed -e 's/"//g' ) &>$LOGFILE

echo -e "****$COMPONENT DNS Record creation in Progress *****!!!!"
sed -e "s/COMPONENT/${COMPONENT}/" -e "s/IPADDRESS/$PRIVATE_IP/" route53.json > /tmp/dns.json

aws route53 change-resource-record-sets --hosted-zone-id $HOSTEDZONEID --change-batch file:///tmp/dns.json

# }

# if [ "$1" == "all" ]; then
#     for component in frontend mongodb catalogue redis user cart mysql shipping reabbitmq payment; do
#         COMPONENT=$component
#         create_server
#     done
# else 
#     create_server
# fi