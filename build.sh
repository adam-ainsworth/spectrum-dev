#!/bin/bash
pasmo -d -v --bin /root/src/program.asm /root/src/program.bin

bin2tap -b -cb 0 -cp 0 -ci 7 -o /var/www/html/program.tap /root/src/program.bin

rm /root/src/program.bin
