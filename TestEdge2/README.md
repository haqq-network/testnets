# Haqq Network TestEdge2

## Overview

The current Haqq version of testedge2 is [`v1.7.4`](https://github.com/haqq-network/haqq/releases/tag/v1.7.3).


## Quickstart

Install packages:
```sh
sudo apt-get install curl git make gcc liblz4-tool build-essential jq bzip2 -y
```

**Preresquisites for compile from source**
- `make` & `gcc` 
- `Go 1.21+` ([How to install Go](https://www.digitalocean.com/community/tutorials/how-to-install-go-on-ubuntu-20-04))

Easy Go compiler installation:
```sh
bash <(curl -s https://raw.githubusercontent.com/haqq-network/mainnet/master/install_go.sh) && \
source $HOME/.bash_profile
```

### Haqq node binary
Download latest Haqq binary for your arch: </br>
https://github.com/haqq-network/haqq/releases/tag/v1.7.4

Or build haqq binary from source:
```sh
cd $HOME
git clone -b v1.7.4 https://github.com/haqq-network/haqq
cd haqq
make install
```

### Run by Tendermint State Sync
Check binary version:
```sh
haqq@haqq-node:~# haqqd -v
haqqd version "1.7.3" b531ad3a9d86df47f28e5e6da133cea5c66a8d03
```

```sh
export CUSTOM_MONIKER="haqq_node_testedge2"
export HAQQD_FOLDER="$HOME/.haqqd"

haqqd config chain-id haqq_54211-3 && \
haqqd init CUSTOM_MONIKER --chain-id haqq_54211-3

# Prepare genesis file for TestEdge(haqq_54211-3)
curl -OL https://raw.githubusercontent.com/haqq-network/testnets/main/TestEdge2/genesis.tar.bz2 &&\
bzip2 -d genesis.tar.bz2 && tar -xvf genesis.tar &&\
mv genesis.json $HAQQD_FOLDER/config/genesis.json

# Prepare addrbook
curl -OL https://raw.githubusercontent.com/haqq-network/testnets/main/TestEdge2/addrbook.json &&\
mv addrbook.json $HAQQD_FOLDER/config/addrbook.json

# Configure State sync
curl -OL https://raw.githubusercontent.com/haqq-network/testnets/main/TestEdge2/state_sync.sh &&\
sh state_sync.sh $HAQQD_FOLDER

# Start Haqq
haqqd start
```

### Run with Docker

```
### ENV’s and storage folder
export CUSTOM_MONIKER="testnet_seed_node"
export HAQQD_DIR="$HOME/haqqd_test"
export HAQQD_VERSION="v1.7.4"
mkdir $HAQQD_DIR && chmod 777 $HAQQD_DIR

### Check
docker run -it --rm \
-v $HAQQD_DIR:/home/haqq/.haqqd \
alhaqq/haqq:$HAQQD_VERSION \
haqqd -v

### Init
docker run -it --rm \
-v $HAQQD_DIR:/home/haqq/.haqqd \
alhaqq/haqq:$HAQQD_VERSION \
haqqd config chain-id haqq_54211-3

docker run -it --rm \
-v $HAQQD_DIR:/home/haqq/.haqqd \
alhaqq/haqq:$HAQQD_VERSION \
haqqd init $CUSTOM_MONIKER --chain-id haqq_54211-3

### Setup
curl -OL https://raw.githubusercontent.com/haqq-network/testnets/main/TestEdge2/genesis.tar.bz2 &&\
bzip2 -d genesis.tar.bz2 && tar -xvf genesis.tar &&\
mv genesis.json $HAQQD_DIR/config/genesis.json &&\ 
curl -OL https://raw.githubusercontent.com/haqq-network/testnets/main/TestEdge2/addrbook.json &&\
mv addrbook.json $HAQQD_DIR/config/addrbook.json && \
curl -OL https://raw.githubusercontent.com/haqq-network/testnets/main/TestEdge2/state_sync.sh &&\
sh state_sync.sh $HAQQD_DIR

### Start
docker run -it \
--network host \
-v $HAQQD_DIR:/home/haqq/.haqqd \
alhaqq/haqq:$HAQQD_VERSION \
haqqd start
```

## Upgrade to Validator Node
You now have an active full node. What's the next step? You can upgrade your full node to become a Haqq Validator. Continue onto the [Validator Setup](https://docs.haqq.network/guides/validators/setup.html).
