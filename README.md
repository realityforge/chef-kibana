# Description

[![Build Status](https://secure.travis-ci.org/realityforge/chef-kibana.png?branch=master)](http://travis-ci.org/realityforge/chef-kibana)

A cookbook that installs [Kibana](https://github.com/elastic/kibana).

Kibana requires ElasticSearch index to be configured to work as per logstash requirements.

[Kibana](https://www.elastic.co/products/kibana) - This cookbook is being written and tested to support Kibana 5.x and greater. If you must have a cookbook that works with older versions of Kibana, please test and then pin to a specific, older major.minor version of this cookbook and only leave the patch release to float. Older versions can be found via Git tags or on Chef Supermarket. 

# Requirements

* Chef 11+

## Platform:

* Ubuntu 12.04, 14.04.
* CentOS 6, 7

## Cookbooks:

* build-essential
* ark
* apache2 (>= 2.0) (Suggested but not required)
* authbind (Suggested but not required)
* apt (Suggested but not required)
* chef_nginx (Suggested but not required)

# Attributes

* `node['kibana']['version']` - Kibana version. Defaults to `5.1.1`.
* `node['kibana']['base_dir']` - The base directory of kibana. Defaults to `/opt/kibana`.
* `node['kibana']['user']` - The user under which Kibana is installed. Defaults to `kibana`.
* `node['kibana']['group']` - The group under which Kibana is installed. Defaults to `kibana`.
* `node['kibana']['install_method']` - Install method. Can be tarball or package. Defaults to `package`.
* `node['kibana']['repository_url']` - Url of package. Defaults to `https://arifacts.elastic.co/packages/5.x/[apt|yum]` (depending on OS family).
* `node['kibana']['checksum']['4.6.3']['tar']` - Checksum of the kibana 4.6.3 tarball. Defaults to `67d586e43a35652adeb6780eaa785d3d785ce60cc74fbf3b6a9a53b753c8f985`.
* `node['kibana']['checksum']['5.1.1']['tar']` - Checksum of the kibana 5.1.1 tarball. Defaults to `da0383be8a12936c7d2a0a145e7bf0eb15abf972e585e0115ed8742032c79245`.
* `node['kibana']['git']['url']` - The URL to Kibana repository. Defaults to `https://github.com/elasticsearch/kibana.git`.
* `node['kibana']['git']['reference']` - The git reference in the Kibana repository. Defaults to `'v' + node['kibana']['kibana3_version']`.
* `node['kibana']['rubyversion']` - The version of Ruby and Gems to use for Kibana. Defaults to `1.9.1`.
* `node['kibana']['interface']` - The interface on which to bind. Defaults to `127.0.0.1`.
* `node['kibana']['port']` - The port on which to bind. Defaults to `5601`.
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
* [kibana::nginx](#kibananginx) - Setup Nginx configuration to act as a reverse proxy to Kibana

## kibana::apache

Setup vhost for apache that rewrites to Kibana.

## kibana::default

Install Kibana.

## kibana::nginx

Install & configure Nginx to act as a reverse proxy to Kibana.

# License and Maintainers

Maintainers:: Peter Donald (<peter@realityforge.org>), Dimitry Ryobryshkin (@cyberflow), Scott Nelson Windels (<scott@drenalin.com>)

License:: Apache 2.0
