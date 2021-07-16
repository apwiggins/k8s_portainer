#!/usr/bin/env bash


helm repo add metallb https://metallb.github.io/metallb
helm repo update

helm install metallb metallb/metallb -f metallb-values.yaml

echo "kubectl get services     will show the current IP address of the load balancer"
