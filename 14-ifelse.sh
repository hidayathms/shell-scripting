#!/bin/bash

echo -e "Demo on IF, IF ELSE & ELSE IF usage"

ACTION=$1

if [ "$ACTION" == "start" ] ; then 
echo -e "\e[34m Starting shipping service \e[0m]"
exit 0
elif [ "$ACTION" == "stop" ] ; then 
echo -e "\e[35m stopping shipping service \e[0m]"
exit 1
else 
echo -e "\e[36m Starting shipping service \e[0m]"
exit 2
fi 

