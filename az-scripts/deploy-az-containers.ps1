# you may need to set a different execution policy for powershell to run this file
# please refer to https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_execution_policies?view=powershell-7.2
# to learn about powershell execution policies


# Install the Azure Container Apps extension for the CLI.
az extension add --name containerapp --upgrade

# Now that the extension is installed, register the Microsoft.App namespace.
az provider register --namespace Microsoft.App

# Register the Microsoft.OperationalInsights provider for the Azure Monitor Log Analytics Workspace if you have not used it before.
az provider register --namespace Microsoft.OperationalInsights

# Set environment variables
$RESOURCE_GROUP = "banki-rg"
$LOCATION = "canadacentral" 
$CONTAINERAPPS_ENVIRONMENT = "banki-prod-env"
$REGISTRY_NAME = "bankiacr.azurecr.io"

# Create an Environment, an Environment for container apps bounds containers to the same Virtual Network and write logs to the same Log Analytics workspace.

az containerapp env create `
    --name $CONTAINERAPPS_ENVIRONMENT `
    --resource-group $RESOURCE_GROUP `
    --location $LOCATION

docker tag banki-api $REGISTRY_NAME'/banki/api'

docker push $REGISTRY_NAME'/banki/api'



az acr repository list --name $REGISTRY_NAME --output table

Write-Output 'PUSHED CONTAINER=============================='

az acr login --name $REGISTRY_NAME

az containerapp create `
    --name api `
    --resource-group $RESOURCE_GROUP `
    --environment $CONTAINERAPPS_ENVIRONMENT `
    --image $REGISTRY_NAME/banki/api:latest `
    --target-port 80 `
    --ingress 'external' `
    --query properties.configuration.ingress.fqdn `
    --registry-server $REGISTRY_NAME
