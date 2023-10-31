#!/bin/bash
export TERM=xterm

echo -e "\nJSSpeccy live at http://localhost/\n"

while [[ 1=1 ]]
  do
    cd /root/src && watch --chgexit -n 1 "ls --all -l --recursive --full-time | sha256sum" && /root/build.sh
  sleep 5  
done
