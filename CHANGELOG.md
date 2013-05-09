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
