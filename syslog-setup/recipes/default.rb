#
# Cookbook Name:: syslog-setup
# Recipe:: default
#
# Copyright 2016, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#!/bin/bash

# Install package rsyslog
package 'rsyslog' do
  action :install
end

## set hostname 
#execute "set hostname" do
#  command "hostname chefworkstation.tloapps.com"
#end

# Copy the rsyslog file to remote server
cookbook_file "/etc/rsyslog.conf" do
   source "rsyslog.conf"
   mode "0644"
end

directory "/var/spool/rsyslog/" do
  mode 0755
  owner 'root'
  group 'root'
  action :create
end

cookbook_file "/etc/rsyslog.d/29-graylog-system.conf" do
   source "29-graylog-system.conf"
   mode "0644"
end

cookbook_file "/etc/rsyslog.d/25-graylog-yum.conf" do
   source "25-graylog-yum.conf"
   mode "0644"
end

cookbook_file "/etc/logrotate.d/yum" do
   source "yum"
   mode "0644"
end

service 'rsyslog' do
  action :restart
end
