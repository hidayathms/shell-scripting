#!/bin/bash


COMPONENT=mongo

MONGO_REPO=" https://raw.githubusercontent.com/stans-robot-project/mongodb/main/mongo.repo "
SCHEMA="https://github.com/stans-robot-project/mongodb/archive/main.zip"

source components/common.sh

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

set-hostname $COMPONENT