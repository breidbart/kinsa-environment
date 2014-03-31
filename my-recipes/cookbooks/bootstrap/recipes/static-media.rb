# Configure Static Media
bash "configure static media" do
  user "vagrant"
  code <<-EOH
    cd /vagrant/myproject/myproject
    mkdir -p media static static_media/javascripts/libs
    cd static_media
    compass create stylesheets --syntax sass -r susy -u susy
    cd stylesheets/sass
    rm _base.sass screen.sass
    wget https://github.com/jbergantine/compass-gesso/tarball/master -O master.tar.gz
    tar -xvzf master.tar.gz
    cd jbergantine*
    mv *.sass ../
    cd ..
    rm -rf jbergantine* master.tar.gz
    touch /vagrant/myproject/myproject/static_media/stylesheets/sass/ie.sass
    cd /vagrant/myproject/myproject/static_media/javascripts/libs
    wget http://ajax.googleapis.com/ajax/libs/jquery/1/jquery.min.js -O jquery.js
  EOH
  not_if "ls /vagrant/myproject/myproject | grep 'static_media'"
end

# insatll modernizr.js
cookbook_file "modernizr.js" do
  owner "vagrant"
  group "vagrant"
  path "/vagrant/myproject/myproject/static_media/javascripts/libs/modernizr.js"
  action :create_if_missing
end

bash "create (as necessary) and update procfile" do
  user "vagrant"
  code <<-EOH
    touch /vagrant/myproject/Procfile.dev
    echo "compass: compass watch myproject/static_media/stylesheets" >> /vagrant/myproject/Procfile.dev
  EOH
  not_if "cat /vagrant/myproject/Procfile.dev | grep 'compass'"
end
  
