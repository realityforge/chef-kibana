# Chef Resource for configuring an Kibana node
class KibanaCookbook::ConfigureResource < Chef::Resource::LWRPBase
  resource_name :kibana_configure
  provides :kibana_configure

  actions(:manage, :remove)
  default_action :manage

  # this is what helps the various resources find each other
  # attribute(:instance_name, kind_of: String, default: nil)

  # if you override one of these, you should probably override them all
  attribute(:path_conf, kind_of: Hash, default: {
    package: '/etc/kibana',
    tarball: '/opt/kibana/kibana/config'
  }.freeze)

  attribute(:template_kibana_yml, kind_of: String, default: 'kibana.yml.erb')
  attribute(:cookbook_kibana_yml, kind_of: String, default: 'kibana')

  attribute(:logging, kind_of: Hash, default: {}.freeze)

  # These are the default settings. Most of the time, you want to override
  # the `configuration` attribute below. If you do override the defaults, you
  # must supply ALL needed defaults, and don't use nil as a value in the hash.
  attribute(:default_configuration, kind_of: Hash, default: {
    'server.port' => '5601',
    'server.host' => '0.0.0.0',
    'elasticsearch.url' => '"http://localhost:9200"',
    'elasticsearch.preserveHost' => true,
    'elasticsearch.shardTimeout' => 0,
    'elasticsearch.requestTimeout' => 30_000,
    'kibana.index' => '".kibana"',
    'kibana.defaultAppId' => '"discover"'
  }.freeze)

  # These settings are merged with the `default_configuration` attribute,
  # allowing you to override and set specific settings. Unless you intend to
  # wipe out all default settings, your configuration items should go here.
  #
  attribute(:configuration, kind_of: Hash, default: {}.freeze)
  attribute(:plugins, kind_of: Hash, default: {}.freeze)
end
