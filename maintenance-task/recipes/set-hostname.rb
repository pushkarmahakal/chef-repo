#Change hostname of instance
execute "set hostname" do
  command "hostname test.node.es1"
#  command "hostname  <%= node['ec2']['placement_availability_zone'] %>"
end

