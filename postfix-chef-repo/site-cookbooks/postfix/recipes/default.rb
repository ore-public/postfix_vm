#
# Cookbook Name:: postfix
# Recipe:: default
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

package "postfix" do
  action :install
end

template "/etc/postfix/main.cf" do
  user "root"
  group "root"
  mode 0644
end
