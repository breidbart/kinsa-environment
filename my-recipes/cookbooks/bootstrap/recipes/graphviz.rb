# Django Extensions lets you use GraphViz to create Model visualizations.

# http://django-extensions.readthedocs.org/en/latest/graph_models.html

# This recipe installs the graphviz application, symlinks it into the virtual 
# environnment and installs the required Python libraries to talk to it.

packages = Array.new

packages |= %w/
  graphviz
/

packages.each do |pkg|
  package pkg do
    action [:install, :upgrade]
  end
end

# Symlink Graphviz
bash "symlink graphviz to virtualenv" do
  user "root"
  code <<-EOH
    ln -s /usr/lib/graphviz /home/vagrant/.virtualenvs/djangoproj/lib/graphviz
  EOH
  not_if "ls /home/vagrant/.virtualenvs/djangoproj/lib | grep 'graphviz'"
end

# Globally install pyparsing==1.5.7
python_pip "pyparsing" do
  version "1.5.7"
end

# Globally install pydot
python_pip "pydot" 