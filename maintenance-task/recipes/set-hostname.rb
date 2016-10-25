#Change hostname of instance
execute "set hostname" do
  command "hostname  <%= node['ec2']['placement_availability_zone'] %>"
end

