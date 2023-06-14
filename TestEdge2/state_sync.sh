#!/bin/bash

SNAP_RPC1="https://rpc.tm.testedge2.haqq.network:443"
SNAP_RPC2="https://te2-s1-tm.haqq.sh:443"

# Select one available SNAP_RPC
if curl --output /dev/null --silent --head --fail "$SNAP_RPC1"; then
  echo "[INFO] SNAP_RPC1 ($SNAP_RPC1) is available and selected for requests"
  SNAP_RPC=$SNAP_RPC1
elif curl --output /dev/null --silent --head --fail "$SNAP_RPC2"; then
  echo "[INFO] SNAP_RPC2 ($SNAP_RPC2) is available and selected for requests"
  SNAP_RPC=$SNAP_RPC2
else
  echo "[ERROR] Both SNAP_RPC1 and SNAP_RPC2 are not available. Exiting..."
  exit 1
fi

echo "[INFO] Fetching latest block height and calculating trust height..."

LATEST_HEIGHT=$(curl -s $SNAP_RPC/block | jq -r .result.block.header.height)
BLOCK_HEIGHT=$((LATEST_HEIGHT - 2000))
TRUST_HASH=$(curl -s "$SNAP_RPC/block?height=$BLOCK_HEIGHT" | jq -r .result.block_id.hash)

echo "[INFO] Latest block height: $LATEST_HEIGHT, trust height: $BLOCK_HEIGHT"
echo "[INFO] Trust hash: $TRUST_HASH"

# persistent_peers
P_PEERS=""

# seed nodes
SEEDS="62bf004201a90ce00df6f69390378c3d90f6dd7e@seed2.testedge2.haqq.network:26656,23a1176c9911eac442d6d1bf15f92eeabb3981d5@seed1.testedge2.haqq.network:26656,96cd4df06277f3353fa2da1f73d8e21663183c3f@91.107.192.98:26656"

echo "[INFO] Starting configuration changes..."

sed -i.bak -E "s|^(enable[[:space:]]+=[[:space:]]+).*$|\1true| ; \
s|^(rpc_servers[[:space:]]+=[[:space:]]+).*$|\1\"$SNAP_RPC\"| ; \
s|^(trust_height[[:space:]]+=[[:space:]]+).*$|\1$BLOCK_HEIGHT| ; \
s|^(trust_hash[[:space:]]+=[[:space:]]+).*$|\1\"$TRUST_HASH\"| ; \
s|^(persistent_peers[[:space:]]+=[[:space:]]+).*$|\1\"$P_PEERS\"| ; \
s|^(seeds[[:space:]]+=[[:space:]]+).*$|\1\"$SEEDS\"|" $HOME/.haqqd/config/config.toml

echo "[SUCCESS] StateSync configuration completed."
