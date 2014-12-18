# == Class: sssd::service
#
# This class manages the sssd service.  It is not intended to be called directly.
#
#
# === Authors
#
# * Justin Lambert <mailto:jlambert@letsevenup.com>
#
class sssd::service (){

  if $caller_module_name != $module_name {
    fail("Use of private class ${name} by ${caller_module_name}")
  }

  service { 'sssd':
    ensure => 'running',
    enable => true,
  }
}
