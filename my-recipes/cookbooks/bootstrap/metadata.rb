depends "apt"
depends "build-essential", "= 1.4.4"
depends "sudo"
depends "openssl"
depends "postgresql"
depends "git"
depends "python" # https://github.com/comandrei/python/
depends "zlib"

license 'BSD'

description 'Bootstrap Ubuntu for Django development work.'

maintainer 'Joe Bergantine'
maintainer_email 'jbergantine@gmail.com'

supports 'ubuntu'

version "0.0.1"