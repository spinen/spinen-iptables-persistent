#
# Cookbook Name:: spinen-iptables
# Attributes:: default
#
# Copyright (C) 2014, SPINEN
#
# All rights reserved - Do Not Redistribute
#

#This contains iptables rules attributes common to all roles. Role-specific attributes will be in the specific recipes
# Set up default global firewall rules
networks = Chef::DataBagItem.load("configs", "networks")

#Allow SPINEN VPN for ssh

networks["development"]["management"].each do |net|
  net = net.to_s
  node.default['iptables-ng']['rules']['filter']['INPUT']['10-ssh-from-#{net}']['rule']    	= '-s #{node["management"]["#{net}"]["network"]}/#{node["management"]["#{net}"]["cidr"]} -p tcp --dport 22 -j ACCEPT -m comment --comment "Allow #{net} for ssh"'
  node.default['iptables-ng']['rules']['filter']['INPUT']['10-ssh-from-#{net}']['ip_version'] = 4
end

#node.default['iptables-ng']['rules']['filter']['INPUT']['20-allow-SPINENVPN']['rule']       = '-s 172.30.80.0/24 -p tcp --dport 22 -j ACCEPT -m comment --comment "Allow SPINENVPN for ssh"'
#node.default['iptables-ng']['rules']['filter']['INPUT']['20-allow-SPINENVPN']['ip_version'] = 4
#Allow local traffic to itself
node.default['iptables-ng']['rules']['filter']['INPUT']['30-allow-self-traffic']['rule']    = '-m state --state RELATED,ESTABLISHED -j ACCEPT -m comment --comment "allow input from established connections"'
node.default['iptables-ng']['rules']['filter']['INPUT']['30-allow-self-traffic']['ip_version']    = 4

#Allow established connection input
node.default['iptables-ng']['rules']['filter']['INPUT']['30-allow-established']['rule']    = '-i lo -j ACCEPT -m comment --comment "allow traffic from itself"'
node.default['iptables-ng']['rules']['filter']['INPUT']['30-allow-established']['ip_version']    = 4

#log all recected traffic
node.default['iptables-ng']['rules']['filter']['INPUT']['80-log_rejected']['rule']   		= ' -m limit --limit 5/min -j LOG --log-prefix "iptables: dropped packets" --log-level 4'
node.default['iptables-ng']['rules']['filter']['FORWARD']['80-log_rejected']['rule']        = ' -m limit --limit 5/min -j LOG --log-prefix "iptables: dropped packets" --log-level 4'

#drop all input traffic
node.default['iptables-ng']['rules']['filter']['INPUT']['90-drop']['rule']       			= '-j DROP -m comment --comment "drop all traffic"'
node.default['iptables-ng']['rules']['filter']['INPUT']['90-drop']['ip_version']			= 4

#drop all forward traffic
node.default['iptables-ng']['rules']['filter']['FORWARD']['90-drop']['rule'] 				= '-j DROP -m comment --comment "deny all forward traffic"'
node.default['iptables-ng']['rules']['filter']['FORWARD']['90-drop']['ip_version'] 			= 4

# Deny everything, we need to make this all work eventually
node.default['iptables-ng']['rules']['filter']['INPUT']['99-default']                   	= 'DROP [0:0]'

#node.default['iptables-ng']['rules']['filter']['OUTPUT']['41-default']                  = 'DROP [0:0]'
#node.default['iptables-ng']['rules']['filter']['FORWARD']['41-default']                 = 'DROP [0:0]'
