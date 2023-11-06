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

while read p; do

    line=(${p//:/ })

    INPUT=${line[0]}
    EXT="${INPUT##*.}"
    NAME=${line[1]}
    START=${line[2]}

    case $EXT in
        "bas")
            add_basic
            ;;

        "scr" | "bin")
            add_bin
            ;;

        "asm")
            add_code
            ;;
        
        *)
            echo "$EXT is an invalid extension"
            ;;
    esac

done < program.conf
