#!/bin/bash
OUTPUT=/var/www/html/program.tap

if test -f $OUTPUT; then
    rm $OUTPUT
fi

function add_basic() {
    zmakebas -r -o program.bin $INPUT
    taput add -b -n "$NAME" -o $START program.bin $OUTPUT
    rm program.bin
}

function add_bin() {
    taput add -n "$NAME" -o $START $INPUT $OUTPUT
}

function add_code() {
    pasmo -d --bin $INPUT program.bin
    taput add -n "$NAME" -o $START program.bin $OUTPUT
    rm program.bin
}

INPUT=program.bas
NAME="HelloWorld"
START=10
add_basic

INPUT=program.scr
NAME="Hello SCR"
START=16384
add_bin 

INPUT=program.asm
NAME="Hello Code"
START=32768
add_code 

