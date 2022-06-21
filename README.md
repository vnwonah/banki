# BANKI

Banki is a sample Fintech Product built entirely with [dotnet](https://dot.net) and runs on [Azure](https://portal.azure.com).

## Scope

Banki is planned to have the following projects: 

- A Dotnet 7 API
- A Blazor Frontend for Administration
- A Blazor Frontend for Customer Services on the Web
- A MAUI Android/iOS/Windows App for Customer Services on Mobile

## Design

Banki's infrastructure is designed to be Cloud First, leveraging as much Azure Services as possible.

## Deployment

### Deploy APIs to Azure Container Apps

Deploying Banki to Azure involves installing the Azure CLI for interacting with our Azure account from terminal, creating an [Azure Container Registry instance](https://azure.microsoft.com/en-us/services/container-registry/) for  building, storing, and managing our container images, and running deployment scripts for Powershell and Bash. These scripts leverage the Azure ClI which is available for Windows, Mac and Linux. Follow the steps below to deploy to azure container apps.

- [Install Azure CLI](https://docs.microsoft.com/en-us/cli/azure/install-azure-cli)
- Login to Azure Account by running `az login` in terminal and complete the azure cli login process
- Start Docker Desktop 
- Create an (Azure Container Registry (ACR) instance by navigating to az-scripts and running create-az-acr.ps1 or create-az-acr.sh. This script creates the ACR instance and logs into it with your local docker installation so banki containers can be pushed to ACR, take a minute to look at the script to see how this is handled.
- Navigate to the az-scripts directory and run the deploy-az-containers.ps1 script on powershell or deploy-az-containers.sh script on bash/zsh
- Confirm that you can see deployed resources on azure portal and can access endpoints on a web browser
- To delete and cleanup resources from Azure run the deploy-az-containers.ps1 or deploy-az-containers.sh depending on your platform

## Technologies

Banki is currently using the following technologies in Production/Development:

- Dotnet 7
- Azure Container Services
- Docker/Docker Compose
- C# 11