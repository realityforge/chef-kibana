# ChefSpec is a tool to unit test cookbooks in conjunction with rspec
# Learn more on the README or at https://github.com/sethvargo/chefspec.
if defined?(ChefSpec)
  ChefSpec.define_matcher(:kibana_configure)
  ChefSpec.define_matcher(:kibana_install)
  ChefSpec.define_matcher(:kibana_plugin)
  ChefSpec.define_matcher(:kibana_service)
  ChefSpec.define_matcher(:kibana_user)

  def create_kibana_user(resource_name)
    ChefSpec::Matchers::ResourceMatcher.new(:kibana_user, :create, resource_name)
  end

  def install_kibana(resource_name)
    ChefSpec::Matchers::ResourceMatcher.new(:kibana_install, :install, resource_name)
  end

  def manage_kibana_configure(resource_name)
    ChefSpec::Matchers::ResourceMatcher.new(:kibana_configure, :manage, resource_name)
  end

  def start_kibana_service(resource_name)
    ChefSpec::Matchers::ResourceMatcher.new(:kibana_service, :start, resource_name)
  end
end
