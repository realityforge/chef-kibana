control 'kibana' do
  impact 1.0
  title 'Test configuration and install kibana'
  desc 'Test configuration and install kibana'

  describe file('/usr/local/kibana-5.6.4') do
    it { should be_directory }
  end
  describe file('/usr/share/kibana/current') do
    it { should be_symlink }
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
