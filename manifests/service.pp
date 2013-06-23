# == Class: sssd::service
#
# This class manages the sssd service.  It is not intended to be called directly.
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
class sssd::service (){

  service { 'sssd':
    ensure  => 'running',
    enable  => true,
  }
}
