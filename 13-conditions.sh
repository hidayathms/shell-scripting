#!/bin/bash

#conditions helps us to execute something only if some factor is true or false.

#case $var in 
 #   ope1) commands-xy ;;
 #   opt2) command-y;;
# esac
ACTION=$1

case $ACTION in
    start)
    echo -e "\e[32m Starting shippping service \e[0m"
    exit 0
    ;;
    stop) 
    echo -e "\e[34m stoping shippping service \e[e0m"
    exit 1
    ;;
    restart)
    echo -e "[\e[35m restarting shipping service \e[0m"
    exit 2
    ;;
    *) 
    echo -e "\e[36m valid opstions are start or stop or restart only \e[0m"
    echo -e "\e[38m Example Usage : bash script.sh start"
    esac