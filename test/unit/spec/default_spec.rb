# frozen_string_literal: true

require_relative 'spec_helper'

describe 'kibana::default' do
  before { stub_resources }
  supported_platforms.each do |platform, versions|
    versions.each do |version|
      context "on #{platform.capitalize} #{version}" do
        let(:chef_run) do
          ChefSpec::ServerRunner.new(platform: platform, version: version) do |node, server|
            node_resources(node)
            stub_chef_zero(platform, version, server)
          end.converge(described_recipe)
        end

        # any platform specific data you want available to your test can be loaded here
        _property = load_platform_properties(platform: platform, platform_version: version)

        it 'creates kibana group' do
          expect(chef_run).to create_group('kibana')
        end

        it 'creates kibana user' do
          expect(chef_run).to create_user('kibana').with(
            gid: 'kibana',
            home: '/opt/kibana',
            shell: '/bin/bash'
          )
        end

        it 'creates kibana base directory' do
          expect(chef_run).to create_directory('/opt/kibana').with(
            owner: 'kibana',
            group: 'kibana'
          )
        end
      end
    end
  end
end
