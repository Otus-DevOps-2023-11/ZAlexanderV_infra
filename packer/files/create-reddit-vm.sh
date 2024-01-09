#!/bin/bash

yc compute instance create \
  --name reddit-app \
  --hostname reddit-app \
  --memory=4 \
  --create-boot-disk image-family=reddit-full,size=20GB \
  --network-interface subnet-name=default-ru-central1-a,nat-ip-version=ipv4 \
  --folder-id b1gs4m14eth4n4rjck3k \
  --zone ru-central1-a
