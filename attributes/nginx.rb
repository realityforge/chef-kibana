# ports to listen on for http/https
default['kibana']['nginx']['listen_http']  = 80
default['kibana']['nginx']['listen_https'] = 443

default['kibana']['nginx']['ssl'] = false

# BYOC - bring your own certificates
default['kibana']['nginx']['ssl_certificate']     = 'nil'
default['kibana']['nginx']['ssl_certificate_key'] = 'nil'

# nginx ssl boilerplate
default['kibana']['nginx']['ssl_protocols']       = 'SSLv3 TLSv1 TLSv1.1 TLSv1.2'
default['kibana']['nginx']['ssl_ciphers']         = 'HIGH:!aNULL:!MD5:!EXP:!kEDH'
default['kibana']['nginx']['ssl_session_cache']   = 'shared:SSL:10m'
default['kibana']['nginx']['ssl_session_timeout'] = '10m'

default['kibana']['nginx']['server_name'] = 'kibana'
