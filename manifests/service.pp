# == Class: sssd::service
#
# This class manages the sssd service.  It is not intended to be called directly.
#
#
class sssd::service (){

  if $caller_module_name != $module_name {
    fail("Use of private class ${name} by ${caller_module_name}")
  }

  service { 'sssd':
    ensure => 'running',
    enable => true,
  }

  if versioncmp($::operatingsystemrelease, '7.0') >= 0 {
    service { 'oddjobd':
      ensure => 'running',
      enable => true,
    }
  }
}
