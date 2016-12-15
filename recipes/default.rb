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
  action [:configure, :start]
end
