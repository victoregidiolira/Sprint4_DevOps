# Sprint 3 - Sistema de Gestão de Motos e Garagens

Este é um projeto em .NET 8 que implementa uma API RESTful para gerenciamento de motos e garagens. Utiliza Entity Framework Core com banco Oracle, estruturado em camadas e baseado em boas práticas de desenvolvimento orientado a objetos.

---

## 📡 Rotas Disponíveis

### 🚗 MotoController

- `GET /moto` – Listar todas as motos
- `GET /moto/{id}` – Buscar moto por ID
- `POST /moto` – Cadastrar nova moto
- `PUT /moto/{id}` – Atualizar moto
- `DELETE /moto/{id}` – Remover moto

### 🏢 GaragemController

- `GET /garagem` – Listar todas as garagens
- `GET /garagem/{id}` – Buscar garagem por ID
- `POST /garagem` – Cadastrar nova garagem
- `PUT /garagem/{id}` – Atualizar garagem
- `DELETE /garagem/{id}` – Remover garagem

---

## 🧰 Tecnologias Utilizadas

- .NET 8
- ASP.NET Core
- Entity Framework Core
- Oracle Database
- RESTful API
---

## 📌 Funcionalidades

- ✅ Cadastro e listagem de garagens
- ✅ Cadastro e controle de motos
- ✅ Associação entre motos e garagens
- ✅ Persistência em banco relacional com EF Core

---

## 👥 Integrantes

- Caetano Penafiel Matos – RM557984  
- Kauã Fermino Zipf – RM558957  
- Victor Egídio Lira – RM556653  

---


## 🔍 Observações

A string de conexão com o banco Oracle foi definida diretamente no arquivo `appsettings.json`.  
Essa abordagem foi adotada porque, se usassemos o arquivo .env teriamos que mandar esse arquivo por fora e nós não saberiamos fazer isso, senão sendo inserido pelo Github.
