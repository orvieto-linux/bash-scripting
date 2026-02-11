#!/usr/bin/env bash

# Legge da tastiera il nome da usare nel saluto.
# read: built-in della shell che acquisisce input standard e lo salva in una variabile.
# Opzioni usate:
# -r   non interpreta il backslash (\) come carattere di escape.
# -p   mostra il prompt prima di leggere l'input.
# (none) senza opzioni, read leggerebbe comunque l'input ma senza prompt automatico
#        e con interpretazione dei backslash.
read -r -p "Inserisci il nome della persona: " nome

# Verifica che l'utente abbia inserito almeno un valore.
# [[ -z ... ]]: condizione vera se la stringa è vuota (zero caratteri).
if [[ -z "${nome}" ]]; then
  # Stampa un messaggio di errore e termina lo script con codice 1.
  echo "Errore: non hai inserito alcun nome."
  exit 1
fi

# Stampa il saluto finale.
# echo: built-in che scrive testo su output standard.
# Opzioni usate:
# (none) qui non servono opzioni; stampiamo semplicemente la stringa.
echo "Ciao, ${nome}!"
