<h1 align="center">🏍️ Sprint 4 – DevOps & Cloud Computing</h1>
<h3 align="center">🚀 Monitoring Mottu (.NET 8 + Azure CI/CD)</h3>

<p align="center">
  <a href="https://dev.azure.com/FIAP-VKC/Monitoring%20Mottu/_build/latest?definitionId=6&branchName=main">
    <img src="https://dev.azure.com/FIAP-VKC/Monitoring%20Mottu/_apis/build/status%2FMonitoring%20Mottu-CI?branchName=main" alt="Build Status"/>
  </a>
  <img src="https://img.shields.io/badge/.NET-8.0-512BD4?logo=dotnet&logoColor=white" alt=".NET"/>
  <img src="https://img.shields.io/badge/Docker-Container-blue?logo=docker&logoColor=white" alt="Docker"/>
  <img src="https://img.shields.io/badge/Azure-DevOps-0078D7?logo=azure-devops&logoColor=white" alt="Azure DevOps"/>
  <img src="https://img.shields.io/badge/Status-Online-6A0DAD?logo=microsoft-azure&logoColor=white" alt="Online"/>
</p>

## 📋 Descrição do Projeto

Este repositório contém o código-fonte de uma **API RESTful em .NET 8** para o gerenciamento de **motos e garagens**, desenvolvida como parte do **Desafio da Mottu** (Sprint 4 – FIAP).

> 🎯 **Objetivo:**  
> Demonstrar a criação de uma **infraestrutura completa de DevOps e Cloud Computing**, com um fluxo **CI/CD totalmente automatizado no Azure**, desde o *commit* até a publicação.

---

## 🚀 Aplicação Online

A API está hospedada no **Azure Web App** e acessível via Swagger:

👉 **[Acessar Swagger (Online)](https://app-sprint4-mottu-victor-hqbfceacdsb0aecs.eastus2-01.azurewebsites.net/swagger/index.html)**

---

## 🛠️ Stack de Tecnologias e Serviços

| Categoria | Tecnologia / Serviço |
|------------|----------------------|
| **Back-end** | .NET 8 (API REST) + Entity Framework Core |
| **Banco de Dados** | Azure SQL Database (PaaS) |
| **Containerização** | Docker (Multi-stage Build) |
| **Orquestração CI/CD** | Azure DevOps Pipelines (Clássico) |
| **Registro de Imagem** | Azure Container Registry (ACR) |
| **Hospedagem** | Azure Web App for Containers (Linux) |

---

## 🔄 Fluxo de DevOps (CI/CD)

O fluxo de automação foi dividido em duas pipelines principais:

### 🧱 1. Pipeline de CI – *Build & Test*
**Nome:** `CI-Build-Docker`  
**Gatilho:** `git push` na branch `main`  
**Agente:** `ubuntu-latest`

**Etapas:**
1. **Test:** Executa `dotnet test` (atualmente sem testes implementados)  
2. **Build:** Cria a imagem Docker `sprint4-mottu-app`  
3. **Push:** Envia a imagem tagueada para o ACR (`sprint4-mottu-app:16`)  
4. **Publish:** Publica os artefatos para a pipeline de release

---

### 🚢 2. Pipeline de CD – *Release & Deploy*
**Nome:** `Release-Deploy-WebApp`  
**Gatilho:** Nova imagem publicada no ACR  

**Etapas:**
- **Deploy:** Executa a tarefa *Azure Web App on Container Deploy*, atualizando o container da aplicação  
- **Reinicialização Controlada:** O Web App é recarregado automaticamente com a nova versão

**Variáveis de ambiente:**
- `DB_ConnectionString`  
- `WEBSITES_PORT`  
- `ASPNETCORE_ENVIRONMENT`

> 🔒 Todas as variáveis sensíveis são configuradas diretamente no Azure Web App, conforme o requisito **7.IV**.

---

## 🗺️ Arquitetura do Pipeline (Mermaid)

```mermaid
graph TD
    %% ===========================
    %% SEÇÕES DO DIAGRAMA
    %% ===========================
    subgraph "👨‍💻 Pessoas"
        Dev["👨‍💻 Desenvolvedor"]
        User["👩‍💻 Usuário Final"]
    end

    subgraph "🐙 Versionamento (SCM)"
        GitHub["GitHub (Repositório)"]
    end

    subgraph "⚙️ Azure DevOps (CI/CD)"
        ADO_CI["🚀 Pipeline CI - Build & Test"]
        ADO_CD["🚢 Pipeline CD - Release & Deploy"]
    end

    subgraph "☁️ Recursos Azure (Nuvem)"
        ACR["📦 Azure Container Registry"]
        WebApp["💻 Azure Web App (sprint4-mottu-app)"]
        SQLDB["💾 Azure SQL Database (db-mottu)"]
    end

    %% ===========================
    %% FLUXOS
    %% ===========================
    Dev -->|"1️⃣ git push (main)"| GitHub
    GitHub -->|"2️⃣ Gatilho CI (Push)"| ADO_CI
    ADO_CI -->|"3️⃣ Build/Test (Docker)"| ADO_CI
    ADO_CI -->|"4️⃣ Push Imagem (sprint4-mottu-app)"| ACR

    ACR -->|"5️⃣ Gatilho CD (Nova Imagem)"| ADO_CD
    ADO_CD -->|"6️⃣ Deploy (Atualiza Container)"| WebApp

    WebApp -->|"7️⃣ Conexão via Variáveis de Ambiente"| SQLDB
    User -->|"8️⃣ Acessa API (Swagger / CRUD)"| WebApp

    %% ===========================
    %% ESTILO (CORES)
    %% ===========================
    style Dev fill:#fff,stroke:#333,stroke-width:2px
    style User fill:#fff,stroke:#333,stroke-width:2px
    style GitHub fill:#6e40c9,color:#fff,stroke:#6e40c9,stroke-width:2px
    style ADO_CI fill:#8a2be2,color:#fff,stroke-width:2px
    style ADO_CD fill:#8a2be2,color:#fff,stroke-width:2px
    style ACR fill:#7b68ee,color:#fff,stroke-width:2px
    style WebApp fill:#9370db,color:#fff,stroke-width:2px
    style SQLDB fill:#9370db,color:#fff,stroke-width:2px


MonitoringMottu/
├── MonitoringMottu.Api/        # API principal (.NET 8)
│   ├── Controllers/
│   ├── Models/
│   ├── Data/
│   └── Program.cs
├── Dockerfile                  # Multi-stage (build + runtime)
├── azure-pipelines.yml         # Pipeline CI/CD (Azure DevOps)
└── README.md                   # Este arquivo 💜

