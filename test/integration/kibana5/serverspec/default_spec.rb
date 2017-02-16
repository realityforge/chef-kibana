# Encoding: utf-8
require 'spec_helper'

# package install only supported on Debian currently
describe 'kibana' do
  describe package('kibana') do
    it { should be_installed }
  end
  describe file('/etc/kibana') do
    it { should be_directory }
  end
  describe service('kibana') do
    it { should be_enabled }
    # TODO: This test fails in Travis but was working with a local kitchen verify
    it { should be_running }
  end
  describe file('/etc/kibana/kibana.yml') do
    its(:content) { should match(/elasticsearch.preserveHost: true/) }
  end
end
