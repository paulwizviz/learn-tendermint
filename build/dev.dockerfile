ARG OS_VER
ARG GO_VER

FROM golang:${GO_VER}-alpine${OS_VER}

ARG TMINT_VER

RUN apk update && \
    apk upgrade && \
    apk --no-cache add gcc g++ git make snappy-dev leveldb-dev bash

WORKDIR /opt

RUN git clone --recursive --branch ${TMINT_VER} https://github.com/tendermint/tendermint.git && \
    cd tendermint && \
    CGO_LDFLAGS="-lsnappy" make build TENDERMINT_BUILD_OPTIONS=cleveldb && \
    make install_abci


