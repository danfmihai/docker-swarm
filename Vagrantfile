Vagrant.configure(2) do |config|
        config.vm.define "docker-swarm-master", primary: true do |master|
                master.vm.box = "ubuntu/bionic64"
                master.vm.network "forwarded_port", guest: 2376, host: 2376
                master.vm.network :forwarded_port, guest: 22, host: 2222, id: "ssh"
                master.vm.network "private_network", ip: "192.168.199.9"
                master.vm.hostname = "docker-swarm-box"
                master.vm.provision "shell", path: "scripts/install.sh"
                master.disksize.size = '50GB' 
                master.ssh.insert_key = false      
                master.vm.provider "virtualbox" do |vb|
                    vb.name = 'docker-compose-master'
                    vb.memory = 4096
                    vb.cpus = 1
                    vb.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
                    vb.customize ["modifyvm", :id, "--natdnsproxy1", "on"]
                end
        end
        
        config.vm.define "docker-swarm-worker1" do |worker1|
                worker1.vm.box = "ubuntu/bionic64"
                worker1.vm.network "forwarded_port", guest: 2376, host: 2376
                worker1.vm.network "private_network", ip: "192.168.199.10"
                worker1.vm.network :forwarded_port, guest: 22, host: 2223, id: "ssh"
                worker1.vm.hostname = "docker-swarm-worker1"
                worker1.vm.provision "shell", path: "scripts/install.sh"
                worker1.disksize.size = '50GB' 
                worker1.ssh.insert_key = false      
                worker1.vm.provider "virtualbox" do |vb|
                    vb.name = 'docker-compose-worker1'
                    vb.memory = 4096
                    vb.cpus = 1
                    vb.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
                    vb.customize ["modifyvm", :id, "--natdnsproxy1", "on"]
                end
        end

        config.vm.define "docker-swarm-worker2" do |worker2|
                worker2.vm.box = "ubuntu/bionic64"
                worker2.vm.network "forwarded_port", guest: 2376, host: 2376
                worker2.vm.network "private_network", ip: "192.168.199.11"
                worker2.vm.network :forwarded_port, guest: 22, host: 2224, id: "ssh"
                worker2.vm.hostname = "docker-swarm-worker2"
                worker2.vm.provision "shell", path: "scripts/install.sh"
                worker2.disksize.size = '50GB' 
                worker2.ssh.insert_key = false      
                worker2.vm.provider "virtualbox" do |vb|
                    vb.name = 'docker-compose-worker2'
                    vb.memory = 4096
                    vb.cpus = 1
                    vb.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
                    vb.customize ["modifyvm", :id, "--natdnsproxy1", "on"]
                end
        end
        

end
