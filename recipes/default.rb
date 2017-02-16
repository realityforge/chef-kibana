# Encoding: utf-8

=begin
#<
Install Kibana.
#>
=end

kibana_user 'kibana'

kibana_install 'kibana' do
  type node['kibana']['install_method'].to_sym
  action :install
end

kibana_configure 'kibana'

kibana_service 'kibana' do
  bin_path node['kibana']['service']['bin_path']
  init_template node['kibana']['service']['template_file']
  init_source node['kibana']['service']['source']
  action [:configure, :start]
end
