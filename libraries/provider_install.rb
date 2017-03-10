# Chef Provider for installing or removing Kibana from package or tarball
# downloaded from elasticsearch.org and installed by package manager or ark resource
class KibanaCookbook::InstallProvider < Chef::Provider::LWRPBase
  include KibanaCookbook::Helpers
  include Chef::DSL::IncludeRecipe
  provides :kibana_install

  def whyrun_supported?
    false
  end

  action :install do
    install_type = determine_install_type(new_resource, node)
    unless new_resource.version
      new_resource.version determine_version(new_resource, node)
    end

    if install_type == 'tarball' || install_type == 'tar'
      install_tarball_wrapper_action
    elsif install_type == 'package'
      install_package_wrapper_action
    else
      raise "#{install_type} is not a valid install type"
    end
  end

  action :remove do
    install_type = determine_install_type(new_resource, node)

    if install_type == 'tarball' || install_type == 'tar'
      remove_tarball_wrapper_action
    elsif install_type == 'package'
      remove_package_wrapper_action
    else
      raise "#{install_type} is not a valid install type"
    end
  end

  protected

  def install_tarball_wrapper_action
    include_recipe 'ark'

    kb_user = find_kb_resource(run_context, :kibana_user, new_resource)

    ark_r = ark 'kibana' do
      url determine_download_url(new_resource, node)
      version determine_version(new_resource, node)
      checksum determine_download_checksum(new_resource, node)
      prefix_root   new_resource.dir[new_resource.type]
      prefix_home   new_resource.dir[new_resource.type]
      owner kb_user.username
      group kb_user.groupname

      action :nothing
    end
    ark_r.run_action(:install)
    new_resource.updated_by_last_action(true) if ark_r.updated_by_last_action?
  end

  def install_package_wrapper_action
    repository_url = determine_repository_url(new_resource, node)
    kibana_key = new_resource.kibana_key
    rep_r = if node['platform_family'] == 'debian'
              apt_repository 'kibana' do
                uri repository_url
                distribution ''
                components %w(stable main)
                key kibana_key
                action :nothing
              end
            else
              raise "#{node['platform_family']} is not a support"
            end
    rep_r.run_action(:add)
    new_resource.updated_by_last_action(true) if rep_r.updated_by_last_action?

    pkg_r = package 'kibana' do
      action :nothing
    end
    pkg_r.run_action(:install)
    new_resource.updated_by_last_action(true) if pkg_r.updated_by_last_action?
  end
end
