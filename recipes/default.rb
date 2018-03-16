# frozen_string_literal: true

=begin
#<
Install Kibana.
#>
=end

group node['kibana']['group'] do
end

user node['kibana']['user'] do
  comment 'Kibana Server'
  gid node['kibana']['group']
  home node['kibana']['base_dir']
  shell '/bin/bash'
  system true
end

directory node['kibana']['base_dir'] do
  mode '0755'
  owner node['kibana']['user']
  group node['kibana']['group']
  recursive true
end

include_recipe "kibana::kibana#{node['kibana']['version']}"
