  # vagrant plugin install vagrant-vbguest vagrant-winnfsd
  Vagrant.configure("2") do |config|
  config.vbguest.auto_update = false
  
  config.vm.define "repocache" do |repocache|
    repocache.vm.box = "debian/stretch64"
 	#repocache.vm.box_version = "9.4.0"
	repocache.vm.hostname ="repocache"
	repocache.vm.network :forwarded_port, guest: 3142, host: 3142
    repocache.vm.network "private_network", ip: "192.168.56.10"
    repocache.vm.network "public_network", ip: "192.168.56.10"
    repocache.vm.provision "shell", path: "install_repo.sh"
	repocache.vm.synced_folder "shared/", "/shared", nfs: true
    repocache.vm.provider "virtualbox" do |vb|
      vb.memory = "300"
      vb.gui = false
      vb.cpus = 2
	end
  end 
  
  config.vm.define "repoclient1" do |repoclient1|
    repoclient1.vm.box = "debian/stretch64"
	#repoclient1.vm.box_version = "9.4.0"
    repoclient1.vm.hostname ="repoclient1"
    repoclient1.vm.network "private_network", ip: "192.168.56.5"
    repoclient1.vm.network "public_network", ip: "192.168.56.5"
	repoclient1.vm.synced_folder "shared/", "/shared", nfs: true
	repoclient1.vm.provision "shell", path: "install_repo_client.sh"
    repoclient1.vm.provider "virtualbox" do |vb|
      vb.memory = "300"
      vb.gui = false
      vb.cpus = 2
	end
  end 
  
  config.vm.define "kmaster" do |kmaster|
    kmaster.vm.box =  "debian/stretch64"
	#kmaster.vm.box_version = "9.4.0"
    kmaster.vm.hostname ="kmaster"
    kmaster.vm.network :forwarded_port, guest: 8001, host: 8001
	kmaster.vm.network :forwarded_port, guest: 80, host: 80
    kmaster.vm.network "private_network", ip: "192.168.56.2"
    kmaster.vm.network "public_network", ip: "192.168.56.2"
    kmaster.vm.provision "shell", path: "install_master.sh"
	kmaster.vm.synced_folder "shared/", "/shared", nfs: true
    kmaster.vm.provider "virtualbox" do |vb|
      vb.memory = "1200"
      vb.gui = false
      vb.cpus = 2
    end
  end  
  config.vm.define "node1" do |node1|
    node1.vm.box = "debian/stretch64"
	#node1.vm.box_version = "9.4.0"
	#node1.vm.network :forwarded_port, guest: 80, host: 80
    node1.vm.hostname ="node1-192-168-56-3"
    node1.vm.network "private_network", ip: "192.168.56.3"
    node1.vm.network "public_network", ip: "192.168.56.3"
    node1.vm.provision "shell", path: "install_node.sh"
	node1.vm.synced_folder "shared/", "/shared", nfs: true
    node1.vm.provider "virtualbox" do |vb|
      vb.memory = "1200"
      vb.gui = false
      vb.cpus = 2
    end
  end  
  config.vm.define "node2" do |node2|
    node2.vm.box = "debian/stretch64"
	#node2.vm.box_version = "9.4.0"
    node2.vm.hostname ="node2-192-168-56-4"
    node2.vm.network "private_network", ip: "192.168.56.4"
    node2.vm.network "public_network", ip: "192.168.56.4"
    node2.vm.provision "shell", path: "install_node.sh"
	node2.vm.synced_folder "shared/", "/shared", nfs: true
    node2.vm.provider "virtualbox" do |vb|
    vb.memory = "1200"
      vb.gui = false
      vb.cpus = 2
	end
  end  
end
