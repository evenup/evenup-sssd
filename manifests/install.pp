# == Class: sssd::install
#
# This class installs sssd.  It is not intended to be called directly.
#
#
# === Authors
#
# * Justin Lambert <mailto:jlambert@letsevenup.com>
#
class sssd::install (
) {

  if $caller_module_name != $module_name {
    fail("Use of private class ${name} by ${caller_module_name}")
  }

  package { 'sssd':
    ensure => 'latest',
    notify => Class['sssd::service'],
  }

  package { 'sssd-client':
    ensure => 'latest',
    notify => Class['sssd::service'],
  }

}
