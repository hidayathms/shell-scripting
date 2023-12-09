#!/bin/bash

USER_ID=$(id -u)
COMPONENT=$1

if [$USER_ID -ne 0] ; then
echo " This scrip is to be executed with sudo or as a root user "
echo " Example Usage : sudo bash scripname componetname"
exit 1
fi 

echo -e "********* \e[35m Configuring frontend  \e[0m ************"

echo -n " Installing NGINX"
yum install nginx -y &>> /tmp/frontend.log
if [ $? -eq 0 ] ; then
echo -e "\e[32m Success \e[0m"
else
echo -e "\e[34m Failure \e[0m"
fi

echo -n " Downloading the component $1 : "

curl -s -L -o /tmp/frontend.zip "https://github.com/stans-robot-project/frontend/archive/main.zip"
if [ $? -eq 0 ] ; then
echo -e "\e[32m Success \e[0m"
else
echo -e "\e[34m Failure \e[0m"
fi

# systemctl enable nginx
# systemctl start nginx
# cd /usr/share/nginx/html
# rm -rf *
# unzip /tmp/frontend.zip
# mv frontend-main/* .
# mv static/* .
# rm -rf frontend-main README.md
# mv localhost.conf /etc/nginx/default.d/roboshop.conf

