# Easy k8s cluster with Portainer

Quickly set up a Kubernetes cluster on virtualbox and manage with Portainer. Requires 16GB of RAM
## Portainer
Portainer cluster explorer and cluster dashboard can be used to externally manage the cluster.  Ideal for lab or home use.
- Portainer is accessible remotely, permitting remote management of the k8s cluster
- available about 5 minutes after Vagrant finishes provisioning steps
- Port 30777 is forwarded for access to Portainer management

## Vagrant
k8s cluster is installed using vagrant
- uses virtualbox to create 4 VMs; adjust Vagrantfile to add additional workers
- spins up a k8s master node (kmaster) requiring 4 GB RAM
- spins up 3 k8s worker nodes (kworker) requiring 4 GB RAM each
- k8s master and workers share a private net 172.42.42.100/24
- k8s master uses 172.42.42.100, while workers use 172.42.42.101 incrementing by 1 for each additional worker added
- k8s cluster is NAT'ed
- OpenEBS script needs to be added separately on kmaster
- Portainer script needs to be added separately on kmaster
- Portainer port is forwarded using  virtualbox port forwarding as a convenience to permit remote management of the cluster

## Installation
1.	'tar zxf k8s_portainer.tar.gz'
2.	`cd k8s_portainer`
3.	`cp bootstrap_kmaster_flannel.sh bootstrap_kmaster.sh # optional to use flannel`
4.	`vagrant up`
5.	`vagrant ssh kmaster -c 'kubectl get nodes -o wide'
6. Wait about 5 minutes to permit Rancher to spin up
7. 'vagrant ssh kmaster'

## Adjust IP Addresses for Load Balancer
To run the load balancer using VirtualBox, we will use a bridged network interface (eth1) instead of the NAT interface (eth0).  To get the IP address for eth1
'ip -br addr sho dev eth1'
This address will be used to adjust the metallb load balancer to use the VirtualBox bridged interface (eth1).

Use your editor to adjust metallb.yaml:
'configInline:
   address-pools:
     - name: default
       protocol: layer2
       addresses:
       - 192.168.1.226/30' <== add the eth1 ip address here

8. Execute 5 scripts to install OpenEBS storage, Portainer, MetalLB, Nginx ingress, and cafe example

## Portainer
From an external browser on a remote machine, https://[VirtualBox host IP]:30777 via the forwarded port on eth1 which should be on your local physical network

In Portainer, in the 'Cluster==>Setup (Endpoints>Local>Kubernetes configuration) screen:
1. Ensure that Allow users to use external load balancer is enabled.
2. Configure Ingress Controller:
    Ingress class as my-nginx-ingress
    Type as nginx
3. Set Storage Options to use openebs-jiva-default
4. save Configuration'

## Ingress
One additional step is required to make the ingress available via the load balancer.  Using your local subnet DNS (I use Pihole), add a Local DNS entry for 'cafe.example.com' and set it to use the IP address for eth1
Once the Local DNS entry is in pihole, you can now access the installed coffee and tea services using https://cafe.example.com/coffee and https://cafe.example.com/tea.

The service should respond so:
'Server address: 10.244.1.6:8080
Server name: coffee-6f4b79b975-v4v9b
Date: 15/Jul/2021:23:52:50 +0000
URI: /coffee
Request ID: 5f5f26974434b9b5243c540e9bc14636'


## References:
- See https://blog.exxactcorp.com/building-a-kubernetes-cluster-using-vagrant/
- Forked from https://exxsyseng@bitbucket.org/exxsyseng/k8s_ubuntu.git
