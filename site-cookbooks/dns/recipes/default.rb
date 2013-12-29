#
# Cookbook Name:: dns
# Recipe:: default
#
# Copyright (C) 2013 YOUR_NAME
# 
# All rights reserved - Do Not Redistribute
#

service "iptables" do
  action [:disable, :stop]
end

%w(screen bind bind-utils).each do |package_name|
  package package_name do
    action :install
  end
end

template "/home/vagrant/.screenrc" do
  user "vagrant"
  mode 0644
end

bash "generate rndc.key" do
  code <<-EOS
    rndc-confgen -a -r /dev/urandom
  EOS
  creates "/etc/rndc.key"
end

file "/etc/rndc.key" do
  owner "named"
  group "named"
  mode 0644
end

template "/etc/named.conf" do
  mode 0644
  notifies :restart, "service[named]"
end

bash "root name server" do
  code <<-EOS
    dig . ns @198.41.0.4 > /var/named/named.ca
  EOS
end

template "/var/named/hoge.com.db" do
  mode 0644
  user "named"
  group "named"
  notifies :reload, "service[named]"
end

template "/var/named/fuga.com.db" do
  mode 0644
  user "named"
  group "named"
  notifies :reload, "service[named]"
end

template "/var/named/office-ore.net.db" do
  mode 0644
  user "named"
  group "named"
  notifies :reload, "service[named]"
end

service "named" do
  supports status: true, restart: true, reload: true
  action [:enable, :start]
end

template "/etc/resolv.conf" do
  mode 0644
  user "root"
  group "root"
end