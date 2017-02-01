# Chef Provider for configuring an kibana service in the init system
class KibanaCookbook::ServiceProvider < Chef::Provider::LWRPBase
  provides :kibana_service
  include KibanaCookbook::Helpers

  def whyrun_supported?
    false
  end

  action :remove do
    raise "#{new_resource} remove not currently implemented"
  end

  action :configure do
    kb_install = find_kb_resource(run_context, :kibana_install, new_resource)
    kb_user = find_kb_resource(run_context, :kibana_user, new_resource)
    # Create service
    #
    if kb_install.type == 'tarball'
      init_r = template "/etc/init/#{new_resource.service_name}.conf" do
        source new_resource.init_source
        cookbook new_resource.init_cookbook
        owner 'root'
        mode 0o0755
        variables(
          version: kb_install.version,
          base_dir: kb_install.dir[kb_install.type],
          bin_path: new_resource.bin_path,
          options: new_resource.options,
          user: kb_user.username,
          group: kb_user.groupname,
          recent_upstart: (node['platform_family'] != 'rhel')
        )
        action :nothing
      end
      init_r.run_action(:create)
      new_resource.updated_by_last_action(true) if init_r.updated_by_last_action?
    end

    # flatten in an array here, in case the service_actions are a symbol vs. array
    [new_resource.service_actions].flatten.each do |act|
      passthrough_action(act)
    end
  end

  # Passthrough actions to service[service_name]
  #
  action :enable do
    passthrough_action(:enable)
  end

  action :disable do
    passthrough_action(:disable)
  end

  action :start do
    passthrough_action(:start)
  end

  action :stop do
    passthrough_action(:stop)
  end

  action :restart do
    passthrough_action(:restart)
  end

  action :status do
    passthrough_action(:status)
  end

  def passthrough_action(action)
    svc_r = lookup_service_resource
    svc_r.run_action(action)
    new_resource.updated_by_last_action(true) if svc_r.updated_by_last_action?
  end

  def lookup_service_resource
    rc = run_context.resource_collection
    rc.find("service[#{new_resource.service_name}]")
  rescue
    service new_resource.service_name do
      # provider Chef::Provider::Service::Upstart
      # provider Chef::Provider::Service::Init
      supports :status => true, :restart => true
      action :nothing
    end
  end
end
