require 'spec_helper'
describe 'windows_defaults' do

  context 'with defaults for all parameters' do
    it { should contain_class('windows_defaults') }
  end
end
