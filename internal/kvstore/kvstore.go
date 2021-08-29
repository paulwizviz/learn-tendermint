package kvstore

type KeyType []byte

func (k KeyType) ToString() string {
	return string(k)
}

type ValueType []byte

func (v ValueType) ToString() string {
	return string(v)
}

type Db interface {
	Insert(key KeyType, value ValueType) error
	GetValue(key string) []byte
	Close() error
}
