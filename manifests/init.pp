# == Class: sssd
#
# This class installs sssd and configures it for LDAP authentication.  It also
# sets up nsswitch.conf and pam to use sssd for authentication and groups.
#
#
# === Parameters
#
# [*services*]
#   String. Comma separated list of services that are started when sssd itself starts.
#   Default: nss,pam
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
# [*ldap_schema*]
#   String. Specifies the Schema Type in use on the target LDAP server.
#   Default: rfc2307
#
# [*manage_nsswitch*]
#   Boolean. Weather to manage /etc/nsswitch.conf.
#   Default: true
#
# [*logsagent*]
#   String.  Agent for remote log transport
#   Default: ''
#   Valid options: beaver
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
class sssd (
  $services           = 'nss,pam',
  $filter_groups      = 'root,wheel',
  $filter_users       = 'root',
  $ldap_base          = 'dc=example,dc=org',
  $ldap_uri           = 'ldap://ldap.example.org',
  $ldap_access_filter = '(&(objectclass=shadowaccount)(objectclass=posixaccount))',
  $ldap_group_member  = 'uniquemember',
  $ldap_schema        = 'rfc2307',
  $ldap_tls_reqcert   = 'demand',
  $ldap_tls_cacert    = '/etc/pki/tls/certs/ca-bundle.crt',
  $ldap_enumerate     = true,
  $manage_nsswitch    = true,
  $logsagent          = undef,
){

  anchor { '::sssd::begin': } ->
  class { '::sssd::install': } ->
  class { '::sssd::config': } ~>
  class { '::sssd::service': } ->
  anchor { '::sssd::end': }

  Class['sssd::install'] ~> Class['sssd::service']

}
