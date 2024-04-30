#!/bin/bash


COMPONENT=cart

source components/common.sh

echo -e " \e[34m********Configuring $COMPONENT ******\e[0m"

echo -n " Disabling the default nodejs:10 repo and enabling nodejs18 on $COMPONENT : "
dnf module disable nodejs -y &>> $LOGFILE
dnf module enable nodejs:18 -y  &>> $LOGFILE
stat $?

echo -n " Installing NodeJS : "
dnf install nodejs -y   &>> $LOGFILE
stat $?


id $APPUSER &>>$LOGFILE
if [ $? -ne 0 ] ; then
echo -n " Creating $APPUSER : "
useradd $APPUSER
stat $?
else 
echo -n " User account exist : "
echo -e " \e[32m Skipping \e[0m  : "
fi

echo -n " Downloading $COMPONENT : "
curl -s -L -o /tmp/${COMPONENT}.zip $COMPONENT_URL
stat $?

echo -n " Extracting $COMPONENT : "
cd /home/roboshop
unzip -o /tmp/${COMPONENT}.zip  &>> $LOGFILE
stat $?

echo -n " Performing Cleanup $COMPONENT : "
rm -rf $APPUSER_HOME    &>> $LOGFILE
stat $?

echo -n " Configuring $COMPONENT permissions : "
mv /home/$APPUSER/${COMPONENT}-main $APPUSER_HOME    &>> $LOGFILE
chown -R $APPUSER:$APPUSER $APPUSER_HOME
chmod -R 770 $APPUSER_HOME
stat $?

echo -n " Generating Artifacts : "
cd $APPUSER_HOME
npm install &>>$LOGFILE
stat $?


echo -n " Updading $COMPONENT Systemd file : "
sed -i -e 's/REDIS_ENDPOINT/172.31.17.183/' -e 's/CATALOGUE_ENDPOINT/172.31.20.135/' ${APPUSER_HOME}/systemd.service
mv ${APPUSER_HOME}/systemd.service /etc/systemd/system/${COMPONENT}.service
stat $?

echo -n " Starting $COMPONENT  :"
systemctl daemon-reload &>> $LOGFILE 
systemctl enable $COMPONENT  &>> $LOGFILE 
systemctl restart $COMPONENT &>> $LOGFILE 
stat $?
echo -e " \e[34m********$COMPONENT Component configuration completed ******\e[0m"