# Haqq Network TestEdge-2
# update from v1.0.3 to v1.1.0 (block height 256200)
systemctl stop haqqd
cd $HOME && rm -rf haqq
git clone https://github.com/haqq-network/haqq && cd haqq
git checkout v1.1.0
make install
# checking the version
haqqd version --long | head
# if v1.1.0 - ok
systemctl restart haqqd && journalctl -u haqqd -f -o cat

# update from v1.1.0 to v1.2.0 (block height 355555)
systemctl stop haqqd
cd $HOME && rm -rf haqq
git clone https://github.com/haqq-network/haqq && cd haqq
git checkout v1.2.0
make install
# checking the version
haqqd version --long | head
# if v1.2.0 - ok
systemctl restart haqqd && journalctl -u haqqd -f -o cat
