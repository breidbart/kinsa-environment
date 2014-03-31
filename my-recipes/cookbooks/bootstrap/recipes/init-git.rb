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

# Install .gitignore 
bash "configure gitignore" do
  user "vagrant"
  code <<-EOH
    cd /vagrant
    echo ".DS_Store\n.vagrant" >> .gitignore
  EOH
  not_if "ls -a /vagrant | grep .gitignore"
end

# Backup existing post-merge hook 
bash "configure gitignore" do
  user "vagrant"
  code <<-EOH
    cd /vagrant/.git/hooks
    if ls | grep 'post-merge'; then mv post-merge post-merge.bak; fi
  EOH
  not_if "ls /vagrant/.git/hooks | grep 'post-merge.bak'"
end

# insatll post-merge hook
cookbook_file "post-merge" do
  path "/vagrant/.git/hooks/post-merge"
  action :create_if_missing
end

# Make post-merge hook executable 
bash "configure gitignore" do
  user "vagrant"
  code <<-EOH
    cd /vagrant/.git/hooks
    chmod u+x post-merge
  EOH
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
