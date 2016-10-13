#
# Cookbook Name:: tomcat-install
# Recipe:: default
#
# Copyright 2016, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
##package "tomcat7" do
#action :install
#end

## start apache service and start on bootup
#service "tomcat7" do
#action [:start, :enable]
#end


####### ------
tomcat_pkgs = value_for_platform(
  ['debian', 'ubuntu'] => {
    'default' => ["tomcat#{node['tomcat']['base_version']}", 'libtcnative-1', 'libmysql-java']
  },
  ['centos', 'redhat', 'fedora', 'amazon'] => {
    'default' => ["tomcat#{node['tomcat']['base_version']}", 'tomcat-native', 'mysql-connector-java']
  },
  'default' => ["tomcat#{node['tomcat']['base_version']}"]
)

tomcat_pkgs.each do |pkg|
  package pkg do
    action :install
  end
end

link ::File.join(node['tomcat']['lib_dir'], node['tomcat']['mysql_connector_jar']) do
  to ::File.join(node['tomcat']['java_dir'], node['tomcat']['mysql_connector_jar'])
  action :create
end

cookbook_file "/var/lib/tomcat7/webapps/sample.war" do
   source "sample.war"
   mode "0644"
   owner "tomcat"
   group "tomcat"
end


service 'tomcat7' do
  action [:enable, :start]
end


