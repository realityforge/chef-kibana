#Install Options
default['kibana']['base_dir'] = '/opt/kibana'
default['kibana']['user'] = 'kibana'
default['kibana']['group'] = 'kibana'
default['kibana']['git']['url'] = 'https://github.com/rashidkpc/Kibana.git'
default['kibana']['git']['reference'] = 'v0.2.0'
default['kibana']['rubyversion'] = '1.9.1'

#KibanaConfig Options
default['kibana']['interface'] = node['ipaddress']
default['kibana']['port'] = 5601
default['kibana']['elasticsearch']['hosts'] = ['127.0.0.1']
default['kibana']['elasticsearch']['port'] = 9200
default['kibana']['default_fields'] = '["@message"]'

#Apache Config Options
default['kibana']['apache']['host'] = node['fqdn']
default['kibana']['apache']['interface'] = node['ipaddress']
default['kibana']['apache']['port'] = 80
