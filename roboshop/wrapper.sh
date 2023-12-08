#!/bin/bash

bash components/$1.sh

if [ $? -ne 0 ] ; then
echo -e "\e[34m example usage : \e[0 bash wrapper.sh componentname"
exit 30
fi 
