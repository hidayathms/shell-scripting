#!/bin/bash

USER_ID=$(id -u)
COMPONENT=$1
LOGFILE="/tmp/${COMPONENT}.log"

stat() {
        if [ $1 -eq 0 ] ; then
    echo -e "\e[32m Success \e[0m"
    else
    echo -e "\e[34m Failure \e[0m"
    fi
}

# if [$USER_ID -ne 0] ; then
# echo " This scrip is to be executed with sudo or as a root user "
# echo " Example Usage : sudo bash scripname componetname"
# exit 1
# fi 

echo -e "********* \e[35m Configuring $COMPONENT  \e[0m ************"

echo -n " Installing NGINX"
yum install nginx -y &>> $LOGFILE
stat $?

echo -n " Downloading the component $COMPONENT : "
curl -s -L -o /tmp/frontend.zip "https://github.com/stans-robot-project/$COMPONENT/archive/main.zip"
stat $?

echo -n "Cleanup of $COMPONENT component : "
cd /usr/share/nginx/html
rm -rf *    &>> $LOGFILE
stat $?

echo -n " Extracting the $COMPONENT : "
unzip -o /tmp/${COMPONENT}.zip  &>> $LOGFILE
stat $?

echo -n "Configuring $COMPONENT : "
mv $COMPONENT-main/* .
mv static/* .
rm -rf $COMPONENT-main README.md
mv localhost.conf /etc/nginx/default.d/roboshop.conf
stat $?

echo -n "Restarting the $COMPONENT Compnent : "
systemctl enable nginx     &>> $LOGFILE
systemctl daemon-reload    &>> $LOGFILE
systemctl restart nginx     &>> $LOGFILE
stat $?

echo -e "********* \e[35m $COMPONENT Configuring completed  \e[0m ************"

