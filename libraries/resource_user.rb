# Chef Resource for declaring a user and group for Elasticsearch
class KibanaCookbook::UserResource < Chef::Resource::LWRPBase
  resource_name :kibana_user
  provides :kibana_user

  actions(:create, :remove)
  default_action :create

  # this is what helps the various resources find each other
  # attribute(:instance_name, kind_of: String, default: nil)

  attribute(:username, kind_of: String, name_attribute: true) # default to resource name
  attribute(:uid, kind_of: Integer)
  attribute(:shell, kind_of: String, default: '/bin/bash')
  attribute(:comment, kind_of: String, default: 'Kibana User')

  attribute(:groupname, kind_of: String, name_attribute: true) # default to resource name
  attribute(:gid, kind_of: Integer)
end
