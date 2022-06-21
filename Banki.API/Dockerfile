FROM  mcr.microsoft.com/dotnet/nightly/aspnet:7.0.0-preview.5 AS base
WORKDIR /app
EXPOSE 80

ENV ASPNETCORE_URLS=http://+:80

# Creates a non-root user with an explicit UID and adds permission to access the /app folder
# For more info, please refer to https://aka.ms/vscode-docker-dotnet-configure-containers
RUN adduser -u 5678 --disabled-password --gecos "" appuser && chown -R appuser /app
USER appuser

FROM mcr.microsoft.com/dotnet/nightly/sdk:7.0.100-preview.5 AS build
WORKDIR /src
COPY ["Banki.API/Banki.API.csproj", "Banki.API/"]
RUN dotnet restore "Banki.API/Banki.API.csproj"
COPY . .
WORKDIR "/src/Banki.API"
RUN dotnet build "Banki.API.csproj" -c Release -o /app/build

FROM build AS publish
RUN dotnet publish "Banki.API.csproj" -c Release -o /app/publish /p:UseAppHost=false

FROM base AS final
WORKDIR /app
COPY --from=publish /app/publish .
ENTRYPOINT ["dotnet", "Banki.API.dll"]
