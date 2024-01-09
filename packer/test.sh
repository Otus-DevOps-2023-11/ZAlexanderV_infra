#!/bin/bash
if [ -z ${APP_PATH+x} ]; then
    echo "Not set"
    APP_PATH="/home/ubuntu"
fi
echo $APP_PATH
