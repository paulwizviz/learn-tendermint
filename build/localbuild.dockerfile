ARG OS_VER
ARG GO_VER

FROM golang:${GO_VER}-alpine${OS_VER} as builder

ARG TMINT_VER

RUN apk update && \
    apk upgrade && \
    apk --no-cache add git make wget

WORKDIR /opt

RUN git clone --recursive --branch ${TMINT_VER} https://github.com/tendermint/tendermint.git && \
    cd tendermint && \
    make install && make build


FROM alpine:${OS_VER}

COPY --from=builder /opt/tendermint/build/tendermint /usr/local/bin/tendermint

# ENTRYPOINT [ "/usr/local/bin/tendermint" ]
