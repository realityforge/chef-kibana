# Encoding: utf-8

require_relative 'spec_helper'

describe 'kibana::default' do
  before { stub_resources }
  supported_platforms.each do |platform, versions|
    versions.each do |version|
      context "on #{platform.capitalize} #{version}" do
        let(:chef_run) do
          ChefSpec::ServerRunner.new(platform: platform, version: version) do |node, server|
            node_resources(node) # data for this node
            stub_chef_zero(platform, version, server) # stub other nodes in chef-zero
          end.converge(described_recipe)
        end

        # any platform specific data you want available to your test can be loaded here
        _property = load_platform_properties(platform: platform, platform_version: version)

        it 'creates kibana_user' do
          expect(chef_run).to create_kibana_user('kibana')
        end

        it 'installs kibana' do
          expect(chef_run).to install_kibana('kibana')
        end

        it 'configure kibana' do
          expect(chef_run).to manage_kibana_configure('kibana')
        end

        it 'start kibana service' do
          expect(chef_run).to start_kibana_service('kibana')
        end
      end
    end
  end
end
