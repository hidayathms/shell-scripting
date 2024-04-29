#!/bin/bash

USER_ID=$(id -u)
COMPONENT=mongo
LOGFILE="/tmp/${COMPONENT}".logs
MONGO_REPO=" https://raw.githubusercontent.com/stans-robot-project/mongodb/main/mongo.repo "
SCHEMA="https://github.com/stans-robot-project/mongodb/archive/main.zip"

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
sudo sed -i -e 's/127.0.0.0/0.0.0.0/' /etc/mongod.conf
stat $?

echo -n " Starting $COMPONENT  :"
systemctl daemon-reload &>> $LOGFILE 
systemctl enable mongod  &>> $LOGFILE 
systemctl restart mongod  &>> $LOGFILE 
stat $?

echo -n " Download the schema in $COMPONENT   : "
curl -s -L -o /tmp/mongodb.zip $SCHEMA
stat $?

echo -n " Extracting the schema in $COMPONENT   : "
unzip -o /tmp/mongodb.zip   &>> $LOGFILE
stat $?

echo -n " Injecting the schema in $COMPONENT   : "
cd mongodb-main
mongo < catalogue.js    &>> $LOGFILE
mongo < users.js    &>> $LOGFILE
stat $?
echo -e " \e[34m********$COMPONENT Component configuration completed ******\e[0m"