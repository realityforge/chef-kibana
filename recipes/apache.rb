# Encoding: utf-8

=begin
#<
Setup vhost for apache that rewrites to Kibana.
#>
=end

include_recipe 'apache2'
include_recipe 'apache2::mod_proxy'
include_recipe 'apache2::mod_proxy_http'

template "#{node['apache']['dir']}/htpasswd" do
  variables(username: node['kibana']['apache']['basic_auth_username'],
            password: node['kibana']['apache']['basic_auth_password'])
  owner node['apache']['user']
  group node['apache']['group']
  mode 0o0644
  not_if { node['kibana']['apache']['basic_auth'] == 'off' }
end

template "#{node['apache']['dir']}/sites-available/kibana.conf" do
  variables(
    'index' => node['kibana']['index'],
    'kibana_service' => node['kibana']['kibana_service'],
    'port' => node['kibana']['elasticsearch']['port']
  )
  source 'vhost3.conf.erb' if node['kibana']['version'] == 3
  source 'vhost4.conf.erb' if node['kibana']['version'] == 4
  cookbook node['kibana']['apache']['cookbook']
  owner node['apache']['user']
  group node['apache']['group']
  mode 0o0644
  notifies :restart, 'service[apache2]'
end

apache_site 'kibana'
