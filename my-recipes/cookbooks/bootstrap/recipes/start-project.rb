# Install Python packages and start the Django project
bash "install packages and start project" do
  user "root"
  code <<-EOH
    source /home/vagrant/.virtualenvs/djangoproj/bin/activate
    pip install -r https://raw.github.com/jbergantine/django-newproj-template/master/requirements/base.txt
    cd /vagrant
    django-admin.py startproject --template=https://github.com/jbergantine/django-newproj-template/zipball/master --extension=py,rst myproject
    cd /vagrant/myproject
    chmod u+x manage.py
  EOH
  not_if "ls /home/vagrant/.virtualenvs/djangoproj/lib/python2.7/site-packages | grep 'django'"
end

bash "set virtualenv postactivate and deactivate hooks" do
  user "vagrant"
  code <<-EOH
    source /home/vagrant/.virtualenvs/djangoproj/bin/activate
    echo "export DJANGO_SETTINGS_MODULE=myproject.settings.development" >> $VIRTUAL_ENV/bin/postactivate
    echo "unset DJANGO_SETTINGS_MODULE" >> $VIRTUAL_ENV/bin/postdeactivate
  EOH
  not_if "ls $VIRTUAL_ENV/bin | grep 'postdeactivate'"
end
