#!/bin/sh

set -m

#
# go-ethereum
#

#geth --config=/app/.go-ethereum/config.toml --nousb init /app/.go-ethereum/genesis.json
#nohup geth --config=/app/.go-ethereum/config.toml --nousb --mine --miner.threads=1 2> /app/.go-ethereum/geth.log &

#
# env
#

export PATH=$PATH:/bin/
export PGDATA=$PWD/postgres
export PGHOST=/tmp/postgres
export PGLOG=$PWD/postgres/LOG
export PGDATABASE=postgres
export DATABASE_URL="postgresql:///postgres?host=$PGHOST"

#
# Postgres
#

if [[ $EUID -ne 0 ]]; then
    alias postgres-sh="sh"
else
    alias postgres-sh="su -m nixbld1"
fi

if [ ! -d $PGHOST ]; then
  echo 'initializing postgresql workspace...'
  postgres-sh -c "mkdir -p $PGHOST"
fi
if [ ! -d $PGDATA ]; then
  echo 'initializing postgresql database...'
  postgres-sh -c "mkdir -p $PGDATA"
  postgres-sh -c 'initdb $PGDATA --encoding=UTF8 --auth=trust >/dev/null'
fi

echo "starting postgres..."
postgres-sh -c 'pg_ctl start -o "-c listen_addresses=localhost -c unix_socket_directories=$PGHOST"'

# NOTE : some Postgres bullshit - it crashes if createdb is executed too soon
echo "sleeping for 3s to prevent postgres/createdb race condition..."
sleep 3

postgres-sh -c 'createdb l2eth'
echo "spawn-test-deps executed"
