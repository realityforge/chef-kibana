## v0.1.10:
* Replace depends with suggest for the apache cookbook as it is not needed when using nginx. Submitted by Bryan Casey.

## v0.1.8:
* nginx support. Submitted by Gregoire Seux and Jonathon W. Marshall.
* Add initial support for centos. Submitted by Gregoire Seux.
* Support configuration of the default operator, default fields, highlighted\_field, primary\_field and default\_index. Submitted by Joseph Anthony Pasquale Holsten.
* Add test-ktichen support for 12.04
* Re-order default attributes file for future changes

## v0.1.6:
* Make Elasticsearch Kibana config an array by default - this will make it easier
  to supply multiple ES nodes by simply overriding ```node['kibana']['elasticsearch']['host']``` attribute

## v0.1.5:

* add additional logic to decide which apt package to install based on the version of ruby specified. `1.8, 1.9.1, 1.9.3` are supported. (doublerr)
* Update README to reflect above (doublerr)
* Add Berkshelf support (doublerr)

## v0.1.4:

* include build-essential recipe to ensure bundle install works. Reported
  by Max Stepanov.
* Stop declaring the apache template twice.
* Use https rather than the git protocol to define the kibana repository as
  many enterprises firewall out the git protocol.
* Adjusting command to ensure the proper version of ruby is used to execute
  Kibana in the init script.  gems are installed for ruby1.9.1, so the daemon
  startup command will force using ruby1.9.1 too now, but 1.9.1 is an attribute
  so that it can be changed in one place as necessary. (nschelly)
* Fixed permissions for KibanaConfig.rb so that the kibana user can read it.
  Used to be root:root, now uses the :user and :group attributes (nschelly)

## v0.1.2:

* Prefer new notification syntax.

## v0.1.0:

* Initial release
