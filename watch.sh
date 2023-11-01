#!/bin/bash

cd /root/src 

while [[ 1=1 ]]
  do
    watch --chgexit -n 1 "ls --all -l --recursive --full-time | sha256sum" && /root/build.sh
    sleep 5  
done
