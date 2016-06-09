# Encoding: utf-8

module KibanaUtils
  def self.upstart_supports?(node)
    platform_major_version = determine_platform_major_version(node)
    case node['platform']
    when 'ubuntu'
      if platform_major_version < 12.04
        false
      elsif platform_major_version >= 16.04
        false
      else
        true
      end
    when 'redhat', 'centos', 'scientific', 'amazon'
      false
    else
      Chef::Log.fatal("#{node['platform']} does not use upstart")
    end
  end

  def self.determine_platform_major_version(node)
    if node['platform'] == 'ubuntu' || node['platform'] == 'amazon'
      node['platform_version'].to_f
    else
      node['platform_version'].split('.').first.to_i
    end
  end
end
