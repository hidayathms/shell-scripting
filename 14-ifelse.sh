#!/bin/bash

<<COMMENT
if conditions is of three formats
1. simple If
2. If else
3. Else If

Simple If
if [expression]; then
commands
if
--commands to be executed only if the expression is true.
COMMENT

echo -e "Demon on If, Else and Else If Usage"

ACTION = $1
 
if [ $ACTION == start ]; then
    echo "shippping starting"
fi