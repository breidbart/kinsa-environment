# -*- mode: ruby -*-
# vi: set ft=ruby :

VAGRANTFILE_API_VERSION = "2"
 
Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.omnibus.chef_version = :latest
  
  config.ssh.private_key_path = ['~/.vagrant.d/insecure_private_key', '~/.ssh/id_rsa']
  config.ssh.forward_agent = true

  # Every Vagrant virtual environment requires a box to build off of.
  config.vm.box = "chef/ubuntu-14.04"

  # The url from where the 'config.vm.box' box will be fetched if it
  # doesn't already exist on the user's system.

  # This praticular box can be configured for either VMWare or VirtualBox.
  config.vm.box_url = "https://vagrantcloud.com/chef/ubuntu-14.04"

  # To access our website, we can open a Web browser on our host workstation 
  # and go to http://localhost:8000. 
  config.vm.network "forwarded_port", guest: 8000, host: 8000

  # LiveReload listens on port 35729.
  # http://feedback.livereload.com/knowledgebase/articles/195869-how-to-change-the-port-number-livereload-listens-o
  config.vm.network "forwarded_port", guest: 35729, host: 35729

  # Optionally, configure the box
  #config.vm.provider "vmware_fusion" do |v|
  #  # https://docs.vagrantup.com/v2/vmware/configuration.html
  #  v.vmx["memsize"] = "2048"
  #  v.vmx["numvcpus"] = "2"
  #end

  config.vm.provision :shell, :inline => 'bash boostrap.sh'

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

    # python, pip, and virtualenv
    chef.add_recipe "python"
    chef.add_recipe "python::pip"
    chef.add_recipe "python::virtualenv"

    # zlib, libjpeg, and libfreetype are necessary for PIL
    chef.add_recipe "zlib"
    chef.add_recipe "libjpeg"
    chef.add_recipe "libfreetype"

    # tie it all together
    chef.add_recipe "bootstrap"

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
        :password => {
          :postgres => 'md5d4dd6397cf55a4507874c3864f092a8c'  # hashed value of iloverandompasswordsbutthiswilldo
        }
      }
    }
  end
end
