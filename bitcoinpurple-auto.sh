#!/bin/bash

sudo apt-get update && sudo apt-get upgrade -y

sudo apt-get install libxcb-xinerama0 -y

cd $HOME

wget "https://dl.walletbuilders.com/download?customer=892645b852d705d7b4dfc41a08a06c8d02c80b8a4553f8e495&filename=bitcoinpurple-qt-linux.tar.gz" -O bitcoinpurple-qt-linux.tar.gz

mkdir $HOME/Desktop/BitcoinPurple

tar -xzvf bitcoinpurple-qt-linux.tar.gz --directory $HOME/Desktop/BitcoinPurple

mkdir $HOME/.bitcoinpurple

cat << EOF > $HOME/.bitcoinpurple/bitcoinpurple.conf
rpcuser=rpc_bitcoinpurple
rpcpassword=dR2oBQ3K1zYMZQtJFZeAerhWxaJ5Lqeq9J2
rpcbind=127.0.0.1
rpcallowip=127.0.0.1
listen=1
server=1
addnode=node3.walletbuilders.com
EOF

cat << EOF > $HOME/Desktop/BitcoinPurple/start_wallet.sh
#!/bin/bash
SCRIPT_PATH=\`pwd\`;
cd \$SCRIPT_PATH
./bitcoinpurple-qt
EOF

chmod +x $HOME/Desktop/BitcoinPurple/start_wallet.sh

cat << EOF > $HOME/Desktop/BitcoinPurple/mine.sh
#!/bin/bash
SCRIPT_PATH=\`pwd\`;
cd \$SCRIPT_PATH
while :
do
./bitcoinpurple-cli generatetoaddress 1 \$(./bitcoinpurple-cli getnewaddress)
done
EOF

chmod +x $HOME/Desktop/BitcoinPurple/mine.sh
    
exec $HOME/Desktop/BitcoinPurple/bitcoinpurple-qt &

sleep 15

exec $HOME/Desktop/BitcoinPurple/bitcoinpurple-cli -named createwallet wallet_name="" &
    
sleep 15

cd $HOME/Desktop/BitcoinPurple/

clear

exec $HOME/Desktop/BitcoinPurple/mine.sh