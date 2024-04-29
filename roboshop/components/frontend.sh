#!/bin/bash

UID=$(id -u)

if [ $UID -ne 0 ] ; then
echo " This script is expected to be executed with sudo or as a addministrator or root user"
exit 1
fi

echo -e " \e[34m********Configuring frontend ******\e[0m"

echo -e -n "  Installing ngnix   : "
dnf install nginx -y &>> /tmp/frontend.logs 

if [ $? -eq 0 ] ; then
    echo -e "\e[32m Success \e[0m"
else 
    echo -e " \e[31m Failure \e[0m"
fi

echo -e -n "  Dowonloading component $1   : "
curl -s -L -o /tmp/frontend.zip "https://github.com/stans-robot-project/frontend/archive/main.zip"
if [ $? -eq 0 ] ; then
    echo -e "\e[32m Success \e[0m"
else 
    echo -e " \e[31m Failure \e[0m"
fi

echo -n "  Clean Up of $1 component :"
cd /usr/share/nginx/html
rm -rf *    &>> /tmp/frontend.logs
if [ $? -eq 0 ] ; then
    echo -e "\e[32m Success \e[0m"
else 
    echo -e " \e[31m Failure \e[0m"
fi

echo -n "  Extract the $1 component :"
unzip /tmp/frontend.zip     &>> /tmp/frontend.logs
if [ $? -eq 0 ] ; then
    echo -e "\e[32m Success \e[0m"
else 
    echo -e " \e[31m Failure \e[0m"
fi

echo -n "  Configuring $1 component :"
mv frontend-main/* .
mv static/* .
rm -rf frontend-main README.md
mv localhost.conf /etc/nginx/default.d/roboshop.conf
if [ $? -eq 0 ] ; then
    echo -e "\e[32m Success \e[0m"
else 
    echo -e " \e[31m Failure \e[0m"
fi

echo -n "  Restarting $1 component :"
systemctl enable nginx  &>> /tmp/frontend.logs
systemctl daemon-reload &>> /tmp/frontend.logs
systemctl restart nginx &>> /tmp/frontend.logs
if [ $? -eq 0 ] ; then
    echo -e "\e[32m Success \e[0m"
else 
    echo -e " \e[31m Failure \e[0m"
fi



echo -e " \e[34m********$1 Component configuration completed ******\e[0m"
