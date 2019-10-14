From ubuntu:bionic

COPY sources.list /etc/apt/

RUN apt-get update && apt-get install -y aptitude && aptitude update


RUN export DEBIAN_FRONTEND=noninteractive && \
    ln -fs /usr/share/zoneinfo/Asia/Taipei /etc/localtime && \
    aptitude install -y tzdata && \
    dpkg-reconfigure --frontend noninteractive tzdata

RUN aptitude install -y coreutils git vim \
    php7.3-cli php7.3-fpm php7.3-json php7.3 php7.3-xml php7.3-mysql php7.3-curl php7.3-redis php7.3-json

COPY /fpm/php.ini /etc/php/7.3/fpm/
COPY ./fpm/pool.d/www.conf /etc/php/7.3/fpm/pool.d/

COPY ./cli/php.ini /etc/php/7.3/cli/

RUN service php7.3-fpm restart
