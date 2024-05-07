ARG OS_VER
ARG BASE_IMAGE

FROM ${BASE_IMAGE}

RUN tendermint init

ENTRYPOINT ["tendermint"]
CMD [ "node", "--proxy_app=kvstore", "--rpc.laddr=tcp://0.0.0.0:26657", "--p2p.laddr=tcp://0.0.0.0:26656", "--rpc.pprof_laddr=:6060"]