# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.vm.box = "debian/stretch64"

  config.vm.provision "docker"

  config.vm.provision "shell", inline: <<-SHELL
    apt-get update
    apt-get -y install make
    cd /vagrant && make build
  SHELL
end
