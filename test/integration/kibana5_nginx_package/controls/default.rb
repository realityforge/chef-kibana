control 'kibana' do
  impact 1.0
  title 'Test configuration and install kibana'
  desc 'Test configuration and install kibana'

  describe package('kibana') do
    it { should be_installed }
  end
end

control 'nginx' do
  impact 1.0
  title 'Test configuration and install kibana'
  desc 'Test configuration and install kibana'

  describe port(8080) do
    it { should be_listening }
  end
  describe service('nginx') do
    it { should be_enabled }
  end
end
