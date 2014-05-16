This repository contains directives to install all the tools we use to build Python webapps at Kinsa in a Vagrant virtual environment. It should help new developers to setup virtual boxes easily and get up to speed in no time.

It should work well on a newer Apple Macintosh running OSX Mavericks.

# Initial setup of Vagrant Base

This step only ever needs to be done once. Once the box is installed on a system the remaining steps refer to that same box regardless of the project.

On an Apple running OS X, download and install [Xcode from the Apple App Store](https://itunes.apple.com/us/app/xcode/id497799835?ls=1&mt=12). This is necessary to get some compilers and install Git on the host machine.

Download [VirtualBox](http://www.virtualbox.org/wiki/Downloads) or [VMWare Fusion](http://www.vmware.com/products/fusion/) or [VMWare Fusion Professional](http://www.vmware.com/products/fusion-professional/), install the package.

[Download Vagrant 2](http://downloads.vagrantup.com/) or higher, install the package.

Launch a Terminal window, check that it installed:

    (host) $ which vagrant

Install the [_vagrant-omnibus_ plugin](https://github.com/schisamo/vagrant-omnibus). This ensures the desired version of Chef is installed.

    (host) $ vagrant plugin install vagrant-omnibus

Install the [_vagrant-berkshelf_ plugin](https://github.com/berkshelf/vagrant-berkshelf) to manage dependencies.

    (host) $ vagrant plugin install vagrant-berkshelf --plugin-version '>= 2.0.1'

Optionally, install the [_vagrant-vmware_ plugin](https://www.vagrantup.com/vmware) to use VMWare Fusion rather than VirtualBox. Click _Buy Now_ and follow the directions. The Vagrant VMWare plugin requires either VMWare Fusion or VMWare Fusion Professional. You will be prompted with directions to install the plugin and associate it with the license [during the installation](https://docs.vagrantup.com/v2/vmware/installation.html).

Add a Vagrant box (we'll be using Ubuntu Trusty Tahr (14.04 LTS) 64-bit):

    (host) $ vagrant box add https://vagrantcloud.com/chef/ubuntu-14.04 

# Starting a New Project

Make a directory for the project and change to it, replacing `<path_to>` with the path to the project and `<project_name>` with the name of the project.

    (host) $ mkdir <path_to>/<project_name> && cd $_

For example, to create a project called 'webapp' in your home directory:

    (host) $ mkdir ~/webapp && cd $_

When you're all done, this directory will match up with `/vagrant/` in the virtual environment. Vagrant keeps the two directories in sync so changes to one will be made in the other. 

Download this repo.
    
    (host) $ curl -L https://github.com/Kinsa/kinsa-environment/tarball/master | tar -xz --strip-components=1

Startup Vagrant and provision the Virtual Machine.

    (host) $ vagrant up

If using with VMWare, throw the `--provider` flag.

    (host) $ vagrant up --provider=vmware_fusion

SSH in to the Virtual Machine.

    (host) $ vagrant ssh 

## A Note About SSH Keys

This project makes your [host machine's SSH key available on the virtual machine](http://docs.vagrantup.com/v2/vagrantfile/ssh_settings.html) so you can use the SSH keys from your host computer on your virtual machine to SSH in to GitHub, BitBucket or your server.

For this to work you need to have working SSH private / public keys on your host computer. [GitHub has a tutorial deliniating the process of creating these keys.](https://help.github.com/articles/generating-ssh-keys)

## Django

The [kinsa-bootstrap](http://github.com/kinsa/kinsa-bootstrap) project installs a new Django project from the template at [https://github.com/jbergantine/django-newproj-template](). There's a few things to do the first time through to get it all setup.

Sync the database and migrate any migrations.

    (vm) $ dj syncdb
    (vm) $ dj migrate

Force compile the stylesheets.

    (vm) $ compass compile myproject/static_media/stylesheets --force

Smoke test.

    (vm) $ frs

`frs` is an alias to `foreman start -f Procfile.dev` which contains a directive to execute `python manage.py runserver [::]:8000` as well as `compass watch myproject/static_media/stylesheets`.

Open a Web browser on your host workstation and navigate to [http://localhost:8000](). You should see the `home.html` template rendered.

---

# Cheat Sheets

## Vagrant command tips

### To exit the VM and return to your host machine:

    (vm) $ exit

### To shutdown the VM:

    (host) $ vagrant halt

### To suspend the VM (i.e. freeze the VM's state):

    (host) $ vagrant suspend

### Once shutdown or suspended, a VM can be restarted. To boot a VM:

    (host) $ vagrant up

### SSH into a VM (VM must [first be booted](#once-shutdown-or-suspended-a-vm-can-be-restarted)):

    (host) $ vagrant ssh

### To destroy the VM:

    (host) $ vagrant destroy

### To check if the VM is currently running:

    (host) $ vagrant status

### To re-run the provisioning after the VM has been started (if you have built the VM from scratch):

    (host) $ vagrant provision

More information is available in the [Vagrant documentation](http://vagrantup.com/v1/docs/index.html).

## VirtualenvWrapper Command Tips

Replacing `<virtualenv_name>` with the name of the virtual environement (IE: `djangoproj`).

### To make a virtual environment:

    (vm) $ mkvirtualenv <virtualenv_name>

### To activate a virtual environment:

    (vm) $ workon <virtualenv_name>
   
### To deactivate a virtual environment:

    (vm) $ deactivate

### To remove a virtual environment (warning this will delete the environment and any files therein):

    (vm) rmvirtualenv <virtualenv_name>

