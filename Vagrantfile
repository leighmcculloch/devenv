# -*- mode: ruby -*-
# vi: set ft=ruby :

VAGRANT_COMMAND = ARGV[0]

Vagrant.configure("2") do |config|
  config.vm.box = "ubuntu/xenial64"
  config.vm.provider "virtualbox" do |v|
    v.memory = 4096
  end

  username = ENV["USER"]

  config.ssh.username = username if VAGRANT_COMMAND == "ssh"
  config.ssh.forward_agent = true

  config.vm.synced_folder ".", "/setup"
  config.vm.synced_folder "..", "/workspace", :mount_options => ["ro"]

  config.vm.provision :shell, privileged: true, inline: "cd /setup/setup-system && ./setup.sh", env: { "FEATURES" => ENV["FEATURES"] }
  config.vm.provision :shell, privileged: true, inline: "adduser-github #{username}"
  config.vm.provision :shell, privileged: true, inline: "adduser #{username} sudo"
  config.vm.provision :shell, privileged: true, inline: "reboot"
end
