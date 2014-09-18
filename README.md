# Description

[![Build Status](https://secure.travis-ci.org/realityforge/chef-kibana.png?branch=master)](http://travis-ci.org/realityforge/chef-kibana)

A cookbook that installs [Kibana](https://github.com/rashidkpc/Kibana).

Kibana requires ElasticSearch index to be configured to work as per logstash requirements.

# Requirements

## Platform:

*No platforms defined*

## Cookbooks:

* build-essential
* authbind (Suggested but not required)
* apache2 (Suggested but not required)
* apt (Suggested but not required)

# Attributes

* `node['kibana']['base_dir']` - The base directory of kibana. Defaults to `/opt/kibana`.
* `node['kibana']['user']` - The user under which Kibana is installed. Defaults to `kibana`.
* `node['kibana']['group']` - The group under which Kibana is installed. Defaults to `kibana`.
* `node['kibana']['git']['url']` - The URL to Kibana repository. Defaults to `https://github.com/rashidkpc/Kibana.git`.
* `node['kibana']['git']['reference']` - The git reference in the Kibana repository. Defaults to `v0.2.0`.
* `node['kibana']['rubyversion']` - The version of Ruby and Gems to use for Kibana. Defaults to `1.9.1`.
* `node['kibana']['interface']` - The interface on which to bind. Defaults to `node['ipaddress']`.
* `node['kibana']['port']` - The port on which to bind. Defaults to `5601`.
* `node['kibana']['elasticsearch']['hosts']` - An Array of the elasticsearch service hosts. Defaults to `[ ... ]`.
* `node['kibana']['elasticsearch']['port']` - The port of the elasticsearch http service. Defaults to `9200`.
* `node['kibana']['default_fields']` - The which fields are shown by default. Defaults to `["@message"]`.
* `node['kibana']['default_operator']` - The operator used if no explicit operator is specified. Defaults to `OR`.
* `node['kibana']['apache']['host']` - The host to create apache vhost for. Defaults to `node['fqdn']`.
* `node['kibana']['apache']['interface']` - The interface on which to bind apache. Defaults to `node['ipaddress']`.
* `node['kibana']['apache']['port']` - The port on which to bind apache. Defaults to `80`.
* `node['kibana']['nginx']['listen_http']` - The port on which to bind nginx. Defaults to `80`
* `node['kibana']['nginx']['listen_https']` - The HTTPS port on which to bind nginx. Defaults to `443`
* `node['kibana']['nginx']['ssl']` - Boolean switch to enable SSL configuration. Defaults to `false`
* `node['kibana']['nginx']['ssl_certificate']` - The path to the SSL certificate file. Defaults to `nil`
* `node['kibana']['nginx']['ssl_certificate_key']` - The path to the SSL certificate key. Defaults to `nil`
* `node['kibana']['nginx']['ssl_protocols']` - The SSL protocols - Defaults to `SSLv3 TLSv1 TLSv1.1 TLSv1.2`
* `node['kibana']['nginx']['ssl_ciphers']` - The SSL ciphers. Defaults to `HIGH:!aNULL:!MD5:!EXP:!kEDH`
* `node['kibana']['nginx']['ssl_session_cache']` - The SSL session cache. Defaults to `shared:SSL:10m`
* `node['kibana']['nginx']['ssl_session_timeout']` - The SSL session timeout. Defaults to `10m`
* `node['kibana']['nginx']['server_name']` - The virtualhost server name. Defaults to `kibana`

# Recipes

* [kibana::apache](#kibanaapache) - Setup vhost for apache that rewrites to Kibana.
* [kibana::default](#kibanadefault) - Install Kibana.

## kibana::apache

Setup vhost for apache that rewrites to Kibana.

## kibana::default

Install Kibana.

# License and Maintainer

Maintainer:: Peter Donald (<peter@realityforge.org>)

License:: Apache 2.0
