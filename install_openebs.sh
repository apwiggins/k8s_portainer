#!/usr/bin/env bash

echo "TASK[1] - starting iscsid"
sudo systemctl start iscsid
#sudo systemctl status iscsid

echo "TASK[2] - installing OpenEBS"
helm repo add openebs https://openebs.github.io/charts
helm repo update
helm install openebs --namespace default openebs/openebs
echo "sleeping 90s to let OpenEBS spin up"
sleep 90s
kubectl patch storageclass openebs-jiva-default -p '{"metadata": {"annotations":{"storageclass.kubernetes.io/is-default-class":"true"}}}'
echo "installed storage classes"
kubectl get sc
