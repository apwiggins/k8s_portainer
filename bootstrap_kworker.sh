#!/bin/bash

KMASTER='172.42.42.100'

# Join worker nodes to the Kubernetes cluster
echo "[TASK 1] Join node to Kubernetes Cluster"
apt-get  install -y sshpass >/dev/null 2>&1
#sshpass -p "kubeadmin" scp -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no kmaster.example.com:/joincluster.sh /joincluster.sh 2>/dev/null
sshpass -p "kubeadmin" scp -o StrictHostKeyChecking=no $KMASTER:/joincluster.sh /joincluster.sh
bash /joincluster.sh #>/dev/null 2>&1

echo "[TASK 2} starting iscsid]"
sudo systemctl start iscsid
sudo systemctl status iscsid
