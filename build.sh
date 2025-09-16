#!/bin/bash
OUTPUT=/var/www/html/program.tap

if test -f $OUTPUT; then
    rm $OUTPUT
fi

if [ -z $PROGRAM ]; then
    PROGRAM=program.conf
fi

function add_basic() {
    zmakebas -r -o program.bin $INPUT && taput add -b -n "$NAME" -o $START program.bin $OUTPUT 

    if test -f program.bin; then
        rm program.bin
    fi
}

function add_boriel() {
    /root/zxbasic/zxbc.py $INPUT -o program.bin
    taput add -n "$NAME" -o $START program.bin $OUTPUT
    rm program.bin
}

function add_bin() {
    if [[ "$START" == "99999" ]]
    then
        taput add $INPUT $OUTPUT
    else
        taput add -n "$NAME" -o $START $INPUT $OUTPUT
    fi
}

function add_code() {
    if [[ "$START" == "99999" ]]
    then
        sjasmplus --raw=program.bin $INPUT && taput add program.bin $OUTPUT
    else
        sjasmplus --raw=program.bin $INPUT && taput add -n "$NAME" -o $START program.bin $OUTPUT
    fi

    if test -f program.bin; then
        rm program.bin
    fi
}

function add_code_pasmo() {
    if [[ "$START" == "99999" ]]
    then
        pasmo -d --bin $INPUT program.bin && taput add program.bin $OUTPUT
    else
        pasmo -d --bin $INPUT program.bin && taput add -n "$NAME" -o $START program.bin $OUTPUT
    fi

    if test -f program.bin; then
        rm program.bin
    fi
}

while read p; do
    if test "$p" = "PAUSE"
    then
        echo "PAUSE"
        exit 0
    fi

    line=(${p//:/ })

    INPUT=${line[0]}
    EXT="${INPUT##*.}"
    NAME=${line[1]}
    START=${line[2]}

    case $EXT in
        "bas")
            add_basic
            ;;

        "scr" | "txt" | "bin")
            add_bin
            ;;

        "asm")
            add_code
            ;;

        "bb")
            add_boriel
            ;;

        *)
            echo "$EXT is an invalid extension"
            ;;
    esac

done < $PROGRAM
