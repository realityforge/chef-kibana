# Encoding: utf-8
require 'spec_helper'

describe 'kibana' do
  describe file('/opt/kibana') do
    it { should be_directory }
  end
  describe service('kibana') do
    it { should be_enabled }
    it { should be_running.under('upstart') }
  end
end

describe 'nginx' do
  describe port(8080) do
    it { should be_listening }
  end
  describe service('nginx') do
    it { should be_enabled }
  end
end
