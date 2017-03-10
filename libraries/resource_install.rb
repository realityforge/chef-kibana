# Chef Resource for installing or removing Kibana from package or source
class KibanaCookbook::InstallResource < Chef::Resource::LWRPBase
  resource_name :kibana_install
  provides :kibana_install

  actions(:install, :remove)
  default_action :install

  # if this version parameter is not set by the caller, we look at
  # `attributes/default.rb` for a default value to use, or we raise
  attribute(:version, kind_of: String, default: nil)

  # we allow a string or symbol for this value
  attribute(:type, kind_of: [Symbol],
                   :equal_to => [:tarball, :package], default: :package)

  # these use `attributes/default.rb` for default values per platform and install type
  attribute(:download_url, kind_of: String, default: nil)
  attribute(:download_checksum, kind_of: String, default: nil) # sha256

  # these correspond to :type of install
  attribute(:dir, kind_of: Hash, default: {
    package: '/opt/kibana',
    tarball: '/opt/kibana'
  }.freeze)

  attribute(:repository_url, kind_of: String, default: nil)
  attribute(:kibana_key,
            kind_of: String,
            default: 'https://artifacts.elastic.co/GPG-KEY-elasticsearch')
end
