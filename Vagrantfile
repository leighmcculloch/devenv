# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.vm.box = "ubuntu/wily64"

  config.ssh.forward_agent = true

  config.vm.network :private_network, ip: "192.168.50.50"
  config.vm.synced_folder ".", "/setup"
  # config.vm.synced_folder "~/dev", "/dev"

  config.vm.provision :shell, privileged: true, inline: "cd /setup-system && ./setup.sh"
  config.vm.provision :shell, privileged: false, inline: "cd /setup-user && ./setup.sh"
end
