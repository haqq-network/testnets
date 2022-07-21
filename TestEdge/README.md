# Join to TestEdge

To quickly get started, node operators can choose to sync via State Sync or by downloading a snapshot

Install packages:
```sh
sudo apt-get install wget liblz4-tool -y
```

Download latest binary for your arch:
https://github.com/haqq-network/haqq/releases/tag/v1.0.3 or build from source 
```sh
cd $HOME
git clone -b v1.0.3 https://github.com/haqq-network/haqq
cd haqq
make install
```

## StateSync
```sh
CUSTOM_MONIKER="example_moniker"

haqqd config chain-id haqq_53211-1 && \
haqqd init CUSTOM_MONIKER --chain-id haqq_53211-1

# Prepare genesis file for TestEdge(haqq_53211-1)
wget -O genesis.json https://storage.googleapis.com/haqq-testedge-snapshots/genesis.json
mv genesis.json $HOME/.haqqd/config/genesis.json

# Configure State sync
sh state_sync.sh

# Start Haqq
haqqd start --x-crisis-skip-assert-invariants
```

## Run from snapshot

Download the snapshot:
```sh
wget -O haqq_149008.tar.lz4 https://storage.googleapis.com/haqq-testedge-snapshots/haqq_149008.tar.lz4

```

```sh
CUSTOM_MONIKER="example_moniker"

haqqd config chain-id haqq_53211-1 && \
haqqd init CUSTOM_MONIKER --chain-id haqq_53211-1

# Prepare genesis file for TestEdge(haqq_53211-1)
wget -O genesis.json https://storage.googleapis.com/haqq-testedge-snapshots/genesis.json
mv genesis.json $HOME/.haqqd/config/genesis.json

# Unzip snapshot to data
lz4 -c -d haqq_149008.tar.lz4 | tar -x -C $HOME/.haqqd/data

# Setup seeds
SEEDS="899eb370da6930cf0bfe01478c82548bb7c71460@34.90.233.163:26656,f2a78c20d5bb567dd05d525b76324a45b5b7aa28@34.90.227.10:26656,4705cf12fb56d7f9eb7144937c9f1b1d8c7b6a4a@34.91.195.139:26656,8f7b0add0523ec3648cb48bc12ac35357b1a73ae@195.201.123.87:26656"

sed -i.bak -E "s|^(seeds[[:space:]]+=[[:space:]]+).*$|\1\"$SEEDS\"|" $HOME/.haqqd/config/config.toml

# Start Haqq
haqqd start --x-crisis-skip-assert-invariants
```
