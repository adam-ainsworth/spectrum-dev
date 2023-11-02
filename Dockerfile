FROM ubuntu/nginx:latest

# it seems Docker on Windows doesn't play nicely with wildcards
COPY ./bin2tap /usr/bin/
COPY ./bin2tap.c /root/
COPY ./init.sh /root/
COPY ./watch.sh /root/
COPY ./build.sh /root/
COPY ./index.html /root/
COPY ./jsspeccy /var/www/html/jsspeccy
# ADD https://github.com/gasman/jsspeccy3/releases/download/v3.1/jsspeccy-3.1.zip /root/

WORKDIR /root

RUN apt-get update && apt-get install pasmo zmakebas && chmod 700 *.sh

# RUN apt-get update && apt-get install unzip pasmo && chmod 700 *.sh && unzip jsspeccy-3.1.zip && mv jsspeccy-3.1/jsspeccy /var/www/html && rm -rf jsspeccy-3.1 jsspeccy-3.1.zip && apt-get remove unzip -y

# Uncomment this line to rebuild bin2tap
# RUN apt-get install build-essential -y && gcc /root/bin2tap.c -o /usr/bin/bin2tap && apt-get remove build-essential -y && apt-get purge build-essential && apt-get autoremove -y && RUN apt-get clean

CMD nginx && /root/init.sh
