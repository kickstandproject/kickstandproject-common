require 'spec_helper'

describe 'common::client', :type => :class do
  context 'on Ubuntu 12.04 (Precise)' do
    let(:facts) { { 
      :lsbdistcodename  => 'precise',
      :lsbdistrelease   => '12.04',
      :operatingsystem  => 'Ubuntu',
    } }

    directories = [
      '/usr/local/bin/puppet',
      '/var/local/puppet',
    ]

    directories.each do |dirs|
      it do
        should contain_file(dirs).with({
          'ensure'  => 'directory',
          'group'   => 'root',
          'mode'    => '0640',
          'owner'   => 'root',
        })
      end
    end
  end
end

# vim:sw=2:ts=2:expandtab:textwidth=79
