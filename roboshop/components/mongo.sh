#!/bin/bash

USER_ID=$(id -u)
COMPONENT=mongo
LOGFILE="/tmp/${COMPONENT}".logs
MONGO_REPO=" https://raw.githubusercontent.com/stans-robot-project/mongodb/main/mongo.repo "

stat(){
    if [ $1 -eq 0 ] ; then
    echo -e "\e[32m Success \e[0m"
else 
    echo -e " \e[31m Failure \e[0m"
fi
}

if [ $USER_ID -ne 0 ] ; then
echo " This script is expected to be executed with sudo or as a addministrator or root user"
exit 1
fi

echo -e " \e[34m********Configuring $COMPONENT ******\e[0m"

echo -n " Dowonloading repo $COMPONENT : "
curl -s -o /etc/yum.repos.d/mongodb.repo $MONGO_REPO
stat $?

echo -n " Installing Mongo   : "
dnf install -y mongodb-org  &>> $LOGFILE 
stat $?

echo -n " Update Config file in $COMPONENT   : "
sed -i -e 's/127.0.0.1/0.0.0.0/' /etc/mongod.conf
stat $?

echo -n " Starting $COMPONENT  :"
systemctl enable mongod  &>> $LOGFILE 
systemctl daemon-reload &>> $LOGFILE 
systemctl start mongod &>> $LOGFILE 
stat $?

echo -n " Download the schema in $COMPONENT   : "
