# == Class: sssd::install
#
# This class installs sssd.  It is not intended to be called directly.
#
#
# === Authors
#
# * Justin Lambert <mailto:jlambert@letsevenup.com>
#
#
# === Copyright
#
# Copyright 2013 EvenUp.
#
class sssd::install (
) {

  package { 'sssd':
    ensure  => 'latest',
  }

  package { 'sssd-client':
    ensure  => 'latest',
  }

}
