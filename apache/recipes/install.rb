# Install apache program

package "apache2" do
action :install
end

# start apache service and start on bootup
service "apache2" do
action [:start, :enable]
end

