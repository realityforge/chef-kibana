# frozen_string_literal: true

name 'kibana'
maintainer 'Peter Donald'
maintainer_email 'peter@realityforge.org'
license 'Apache-2.0'
description 'Installs/Configures kibana, the logstash UI'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version '0.2.2'
source_url 'https://github.com/realityforge/chef-kibana'
issues_url 'https://github.com/realityforge/chef-kibana/issues'

chef_version '>= 12' if respond_to?(:chef_version)

supports 'ubuntu'
supports 'debian'
supports 'centos'

depends 'build-essential'
depends 'ark'
depends 'apt'

# Suggests is not officially valid, that is why these are commented out
# suggests 'apache2', '>= 2.0'
# suggests 'authbind'
# suggests 'chef_nginx'
# suggests 'java'
# suggests 'elasticsearch'
