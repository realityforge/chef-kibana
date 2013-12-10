# Encoding: utf-8

name             'kibana'
maintainer       'Peter Donald'
maintainer_email 'peter@realityforge.org'
license          'Apache 2.0'
description      'Installs/Configures kibana, the logstash UI'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.1.7'

depends 'build-essential'
depends 'ark'
suggests 'authbind'
suggests 'apache2'
suggests 'apt'
suggests 'nginx'
