#!/bin/bash

USER_ID=$(id -u)
COMPONENT=redis
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

echo -e " \e[34m********Configuring $COMPONENT  repo ******\e[0m"
dnf install https://rpms.remirepo.net/enterprise/remi-release-8.rpm -y  &>>LOGFILE
stat $?

echo -n " Installing Redis   : "
dnf module enable redis:remi-6.2 -y &>>LOGFILE
dnf install redis -y &>>LOGFILE
stat $?

echo -n " Update Config file in $COMPONENT   : "
sudo sed -i -e 's/127.0.0.0/0.0.0.0/' /etc/redis.conf
sudo sed -i -e 's/127.0.0.0/0.0.0.0/' /etc/redis/redis.conf
stat $?

echo -n " Starting $COMPONENT  :"
systemctl enable redis  &>> $LOGFILE 
systemctl daemon-reload &>> $LOGFILE 
systemctl restart redis &>> $LOGFILE 
stat $?
