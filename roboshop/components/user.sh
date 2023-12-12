#!/bin/bash

USER_ID=$(id -u)
COMPONENT=user
LOGFILE="/tmp/${COMPONENT}.log"
URL_REPO="https://rpm.nodesource.com/pub_16.x/nodistro/repo/nodesource-release-nodistro-1.noarch.rpm"
USER_DATA="https://github.com/stans-robot-project/user/archive/main.zip"
APPUSER="roboshop"
APPUSER_HOME="/home/roboshop/user/"

stat() {
        if [ $1 -eq 0 ] ; then
    echo -e "\e[32m Success \e[0m"
    else
    echo -e "\e[34m Failure \e[0m"
    fi
}

if [ $USER_ID -ne 0 ] ; then
echo " This scrip is to be executed with sudo or as a root user "
echo " Example Usage : sudo bash scripname componetname"
exit 1
fi 

echo -e "********* \e[35m Configuring $COMPONENT  \e[0m ************"

echo -n " Configuring $COMPONENT repo : "

if [ $? -ne 0 ] ; then
yum install  $URL_REPO -y    &>> $LOGFILE
stat $?
else
echo -e "\e[32m Skipping \e[0m"
fi

echo -n " Installing $COMPONENT nodjs : "
yum install nodejs -y   &>> $LOGFILE
stat $?

echo -n " Create new user in $COMPONENT  : "
id $APPUSER  &>> $LOGFILE
if [ $? -ne 0 ] ; then
useradd $APPUSER
stat $?
else
echo -e "\e[32m Skipping \e[0m"
fi




echo -n " Dowloading $COMPONENT data :"
curl -s -L -o /tmp/user.zip $USER_DATA  &>> $LOGFILE
stat $?

# echo -n " Performing cleanup of $component : "
# rm -rf /home/centos/catalogue &>> $LOGFILE

echo -n "Extracting $COMPONENT  : "
cd /home/roboshop
unzip -o /tmp/user.zip &>> $LOGFILE
stat $?

echo -n " Configuring  $COMPOENT permissions : " 
mv user-main user   &>> $LOGFILE
chown -R $APPUSER:$APPUSER $APPUSER_HOME
chmod -R 770 $APPUSER_HOME
stat $?

echo -n " Generating Artifacts : "
cd /home/roboshop/user
npm install     &>> $LOGFILE
stat $?

echo -n " Configure the service : "
cd /home/roboshop/user/
sed -i -e 's/REDIS_ENDPOINT/redis.roboshop.internal/' systemd.service
sed -i -e 's/MONGO_ENDPOINT/mongodb.roboshop.internal/' systemd.service
mv systemd.service /etc/systemd/system/user.service &>> $LOGFILE
stat $?


echo -n "Starting the $COMPONENT Compnent : "
cd /etc/systemd/system/
systemctl daemon-reload
systemctl enable user
systemctl restart user 
stat $?