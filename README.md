In questo repo, vengono ospitati i file della serata dedicata al BASH scripting.

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
