#
# Cookbook Name:: dns
# Recipe:: default
#
# Copyright (C) 2013 YOUR_NAME
# 
# All rights reserved - Do Not Redistribute
#

%w(bind bind-utils).each do |package_name|
  package package_name do
    action :install
  end
end

bash "generate rndc.key" do
  code <<-EOS
    rndc-confgen -a -r /dev/urandom
  EOS
  creates "/etc/rndc.key"
end

service "named" do
  supports status: true, restart: true, reload: true
  action [:enable, :start]
end

template "/etc/named.conf" do
  mode 0640
  notifies :restart, "service[named]"
end

bash "root name server" do
  code <<-EOS
    dig . ns @198.41.0.4 > /var/named/named.ca
  EOS
end

template "/var/named/hoge.com.db" do
  mode 0640
  notifies :reload, "service[named]"
end

template "/var/named/fuga.com.db" do
  mode 0640
  notifies :reload, "service[named]"
end
