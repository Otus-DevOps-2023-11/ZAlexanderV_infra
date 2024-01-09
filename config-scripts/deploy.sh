#!/bin/bash
MY_USER=$(whoami)
APP_PATH=$(pwd)
echo $APP_PATH
echo $MY_USER
sudo ./install_ruby.sh
sudo ./install_mongodb.sh
sudo apt install -y git
git clone -b monolith https://github.com/express42/reddit.git
cd $APP_PATH/reddit/
bundle install
puma -d
