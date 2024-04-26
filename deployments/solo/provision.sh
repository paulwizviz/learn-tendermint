#!/bin/sh

tendermint init validator
#tendermint start --proxy_app=kvstore --rpc.laddr=tcp://0.0.0.0:26657 --consensus.create_empty_blocks=false --db_backend=cleveldb --log_level=debug
#tendermint start
ex1