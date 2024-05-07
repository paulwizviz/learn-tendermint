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

The ABCI application, not be confused with client applications is something you create to serve as a state machine. An ABCI application interact with the tendermint core either as:

* an integrated process with tendermint core.
* a separate process.

### ABCI application modus operandi

The ABCI application is the state machine where you implement a number of interfaces. Please refer to [official specification](https://github.com/tendermint/spec/tree/95cf253b6df623066ff7cd4074a94e7a3f147c7a/spec/abci) For current discussion, we focus on these:

* `CheckTx`
* `BeginBlock`
* `DeliverTx`
* `EndBlock`
* `Commit`

To mutate the ABCI application, you sent a transaction like this: `<URL root>/broadcast_tx_commit?tx="name=satoshi"` -- e.g. using curl. Please refer to the [official transaction format](https://docs.tendermint.com/v0.34/rpc/)

When a transaction is sent to tendermint core, it calls the ABCI application `CheckTx`. You implement this function to validate transactions -- e.g. validate transaction signature, etc.

When tendermint core initiate a block, it calls ABCI application member function named `BeginBlock`. You implement this interface to initiate the start of a state session. 

On completion of the `BeginBlock`, the core calls the function named `DeliverTx`. On completion of that function the core calls `EndBlock` for one more check. Thereafter the `Commit` is called and the state machine is committed. 

When a query transaction (e.g. `/abci_query?data="name"`) is sent to tendermint core, the ABCI application member function `Query` is called.

### ABCI application integrated with tendermint core

You build this type of application using ABCI Go package [ABCI Go package](https://github.com/tendermint/tendermint/tree/v0.34.x/abci). Please refer to the [ABCI specification](https://github.com/tendermint/tendermint/tree/v0.34.x/spec/abci) for more information. The relationship between ABCI application and Tendermint core (see Figure 1).

![Figure 1](../assets/img/tmint-native-abci.png)</br>
<b>Figure 1:</b> ABCI application package as a single executable with tendermint core.

You will find an example of a native ABCI app [here](../cmd/tmint/ex1/main.go).

### ABCI application as a separate process

In this configuration, the ABCI application runs in a separate process. The application and tendermint core communicate via sockets (see Figure 2).

![Figure 2](../assets/img/tmint-socket-abci.png)</br>
<b>Figure 2:</b> Socket based ABCI application

You will find an example of a socket-base ABCI app [here](../cmd/tmint/ex2/main.go).

## Docker Images

To support a series of working examples we have provided mechanism to build two Docker images:

* Base image
* Solo image

The base image provides installed version of tendermint core. The specification of the image is [here](../build/tmint/base.dockerfile).

The [solo image](../build/tmint/solo.dockerfile) is derived from base image and it provides installed version of the following `ABCI` applications:

* [Ex1](../cmd/tmint/ex1/main.go) - This is a native version of `ABCI` application.
* [Ex2](../cmd/tmint/ex2/main.go) - This is a socket based version of `ABCI` application.

To build the image use the script [./scripts/tendermint.sh](../scripts/tendermint.sh), run the command `./scripts/tendermint.sh image build` to build all images or `build:base` or `build:solo` for base or solo images respectively. 

## Tendermint Networking Examples

* [Solo Ex1](../deployments/tmint/solo_ex1.yml) - This network has one Solo container `ex1_node` embedded with `Ex1` application.
* [Solo Ex2](../deployments/tmint/solo_ex2.yml) - This network has two Solo containers `ex2_1` and `ex2_2` embedded with `EX2` application.

To start and stop network use the script `./scripts/tendermint.sh solo:ex1 start` or `./scripts/tendermint.sh solo:ex2 start` to active the respective network. 

A set of example calls can be found [here](../examples/tmint/curl/txn.sh).

## Useful References

* [Tendermint Explained — Bringing BFT-based PoS to the Public Blockchain Domain](https://blog.cosmos.network/tendermint-explained-bringing-bft-based-pos-to-the-public-blockchain-domain-f22e274a0fdb)
* [Tendermint Core EXPLAINED (Algorithm & History)](https://www.youtube.com/watch?v=kTczTT9DlP8)
* [Revisiting Tendermint: Design Tradeoffs, Accountability, and Practical Use](https://www.youtube.com/watch?v=UCuNBukWfAM)
* Tendermint Demo
    * [Tendermint Tutorial Demo - Part 1](https://www.youtube.com/watch?v=pVMFMiZGunw)
    * [Tendermint Tutorial Demo - Part 2](https://www.youtube.com/watch?v=wko5DPM-9Gs)