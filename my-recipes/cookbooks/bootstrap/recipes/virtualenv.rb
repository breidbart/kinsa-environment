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