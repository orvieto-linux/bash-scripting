#!/usr/bin/env bash

# Chiede all'utente di inserire il nome della persona da salutare.
read -r -p "Inserisci il nome della persona: " nome

# Stampa un messaggio di saluto includendo il nome fornito dall'utente.
echo "Ciao, ${nome}!"
