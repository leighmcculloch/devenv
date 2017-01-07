# -*- mode: ruby -*-
# vi: set ft=ruby :

VAGRANT_COMMAND = ARGV[0]

Vagrant.configure("2") do |config|
  config.vm.box = "ubuntu/xenial64"

  username = ENV["USER"]

  config.ssh.username = username if VAGRANT_COMMAND == "ssh"
  config.ssh.forward_agent = true

  config.vm.network :private_network, ip: "192.168.50.50"
  config.vm.synced_folder ".", "/setup"
  config.vm.synced_folder "..", "/workspace"

  config.vm.provision :shell, privileged: true, inline: "cd /setup/setup-system && ./setup.sh", env: { "FEATURES" => ENV["FEATURES"] }
  config.vm.provision :shell, privileged: true, inline: "adduser-github #{username}"
  config.vm.provision :shell, privileged: true, inline: "cat ~#{config.ssh.username}/.ssh/authorized_keys >> ~#{username}/.ssh/authorized_keys"
  config.vm.provision :shell, privileged: true, inline: "adduser #{username} sudo"
  config.vm.provision :shell, privileged: true, inline: "reboot"
end
