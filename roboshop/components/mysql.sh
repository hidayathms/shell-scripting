#!/bin/bash

COMPONENT=mysql
MYSQL_REPO="https://raw.githubusercontent.com/stans-robot-project/mysql/main/mysql.repo"
source components/common.sh

echo -e " \e[34m********Configuring $COMPONENT  repo ******\e[0m"

echo -n " Dowonloading repo $COMPONENT : "
dnf module disable mysql -y &>> $LOGFILE 
curl -s -L -o /etc/yum.repos.d/mysql.repo $MYSQL_REPO &>> $LOGFILE 
stat $?

echo -n " Installing  $COMPONENT : "
dnf install mysql-community-server -y &>> $LOGFILE 
stat $?

echo -n " Starting $COMPONENT  :"
systemctl enable mysqld  &>> $LOGFILE 
systemctl start mysqld  &>> $LOGFILE 
stat $?

echo -n " Extracting $COMPONENT default root password: "
DEFAULT_ROOT_PASS=$(sudo grep "temporary password" /var/log/mysqld.log | awk -F " " '{print $NF}')
echo " printing default root password : $DEFAULT_ROOT_PASS "
stat $?
