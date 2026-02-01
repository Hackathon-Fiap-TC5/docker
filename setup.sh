#!/bin/bash

set -e

# Detecta se docker-compose deve ser chamado com hífen ou espaço
if command -v docker-compose >/dev/null 2>&1; then
    DOCKER_COMPOSE_COMMAND="docker-compose"
elif docker compose version >/dev/null 2>&1; then
    DOCKER_COMPOSE_COMMAND="docker compose"
else
    echo "Erro: docker-compose não encontrado."
    exit 1
fi

# URLs dos repositórios
REPO_LOGIN="https://github.com/TC4-FIAP-Arquitetura-Dev-Java/ms-login"
REPO_USUARIO="https://github.com/TC4-FIAP-Arquitetura-Dev-Java/ms-usuario"
REPO_FEEDBACK="https://github.com/TC4-FIAP-Arquitetura-Dev-Java/ms-feedback"
REPO_COLLETIONS="https://github.com/TC4-FIAP-Arquitetura-Dev-Java/collections"

# Clonar se os diretórios não existirem
[ ! -d "ms-login" ] && git clone "$REPO_LOGIN"
[ ! -d "ms-usuario" ] && git clone "$REPO_USUARIO"
[ ! -d "ms-feedback" ] && git clone "$REPO_FEEDBACK"
[ ! -d "colletions" ] && git clone "$REPO_COLLETIONS"

# URL do Gist
GIST_RAW_URL="https://gist.githubusercontent.com/Ghustavo516/2681a752b3c718d50e6985751983e867/raw/58c1c281b2177c64be78481d8380882f2e9e1aad/docker-compose-tc4.yml"

# Baixar docker-compose.yaml
if command -v curl >/dev/null 2>&1; then
    curl -fsSL "$GIST_RAW_URL" -o docker-compose.yaml
else
    echo "Erro: curl não está instalado"
    exit 1
fi

# Subir containers
$DOCKER_COMPOSE_COMMAND up -d || { echo "Falha ao subir containers"; exit 1; }