# Description

[![Build Status](https://secure.travis-ci.org/realityforge/chef-kibana.png?branch=master)](http://travis-ci.org/realityforge/chef-kibana)

A cookbook that installs [Kibana](https://github.com/rashidkpc/Kibana).

Kibana requires ElasticSearch index to be configured to work as per logstash requirements.

# Requirements

## Platform:

*No platforms defined*

## Cookbooks:

* build-essential
* ark
* apache2 (>= 2.0) (Suggested but not required)
* authbind (Suggested but not required)
* apt (Suggested but not required)
* nginx (Suggested but not required)

# Attributes

* `node['kibana']['version']` - Kibana version. Defaults to `2`.
* `node['kibana']['kibana3_version']` - Kibana3 exact version. Defaults to `3.0.0`.
* `node['kibana']['base_dir']` - The base directory of kibana. Defaults to `/opt/kibana`.
* `node['kibana']['user']` - The user under which Kibana is installed. Defaults to `kibana`.
* `node['kibana']['group']` - The group under which Kibana is installed. Defaults to `kibana`.
* `node['kibana']['install_method']` - Install method. Can be source or release. Defaults to `release`.
* `node['kibana']['url']` - Url of tarball. Defaults to `https://download.elasticsearch.org/kibana/kibana/kibana-#{node['kibana']['kibana3_version']}.tar.gz`.
* `node['kibana']['checksum']` - Checksum of the tarball. Defaults to `df25bc0cc02385edcac446ef8cbd83b896cdc910a0fa1b0a7bd2a958164593a8`.
* `node['kibana']['git']['url']` - The URL to Kibana repository. Defaults to `https://github.com/elasticsearch/kibana.git`.
* `node['kibana']['git']['reference']` - The git reference in the Kibana repository. Defaults to `'v' + node['kibana']['kibana3_version']`.
* `node['kibana']['rubyversion']` - The version of Ruby and Gems to use for Kibana. Defaults to `1.9.1`.
* `node['kibana']['interface']` - The interface on which to bind. Defaults to `node['ipaddress']`.
* `node['kibana']['port']` - The port on which to bind. Defaults to `5601`.
* `node['kibana']['elasticsearch']['hosts']` - An Array of the elasticsearch service hosts. Defaults to `[ ... ]`.
* `node['kibana']['elasticsearch']['port']` - The port of the elasticsearch http service. Defaults to `9200`.
* `node['kibana']['default_fields']` - The which fields are shown by default. Defaults to `["@message"]`.
* `node['kibana']['default_operator']` - The operator used if no explicit operator is specified. Defaults to `OR`.
* `node['kibana']['config']['cookbook']` - The cookbook from which config.js template is taken. Defaults to `nil`.
* `node['kibana']['config']['source']` - The template from which config.js is generated from. Defaults to `nil`.
* `node['kibana']['highlighted_field']` - Fields specifiers which default to @message (may need to be changed for newer logstash). Defaults to `@message`.
* `node['kibana']['primary_field']` -  Defaults to `@message`.
* `node['kibana']['default_index']` -  Defaults to `@message`.
* `node['kibana']['apache']['host']` - The host to create apache vhost for. Defaults to `node['fqdn']`.
* `node['kibana']['apache']['interface']` - The interface on which to bind apache. Defaults to `node['ipaddress']`.
* `node['kibana']['apache']['basic_auth']` - Enable http auth for Apache. Defaults to `off`.
* `node['kibana']['apache']['basic_auth_username']` - Apache http auth username. Defaults to `admin`.
* `node['kibana']['apache']['basic_auth_password']` - Apache http auth password. Defaults to `PLEASEchangeme`.
* `node['kibana']['apache']['port']` - The port on which to bind apache. Defaults to `80`.
* `node['kibana']['apache']['proxy']` - Boolean switch to enable apache search query proxy. Defaults to `false`.
* `node['kibana']['nginx']['port']` - The port on which to bind nginx. Defaults to `80`.
* `node['kibana']['nginx']['listen_http']` - The port on which to bind nginx. Defaults to `80`.
* `node['kibana']['nginx']['listen_https']` - The HTTPS port on which to bind nginx. Defaults to `443`.
* `node['kibana']['nginx']['client_max_body']` -  Defaults to `50M`.
* `node['kibana']['nginx']['ssl']` - Boolean switch to enable SSL configuration. Defaults to `false`.
* `node['kibana']['nginx']['proxy']` - Boolean switch to enable nginx search query proxy. Defaults to `false`.
* `node['kibana']['nginx']['auth']` - Boolean switch to enable auth basic. Defaults to `false`.
* `node['kibana']['auth_file']` - The path to auth basic file. Defaults to `/etc/nginx/htpasswd.users`.
* `node['kibana']['nginx']['ssl_certificate']` - The path to the SSL certificate file. Defaults to `nil`.
* `node['kibana']['nginx']['ssl_certificate_key']` - The path to the SSL certificate key. Defaults to `nil`.
* `node['kibana']['nginx']['ssl_protocols']` - The SSL protocols. Defaults to `TLSv1 TLSv1.1 TLSv1.2`.
* `node['kibana']['nginx']['ssl_ciphers']` - The SSL ciphers. Defaults to `ECDHE-RSA-RC4-SHA:ECDHE-RSA-AES128-SHA:AES256-CGM-SHA256:ECDHE-RSA-AES256-SHA256:RC4:HIGH:!aNULL:!MD5:-LOW:-SSLv2:-EXP`.
* `node['kibana']['nginx']['ssl_session_cache']` - The SSL session cache. Defaults to `shared:SSL:10m`.
* `node['kibana']['nginx']['ssl_session_timeout']` - The SSL session timeout. Defaults to `10m`.
* `node['kibana']['nginx']['server_name']` - The virtualhost server name. Defaults to `kibana`.

# Recipes

* [kibana::apache](#kibanaapache) - Setup vhost for apache that rewrites to Kibana.
* [kibana::default](#kibanadefault) - Install Kibana.
* kibana::kibana3
* kibana::kibana4
* kibana::nginx

## kibana::apache

Setup vhost for apache that rewrites to Kibana.

## kibana::default

Install Kibana.

# License and Maintainer

Maintainer:: Peter Donald (<peter@realityforge.org>)

License:: Apache 2.0
