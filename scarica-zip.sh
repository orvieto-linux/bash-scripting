#!/usr/bin/env bash

# Attiva alcune opzioni di sicurezza della shell:
# -e termina lo script se un comando fallisce.
# -u termina se viene usata una variabile non inizializzata.
# -o pipefail propaga errori anche nelle pipeline.
set -euo pipefail

# Chiede all'utente l'URL della risorsa da scaricare.
# read è una built-in Bash che legge dallo standard input.
# -r evita l'interpretazione dei backslash come escape.
# -p mostra un prompt prima della lettura.
read -r -p "Inserisci l'URL da scaricare: " url

# Chiede all'utente il percorso assoluto dove salvare il file.
# Anche qui usiamo read -r -p per input robusto e prompt chiaro.
read -r -p "Inserisci il percorso assoluto di destinazione: " percorso_destinazione

# Verifica che l'URL non sia vuoto.
# [[ -z ... ]] è vero quando la stringa ha lunghezza zero.
if [[ -z "${url}" ]]; then
  # Mostra errore su stderr con >&2 e termina con codice 1.
  echo "Errore: URL non valido (vuoto)." >&2
  exit 1
fi

# Verifica che il percorso non sia vuoto.
if [[ -z "${percorso_destinazione}" ]]; then
  # Informa l'utente e termina con errore.
  echo "Errore: percorso di destinazione non valido (vuoto)." >&2
  exit 1
fi

# Controlla che il percorso inserito sia assoluto.
# Un percorso assoluto su Linux inizia con '/'.
if [[ "${percorso_destinazione}" != /* ]]; then
  # Se non è assoluto, interrompe l'esecuzione.
  echo "Errore: devi specificare un percorso assoluto (es. /home/utente/download)." >&2
  exit 1
fi

# Crea la cartella di destinazione se non esiste.
# mkdir crea directory.
# -p crea anche eventuali directory parent e non fallisce se la directory esiste già.
mkdir -p "${percorso_destinazione}"

# Estrae un nome file dall'URL rimuovendo prima la query string (parte dopo '?').
# ${url%%\?*} elimina da '?' in poi.
# basename prende l'ultima parte del percorso URL.
nome_file="$(basename "${url%%\?*}")"

# Se non si riesce a ricavare un nome file valido, usa un fallback.
if [[ -z "${nome_file}" || "${nome_file}" == "/" || "${nome_file}" == "." ]]; then
  # Nome di fallback quando l'URL non contiene un file esplicito.
  nome_file="download.file"
fi

# Costruisce il percorso completo del file scaricato.
file_scaricato="${percorso_destinazione}/${nome_file}"

# Scarica la risorsa con wget.
# -O permette di definire esplicitamente il nome/percorso del file di output.
wget -O "${file_scaricato}" "${url}"

# Funzione che verifica se un comando è disponibile nel sistema.
# command -v restituisce successo se il comando esiste nel PATH.
comando_disponibile() {
  # "$1" è il primo argomento passato alla funzione.
  command -v "$1" >/dev/null 2>&1
}

# Funzione che prova a decomprimere l'archivio se il formato è riconosciuto.
decomprimi_se_archivio() {
  # Salva in variabile locale il percorso del file passato alla funzione.
  local file="$1"

  # Usa un case per riconoscere il tipo di archivio in base all'estensione.
  case "${file}" in
    *.zip)
      # Verifica che il comando unzip sia disponibile prima di usarlo.
      if comando_disponibile unzip; then
        # unzip -o estrae sovrascrivendo file esistenti senza chiedere conferma.
        unzip -o "${file}" -d "${percorso_destinazione}"
      else
        # Avvisa l'utente se unzip non è installato.
        echo "Avviso: archivio ZIP rilevato ma comando 'unzip' non disponibile." >&2
      fi
      ;;
    *.tar.gz|*.tgz)
      # tar -x estrae, -z gestisce gzip, -f indica il file archivio, -C la destinazione.
      tar -xzf "${file}" -C "${percorso_destinazione}"
      ;;
    *.tar.bz2)
      # tar -x estrae, -j gestisce bzip2, -f indica il file archivio, -C la destinazione.
      tar -xjf "${file}" -C "${percorso_destinazione}"
      ;;
    *.tar.xz)
      # tar -x estrae, -J gestisce xz, -f indica il file archivio, -C la destinazione.
      tar -xJf "${file}" -C "${percorso_destinazione}"
      ;;
    *.tar)
      # tar -x estrae un archivio tar non compresso.
      tar -xf "${file}" -C "${percorso_destinazione}"
      ;;
    *.gz)
      # Verifica disponibilità di gunzip per file gzip singoli.
      if comando_disponibile gunzip; then
        # gunzip -k decomprime mantenendo anche il file originale.
        gunzip -k "${file}"
      else
        # Avvisa l'utente se gunzip non è disponibile.
        echo "Avviso: file .gz rilevato ma comando 'gunzip' non disponibile." >&2
      fi
      ;;
    *)
      # Nessuna estensione riconosciuta: non decomprime.
      echo "Il file scaricato non sembra un archivio supportato: nessuna decompressione eseguita."
      ;;
  esac
}

# Chiama la funzione di decompressione passando il file appena scaricato.
decomprimi_se_archivio "${file_scaricato}"

# Messaggio finale con il percorso usato.
echo "Operazione completata. File salvato in: ${file_scaricato}"
