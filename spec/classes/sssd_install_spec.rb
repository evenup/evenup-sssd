require 'spec_helper'

describe 'sssd', :type => :class do

  context 'centos 6' do
    let(:facts) { { :operatingsystemrelease => '6.6' } }
    it { should contain_package('sssd') }
    it { should contain_package('sssd-client') }
    it { should_not contain_package('oddjob-mkhomedir') }
  end

  context 'centos 7' do
    let(:facts) { { :operatingsystemrelease => '7.0.1406' } }
    it { should contain_package('sssd') }
    it { should contain_package('sssd-client') }
    it { should contain_package('oddjob-mkhomedir') }
  end

end

