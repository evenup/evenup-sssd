require 'spec_helper'

describe 'sssd::config', :type => :class do
  let(:facts) { { :concat_basedir => '/var/lib/puppet/concat' } }
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
  it { should_not contain_beaver__stanza('/var/log/sssd/sssd_LDAP.log') }
  it { should_not contain_beaver__stanza('/var/log/sssd/sssd.log') }
  it { should_not contain_beaver__stanza('/var/log/sssd/sssd_pam.log') }
  it { should_not contain_beaver__stanza('/var/log/sssd/sssd_nss.log') }

  context 'with beaver' do
    let(:params) { { :logsagent => 'beaver' } }

    it { should contain_beaver__stanza('/var/log/sssd/sssd_LDAP.log') }
    it { should contain_beaver__stanza('/var/log/sssd/sssd.log') }
    it { should contain_beaver__stanza('/var/log/sssd/sssd_pam.log') }
    it { should contain_beaver__stanza('/var/log/sssd/sssd_nss.log') }
  end
end

