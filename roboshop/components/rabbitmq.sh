#!/bin/bash

COMPONENT=rabbitmq

source components/common.sh

echo -e " \e[34m********Configuring $COMPONENT  dependencies ******\e[0m"
curl -s https://packagecloud.io/install/repositories/rabbitmq/erlang/script.rpm.sh | sudo bash  &>>LOGFILE
stat $?

echo -e " \e[34m********Configuring $COMPONENT  repo ******\e[0m"
curl -s https://packagecloud.io/install/repositories/rabbitmq/rabbitmq-server/script.rpm.sh | sudo bash  &>>LOGFILE
stat $?

echo -n " Installing $COMPONENT   : "
dnf install rabbitmq-server -y &>>LOGFILE
stat $?

START_SVC

echo -n " Creating $APPUSER for $COMPONENT: "
rabbitmqctl add_user roboshop roboshop123
stat $?

echo -n " Sorting permissions to $COMPONENT   : "
rabbitmqctl set_user_tags roboshop administrator
rabbitmqctl set_permissions -p / roboshop ".*" ".*" ".*"

echo -e " \e[34m********$COMPONENT Component configuration completed ******\e[0m"
