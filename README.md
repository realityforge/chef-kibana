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
