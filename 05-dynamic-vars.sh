#!/bin/bash

# DATE="21FEB2024"  Whenever using experession need to enclose in paranthesis
DATE=$(date +%F)
NO_OF_SESSIONS=$(who|wc -l)
echo " Goood Morning, Todays date is $DATE"

echo -e "\e[34m No of sessions is : $NO_OF_SESSIONS \e[0m "


