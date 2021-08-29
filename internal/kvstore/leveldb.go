package kvstore

import "github.com/syndtr/goleveldb/leveldb"

type levelDB struct {
	store *leveldb.DB
}

func (l *levelDB) Insert(key KeyType, value ValueType) error {
	err := l.store.Put(key, value, nil)
	if err != nil {
		return err
	}
	return nil
}

func (l *levelDB) GetValue(key KeyType) (ValueType, error) {
	value, err := l.store.Get(key, nil)
	if err != nil {
		return nil, err
	}
	return value, nil
}

func (l *levelDB) Close() error {
	return l.store.Close()
}

func NewLevelDB(filename string) (*levelDB, error) {
	db, err := leveldb.OpenFile(filename, nil)
	if err != nil {
		return nil, err
	}
	return &levelDB{
		store: db,
	}, nil
}
