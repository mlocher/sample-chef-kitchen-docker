require 'serverspec'
set :backend, :exec
set :path, '/sbin:/usr/sbin:$PATH'

describe 'chef::default' do

  describe file('/root/hello.txt') do
    it { should exist }
    its(:content) { should match /Welcome to Chef/ }
  end
end
