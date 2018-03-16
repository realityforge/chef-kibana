# frozen_string_literal: true

require 'chefspec'
require_relative 'spec_helper'

describe 'kibana::nginx' do
  before { stub_resources }

  let(:chef_run) { ChefSpec::SoloRunner.new(UBUNTU_OPTS).converge(described_recipe) }
end
