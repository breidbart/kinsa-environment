# Create Bash Aliases, append custom colors
cookbook_file "profile.sh" do
  owner "vagrant"
  group "vagrant"
  path "/home/vagrant/.bash_profile"
  action :create_if_missing
end