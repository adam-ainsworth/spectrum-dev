FROM ubuntu/nginx:latest

# it seems Docker on Windows doesn't play nicely with wildcards
COPY ./build.sh /root
COPY ./watch.sh /root
COPY ./bin2tap.c /root
COPY ./index.html /root

RUN apt-get update && apt-get install wget unzip pasmo build-essential -y && chmod 700 /root/*.sh && gcc /root/bin2tap.c -o /root/bin2tap && wget https://github.com/gasman/jsspeccy3/releases/download/v3.1/jsspeccy-3.1.zip && unzip jsspeccy-3.1.zip && mv jsspeccy-3.1/jsspeccy /var/www/html && rm -rf jsspeccy-3.1 jsspeccy-3.1.zip && mv /root/index.html /var/www/html && apt-get remove wget unzip build-essential -y

CMD nginx && /root/watch.sh
