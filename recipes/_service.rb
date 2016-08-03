# Encoding: utf-8

service 'kibana' do
  if node['kibana']['service']['upstart']
    provider Chef::Provider::Service::Upstart
  end
  supports start: true, restart: true, stop: true, status: true
  action :nothing
end

template node['kibana']['template_file'] do
  cookbook node['kibana']['service']['cookbook']
  source node['kibana']['service']['source']
  variables(
    version: node['kibana']['version'],
    options: '', # TODO
    recent_upstart: (node['platform_family'] != 'rhel')
  )
  notifies :restart, 'service[kibana]', :delayed
end
