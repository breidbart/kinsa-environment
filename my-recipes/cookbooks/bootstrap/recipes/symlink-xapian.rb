# Symlink Xapian
bash "symlink xapian to virtualenv" do
  user "root"
  code <<-EOH
    ln -s /usr/lib/python2.7/dist-packages/xapian /home/vagrant/.virtualenvs/djangoproj/lib/python2.7/site-packages/xapian
  EOH
  not_if "ls /home/vagrant/.virtualenvs/djangoproj/lib/python2.7/site-packages | grep 'xapian'"
end
