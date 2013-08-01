infra-example-nginx
===================

Companion repository for my blog post [Infra as a Repo - Using Vagrant and Salt Stack to deploy Nginx on DigitalOcean](http://blog.publysher.nl/2013/07/infra-as-repo-using-vagrant-and-salt.html)

Requirements
------------

* [Vagrant](http://vagrantup.com)
* [vagrant-hostmanager](https://github.com/smdahlen/vagrant-hostmanager)
* [vagrant-digitalocean](https://github.com/smdahlen/vagrant-digitalocean)

If you want to deploy to a VPS as well, a [Digital Ocean](http://www.digitalocean.com) account is needed as well.

Create a local server
---------------------

Run `vagrant up` to create a local Nginx server.


Create a server on Digital Ocean
--------------------------------

Copy the `Vagrant.local.example` to `~/.vagrant.d/` and enter your Digital Ocean API key.

Run `vagrant up --provider=digital_ocean` to provision a new Nginx server at Digital Ocean. Run `vagrant rebuild` to
recreate this server.
