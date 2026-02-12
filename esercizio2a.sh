#Creare uno script BASH che chieda all’utente i seguenti dati:
#
#- Nome
#- Cognome
#- Codice Fiscale
#- Città di Residenza
#- Telefono
#E li stampi a video come riepilogo, con una frase decisa da te.

#!/usr/bin/env bash
#soluzione banale

echo "Quale è il tuo nome?"
read nome
echo "Quale è il tuo cognome?" 
read cognome
echo "Quale è il tuo codice fiscale?" 
read cf
echo "In quale città vivi?" 
read residenza
echo "Quale è il tuo numero di telefono?" 
read telefono

echo "Ciao $nome $cognome so che abiti a $residenza e ti posso chiamare al $telefono"
