# TODO

# The `install twitter bootstrap 3.1.1` task should have some sort of 
# `not_if` condition

# The `install plugins via npm` task should have some sort of 
# `not_if` condition

# The files in the gist at https://gist.github.com/jbergantine/9172763 
# (package.json and Gruntfile.js) should be a file? 
# (Documentation on files @ http://docs.opscode.com/resource_remote_file.html)


# WARNINGS

# There is no task for updating base.html to include the bootstrap javascript
# <script src="{{ STATIC_URL }}bootstrap/dist/js/bootstrap.min.js"></script>

# This uses /stylesheets/css instead of /stylesheets/stylesheets; the references
# to the CSS files need to be updated accordingly in base.html

# There are no tasks for updating the fabfile for deployment 
# (to either remove compass compress, etc. or to minify the new CSS
# files - django_compressor might do this for us?)

# There is no task for removing the `compass` task from `Procfile.dev`


# Configure Static Media
bash "install grunt-cli" do
  user "root"
  code <<-EOH
    npm install -g grunt-cli
  EOH
  not_if "npm ls | grep grunt"
end

bash "setup static media directories" do 
  user "vagrant"
  code <<-EOH
    mkdir -p /vagrant/myproject/myproject/media 
    mkdir -p /vagrant/myproject/myproject/static 
    mkdir -p /vagrant/myproject/myproject/static_media/bootstrap
    mkdir -p /vagrant/myproject/myproject/static_media/fonts
    mkdir -p /vagrant/myproject/myproject/static_media/images
    mkdir -p /vagrant/myproject/myproject/static_media/javascripts/libs
    mkdir -p /vagrant/myproject/myproject/static_media/stylesheets/css
    mkdir -p /vagrant/myproject/myproject/static_media/stylesheets/less
  EOH
end

bash "download and unpack twitter bootstrap 3.1.1" do 
  user "vagrant"
  code <<-EOH
    wget --no-check-certificate https://github.com/twbs/bootstrap/archive/v3.1.1.tar.gz -O - | tar -xz --strip-components=1 --directory=/vagrant/myproject/myproject/static_media/bootstrap
  EOH
  not_if "ls /vagrant/myproject/myproject/static_media/bootstrap | grep package.json"
end

bash "install twitter bootstrap 3.1.1" do
  user "root"
  code <<-EOH
    cd /vagrant/myproject/myproject/static_media/bootstrap && npm install
  EOH
end

bash "create project less files" do 
  user "vagrant"
  code <<-EOH
    echo '@import "../../bootstrap/less/bootstrap.less";' >> /vagrant/myproject/myproject/static_media/stylesheets/less/style.less
    touch /vagrant/myproject/myproject/static_media/stylesheets/less/palette.less
    echo '@import "palette.less";' >> /vagrant/myproject/myproject/static_media/stylesheets/less/screen.less
  EOH
  not_if "ls /vagrant/myproject/myproject/static_media/stylesheets/less/ | grep 'screen.less'"
end

bash "create package.json" do
  user "vagrant"
  code <<-EOH
    cd /vagrant/myproject/myproject/static_media/stylesheets/
    wget https://gist.github.com/jbergantine/9172763/raw/package.json -O package.json
  EOH
  not_if "ls /vagrant/myproject/myproject/static_media/stylesheets/ | grep 'package.json'"
end

bash "install plugins via npm" do 
  user "root"
  code <<-EOH
    cd /vagrant/myproject/myproject/static_media/stylesheets/ && npm install
  EOH
end

bash "create Gruntfile.js" do
  user "vagrant"
  code <<-EOH
    cd /vagrant/myproject/myproject/static_media/stylesheets/
    wget https://gist.github.com/jbergantine/9172763/raw/Gruntfile.js -O Gruntfile.js
  EOH
  not_if "ls /vagrant/myproject/myproject/static_media/stylesheets/ | grep 'Gruntfile.js'"
end

bash "update Procfile.dev" do 
  user "vagrant"
  code <<-EOH
    touch /vagrant/myproject/Procfile.dev
    echo "less: sh -c 'cd /vagrant/myproject/myproject/static_media/stylesheets/ && grunt watch'" >> /vagrant/myproject/Procfile.dev
  EOH
  not_if "cat /vagrant/myproject/Procfile.dev | grep 'less: '"
end

bash "download jquery" do
  user "vagrant"
  code <<-EOH
    cd /vagrant/myproject/myproject/static_media/javascripts/libs
    wget http://ajax.googleapis.com/ajax/libs/jquery/1/jquery.min.js -O jquery.js
  EOH
  not_if "ls /vagrant/myproject/myproject/static_media/javascripts/libs | grep 'jquery'"
end
