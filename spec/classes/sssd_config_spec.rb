require 'spec_helper'

describe 'sssd::config', :type => :class do
  let(:params) { {
    :filter_groups      => 'root',
    :filter_users       => 'root,wheel',
    :ldap_base          => 'dc=example,dc=org',
    :ldap_uri           => 'ldap://ldap.example.org',
    :ldap_access_filter => '(&(objectclass=shadowaccount)(objectclass=posixaccount))',
    :ldap_tls_reqcert   => 'demand',
    :ldap_tls_cacert    => '/etc/pki/tls/certs/ca-bundle.crt',
  } }

  it { should create_class('sssd::config') }

  it { should contain_file('/etc/sssd/sssd.conf').with_mode('0600') }
  it { should contain_file('/etc/pam.d/system-auth') }
  it { should contain_file('/etc/pam.d/password-auth') }
  it { should contain_file('/etc/nsswitch.conf') }

end

