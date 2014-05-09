# Create the Database
bash "create database" do
  user "vagrant"
  code <<-EOH
    echo "CREATE USER django_login WITH SUPERUSER PASSWORD 'secret';" | sudo -u postgres psql
    sudo -u postgres createdb -O django_login -E UTF8 --lc-ctype=en_US.utf8 --lc-collate=en_US.utf8 -T template0 django_db
  EOH
  not_if "sudo -u postgres psql -l | grep django_db"
end

# Set Database permissions
# Gets around FATAL: Ident authentication failed for user “django_login” 
# Create Bash Aliases, append custom colors
cookbook_file "pg_hba.conf" do
  owner "postgres"
  group "postgres"
  path "/etc/postgresql/9.3/main/pg_hba.conf"
  action :create
end

bash "restart postgresql" do
    user "root"
    code <<-EOH
        /etc/init.d/postgresql restart
    EOH
end