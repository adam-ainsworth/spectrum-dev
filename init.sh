#!/bin/bash
export TERM=xterm

echo -e "\nJSSpeccy live at http://localhost/\n"

cp index.html /var/www/html/

if [[ -z "${MACHINE}" ]]; then
  sed -i "s/envMachine/null/g" /var/www/html/index.html
else
  sed -i "s/envMachine/'${MACHINE}'/g" /var/www/html/index.html
fi

if [[ -z "${AUTOLOADTAPES}" ]]; then
  sed -i "s/envAutoLoadTapes/null/g" /var/www/html/index.html
else
  sed -i "s/envAutoLoadTapes/${AUTOLOADTAPES}/g" /var/www/html/index.html
fi

if [[ -z "${TAPEAUTOLOADMODE}" ]]; then
  sed -i "s/envTapeAutoLoadMode/null/g" /var/www/html/index.html
else
  sed -i "s/envTapeAutoLoadMode/'${TAPEAUTOLOADMODE}'/g" /var/www/html/index.html
fi

if [[ -z "${KEYBOARDENABLED}" ]]; then
  sed -i "s/envKeyboardEnabled/null/g" /var/www/html/index.html
else
  sed -i "s/envKeyboardEnabled/${KEYBOARDENABLED}/g" /var/www/html/index.html
fi

if [[ -z "${UIENABLED}" ]]; then
  sed -i "s/envUiEnabled/null/g" /var/www/html/index.html
else
  sed -i "s/envUiEnabled/${UIENABLED}/g" /var/www/html/index.html
fi

if [[ -z "${TAPETRAPSENABLED}" ]]; then
  sed -i "s/envTapeTrapsEnabled/null/g" /var/www/html/index.html
else
  sed -i "s/envTapeTrapsEnabled/${TAPETRAPSENABLED}/g" /var/www/html/index.html
fi

touch /var/www/html/program.tap

/root/watch.sh
