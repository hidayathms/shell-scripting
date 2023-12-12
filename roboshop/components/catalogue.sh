#!/bin/bash

USER_ID=$(id -u)
COMPONENT=catalogue
LOGFILE="/tmp/${COMPONENT}.log"
CAT_REPO="https://rpm.nodesource.com/pub_16.x/nodistro/repo/nodesource-release-nodistro-1.noarch.rpm"
CAT_DATA="https://github.com/stans-robot-project/catalogue/archive/main.zip"
APPUSER="roboshop"
APPUSER_HOME="/home/roboshop/catalogue"

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
yum install  $CAT_REPO -y    &>> $LOGFILE
stat $?
else
echo -e "\e[32m Skipping \e[0m"
fi

echo -n " Installing $COMPONENT nodjs : "
yum install nodejs -y   &>> $LOGFILE
stat $?

# echo -n " Create new user in $COMPONENT  : "
# id $APPUSER  &>> $LOGFILE
# if [ $? -ne 0 ] ; then
# useradd $APPUSER
# stat $?
# else
# echo -e "\e[32m Skipping \e[0m"
# fi




echo -n " Dowloading $COMPONENT data :"
curl -s -L -o /tmp/catalogue.zip $CAT_DATA
stat $?

echo -n " Performing cleanup of $component : "
rm -rf /home/centos/catalogue &>> $LOGFILE

echo -n "Extracting $COMPONENT  : "
cd /home/centos
unzip -o /tmp/catalogue.zip &>> $LOGFILE
stat $?

echo -n " Configuring  $COMPOENT permissions : " 
mv catalogue-main catalogue   &>> $LOGFILE
# chown -R $APPUSER:$APPUSER $APPUSER_HOME
# chmod -R 770 $APPUSER_HOME
stat $?

echo -n " Generating Artifacts : "
cd /home/centos/catalogue
npm install     &>> $LOGFILE
stat $?

echo -n " Configure the service : "
cd /home/centos/catalogue
sed -i -e 's/MONGO_DNSNAME/mongodb.roboshop.internal/' systemd.service
mv systemd.service /etc/systemd/system/catalogue.service &>> $LOGFILE
stat $?


echo -n "Starting the $COMPONENT Compnent : "
cd /etc/systemd/system/
systemctl daemon-reload
systemctl enable catalogue
systemctl restart catalogue 
stat $?