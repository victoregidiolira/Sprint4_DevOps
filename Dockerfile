# Estágio 1: Build (Compilação)
# Assumindo .NET 8.0 - Verifique seu .csproj!
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /src

# Copia o arquivo .sln e os arquivos .csproj para restaurar dependências
COPY *.sln .
COPY MonitoringMottu.Domain/MonitoringMottu.Domain.csproj MonitoringMottu.Domain/
COPY MonitoringMottu.Application/MonitoringMottu.Application.csproj MonitoringMottu.Application/
COPY MonitoringMottu.Infrastructure/MonitoringMottu.Infrastructure.csproj MonitoringMottu.Infrastructure/
COPY MonitoringMottu.API/MonitoringMottu.API.csproj MonitoringMottu.API/

# Restaura as dependências de todos os projetos
RUN dotnet restore

# Copia todo o código-fonte restante
COPY . .
WORKDIR "/src/MonitoringMottu.API"
RUN dotnet publish -c Release -o /app/publish

# Estágio 2: Final (Produção)
# Use a mesma versão do .NET (ex: 8.0)
FROM mcr.microsoft.com/dotnet/aspnet:8.0 AS final
WORKDIR /app
COPY --from=build /app/publish .

# Expõe a porta padrão
EXPOSE 8080

# O ponto de entrada é a DLL da sua API
ENTRYPOINT ["dotnet", "MonitoringMottu.API.dll"]
