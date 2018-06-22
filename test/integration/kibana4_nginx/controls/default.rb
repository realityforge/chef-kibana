control 'kibana' do
  impact 1.0
  title 'Test configuration and install kibana'
  desc 'Test configuration and install kibana'

  describe file('/opt/kibana') do
    it { should be_directory }
  end
end

control 'nginx' do
  impact 1.0
  title 'Test configuration and install kibana'
  desc 'Test configuration and install kibana'

  describe port(80) do
    it { should be_listening }
  end
  describe service('nginx') do
    it { should be_enabled }
  end
end
