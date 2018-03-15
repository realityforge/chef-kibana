# Encoding: utf-8
# frozen_string_literal: true
require 'spec_helper'

describe 'kibana' do
  describe file('/opt/kibana') do
    it { should be_directory }
  end
end
