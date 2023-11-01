#!/bin/bash
export TERM=xterm

echo -e "\nJSSpeccy live at http://localhost/\n"

cp index.html /var/www/html/

if [[ -z "${MACHINE}" ]]; then
  sed -i "s/envMachine/null/g" /var/www/html/index.html
else
  sed -i "s/envMachine/'${MACHINE}'/g" /var/www/html/index.html
fi

/root/watch.sh
