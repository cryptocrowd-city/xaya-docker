Verificare il sync con la chain
===

 1. Salvare l'hash del blocco da cui proviene l'ultima mossa.
 2. Invocare la getblockchaininfo per conoscere il blocco più recente (best block)
 3. Verificare che l'hash coincida con quella salvata.
 4. **SE NO** invocare la `game_send_updates` con l'ultimo blocco nodo, il che farà reinviare tutte le notifiche successive così che il sistema le processi.
