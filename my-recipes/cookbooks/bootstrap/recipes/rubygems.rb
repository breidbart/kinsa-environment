# Gem Versions Updated March 27, 2014

gems = Array.new

# d2 array of gem name and version number to install
# version number is an optional argument, exclude it to install the latest version of the gem

# Susy and Compass in their most recent versions currently have a SASS dependency conflict
# http://stackoverflow.com/questions/22299466/cant-get-sass-compass-susy-installed-on-osx-due-to-version-conflict
gems = [
    ['compass', '0.12.4'], # https://rubygems.org/gems/compass
    ['susy', '1.0.9'], # https://rubygems.org/gems/susy
    ['foreman'] # http://rubygems.org/gems/foreman
]

gems.each do |gem|
    gem_package gem[0] do 
        version gem[1] unless gem[1].nil?
        action :install
    end
end
