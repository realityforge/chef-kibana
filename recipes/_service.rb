# Encoding: utf-8

service 'kibana' do
  provider Chef::Provider::Service::Upstart
  supports start: true, restart: true, stop: true, status: true
  action :nothing
end

template '/etc/init/kibana.conf' do
  cookbook node['kibana']['service']['cookbook']
  source node['kibana']['service']['source']
  variables(
    version: node['kibana']['version'],
    options: '', # TODO
    recent_upstart: (node['platform_family'] != 'rhel')
  )
  notifies :restart, 'service[kibana]', :delayed
end
