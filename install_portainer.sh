#!/usr/bin/env bash

# Initialize Portainer
echo "[TASK 1] Initialize Portainer"

helm repo add portainer https://portainer.github.io/k8s/
helm repo update
helm install --set persistence.storageClass=openebs-jiva-default --create-namespace portainer -n portainer portainer/portainer

# to use ClusterIP
#helm install --set persistence.storageClass=openebs-jiva-default --create-namespace -n portainer portainer portainer/portainer --set service.type=ClusterIP
