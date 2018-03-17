# frozen_string_literal: true

require_relative 'spec_helper'

describe 'kibana::kibana3' do
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

        _property = load_platform_properties(platform: platform, platform_version: version)

        it 'includes kibana recipe' do
          expect(chef_run).to include_recipe('kibana::default')
        end

        it 'installs kibana3 with ark' do
          expect(chef_run).to install_ark('kibana')
        end

        it 'creates a template for kibana' do
          expect(chef_run).to create_template('/opt/kibana/current/config.js').with(
            owner: 'kibana',
            group: 'kibana',
            mode:  '0644'
          )
        end
      end
    end
  end
end

# if source install is requested test this path
describe 'kibana::kibana3' do
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

        _property = load_platform_properties(platform: platform, platform_version: version)

        it 'installs package git' do
          expect(chef_run).to install_package('git')
        end
        it 'checks out /opt/kibana' do
          expect(chef_run).to checkout_git('/opt/kibana/current').with(repository: 'https://github.com/elastic/kibana.git')
        end

        it 'creates a template for kibana' do
          expect(chef_run).to create_template('/opt/kibana/current/src/config.js').with(
            owner: 'kibana',
            group: 'kibana',
            mode:  '0644'
          )
        end
      end
    end
  end
end
