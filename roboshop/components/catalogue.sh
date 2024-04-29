#!/bin/bash

USER_ID=$(id -u)
COMPONENT=catalogue
LOGFILE="/tmp/${COMPONENT}".logs
APPUSER="roboshop"
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

echo -n " Disabling the default nodejs:10 repo and enabling nodejs18 on $COMPONENT : "
dnf module disable nodejs -y &>> $LOGFILE
dnf module enable nodejs:18 -y  &>> $LOGFILE
stat $?

echo -n " Installing NodeJS : "
dnf install nodejs -y   &>> $LOGFILE
stat $?


id $APPUSER &>>$LOGFILE
if [ $? -ne 0 ] ; then
echo -n " Creating $APPUSER : "
useradd $APPUSER
stat $?
else 
echo -e " Skipping  : "
fi

