# Haqq Network TestEdge2

## Overview

The current Haqq version of testedge2 is [`v1.4.0`](https://github.com/haqq-network/haqq/releases/tag/v1.4.0).


## Quickstart

Install packages:
```sh
sudo apt-get install curl git make gcc liblz4-tool build-essential jq bzip2 -y
```

**Preresquisites for compile from source**
- `make` & `gcc` 
- `Go 1.19+` ([How to install Go](https://www.digitalocean.com/community/tutorials/how-to-install-go-on-ubuntu-20-04))

Easy Go compiler installation:
```sh
bash <(curl -s https://raw.githubusercontent.com/haqq-network/mainnet/master/install_go.sh) && \
source $HOME/.bash_profile
```

### Haqq node binary
Download latest Haqq binary for your arch: </br>
https://github.com/haqq-network/haqq/releases/tag/v1.4.0

Or build haqq binary from source:
```sh
cd $HOME
git clone -b v1.4.0 https://github.com/haqq-network/haqq
cd haqq
make install
```

### Run by Tendermint State Sync
Check binary version:
```sh
haqq@haqq-node:~# haqqd -v
haqqd version "1.4.0" 4f16bbfc188b66ae44b559453c43bff78f85b6d4
```

```sh
CUSTOM_MONIKER="haqq_node_testedge2"

haqqd config chain-id haqq_54211-3 && \
haqqd init CUSTOM_MONIKER --chain-id haqq_54211-3

# Prepare genesis file for TestEdge(haqq_54211-3)
curl -OL https://raw.githubusercontent.com/haqq-network/testnets/main/TestEdge2/genesis.tar.bz2 &&\
bzip2 -d genesis.tar.bz2 && tar -xvf genesis.tar &&\
mv genesis.json $HOME/.haqqd/config/genesis.json

# Prepare addrbook
curl -OL https://raw.githubusercontent.com/haqq-network/testnets/main/TestEdge2/addrbook.json &&\
mv addrbook.json $HOME/.haqqd/config/addrbook.json

# Configure State sync
curl -OL https://raw.githubusercontent.com/haqq-network/testnets/main/TestEdge2/state_sync.sh &&\
sh state_sync.sh

# Start Haqq
haqqd start --x-crisis-skip-assert-invariants
```

## Upgrade to Validator Node
You now have an active full node. What's the next step? You can upgrade your full node to become a Haqq Validator. The top 150 validators have the ability to propose new blocks to the Haqq Network. Continue onto the [Validator Setup](https://docs.haqq.network/guides/validators/setup.html).
