#!/bin/bash

# Conditions helps us to execute something only if some factor is true or false


# Syntax of case
# case  $var in 
# opt1) command x ;;
# opt2) command y ;;
# esac

# $1 REFERES FIRST COMMAND LINE ARGUMENT
ACTION=$1

case $ACTION in 
    start)
        echo -e " \e[34m Starting shipping servie \e[0m"
        exit 0
        ;;
    stop) 
        echo -e "\e[31m Stopping shipping service \e[0m"
        exit 1
        ;;
    restart)
        echo -e "\e[33m Restarting shipping service \e[0m"
        exit 1
        ;;
    *)
        echo -e "\e[35m Valid options are start, sotp or restart only \e[0m"
        echo -e "\e[35m Example usage: \e[0m \n\t\t bash scriptname.sh start"
esac
