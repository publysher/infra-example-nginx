infra-example-nginx
===================

Companion repository for my blog post series [Infra as a Repo](http://blog.publysher.nl/search/label/infra-as-a-repo).

Requirements
------------

* [Vagrant](http://vagrantup.com)
* [vagrant-hostmanager](https://github.com/smdahlen/vagrant-hostmanager)
* [vagrant-digitalocean](https://github.com/smdahlen/vagrant-digitalocean)
* [salty-vagrant](https://github.com/saltstack/salty-vagrant) *from source*

If you want to deploy to a VPS as well, a [Digital Ocean](http://www.digitalocean.com) account is needed as well.

Please note that the latest released vagrant-salt-plugin is terribly outdated. Use the
[Installing from Source](https://github.com/saltstack/salty-vagrant#installing-from-source) instructions to install
salty-vagrant.

Create a local server
---------------------

Run `vagrant up` to create a local Nginx server.


Create a server on Digital Ocean
--------------------------------

Copy the `Vagrant.local.example` to `~/.vagrant.d/` and enter your Digital Ocean API key.

Run `vagrant up --provider=digital_ocean` to provision a new Nginx server at Digital Ocean. Run `vagrant rebuild` to
recreate this server.
