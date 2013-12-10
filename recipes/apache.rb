=begin
#<
Setup vhost for apache that rewrites to Kibana.
#>
=end

include_recipe 'apache2'
include_recipe 'apache2::mod_proxy'
include_recipe 'apache2::mod_proxy_http'

template "#{node['apache']['dir']}/htpasswd" do
  variables( :username => node['kibana']['apache']['basic_auth_username'],
             :password => node['kibana']['apache']['basic_auth_password'])
  owner node['apache']['user']
  group node['apache']['group']
  mode 00644
end

template "#{node['apache']['dir']}/sites-available/kibana" do
  source 'vhost.conf.erb' if node['kibana']['version'] =~ /^2/
  source 'vhost3.conf.erb' if node['kibana']['version'] =~ /^3/
  owner node['apache']['user']
  group node['apache']['group']
  mode 00644
  notifies :restart, 'service[apache2]'
end

apache_site 'kibana'
