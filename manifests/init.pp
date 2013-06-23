# == Class: sssd
#
# This class installs sssd and configures it for LDAP authentication.  It also
# sets up nsswitch.conf and pam to use sssd for authentication and groups.
#
#
# === Parameters
#
# [*filter_groups*]
#   String.  Groups to filter out of the sssd results
#   Default: root,wheel
#
# [*filter_users*]
#   String.  Users to filter out of the sssd results
#   Default: root
#
# [*ldap_base*]
#   String.  LDAP base to search for LDAP results in
#   Default: dc=example,dc=org
#
# [*ldap_uri*]
#   String.  LDAP URIs to connect to for results.  Comma separated list of hosts.
#   Default: ldap://ldap.example.org
#
# [*ldap_access_filter*]
#   String.  Filter used to search for users
#   Default: (&(objectclass=shadowaccount)(objectclass=posixaccount))
#
# === Examples
#
# * Installation:
#     class { 'sssd':
#       ldap_base => 'dc=mycompany,dc=com',
#       ldap_uri  => 'ldap://ldap1.mycompany.com, ldap://ldap2.mycompany.com',
#     }
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
class sssd (
  $filter_groups      = 'root,wheel',
  $filter_users       = 'root',
  $ldap_base          = 'dc=example,dc=org',
  $ldap_uri           = 'ldap://ldap.example.org',
  $ldap_access_filter = '(&(objectclass=shadowaccount)(objectclass=posixaccount))',
  $ldap_tls_reqcert   = 'demand',
  $ldap_tls_cacert    = '/etc/pki/tls/certs/ca-bundle.crt',
){

  class { 'sssd::install': }

  class { 'sssd::config':
    filter_groups       => $filter_groups,
    filter_users        => $filter_users,
    ldap_base           => $ldap_base,
    ldap_uri            => $ldap_uri,
    ldap_access_filter  => $ldap_access_filter,
    ldap_tls_reqcert    => $ldap_tls_reqcert,
    ldap_tls_cacert     => $ldap_tls_cacert,
  }

  class { 'sssd::service': }

  # Containment
  anchor { 'sssd::begin': }
  anchor { 'sssd::end': }

  Anchor['sssd::begin'] ->
  Class['sssd::install'] ->
  Class['sssd::config'] ->
  Class['sssd::service'] ->
  Anchor['sssd::end']

}
