# Globally install bpython
python_pip "werkzeug" 

bash "override the rs alias to use runserver_plus" do
  user "vagrant"
  code <<-EOH
    echo "alias rs='python manage.py runserver_plus [::]:8000" >> /home/vagrant/.bash_profile
  EOH
  not_if "cat /home/vagrant/.bash_profile | grep \"alias sh='python manage.py shell_plus --use-bpython'\""
end