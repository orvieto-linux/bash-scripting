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
