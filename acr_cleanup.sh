#!/bin/bash

# The below command is going to take inputs from the github actions env variables

az login --service-principal -u $az_service_principal -p $az_password --tenant $az_tenant

# Set the Azure Container Registry name

acr_registry_name="<acr_registry_name>"

# Set the repository name that needs to be cleaned up

repo="<acr_repository_name>"


# Fetching all the repository in the given acr registry

echo "FETCHING ALL THE REPOSITORIES FROM THE ACR REGISTRY --> ${acr_registry_name}"
echo ""
all_repos=$(az acr repository list -n ${acr_registry_name} | jq .[] | sed 's/"//g')
echo ""
echo $all_repos
echo ""

# The below line has to be uncommented to check the loops 

#for repo in $all_repos; do

        # Get a list of the first 7 images depending on the date ( descending order - From latest to oldest )
        
        echo "FETCHING THE LATEST 7 MANIFEST TAGS FROM THE REPOSITORY ------> ${repo}"
        echo ""
        retained_tags=$(az acr manifest list-metadata -r ${acr_registry_name} -n ${repo} --top 7 --orderby time_desc | jq ".[].tags[]")
        echo ""
        echo $retained_tags
        echo ""
        echo ""
        

        # Get the list of all the manifests tags in the provided repository of the given acr registry

        echo "LISTING ALL THE MANIFEST TAGS FROM THE REPOSITORY ------> ${repo}"
        echo ""
        all_manifests=$(az acr manifest list-metadata -r ${acr_registry_name} -n ${repo} | jq -c '.[].tags[]?')
        echo ""
        echo $all_manifests
        echo ""
        echo ""


        # Fetching the list for the tags that have to be removed

        echo "LISTING THE MANIFEST TAGS THAT HAVE TO BE REMOVED FROM THE REPOSITORY ------>  ${repo}"
        echo ""
        to_be_deleted=$(echo ${retained_tags[@]} ${all_manifests[@]} | tr ' ' '\n' | sort | uniq -u |  sed 's/"//g')
        echo ""
        echo $to_be_deleted
        echo ""
        echo ""
        

        # Iterate over the list of tags and delete the manifest for each tag from the ACR
        echo "DELETING THE OLDER TAGS FROM THE REPOSITORY ------> ${repo}"
        echo ""

        # UNCOMMENT THE BELOW LINES TO DELETE THE OLD REPOSITORIES

        #for tag in ${to_be_deleted}; do
        #      az acr manifest delete -r ${acr_registry_name} -n ${repo}:${tag} -y
        #done
        echo ""
        echo ""

        # Lisiting the tags after the cleaning of the repository

        echo "LISTING ALL THE MANIFEST TAGS LEFT IN THE ${repo} REPOSITORY AFTER CLEANING"
        echo ""
        final_manifests=$(az acr manifest list-metadata -r ${acr_registry_name} -n ${repo} | jq -c '.[].tags[]?')
        echo ""
        echo $final_manifests
#done