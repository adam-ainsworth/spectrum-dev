org 32768

ld hl, $0000
ld de, $4000
ld bc, $1800
ldir
di
halt
