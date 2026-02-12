#Creare uno script BASH che, una volta avviato, mostri a video un messaggio in cui descrivi come si sta svolgendo la serata finora, con un testo di 
#massimo 3-4 righe

#!/usr/bin/env bash
#soluzione con complessità superiore
DESCRIZIONE="Questa sera abbiamo partecipato all’assemblea dei soci di Orvieto Linux e dopo abbiamo iniziato la prima serata tematica del 2026 sul BASH scripting"
mostra () { echo "$1" }
mostra $DESCRIZIONE
exit 0
