# Encoding: utf-8

#<> Kibana major version
default['kibana']['version'] = '5'

#<> Kibana3 exact version
default['kibana']['kibana3_version'] = '3.1.2'
default['kibana']['kibana3_checksum'] = '480562733c2c941525bfa26326b6fae5faf83109b452a6c4e283a5c37e3086ee'
default['kibana']['kibana3_url'] = 'https://download.elastic.co/kibana/kibana/kibana-3.1.2.tar.gz'

#<> Kibana4 exact version
default['kibana']['kibana4_version'] = '4.6.3'
default['kibana']['kibana4_checksum'] = '483d49d7d03052f4885c88d905b602f3fa432cb12e2c2cbdab82bb0d259d00c7'
default['kibana']['kibana4_url'] = 'https://download.elastic.co/kibana/kibana/kibana-4.6.3-linux-x86_64.tar.gz'

#<> Kibana5 exact version, checksum, URL
default['kibana']['kibana5_version'] = '5.1.1',
default['kibana']['kibana5_checksum'] = 'da0383be8a12936c7d2a0a145e7bf0eb15abf972e585e0115ed8742032c79245',
default['kibana']['kibana5_url'] = 'https://artifacts.elastic.co/downloads/kibana/kibana-5.1.1-linux-x86_64.tar.gz',

#<> The base directory of kibana.
default['kibana']['base_dir'] = '/opt/kibana'
#<> The user under which Kibana is installed.
default['kibana']['user'] = 'kibana'
#<> The group under which Kibana is installed.
default['kibana']['group'] = 'kibana'
#<> Install method. Can be source, release or package
default['kibana']['install_method'] = 'release'
#<> Kibana repository url for package method install
default['kibana']['repository_url'] = 'http://packages.elastic.co/kibana/4.5/debian'
#<> Kibana repository Public Signing Key
default['kibana']['repository_key'] = 'https://packages.elastic.co/GPG-KEY-elasticsearch'
#<> The URL to Kibana repository.
default['kibana']['git']['url'] = 'https://github.com/elasticsearch/kibana.git'

#<> The git reference in the Kibana repository.
default['kibana']['git']['reference'] = 'v' + node['kibana']['kibana5_version']

#<> The version of Ruby and Gems to use for Kibana.
case node['platform_family']
when 'debian'
  default['kibana']['rubyversion'] = '1.9.1'
when 'rhel'
  default['kibana']['rubyversion'] = nil
end

#<> The interface on which to bind.
default['kibana']['interface'] = '0.0.0.0'

#<> The port on which to bind.
default['kibana']['port'] = 5601
#<> An Array of the elasticsearch service hosts.
default['kibana']['elasticsearch']['hosts'] = ['127.0.0.1']
#<> The port of the elasticsearch http service.
default['kibana']['elasticsearch']['port'] = 9200

default['kibana']['index'] = if node['kibana']['version'] > '3'
                               '.kibana'
                             else
                               'kibana-int'
                             end

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
#<> The apache configuration source
default['kibana']['apache']['cookbook'] = 'kibana'

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

#<> The nginx configuration source
default['kibana']['nginx']['source'] = node['kibana']['version'] == '4' ? 'nginx4.conf.erb' : 'nginx.conf.erb'
default['kibana']['nginx']['cookbook'] = 'kibana'

#<> Redirect requests to kibana service
default['kibana']['kibana_service'] = nil
unless node['kibana']['version'] =~ /^3/
  default['kibana']['kibana_service'] = "http://#{node['kibana']['interface']}:#{node['kibana']['port']}"
end

# kibana service configurations - defaults to settings for Ubuntu 14.04
case node['platform']
when 'centos', 'amazon'
  if node['platform_version'] < '6.9'
    default['kibana']['service']['provider'] = Chef::Provider::Service::Init::Redhat
    default['kibana']['service']['source'] = 'initd.kibana.erb'
    default['kibana']['service']['template_file'] = '/etc/init.d/kibana'
  else
    default['kibana']['service']['provider'] = Chef::Provider::Service::Systemd
    default['kibana']['service']['source'] = 'systemd.service.erb'
    default['kibana']['service']['template_file'] = '/usr/lib/systemd/system/kibana.service'
  end
when 'ubuntu'
  if node['platform_version'] < '16.04'
    default['kibana']['service']['provider'] = Chef::Provider::Service::Upstart
    default['kibana']['service']['source'] = 'upstart.conf.erb'
    default['kibana']['service']['template_file'] = '/etc/init/kibana.conf'
    default['kibana']['service']['upstart'] = true
  else
    default['kibana']['service']['provider'] = Chef::Provider::Service::Systemd
    default['kibana']['service']['source'] = 'systemd.service.erb'
    default['kibana']['service']['template_file'] = '/lib/systemd/system/kibana.service'
  end
end
default['kibana']['service']['cookbook'] = 'kibana'
default['kibana']['service']['bin_path'] = 'current/bin'
default['kibana']['service']['options'] = ''

#<> The kibana 4 default application on load
default['kibana']['defaultapp'] = 'discover'

# Extra config options for kibana.yml (key: value)
default['kibana']['extra_config'] = {}

# Logging options. Logs to stdout by default.
default['kibana']['log_to_file'] = false
default['kibana']['logfile'] = "#{node['kibana']['base_dir']}/kibana.log"
default['kibana']['logging_option'] = ''

if node['kibana']['log_to_file']
  if node['kibana']['version'] == '3' ||  node['kibana']['version'] == '4'
    default['kibana']['logging_option'] = "log_file: #{node['kibana']['logfile']}"
  elsif node['kibana']['version'] == '5'
    default['kibana']['logging_option'] = "logging.dest: #{node['kibana']['logfile']}"
  end
end

default['kibana']['plugins'] = [
  # example:
  # ES 2.x: { :name => 'marvel', :url => 'elasticsearch/marvel/2.4.1' }
  # ES 5.x: { :name => 'x-pack', :url => 'x-pack' }
]
