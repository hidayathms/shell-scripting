#!/bin/bash

COMPONENT=rabbitmq

source components/common.sh

echo -e " \e[34m********Configuring $COMPONENT   ******\e[0m"


echo -n  " Configuring $COMPONENT  repo : "
curl -s https://packagecloud.io/install/repositories/rabbitmq/erlang/script.rpm.sh | sudo bash  &>>LOGFILE
curl -s https://packagecloud.io/install/repositories/rabbitmq/rabbitmq-server/script.rpm.sh | sudo bash  &>>LOGFILE
stat $?

echo -n " Installing $COMPONENT   : "
dnf install rabbitmq-server -y &>>LOGFILE
stat $?

echo -n " Starting $COMPONENT  :"
systemctl enable rabbitmq-server &>>LOGFILE
systemctl start rabbitmq-server &>>LOGFILE
systemctl status rabbitmq-server -l &>>LOGFILE
stat $?


if [ $? -ne 0 ] ; then
echo -n " Creating $APPUSER for $COMPONENT : "
rabbitmqctl add_user roboshop roboshop123
stat $?
fi

echo -n " Sorting permissions to $COMPONENT : "
rabbitmqctl set_user_tags roboshop administrator
rabbitmqctl set_permissions -p / roboshop ".*" ".*" ".*"
stat $?

echo -e " \e[34m********$COMPONENT Component configuration completed ******\e[0m"
