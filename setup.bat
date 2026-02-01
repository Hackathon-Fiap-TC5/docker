@echo off
setlocal enabledelayedexpansion

:: Parar se ocorrer qualquer erro
set "ERRORLEVEL_CHECK=0"

:: Detectar se docker-compose existe (com ou sem hífen)
where docker-compose >nul 2>nul
if %ERRORLEVEL%==0 (
    set "DOCKER_COMPOSE_COMMAND=docker-compose"
) else (
    docker compose version >nul 2>nul
    if %ERRORLEVEL%==0 (
        set "DOCKER_COMPOSE_COMMAND=docker compose"
    ) else (
        echo Erro: docker-compose não encontrado.
        exit /b 1
    )
)

:: URLs dos repositórios
set "REPO_LOGIN=https://github.com/TC4-FIAP-Arquitetura-Dev-Java/ms-login"
set "REPO_USUARIO=https://github.com/TC4-FIAP-Arquitetura-Dev-Java/ms-usuario"
set "REPO_FEEDBACK=https://github.com/TC4-FIAP-Arquitetura-Dev-Java/ms-feedback"
set "REPO_COLLETIONS=https://github.com/TC4-FIAP-Arquitetura-Dev-Java/collections"

:: Clonar se os diretórios não existirem
if not exist "ms-login" (
    git clone %REPO_LOGIN%
)
if not exist "ms-usuario" (
    git clone %REPO_USUARIO%
)
if not exist "ms-feedback" (
    git clone %REPO_FEEDBACK%
)
if not exist "collections" (
    git clone %REPO_COLLETIONS%
)

:: URL do docker-compose.yaml
set "GIST_RAW_URL=https://gist.githubusercontent.com/Ghustavo516/2681a752b3c718d50e6985751983e867/raw/58c1c281b2177c64be78481d8380882f2e9e1aad/docker-compose-tc4.yml"

:: Verifica se curl está disponível
where curl >nul 2>nul
if %ERRORLEVEL%==0 (
    curl -fsSL %GIST_RAW_URL% -o docker-compose.yaml
) else (
    echo Erro: curl não está instalado.
    exit /b 1
)

:: Subir containers
%DOCKER_COMPOSE_COMMAND% up -d