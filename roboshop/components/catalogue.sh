#!/bin/bash

USER_ID=$(id -u)
COMPONENT=catalogue
LOGFILE="/tmp/${COMPONENT}".logs
APPUSER="roboshop"
COMPONENT_URL="https://github.com/stans-robot-project/catalogue/archive/main.zip"
APPUSER_HOME="/home/$APPUSER/${COMPONENT}"


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
echo -n " User account exist : "
echo -e " \e[32m Skipping \e[0m  : "
fi

echo -n " Downloading $COMPONENT : "
curl -s -L -o /tmp/${COMPONENT}.zip $COMPONENT_URL
stat $?

echo -n " Extracting $COMPONENT : "
cd /home/roboshop
unzip -o /tmp/${COMPONENT}.zip  &>> $LOGFILE
stat $?

echo -n " Configuring $COMPONENT permissions : "
mv /home/$APPUSER/${COMPONENT}-main $APPUSER_HOME    &>> $LOGFILE
chown -R $APPUSER:$APPUSER $APPUSER_HOME
chmod -R 770 $APPUSER_HOME
stat $?

echo -n " Generating Artifacts : "
cd $APPUSER_HOME
npm install &>>$LOGFILE
stat $?

echo -n " Move $COMPONENT Configuraiton file : "
mv /home/roboshop/catalogue/systemd.service /etc/systemd/system/catalogue.service
stat $?

