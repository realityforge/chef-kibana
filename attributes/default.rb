#<> The base directory of kibana.
default['kibana']['base_dir'] = '/opt/kibana'
#<> The user under which Kibana is installed.
default['kibana']['user'] = 'kibana'
#<> The group under which Kibana is installed.
default['kibana']['group'] = 'kibana'
#<> The URL to Kibana repository.
default['kibana']['git']['url'] = 'https://github.com/rashidkpc/Kibana.git'
#<> The git reference in the Kibana repository.
default['kibana']['git']['reference'] = 'v0.2.0'
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

#<> The host to create apache vhost for.
default['kibana']['apache']['host'] = node['fqdn']
#<> The interface on which to bind apache.
default['kibana']['apache']['interface'] = node['ipaddress']
#<> The port on which to bind apache.
default['kibana']['apache']['port'] = 80
