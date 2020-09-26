FROM gitpod/workspace-full

ENV HAKONIWA_HOME=/home/gitpod/hakoniwa
ENV ATHRILL_GCC=${HAKONIWA_HOME}/athrill-gcc

USER root

RUN apt-get update \
    && apt-get -y install curl make \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

USER gitpod

RUN cd /home/gitpod \
    && curl -L -O https://www.toppers.jp/download.cgi/athrill-target-rh850f1x-20200820.tar.gz \
    && tar xf athrill-target-rh850f1x-20200820.tar.gz \
    && rm athrill-target-rh850f1x-20200820.tar.gz

# athrill-gcc
RUN curl -L https://github.com/toppers/athrill-gcc-v850e2m/releases/download/v1.1/athrill-gcc-package.tar.gz -O \
    && tar xf athrill-gcc-package.tar.gz \
    && cd athrill-gcc-package \
    && tar xf athrill-gcc.tar.gz \
    && mv usr/local/athrill-gcc ${HAKONIWA_HOME} \
    && cd ../ \
    && rm -rf athrill-gcc-package \
    && rm athrill-gcc-package.tar.gz

# cfg
RUN curl -L -O https://github.com/mitsut/cfg/releases/download/1.9.7/cfg-1.9.7-x86_64-unknown-linux-gnu.tar.gz \
    && tar xf cfg-1.9.7-x86_64-unknown-linux-gnu.tar.gz -C ${HAKONIWA_HOME}/ \
    && rm cfg-1.9.7-x86_64-unknown-linux-gnu.tar.gz

ENV LD_LIBRARY_PATH="${ATHRILL_GCC}:${ATHRILL_GCC}/lib:${LD_LIBRARY_PATH}"

USER gitpod

RUN echo 'export PATH=${ATHRILL_GCC}/bin:${HAKONIWA_HOME}/athrill-target-rh850f1x/build_linux:$PATH' >>/home/gitpod/.bashrc
