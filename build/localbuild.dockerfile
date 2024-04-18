ARG OS_VER
ARG GO_VER

FROM golang:${GO_VER}-alpine${OS_VER} as builder

ARG TMINT_VER

RUN apk update && \
    apk upgrade && \
    apk --no-cache add gcc g++ git make wget snappy-dev leveldb-dev

WORKDIR /opt

RUN git clone --recursive --branch ${TMINT_VER} https://github.com/tendermint/tendermint.git && \
    cd tendermint && \
    CGO_LDFLAGS="-lsnappy" make build TENDERMINT_BUILD_OPTIONS=cleveldb


FROM alpine:${OS_VER}

COPY --from=builder /opt/tendermint/build/tendermint /usr/local/bin/tendermint

RUN apk update && \
    apk upgrade && \
    apk --no-cache add snappy leveldb

