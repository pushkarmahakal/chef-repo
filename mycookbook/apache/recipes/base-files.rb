# Add file for apache to serve

cookbook_file "/var/www/index.html" do
  source "index.html"
  mode "0644"
end

service "apache2" do
action :restart
end

