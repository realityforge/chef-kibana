# Chef Resource for declaring a service for Kibana
class KibanaCookbook::ServiceResource < Chef::Resource::LWRPBase
  resource_name :kibana_service
  provides :kibana_service

  actions(
    :configure, :remove, # our custom actions
    :enable, :disable, :start, :stop, :restart, :status # passthrough to service resource
  )
  default_action :configure

  # this is what helps the various resources find each other
  attribute(:service_name, kind_of: String, name_attribute: true)
  attribute(:options, kind_of: String, default: '')

  # service actions
  attribute(:service_actions, kind_of: [Symbol, Array], default: [:enable].freeze)

  # allow overridable init script
  attribute(:bin_path, kind_of: String, default: 'bin')
  attribute(:init_source, kind_of: String, default: 'upstart.conf.erb')
  attribute(:init_cookbook, kind_of: String, default: 'kibana')
end
