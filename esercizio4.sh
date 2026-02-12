#Creare uno script BASH che chieda all’utente un indirizzo web di un file .zip e lo estragga nella directory corrente, cioè quella in cui è stato salvato il file dello script.sh
#L’URL è il seguente:
# https://github.com/orvieto-linux/bash-scripting/archive/refs/heads/main.zip

#!/usr/bin/env bash
URL="$1"
#basename ottiene il nome del file
FILE_NAME=$(basename "$URL")
wget "$URL"
unzip "$FILE_NAME"
echo "Scaricamento e decompressione effettuati"

# si esegue cosi ./script.sh https://github.com/orvieto-linux/bash-scripting/archive/refs/heads/main.zip
