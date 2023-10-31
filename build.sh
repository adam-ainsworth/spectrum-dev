echo -e 'Build!\n'

pasmo -d -v --bin /root/src/program.asm /root/src/program.bin
/root/bin2tap /root/src/program.bin /var/www/html/program.tap
rm /root/src/program.bin
