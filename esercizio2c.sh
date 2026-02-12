#Creare uno script BASH che chieda all’utente i seguenti dati:
#
#- Nome
#- Cognome
#- Codice Fiscale
#- Città di Residenza
#- Telefono
#E li stampi a video come riepilogo, con una frase decisa da te.

#!/usr/bin/env bash
#soluzione elegante

read -p $'Quali sono il tuo nome, cognome, codice fiscale, \ncittà di residenza e telefono? \nSepara con uno spazio I dati, senza virgole! \n' \
nome cognome  cf residenza telefono

echo "Ciao $nome $cognome so che abiti a $residenza e ti posso chiamare al $telefono"
