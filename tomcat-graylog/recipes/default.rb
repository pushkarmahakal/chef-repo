#
# Cookbook Name:: tomcat-graylog
# Recipe:: default
#
# Copyright 2016, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
############# Forward tomcat logs to graylog ############ 
package 'rsyslog' do
  action :install
end

ruby_block "insert_line" do
  block do
    file = Chef::Util::FileEdit.new("/etc/rsyslog.conf")
    file.insert_line_if_no_match("\\$\\IncludeConfig /etc/rsyslog.d/\\*\\.conf", "$IncludeConfig /etc/rsyslog.d/*.conf")
    file.write_file
  end
end

directory "/var/spool/rsyslog/" do
  mode 0755
  owner 'root'
  group 'root'
  action :create
end

cookbook_file "/etc/rsyslog.d/22-graylog-tomcat.conf" do
   source "22-graylog-tomcat.conf"
   mode "0644"
end

cookbook_file "/etc/rsyslog.d/29-graylog-system.conf" do
   source "29-graylog-system.conf"
   mode "0644"
end

########## 

ruby_block "delete_line" do
  block do
    file = Chef::Util::FileEdit.new("/etc/tomcat7/logging.properties")
    file.search_file_delete_line("1catalina.org.apache.juli.FileHandler.prefix = catalina.")
    file.write_file
  end
end

ruby_block "insert_line" do
  block do
    file = Chef::Util::FileEdit.new("/etc/tomcat7/logging.properties")
    file.insert_line_if_no_match("1catalina.org.apache.juli.FileHandler.prefix = catalina", "1catalina.org.apache.juli.FileHandler.prefix = catalina")
    file.write_file
  end
end

ruby_block "insert_line" do
  block do
    file = Chef::Util::FileEdit.new("/etc/tomcat7/logging.properties")
    file.insert_line_if_no_match("1catalina.org.apache.juli.FileHandler.rotatable = false", "1catalina.org.apache.juli.FileHandler.rotatable = false")
    file.write_file
  end
end

ruby_block "delete_line" do
  block do
    file = Chef::Util::FileEdit.new("/etc/tomcat7/logging.properties")
    file.search_file_delete_line("2localhost.org.apache.juli.FileHandler.prefix = localhost.")
    file.write_file
  end
end

ruby_block "insert_line" do
  block do
    file = Chef::Util::FileEdit.new("/etc/tomcat7/logging.properties")
    file.insert_line_if_no_match("2localhost.org.apache.juli.FileHandler.prefix = localhost", "2localhost.org.apache.juli.FileHandler.prefix = localhost")
    file.write_file
  end
end

ruby_block "insert_line" do
  block do
    file = Chef::Util::FileEdit.new("/etc/tomcat7/logging.properties")
    file.insert_line_if_no_match("2localhost.org.apache.juli.FileHandler.rotatable = false", "2localhost.org.apache.juli.FileHandler.rotatable = false")
    file.write_file
  end
end

ruby_block "delete_line" do
  block do
    file = Chef::Util::FileEdit.new("/etc/tomcat7/logging.properties")
    file.search_file_delete_line("3manager.org.apache.juli.FileHandler.prefix = manager.")
    file.write_file
  end
end

ruby_block "insert_line" do
  block do
    file = Chef::Util::FileEdit.new("/etc/tomcat7/logging.properties")
    file.insert_line_if_no_match("3manager.org.apache.juli.FileHandler.prefix = manager", "3manager.org.apache.juli.FileHandler.prefix = manager")
    file.write_file
  end
end

ruby_block "insert_line" do
  block do
    file = Chef::Util::FileEdit.new("/etc/tomcat7/logging.properties")
    file.insert_line_if_no_match("3manager.org.apache.juli.FileHandler.rotatable = false", "3manager.org.apache.juli.FileHandler.rotatable = false")
    file.write_file
  end
end

ruby_block "delete_line" do
  block do
    file = Chef::Util::FileEdit.new("/etc/tomcat7/logging.properties")
    file.search_file_delete_line("4host-manager.org.apache.juli.FileHandler.prefix = host-manager.")
    file.write_file
  end
end

ruby_block "insert_line" do
  block do
    file = Chef::Util::FileEdit.new("/etc/tomcat7/logging.properties")
    file.insert_line_if_no_match("4host-manager.org.apache.juli.FileHandler.prefix = host-manager", "4host-manager.org.apache.juli.FileHandler.prefix = host-manager")
    file.write_file
  end
end

ruby_block "insert_line" do
  block do
    file = Chef::Util::FileEdit.new("/etc/tomcat7/logging.properties")
    file.insert_line_if_no_match("4host-manager.org.apache.juli.FileHandler.rotatable = false", "4host-manager.org.apache.juli.FileHandler.rotatable = false")
    file.write_file
  end
end

##### 

ruby_block "insert_line" do
  block do
    file = Chef::Util::FileEdit.new("/etc/tomcat7/server.xml")
    file.insert_line_if_no_match('\\<\\Valve className\\=\\"org.apache.catalina.valves.AccessLogValve" directory\\=\\"logs" renameOnRotate\\=\\"true"', '<Valve className="org.apache.catalina.valves.AccessLogValve" directory="logs" renameOnRotate="true"')
    file.write_file
  end
end

ruby_block "delete_line" do
  block do
    file = Chef::Util::FileEdit.new("/etc/tomcat7/server.xml")
    file.search_file_delete_line('prefix\\=\\"localhost_access_log." suffix\\=\\".txt"')
    file.write_file
  end
end

ruby_block "insert_line" do
  block do
    file = Chef::Util::FileEdit.new("/etc/tomcat7/server.xml")
    file.insert_line_if_no_match('prefix\\=\\"localhost_access_log" suffix\\=\\".txt"', 'prefix="localhost_access_log" suffix=".txt"')
    file.write_file
  end
end

service "tomcat7" do
  action :restart
end

service "rsyslog" do
  action :restart
end
