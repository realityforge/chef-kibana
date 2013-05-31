package 'git'

group node['kibana']['group'] do
end

user node['kibana']['user'] do
  comment 'Kibana Server'
  gid node['kibana']['group']
  home node['kibana']['base_dir']
  shell '/bin/bash'
  system true
end

directory node['kibana']['base_dir'] do
  mode '0700'
  owner node['kibana']['user']
  group node['kibana']['group']
  recursive true
end

git node['kibana']['base_dir'] do
  repository node['kibana']['git']['url']
  reference node['kibana']['git']['reference']
  user node['kibana']['user']
  group node['kibana']['group']
  action :checkout
end

gem_package 'bundler' do
    gem_binary "/usr/bin/gem#{node['kibana']['rubyversion']}"
  action :install
end

# kibana requires eventmachine which requires a gem with native extensions. Thus we need
# to include build-essentials prior to installing kibana
include_recipe 'build-essential::default'

bash 'kibana bundle install' do
  cwd node['kibana']['base_dir']
  code 'bundle install'
end

service 'kibana' do
  provider Chef::Provider::Service::Upstart
  supports :start => true, :restart => true, :stop => true, :status => true
  action :nothing
end

template '/etc/init.d/kibana' do
  source 'kibana.init.erb'
  mode 00755
  notifies :restart, 'service[kibana]', :delayed
end

template "#{node['kibana']['base_dir']}/KibanaConfig.rb" do
  source 'KibanaConfig.rb.erb'
  user node['kibana']['user']
  group node['kibana']['group']
  mode 00600
  notifies :restart, 'service[kibana]', :delayed
end

service 'kibana' do
  action [:enable, :start]
end
