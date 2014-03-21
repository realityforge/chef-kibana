# Encoding: utf-8

#<> Kibana version
default['kibana']['version'] = '2'
#<> Kibana3 exact version
default['kibana']['kibana3_version'] = '3.0.0'
#<> The base directory of kibana.
default['kibana']['base_dir'] = '/opt/kibana'
#<> The user under which Kibana is installed.
default['kibana']['user'] = 'kibana'
#<> The group under which Kibana is installed.
default['kibana']['group'] = 'kibana'
#<> Install method. Can be source or release
default['kibana']['install_method'] = 'release'
#<> Url of tarball
default['kibana']['url'] = "https://download.elasticsearch.org/kibana/kibana/kibana-#{node['kibana']['kibana3_version']}.tar.gz"
#<> Checksum of the tarball
default['kibana']['checksum'] = 'df25bc0cc02385edcac446ef8cbd83b896cdc910a0fa1b0a7bd2a958164593a8'
#<> The URL to Kibana repository.
default['kibana']['git']['url'] = if node['kibana']['version'] > '2'
                                    'https://github.com/elasticsearch/kibana.git'
                                  else
                                    'https://github.com/rashidkpc/Kibana.git'
                                  end
#<> The git reference in the Kibana repository.
default['kibana']['git']['reference'] = if node['kibana']['version'] > '2'
                                          'v' + node['kibana']['kibana3_version']
                                        else
                                          'v0.2.0'
                                        end
#<> The version of Ruby and Gems to use for Kibana.
default['kibana']['rubyversion'] = '1.9.1'

#<> The interface on which to bind.
default['kibana']['interface'] = node['ipaddress']
#<> The port on which to bind.
default['kibana']['port'] = 5601
#<> An Array of the elasticsearch service hosts.
default['kibana']['elasticsearch']['hosts'] = ['127.0.0.1']
#<> The port of the elasticsearch http service.
default['kibana']['elasticsearch']['port'] = 9200
#<> The which fields are shown by default.
default['kibana']['default_fields'] = '["@message"]'
#<> The operator used if no explicit operator is specified.
default['kibana']['default_operator'] = 'OR'
#<> The cookbook from which config.js template is taken
default['kibana']['config']['cookbook'] = nil
#<> The template from which config.js is generated from
default['kibana']['config']['source'] = nil

#<> The host to create apache vhost for.
default['kibana']['apache']['host'] = node['fqdn']
#<> The interface on which to bind apache.
default['kibana']['apache']['interface'] = node['ipaddress']
#<> Enable http auth for Apache
default['kibana']['apache']['basic_auth'] = 'off'
#<> Apache http auth username
default['kibana']['apache']['basic_auth_username'] = 'admin'
#<> Apache http auth password
default['kibana']['apache']['basic_auth_password'] = 'PLEASEchangeme'
#<> The port on which to bind apache.
default['kibana']['apache']['port'] = 80
#<> The port on which to bind nginx
default['kibana']['nginx']['port'] = 80
