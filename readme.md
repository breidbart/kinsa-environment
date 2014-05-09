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

Optionally, install the [_vagrant-vmware_ plugin](https://www.vagrantup.com/vmware) to use VMWare Fusion rather than VirtualBox. Click _Buy Now_ and follow the directions. The plugin requires VMWare Fusion or VMWare Fusion Professional separately. You will be prompted with directions to install the plugin and associate it with the license [during the installation](https://docs.vagrantup.com/v2/vmware/installation.html).

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

Run the bootstrap script to download the Chef cookbooks.

    (host) $ bash bootstrap.sh

---

**WARNING**

Currently, installation will fail when attempting to install Git and Python.

Open the `metadata.rb` file in each of those cookbooks and remove or comment out the dependencies except for `build_essential` which is the only requirement for the Debian/Ubuntu operating system. The others maybe should be listed as `recommends` or there may be some other issue at hand. Not sure at this time.

---

Startup Vagrant and provision the Virtual Machine.

    (host) $ vagrant up

If using with VMWare, throw the `--provider` flag.

    (host) $ vagrant up --provider=vmware_fusion

SSH in to the Virtual Machine.

    (host) $ vagrant ssh 

# A Note About SSH Keys

This project makes your [host machine's SSH key available on the virtual machine](http://docs.vagrantup.com/v2/vagrantfile/ssh_settings.html) so you can use the SSH keys from your host computer on your virtual machine to SSH in to GitHub, BitBucket or your server.

For this to work you need to have working SSH private / public keys on your host computer. [GitHub has a tutorial deliniating the process of creating these keys.](https://help.github.com/articles/generating-ssh-keys)

# Django

This project installs a new Django project from the template at [https://github.com/jbergantine/django-newproj-template](). There's a few things to do the first time through to get it all setup.

Sync the database and migrate any migrations.

    (vm) $ dj syncdb
    (vm) $ dj migrate

Smoke test.

    (vm) $ frs

`frs` is an alias to `foreman start -f Procfile.dev` which contains a directive to execute `python manage.py runserver [::]:8000` as well as `compass watch myproject/static_media/stylesheets`.

Open a Web browser on your host workstation and navigate to [http://localhost:8000](). You should see the `home.html` template rendered.

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

## PIP Command Tips

### List intalled packages

    (vm) $ pip freeze

The output of this command can be routed to a file as in:

    (vm) $ pip freeze > <path_to_file>

As in:

    (vm) $ pip freeze > requirements.txt

### Install a new package:
 
    (vm) $ pip install <package_name>

### Upgrade a package that is alrady installed:

    (vm) $ pip install <package_name> --upgrade

### Install a specific version of a package (where x.x.x is the version number):

    (vm) $ pip install <package_name>==x.x.x

### Install all the packages listed in a file:

    (vm) pip install -r <path_to_file>

As in:

    (vm) $ pip install -r requirements.txt

### Uninstall a package:

    (vm) $ pip uninstall <package_name>

# Bash Aliases

The following bash aliases are added to the shell. 

## Compass

<table>
    <tr>
        <th>$ cw</th>
        <td><pre>compass watch myproject/static_media/stylesheets</pre></td>
    </tr>
</table>

## Django

<table>
    <tr>
        <th>$ dj</th>
        <td>
            <pre>python manage.py</pre>
            <p>Example usage, interact with the Django shell:</p>
            <pre>dj shell</pre>
        </td>
    </tr>
</table>
<table>
    <tr>
        <th>$ rs</th>
        <td>
            <pre>python manage.py runserver [::]:8000</pre>
        </td>
    </tr>
    <tr>
        <th>$ sh</th>
        <td>
            <pre>python manage.py shell</pre>
        </td>
    </tr>
    <tr>
        <th>$ frs</th>
        <td>
            <pre>foreman start -f Procfile.dev</pre>
            <p>Simutaniously starts <code>compass watch myproject/static_media/stylesheets</code> and <code>python manage.py runserver [::]:8000</code> so stylesheets can be compiled and the server run from the same SSH session without manually managing processes.</p>
        </td>
    </tr>
</table>

## Git

<table>
    <tr>
        <th>$ git br</th>
        <td><pre>git branch</pre></td>
    </tr>
    <tr>
        <th>$ git ci</th>
        <td><pre>git commit</pre></td>
    </tr>
    <tr>
        <th>$ git co</th>
        <td><pre>git checkout</pre></td>
    </tr>
    <tr>
        <th>$ git last</th>
        <td><pre>git log -1 HEAD</pre></td>
    </tr>
    <tr>
        <th>$ git st</th>
        <td><pre>git status</pre></td>
    </tr>
    <tr>
        <th>$ git unstage</th>
        <td><pre>git reset HEAD --</pre></td>
    </tr>
</table>
<table>
    <tr>
        <th>$ ga</th>
        <td><pre>git add</pre></td>
    </tr>
    <tr>
        <th>$ gb</th>
        <td><pre>git branch</pre></td>
    </tr>
    <tr>
        <th>$ gco</th>
        <td><pre>git checkout</pre></td>
    </tr>
    <tr>
        <th>$ gl</th>
        <td><pre>git pull</pre></td>
    </tr>
    <tr>
        <th>$ gp</th>
        <td><pre>git push</pre></td>
    </tr>
    <tr>
        <th>$ gst</th>
        <td><pre>git status</pre></td>
    </tr>
    <tr>
        <th>$ gss</th>
        <td><pre>git status -s</pre></td>
    </tr>
</table>

## Python

<table>
    <tr>
        <th>$ py</th>
        <td>
            <pre>python</pre>
            <p>Launches a Python interactive shell.</p>
        </td>
    </tr>
    <tr>
        <th>$ pyclean</th>
        <td>
            <pre>find . -name "*.pyc" -delete</pre>
            <p>Removes all files ending in ".pyc".</p>
        </td>
    </tr>
</table>
