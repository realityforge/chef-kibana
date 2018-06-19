# frozen_string_literal: true

require 'spec_helper'

describe 'kibana' do
  describe file('/etc/kibana') do
    it { should be_directory }
  end
  describe service('kibana') do
    it { should be_enabled }
    # TODO: This test fails in Travis but was working with a local kitchen verify
    #    it { should be_running }
  end
end

describe 'nginx' do
  describe port(80) do
    it { should be_listening }
  end
  describe service('nginx') do
    it { should be_enabled }
  end
end
