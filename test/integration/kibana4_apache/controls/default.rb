control 'kibana' do
  impact 1.0
  title 'Test configuration and install kibana'
  desc 'Test configuration and install kibana'

  describe file('/opt/kibana') do
    it { should be_directory }
  end
end

control 'apache' do
  impact 1.0
  title 'Test configuration and install kibana'
  desc 'Test configuration and install kibana'

  describe port(8080) do
    it { should be_listening }
  end
  if os.debian?
    describe service('apache2') do
      it { should be_enabled }
      it { should be_running }
    end
  end
  if os.redhat?
    describe service('httpd') do
      it { should be_enabled }
      it { should be_running }
    end
  end
end
