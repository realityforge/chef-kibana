# frozen_string_literal: true

require 'chefspec'
require_relative 'spec_helper'

describe 'kibana::apache' do
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

        # TODO: creates a template /etc/apache2/htpasswd
        # TODO: creates a template /etc/apache2/sites-available/kibana.conf
  
        it 'converges successfully' do
          expect { :chef_run }.to_not raise_error
        end
      end
    end
  end
end
