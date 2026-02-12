#Creare uno script BASH che chieda all’utente i seguenti dati:
#
#- Nome
#- Cognome
#- Codice Fiscale
#- Città di Residenza
#- Telefono
#E li stampi a video come riepilogo, con una frase decisa da te.

#!/usr/bin/env bash
#soluzione compatta con meno righe

read -p "Quale è il tuo nome?" nome 
read -p "Quale è il tuo cognome?" cognome  
read -p "Quale è il tuo codice fiscale?" cf 
read -p "In quale città vivi?" residenza
read -p "Quale è il tuo numero di telefono?" telefono

echo "Ciao $nome $cognome so che abiti a $residenza e ti posso chiamare al $telefono"
