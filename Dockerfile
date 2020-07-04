FROM i386/ubuntu:xenial

MAINTAINER Andy Sheppard <zoltarisconundrum@gmail.com>

#ENV BYOND_MAJOR=513 \
 #   BYOND_MINOR=1526
# Get the Required Packages and DL & install Byond
RUN apt-get update \
    && apt-get install -y \
    curl \
    unzip \
    make \
    libstdc++6 \
    libmariadb-client-lgpl-dev-compat \
    git \
    libssl-dev \
    #&& curl "http://www.byond.com/download/build/${BYOND_MAJOR}/${BYOND_MAJOR}.${BYOND_MINOR}_byond_linux.zip" -o byond.zip \
    && curl "http://www.byond.com/download/build/513/513.1526_byond_linux.zip" -o byond.zip \
    && unzip byond.zip \
    && cd byond \
    && sed -i 's|install:|&\n\tmkdir -p $(MAN_DIR)/man6|' Makefile \
    && make install \
    && chmod 644 /usr/local/byond/man/man6/* \
    && apt-get purge -y --auto-remove curl unzip make \
    && cd .. \
    && rm -rf byond byond.zip /var/lib/apt/lists/*
