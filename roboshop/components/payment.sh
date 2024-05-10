#!/bin/bash

COMPONENT=payment

source components/common.sh

PAYTHON

echo -e " \e[34m********$COMPONENT Component configuration completed ******\e[0m"

set-hostname $COMPONENT