module KibanaCookbook
  # Helper methods included by various providers and passed to the template engine
  module Helpers
    def determine_version(new_resource, node)
      if new_resource.version
        new_resource.version.to_s
      elsif node['kibana'] && node['kibana']['version']
        node['kibana']['version'].to_s
      else
        raise 'could not determine version of kibana to install'
      end
    end

    def determine_install_type(new_resource, node)
      if new_resource.type
        new_resource.type.to_s
      elsif node['kibana'] && node['kibana']['install_type']
        node['kibana']['install_type'].to_s
      else
        raise 'could not determine how to install kibana (package? tarball?)'
      end
    end

    def determine_repository_url(new_resource, node)
      # TODO: add support version 5.x
      # platform_family = node['platform_family']
      # url_string = nil
      if new_resource.repository_url
        # url_string = new_resource.repository_url
        new_resource.repository_url
      else
        # url_string = node['kibana']['repository_url']
        node['kibana']['repository_url']
      end
    end

    def determine_download_url(new_resource, node)
      # platform_family = node['platform_family']
      install_type = determine_install_type(new_resource, node)
      version = determine_version(new_resource, node)
      arch = determine_arch
      ext = determine_ext

      # url_string = nil
      if new_resource.download_url
        new_resource.download_url
      elsif install_type.to_s == 'tar' || install_type.to_s == 'tarball'
        prefix = if version.to_s =~ /^5/
                   'https://artifacts.elastic.co/downloads/kibana/kibana-'
                 else
                   'https://download.elastic.co/kibana/kibana/kibana-'
                 end
        suffix = "#{version}-#{node['os']}-#{arch}.#{ext}"
        prefix + suffix
      else
        raise 'could not determine url for install kibana'
      end

      # return url_string
    end

    def determine_download_checksum(new_resource, node)
      # platform_family = node['platform_family']
      install_type = determine_install_type(new_resource, node)
      version = determine_version(new_resource, node)

      if new_resource.download_checksum
        new_resource.download_checksum
      elsif install_type.to_s == 'tar' || install_type.to_s == 'tarball'
        node && version &&
          node['kibana'] &&
          node['kibana']['checksums'] &&
          node['kibana']['checksums'][version] &&
          node['kibana']['checksums'][version]['tar']
      end
    end

    def find_kb_resource(run_context, resource_type, resource)
      resource_name = resource.name

      # if we are truly given a specific name to find
      name_match = find_exact_resource(run_context, resource_type, resource_name) rescue nil
      return name_match if name_match

      # otherwise try the defaults
      name_default = find_exact_resource(run_context, resource_type, 'default') rescue nil
      name_kibana = find_exact_resource(run_context, resource_type, 'kibana') rescue nil

      # if we found exactly one default name that matched
      return name_default if name_default && !name_kibana
      return name_kibana if name_kibana && !name_default

      raise "Could not find exactly one #{resource_type} resource, and no specific resource or instance name was given"
    end

    # find exactly the resource name and type, but raise if there's multiple matches
    # see https://github.com/chef/chef/blob/master/lib/chef/resource_collection/resource_set.rb#L80
    def find_exact_resource(run_context, resource_type, resource_name)
      rc = run_context.resource_collection
      result = rc.find(resource_type => resource_name)

      if result && result.is_a?(Array)
        str = ''
        str << "more than one #{resource_type} was found, "
        str << 'you must specify a precise resource name'
        raise str
      end

      result
    end

    # def find_instance_name_resource(run_context, resource_type, instance_name)
    #   results = []
    #   rc = run_context.resource_collection

    #   rc.each do |r|
    #     next unless r.resource_name == resource_type
    #     results << r
    #   end

    #   if !results.empty? && results.length > 1
    #     str = ''
    #     str << "more than one #{resource_type} was found, "
    #     str << 'you must specify a precise instance name'
    #     raise str
    #   elsif !results.empty?
    #     return results.first
    #   end

    #   return nil # falsey
    # end

    def determine_ext
      case node['os']
      when 'windows'
        'zip'
      else
        'tar.gz'
      end
    end

    def determine_arch
      return '' if node['os'] == 'windows'
      case node['kernel']['machine']
      when 'x86_64'
        'x86_64'
      else
        '-x86'
      end
    end
  end
end
