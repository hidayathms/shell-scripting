USER_ID=$(id -u)
COMPONENT=mongo
LOGFILE="/tmp/${COMPONENT}.log"
MONGO_REPO="https://raw.githubusercontent.com/stans-robot-project/mongodb/main/mongo.repo"

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

echo -e " Configuring $COMPONENT repo : "
curl -s -o /etc/yum.repos.d/mongodb.repo $MONGO_REPO
stat $?

echo -e " Installing $COMPONENT : "
yum install -y mongodb-org  &>> $LOGFILE
stat $?

# echo -n "Starting the $COMPONENT Compnent : "
# systemctl enable mongo     &>> $LOGFILE
# systemctl daemon-reload    &>> $LOGFILE
# systemctl restart mongo     &>> $LOGFILE
# stat $?