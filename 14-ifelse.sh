#!/bin/bash

echo -e "Demo on IF, IF ELSE & ELSE IF usage"

ACTION=$1

if [ "$ACTION" == "start" ] ; then 
echo -e "\e[34m Starting shipping service \e[0m]"
exit 0
elif [ "$ACTION" == "stop" ] ; then 
echo -e "\e[34m stopping shipping service \e[0m]"
exit 0
else 
echo -e "\e[34m Starting shipping service \e[0m]"
exit 1
fi 

echo "It has not met any conditions"
exit 100