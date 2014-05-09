# Globally install bpython
python_pip "bpython" 

bash "override the sh alias to use bpython" do
  user "vagrant"
  code <<-EOH
    echo "alias sh='python manage.py shell_plus --bpython'" >> /home/vagrant/.bash_profile
  EOH
  not_if "cat /home/vagrant/.bash_profile | grep shell_plus"
end