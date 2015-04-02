# Encoding: utf-8

name             'kibana'
maintainer       'Peter Donald'
maintainer_email 'peter@realityforge.org'
license          'Apache 2.0'
description      'Installs/Configures kibana, the logstash UI'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.2.0'

depends 'build-essential'
depends 'ark'
depends 'supervisor', '~> 0.4.12'
suggests 'apache2', '>= 2.0'
suggests 'authbind'
suggests 'apt'
suggests 'nginx'