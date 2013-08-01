Description
===========

A cookbook that installs [Kibana](https://github.com/rashidkpc/Kibana).

Platforms
=========
- `ubuntu`, tested on `ubuntu-12.04` only

Requirements
============

Kibana requires ElasticSearch index to be configured to work as per logstash requirements.

Attributes
==========

### Install Options ###

* `node['kibana']['base_dir']` - The base directory of kibana. Defaults to '/opt/kibana'.
* `node['kibana']['user']` - The user under which Kibana is installed. Defaults to 'kibana'.
* `node['kibana']['group']` - The group under which Kibana is installed. Defaults to 'kibana'.
* `node['kibana']['git']['url']` - The URL to Kibana repository. Defaults to 'git://github.com/rashidkpc/Kibana.git'.
* `node['kibana']['git']['reference']` - The git reference in the Kibana repository. Defaults to 'v0.2.0'.
* `node['kibana']['rubyversion']` - The version of Ruby and Gems to use for Kibana.Defaults to `1.9.1`

### KibanaConfig Options ###

* `node['kibana']['interface']` - The interface on which to bind. Defaults to node['ipaddress'].
* `node['kibana']['port']` - The port on which to bind. Defaults to 5601.
* `node['kibana']['elasticsearch']['hosts']` - An Array of the elasticsearch service hosts. Defaults to ['127.0.0.1'].
* `node['kibana']['elasticsearch']['port']` - The port of the elasticsearch http service. Defaults to 9200.
* `node['kibana']['default_fields']` - The which fields are shown by default. Defaults to `["@message"]`.
* `node['kibana']['default_operator']` - The operator used if no explicit operator is specified. Defaults to `"NO"`.

### Apache Config Options ###

* `node['kibana']['apache']['host']` - The host to create apache vhost for. Defaults to `node['fqdn']`
* `node['kibana']['apache']['interface']` - The interface on which to bind apache. Defaults to `node['ipaddress']`
* `node['kibana']['apache']['port']` - The port on which to bind apache. Defaults to 80.


Recipes
=======

* `default` - Install Kibana.
* `apache` - Setup vhost for apache that rewrites to Kibana.
