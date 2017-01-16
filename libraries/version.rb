# Encoding: utf-8
# frozen_string_literal: true

class Kibana
  # All to find correct url to download kibana
  class Url
    def initialize(node, version)
      @node    = node
      @version = version
    end

    def get
      prefix = 'https://download.elastic.co/kibana/kibana/kibana-'
      suffix = case @version
               when /^3\./
                 "#{@version}.#{ext}"
               else
                 "#{@version}-#{@node['os']}#{arch}.#{ext}"
               end
      prefix + suffix
    end

    def ext
      case @node['os']
      when 'windows'
        'zip'
      else
        'tar.gz'
      end
    end

    def arch
      return '' if @node['os'] == 'windows'
      case @node['kernel']['machine']
      when 'x86_64'
        '-x64'
      else
        '-x86'
      end
    end
  end
end
