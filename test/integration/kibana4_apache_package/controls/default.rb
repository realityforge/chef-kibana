control 'kibana' do
  impact 1.0
  title 'Test configuration and install kibana'
  desc 'Test configuration and install kibana'

  describe file('/opt/kibana') do
    it { should be_directory }
  end
  describe package('kibana') do
    it { should be_installed }
  end
  describe service('kibana') do
    it { should be_enabled }
    # TODO: This test fails in Travis but was working with a local kitchen verify
    it { should be_running }
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
    describe service('apache2'), if: os[:family] == 'ubuntu' do
      it { should be_enabled }
      it { should be_running }
    end
  else os.redhat?
    describe service('httpd'), if: os[:family] == 'redhat' do
      it { should be_enabled }
      it { should be_running }
    end
  end
end
