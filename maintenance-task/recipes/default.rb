#
# Cookbook Name:: maintenance-task
# Recipe:: default
#
# Copyright 2016, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

ruby_block "insert_line" do
  block do
    file = Chef::Util::FileEdit.new("/etc/elasticsearch/elasticsearch.yml")
    file.insert_line_if_no_match("path.repo\\:\\ /etc/elasticsearch/backup", "node:")
    file.write_file
  end
end

ruby_block "insert_line" do
  block do
    file = Chef::Util::FileEdit.new("/etc/elasticsearch/elasticsearch.yml")
    file.insert_line_if_no_match("  name\\:\\ Zone1-ALPHA", "  name: Zone1-ALPHA")
    file.write_file
  end
end

ruby_block "insert_line" do
  block do
    file = Chef::Util::FileEdit.new("/etc/elasticsearch/elasticsearch.yml")
    file.insert_line_if_no_match("discovery.zen.ping.multicast.enabled\\:\\ false", "discovery.zen.ping.multicast.enabled: false")
    file.write_file
  end
end

ruby_block "insert_line" do
  block do
    file = Chef::Util::FileEdit.new("/etc/elasticsearch/elasticsearch.yml")
    file.insert_line_if_no_match("discovery.zen.ping.timeout: 5s", "discovery.zen.ping.timeout: 5s")
    file.write_file
  end
end

ruby_block "insert_line" do
  block do
    file = Chef::Util::FileEdit.new("/etc/elasticsearch/elasticsearch.yml")
    file.insert_line_if_no_match("discovery.zen.ping.unicast.hosts: \\[prod-aes01.com]", "discovery.zen.ping.unicast.hosts: [prod-aes01.com]")
#    file.insert_line_if_no_match("discovery.zen.ping.unicast.hosts: [\"\prod-es01.tloapps.com\"\, \"\prod-es02.tloapps.com\"\, \"\prod-es03.tloapps.com\"\, \"\prod-es04.tloapps.com\"\, \"\prod-es05.tloapps.com\"\, \"\prod-es06.tloapps.com\"\]", "discovery.zen.ping.unicast.hosts: [\"\prod-es01.tloapps.com\"\, \"\prod-es02.tloapps.com\"\, \"\prod-es03.tloapps.com\"\, \"\prod-es04.tloapps.com\"\, \"\prod-es05.tloapps.com\"\, \"\prod-es06.tloapps.com\"\]") 
    file.write_file
  end
end

