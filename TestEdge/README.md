# Haqq Network TestEdge

## Overview

The current Haqq version of testedge is [`v1.0.3`](https://github.com/haqq-network/haqq/releases/tag/v1.0.3). To bootstrap a testedge node, it is possible to sync from v1.0.3 via snapshot or via State Sync.


## Quickstart

Install packages:
```sh
sudo apt-get install curl git make gcc liblz4-tool build-essential jq -y
```

**Preresquisites for compile from source**
- `make` & `gcc` 
- `Go 1.16+` ([How to install Go](https://www.digitalocean.com/community/tutorials/how-to-install-go-on-ubuntu-20-04))

**If you chose option 1 or 2 for run node then you need to download or build from souce**

Download latest binary for your arch: </br>
https://github.com/haqq-network/haqq/releases/tag/v1.0.3

Build from source:
```sh
cd $HOME
git clone -b v1.0.3 https://github.com/haqq-network/haqq
cd haqq
make install
```

### **Option 1**: Run by Tendermint State Sync (preferred)
Check binary version:
```sh
haqq@haqq-node:~# haqqd -v
haqqd version "1.0.3" 58215364d5be4c9ab2b17b2a80cf89f10f6de38a
```

```sh
CUSTOM_MONIKER="example_moniker"

haqqd config chain-id haqq_53211-1 && \
haqqd init CUSTOM_MONIKER --chain-id haqq_53211-1

# Prepare genesis file for TestEdge(haqq_53211-1)
curl -OL https://storage.googleapis.com/haqq-testedge-snapshots/genesis.json
mv genesis.json $HOME/.haqqd/config/genesis.json

# Configure State sync
curl -OL https://raw.githubusercontent.com/haqq-network/testnets/main/TestEdge/state_sync.sh
sh state_sync.sh

# Start Haqq
haqqd start --x-crisis-skip-assert-invariants
```

### **Option 2**: Run from snapshot

Check binary version:
```sh
haqq@haqq-node:~# haqqd -v
haqqd version "1.0.3" 58215364d5be4c9ab2b17b2a80cf89f10f6de38a
```

Download the snapshot:
```sh
curl -OL https://storage.googleapis.com/haqq-testedge-snapshots/haqq_256222.tar.lz4
```

```sh
CUSTOM_MONIKER="example_moniker"

haqqd config chain-id haqq_53211-1 && \
haqqd init CUSTOM_MONIKER --chain-id haqq_53211-1

# Prepare genesis file for TestEdge(haqq_53211-1)
curl -OL https://storage.googleapis.com/haqq-testedge-snapshots/genesis.json && \
mv genesis.json $HOME/.haqqd/config/genesis.json

# Unzip snapshot to data
lz4 -c -d haqq_167797.tar.lz4 | tar -x -C $HOME/.haqqd/data

# Setup seeds
SEEDS="8f7b0add0523ec3648cb48bc12ac35357b1a73ae@195.201.123.87:26656,899eb370da6930cf0bfe01478c82548bb7c71460@34.90.233.163:26656,f2a78c20d5bb567dd05d525b76324a45b5b7aa28@34.90.227.10:26656,4705cf12fb56d7f9eb7144937c9f1b1d8c7b6a4a@34.91.195.139:26656"

sed -i.bak -E "s|^(seeds[[:space:]]+=[[:space:]]+).*$|\1\"$SEEDS\"|" $HOME/.haqqd/config/config.toml

# Start Haqq
haqqd start --x-crisis-skip-assert-invariants
```

### **Option 3**: Run with sync from scratch
The main problem of synchronization from scratch is that we need to consistently change the version of the binary.
Currently we need upgrades binary by this pipepline:
v1.0.1 -> v1.0.2 -> v1.0.3

Download binary v1.0.1 for your arch:
https://github.com/haqq-network/haqq/releases/tag/v1.0.1 or build from source 
```sh
cd $HOME
git clone -b v1.0.1 https://github.com/haqq-network/haqq
cd haqq
make install
```

Check binary version:
```sh
haqq@haqq-node:~# haqqd -v
haqqd version "1.0.1" dfefefccac6c590b6b42fd32dfb03810467ff9dd
```

Start from v1.0.1:
```sh
CUSTOM_MONIKER="example_moniker"

haqqd config chain-id haqq_53211-1 && \
haqqd init CUSTOM_MONIKER --chain-id haqq_53211-1

# Prepare genesis file for TestEdge(haqq_53211-1)
curl -OL https://storage.googleapis.com/haqq-testedge-snapshots/genesis.json && \
mv genesis.json $HOME/.haqqd/config/genesis.json

# Setup seeds
SEEDS="8f7b0add0523ec3648cb48bc12ac35357b1a73ae@195.201.123.87:26656,899eb370da6930cf0bfe01478c82548bb7c71460@34.90.233.163:26656,f2a78c20d5bb567dd05d525b76324a45b5b7aa28@34.90.227.10:26656,4705cf12fb56d7f9eb7144937c9f1b1d8c7b6a4a@34.91.195.139:26656"

sed -i.bak -E "s|^(seeds[[:space:]]+=[[:space:]]+).*$|\1\"$SEEDS\"|" $HOME/.haqqd/config/config.toml

# Start Haqq
haqqd start --x-crisis-skip-assert-invariants
```

Now wait until the chain reaches block height 1143. It will panic and log the following:
```
panic: UPGRADE "v1.0.2" NEEDED at height: 1143
```

It's now time to perform the manual upgrade to `v1.0.2`:
```sh
git checkout v1.0.2 && \
make install && \
haqqd start --x-crisis-skip-assert-invariants
```

Now wait until the chain reaches block height 1928. It will panic and log the following:
```
panic: UPGRADE "v1.0.3" NEEDED at height: 1928
```

It's now time to perform the manual upgrade to `v1.0.3`:
```sh
git checkout v1.0.3 && \
make install && \
haqqd start --x-crisis-skip-assert-invariants
```

## Upgrade to Validator Node
You now have an active full node. What's the next step? You can upgrade your full node to become a Haqq Validator. The top 100 validators have the ability to propose new blocks to the Haqq Network. Continue onto the [Validator Setup](https://docs.haqq.network/guides/validators/setup.html).
