# Tendermint



First, Tendermint and Cosmos or Cosmos SDK belongs to the same family of software tools. We won't elaborate on the differences between the tools. You can read the difference in [Tendermint & Cosmos SDK Demystified](https://medium.com/coinmonks/tendermint-cosmos-sdk-demystified-47385cf77cf6). For now, think of Tendermint as the basic building block of Cosmos. We'll discuss the features of Cosmos details in other section of this project.

Second, the term `tendermint` encompass several things, and these are:

* an open source Go based projects;
* a practical Byzantine Fault Tolerant (pBFT) consensus engine - i.e. the Tendermint Core;
* a library for the creation of Application Blockchain Interface (ABCI) applications.

These elements combined to help you developed replicated state machines or Layer 1 of a blockchain protocol.

## Tendermint Source Code

Tendermint's source code is located in [(https://github.com/tendermint/tendermint.git](https://github.com/tendermint/tendermint.git).

You use the source to generate:

* an orchestration tool named `tendermint` to manage a running `tendermint core`;
* a Go based packages (or libraries) to help you build `ABCI` application;
* an `ABCI-CLI` tool to help you debug ABCI applications.

## Tendermint Core

The tendermint core is an executable process comprise of these elements:

* a pBFT consensus engine;
* a P2P networking protocol;
* an JSON RPC protocol.

### The pBFT consensus engine

The pBFT consensus engine ensures that transactions sent to a network of nodes are recorded in the right order. 

The pBFT consensus algorithm is described in [what is tendermint?](https://docs.tendermint.com/v0.34/introduction/what-is-tendermint.html).

### The P2P protocol

The P2P protocol enable nodes hosting the tendermint core, is the basis for nodes to communicate with each other on a peer-to-peer basis.

### The JSON RPC protocol

The JSON RPC protocol enable client applications to communicate (i.e. send transactions) with the tendermint core.

## `ABCI` application

The ABCI application, not be confused with client applications is something you create to serve as a state machine. It is similar, but entirely, to a smart contract execution engine. The relationship between an ABCI application and tendermint core is summarised in Figure 1.

![Figure 1](../assets/img/tendermint-arch.png)<br>
<u>Figure 1: A Tendermint node</u>

An ABCI application interact with the tendermint core either as:

1. an integrated process with tendermint core.
1. a separate process.

### ABCI application modus operandi

Part of the ABCI application is a state engine. This could be in the form of a Key-Value store.

When a transaction is sent to tendermint core, the transaction is sent to ABCI application member function named `CheckTx`. This method is responsible for validating transactions -- i.e. you implement this logic.

When tendermint core initiate a block, it is transferred to the ABCI application member function named `BeginBlock` and this include logic to initiate the start of a state session in the state machine. The traction is then stored in the current session of state machine via the member function named `DeliverTx`. The `EndBlock` member function is called for one more check. At the `Commit` signal the block is committed. 

When a query operation is sent to tendermint core, the ABCI application member function `Query` is called.


### ABCI application integrated with tendermint core

You build this type of application using ABCI Go package [ABCI Go package](https://github.com/tendermint/tendermint/tree/v0.34.x/abci). Please refer to the [ABCI specification](https://github.com/tendermint/tendermint/tree/v0.34.x/spec/abci) for more information.

You will find an example of a native ABCI app [here](../cmd/tmint/ex1/main.go).

### ABCI application as a separate process

In this configuration, the ABCI application runs in a separate process. The application and tendermint core communicate via sockets.

You will find an example of a socket-base ABCI app [here](../cmd/tmint/ex2/main.go).

## Working networks

You will find a collection of networks for you to conduct experiments.

* Solo network
* Cluster network

### Solo network

The solo network has one running tendermint node in a setup intended for you to experiment. The node is based on docker image derived from this [dockerfile](../build/tendermint/ex.dockerfile). In the dockerfile an executable `tendermint` is derived from this [source code](https://github.com/tendermint/tendermint.git).

You will find a docker-compose network comprising a single node. The configuration is [here](../deployments/tmint/solo.yml).

To experiment with the network, use the scripts provided and run the following commands.

* `./scripts/tendermint.sh image build` to create the solo node.
* `./scripts/tendermint.sh solo start:ex` to activate the network.
* `./scripts/tendermint.sh solo stop:ex` to de-activate the network.

You will also find example scripts and application using [curl](../examples/tmint/curl/txn.sh) to simulate a client application. Use the client to:

* Get status of the solo node.
* Send a transaction.
* Query the node.

## Useful References

* [Tendermint Explained — Bringing BFT-based PoS to the Public Blockchain Domain](https://blog.cosmos.network/tendermint-explained-bringing-bft-based-pos-to-the-public-blockchain-domain-f22e274a0fdb)