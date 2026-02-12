## Introduzione al BASH Scripting
gennaio 2026

In questo repo, vengono ospitati i file della serata dedicata al BASH scripting.
Oltre agli esercizi proposti trovate anche altri script bonus, il cui funzionamento è spiegato di seguito.

## Script di pulizia per Linux Mint

File: `cleanup_temp_mint.sh`

### Uso

```bash
./cleanup_temp_mint.sh
```

Modalità di prova (non elimina nulla):

```bash
./cleanup_temp_mint.sh --dry-run
```

Rimozione completa in `/tmp` e `/var/tmp`:

```bash
./cleanup_temp_mint.sh --all
```

## Script di saluto personalizzato

File: `stampa-nome.sh`

### Uso

```bash
./stampa-nome.sh
```

Lo script richiede l'inserimento del nome e stampa un saluto personalizzato.

### Regole di utilizzo

- Inserire un nome non vuoto quando richiesto dal prompt.
- Se il nome è vuoto, lo script mostra un errore e termina con codice di uscita `1`.
- Per un input valido, lo script stampa `Ciao, <nome>!` e termina con codice `0`.
- Lo script è pensato per essere eseguito in shell Bash.

## Script download e decompressione archivio

File: `scarica-zip.sh`

### Uso

```bash
./scarica-zip.sh
```

Lo script richiede in input:

1. un URL da cui scaricare la risorsa;
2. un percorso assoluto di destinazione.

### Regole di utilizzo

- Il percorso di destinazione deve essere assoluto (deve iniziare con `/`).
- Se la cartella di destinazione non esiste, viene creata automaticamente.
- Il download viene eseguito con `wget` e salvato nella directory indicata.
- Se il file scaricato è un archivio supportato (`.zip`, `.tar`, `.tar.gz`, `.tgz`, `.tar.bz2`, `.tar.xz`, `.gz`), lo script prova a decomprimerlo.
- Se il formato non è supportato, lo script conserva il file scaricato senza decompressione.

### Esempio

```bash
./scarica-zip.sh
# URL: https://github.com/madler/zlib/archive/refs/heads/master.zip
# Percorso assoluto: /tmp/prova-download
```
