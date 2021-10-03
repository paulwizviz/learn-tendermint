FROM golang:1.17-alpine as builder

RUN apk update && \
    apk upgrade && \
    apk --no-cache add git make wget

WORKDIR /opt

RUN git clone https://github.com/tendermint/tendermint.git && \
    cd tendermint && \
    make install && make build
