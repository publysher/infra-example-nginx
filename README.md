infra-example-nginx
===================

Companion repository for my blog post series [Infra as a Repo](http://blog.publysher.nl/search/label/infra-as-a-repo).

In its current incarnation, this example provisions two servers: one salt master (`salt`) and one minion that will run
Nginx (`nginx01`). These servers can be run locally on VirtualBox, or on Digital Ocean Droplets.

Requirements
------------

* Install [Virtual Box][VirtualBox-download]
* Install [Vagrant][]
* Install [vagrant-hostmanager][]: `vagrant plugin install vagrant-hostmanager`
* Install [vagrant-digitalocean][]: `vagrant plugin install vagrant-digitalocean`
* Install [salty-vagrant][] as described below

If you want to deploy to [Digital Ocean](http://www.digitalocean.com), you will need an account well.

### Installing Salty-Vagrant ###

The latest official vagrant-salt-plugin release is somewhat outdated. To use this example, you will need to take
the following steps:

1. Check out [salty-vagrant][salty-vagrant-source]
2. Apply [Pull Request #98][salty-vagrant-pr-98]
3. Install the plugin following the "[Install from source][salty-vagrant-source]" instructions.


Running local servers
---------------------

Run `vagrant up` to create two virtualbox images. This will download a minimal Debian Wheezy 7.0 image from my
dropbox account and spin up two images:

* `salt` -- a VM containing nothing but a Salt master
* `nginx01` -- a VM containing a Salt minion, which installs an Nginx server

If you want easy access to these machines, add the following lines to your `/etc/hosts` file:

    10.1.14.100	nginx01.intranet
    10.1.14.50	salt.intranet


Create servers on Digital Ocean
--------------------------------

Copy the `Vagrant.local.example` to `~/.vagrant.d/` and enter your Digital Ocean API key.

Run `vagrant up --provider=digital_ocean` to provision both servers at Digital Ocean. Run `vagrant rebuild` to
recreate these server.

By default, the servers are the cheapest Droplets, hosted in NYC.

[VirtualBox-download]: https://www.virtualbox.org/wiki/Downloads
[Vagrant]: http://vagrantup.com
[vagrant-hostmanager]: https://github.com/smdahlen/vagrant-hostmanager
[vagrant-digitalocean]: https://github.com/smdahlen/vagrant-digitalocean
[salty-vagrant]: https://github.com/saltstack/salty-vagrant
[salty-vagrant-source]: https://github.com/saltstack/salty-vagrant#installing-from-source
[salty-vagrant-pr-98]: https://github.com/saltstack/salty-vagrant/pull/98
[Digital Ocean]: https://www.digitalocean.com/?refcode=8d8ff680bec5
