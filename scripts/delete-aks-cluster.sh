#!/bin/bash

# Delete all resources in the AKS cluster
echo "Deleting all resources in the AKS cluster..."
kubectl delete all --all

# Get the resource group name
RESOURCE_GROUP=$(az aks show --name akhDemoAKSCluster --query resourceGroup -o tsv)

# Delete the AKS cluster
echo "Deleting AKS cluster..."
az aks delete --name akhDemoAKSCluster --resource-group $RESOURCE_GROUP --yes --no-wait

# Delete the resource group
echo "Deleting resource group..."
az group delete --name $RESOURCE_GROUP --yes --no-wait

# Remove the cluster from kubectl config
echo "Removing cluster from kubectl config..."
kubectl config delete-context akhDemoAKSCluster
kubectl config delete-cluster akhDemoAKSCluster

echo "Deletion process initiated. It may take several minutes to complete."