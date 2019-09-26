From ubuntu:bionic

COPY sources.list /etc/apt/

RUN apt-get update && apt-get install -y aptitude && aptitude update


RUN export DEBIAN_FRONTEND=noninteractive && \
    ln -fs /usr/share/zoneinfo/Asia/Taipei /etc/localtime && \
    aptitude install -y tzdata && \
    dpkg-reconfigure --frontend noninteractive tzdata

RUN aptitude install -y coreutils git vim \
    php7.2-cli php7.2-fpm php7.2-json php7.2 php7.2-xml php7.2-mysql php7.2-curl
