Sprint 4 - DevOps & Cloud Computing (MonitoringMottu .NET)[![Build Status](https://dev.azure.com/FIAP-VKC/Monitoring%20Mottu/_apis/build/status%2FMonitoring%20Mottu-CI?branchName=main)](https://dev.azure.com/FIAP-VKC/Monitoring%20Mottu/_build/latest?definitionId=6&branchName=main)Este repositório contém o código-fonte de uma API RESTful em .NET 8 para o gerenciamento de motos e garagens, como parte do desafio da Mottu.O objetivo principal deste projeto (Sprint 4 da FIAP) foi não o código em si, mas a criação de uma infraestrutura completa de DevOps e Cloud Computing, implementando um fluxo CI/CD totalmente automatizado no Azure.🚀 Link da Aplicação (Ao Vivo)A API está implantada no Azure e pode ser acessada (via Swagger) no seguinte link:https://app-sprint4-mottu-victor-hqbfceacdsb0aecs.eastus2-01.azurewebsites.net/swagger/index.html🛠️ Stack de Tecnologias e DevOpsEsta é a stack completa de ferramentas e serviços utilizados para este projeto:Aplicação: .NET 8 (API) com Entity Framework CoreBanco de Dados: Azure SQL Database (PaaS)Containerização: Docker (via Dockerfile multi-stage)Orquestrador CI/CD: Azure DevOps Pipelines (Clássico)Registro de Imagem: Azure Container Registry (ACR)Plataforma de Host: Azure Web App for Containers (Linux)🔄 Arquitetura de DevOps e Fluxo CI/CDO fluxo de automação deste projeto é dividido em duas pipelines:1. Pipeline de CI (Build & Test)Nome: CI-Build-DockerGatilho: Automático, a cada git push na branch main.Agente: ubuntu-latest.Etapas:Test: Executa a etapa de dotnet test (atualmente com 0 testes).Build: Faz o build da imagem Docker (usando o Dockerfile) com o nome sprint4-mottu-app.Push: Envia a nova imagem tagueada (ex: sprint4-mottu-app:16) para o Azure Container Registry (ACR).Publish: Publica os artefatos formais.2. Pipeline de CD (Release & Deploy)Nome: Release-Deploy-WebAppGatilho: Automático, assim que uma nova imagem (sprint4-mottu-app) é publicada no ACR pela pipeline de CI.Etapas:Deploy: A tarefa Azure Web App on Container Deploy puxa a nova imagem do ACR e atualiza o Azure Web App (app-sprint4-mottu-victor), causando uma reinicialização controlada e colocando a nova versão no ar.Variáveis: As variáveis de ambiente (como DB_ConnectionString, WEBSITES_PORT e ASPNETCORE_ENVIRONMENT) são gerenciadas diretamente no Azure Web App para manter a segurança (Req. 7.IV).🗺️ Diagrama da ArquiteturaO diagrama abaixo ilustra o fluxo completo, desde o desenvolvedor até a aplicação em produção.graph TD
    subgraph "Pessoas"
        Dev(👨‍💻 Desenvolvedor)
        User(👩‍💻 Usuário Final)
    end

    subgraph "Ferramentas de Versionamento (SCM)"
        GitHub[🐙 GitHub (Repositório)]
    end

    subgraph "Azure DevOps (CI/CD)"
        ADO_CI(🚀 Pipeline CI - Build & Test)
        ADO_CD(🚢 Pipeline CD - Release)
    end

    subgraph "Recursos no Azure (Nuvem)"
        ACR[📦 Azure Container Registry]
        WebApp[💻 Azure Web App (sprint4-mottu-app)]
        SQLDB[💾 Azure SQL Database (db-mottu)]
    end

    %% Fluxo CI (Números 1-4)
    Dev -- "1. git push (na main)" --> GitHub
    GitHub -- "2. Gatilho de CI (Push)" --> ADO_CI
    ADO_CI -- "3. Build, Test (Docker)" --> ADO_CI
    ADO_CI -- "4. Push Imagem (sprint4-mottu-app)" --> ACR

    %% Fluxo CD (Números 5-7)
    ACR -- "5. Gatilho de CD (Novo Artefato)" --> ADO_CD
    ADO_CD -- "6. Deploy (Puxa Imagem)" --> WebApp

    %% Fluxo da Aplicação (Números 7-8)
    WebApp -- "7. Conexão (Variáveis de Ambiente)" --> SQLDB
    User -- "8. Acessa API (Swagger / CRUD)" --> WebApp

    %% Estilização para ficar bonito
    style Dev fill:#fff,stroke:#333,stroke-width:2px
    style User fill:#fff,stroke:#333,stroke-width:2px
    style GitHub fill:#181717,color:#fff,stroke:#fff,stroke-width:2px
    style ADO_CI fill:#2188ff,color:#fff,stroke-width:2px
    style ADO_CD fill:#2188ff,color:#fff,stroke-width:2px
    style ACR fill:#0062a8,color:#fff,stroke-width:2px
    style WebApp fill:#0078d4,color:#fff,stroke-width:2px
    style SQLDB fill:#0078d4,color:#fff,stroke-width:2px
