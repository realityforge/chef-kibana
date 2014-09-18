# Encoding: utf-8

# ports to listen on for http/https
default['kibana']['nginx']['listen_http']  = 80
default['kibana']['nginx']['listen_https'] = 443

default['kibana']['nginx']['client_max_body'] = '50M'

default['kibana']['nginx']['ssl'] = false

# BYOC - bring your own certificates
default['kibana']['nginx']['ssl_certificate']     = 'nil'
default['kibana']['nginx']['ssl_certificate_key'] = 'nil'

# nginx ssl boilerplate
default['kibana']['nginx']['ssl_protocols']       = 'TLSv1 TLSv1.1 TLSv1.2'
default['kibana']['nginx']['ssl_ciphers']         = 'ECDHE-RSA-RC4-SHA:ECDHE-RSA-AES128-SHA:AES256-CGM-SHA256:ECDHE-RSA-AES256-SHA256:RC4:HIGH:!aNULL:!MD5:-LOW:-SSLv2:-EXP'
default['kibana']['nginx']['ssl_session_cache']   = 'shared:SSL:10m'
default['kibana']['nginx']['ssl_session_timeout'] = '10m'

default['kibana']['nginx']['server_name'] = 'kibana'
