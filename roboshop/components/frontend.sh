#!/bin/bash

UID=$(id -u)

if [ $UID -ne 0 ] ; then
echo " This script is expected to be executed with sudo or as a addministrator or root user"
exit 1
fi
echo -e " \e[34m********Configuring frontend ******\e[0m"

echo -e " \e[31m**Installing ngnix  **\e[0m"
dnf install nginx -y >/tmp/$1.logs 


# systemctl enable nginx
# systemctl start nginx
# curl -s -L -o /tmp/frontend.zip "https://github.com/stans-robot-project/frontend/archive/main.zip"
# cd /usr/share/nginx/html
# rm -rf *
# unzip /tmp/frontend.zip
# mv frontend-main/* .
# mv static/* .
# rm -rf frontend-main README.md
# mv localhost.conf /etc/nginx/default.d/roboshop.conf


