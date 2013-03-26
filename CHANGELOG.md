## v0.1.4:

* Adjusting command to ensure the proper version of ruby is used to execute
  Kibana in the init script.  gems are installed for ruby1.9.1, so the daemon
  startup command will force using ruby1.9.1 too now, but 1.9.1 is an attribute
  so that it can be changed in one place as necessary. (nschelly)

## v0.1.2:

* Prefer new notification syntax.

## v0.1.0:

* Initial release
