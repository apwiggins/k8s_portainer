#!/usr/bin/env bash

helm repo add bitnami https://charts.bitnami.com/bitnami
helm install my-release bitnami/nginx-ingress-controller
