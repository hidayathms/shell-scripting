#!/bin/bash

# DATE="01DEC2023"
DATE=$(date +%F)
NO_0F_SESSIONS=$(who | wc -l)
echo Good Morning, Todays data is $DATE
echo No os sessions is $NO_0F_SESSIONS

