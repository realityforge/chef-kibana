# frozen_string_literal: true

require 'chefspec'
require_relative 'spec_helper'

describe 'kibana::kibana4' do
  before { stub_resources }

  let(:chef_run) do
    ChefSpec::SoloRunner.new(UBUNTU_OPTS) do |node|
      node.normal['kibana']['version'] = 4
      node.default['kibana']['install_method'] = 'release'
    end.converge(described_recipe, 'kibana::_service')
  end
  let(:template) { chef_run.template('/opt/kibana/current/config/kibana.yml') }

  it 'includes kibana recipe' do
    expect(chef_run).to include_recipe('kibana::default')
  end
  it 'includes the kibana::_service recipe' do
    expect(chef_run).to include_recipe('kibana::_service')
  end

  it 'installs kibana4 using ark' do
    expect(chef_run).to install_ark('kibana')
  end

  it 'creates a template for the kibana config' do
    expect(chef_run).to create_template('/opt/kibana/current/config/kibana.yml').with(
      owner: 'kibana',
      group: 'kibana',
      mode:  '0644'
    )
  end
  it 'sends a restart notification to the service kibana' do
    expect(template).to notify('service[kibana]').to(:restart)
  end
end
