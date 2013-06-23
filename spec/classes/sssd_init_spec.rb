require 'spec_helper'

describe 'sssd', :type => :class do

  it { should create_class('sssd') }

  it { should contain_class('sssd::install') }
  it { should contain_class('sssd::config') }
  it { should contain_class('sssd::service') }

end

