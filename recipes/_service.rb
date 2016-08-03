# Encoding: utf-8

service 'kibana' do
  provider node['kibana']['service']['provider']
  supports start: true, restart: true, stop: true, status: true
  action :nothing
end

#service 'kibana' do
#  case node['platform']
#  when 'centos'
#    if node['platform_version'].to_f <= 6.8
#      provider Chef::Provider::Service::Init::Redhat
#    else
#      provider Chef::Provider::Service::Systemd
#    end
#  when 'ubuntu'
#      provider Chef::Provider::Service::Upstart
#  end
#  supports start: true, restart: true, stop: true, status: true
#  action :nothing
#end

template node['kibana']['service']['template_file'] do
  cookbook node['kibana']['service']['cookbook']
  source node['kibana']['service']['source']
  variables(
    version: node['kibana']['version'],
    options: '', # TODO
    recent_upstart: (node['platform_family'] != 'rhel')
  )
  notifies :restart, 'service[kibana]', :delayed
end
