#!/bin/bash

WALLET=`xaya-cli -regtest getnewaddress "cymon"`
xaya-cli -regtest generatetoaddress 101 $WALLET
xaya-cli -rpcuser=user -rpcpassword=password -regtest name_register "p/cymon" "{}"
