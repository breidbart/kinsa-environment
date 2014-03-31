# Init Git Project (this is a backup in case it got missed for some reason)
# Create branches for development and production
bash "init git" do
  user "vagrant"
  code <<-EOH
    cd /vagrant
    git init
  EOH
  not_if "ls -a /vagrant | grep .git$"
end

# docs @ http://docs.opscode.com/resource_cookbook_file.html
# insatll post-merge hook, make vagrant its owner, make it executable
cookbook_file "post-merge" do
  owner "vagrant"
  group "vagrant"
  mode 0744
  path "/vagrant/.git/hooks/post-merge"
  action :create
end

# Configure Git
bash "configure git aliases" do
  user "vagrant"
  code <<-EOH
    cd /vagrant
    git config color.branch true
    git config color.diff true
    git config color.interactive true
    git config color.status true
    git config merge.summary true
    git config alias.st status
    git config alias.ci commit
    git config alias.co checkout
    git config alias.br branch
    git config alias.unstage 'reset HEAD --'
    git config alias.last 'log -1 HEAD'
  EOH
  not_if "cd /vagrant && git config --get color.diff"
end
