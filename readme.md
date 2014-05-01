This repository contains a Chef cookbook and bash script that will install all the tools we use to build Python webapps at Kinsa in a Vagrant virtual environment. It should help new developers to setup virtual boxes easily and get up to speed in no time.

It should work well on a newer Apple Macintosh running OSX Mavericks.

# Initial setup of Vagrant Base

This step only ever needs to be done once. Once the box is installed on a system the remaining steps refer to that same box regardless of the project.

On an Apple running OS X, download and install [Xcode from the Apple App Store](https://itunes.apple.com/us/app/xcode/id497799835?ls=1&mt=12). This is necessary to get some compilers and install Git on the host machine.

Download VirtualBox from http://www.virtualbox.org/wiki/Downloads, install the package.

Download Vagrant 2 or higher from http://downloads.vagrantup.com/, install the package.

Launch a Terminal window, check that it installed:

    (host) $ which vagrant

Install the [_vagrant-omnibus_ plugin](https://github.com/schisamo/vagrant-omnibus). This ensures the desired version of Chef is installed.

    (host) $ vagrant plugin install vagrant-omnibus

Add a Vagrant box (we'll be using Ubuntu Trusty Tahr (14.04 LTS) 64-bit):

    (host) $ vagrant box add trusty64 https://cloud-images.ubuntu.com/vagrant/trusty/current/trusty-server-cloudimg-amd64-vagrant-disk1.box 

# Starting a New Project

Make a directory for the project and change to it, replacing `<path_to>` with the path to the project and `<project_name>` with the name of the project.

    (host) $ mkdir <path_to>/<project_name> && cd $_

For example, to create a project called 'webapp' in your home directory:

    (host) $ mkdir ~/webapp && cd $_

When you're all done, this directory will match up with `/vagrant/` in the virtual environment. VirtualBox keeps the two directories in sync so changes to one will be made in the other. 

Clone this repo.
    
    (host) $ git clone git@github.com:Kinsa/kinsa-environment.git

Startup Vagrant and provision the Virtual Machine.

    (host) $ vagrant up

SSH in to the Virtual Machine.

    (host) $ vagrant ssh 

# A Note About SSH Keys

This project makes your [host machine's SSH key available on the virtual machine](http://docs.vagrantup.com/v2/vagrantfile/ssh_settings.html) so you can use the SSH keys from your host computer on your virtual machine to SSH in to GitHub, BitBucket or your server.

For this to work you need to have working SSH private / public keys on your host computer. [GitHub has a tutorial deliniating the process of creating these keys.](https://help.github.com/articles/generating-ssh-keys)
