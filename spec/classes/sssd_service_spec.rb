require 'spec_helper'

describe 'sssd', :type => :class do

  context 'centos 6' do
    let(:facts) { { :operatingsystemrelease => '6.6' } }
    it { should create_class('sssd::service') }
    it { should contain_service('sssd').with(:ensure => 'running', :enable => true) }
    it { should_not contain_service('oddjobd') }
  end

  context 'centos 7' do
    let(:facts) { { :operatingsystemrelease => '7.0.1406' } }
    it { should create_class('sssd::service') }
    it { should contain_service('sssd').with(:ensure => 'running', :enable => true) }
    it { should contain_service('oddjobd').with(:ensure => 'running', :enable => true) }
  end

end

