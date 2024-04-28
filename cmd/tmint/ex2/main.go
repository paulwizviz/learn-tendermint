package main

import (
	"flag"
	"fmt"
	"os"
	"os/signal"
	"syscall"

	"github.com/dgraph-io/badger"
	"github.com/tendermint/tendermint/abci/server"
	"github.com/tendermint/tendermint/abci/types"
	"github.com/tendermint/tendermint/libs/log"
)

type App struct {
	db           *badger.DB
	currentBatch *badger.Txn
}

func NewApp(db *badger.DB) *App {
	return &App{
		db: db,
	}
}

func (App) Info(req types.RequestInfo) types.ResponseInfo {
	fmt.Println(req)
	return types.ResponseInfo{}
}

func (App) SetOption(req types.RequestSetOption) types.ResponseSetOption {
	fmt.Println(req)
	return types.ResponseSetOption{}
}

func (App) DeliverTx(req types.RequestDeliverTx) types.ResponseDeliverTx {
	fmt.Println(req)
	return types.ResponseDeliverTx{Code: 0}
}

func (App) CheckTx(req types.RequestCheckTx) types.ResponseCheckTx {
	fmt.Println(req)
	return types.ResponseCheckTx{Code: 0}
}

func (App) Commit() types.ResponseCommit {
	fmt.Println("--Commit--")
	return types.ResponseCommit{}
}

func (App) Query(req types.RequestQuery) types.ResponseQuery {
	fmt.Println(req)
	return types.ResponseQuery{Code: 0}
}

func (App) InitChain(req types.RequestInitChain) types.ResponseInitChain {
	fmt.Println(req)
	return types.ResponseInitChain{}
}

func (a *App) BeginBlock(req types.RequestBeginBlock) types.ResponseBeginBlock {
	a.currentBatch = a.db.NewTransaction(true) // Starts a DB session
	return types.ResponseBeginBlock{}
}

func (App) EndBlock(req types.RequestEndBlock) types.ResponseEndBlock {
	fmt.Println(req)
	return types.ResponseEndBlock{}
}

func (App) ListSnapshots(req types.RequestListSnapshots) types.ResponseListSnapshots {
	fmt.Println(req)
	return types.ResponseListSnapshots{}
}

func (App) OfferSnapshot(req types.RequestOfferSnapshot) types.ResponseOfferSnapshot {
	fmt.Println(req)
	return types.ResponseOfferSnapshot{}
}

func (App) LoadSnapshotChunk(req types.RequestLoadSnapshotChunk) types.ResponseLoadSnapshotChunk {
	fmt.Println(req)
	return types.ResponseLoadSnapshotChunk{}
}

func (App) ApplySnapshotChunk(req types.RequestApplySnapshotChunk) types.ResponseApplySnapshotChunk {
	fmt.Println(req)
	return types.ResponseApplySnapshotChunk{}
}

var socketAddr string

func main() {

	flag.StringVar(&socketAddr, "socket", "/var/abci/ex2.socket", "Socket address")
	flag.Parse()

	logger := log.NewTMLogger(log.NewSyncWriter(os.Stdout))

	db, err := badger.Open(badger.DefaultOptions("/tmp/badger"))
	if err != nil {
		fmt.Fprintf(os.Stderr, "failed to open badger db: %v", err)
		os.Exit(1)
	}
	defer db.Close()

	app := NewApp(db)

	flag.Parse()

	logger.Info("ABCI Ex2 started..")

	s := server.NewSocketServer(socketAddr, app)
	s.SetLogger(logger)
	if err := s.Start(); err != nil {
		fmt.Fprintf(os.Stderr, "error starting socket server: %v", err)
		os.Exit(1)
	}
	defer s.Stop()

	c := make(chan os.Signal, 1)
	signal.Notify(c, os.Interrupt, syscall.SIGTERM)
	<-c
	os.Exit(0)
}
