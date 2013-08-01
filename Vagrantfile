# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|

  # Default configuration for Virtualbox
  config.vm.box = 'debian-wheezy-64'
  config.vm.box_url = 'https://www.dropbox.com/s/00ndb5ea4k8hyoy/debian-wheezy-64.box'

  # Create a host-managed private network
  config.hostmanager.enabled = false
  config.hostmanager.manage_host = false
  config.hostmanager.ignore_private_ip = false
  config.hostmanager.include_offline = true

  # VM-specific digital ocean config
  config.vm.provider :digital_ocean do |provider|
    provider.image = 'Debian 7.0 x64'
    provider.region = 'New York 1'
    provider.size = '512MB'
  end

  # General provisioning #1: install salt minion
  config.vm.provision :shell,
    :inline => 'wget -q -O - http://bootstrap.saltstack.org | sudo sh'

  # General provisioning #2: update host file
  config.vm.provision :hostmanager

  # Specific options for NGINX01
  config.vm.define :nginx01 do |node|
    node.vm.hostname = 'nginx01.intranet'
    node.vm.network :private_network, ip: '10.1.14.100'
    node.vm.synced_folder 'salt/roots/', '/srv/'

    node.vm.provision :salt do |salt|
      salt.minion_config = 'salt/minion'
      salt.run_highstate = true
      salt.verbose = true
    end
  end

end
