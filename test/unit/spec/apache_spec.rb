# frozen_string_literal: true
require 'chefspec'
require_relative 'spec_helper'

describe 'kibana::apache' do
  before { stub_resources }

  let(:chef_run) { ChefSpec::SoloRunner.new(UBUNTU_OPTS).converge(described_recipe) }

  # TODO: creates a template /etc/apache2/htpasswd
  # TODO: creates a template /etc/apache2/sites-available/kibana.conf
end
