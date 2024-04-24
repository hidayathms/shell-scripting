#!/bin/bash

# Special Varialbles are like $0 to $09, $a, S#, $?, $$ 

echo " Thins the name of scrip name : $0"

echo "First Argument : $1"
echo "First Argument : $2"
echo "First Argument : $3"

# bash scriptName.sh firstArg secondArg thirdArg
#                       $1          $2      $3     upto $9 which can be read from command line


echo $0  # print script name
echo $#  # Prints the overall arguments used in the script
echo $?  # This prints the exit code of the last command
echo $*  # Ptints all the arguments used
echo $@  # This will print used arguments