# 🚀 Tech Challenge FIAP – Microsserviços com Docker

![Java](https://img.shields.io/badge/Java-21-orange?style=for-the-badge&logo=openjdk)
![Docker](https://img.shields.io/badge/Docker-24.0-blue?style=for-the-badge&logo=docker)
![MySQL](https://img.shields.io/badge/MySQL-8.0-blue?style=for-the-badge&logo=mysql)
![Spring](https://img.shields.io/badge/Spring_Boot-3.x-brightgreen?style=for-the-badge&logo=springboot)

Este repositório contém a arquitetura completa de microsserviços do **Tech Challenge FIAP**, utilizando **Docker** e **Docker Compose** para orquestrar os serviços e bancos de dados, garantindo um ambiente padronizado, reprodutível e simples de executar.

---

## 📌 Microsserviços Incluídos

O ecossistema é composto por três serviços principais:

1. **ms-login**  
   Responsável pela autenticação, geração e validação de tokens JWT.

2. **ms-usuario**  
   Responsável pelo gerenciamento de usuários e seus dados, persistidos em **MySQL**.

3. **ms-feedback**  
   Responsável pela coleta e gerenciamento de feedbacks, também persistidos em **MySQL**.

---

## 📦 Funcionalidades do Ambiente

- Orquestração centralizada via `docker-compose.yml`
- Bancos de dados MySQL isolados por serviço
- Persistência de dados utilizando volumes Docker
- Inicialização ordenada com `depends_on` e `healthcheck`
- Swagger UI habilitado em todos os microsserviços
- Coleção Postman para testes de API

---

## 🔧 Requisitos Mínimos

| Ferramenta | Finalidade | Versão Sugerida |
|----------|-----------|----------------|
| Docker | Execução dos containers | 24.0+ |
| Docker Compose | Orquestração | 2.20+ |
| Java JDK | Desenvolvimento local | 21 |
| Git | Versionamento | - |
| Postman / Insomnia | Testes de API | - |
| DBeaver / MySQL Workbench | Acesso ao banco | Opcional |

---

## 📂 Estrutura do Projeto

```text
/
├── ms-login/
├── ms-usuario/
├── ms-feedback/
├── collections/
└── docker-compose.yml
```

---

## ▶️ Como Executar o Projeto

### Subir todo o ambiente

```bash
docker compose up -d
```

### Acompanhar logs

```bash
docker compose logs -f
```

### Parar o ambiente

```bash
docker compose down
```

### Reset completo (⚠️ remove volumes)

```bash
docker compose down --rmi all --volumes
```

---

## 🔗 Swagger UI

| Serviço | URL |
|--------|-----|
| ms-login | http://localhost:9082/swagger-ui/index.html |
| ms-usuario | http://localhost:9083/swagger-ui/index.html |
| ms-feedback | http://localhost:9084/swagger-ui/index.html |

---

## 🗄️ Conexão com Bancos MySQL

### Banco de Usuários

- Host: localhost
- Porta: 3307
- Database: usuarios
- Usuário: usuarios
- Senha: admin

```text
jdbc:mysql://localhost:3307/usuarios
```

### Banco de Feedback

- Host: localhost
- Porta: 3308
- Database: feedback
- Usuário: feedback
- Senha: admin

```text
jdbc:mysql://localhost:3308/feedback
```

> Dentro do Docker, os serviços utilizam os hosts `db-usuarios` e `db-feedback`.

---

## 🧪 Testes de API

Importe a coleção localizada em:

```text
./collections/TechChallenge.postman_collection.json
```

A coleção contém cenários completos de autenticação, usuários e feedbacks.