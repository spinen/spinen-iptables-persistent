#
# Cookbook Name:: spinen-iptables
# Attributes:: default
#
# Copyright (C) 2014, SPINEN
#
# All rights reserved - Do Not Redistribute
#

# If you want to add any partial templates, change "no-partial" to the partial you plan to include.
node.default['iptables']['partial'] = "no-partial"

#Point the default vpc to development. Change "development" to whatever vpc you plan on managing.
node.default['dns']['vpc'] = "development"

#network hashes
node.default['iptables']['network1'] = "sample-network1"

node.default['iptables']['network2'] = "sample-network2"