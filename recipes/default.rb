#
# Cookbook Name:: open_localdev_proxy
# Recipe:: default
#
# Copyright (c) 2015 Isaac Diamond, All Rights Reserved.

# Configure proxies if enabled

if node['open_localdev_proxy']['proxy']['enabled']
  ENV['HTTP_PROXY'] = node['open_localdev_proxy']['proxy']['http_proxy']
  ENV['HTTPS_PROXY'] = node['open_localdev_proxy']['proxy']['https_proxy']

  ::Chef::Config[:http_proxy] = http_proxy
  ::Chef::Config[:https_proxy] = https_proxy
  ::Chef::Log.info "Setting proxy"
else
  ::Chef::Log.info "Not setting proxy"
end

# Create cache directory
directory node['squid']['cache_dir'] do
  action :create
end

# Run embedded squid recipe
include_recipe "squid::default"

# Run apache recipe for the cache-manager
include_recipe "apache2::default"

# Hack to restart squic on RHEL
file "var/lock/subsys/squid" do
  action :delete
  notifies :restart, "service[squid]", :immediately
end

