# Infraestrutura Sol Provedor

Repositório de infraestrutura como código para implantação pelo Portainer.

## Stacks

| Stack no Portainer | Compose path |
|---|---|
| nas-storage | `nas/storage/docker-compose.yml` |
| nas-monitoring | `nas/monitoring/docker-compose.yml` |
| nas-backup | `nas/backup/docker-compose.yml` |

## Antes de implantar

No servidor Docker:

```bash
sudo mkdir -p /opt/infraestrutura-solprovedor
sudo git clone URL_DO_REPOSITORIO /opt/infraestrutura-solprovedor
cd /opt/infraestrutura-solprovedor
sudo bash scripts/prepare-host.sh
```

O script cria:

- `/srv/nas-data` para os arquivos;
- `/srv/nas-system` para configurações e logs;
- a rede Docker externa `nas_backend`;
- cópias das configurações necessárias ao Portainer Community Edition.

## Segredos

Nunca envie arquivos `.env`, senhas ou `rclone.conf` ao GitHub.

No Portainer, cadastre as variáveis de ambiente manualmente em cada Stack ou use
**Load variables from .env file** com o arquivo `.env.example` correspondente
depois de preenchê-lo localmente.

## Ordem de implantação

1. `nas-storage`
2. `nas-monitoring`
3. configurar o `rclone.conf`
4. `nas-backup`
