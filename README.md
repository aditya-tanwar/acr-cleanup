Title: Azure Container Registry Cleanup GitHub Action

Description:

This GitHub Action cleans up Azure Container Registry (ACR) repositories by deleting old manifest tags.

Usage:

To use this action, you will need to set the following environment variables:

az_service_principal: The service principal ID for your Azure account.
az_password: The service principal password for your Azure account.
az_tenant: The tenant ID for your Azure account.
acr_registry_name: The name of your Azure Container Registry.
repo: The name of the ACR repository to be cleaned up.
Once you have set the environment variables, you can add the following action to your GitHub workflow:

YAML
name: Clean up ACR repository

on:
  push:
    branches:
      - main

jobs:
  build:
    runs-on: ubuntu-latest

    steps:
      - uses: actions/checkout@v3

      - name: Clean up ACR repository
        uses: ./.github/actions/acr-cleanup@v1
        with:
          az_service_principal: ${{ secrets.AZURE_SERVICE_PRINCIPAL }}
          az_password: ${{ secrets.AZURE_PASSWORD }}
          az_tenant: ${{ secrets.AZURE_TENANT }}
          acr_registry_name: ${{ secrets.ACR_REGISTRY_NAME }}
          repo: ${{ secrets.ACR_REPOSITORY }}
Use code with caution. Learn more
How it works:

This action works by first fetching a list of all the manifest tags in the given ACR repository. Then, it sorts the tags by date in descending order and selects the first 7 tags to be retained. All other tags are then deleted from the ACR.

Limitations:

This action only deletes manifest tags. It does not delete the underlying manifests and layer data.
This action does not support deleting ACR repositories.
Contributing:

If you have any suggestions or bug reports, please feel free to open an issue on this repository.