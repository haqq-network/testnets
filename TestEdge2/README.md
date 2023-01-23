# Haqq Network TestEdge2

## Overview

The current Haqq version of testedge2 is [`v1.3.0`](https://github.com/haqq-network/haqq/releases/tag/v1.3.0).


## Quickstart

Install packages:
```sh
sudo apt-get install curl git make gcc liblz4-tool build-essential jq bzip2 -y
```

**Preresquisites for compile from source**
- `make` & `gcc` 
- `Go 1.19+` ([How to install Go](https://www.digitalocean.com/community/tutorials/how-to-install-go-on-ubuntu-20-04))

Download latest binary for your arch: </br>
https://github.com/haqq-network/haqq/releases/tag/v1.3.0

Build from source:
```sh
cd $HOME
git clone -b v1.3.0 https://github.com/haqq-network/haqq
cd haqq
make install
```

### Run by Tendermint State Sync
Check binary version:
```sh
haqq@haqq-node:~# haqqd -v
haqqd version "1.3.0" 39b4dcb706e72c187fc23ec6dddcfed20c79bc9d
```

```sh
CUSTOM_MONIKER="haqq_node_testedge2"

haqqd config chain-id haqq_54211-3 && \
haqqd init CUSTOM_MONIKER --chain-id haqq_54211-3

# Prepare genesis file for TestEdge(haqq_54211-3)
curl -OL https://raw.githubusercontent.com/haqq-network/testnets/main/TestEdge2/genesis.tar.bz2 &&\
bzip2 -d genesis.tar.bz2 && tar -xvf genesis.tar &&\
mv genesis.json $HOME/.haqqd/config/genesis.json

# Configure State sync
curl -OL https://raw.githubusercontent.com/haqq-network/testnets/main/TestEdge2/state_sync.sh &&\
sh state_sync.sh

# Start Haqq
haqqd start --x-crisis-skip-assert-invariants
```

## Upgrade to Validator Node
You now have an active full node. What's the next step? You can upgrade your full node to become a Haqq Validator. The top 150 validators have the ability to propose new blocks to the Haqq Network. Continue onto the [Validator Setup](https://docs.haqq.network/guides/validators/setup.html).
