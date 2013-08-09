# -*- mode: ruby -*-
# vi: set ft=ruby :

# A Happy Hack to set hostmanager aliases and override them on a provider-specific basis
def set_host_aliases(node, aliases)
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
  config.hostmanager.manage_host = false
  config.hostmanager.include_offline = true

  # VM-specific digital ocean config
  config.vm.provider :digital_ocean do |provider|
    provider.image = 'Debian 7.0 x64'
    provider.region = 'New York 1'
    provider.size = '512MB'
  end

  # General provisioning #1: update host file
  config.vm.provision :hostmanager

  # General provisioning #2: run Salt
  config.vm.provision :salt do |salt|
    salt.bootstrap_script = 'lib/salt-bootstrap/bootstrap-salt.sh'

    salt.install_master = true
    salt.run_highstate = false

    salt.minion_key = 'build/keys/nginx01.intranet.pem'
    salt.minion_pub = 'build/keys/nginx01.intranet.pub'

    salt.master_key = 'build/keys/master.pem'
    salt.master_pub = 'build/keys/master.pub'

    salt.seed_master = {
        'nginx01.intranet' => 'build/keys/nginx01.intranet.pub'
    }
  end

  # NGINX01 is a web server
  config.vm.define :nginx01 do |node|

    node.vm.hostname = 'nginx01.intranet'
    node.vm.network :private_network, ip: '10.1.14.100'
    node.vm.synced_folder 'salt/roots/', '/srv/'

    set_host_aliases(node, %w(salt salt.intranet))

    node.vm.provision :shell, :inline => 'sleep 60; salt-call state.highstate'

  end

end
