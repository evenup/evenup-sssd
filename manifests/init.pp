# == Class: sssd
#
# This class installs sssd and configures it for LDAP or IPA authentication.  It also
# sets up nsswitch.conf and pam to use sssd for authentication and groups.
#
#
# === Parameters
#
# [*services*]
#   String. Comma separated list of services that are started when sssd itself starts.
#   Default: nss,pam
#
# [*domain*]
#  String.  Domain to service by SSSD
#  Default: LDAP
#
# [*provider*]
#   String.  Provider used for $domain
#   Default: ldap
#   Options: ldap, ipa
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
# [*ldap_pwd_policy*]
#   String. Select the policy to evaluate the password expiration on
#   the client side.
#   Default: shadow (default for sssd is 'none')
#   Valid options: none shadow mit_kerberos
#
# [*ldap_schema*]
#   String. Specifies the Schema Type in use on the target LDAP server.
#   Default: rfc2307
#
# [*ldap_tls_reqcert*]
#   String.  What checks to perform on TLS certificates
#   Default: demand
#   Options: never, allow, try, demand, hard
#
# [*ldap_tls_cacert*]
#   String.  Path containing certificates for valid CAs
#   Default: /etc/pki/tls/certs/ca-bundle.crt
#
# [*ldap_enumerate*]
#   Boolean.  Whether or not enumeration should be enabled
#   Default: true
#
# [*ipa_hostname*]
#   String.  Hostname to use for IPA
#   Default: $::fqdn
#
# [*ipa_server*]
#   String.  List of servers to connect to.  _srv_ is a special service
#     discovery keyword to discover servers via DNS
#   Default: _srv_
#
# [*ipa_dyndns*]
#   Boolean.  Enables SSSD's ability to update IPA's DNS server
#   Default: true
#
# [*ipa_server_mode*]
#   Boolean.  Set to true when SSSD is running on an IPA server
#   Default: false
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
class sssd (
  $services           = 'nss,pam',
  $domain             = 'LDAP',
  $provider           = 'ldap',
  $filter_groups      = 'root,wheel',
  $filter_users       = 'root',
  $homedir            = undef,
  $ldap_base          = 'dc=example,dc=org',
  $ldap_uri           = 'ldap://ldap.example.org',
  $ldap_access_filter = '(&(objectclass=shadowaccount)(objectclass=posixaccount))',
  $ldap_group_member  = 'uniquemember',
  $ldap_pwd_policy    = 'shadow',
  $ldap_schema        = 'rfc2307',
  $ldap_tls_reqcert   = 'demand',
  $ldap_tls_cacert    = '/etc/pki/tls/certs/ca-bundle.crt',
  $ldap_enumerate     = true,
  $ipa_hostname       = $::fqdn,
  $ipa_server         = '_srv_',
  $ipa_dyndns         = true,
  $ipa_server_mode    = false,
  $manage_nsswitch    = true,
  $logsagent          = undef,
  $debug_level        = '0x02F0',
){

  validate_re($provider, ['^ldap$', '^ipa$'], 'Supported providers for SSSD are ldap and ipa')
  validate_re($ldap_tls_reqcert, ['^never$', '^allow$', '^try$', '^demand$', '^hard$'], 'Supported options for ldap_tls_reqcert are never, allow, try, demand, and hard')

  anchor { '::sssd::begin': } ->
  class { '::sssd::install': } ->
  class { '::sssd::config': } ~>
  class { '::sssd::service': } ->
  anchor { '::sssd::end': }

  Class['sssd::install'] ~> Class['sssd::service']

}
