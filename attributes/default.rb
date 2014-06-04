#
# Cookbook Name:: spinen-iptables
# Attributes:: default
#
# Copyright (C) 2014, SPINEN
#
# All rights reserved - Do Not Redistribute
#

# If you want to add any partial templates, change "no-partial" to the partial you want to include.
node.default['iptables']['partial'] = "no-partial"

#Point the default vpc to development. Change "development" to whatever vpc you plan on managing.
node.default['dns']['vpc'] = "development"