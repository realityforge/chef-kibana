require 'chefspec'
require_relative 'spec_helper'

describe 'kibana::kibana4' do
  before { stub_resources }

  let(:chef_run) { ChefSpec::SoloRunner.new.converge(described_recipe) }
  let(:template) { chef_run.template('/opt/kibana/current/config/kibana.yml') }

  it 'includes kibana recipe' do
    expect(chef_run).to include_recipe('kibana::default')
  end

# install kibana4 using ark

  it 'creates a template for the kibana config' do
    expect(chef_run).to create_template('/opt/kibana/current/config/kibana.yml').with(
      owner: 'kibana',
      group: 'kibana',
      mode:  '0644',
    )
  end
  it 'sends a restart notification to the service kibana' do
    expect(template).to notify('service[kibana]').to(:restart)
  end

# install service using _service.rb recipe

end
