
ruby_block "insert_line" do
  block do
    file = Chef::Util::FileEdit.new("/etc/rsyslog.conf")
    file.insert_line_if_no_match("\\$\\IncludeConfig /etc/rsyslog.d/\\*\\.conf", "$IncludeConfig /etc/rsyslog.d/*.conf")
    file.write_file
  end
end

