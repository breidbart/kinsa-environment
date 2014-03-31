postgresql_database 'django_db' do
  connection(
    :host     => '127.0.0.1',
    :port     => 5432,
    :username => 'django_login',
    :password => 'secret'  # hashed: 53f48b7c4b76a86ce72276c5755f217d
  )
  template 'template0'
  encoding 'UTF8'
  action :create
end