# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.vm.box = "ubuntu/xenial64"

  config.ssh.forward_agent = true

  config.vm.network :private_network, ip: "192.168.50.50"
  config.vm.synced_folder ".", "/setup"
  config.vm.synced_folder "..", "/workspace"

  config.vm.provision :shell, privileged: true, inline: "cd /setup/setup-system && ./setup.sh", env: { "FEATURES" => "go,ruby,rust,swift,gcloud,awscli" }
  config.vm.provision :shell, privileged: false, inline: "cd /setup/setup-user && ./setup.sh"
end
