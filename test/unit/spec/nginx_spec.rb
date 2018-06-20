require 'chefspec'
require_relative 'spec_helper'

describe 'kibana::nginx' do
  supported_platforms.each do |platform, versions|
    versions.each do |version|
      context "on #{platform.capitalize} #{version}" do
        cached(:chef_run) do
          ChefSpec::ServerRunner.new(platform: platform, version: version) do |node, server|
            node_resources(node) # data for this node
            node.normal['nginx']['dir'] = '/etc/nginx'
            node.normal['kibana']['base_dir'] = '/opt/kibana'
            node.normal['kibana']['elasticsearch']['hosts'] = 'node1'
            stub_chef_zero(platform, version, server) # stub other nodes in chef-zero
          end.converge(described_recipe)
        end

        before do
          stub_resources
          allow(File).to receive(:join).and_call_original
          allow(File).to receive(:join).with('/etc/nginx', 'sites-available', 'kibana').and_return('/etc/nginx/sites-available/kibana')
          allow_any_instance_of(Chef::Recipe).to receive(:include_recipe).with('chef_nginx')
          allow_any_instance_of(Chef::Recipe).to receive(:nginx_site).with('kibana').and_return(true)
        end

        it 'installs included recipes' do
          %w(
            nginx
          ).each do |recipe|
            expect_any_instance_of(Chef::Recipe).to receive(:include_recipe).with(recipe)
            chef_run
          end
        end

        it 'creates the nginx configuration' do
          expect(chef_run).to render_file('/etc/nginx/sites-available/kibana').with_content(/listen\s+80/)
        end

        it 'converges successfully' do
          expect { chef_run }.to_not raise_error
        end
      end
    end
  end
end
