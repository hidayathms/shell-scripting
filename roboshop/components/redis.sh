#!/bin/bash

USER_ID=$(id -u)
COMPONENT=redis
LOGFILE="/tmp/${COMPONENT}.log"
URL_REPO="https://raw.githubusercontent.com/stans-robot-project/redis/main/redis.repo"
# CAT_DATA="https://github.com/stans-robot-project/catalogue/archive/main.zip"
# APPUSER="roboshop"
# APPUSER_HOME="/home/roboshop/redis"





stat() {
        if [ $1 -eq 0 ] ; then
    echo -e "\e[32m Success \e[0m"
    else
    echo -e "\e[34m Failure \e[0m"
    fi
}

echo -e "********* \e[35m Configuring $COMPONENT  \e[0m ************"

echo -n " Configuring $COMPONENT repo : "
curl -L  $URL_REPO -o /etc/yum.repos.d/redis.repo
stat $?

echo -n " Installing $COMPONENT : "
yum install redis-6.2.13 -y  &>> $LOGFILE
stat $?

echo -n " Configure the service : "
