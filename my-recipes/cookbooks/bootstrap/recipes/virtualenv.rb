# Setup VirtualenvWrapper
python_pip "virtualenvwrapper" do
  action :install
  not_if "ls /usr/local/bin | grep 'virtualenvwrapper.sh'"
end

# Create the enclosing directory
bash "mk .virtualenvs dir" do 
  user "vagrant"
  code <<-EOH
    mkdir -pv /home/vagrant/.virtualenvs
  EOH
end

# Create the Virtual Environment
python_virtualenv "/home/vagrant/.virtualenvs/djangoproj" do
  interpreter "python2.7"
  owner "vagrant"
  group "vagrant"
  action :create
  not_if "ls /home/vagrant/.virtualenvs | grep 'djangoproj'"
end

#bash "configure virtualenvwrapper" do
#  user "vagrant"
#  code <<-EOH
#    echo "export WORKON_HOME=/home/vagrant/.virtualenvs" >> /home/vagrant/.profile
#    echo "source /usr/local/bin/virtualenvwrapper.sh" >> /home/vagrant/.profile
#    echo "workon djangoproj" >> /home/vagrant/.profile
#  EOH
#  not_if "cat /home/vagrant/.profile | grep /home/vagrant/.virtualenvs"
#end
