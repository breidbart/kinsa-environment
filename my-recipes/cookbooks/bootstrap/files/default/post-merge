#!/bin/sh
if [ $(git diff HEAD@{1} HEAD --name-only | grep 'requirements/development.txt' -c) -ne 0 ]
then
    sudo $VIRTUAL_ENV/bin/pip install -r /vagrant/myproject/requirements/development.txt
fi

compass compile /vagrant/myproject/myproject/static_media/stylesheets -e production --force

$VIRTUAL_ENV/bin/python /vagrant/myproject/manage.py syncdb

$VIRTUAL_ENV/bin/python /vagrant/myproject/manage.py migrate

if [ $(cat /vagrant/myproject/requirements/development.txt | grep 'haystack' -c) -ne 0 ]
then 
    $VIRTUAL_ENV/bin/python /vagrant/myproject/manage.py rebuild_index --noinput
fi