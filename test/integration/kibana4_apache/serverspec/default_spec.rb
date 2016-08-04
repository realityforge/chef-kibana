# Encoding: utf-8
require 'spec_helper'

describe 'kibana' do
  describe file('/opt/kibana') do
    it { should be_directory }
  end
  describe service('kibana'), if: os[:family] == 'ubuntu' do
    it { should be_enabled }
    it { should be_running }
  end
  describe service('kibana'), if: os[:family] == 'redhat' do
    it { should be_enabled }
    it { should be_running }
  end
end

describe 'apache' do
  describe port(8080) do
    it { should be_listening }
  end
  describe service('apache2'), if: os[:family] == 'ubuntu' do
    it { should be_enabled }
    it { should be_running }
  end
  describe service('httpd'), if: os[:family] == 'redhat' do
    it { should be_enabled }
    it { should be_running }
  end
end
