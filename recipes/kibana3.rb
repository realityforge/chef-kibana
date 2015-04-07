# Encoding: utf-8

include_recipe 'kibana'

if node['kibana']['install_method'] == 'source'
  package 'git'

  git File.join(node['kibana']['base_dir'], 'current') do
    repository node['kibana']['git']['url']
    reference node['kibana']['git']['reference']
    user node['kibana']['user']
    group node['kibana']['group']
    action :checkout
  end
  config_path = 'current/src/config.js'
else
  ark 'kibana' do
    url node['kibana']['url']
    version node['kibana']['version']
    checksum node['kibana']['checksum'] unless node['kibana']['checksum']
    path node['kibana']['base_dir']
    home_dir File.join(node['kibana']['base_dir'], 'current')
  end
  config_path = 'current/config.js'
end

template File.join(node['kibana']['base_dir'], config_path) do
  cookbook node['kibana']['config']['cookbook']
  source   node['kibana']['config']['source']
  owner node['kibana']['user']
  group node['kibana']['group']
  mode '0644'
  variables('es_port' => node['kibana']['elasticsearch']['port'])
end
