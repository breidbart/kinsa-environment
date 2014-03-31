# -*- mode: ruby -*-
# vi: set ft=ruby :

VAGRANTFILE_API_VERSION = "2"
 
Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.ssh.private_key_path = ['~/.vagrant.d/insecure_private_key', '~/.ssh/id_rsa']
  config.ssh.forward_agent = true

  # Every Vagrant virtual environment requires a box to build off of.
  config.vm.box = "precise64"

  # The url from where the 'config.vm.box' box will be fetched if it
  # doesn't already exist on the user's system.
  config.vm.box_url = "http://files.vagrantup.com/precise64.box"

  # To access our website, we can open a web browser on our workstation 
  # and go to http://localhost:8001. 
  config.vm.network "forwarded_port", guest: 8000, host: 8000

  # LiveReload listens on port 35729.
  # http://feedback.livereload.com/knowledgebase/articles/195869-how-to-change-the-port-number-livereload-listens-o
  config.vm.network "forwarded_port", guest: 35729, host: 35729

  # Enable provisioning with chef solo, specifying a cookbooks path 
  # (relative to this Vagrantfile), and adding some recipes and/or 
  # roles.
  config.vm.provision :chef_solo do |chef|
    chef.cookbooks_path = "./my-recipes/cookbooks"

    # compilers
    chef.add_recipe "apt"
    chef.add_recipe "build-essential"

    chef.add_recipe "sudo"
 
    # openssl is a requirement for postgresql
    chef.add_recipe "openssl"

    # postgresql database server
    chef.add_recipe "postgresql::client"
    chef.add_recipe "postgresql::server"

    # git 
    chef.add_recipe "git"

    # python, python-dev plus pip and virtualenv
    chef.add_recipe "python"
    chef.add_recipe "python::pip"
    chef.add_recipe "python::virtualenv"

    # zlib, libjpeg, and libfreetype are necessary for PIL
    chef.add_recipe "zlib"
    chef.add_recipe "libjpeg"
    chef.add_recipe "libfreetype"

    # tie it all together
    chef.add_recipe "bootstrap::virtualenv"
    chef.add_recipe "bootstrap::bash"
    chef.add_recipe "bootstrap::symlink-pil"
    chef.add_recipe "bootstrap::postgresql"
    chef.add_recipe "bootstrap::rubygems"
    chef.add_recipe "bootstrap::start-project"
    chef.add_recipe "bootstrap::init-git"
    chef.add_recipe "bootstrap::static-media"

    # Assign the password 'thisisapassword' to psql user 'postgres'
    # Setup memcached
    chef.json = { 
      :authorization => {
        :sudo => {
          :users => [ "vagrant" ],
          :passwordless => "true"
        }
      },
      :postgresql => {
        :version  => '9.1',
        :listen_address => '*',
        :hba => [
          { :type => 'local', :db => 'all', :user => 'all', :addr => nil, :method => 'md5' },
          { :type => 'local', :db => 'django_db', :user => 'django_login', :addr => nil, :method => 'md5' },
        ],
        :password => {
          :postgres => 'md5d4dd6397cf55a4507874c3864f092a8c'  # hashed value of iloverandompasswordsbutthiswilldo
        }
      }
    }
  end
end
