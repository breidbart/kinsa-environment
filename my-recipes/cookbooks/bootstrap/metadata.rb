name 'bootstrap'

supports 'ubuntu', '>= 12.0.4'

depends "apt"
depends "build-essential"
depends "git"
depends "gitflow"
depends "libfreetype"
depends "libjpeg"
depends "openssl"
depends "postgresql"
depends "python"
depends 'rbenv'
depends 'ruby_build'
depends "sudo"
depends "zlib"

license 'Apache 2.0'

description 'Bootstrap Ubuntu for Django development work.'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))

maintainer 'Joe Bergantine'
maintainer_email 'jbergantine@gmail.com'

version "0.0.5"