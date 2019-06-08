FROM ubuntu:18.04

ENV WORKDIR /workdir
ENV ZPLUG_HOME /workdir/.zplug

WORKDIR $WORKDIR

RUN apt-get update && apt-get install -y \
    git \
    zsh \
    emacs \
    curl \
    && \
    apt-get clean

RUN git clone https://github.com/zplug/zplug $ZPLUG_HOME

ADD . $WORKDIR

ENTRYPOINT [ "/workdir/entrypoint.sh" ]
