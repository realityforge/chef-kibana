# Encoding: utf-8
require 'spec_helper'

describe 'kibana' do
  describe file('/opt/kibana') do
    it { should be_directory }
  end
end
