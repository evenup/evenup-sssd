# == Class: sssd::config
#
# This class configures sssd.  It is not intended to be called directly.
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
class sssd::config (
  $filter_groups,
  $filter_users,
  $ldap_base,
  $ldap_uri,
  $ldap_access_filter,
  $ldap_tls_reqcert,
  $ldap_tls_cacert,
){

  file { '/etc/sssd/sssd.conf':
    ensure  => 'file',
    owner   => 'root',
    group   => 'root',
    mode    => '0600',
    notify  => Class['sssd::service'],
    content => template('sssd/sssd.conf.erb'),
  }

  file { '/etc/pam.d/password-auth':
    ensure  => file,
    owner   => 'root',
    group   => 'root',
    mode    => '0444',
    source  => 'puppet:///modules/sssd/password-auth',
  }

  file { '/etc/pam.d/system-auth':
    ensure  => file,
    owner   => 'root',
    group   => 'root',
    mode    => '0444',
    source  => 'puppet:///modules/sssd/system-auth',
  }

  file { '/etc/nsswitch.conf':
    ensure  => file,
    owner   => 'root',
    group   => 'root',
    mode    => '0444',
    source  => 'puppet:///modules/sssd/nsswitch.conf',
  }

}
