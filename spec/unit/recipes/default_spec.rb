#
# Cookbook Name:: open_localdev_proxy
# Spec:: default
#
# Copyright (c) 2015 Isaac Diamond, All Rights Reserved.

require 'spec_helper'

describe 'open_localdev_proxy::default' do
  context 'When all attributes are default, on an unspecified platform' do
    let(:chef_run) do
      runner = ChefSpec::ServerRunner.new
      runner.converge(described_recipe)
    end

    it 'converges successfully' do
      chef_run # This should not raise an error
    end

    it 'installs squid' do
      expect(chef_run).to install_package('squid');
    end

    it 'should run squid' do
      expect(chef_run).to start_service('squid');
    end

    it 'should configure squid correctly' do
      expect(chef_run).to render_file('/etc/squid/squid.conf')
    end
  end
end

