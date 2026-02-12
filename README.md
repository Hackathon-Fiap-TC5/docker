# 🏥 COMPARECE+ — Guia de Execução com Docker

![Java](https://img.shields.io/badge/Java-21-orange?style=for-the-badge\&logo=openjdk)
![Docker](https://img.shields.io/badge/Docker-24.0-blue?style=for-the-badge\&logo=docker)
![MySQL](https://img.shields.io/badge/MySQL-8.0-blue?style=for-the-badge\&logo=mysql)
![Spring](https://img.shields.io/badge/Spring_Boot-3.x-brightgreen?style=for-the-badge\&logo=springboot)

O **COMPARECE+** é uma plataforma de gestão inteligente de absenteísmo no SUS, construída com arquitetura de microsserviços e totalmente orquestrada via **Docker Compose**. Este guia descreve como subir o ambiente completo localmente de forma rápida, reprodutível e padronizada.

---

## 🚀 Visão Geral do Projeto

O COMPARECE+ utiliza análise de dados para calcular o **Índice de Comparecimento do Cidadão (ICC)**, apoiando a tomada de decisões operacionais e reduzindo desperdícios causados por faltas em consultas.

A solução é baseada em:

* Arquitetura de microsserviços
* Clean Architecture
* API First
* Containers Docker isolados por serviço
* Bancos MySQL independentes
* Orquestração centralizada com `docker-compose`

---

## 🧩 Microsserviços

### 📅 MS-Agendamento

Responsável pelo ciclo de vida das consultas médicas.

**Principais funções:**

* Criação, consulta e cancelamento de agendamentos
* Publicação de eventos em fila de mensageria
* Integração com banco MySQL dedicado
* Exposição de APIs REST com Swagger

---

### 📊 MS-Comparecimento

Componente analítico da solução.

**Principais funções:**

* Cálculo do ICC
* Classificação de pacientes
* Geração de relatórios de absenteísmo
* Consumo de eventos de agendamento
* Sugestões de conduta para otimização da agenda

---

## 📦 Funcionalidades do Ambiente Docker

* Orquestração completa via `docker-compose.yml`
* Containers isolados por microsserviço
* MySQL dedicado para cada serviço
* Persistência com volumes Docker
* Inicialização ordenada com `depends_on` e `healthcheck`
* Swagger habilitado em todos os serviços
* Coleção Postman para testes de API

---

## 🔧 Requisitos

| Ferramenta                | Finalidade             | Versão Recomendada |
| ------------------------- | ---------------------- | ------------------ |
| Docker                    | Execução de containers | 24.0+              |
| Docker Compose            | Orquestração           | 2.20+              |
| Java JDK                  | Desenvolvimento local  | 21                 |
| Git                       | Controle de versão     | -                  |
| Postman / Insomnia        | Testes de API          | -                  |
| DBeaver / MySQL Workbench | Acesso ao banco        | Opcional           |

---

## 📂 Estrutura do Repositório

```text
/
├── ms-agendamento/
├── ms-comparecimento/
├── collections/
└── docker-compose.yml
```

---

## ▶️ Executando o Ambiente

### Subir todos os serviços

```bash
docker compose up -d
```

### Acompanhar logs em tempo real

```bash
docker compose logs -f
```

### Parar os containers

```bash
docker compose down
```

### Reset completo do ambiente (remove imagens e volumes)

```bash
docker compose down --rmi all --volumes
```

---

## 🔗 Acesso às APIs (Swagger)

| Serviço           | URL                                         |
| ----------------- | ------------------------------------------- |
| ms-agendamento    | http://localhost:9083/swagger-ui/index.html |
| ms-comparecimento | http://localhost:9084/swagger-ui/index.html |

---

## 🗄️ Conexão com os Bancos MySQL

### Banco — Agendamento

* **Host:** localhost
* **Porta:** 3307
* **Database:** agendamento
* **Usuário:** agendamento
* **Senha:** admin

```
jdbc:mysql://localhost:3307/agendamento
```

---

### Banco — Comparecimento

* **Host:** localhost
* **Porta:** 3308
* **Database:** comparecimento
* **Usuário:** comparecimento
* **Senha:** admin

```
jdbc:mysql://localhost:3308/comparecimento
```

> Dentro da rede Docker, os serviços utilizam os hosts `db-agendamento` e `db-comparecimento`.

---

## 🧪 Testes de API

Importe a coleção Postman disponível em:

```text
./collections/Comparece+ - PosTech_TC5_hackathon.postman_collection.json
```

Essa coleção contém exemplos prontos para validar os fluxos principais do sistema.

---

## ✅ Resultado Esperado

Após subir o ambiente:

* Todos os containers devem estar em execução
* As APIs devem responder via Swagger
* Os bancos MySQL devem estar acessíveis
* O sistema estará pronto para testes e desenvolvimento

---

## 📌 Observações

* O primeiro boot pode demorar alguns minutos devido à criação das imagens
* Caso ocorra conflito de containers antigos, execute um reset completo
* Os dados persistem entre execuções graças aos volumes Docker

---

## 👨‍💻 Desenvolvido para o Hackathon FIAP

Projeto acadêmico focado em inovação tecnológica aplicada à saúde pública, com ênfase em eficiência operacional e melhoria do acesso aos serviços do SUS.

---

**COMPARECE+ — Inteligência de dados a serviço da saúde pública.**
