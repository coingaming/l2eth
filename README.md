# l2eth

Client libraries for Layer 2 technologies of Etherium

# environment

Connext

```bash
git clone git@github.com:connext/indra.git

cd ./indra

# spawn Connext docker compose
make start

# check everything is running
make dls
```

Merchant

```bash
git clone git@github.com:connext/rest-api-client.git

cd ./rest-api-client

npm i

CONNEXT_NODE_URL='http://localhost:3000' \
  CONNEXT_ETH_PROVIDER_URL='http://localhost:8545' \
  PORT='5040' \
  npm start
```

Customer

```bash
CONNEXT_NODE_URL='http://localhost:3000' \
  CONNEXT_ETH_PROVIDER_URL='http://localhost:8545' \
  PORT='5041' \
  npm start
```

# tests

```bash
stack test
```
