#!/bin/bash

USER_ID=$(id -u)
COMPONENT=$1
LOGFILE="/tmp/${COMPONENT}".logs

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

echo -n "  Installing ngnix   : "
dnf install nginx -y &>> $LOGFILE 
stat $?

echo -n "  Dowonloading component $COMPONENT : "
curl -s -L -o /tmp/$COMPONENT.zip "https://github.com/stans-robot-project/$COMPONENT/archive/main.zip"
stat $?

echo -n "  Clean Up of $COMPONENT component :"
cd /usr/share/nginx/html
rm -rf *    &>> $LOGFILE 
stat $?

echo -n "  Extract the $COMPONENT component :"
unzip /tmp/$COMPONENT.zip     &>> $LOGFILE 
stat $?

echo -n "  Configuring $COMPONENT component :"
mv $COMPONENT-main/* .
mv static/* .
rm -rf $COMPONENT-main README.md
mv localhost.conf /etc/nginx/default.d/roboshop.conf
stat $?

echo -n "  Restarting $COMPONENT component :"
systemctl enable nginx  &>> $LOGFILE 
systemctl daemon-reload &>> $LOGFILE 
systemctl restart nginx &>> $LOGFILE 
stat $?

echo -e " \e[34m********$COMPONENT Component configuration completed ******\e[0m"
