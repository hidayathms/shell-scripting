#!/bin/bash

echo "$$" # $$ is going to print the PID of the current process
echo '$$' # Single quote always eliminates the power of the special variable

echo $?
echo "$?"
echo '$?'