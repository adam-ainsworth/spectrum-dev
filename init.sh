#!/bin/bash
export TERM=xterm

echo -e "\nJSSpeccy live at http://localhost/\n"

cp index.html /var/www/html/

echo $MACHINE

/root/watch.sh