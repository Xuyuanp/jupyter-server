FROM debian:latest

LABEL maintainer='xuyuanp@gmail.com'

RUN apt-get update --fix-missing \
        && apt-get install -q -y curl git wget procps g++ libpq-dev bash-completion \
        && apt-get clean \
        && rm -rf /var/lib/apt/lists/*

ADD WenQuanYiMicroHei.ttf /usr/share/fonts/

RUN groupadd -r -g 1000 jupyter \
        && useradd -r -g jupyter -u 1000 -d /jupyter -s /bin/bash jupyter

ENV TINI_VERSION v0.6.0
ADD https://github.com/krallin/tini/releases/download/${TINI_VERSION}/tini /usr/bin/tini
RUN chmod +x /usr/bin/tini

USER jupyter
WORKDIR /jupyter
ENTRYPOINT ["/usr/bin/tini", "--"]
