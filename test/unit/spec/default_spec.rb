require 'chefspec'
require_relative 'spec_helper'

describe 'kibana::default' do
  before { stub_resources }

  let(:chef_run) { ChefSpec::SoloRunner.new.converge(described_recipe) }

  it 'includes kibana recipe' do
    expect(chef_run).to include_recipe('kibana::default')
  end
end
