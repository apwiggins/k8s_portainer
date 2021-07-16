#!/usr/bin/env bash

mkdir cafe
cd cafe

wget https://raw.githubusercontent.com/nginxinc/kubernetes-ingress/v1.11.3/examples/complete-example/cafe.yaml
wget https://raw.githubusercontent.com/nginxinc/kubernetes-ingress/v1.11.3/examples/complete-example/cafe-secret.yaml
wget https://raw.githubusercontent.com/nginxinc/kubernetes-ingress/v1.11.3/examples/complete-example/cafe-ingress.yaml

kubectl create -f ./cafe.yaml
kubectl create -f ./cafe-secret.yaml
kubectl create -f ./cafe-ingress.yaml
