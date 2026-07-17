#!/usr/bin/env bash
set -euo pipefail

: "${BACKUP_CRON:=0 23 * * *}"

cat > /etc/crontab <<EOF
${BACKUP_CRON} /usr/local/bin/backup.sh
EOF

exec supercronic /etc/crontab
