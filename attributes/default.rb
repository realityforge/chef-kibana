# Encoding: utf-8

#<> Kibana version
default['kibana']['version'] = '4.0.2'
#<> Kibana3 exact version
# should be only one such variable
#default['kibana']['kibana3_version'] = '3.0.0'
#<> The base directory of kibana.
default['kibana']['base_dir'] = '/opt/kibana'
default['kibana']['log_file'] = '/var/log/kibana.log'
#<> The user under which Kibana is installed.
default['kibana']['user'] = 'kibana'
#<> The group under which Kibana is installed.
default['kibana']['group'] = 'kibana'
#<> Install method. Can be source or release
default['kibana']['install_method'] = 'release'
#<> Url of tarball
if node['kibana']['version'].to_i < 4
  default['kibana']['url'] = "https://download.elasticsearch.org/kibana/kibana/kibana-#{node['kibana']['version']}.tar.gz"
else
  if node['kernel']['machine'] == 'x86_64'
    default['kibana']['url'] = "https://download.elasticsearch.org/kibana/kibana/kibana-#{node['kibana']['version']}-linux-x64.tar.gz"
  else
    default['kibana']['url'] = "https://download.elasticsearch.org/kibana/kibana/kibana-#{node['kibana']['version']}-linux-x86.tar.gz"
  end
end
#<> Checksum of the tarball
#default['kibana']['checksum'] = 'df25bc0cc02385edcac446ef8cbd83b896cdc910a0fa1b0a7bd2a958164593a8'
default['kibana']['checksum'] = nil
#<> The URL to Kibana repository.
default['kibana']['git']['url'] = if node['kibana']['version'] > '2'
                                    'https://github.com/elasticsearch/kibana.git'
                                  else
                                    'https://github.com/rashidkpc/kibana2.git'
                                  end
#<> The git reference in the Kibana repository.
default['kibana']['git']['reference'] = if node['kibana']['version'] > '2'
                                          'v' + node['kibana']['version']
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
#<> Fields specifiers which default to @message (may need to be changed for newer logstash)
default['kibana']['highlighted_field'] = '@message'
default['kibana']['primary_field'] = '@message'
default['kibana']['default_index'] = '@message'

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
#<> Boolean switch to enable apache search query proxy
default['kibana']['apache']['proxy'] = false
#<> The port on which to bind nginx
default['kibana']['nginx']['port'] = 80

#<> The port on which to bind nginx.
default['kibana']['nginx']['listen_http']  = 80
#<> The HTTPS port on which to bind nginx.
default['kibana']['nginx']['listen_https'] = 443

default['kibana']['nginx']['client_max_body'] = '50M'

#<> Boolean switch to enable SSL configuration.
default['kibana']['nginx']['ssl'] = false
#<> Boolean switch to enable nginx search query proxy
default['kibana']['nginx']['proxy'] = false
#<> Boolean switch to enable auth basic
default['kibana']['nginx']['auth'] = false

#<> The path to auth basic file
default['kibana']['auth_file'] = '/etc/nginx/htpasswd.users'

#<> The path to the SSL certificate file.
default['kibana']['nginx']['ssl_certificate']     = nil
#<> The path to the SSL certificate key.
default['kibana']['nginx']['ssl_certificate_key'] = nil

# nginx ssl boilerplate
#<> The SSL protocols.
default['kibana']['nginx']['ssl_protocols']       = 'TLSv1 TLSv1.1 TLSv1.2'
#<> The SSL ciphers.
default['kibana']['nginx']['ssl_ciphers']         = 'ECDHE-RSA-RC4-SHA:ECDHE-RSA-AES128-SHA:AES256-CGM-SHA256:ECDHE-RSA-AES256-SHA256:RC4:HIGH:!aNULL:!MD5:-LOW:-SSLv2:-EXP'
#<> The SSL session cache.
default['kibana']['nginx']['ssl_session_cache']   = 'shared:SSL:10m'
#<> The SSL session timeout.
default['kibana']['nginx']['ssl_session_timeout'] = '10m'

#<> The virtualhost server name.
default['kibana']['nginx']['server_name'] = 'kibana'
