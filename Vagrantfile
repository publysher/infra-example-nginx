# -*- mode: ruby -*-
# vi: set ft=ruby :

# A Happy Hack to set hostmanager aliases and override them on a provider-specific basis
def set_network(node, ip, names)
  node.vm.network :private_network, ip: ip

  primary, *aliases = *names

  node.vm.hostname = primary
  node.hostmanager.aliases = aliases
  node.hostmanager.ignore_private_ip = false

  node.vm.provider :digital_ocean do |provider, override|
    override.hostmanager.aliases = aliases
    override.hostmanager.ignore_private_ip = true
  end
end


Vagrant.configure("2") do |config|

  # Default configuration for Virtualbox
  config.vm.box = 'debian-wheezy-64'
  config.vm.box_url = 'https://www.dropbox.com/s/00ndb5ea4k8hyoy/debian-wheezy-64.box'

  # Create a host-managed private network
  config.hostmanager.enabled = false
  config.hostmanager.include_offline = true

  # DO NOT SHARE OUR ENTIRE PROJECT DIRECTORY
  config.vm.synced_folder 'shared/', '/vagrant/'

  # VM-specific digital ocean config
  config.vm.provider :digital_ocean do |provider|
    provider.image = 'Debian 7.0 x64'
    provider.region = 'New York 1'
    provider.size = '512MB'
  end

  # General provisioning #1: update host file
  config.vm.provision :hostmanager

  # SALT is the salt master
  config.vm.define :salt do |node|
    set_network(node, '10.1.14.50', %w(salt.intranet salt))
    node.vm.synced_folder 'salt/roots/', '/srv/'

    # Salt-master provisioning
    node.vm.provision :salt do |salt|
      salt.bootstrap_script = 'lib/salt-bootstrap/bootstrap-salt.sh'

      salt.install_master = true
      salt.run_highstate = false

      salt.minion_key = 'build/keys/salt.intranet.pem'
      salt.minion_pub = 'build/keys/salt.intranet.pub'

      salt.master_key = 'build/keys/master.pem'
      salt.master_pub = 'build/keys/master.pub'

      salt.seed_master = {
          'salt.intranet' => 'build/keys/salt.intranet.pub',
          'nginx01.intranet' => 'build/keys/nginx01.intranet.pub'
      }
    end

    # And explicitly call the highstate on this one
    node.vm.provision :shell, :inline => 'sleep 60; salt-call state.highstate'
  end

  # NGINX01 is a web server
  config.vm.define :nginx01 do |node|
    set_network(node, '10.1.14.100', %w(nginx01.intranet nginx01))

    # Salt-minion provisioning
    node.vm.provision :salt do |salt|
      salt.bootstrap_script = 'lib/salt-bootstrap/bootstrap-salt.sh'
      salt.run_highstate = true
      salt.minion_key = 'build/keys/nginx01.intranet.pem'
      salt.minion_pub = 'build/keys/nginx01.intranet.pub'
    end

  end

end
