include_recipe 'nginx'

template File.join(node['nginx']['dir'], 'sites-available', 'kibana') do
  source 'nginx.erb'
  owner node['nginx']['user']
  mode '0644'
  variables({
    'root' => "#{node['kibana']['base_dir']}/current"
  })
end

nginx_site 'kibana' do
  enable true
end
