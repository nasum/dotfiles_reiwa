FROM ubuntu:18.04

ENV WORKDIR /root
ENV SHELL /usr/bin/zsh

WORKDIR $WORKDIR

RUN apt-get update && apt-get install -y \
    git \
    zsh \
    emacs \
    curl \
    language-pack-ja \
    && \
    apt-get clean

ADD . $WORKDIR

CMD zsh
