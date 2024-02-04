#!/bin/bash
if [ -z ${APP_PATH+x} ]; then
    APP_PATH="/home/ubuntu"
fi
cd $APP_PATH
export DEBIAN_FRONTEND="noninteractive"
sudo apt update
sudo apt install -y -q git
git clone -b monolith https://github.com/express42/reddit.git
cd $APP_PATH/reddit/
bundle install
sudo  mv /var/tmp/reddit-app.service /etc/systemd/system
sudo systemctl daemon-reload
sudo systemctl enable --now reddit-app.service
