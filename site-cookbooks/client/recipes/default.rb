#
# Cookbook Name:: client
# Recipe:: default
#
# Copyright (C) 2013 YOUR_NAME
# 
# All rights reserved - Do Not Redistribute
#

service "iptables" do
  action [:disable, :stop]
end

%w(screen bind-utils).each do |package_name|
  package package_name do
    action :install
  end
end

template "/home/vagrant/.screenrc" do
  user "vagrant"
  mode 0644
end

template "/etc/resolv.conf" do
  mode 0644
  user "root"
  group "root"
end