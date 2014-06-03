This repository contains directives to install all the tools we use to build Python webapps at Kinsa in a Vagrant virtual environment. It should help new developers to setup virtual boxes easily and get up to speed in no time.

It should work well on a newer Apple Macintosh running OSX Mavericks.

# Initial setup of Vagrant Base

This step only ever needs to be done once. Once the box is installed on a system the remaining steps refer to that same box regardless of the project.

On an Apple running OS X, download and install [Xcode from the Apple App Store](https://itunes.apple.com/us/app/xcode/id497799835?ls=1&mt=12). This is necessary to get some compilers and install Git on the host machine.

Download [VirtualBox](http://www.virtualbox.org/wiki/Downloads) or [VMWare Fusion](http://www.vmware.com/products/fusion/) or [VMWare Fusion Professional](http://www.vmware.com/products/fusion-professional/), install the package.

[Download Vagrant 1.6](http://downloads.vagrantup.com/) or higher, install the package.

Launch a Terminal window, check that it installed:

```bash
(host) $ which vagrant
```

Install the [_vagrant-omnibus_ plugin](https://github.com/schisamo/vagrant-omnibus). This ensures the desired version of Chef is installed.

```bash
(host) $ vagrant plugin install vagrant-omnibus
```

Install the [_vagrant-berkshelf_ plugin](https://github.com/berkshelf/vagrant-berkshelf) to manage Chef cookbooks.

```bash
(host) $ vagrant plugin install vagrant-berkshelf --plugin-version '>= 2.0.1'
```

Optionally, install the [_vagrant-vmware_ plugin](https://www.vagrantup.com/vmware) to use VMWare Fusion rather than VirtualBox. Click _Buy Now_ and follow the directions. The Vagrant VMWare plugin requires either VMWare Fusion or VMWare Fusion Professional. You will be prompted with directions to install the plugin and associate it with the license [during the installation](https://docs.vagrantup.com/v2/vmware/installation.html).

Add a Vagrant box (we'll be using Ubuntu Trusty Tahr (14.04 LTS) 64-bit):

```bash
(host) $ vagrant box add https://vagrantcloud.com/chef/ubuntu-14.04 
```

# Starting a New Project

Make a directory for the project and change to it, replacing `<path_to>` with the path to the project and `<project_name>` with the name of the project.

```bash
(host) $ mkdir <path_to>/<project_name> && cd $_
```

For example, to create a project called 'webapp' in your home directory:

```bash
(host) $ mkdir ~/webapp && cd $_
```

When you're all done, this directory will match up with `/vagrant/` in the virtual environment. Vagrant keeps the two directories in sync so changes to one will be made in the other. 

Download this repo.
    
```bash
(host) $ curl -L https://github.com/Kinsa/kinsa-environment/tarball/master | tar -xz --strip-components=1
```

Startup Vagrant and provision the Virtual Machine.

```bash
(host) $ vagrant up
```

If using with VMWare, throw the `--provider` flag.

```bash
(host) $ vagrant up --provider=vmware_fusion
```

SSH in to the Virtual Machine.

```bash
(host) $ vagrant ssh 
```

## A Note About SSH Keys

This project makes your [host machine's SSH key available on the virtual machine](http://docs.vagrantup.com/v2/vagrantfile/ssh_settings.html) so you can use the SSH keys from your host computer on your virtual machine to SSH in to GitHub, BitBucket or your server.

For this to work you need to have working SSH private / public keys on your host computer. [GitHub has a tutorial deliniating the process of creating these keys.](https://help.github.com/articles/generating-ssh-keys)

## The Bash Prompt

This project uses a customized bash prompt which shows you the current user, active Python virtual environment and git branch with color coding.

The ouptut format looks like this:

```bash
<user> <python virtual environment name> <git branch> <path from root>$
```

Specifically, it might look like this if the user is `vagrant`, the virtualenv is `djangoproj`, the active git branch is `develop` and the path is `/vagrant/myproject`:

```bash
vagrant djangoproj develop /vagrant/myproject$
```

## Django

The [kinsa-bootstrap](http://github.com/kinsa/kinsa-bootstrap) project installs a new Django project from the template at [https://github.com/jbergantine/django-newproj-template](). There's a few things to do the first time through to get it all setup.

Sync and migrate the database.

```bash
(vm) $ dj syncdb
(vm) $ dj migrate
```

Force compile the stylesheets.

```bash
(vm) $ compass compile myproject/static_media/stylesheets --force
```

Smoke test.

```bash
(vm) $ frs
```

`frs` is an alias to `foreman start -f Procfile.dev` which contains a directive to execute `python manage.py runserver [::]:8000` as well as `compass watch myproject/static_media/stylesheets`.

Open a Web browser on your host workstation and navigate to [http://localhost:8000](). You should see the `home.html` template rendered.

# Directory Structure and Subprojects

## Python

Python 2.7, VirtualEnv, and VirtualEnvWrapper are installed and configured. 

The Django Project is installed into a virtual environment named `djangoproj` which resides in `/home/vagrant/.virtualenvs`. The `djangoproj` virtual environment is activated by default for the `vagrant` user's Bash session.

Certain packages are installed globally, and the `djangoproj` virtual environment is configured to have access to global packages.

## Django Project

The Django Project gets built into `/vagrant/myproject`.

This is the starting directory for the `vagrant` users's Bash session when SSH'ing in.

This directory is shared with the host machine. Files may be edited from here using an IDE or text editor on the host machine.

The Django project is available on the host machine at `localhost:8000` or `http://127.0.0.1:8000`.

## Default Django Application

The defualt application is also called `myproject` and resides at `/vagrant/myproject/myproject`.

See the [Django Newproj Template README](https://github.com/jbergantine/django-newproj-template). for additional documentation of the default application including additional Python packages installed, settings file names and locations, default database engine, etc.

## HTML

HTML Templates reside in `/vagrant/myproject/myproject/templates`.

[See the Django Newproj Template README for additional documentation of the included HTML templates.](https://github.com/jbergantine/django-newproj-template).

## Stylesheets

SASS files reside in `/vagrant/myproject/myproject/static_media/stylesheets/sass` and get compiled via Compass to `/vagrant/myproject/myproject/static_media/stylesheets/stylesheets`.

[See the Gesso SASS project README for additional documentation.](https://github.com/jbergantine/compass-gesso).

This project forwards port 35729 from the virtual machine to the host machine which is the port LiveReload relies on. For this to be useful, Grunt must be installed and used to compile the stylesheets with the `livereload` option enabled. For more information see https://github.com/gruntjs/grunt-contrib-watch#optionslivereload and https://github.com/gruntjs/grunt-contrib-compass. 

This project relies on Compass and Susy 1.x.

* [Compass documentation](http://compass-style.org/reference/compass/).
* [Susy One documentation](http://susydocs.oddbird.net/en/latest/susyone/).

## Scripts

JavaScript files reside in `/vagrant/myproject/myproject/static_media/javascripts`.

This project relies on the latest verison of jQuery and a customzied version of Modernizr 2.6.2 with just [HTML5 shims](http://modernizr.com/download/#-shiv-cssclasses-load).

* [jQuery documentation](http://api.jquery.com).
* [Modernizr documentation](http://modernizr.com/docs/).

## Images

Images reside in `/vagrant/myproject/myproject/static_media/images`.

# Working Collaboratively

The project uses an undocumented post-merge Git hook [(view the source code)](https://github.com/Kinsa/kinsa-bootstrap/blob/develop/files/default/post-merge.sh) to compile SASS files, install Python package dependancies, sync/migrate databases and load database fixtures when working collaboratively.

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
            <pre>python manage.py runserver_plus [::]:8000</pre>
        </td>
    </tr>
    <tr>
        <th>$ sh</th>
        <td>
            <pre>python manage.py shell_plus --bpython</pre>
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
