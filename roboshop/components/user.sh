#!/bin/bash


COMPONENT=user

source components/common.sh

echo -e " \e[34m********Configuring $COMPONENT ******\e[0m"

NODEJS          # Call nodejs function
CREATE_USER
DOWNLOAD_AND_EXTRACT

CONFIG_SVC

START_SVC
echo -e " \e[34m********$COMPONENT Component configuration completed ******\e[0m"