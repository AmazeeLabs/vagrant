AmazeeLabs Vagrant
==================

Internal Documentation : http://confluence.amazeelabs.com/display/KNOWLEDGE/Vagrant

Git Submodule Usage
===================

 1. git submodule add git@github.com:AmazeeLabs/vagrant.git vagrant
 1. git submodule update --init
 1. copy the vagrant/Vagrantfile.dist to your project root
 2. rename it to Vagrantfile
 3. edit Vagrantfile (change HOSTNAME)
 1. vagrant up
 1. enjoy!

Standalone Usage
================

 1. copy Vagrantfile.dist to Vagrantfile
 1. Uncomment the Line which checks for the recipe folder to setup your environment (search for chef.cookbooks_path)
 1. vagrant up
 1. enjoy!

