require 'chefspec'
require_relative 'spec_helper'

describe 'kibana::apache' do
  before { stub_resources }

  let(:chef_run) { ChefSpec::SoloRunner.new.converge(described_recipe) }

# creates a template /etc/apache2/htpasswd

# creates a template /etc/apache2/sites-available/kibana.conf

end
