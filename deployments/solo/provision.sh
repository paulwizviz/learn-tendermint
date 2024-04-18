#!/bin/sh

tendermint init validator

tendermint start --proxy-app=kvstore --rpc.laddr=tcp://0.0.0.0:26657  --db-backend=cleveldb