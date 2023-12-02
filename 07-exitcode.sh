#!/bin/bash

# Each and every action in linux will have a exit code

# 0 to 255 is the rage of codes
#Among all, 0 represents action completed successfully.
#Anyting in betweeen 1 to 255 represents either partial success, partial failure or complete failure

# 0     : Global Success
# 1-125 : Some failure from the command
# 125+  : System failure

# Exit codes also plays a key role in debugging big scripts

