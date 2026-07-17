# Implantação pelo Portainer

## 1. GitHub

Crie um repositório privado chamado:

```text
infraestrutura-solprovedor
```

Suba todo o conteúdo deste projeto, exceto arquivos ignorados pelo `.gitignore`.

## 2. Preparar o servidor

```bash
sudo mkdir -p /opt
cd /opt
sudo git clone https://github.com/SEU_USUARIO/infraestrutura-solprovedor.git
sudo bash /opt/infraestrutura-solprovedor/scripts/prepare-host.sh
```

## 3. Stack `nas-storage`

No Portainer:

- Stacks → Add stack
- Name: `nas-storage`
- Build method: `Git repository`
- Repository URL: URL HTTPS do repositório
- Repository reference: `refs/heads/main`
- Compose path: `nas/storage/docker-compose.yml`
- Authentication: habilitada se o repositório for privado
- Environment variables: carregar `nas/storage/.env.example` depois de editar localmente
- Deploy the stack

## 4. Stack `nas-monitoring`

- Name: `nas-monitoring`
- Compose path: `nas/monitoring/docker-compose.yml`
- Carregar as variáveis de `nas/monitoring/.env.example`

## 5. Configurar Rclone

No servidor, configure o arquivo fora do Git:

```bash
sudo docker run --rm -it \
  -v /srv/nas-system/rclone:/config/rclone \
  rclone/rclone config \
  --config /config/rclone/rclone.conf
```

Crie um remote chamado `cloud`.

## 6. Stack `nas-backup`

- Name: `nas-backup`
- Compose path: `nas/backup/docker-compose.yml`
- Carregar as variáveis de `nas/backup/.env.example`

O build usa o clone local:

```text
/opt/infraestrutura-solprovedor/nas/backup
```

## Atualizações

Edite os arquivos, faça commit e push. Depois execute no servidor:

```bash
sudo bash /opt/infraestrutura-solprovedor/scripts/update-configs.sh
```

No Portainer, abra cada stack e use **Pull and redeploy**.

Não habilite Force redeployment até validar toda a implantação.
