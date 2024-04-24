#!/bin/bash

# There are 4 types of commands available :
# 1) Binary  (/bin, /sbin)
# 2)Aliases
# 3) Shell Built-in Commands
# 4) Functions  

#Functions are nothing but a set of commands that can be written in a sequence and can be called n number of times

# How to declare a function ?

#f() {
 #    echo hai 
#}

# How do you call a function
#f # call funtion


b56(){
    echo " This is batch b56 funtion"
    echo " We are leaning functions"
    echo " Todays date is :"
    data
    echo " Funcation b56 completed"
}

b56

stat(){
    echo "Number of sesstios opened :  $(who|wc -l)"
    echo "Todays date is $(date +%F) "
    b56
}

stat