#!/bin/bash
WALLET=/tmp/miner.wallet

while [ true ]
do
    if [ -n "$XAYA_REGTEST" ]; then
        if [ -f "$WALLET" ]; then
            WALLETID=$(cat "$WALLET") 
            if [ -z "$WALLETID" ]; then
                echo "Wallet creation went wrong"
                rm $WALLET
            else
                echo "Wallet is $WALLETID"
                xaya-cli -regtest generatetoaddress 1 $WALLETID
            fi
        else 
            echo "Creating wallet..."
            xaya-cli -regtest getnewaddress "miner" > $WALLET
        fi
    fi
    sleep 15
done
