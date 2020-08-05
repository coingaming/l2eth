# L2eth

Client libraries for Layer 2 technologies of Etherium

# Environment

Connext hub

```bash
git clone git@github.com:connext/indra.git

cd ./indra

# spawn Connext docker compose
make start

# check everything is running
make dls
```

Connext merchant

```bash
git clone git@github.com:connext/rest-api-client.git

cd ./rest-api-client

npm i

CONNEXT_NODE_URL='http://localhost:3000' \
  CONNEXT_ETH_PROVIDER_URL='http://localhost:8545' \
  CONNEXT_STORE_DIR='./merchant-store' \
  PORT='5040' \
  npm start
```

Connext customer

```bash
cd ./rest-api-client

CONNEXT_NODE_URL='http://localhost:3000' \
  CONNEXT_ETH_PROVIDER_URL='http://localhost:8545' \
  CONNEXT_STORE_DIR='./customer-store' \
  PORT='5041' \
  npm start
```

# Tests

```bash
stack test
```
