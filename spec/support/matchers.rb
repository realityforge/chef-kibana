# matcher for install_ark
def install_ark(resource_name)
  ChefSpec::Matchers::ResourceMatcher.new(:ark, :install, resource_name)
end

def put_ark(resource_name)
  ChefSpec::Matchers::ResourceMatcher.new(:ark, :put, resource_name)
end
