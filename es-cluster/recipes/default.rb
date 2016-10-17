#
# Cookbook Name:: es-cluster
# Recipe:: default
#
# Copyright 2016, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

user "elasticsearch" do
  action :create
end

group "elasticsearch" do
  action :create
  members "elasticsearch"
end

directory "/data" do
  mode 0755
  owner "elasticsearch"
  group "elasticsearch"
  action :create
end

remote_file "elasticsearch-2.3.5.rpm" do 
  source "https://download.elastic.co/elasticsearch/release/org/elasticsearch/distribution/rpm/elasticsearch/2.3.5/elasticsearch-2.3.5.rpm"
  not_if { ::File.exists?('elasticsearch-2.3.5.rpm') }
end 

remote_file "cloud-plugin" do
  source "https://download.elastic.co/elasticsearch/release/org/elasticsearch/plugin/cloud-aws/2.4.0/cloud-aws-2.4.0.zip"
  not_if  { ::File.exists?('cloud-aws-2.4.0.zip') }
end

remote_file "head-plugin" do
  source "https://download.elastic.co/elasticsearch/release/org/elasticsearch/plugin/cloud-aws/2.4.0/cloud-aws-2.4.0.zip"
  not_if  { ::File.exists?('cloud-aws-2.4.0.zip') }
end

package "elasticsearch" do
#  version '2.3.5-1.noarch'
  action :install
  source 'elasticsearch-2.3.5.rpm'
  not_if "rpm -qa|grep elasticsearch-2.3.5.rpm"
end

execute "Install cloud-plugin" do 
  command "/usr/share/elasticsearch/bin/plugin install cloud-aws"
  not_if { ::File.exists?('/usr/share/elasticsearch/plugins/cloud-aws/cloud-aws-2.3.5.jar') } 
end

execute "Install plugin-head" do
  command "/usr/share/elasticsearch/bin/plugin install mobz/elasticsearch-head"
  not_if { ::File.exists?('/usr/share/elasticsearch/plugins/head/elasticsearch-head.sublime-project') }
end

service "elasticsearch" do 
  action [:start, :enable]
end

directory "/etc/elasticsearch/" do
  mode "0755"
  owner "elasticsearch"
  group "elasticsearch"
end

template "/etc/elasticsearch/elasticsearch.yml" do
  source "elasticsearch.yml.erb"
  mode "0644"
end

service "elasticsearch" do
  action :restart
end


