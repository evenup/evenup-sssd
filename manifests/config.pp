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
  $filter_groups      = 'root,wheel',
  $filter_users       = 'root',
  $ldap_base          = 'dc=example,dc=org',
  $ldap_uri           = 'ldap://ldap.example.org',
  $ldap_access_filter = '(&(objectclass=shadowaccount)(objectclass=posixaccount))',
  $ldap_group_member  = 'uniquemember',
  $ldap_tls_reqcert   = 'demand',
  $ldap_tls_cacert    = '/etc/pki/tls/certs/ca-bundle.crt',
  $logsagent          = '',
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

  case $logsagent {
    'beaver': {
      beaver::stanza { '/var/log/sssd/sssd_LDAP.log':
        type    => 'sssd',
        tags    => ['sssd', 'ldap', $::disposition],
      }

      beaver::stanza { '/var/log/sssd/sssd.log':
        type    => 'sssd',
        tags    => ['sssd', $::disposition],
      }

      beaver::stanza { '/var/log/sssd/sssd_nss.log':
        type    => 'sssd',
        tags    => ['sssd', 'nss', $::disposition],
      }

      beaver::stanza { '/var/log/sssd/sssd_pam.log':
        type    => 'sssd',
        tags    => ['sssd', 'pam', $::disposition],
      }
    }
    default: {}
  }


}
