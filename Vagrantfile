# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|

  # Default configuration for Virtualbox
  config.vm.box = 'debian-wheezy-64'
  config.vm.box_url = 'https://www.dropbox.com/s/00ndb5ea4k8hyoy/debian-wheezy-64.box'

  # Name the VM
  config.vm.define :nginx01

  # Mount salt roots, so we can do masterless setup
  config.vm.synced_folder 'salt/roots/', '/srv/'

  # Forward 8080 to nginx
  config.vm.network :forwarded_port, guest: 80, host: 8080

  # VM-specific digital ocean config
  config.vm.provider :digital_ocean do |provider|
    provider.image = 'Debian 7.0 x64'
    provider.region = 'New York 1'
    provider.size = '512MB'
  end


  # Provisioning #1: install salt stack
  config.vm.provision :shell,
    :inline => 'wget -O - http://bootstrap.saltstack.org | sudo sh'

  # Provisioning #2: masterless highstate call
  config.vm.provision :salt do |salt|
    salt.minion_config = 'salt/minion'
    salt.run_highstate = true
    salt.verbose = true
  end

end
