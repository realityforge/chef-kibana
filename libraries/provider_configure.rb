# Chef Provider for configuring an kibana instance
class KibanaCookbook::ConfigureProvider < Chef::Provider::LWRPBase
  include KibanaCookbook::Helpers

  provides :kibana_configure

  def whyrun_supported?
    false
  end

  action :manage do
    # lookup existing ES resources
    kb_user = find_kb_resource(run_context, :kibana_user, new_resource)
    kb_install = find_kb_resource(run_context, :kibana_install, new_resource)
    # kb_svc = find_kb_resource(run_context, :kibana_service, new_resource)

    default_configuration = new_resource.default_configuration.dup
    merged_configuration = default_configuration.merge(new_resource.configuration.dup)
    merged_configuration = merged_configuration.merge(new_resource.plugins.dup)
    yml_template = template 'kibana.yml' do
      path "#{new_resource.path_conf[kb_install.type]}/kibana.yml"
      source new_resource.template_kibana_yml
      cookbook new_resource.cookbook_kibana_yml
      owner kb_user.username
      group kb_user.groupname
      mode 0o0755
      # helpers(ElasticsearchCookbook::Helpers)
      variables(config: merged_configuration)
      action :nothing
    end
    yml_template.run_action(:create)
    new_resource.updated_by_last_action(true) if yml_template.updated_by_last_action?
  end
end
