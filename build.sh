#!/bin/bash
OUTPUT=/var/www/html/program.tap

if test -f $OUTPUT; then
    rm $OUTPUT
fi

# BASIC
zmakebas -r -o program.bin program.bas
taput add -b -n "HelloWorld" -o 10 program.bin $OUTPUT
rm program.bin

# SCREEN
taput add -n "Hello SCR" -o 16384 program.scr $OUTPUT

# CODE
pasmo -d --bin program.asm program.bin
taput add -n "Hello Code" -o 32768 program.bin $OUTPUT
rm program.bin
