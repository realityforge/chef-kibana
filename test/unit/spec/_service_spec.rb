require 'chefspec'
require_relative 'spec_helper'

describe 'kibana::_service' do
  before { stub_resources }

  let(:chef_run) { ChefSpec::SoloRunner.new(platform: 'ubuntu', version: '14.04').converge(described_recipe) }
  let(:template) { chef_run.template(node['kibana']['template_file']) }

  it 'expects service kibana to do nothing' do
    kibana_service = chef_run.service('kibana')
    expect(kibana_service).to do_nothing
  end

  it 'creates an upstart template at /etc/init/kibana.conf' do
    expect(chef_run).to create_template(node['kibana']['template_file'])
  end

  it 'sends a restart notification to the service' do
    expect(template).to notify('service[kibana]').to(:restart)
  end
end

# TODO: enable for CentOS 6 initscript
#describe 'kibana::_service' do
#  before { stub_resources }
#  let(:chef_run) { ChefSpec::SoloRunner.new(platform: 'redhat', version: '6.0').converge(described_recipe) }
#  let(:template) { chef_run.template('/etc/init.d/kibana') }
#
#  it 'creates an init.d template at /etc/init.d/kibana' do
#    expect(chef_run).to create_template('/etc/init.d/kibana')
#  end
#
#  it 'sends a restart notification to the service' do
#    expect(template).to notify('service[kibana]').to(:restart)
#  end
#end

# TODO: enable for CentOS/RHEL 7 systemd
