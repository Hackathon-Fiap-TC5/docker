@echo off
setlocal enabledelayedexpansion

echo ============================================
echo Setup Ambiente Hackathon TC5
echo ============================================

:: Detectar docker-compose (v1) ou docker compose (v2)
where docker-compose >nul 2>nul
if %ERRORLEVEL%==0 (
    set "DOCKER_COMPOSE_COMMAND=docker-compose"
) else (
    docker compose version >nul 2>nul
    if %ERRORLEVEL%==0 (
        set "DOCKER_COMPOSE_COMMAND=docker compose"
    ) else (
        echo Erro: docker-compose nao encontrado.
        exit /b 1
    )
)

echo Usando: %DOCKER_COMPOSE_COMMAND%

:: URLs dos repositórios
set "REPO_AGENDAMENTO=https://github.com/Hackathon-Fiap-TC5/ms-agendamento"
set "REPO_COMPARECIMENTO=https://github.com/Hackathon-Fiap-TC5/ms-comparecimento"
set "REPO_COLLECTIONS=https://github.com/Hackathon-Fiap-TC5/collections"

:: Clonar repositórios se não existirem
if not exist "ms-agendamento" (
    echo Clonando ms-agendamento...
    git clone %REPO_AGENDAMENTO% || exit /b 1
)

if not exist "ms-comparecimento" (
    echo Clonando ms-comparecimento...
    git clone %REPO_COMPARECIMENTO% || exit /b 1
)

if not exist "collections" (
    echo Clonando collections...
    git clone %REPO_COLLECTIONS% || exit /b 1
)

:: URL do docker-compose.yaml
set "GIST_RAW_URL=https://gist.githubusercontent.com/Ghustavo516/74203204973a7cd391dbde607278c083/raw/17222ac445bbc50ed389a0ef452b27a890fd83d0/docker-compose-tc5.yml"

:: Verificar se curl existe
where curl >nul 2>nul
if %ERRORLEVEL%==0 (
    echo Baixando docker-compose.yaml...
    curl -fsSL %GIST_RAW_URL% -o docker-compose.yaml || exit /b 1
) else (
    echo Erro: curl nao esta instalado.
    exit /b 1
)

:: Subir containers
echo Subindo containers...
%DOCKER_COMPOSE_COMMAND% up -d --build || exit /b 1

echo ============================================
echo Ambiente iniciado com sucesso!
echo ============================================

pause
