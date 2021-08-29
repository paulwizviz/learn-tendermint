FROM ubuntu:18.04 as builder

ENV GOROOT=/usr/local/go 
ENV GOPATH=/opt/gopath
ENV PATH=$GOPATH/bin:$GOROOT/bin:$PATH

RUN apt -y update && \
    apt -y upgrade && \
    apt -y install git && \
    apt -y install make && \
    apt -y install wget

WORKDIR /opt

RUN wget https://dl.google.com/go/go1.16.4.linux-amd64.tar.gz && \
    tar -xvf go1.16.4.linux-amd64.tar.gz && \
    mv go /usr/local && \
    rm -f go1.16.4.linux-amd64.tar.gz

RUN git clone https://github.com/tendermint/tendermint.git && \
    cd tendermint && \
    make install && make build

FROM ubuntu:18.04

COPY --from=builder /opt/tendermint/build/tendermint /usr/local/bin/tendermint
