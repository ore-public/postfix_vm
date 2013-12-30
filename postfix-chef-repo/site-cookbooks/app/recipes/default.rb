#
# Cookbook Name:: app
# Recipe:: default
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

group "app" do
  group_name "app"
  action :create
end


user "app" do
  group "app"
  action :create
end

directory "/home/app/.ssh" do
  owner "app"
  group "app"
  mode 0700
  action :create
end

template "/home/app/.ssh/authorized_keys" do
  user "app"
  group "app"
  mode 0600
end

