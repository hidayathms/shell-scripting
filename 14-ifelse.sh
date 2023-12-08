#!/bin/bash

echo -e "Demo on IF, IF ELSE & ELSE IF usage"
ACTION=$1
if [ "$ACTION" == "start" ] ; then 
echo -e "\e[34m Starting shipping service \e[0m]"
exit 0
fi 
echo "It has not met any conditions"
echo "exit code is $?"