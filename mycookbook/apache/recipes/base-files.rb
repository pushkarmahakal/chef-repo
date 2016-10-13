# Add file for apache to serve

cookbook_file "/var/www/html/index.html" do
  source "index.html"
  mode "0644"
end

