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

ode.default['iptables']['rules.v4'] = 'rules.v4.erb'

#Point the default vpc to development. Change "development" to whatever vpc you plan on managing.
node.default['dns']['vpc'] = "development"

#network hashes
node.default['iptables']['network1'] = "sample-network1"

node.default['iptables']['network2'] = "sample-network2"

node.default['iptables']['network3'] = "sample-network3"

node.default['iptables']['network4'] = "sample-network4"

node.default['iptables']['network5'] = "sample-network5"