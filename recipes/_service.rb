# Encoding: utf-8

template node['kibana']['service']['template_file'] do
  cookbook node['kibana']['service']['cookbook']
  source node['kibana']['service']['source']
  mode '0755'
  variables(
    version: node['kibana']['version'],
    options: '', # TODO
    recent_upstart: (node['platform_family'] != 'rhel')
  )
  notifies :restart, 'service[kibana]', :delayed
end

service 'kibana' do
  provider node['kibana']['service']['provider']
  supports start: true, restart: true, stop: true, status: true
  action :enable
end
