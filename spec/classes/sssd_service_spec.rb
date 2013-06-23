require 'spec_helper'

describe 'sssd::service', :type => :class do

  it { should create_class('sssd::service') }
  it { should contain_service('sssd').with_ensure('running').with_enable('true') }

end

