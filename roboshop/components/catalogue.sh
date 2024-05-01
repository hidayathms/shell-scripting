#!/bin/bash


COMPONENT=catalogue

source components/common.sh

NODEJS          # Call nodejs function

CREATE_USER

DOWNLOAD_AND_EXTRACT

CONFIG_SVC

START_SVC

echo -e " \e[34m********$COMPONENT Component configuration completed ******\e[0m"