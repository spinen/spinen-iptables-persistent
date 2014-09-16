#
# Cookbook Name:: spinen-iptables
# Recipe:: default
#
# Copyright (C) 2014 SPINEN
#
# All rights reserved - Do Not Redistribute
#

networks = data_bag_item('configs', 'networks')

#remove the ufw package that can conflict with iptables-persistent
package "ufw" do
  action :remove
end

#install iptables-persistent package BEFORE writing any iptables rules to prevent breaking the packer build in Jenkins
package "iptables-persistent" do
  action :install
end

icmp_list = networks['icmp']
ssh_list = Hash.new

# create a hash of "network" => "network/cidr" for each allowed management network based on the vpc of the build
networks["#{node['dns']['vpc']}"]["management"].each do |net|
	ssh_list["#{net}"] = networks["management"]["#{net}"]["network"] + "/" + networks["management"]["#{net}"]["cidr"]
end

# create a hash of "network" => "network/cidr" for each allowed management network based on the vpc of the build
networks['icmp'].each do |net|
  icmp_list["#{net}"] = networks["icmp"]["#{net}"]["network"] + "/" + networks["icmp"]["#{net}"]["cidr"]
end


#write a rules.v4 file into the iptables directory. the iptables-persistent package will read this file on boot and apply to iptables
template "/etc/iptables/rules.v4" do
  source "rules.v4.erb"
  user   "root"
  group  "root"
  mode   0644
  backup false
  variables(
  	:ssh_list => ssh_list,
    :icmp_list => icmp_list,
    :partial => node['iptables']['partial']
    )
end
