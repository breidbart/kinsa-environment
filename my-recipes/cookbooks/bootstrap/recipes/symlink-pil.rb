# Create Symlinks for PIL
bash "create symlinks" do
  user "root"
  code <<-EOH
    ln -s /usr/lib/x86_64-linux-gnu/libjpeg.so /usr/lib
    ln -s /usr/lib/x86_64-linux-gnu/libfreetype.so /usr/lib
    ln -s /usr/lib/x86_64-linux-gnu/libz.so /usr/lib
  EOH
  not_if "ls /usr/lib | grep libz.so"
end
