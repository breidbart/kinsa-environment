# -*- mode: ruby -*-
# vi: set ft=ruby :

VAGRANTFILE_API_VERSION = "2"
 
Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.omnibus.chef_version = :latest

  config.berkshelf.enabled = true

  config.ssh.private_key_path = ["~/.vagrant.d/insecure_private_key", "~/.ssh/id_rsa"]
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
  
  # SMTP Ports
  config.vm.network "forwarded_port", guest: 25, host: 25
  config.vm.network "forwarded_port", guest: 465, host: 465
  config.vm.network "forwarded_port", guest: 587, host: 587

  # Optionally, configure the box
  # VMWare
  #config.vm.provider "vmware_fusion" do |v|
  #  # https://docs.vagrantup.com/v2/vmware/configuration.html
  #  v.vmx["memsize"] = "2048"
  #  v.vmx["numvcpus"] = "4"
  #end

  # VirtualBox
  #config.vm.provider "virtualbox" do |v|
  #  v.customize ["modifyvm", :id, "--vram", "16"]
  #  v.memory = 2048
  #  v.cpus = 4
  #end

  # Enable provisioning with chef solo, specifying a cookbooks path 
  # (relative to this Vagrantfile), and adding some recipes and/or 
  # roles.
  config.vm.provision :chef_solo do |chef|
    # required directive, but ignored since we're using Berkshelf
    chef.cookbooks_path = "cookbooks"

    chef.custom_config_path = "Vagrantfile.chef"

    chef.add_recipe "kinsa-bootstrap"

    chef.json = { 
      :authorization => {
        :sudo => {
          :users => [ "vagrant" ],
          :passwordless => "true"
        }
      },
      :postgresql => {
        :version  => '9.3',
        :listen_address => '*',
        :password => {
          :postgres => 'md5d4dd6397cf55a4507874c3864f092a8c'  # hashed value of iloverandompasswordsbutthiswilldo
        }
      },
      :rbenv => {
        :global => '2.1.2',
        :rubies => ['2.1.2'],
        :gems => {
          '2.1.2' => [
            {
              :name => 'compass',
              :version => '0.12.4'
            },
            {
              :name => 'susy',
              :version => '1.0.9'
            },
            {
              :name => 'foreman'
            },
            {
              :name => 'bundler'
            }
          ]
        }
      }
    }
  end
end
