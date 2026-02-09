#!/usr/bin/env bash
set -euo pipefail

# Pulizia file temporanei per Linux Mint
# Uso:
#   ./cleanup_temp_mint.sh                  # esegue la pulizia (file vecchi di 1 giorno)
#   ./cleanup_temp_mint.sh --dry-run        # mostra cosa verrebbe eliminato
#   ./cleanup_temp_mint.sh --all            # rimuove tutto in /tmp e /var/tmp
#   ./cleanup_temp_mint.sh --help           # mostra questo aiuto

DRY_RUN=false
REMOVE_ALL=false

for arg in "$@"; do
  case "$arg" in
    --dry-run)
      DRY_RUN=true
      ;;
    --all)
      REMOVE_ALL=true
      ;;
    --help|-h)
      sed -n '1,12p' "$0"
      exit 0
      ;;
    *)
      echo "Opzione non riconosciuta: $arg" >&2
      exit 1
      ;;
  esac
done

run_cmd() {
  if $DRY_RUN; then
    echo "[DRY-RUN] $*"
  else
    "$@"
  fi
}

require_cmd() {
  if ! command -v "$1" >/dev/null 2>&1; then
    echo "Comando mancante: $1" >&2
    exit 1
  fi
}

if [[ $EUID -ne 0 ]]; then
  if command -v sudo >/dev/null 2>&1; then
    SUDO="sudo"
  else
    echo "sudo non disponibile. Esegui come root per pulire /tmp e /var/tmp." >&2
    SUDO=""
  fi
else
  SUDO=""
fi

require_cmd find
require_cmd rm

# 1) /tmp e /var/tmp (solo contenuto, non le directory)
if $REMOVE_ALL; then
  run_cmd $SUDO find /tmp -mindepth 1 -maxdepth 1 -exec rm -rf {} +
  run_cmd $SUDO find /var/tmp -mindepth 1 -maxdepth 1 -exec rm -rf {} +
else
  run_cmd $SUDO find /tmp -mindepth 1 -maxdepth 1 -mtime +1 -exec rm -rf {} +
  run_cmd $SUDO find /var/tmp -mindepth 1 -maxdepth 1 -mtime +1 -exec rm -rf {} +
fi

# 2) Cache APT
require_cmd apt-get
run_cmd $SUDO apt-get clean

# 3) Thumbnail cache dell'utente
if [[ -d "$HOME/.cache/thumbnails" ]]; then
  run_cmd rm -rf "$HOME/.cache/thumbnails"/*
fi

# 4) Cestino dell'utente
if [[ -d "$HOME/.local/share/Trash" ]]; then
  run_cmd rm -rf "$HOME/.local/share/Trash"/files/*
  run_cmd rm -rf "$HOME/.local/share/Trash"/info/*
fi

# 5) Cache generica dell'utente (solo file temporanei più comuni)
if [[ -d "$HOME/.cache" ]]; then
  run_cmd find "$HOME/.cache" -type f \( -name '*.tmp' -o -name '*.temp' -o -name '*.swp' \) -delete
fi

echo "Pulizia completata."
