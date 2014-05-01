# Initial setup of Vagrant Base

This step only ever needs to be done once. Once the precise64 box is installed on a system the remaining steps refer to that same box regardless of the project.

On an Apple running OS X, download and install [Xcode from the Apple App Store](https://itunes.apple.com/us/app/xcode/id497799835?ls=1&mt=12). This is necessary to get some compilers and install Git on the host machine.

Download VirtualBox from http://www.virtualbox.org/wiki/Downloads, install the package.

Download Vagrant 2 or higher from http://downloads.vagrantup.com/, install the package.

Launch a Terminal window, check that it installed:

    (host) $ which vagrant

Install the [_vagrant-omnibus_ plugin](https://github.com/schisamo/vagrant-omnibus). This ensures the desired version of Chef is installed.

    $ vagrant plugin install vagrant-omnibus

Add a Vagrant box (we'll be using Ubuntu Trusty Tahr (14.04 LTS) 64-bit):

    (host) $ vagrant box add trusty64 https://cloud-images.ubuntu.com/vagrant/trusty/current/trusty-server-cloudimg-amd64-vagrant-disk1.box 

# Using Vagrant with This Project

Make a directory for the project and change to it, replacing `<path_to>` with the path to the project and `<project_name>` with the name of the project.

    (host) $ mkdir <path_to>/<project_name> && cd $_

For example, to create a project called 'website' in your home directory:

    (host) $ mkdir ~/website && cd $_

When you're all done, this directory will match up with `/vagrant/` in the virtual environment. VirtualBox keeps the two directories in sync so changes to one will be made in the other. 

Clone the repo, replacing `<path_to_repo>` with the clone URL of the repo.
    
    (host) $ git clone <path_to_repo>

Startup Vagrant and provision the Virtual Machine.

    (host) $ vagrant up

SSH in to the Virtual Machine.

    (host) $ vagrant ssh 

Install the project-specific packages.

    (vm) $ sudo pip install -r requirements/development.txt

Sync the database and migrate any migrations.

    (vm) $ dj syncdb
    (vm) $ dj migrate

## Smoke Test

    (vm) $ frs

(`frs` is an alias to to `foreman start -f Procfile.dev` which contains a directive to execute `python manage.py runserver [::]:8000` as well as `compass watch myproject/static_media/stylesheets`.)

Open a Web browser and navigate to [http://localhost:8000](http://localhost:8000). You should see the `home.html` template rendered.

## SSH Keys

This project makes your [host machine's SSH key available on the virtual machine](http://docs.vagrantup.com/v2/vagrantfile/ssh_settings.html) so you can use the SSH keys from your host computer on your virtual machine to SSH in to GitHub, BitBucket or your server.

For this to work you need to have working SSH private / public keys on your host computer. [GitHub has a tutorial deliniating the process of creating these keys.](https://help.github.com/articles/generating-ssh-keys)

## Co-Dependencies

This project uses [django-newproj-template](https://github.com/jbergantine/django-newproj-template) and the [Gesso](https://github.com/jbergantine/compass-gesso) frontend framework.
