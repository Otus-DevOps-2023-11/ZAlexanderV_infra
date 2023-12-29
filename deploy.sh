#!/bin/bash
cd /home/yc-user
sudo /home/yc-user/install_ruby.sh
sudo /home/yc-user/install_mongodb.sh
sudo apt install -y git
git clone -b monolith https://github.com/express42/reddit.git
cd /home/yc-user/reddit/
bundle install
puma -d
