# frozen_string_literal: true

require_relative 'spec_helper'

# for ubuntu 14.04 upstart
# describe 'kibana::_service' do
#   before { stub_resources }
#   let(:chef_run) { ChefSpec::SoloRunner.new(UBUNTU_OPTS).converge(described_recipe) }
#   let(:template) { chef_run.template('/etc/init/kibana.conf') }
#   it 'creates an upstart template at /etc/init/kibana.conf' do
#     expect(chef_run).to create_template('/etc/init/kibana.conf')
#   end
# end
#
# # for ubuntu 16.04 systemd
# describe 'kibana::_service' do
#   before { stub_resources }
#   let(:chef_run) { ChefSpec::SoloRunner.new(UBUNTU_1604_OPTS).converge(described_recipe) }
#   let(:template) { chef_run.template('/lib/systemd/system/kibana.service') }
#   it 'creates an upstart template at /lib/systemd/system/kibana.service' do
#     expect(chef_run).to create_template('/lib/systemd/system/kibana.service')
#   end
# end
#
# # for centos 6.x init
# describe 'kibana::_service' do
#   before { stub_resources }
#   let(:chef_run) { ChefSpec::SoloRunner.new(CENTOS_OPTS).converge(described_recipe) }
#   let(:template) { chef_run.template('/usr/lib/systemd/system/kibana.service') }
#
#   it 'creates an init.d template at /usr/lib/systemd/system/kibana.service' do
#     expect(chef_run).to create_template('/usr/lib/systemd/system/kibana.service')
#   end
# end
#
# # for centos 7.x systemd
# describe 'kibana::_service' do
#   before { stub_resources }
#   let(:chef_run) { ChefSpec::SoloRunner.new(CENTOS7_OPTS).converge(described_recipe) }
#   let(:template) { chef_run.template('/usr/lib/systemd/system/kibana.service') }
#   it 'creates an init.d template at /usr/lib/systemd/system/kibana.service' do
#     expect(chef_run).to create_template('/usr/lib/systemd/system/kibana.service')
#   end
# end

describe 'kibana::_service' do
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

        # tempalte kibana service

        it 'enables a kibana service' do
          expect(chef_run).to enable_service('kibana')
        end

        # it 'sends a restart notification to the service' do
        #   expect(template).to notify('service[kibana]').to(:restart)
        # end
      end
    end
  end
end
