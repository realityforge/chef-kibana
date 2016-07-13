require 'chefspec'
require_relative 'spec_helper'

describe 'kibana::nginx' do
  before { stub_resources }

  let(:chef_run) { ChefSpec::SoloRunner.new.converge(described_recipe) }
end
