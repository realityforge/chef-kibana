# Encoding: utf-8
require 'spec_helper'

describe 'kibana' do
  describe file('/opt/kibana/kibana') do
    it { should be_directory }
  end
  describe service('kibana') do
    it { should be_enabled }
    # TODO: This test fails in Travis but was working with a local kitchen verify
    it { should be_running }
  end
  describe file('/opt/kibana/kibana/config/kibana.yml') do
    its(:content) { should match(/elasticsearch.preserveHost: true/) }
  end
end
