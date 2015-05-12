# Encoding: utf-8

#<> Kibana major version
default['kibana']['version'] = '2'
#<> Kibana3 exact version
default['kibana']['kibana3_version'] = '3.0.0'
#<> Kibana4 exact version
default['kibana']['kibana4_version'] = '4.0.2'
#<> The base directory of kibana.
default['kibana']['base_dir'] = '/opt/kibana'
#<> The user under which Kibana is installed.
default['kibana']['user'] = 'kibana'
#<> The group under which Kibana is installed.
default['kibana']['group'] = 'kibana'
#<> Install method. Can be source or release
default['kibana']['install_method'] = 'release'

url_version = node['kibana']["kibana#{node['kibana']['version']}_version"] || node['kibana']['version']
#<> Url of tarball
default['kibana']['url'] = Kibana::Url.new(node, url_version).get
#<> Checksum of the tarball
default['kibana']['checksum'] = 'df25bc0cc02385edcac446ef8cbd83b896cdc910a0fa1b0a7bd2a958164593a8'
#<> Checksum of the tarball (for Kibana4)
default['kibana']['kibana4_checksum'] = '4cc36e5c6ca7c495667319df75feda1facb7c43a3d9686841f07a2522adec294'

#<> The URL to Kibana repository.
default['kibana']['git']['url'] = if node['kibana']['version'] > '2'
                                    'https://github.com/elasticsearch/kibana.git'
                                  else
                                    'https://github.com/rashidkpc/kibana2.git'
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
default['kibana']['interface'] = '127.0.0.1'

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
#<> The cookbook from which configuration template is taken
default['kibana']['config']['cookbook'] = nil
#<> The template from which configuration is generated from
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

#<> Redirect requests to kibana service
default['kibana']['nginx']['kibana_service'] = nil
unless node['kibana']['version'] =~ /^3/
  default['kibana']['nginx']['kibana_service'] = "http://#{node['kibana']['interface']}:#{node['kibana']['port']}"
end

#<> The kibana service configuration source
default['kibana']['service']['source'] = 'upstart.conf.erb'
default['kibana']['service']['cookbook'] = 'kibana'

#<> The kibana 4 default application on load
default['kibana']['defaultapp'] = 'discover'
