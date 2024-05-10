#!/bin/bash


COMPONENT=redis

source components/common.sh

echo -e " \e[34m********Configuring $COMPONENT  repo ******\e[0m"
dnf install https://rpms.remirepo.net/enterprise/remi-release-8.rpm -y  &>>LOGFILE
stat $?

echo -n " Installing Redis   : "
dnf module enable redis:remi-6.2 -y &>>LOGFILE
dnf install redis -y &>>LOGFILE
stat $?

echo -n " Update Config file in $COMPONENT   : "
sed -i -e 's/127.0.0.0/0.0.0.0/' /etc/redis.conf
sed -i -e 's/127.0.0.0/0.0.0.0/' /etc/redis/redis.conf
stat $?


echo -n " Starting $COMPONENT  :"
# systemctl enable redis  &>> $LOGFILE 
systemctl daemon-reload &>> $LOGFILE 
systemctl restart redis &>> $LOGFILE 
stat $?

set-hostname $COMPONENT