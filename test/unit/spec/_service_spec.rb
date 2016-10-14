require 'chefspec'
require_relative 'spec_helper'

# for ubuntu 14.04 upstart
describe 'kibana::_service' do
  before { stub_resources }
  let(:chef_run) { ChefSpec::SoloRunner.new(UBUNTU_OPTS).converge(described_recipe) }
  let(:template) { chef_run.template('/etc/init/kibana.conf') }
  it 'creates an upstart template at /etc/init/kibana.conf' do
    expect(chef_run).to create_template('/etc/init/kibana.conf')
  end
  it 'enables a kibana service' do
    expect(chef_run).to enable_service('kibana')
  end
  it 'sends a restart notification to the service' do
    expect(template).to notify('service[kibana]').to(:restart)
  end
end

# for ubuntu 16.04 systemd
describe 'kibana::_service' do
  before { stub_resources }
  let(:chef_run) { ChefSpec::SoloRunner.new(UBUNTU_1604_OPTS).converge(described_recipe) }
  let(:template) { chef_run.template('/lib/systemd/system/kibana.service') }
  it 'creates an upstart template at /lib/systemd/system/kibana.service' do
    expect(chef_run).to create_template('/lib/systemd/system/kibana.service')
  end
  it 'enables a kibana service' do
    expect(chef_run).to enable_service('kibana')
  end
  it 'sends a restart notification to the service' do
    expect(template).to notify('service[kibana]').to(:restart)
  end
end

# for centos 6.x init
describe 'kibana::_service' do
  before { stub_resources }
  let(:chef_run) { ChefSpec::SoloRunner.new(CENTOS_OPTS).converge(described_recipe) }
  let(:template) { chef_run.template('/etc/init.d/kibana') }

  it 'creates an init.d template at /etc/init.d/kibana' do
    expect(chef_run).to create_template('/etc/init.d/kibana')
  end
  it 'enables a kibana service' do
    expect(chef_run).to enable_service('kibana')
  end
  it 'sends a restart notification to the service' do
    expect(template).to notify('service[kibana]').to(:restart)
  end
end

# for centos 7.x systemd
describe 'kibana::_service' do
  before { stub_resources }
  let(:chef_run) { ChefSpec::SoloRunner.new(CENTOS7_OPTS).converge(described_recipe) }
  let(:template) { chef_run.template('/usr/lib/systemd/system/kibana.service') }
  it 'creates an init.d template at /usr/lib/systemd/system/kibana.service' do
    expect(chef_run).to create_template('/usr/lib/systemd/system/kibana.service')
  end
  it 'enables a kibana service' do
    expect(chef_run).to enable_service('kibana')
  end
  it 'sends a restart notification to the service' do
    expect(template).to notify('service[kibana]').to(:restart)
  end
end
