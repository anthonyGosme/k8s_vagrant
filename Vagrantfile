  # to try
  #config.vm.box = "debian/jessie64"
  #config.vm.box_version = "8.10.0"
  
  Vagrant.configure("2") do |config|
  config.vbguest.auto_update = false
  config.vm.define "master" do |master|
    master.vm.box = "debian/contrib-stretch64"
    master.vm.hostname ="master"
    master.vm.network :forwarded_port, guest: 8001, host: 8001
    master.vm.network "private_network", ip: "192.168.56.2"
    master.vm.network "public_network", ip: "192.168.56.2"
    master.vm.provision "shell", path: "install_master.sh"
    master.vm.provider "virtualbox" do |vb|
      vb.memory = "1200"
      vb.gui = false
      vb.cpus = 2
    end
  end  
  config.vm.define "node1" do |node1|
    node1.vm.box = "debian/contrib-stretch64"
    node1.vm.hostname ="node1"
    node1.vm.network "private_network", ip: "192.168.56.3"
    node1.vm.network "public_network", ip: "192.168.56.3"
    node1.vm.provision "shell", path: "install_node.sh"
    node1.vm.provider "virtualbox" do |vb|
      vb.memory = "1200"
      vb.gui = false
      vb.cpus = 2
    end
  end  
  config.vm.define "node2" do |node2|
    node2.vm.box = "debian/contrib-stretch64"
    node2.vm.hostname ="node2"
    node2.vm.network "private_network", ip: "192.168.56.4"
    node2.vm.network "public_network", ip: "192.168.56.4"
    node2.vm.provision "shell", path: "install_node.sh"
    node2.vm.provider "virtualbox" do |vb|
      vb.memory = "1200"
      vb.gui = false
      vb.cpus = 2
	end
  end  
  

  config.vm.define "repoclient1" do |repoclient1|
    repoclient1.vm.box = "debian/contrib-stretch64"
    repoclient1.vm.hostname ="repoclient1"
    repoclient1.vm.network "private_network", ip: "192.168.56.5"
    repoclient1.vm.network "public_network", ip: "192.168.56.5"
	repoclient1.vm.provision "shell", path: "install_repo_client.sh"
    repoclient1.vm.provider "virtualbox" do |vb|
      vb.memory = "300"
      vb.gui = false
      vb.cpus = 2
	end
  end 
  
  config.vm.define "repoclient2" do |repoclient2|
    repoclient2.vm.box = "debian/contrib-stretch64"
    repoclient2.vm.hostname ="repoclient2"

    repoclient2.vm.network "private_network", ip: "192.168.56.6"
    repoclient2.vm.network "public_network", ip: "192.168.56.6"
    repoclient2.vm.provision "shell", path: "install_repo_client.sh"
    repoclient2.vm.provider "virtualbox" do |vb|
      vb.memory = "300"
      vb.gui = false
      vb.cpus = 2
	end
  end 
  
  config.vm.define "repocache" do |repocache|
    repocache.vm.box = "debian/contrib-stretch64"
    repocache.vm.hostname ="repocache"
	repocache.vm.network :forwarded_port, guest: 3142, host: 3142
    repocache.vm.network "private_network", ip: "192.168.56.10"
    repocache.vm.network "public_network", ip: "192.168.56.10"
    repocache.vm.provision "shell", path: "install_repo.sh"
    repocache.vm.provider "virtualbox" do |vb|
      vb.memory = "300"
      vb.gui = false
      vb.cpus = 2
	end
  end 
  
end
