include_recipe 'apache2::mod_proxy'
include_recipe 'apache2::mod_proxy_http'

template "#{node['apache']['dir']}/sites-available/kibana" do
  source 'vhost.conf.erb'
  notifies :restart, resources(:service => 'apache2')
end

template "#{node['apache']['dir']}/sites-available/kibana" do
  source 'vhost.conf.erb'
  owner node['apache']['user']
  group node['apache']['group']
  mode 00644
  notifies :restart, 'service[apache2]'
end

apache_site 'kibana'
