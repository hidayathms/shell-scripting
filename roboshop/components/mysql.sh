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
stat $?

echo " show databases;" | mqsql -uroot -pRoboshop@1 &>> $LOGFILE 
if [ $? -ne 0 ] ; then
echo -n " Changing the default root password: "
echo "ALTER USER 'root'@'localhost' IDENTIFIED BY 'Roboshop@1'" | mysql --connect-expired-password -uroot -p$DEFAULT_ROOT_PASS &>> $LOGFILE 
stat $?
fi 

echo -n "Uninstalling password-validate-plugin : "
echo "uninstall plugin validate_password; " | mysql -uroot -pRoboshop@1 &>>LOGFILE
stat $?
