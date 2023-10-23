
This script cleans up an Azure Container Registry (ACR) repository by deleting old images. It takes two inputs:

az_service_principal: The service principal name for the Azure account with access to the ACR registry.
az_password: The password for the service principal.
az_tenant: The tenant ID for the Azure account.
The script performs the following steps:

Logs in to Azure using the service principal credentials.
Fetches a list of all the repositories in the ACR registry.
For each repository, gets a list of the first 7 images, sorted by date in descending order.
Gets a list of all the image tags in the repository.
Compares the two lists to identify the image tags that are not in the top 7.
Deletes the image tags that are not in the top 7.
Benefits of using the script:

The script helps to keep your ACR registry clean and organized.
It can help to reduce the storage costs associated with your ACR registry.
The script can be automated to run on a regular basis, ensuring that your ACR registry is always clean.
How to use the script:

To use the script, you will need to create a new workflow in your GitHub repository. The workflow should have the following steps:

Use a checkout step to check out the code from your repository.
Use a run step to run the script.
Use a commit step to commit the changes to your repository.
Once you have created the workflow, push the changes to your repository. The workflow will be triggered and the script will be executed.
