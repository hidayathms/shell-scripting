#!/bin/bash

echo "$$"  # This is going to print the PID of the current process
echo '$$'  # Single quote always kills the power of the special variable

echo $?
echo "$?"
echo '$?'