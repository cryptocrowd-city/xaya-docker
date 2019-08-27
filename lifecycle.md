Ciclo di vita di una "mossa" (xaya ad-hoc notifications)
===

1 - Il gioco, nel momento in cui nasce, si registra nei giochi tracciati

´xaya-cli trackedgames add HelloWorld

2 - Una mossa viene eseguita da un client RPC verso il nodo xaya

`xaya-cli -rpcuser=user -rpcpassword=password -regtest name_update "p/cymon" "{\"g\":{\"helloworld\":{\"m\":\"Hello\"}}}`

3 - Mediante mining il blocco viene aggiunto alla blockchain
 
4 - Il nodo notifica la mossa mediante una notifica ad hoc game-block-attach che riporta come payload un JSON coi dettagli della mossa

```
Topic: game-block-attach json Hello
Payload: {"block":{"hash":"0cbb307d082c3b1804b265b71e27e061e6b5436afedc53c13d03221421f53c97","parent":"99265ac4578d9f2affcdb5dfb25bc5585f2806494383690fd2f6596552e30a23","height":106,"timestamp":1566827264,"rngseed":"0feedc8ffaf74646ccc4ba6eece2b4d191e05714c617d6c2be572260abe1f266"},"moves":[{"txid":"6b996f6d8cffab3977611a9456903ec71324b5734dbf7707b8eca5e931642e01","name":"cymon","inputs":[{"txid":"4e51e321a3bfa790ac257dd53c26720282453cadfda26fc10186e3c0dea036cd","vout":1},{"txid":"4e51e321a3bfa790ac257dd53c26720282453cadfda26fc10186e3c0dea036cd","vout":0}],"out":{"cYRqhURiGkwswKXTD5Eac5w5kQAerWbBYC":49.98934800},"move":{"m":"Hello"}}],"admin":[]}
Seq: 105
```

5 - Il game daemon assorbe la notifica ed elabora la mossa

Ciclo di vita di una "mossa" (pure bitcoind)
===

1 - Una mossa viene eseguita da un client RPC verso il nodo xaya

`xaya-cli -rpcuser=user -rpcpassword=password -regtest name_update "p/cymon" "{\"g\":{\"helloworld\":{\"m\":\"Hello\"}}}`

2- Mediante mining il blocco viene aggiunto alla blockchain

3- Il nodo notifica l'aggiunta del blocco sulla coda ZMQ di cui il demone del gioco è subscriber.

```
Payload: de3af3e5a45237abaea8cf19c0d24755764ee6b0fe006b7168e812febcf3e825 (size: 32)
Topic: rawblock (size: 8)
Seq: 628 (size: 4)
Payload: 1d58f1fcdd6808a64ac103420fbd7ac60e210253c894de7b0fb7c8cfc873375c (size: 32)
Topic: rawtx (size: 5)
Seq: 631 (size: 4)
```

4- Il demone recupera i dati del blocco usando il payload della notifica (Topic rawblock), che è l'hash del blocco stesso. Il valore di verbose a 2 riporta anche l'hex della transazione

`xaya-cli -regtest getblock 4c59fcc93b0eb5e36f3f5db28176f226680bf89555805db37e8f723350f5336e 2`

5- Il demone usa le api RPC per fare il decoding della transazione

6- All'interno della transazione si recuperano gli outputs, uno di questi (script type unkown) contiene uno script. Si decoda anche questo.

`xaya-cli decodescript 76a9142f737432473b2143fd49f6211a851a3d1285a38488ac`

7- Il nodo nameOp contiene i dati relativi alla mossa.

```
"nameOp": {
    "op": "name_update",
    "name": "p/cymon",
    "name_encoding": "utf8",
    "value": "{\"g\":{\"helloworld\":{\"m\":\"Hello\"}}}",
    "value_encoding": "ascii"
  },
```


`xaya-cli decoderawtransaction 020000000001010000000000000000000000000000000000000000000000000000000000000000ffffffff050278020101ffffffff02205fa012000000001976a91481ec141fd018d5dc321c6b695486d70b5168714588ac0000000000000000266a24aa21a9ede2f61c3f71d1defd3fa999dfa36953755c690689799962b48bebd836974e8cf90120000000000000000000000000000000000000000000000000000000000000000000000000`

