Configurazione
===

Per lavorare in regtest bisogna mette in xaya.conf

`regtest=1`

Tutte le chiamate usando xaya-cli, quindi, avranno bisogno del parametro -regtest

Mining
===

L'ambiente regtest non mina davvero, ma il comando

`xaya-cli -regtest generatetoaddress 1 <wallet>`

oltre ad assegnare CHI al wallet aggiunge anche un blocco alla chain. E' necessario lanciarlo ogni volta che c'è un'attività pending.

Minare CHI
===
   
 * xaya-cli -regtest getnewaddress "cymon" 
   [Per avere il wallet]
 * xaya-cli -regtest generatetoaddress 101 cYRigVHCgsJYXq2s6C1tT3WsLEyYs1oCqG
   [La stringa in fondo è quella restituita dal primo comando: è il wallet]
 * xaya-cli -regtest getbalance
   [Mostra i CHI ottenuti]

HelloWorld
===

 1. Lanciare HelloWorld con l'apposito script

`run-regtest.sh`

 2. Ottenere un nome (mining necessario)
 
`xaya-cli -rpcuser=user -rpcpassword=password -regtest name_register "p/cymon" "{}"`

 3. Eseguire la mossa (mining necessario)

`xaya-cli -rpcuser=user -rpcpassword=password -regtest name_update "p/cymon" "{\"g\":{\"helloworld\":{\"m\":\"Hello\"}}}"`

 4. La mossa risulta nell'interfaccia dell'Hello World
