LOGFILE="/tmp/${COMPONENT}.logs"
APPUSER="roboshop"
COMPONENT_URL="https://github.com/stans-robot-project/$COMPONENT/archive/main.zip"
APPUSER_HOME="/home/$APPUSER/${COMPONENT}"
USER_ID=$(id -u)

stat(){
    if [ $1 -eq 0 ] ; then
    echo -e "\e[32m Success \e[0m"
else 
    echo -e " \e[31m Failure \e[0m"
fi
}


if [ $USER_ID -ne 0 ] ; then
echo " This script is expected to be executed with sudo or as a addministrator or root user"
exit 1
fi