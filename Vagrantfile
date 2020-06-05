Vagrant.configure(2) do |config|
        config.vm.define "docker-sqarm-box" do |devbox|
                devbox.vm.box = "ubuntu/bionic64"
                devbox.vm.network "forwarded_port", guest: 2376, host: 2376
                devbox.vm.network "private_network", ip: "192.168.199.9"
                devbox.vm.hostname = "docker-swarm-box"
                devbox.vm.provision "shell", path: "scripts/install.sh"
                devbox.disksize.size = '50GB'        
                devbox.vm.provider "virtualbox" do |vb|
                    vb.name = 'docker-compose-vm'
                    vb.memory = 4096
                    vb.cpus = 1
                    vb.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
                    vb.customize ["modifyvm", :id, "--natdnsproxy1", "on"]
                end
        end
        
end
