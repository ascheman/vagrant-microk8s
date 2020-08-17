# -*- mode: ruby -*-
# vi: set ft=ruby :

name = ENV['VAGRANT_NAME'] || "k8s-develop"
# Memory settings for "minimal" environment
memory = ENV['VAGRANT_MEMORY'] || 8192
ip_unique = ENV['VAGRANT_IP_UNIQUE'] || "45"
port_unique = ENV['VAGRANT_PORT_UNIQUE'] || "45"
box = ENV['VAGRANT_BOX'] || "bento/ubuntu-20.04"

Vagrant.configure("2") do |boxname|
  # Generic/Defaults
  boxname.vm.box = box
  boxname.vm.hostname = name
  # Mount-Sync this explicitely - otherwise some boxes will only rsync the folder
  boxname.vm.synced_folder ".", "/vagrant"
  boxname.vm.synced_folder "cache/apt-archives", "/var/cache/apt/archives"
  # boxname.vm.synced_folder "cache/snapd", "/var/cache/snapd"

  boxname.vm.provider "virtualbox" do |vbox, override|
    vbox.name = name
    vbox.memory = memory
    # Cf. https://github.com/chef/bento/issues/682 for bento/ubuntu 2.3.x boxes
    vbox.customize ["modifyvm", :id, "--cableconnected1", "on"]
    # override.vm.network "private_network", ip: "192.168.50.#{ip_unique}", virtualbox__intnet: true
    # SSH
    override.vm.network "forwarded_port", guest: 22, host: "#{port_unique}022"
    # k8s Ingress HTTP
    override.vm.network "forwarded_port", guest: 80, host: "#{port_unique}080"
    # k8s Ingress HTTPS
    override.vm.network "forwarded_port", guest: 443, host: "#{port_unique}443"
    # k8s API HTTPS
    override.vm.network "forwarded_port", guest: 16443, host: "#{port_unique}643"
    # Docker
    # override.vm.network "forwarded_port", guest: 2375, host: "#{port_unique}375"
    # Docker Registry
    # override.vm.network "forwarded_port", guest: 5000, host: "#{port_unique}050"
    # Docker Registry UI
    # override.vm.network "forwarded_port", guest: 8055, host: "#{port_unique}055"
  end

  boxname.vm.provision "shell", path: "bin/install-all.sh"

end
