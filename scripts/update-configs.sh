#!/usr/bin/env bash
set -euo pipefail

cd /opt/infraestrutura-solprovedor
git pull --ff-only
bash scripts/prepare-host.sh

echo "Configurações atualizadas. Redeploy das stacks pode ser feito no Portainer."
