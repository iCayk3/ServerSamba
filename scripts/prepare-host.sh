#!/usr/bin/env bash
set -euo pipefail

REPO_DIR="${REPO_DIR:-/opt/infraestrutura-solprovedor}"
CONFIG_DIR="/srv/nas-system/config"
LOG_DIR="/srv/nas-system/logs"

if [[ ! -d "$REPO_DIR/nas" ]]; then
  echo "Repositório não encontrado em $REPO_DIR"
  exit 1
fi

sudo mkdir -p \
  /srv/nas-data/{financeiro,rh,publico} \
  "$CONFIG_DIR/loki" \
  "$CONFIG_DIR/alloy" \
  "$CONFIG_DIR/grafana/provisioning/datasources" \
  "$LOG_DIR/samba" \
  /srv/nas-system/restic-cache \
  /srv/nas-system/rclone

sudo cp "$REPO_DIR/nas/monitoring/config/loki/loki.yml" \
  "$CONFIG_DIR/loki/loki.yml"

sudo cp "$REPO_DIR/nas/monitoring/config/alloy/config.alloy" \
  "$CONFIG_DIR/alloy/config.alloy"

sudo cp "$REPO_DIR/nas/monitoring/config/grafana/provisioning/datasources/loki.yml" \
  "$CONFIG_DIR/grafana/provisioning/datasources/loki.yml"

sudo touch /srv/nas-system/rclone/rclone.conf
sudo chmod 600 /srv/nas-system/rclone/rclone.conf

sudo chmod -R 0770 /srv/nas-data
sudo chmod -R 0755 /srv/nas-system/config
sudo chmod -R 0775 /srv/nas-system/logs

docker network inspect nas_backend >/dev/null 2>&1 || \
  docker network create nas_backend

echo "Host preparado."
echo "Dados: /srv/nas-data"
echo "Configurações: /srv/nas-system/config"
echo "Rclone: /srv/nas-system/rclone/rclone.conf"
