FROM python:3.7

LABEL maintainer='xuyuanp@gmail.com'

RUN groupadd -r -g 1000 jupyter && \
        useradd -r -g jupyter -u 1000 -d /jupyter -m -s /bin/bash jupyter && \
        pip install -U -q --no-cache-dir pip && \
        pip install -q --no-cache-dir jupyterlab
ADD WenQuanYiMicroHei.ttf /usr/share/fonts/

ENV TINI_VERSION v0.6.0
ADD https://github.com/krallin/tini/releases/download/${TINI_VERSION}/tini /usr/bin/tini
RUN chmod +x /usr/bin/tini

USER jupyter
WORKDIR /jupyter

ENV PYTHONUSERBASE=/jupyter/data/pip
ENV PATH="${PYTHONUSERBASE}/bin:${PATH}"

EXPOSE 8888
ENTRYPOINT ["/usr/bin/tini", "-v", "--"]
CMD ["jupyter", "lab", "--port=8888", "--no-browser", "--ip=0.0.0.0"]
