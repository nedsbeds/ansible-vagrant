# -*- mode: ruby -*-
# vi: set ft=ruby :


## Load box options

require "./VagrantConfig.rb"


## Configure the box

Vagrant.configure(2) do |config|
  
  # For a complete reference, please see the online documentation at
  # https://docs.vagrantup.com.
  
  
  ## Box specification
  
  # Every Vagrant development environment requires a box. You can search for
  # boxes at https://atlas.hashicorp.com/search.
  config.vm.box = "ubuntu/trusty64"
  
  # Set the name of the box (as shown in Vagrant messages)
  config.vm.define VagrantConfig[:box][:box_name]
  
  # Set the guest's hostname
  config.vm.hostname = VagrantConfig[:box][:box_name].downcase
  
  
  ## Network
  
  # Create a private network, using the box number to determine the IP
  config.vm.network "private_network", ip: "10.10.10.#{VagrantConfig[:box][:box_number]}"
  
  # Forward ports for Apache, SSL, and MySQL, using the box number for the port component
  config.vm.network "forwarded_port", 
    guest: 80,
    host: "80#{VagrantConfig[:box][:box_number]}"
  
  config.vm.network "forwarded_port", 
    guest: 443,
    host: "44#{VagrantConfig[:box][:box_number]}"
  
  config.vm.network "forwarded_port", 
    guest: 3306,
    host: "33#{VagrantConfig[:box][:box_number]}"
  
  # Specify ports that Vagrant may use for "handling port collisions and such"
  config.vm.usable_port_range = 2900..3000
  
  # Set a message for when `vagrant up` has finished
  config.vm.post_up_message = "'#{VagrantConfig[:box][:box_name]}' (box number: #{VagrantConfig[:box][:box_number]}) finished building"
  
  
  ## Filesystem
  
  # Share the Apache document root with the guest VM using vagrant-bindfs
  # First we share our host directory to /vagrant-nfs, then we use
  # bindfs to re-mount /vagrant-nfs to the real guest directory
  config.vm.synced_folder VagrantConfig[:apache][:local_document_root], "/vagrant-nfs", type: :nfs
  config.bindfs.bind_folder "/vagrant-nfs", VagrantConfig[:apache][:remote_document_root]
  
  
  ## SSH
  
  # Enable agent forwarding so that host SSH keys will be available on the guest
  config.ssh.forward_agent = true
  
  # Override default forwarded port for SSH
  config.vm.network :forwarded_port,
    guest: 22,
    host: "22#{VagrantConfig[:box][:box_number]}",
    id: "ssh",
    auto_correct: true
  
  
  ## Provider
  
  # Configure VirtualBox
  config.vm.provider "virtualbox" do |vb|
    
    # The name of the box, as it appears in VirtualBox
    vb.name = VagrantConfig[:box][:box_name]
    
    # CPU and memory allocation
    vb.cpus = 1
    vb.memory = 512
    
    # Cap CPU usage to 25% of host CPU
    vb.customize ["modifyvm", :id, "--cpuexecutioncap", "25"]
    
    # Use paravirtualised networking
    vb.customize ["modifyvm", :id, "--nictype1", "virtio"]
    
    # Use NAT for DNS
    vb.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
    vb.customize ["modifyvm", :id, "--natdnsproxy1", "on"]
    
    # Set time synchronisation frequency to 60 seconds
    vb.customize ["guestproperty", "set", :id, "/VirtualBox/GuestAdd/VBoxService/--timesync-set-threshold", 60000]
    
  end
  
  
  ## Provisioning
  
  # Ansible
  config.vm.provision "ansible" do |ansible|
    
    # Call the playbook
    ansible.playbook = "ansible/playbook.yaml"
    
    # Pass in box options
    ansible.extra_vars = VagrantConfig
    
  end
  
end
