require 'spec_helper'

describe 'sssd', :type => :class do

  it { should create_class('sssd::install') }

  it { should contain_package('sssd') }
  it { should contain_package('sssd-client') }

end

