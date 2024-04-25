#!/bin/bash

<<COMMENT
if conditions is of three formats
1. simple If
2. If else
3. Else If

Simple If
if [expression]; then
commands
if
--commands to be executed only if the expression is true.
COMMENT

echo -e "Demon on If, Else and Else If Usage"

ACTION=$1
 
if [ "$ACTION" == "start" ]; then
    echo "shippping starting"
   exit 0

elif [ "ACTION" == "stop" ]; then 
 echo "shippping stoping"
   exit 1
elif [ "ACTION" == "restart" ]; then 
 echo "shippping restarting"
   exit 2
else
   echo "valid option is start, stop and restart only"
   exit 3
fi

echo " It has not met any conditions"
exit 100