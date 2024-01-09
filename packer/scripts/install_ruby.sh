#!/bin/bash
apt update
sleep 3
echo 'debconf debconf/frontend select Noninteractive' | debconf-set-selections
apt full-upgrade -y
apt install -y -q ruby-full ruby-bundler build-essential
ruby -v
bundler -v
