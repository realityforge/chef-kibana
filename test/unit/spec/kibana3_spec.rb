require 'chefspec'
require_relative 'spec_helper'

describe 'kibana::kibana3' do
  before { stub_resources }

  let(:chef_run) { ChefSpec::SoloRunner.new.converge(described_recipe) }

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

# if source install is requested test this path
describe 'kibana::kibana3' do
  before { stub_resources }

  let(:chef_run) do
    ChefSpec::SoloRunner.new do |node|
      node.override['kibana']['install_method'] = 'source'
    end.converge(described_recipe)
  end

  it 'installs package git' do
    expect(chef_run).to install_package('git')
  end
  it 'checks out /opt/kibana' do
    expect(chef_run).to checkout_git('/opt/kibana/current').with(repository: 'https://github.com/elasticsearch/kibana.git')
  end

  it 'creates a template for kibana' do
    expect(chef_run).to create_template('/opt/kibana/current/src/config.js').with(
      owner: 'kibana',
      group: 'kibana',
      mode:  '0644'
    )
  end
end
