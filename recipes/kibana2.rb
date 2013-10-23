include_recipe 'kibana'

package 'git'

git node['kibana']['base_dir'] do
  repository node['kibana']['git']['url']
  reference node['kibana']['git']['reference']
  user node['kibana']['user']
  group node['kibana']['group']
  action :checkout
end

if node['platform']["ubuntu"]
  package "libcurl4-gnutls-dev"
end

if node['kibana']['rubyversion'] == '1.8' or node['kibana']['rubyversion'] == '1.9.1'
  package "ruby#{node['kibana']['rubyversion']}-full"
else
  package "ruby#{node['kibana']['rubyversion']}"
end

#gem1.8 doesn't get brought in with ruby1.8.x
if  node['kibana']['rubyversion'] == '1.8'
    package "rubygems#{node['kibana']['rubyversion']}"
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

template '/etc/init/kibana.conf' do
  source 'upstart.conf.erb'
  mode '0600'
  notifies :restart, 'service[kibana]', :delayed
end

template "#{node['kibana']['base_dir']}/KibanaConfig.rb" do
  source 'KibanaConfig.rb.erb'
  user node['kibana']['user']
  group node['kibana']['group']
  mode '0600'
  notifies :restart, 'service[kibana]', :delayed
end

service 'kibana' do
  action [:enable, :start]
end
