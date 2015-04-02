# Encoding: utf-8

#node.default['kibana']['checksum'] = "c925f75cd5799bfd892c7ea9c5936be10a20b119"

include_recipe 'kibana'
include_recipe 'supervisor'

Chef::Application.fatal!("Currently only release install_method is supported for Kibana 4.x", 1) if node['kibana']['install_method'] != 'release'

ark 'kibana' do
  url node['kibana']['url']
  version node['kibana']['version']
  checksum node['kibana']['checksum'] unless node['kibana']['checksum']
  path node['kibana']['base_dir']
  home_dir File.join(node['kibana']['base_dir'], 'current')
end

config_path = 'current/config/kibana.yml'

template File.join(node['kibana']['base_dir'], config_path) do
  cookbook node['kibana']['config']['cookbook']
  source   node['kibana']['config']['source']
  owner node['kibana']['user']
  group node['kibana']['group']
  mode '0644'
  notifies :restart, 'supervisor_service[kibana]', :delayed
end

supervisor_service 'kibana' do
  action [:enable, :start]
  autostart true
  autorestart true
  user node['kibana']['user']
  stdout_logfile node['kibana']['log_file']
  redirect_stderr true
  directory File.join(node['kibana']['base_dir'], 'current')
  command File.join(node['kibana']['base_dir'], 'current/bin/kibana')
end