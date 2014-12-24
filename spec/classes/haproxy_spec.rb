require 'spec_helper'
describe 'haproxy' do

  context 'with defaults for all parameters' do
    let(:facts) do
      { :osfamliy => RedHat }
    end
    let(:params) do
      {
        'service_ensure' => 'running',
        'package_ensure' => 'present',
        'service_manage' => 'true',
      }
    end
      it 'should install the haproxy package' do
        subject.should contain_package('haproxy').with(
          'ensure' => 'present'
        )
      end
      it 'should install the haproxy service' do
        subject.should contain_service('haproxy').with(
          'ensure'     => 'running',
          'enable'     => 'true',
          'hasrestart' => 'true',
          'hasstatus'  => 'true'
        )
      end
      it 'should set up /etc/haproxy/haproxy.cfg as a concat resource' do
        subject.should contain_file('/etc/haproxy/haproxy.cfg').with(
          'owner' => '0',
          'group' => '0',
          'mode'  => '0644'
        )
      end
      it 'should manage the chroot directory' do
        subject.should contain_file('/var/lib/haproxy').with(
          'ensure' => 'directory',
          'owner'  => 'haproxy',
          'group'  => 'haproxy'
        )
      end
    context 'on unsupported operatingsystems' do
      let(:facts) do
        { :osfamily => 'windows' }
      end
      it do
        expect {
          should contain_service('haproxy')
        }.to raise_error(Puppet::Error, /operating system is not supported with the haproxy module/)
      end
  end
end
