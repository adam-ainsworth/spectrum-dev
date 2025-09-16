FROM ubuntu/nginx:latest

# it seems Docker on Windows doesn't play nicely with wildcards
COPY ./taput /usr/bin/
COPY ./sjasmplus /usr/bin/
COPY ./init.sh /root/
COPY ./watch.sh /root/
COPY ./build.sh /root/
COPY ./index.html /root/
COPY ./jsspeccy /var/www/html/jsspeccy

WORKDIR /root

RUN apt-get update && apt-get install zmakebas && chmod 700 *.sh && wget http://www.boriel.com/files/zxb/zxbasic-1.17.1-linux64.tar.gz && tar -xf zxbasic-1.17.1-linux64.tar.gz && rm zxbasic-1.17.1-linux64.tar.gz

# Not using Pasmo for now
# RUN apt-get update && apt-get install pasmo zmakebas && chmod 700 *.sh

# This pulls JSSSpeccy from a release and moves it to the correct place
# ADD https://github.com/gasman/jsspeccy3/releases/download/v3.1/jsspeccy-3.1.zip /root/
# RUN apt-get install unzip && unzip jsspeccy-3.1.zip && mv jsspeccy-3.1/jsspeccy /var/www/html && rm -rf jsspeccy-3.1 jsspeccy-3.1.zip && apt-get remove unzip -y

# This rebuilds taput
# RUN apt-get install git build-essential -y && git clone https://github.com/Sivvus/taput && cd taput && make && apt-get remove git build-essential -y && apt-get purge build-essential && apt-get autoremove -y && apt-get clean

# This rebuilds sjasmplus
# RUN apt-get update && apt-get install git g++ build-essential -y && git clone --recursive -j8 https://github.com/z00m128/sjasmplus.git && cd sjasmplus/ && git submodule update --init --recursive && make && make install && cd .. && rm -rf sjasmplus/ && cp /usr/local/bin/sjasmplus .  && apt-get remove git g++ build-essential -y && apt-get purge build-essential && apt-get autoremove -y && apt-get clean

CMD nginx && /root/init.sh
