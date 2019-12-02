FROM debian:latest

LABEL maintainer='xuyuanp@gmail.com'

RUN sed -i 's/deb.debian.org/mirrors.ustc.edu.cn/g' /etc/apt/sources.list \
        && sed -i 's|security.debian.org/debian-security|mirrors.ustc.edu.cn/debian-security|g' /etc/apt/sources.list \
        && apt-get update --fix-missing \
        && apt-get install -q -y curl git wget procps g++ libpq-dev neovim \
        && apt-get clean \
        && rm -rf /var/lib/apt/lists/*

ADD WenQuanYiMicroHei.ttf /usr/share/fonts/

RUN groupadd -r -g 1000 jupyter \
        && useradd -r -g jupyter -u 1000 -d /jupyter -s /bin/bash jupyter

USER jupyter
WORKDIR /jupyter

ENV TINI_VERSION v0.6.0
ADD https://github.com/krallin/tini/releases/download/${TINI_VERSION}/tini /usr/bin/tini
RUN chmod +x /usr/bin/tini
ENTRYPOINT ["/usr/bin/tini", "--"]
