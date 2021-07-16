# -*- mode: ruby -*-
# vi: set ft=ruby :

ENV['VAGRANT_NO_PARALLEL'] = 'yes'

Vagrant.configure(2) do |config|

    config.vm.provision "shell", path: "bootstrap.sh"

    # Kubernetes Master Server
    config.vm.define "kmaster" do |kmaster|
        kmaster.vm.box = "bento/ubuntu-20.04"
        kmaster.vm.hostname = "kmaster.example.com"
        kmaster.vm.network "public_network", bridge: "enp4s0"
        kmaster.vm.network "private_network", ip: "172.42.42.100"
        #kmaster.vm.network "forwarded_port", guest: 80, host: 7080                                     
        #kmaster.vm.network "forwarded_port", guest: 443, host: 7443
        #kmaster.vm.network "forwarded_port", guest: 9000, host: 9100
        # port forward for portainer
        kmaster.vm.network "forwarded_port", guest: 30777, host: 30777
        kmaster.vm.provider "virtualbox" do |v|
            v.name = "kmaster"
            v.memory = 4096
            v.cpus = 2
        #    v.customize ["modifyvm", :id, "--nicpromisc1", "allow-all"]
        end
        #kmaster.vm.provision "shell", path: "bootstrap_kmaster.sh"
        kmaster.vm.provision "shell", path: "bootstrap_kmaster_flannel.sh"
        kmaster.vm.provision "shell", path: "bootstrap_kmaster_helm.sh"
        kmaster.vm.provision "file", source: "modify_arp.sh",     destination: "$HOME/0_modify_arp.sh"
kmaster.vm.provision "file", source: "install_openebs.sh",     destination: "$HOME/1_install_openebs.sh"
        kmaster.vm.provision "file", source: "install_portainer.sh",   destination: "$HOME/2_install_portainer.sh"
        kmaster.vm.provision "file", source: "metallb-values.yaml",    destination: "$HOME/metallb-values.yaml"
        kmaster.vm.provision "file", source: "install_metallb.sh",     destination: "$HOME/3_install_metallb.sh"
        kmaster.vm.provision "file", source: "install_nginx_ingress.sh", destination: "$HOME/4_install_nginx_ingress.sh"
        kmaster.vm.provision "file", source: "install_nginx_cafe.sh", destination: "$HOME/5_install_nginx_cafe.sh"
    end 

    NodeCount = 3 
    # Kubernetes Worker Nodes
    (1..NodeCount).each do |i|
        config.vm.define "kworker#{i}" do |workernode|
            workernode.vm.box = "bento/ubuntu-20.04"
            workernode.vm.hostname = "kworker#{i}.example.com"
            workernode.vm.network "private_network", ip: "172.42.42.10#{i}"
            workernode.vm.provider "virtualbox" do |v|
                v.name = "kworker#{i}"
                v.memory = 4096
                v.cpus = 2
            end
            workernode.vm.provision "shell", path: "bootstrap_kworker.sh"
        end
    end
end
