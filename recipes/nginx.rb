# Encoding: utf-8

include_recipe 'nginx'

template File.join(node['nginx']['dir'], 'sites-available', 'kibana') do
  source 'nginx.erb' if node['kibana']['version'].to_i < 4
  source 'nginx4.erb' if node['kibana']['version'].to_i >= 4
  owner node['nginx']['user']
  mode '0644'
  variables(
    'root'                => File.join(node['kibana']['base_dir'], 'current'),
    'log_dir'             => node['nginx']['log_dir'],
    'listen_http'         => node['kibana']['nginx']['listen_http'],
    'listen_https'        => node['kibana']['nginx']['listen_https'],
    'client_max_body'     => node['kibana']['nginx']['client_max_body'],
    'server_name'         => node['kibana']['nginx']['server_name'],
    'ssl'                 => node['kibana']['nginx']['ssl'],
    'ssl_certificate'     => node['kibana']['nginx']['ssl_certificate'],
    'ssl_certificate_key' => node['kibana']['nginx']['ssl_certificate_key'],
    'ssl_protocols'       => node['kibana']['nginx']['ssl_protocols'],
    'ssl_ciphers'         => node['kibana']['nginx']['ssl_ciphers'],
    'ssl_session_cache'   => node['kibana']['nginx']['ssl_session_cache'],
    'ssl_session_timeout' => node['kibana']['nginx']['ssl_session_timeout'],
    'proxy'               => node['kibana']['nginx']['proxy'],
    'auth'                => node['kibana']['nginx']['auth'],
    'auth_file'           => node['kibana']['auth_file']
  )
end

nginx_site 'kibana' do
  enable true
end
