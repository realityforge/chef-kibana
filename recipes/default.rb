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

package 'git'

git node['kibana']['base_dir'] do
  repository node['kibana']['git']['url']
  reference node['kibana']['git']['reference']
  user node['kibana']['user']
  group node['kibana']['group']
  action :checkout
end

%w[libcurl4-gnutls-dev ruby1.9.1-full].each do |pkg|
  apt_package pkg
end

gem_package 'bundler' do
  gem_binary '/usr/bin/gem1.9.1'
end

bash 'kibana bundle install' do
  cwd node['kibana']['base_dir']
  code 'bundle install'
end

service 'kibana' do
  provider Chef::Provider::Service::Upstart
  supports :start => true, :restart => true, :stop => true, :status => true
  action :nothing
end

template '/etc/init/kibana.conf' do
  source 'upstart.conf.erb'
  mode '0600'
  notifies :restart, 'service[kibana]', :delayed
end

template "#{node['kibana']['base_dir']}/KibanaConfig.rb" do
  source 'KibanaConfig.rb.erb'
  mode '0600'
  notifies :restart, 'service[kibana]', :delayed
end

service 'kibana' do
  action [:enable, :start]
end
