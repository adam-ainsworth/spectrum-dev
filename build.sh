#!/bin/bash
OUTPUT=/var/www/html/program.tap

if test -f $OUTPUT; then
    rm $OUTPUT
fi

zmakebas -a 10 -n Hello -o $OUTPUT /root/src/program.bas

bin2tap -o $OUTPUT /root/src/program.scr -a 16384 -append

pasmo -d -v --bin /root/src/program.asm /root/src/program.bin

# TODO add option for header
bin2tap -o $OUTPUT /root/src/program.bin -append
rm /root/src/program.bin
