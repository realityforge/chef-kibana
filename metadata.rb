# Encoding: utf-8

name 'kibana'
maintainer 'Peter Donald'
maintainer_email 'peter@realityforge.org'
license 'Apache 2.0'
description 'Installs/Configures kibana, the logstash UI'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version '0.1.12'
source_url 'https://github.com/realityforge/chef-kibana'
issues_url 'https://github.com/realityforge/chef-kibana/issues'

supports 'ubuntu'
supports 'debian'

depends 'build-essential'
depends 'ark'
depends 'apt'

# Suggests is not officially valid, that is why these are commented out
# suggests 'apache2', '>= 2.0'
# suggests 'authbind'
# suggests 'nginx'
# suggests 'java'
# suggests 'elasticsearch'
