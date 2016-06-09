# Encoding: utf-8

template '/etc/init/kibana.conf' do
  cookbook node['kibana']['service']['cookbook']
  source node['kibana']['service']['source']
  variables(
    version: node['kibana']['version'],
    options: '', # TODO
    recent_upstart: (node['platform_family'] != 'rhel')
  )
  notifies :restart, 'service[kibana]', :delayed
  not_if KibanaUtils.upstart_supports?(node)
end

service 'kibana' do
  if KibanaUtils.upstart_supports?(node)
    provider Chef::Provider::Service::Upstart
  else
    provider Chef::Provider::Service::Systemd
  end
  supports start: true, restart: true, stop: true, status: true
  action :nothing
end

