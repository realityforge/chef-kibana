# Encoding: utf-8
require 'spec_helper'

describe 'kibana' do
  describe file('/opt/kibana') do
    it { should be_directory }
  end
  describe service('kibana') do
    it { should be_enabled }
    it { should be_running }
  end
  describe port(5601) do
    it { should be_listening }
  end
end

describe 'apache' do
  describe port(8080) do
    it { should be_listening }
  end
  describe service('apache2') do
    it { should be_enabled }
    it { should be_running }
  end
end
