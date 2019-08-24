Ciclo di vita di una "mossa" (xaya ad-hoc notifications)
===

1 - Il gioco, nel momento in cui nasce, si registra nei giochi tracciati

´xaya-cli trackedgames add HelloWorld

2 - Una mossa viene eseguita da un client RPC verso il nodo xaya

`xaya-cli -rpcuser=user -rpcpassword=password -regtest name_update "p/cymon" "{\"g\":{\"helloworld\":{\"m\":\"Hello\"}}}`

3 - Mediante mining il blocco viene aggiunto alla blockchain
 
4 - Il nodo notifica la mossa mediante una notifica ad hoc game-block-attach che riporta come payload un JSON coi dettagli della mossa

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

