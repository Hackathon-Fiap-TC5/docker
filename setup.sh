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
REPO_AGENDAMENTO="https://github.com/Hackathon-Fiap-TC5/ms-agendamento"
REPO_COMPARECIMENTO="https://github.com/Hackathon-Fiap-TC5/ms-comparecimento"
REPO_COLLETIONS="https://github.com/Hackathon-Fiap-TC5/collections"

# Clonar se os diretórios não existirem
[ ! -d "ms-agendamento" ] && git clone "REPO_AGENDAMENTO"
[ ! -d "ms-comparecimento" ] && git clone "REPO_COMPARECIMENTO"
[ ! -d "colletions" ] && git clone "$REPO_COLLETIONS"

# URL do Gist
GIST_RAW_URL="https://gist.githubusercontent.com/Ghustavo516/74203204973a7cd391dbde607278c083/raw/17222ac445bbc50ed389a0ef452b27a890fd83d0/docker-compose-tc5.yml"

# Baixar docker-compose.yaml
if command -v curl >/dev/null 2>&1; then
    curl -fsSL "$GIST_RAW_URL" -o docker-compose.yaml
else
    echo "Erro: curl não está instalado"
    exit 1
fi

# Subir containers
$DOCKER_COMPOSE_COMMAND up -d || { echo "Falha ao subir containers"; exit 1; }