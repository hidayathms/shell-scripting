# Text Color red = 31, green = 32, yellow = 33, blue = 34, cyan=36, and white = 37
# Background red = 41, green = 42, yellow = 43, blue = 44, magenta = 45, cyan = 46, and white=47

#syntax to print is echo -e "\e[31m priting in Red color \e[0m"

echo -e "\e[31m I am printing Red Color \e[0m"
echo -e "\e[32m I am printing Green Color \e[0m"
echo -e "\e[33m I am printing Yellow Color \e[0m"
echo -e "\e[34m I am printing Blue Color \e[0m"
echo -e "\e[36m I am printing cyan Color \e[0m"

# Printing background+foreground
echo -e "\e[41m I am printing background + foreground \e[0m"