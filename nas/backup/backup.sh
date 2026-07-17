#!/usr/bin/env bash
set -euo pipefail

echo "[$(date -Is)] Iniciando backup"

restic snapshots >/dev/null 2>&1 || restic init

restic backup \
  /data \
  /docker-volumes \
  /config-backup \
  --exclude-caches \
  --tag nas-corporativo

restic forget \
  --keep-daily 30 \
  --keep-weekly 12 \
  --keep-monthly 12 \
  --keep-yearly 5 \
  --prune

echo "[$(date -Is)] Backup concluído"
