USER_ID=$(id -u)
COMPONENT=mongo
LOGFILE="/tmp/${COMPONENT}.log"
MONGO_REPO="https://raw.githubusercontent.com/stans-robot-project/mongodb/main/mongo.repo"
MONGO_SCHEMA="https://github.com/stans-robot-project/mongodb/archive/main.zip"

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
curl -s -o /etc/yum.repos.d/mongodb.repo $MONGO_REPO
stat $?

echo -n " Installing $COMPONENT : "
yum install -y mongodb-org  &>> $LOGFILE
stat $?

echo -n " Enabling the visiblity in  $COMPONENT config file : "
sed -i -e 's/127.0.0.1/0.0.0.0/' /etc/mongod.conf
stat $?


echo -n "Starting the $COMPONENT Compnent : "
systemctl enable mongod    &>> $LOGFILE
systemctl daemon-reload    &>> $LOGFILE
systemctl start mongod     &>> $LOGFILE
systemctl restart mongod    &>> $LOGFILE
stat $?

echo -n " Dowloading $COMPONENT schema :"
curl -s -L -o /tmp/mongodb.zip $MONGO_SCHEMA
stat $?

echo -n "Extracting $COMPONENT schema"
cd /tmp
unzip -o /tmp/mongodb.zip  &>> $LOGFILE
stat $?

echo -n "Injecting the schema"
cd /tmp/mongodb-main
mongo < catalogue.js    &>> $LOGFILE
mongo < users.js    &>> $LOGFILE
stat $?

echo -e "********* \e[35m $COMPONENT Configuring completed  \e[0m ************"