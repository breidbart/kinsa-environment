# Create the Database
bash "create database" do
  user "vagrant"
  code <<-EOH
    echo "CREATE USER django_login WITH SUPERUSER PASSWORD 'secret';" | sudo -u postgres psql
    sudo -u postgres createdb -O django_login -E UTF8 --lc-ctype=en_US.utf8 --lc-collate=en_US.utf8 -T template0 django_db
  EOH
  not_if "sudo -u postgres psql -l | grep django_db"
end
