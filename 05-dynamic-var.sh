#!/bin/bash

# DATE="01DEC2023"
DATE=$(date +%F)
NO_0F_SESSIONS=$(who | wc -l)
echo -e Good Morning, Todays data is \e[34m $DATE \e[0m
echo No os sessions is $NO_0F_SESSIONS

