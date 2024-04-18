# Tendermint

Tendermint is a tool to help you spin up replicated application across multiple machine that is Byzantine Fault Tolerant (BFT). There are two major components: tendermint core (consensus engine) and Application BlockChain Interface (ABCI). For detailed description please refer to [what is tendermint?](https://docs.tendermint.com/v0.34/introduction/what-is-tendermint.html).

## Building node from source code

The tendermint source code is located in [github.com/tendermint/tendermint.git](https://github.com/tendermint/tendermint.git). It is also worth noting that the source code can also generate supporting tools.

The process to build tendermint from source is [here](../build/localbuild.dockerfile).

## Solo network

You will find a network with a solo node [here](../deployments/solo/docker-compose.yml).

To run the solo network follow this steps:

* STEP 1 - Build a solo docker image by running this command `./scripts/ops.sh image build`
* STEP 2 - Start the network by running this command `./scripts/ops.sh network solo start`

To learn what the tendermint node offer you can run the following commands:

* `curl -s localhost:26657/status` - return the status of the node
* Sending Transactions
    * `curl -s 'localhost:26657/broadcast_tx_commit?tx="abcd"'`
    * `curl -s 'localhost:26657/abci_query?data="abcd"'`
    * `curl -s 'localhost:26657/broadcast_tx_commit?tx="name=satoshi"'`
    * `curl -s 'localhost:26657/abci_query?data="name"'`

