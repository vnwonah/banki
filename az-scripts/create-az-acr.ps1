# you may need to set a different execution policy for powershell to run this file
# please refer to https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_execution_policies?view=powershell-7.2
# to learn about powershell execution policies

# Set environment variables
$RESOURCE_GROUP = "banki-rg"
$LOCATION = "canadacentral" 
$REGISTRY_NAME = "bankiacr"

# Create a resource group to manage all banki resources
az group create `
    --name $RESOURCE_GROUP `
    --location $LOCATION

# Register the Microsoft.ContainerRegistry provider for the Azure Monitor Log Analytics Workspace if you have not used it before.
az provider register --namespace Microsoft.ContainerRegistry

# Create Azure Container Registry (ACR) instance
az acr create `
    --name $REGISTRY_NAME `
    --resource-group $RESOURCE_GROUP `
    --sku Basic `
    --admin-enabled true

# Retrieve ACR instance credentials and store to variable
$CREDENTIALS = az acr credential show --resource-group $RESOURCE_GROUP --name $REGISTRY_NAME | ConvertFrom-Json
Write-Output $CREDENTIALS.username
Write-Output $CREDENTIALS.passwords[0].value

# Login to ACR from docker
docker login $REGISTRY_NAME'.azurecr.io' --username $CREDENTIALS.username --password $CREDENTIALS.passwords[0].value