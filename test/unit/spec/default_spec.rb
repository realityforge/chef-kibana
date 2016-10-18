require 'chefspec'
require_relative 'spec_helper'

describe 'kibana::default' do
  before { stub_resources }

  let(:chef_run) { ChefSpec::SoloRunner.new(UBUNTU_OPTS).converge(described_recipe) }

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
