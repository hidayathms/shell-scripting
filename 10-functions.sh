#!/bin/bash

#There are 4 types of commands available

# 1) binary             (/bin, /sbin)
# 2) Aliases            (Aliases are shortcuts example alias net="netstat -tulpn")
# 3) Shell Bulutin commands
# 4 Functions           #Functions are nothing but a set of commands that can be written in a sequence and can be called when needed.

# How do you declare a function ?

#f () {
    # echo hai
#}


b56(){
    echo " This is batch56 function"
    echo " learning functions"
    echo "Todays date is :"
    date
    echo "Function completed"
}

b56

stat(){
    echo " Number of sessions opened $(who|wc -l)"
    echo "Todays date is $(date +%F)" 
    echo "Avg cpu utilization $(uptime|awk -F : '{print $NF}' | awk -F ',' '{print $2}')"
b56
}

stat