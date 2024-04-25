#!/bin/bash

bash components/$1.sh

if [ $? -ne 0 ] ; then
    echo -e "\e[31m examaple usage : bash wrapper.sh component name \e[0m"
    exit 10
fi

