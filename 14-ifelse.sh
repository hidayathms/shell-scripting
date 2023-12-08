#!/bin/bash

echo -e "Demo on IF, IF ELSE & ELSE IF usage"
ACTION = $1
if [ $ACTION == start ] ; then 
echo -e "\e[34mStarting shipping service \e[0m]"
exit 0
fi 