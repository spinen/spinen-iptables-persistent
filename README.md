Spinen iptables Cookbook
===

This cookbook installs iptables-persistent, and configures the server to open the specified ports via iptables.


## Setup
---

For the spinen-iptables cookbook to function correctly, you need to create a data_bags network configuration. A sample networks.json is provided, but is not functional. Use it as a sample template to work with. Replace the "sample-network" groups with networks that you plan on using. Replace all "33.33.33.changethis" with the corresponding network ip addresses, and replace all domain names with the desired domain.

## Attributes
---

#### Loads data_bag configurations
`networks = Chef::DataBagItem.load("configs", "networks")`

#### Allow SPINEN VPN for ssh

`networks["development"]["management"].each do |net|`

 `net = net.to_s`

  `node.default['iptables-ng']['rules']['filter']['INPUT']['10-ssh-from-#{net}']['rule'] = '-s #{node["management"]["#{net}"]["network"]}/#{node["management"]["#{net}"]["cidr"]} -p tcp --dport 22 -j ACCEPT -m comment --comment "Allow #{net} for ssh"'`

`node.default['iptables-ng']['rules']['filter']['INPUT']['10-ssh-from-#{net}']['ip_version'] = 4`

`node.default['iptables-ng']['rules']['filter']['INPUT']['20-allow-SPINENVPN']['rule'] = '-s 172.30.80.0/24 -p tcp --dport 22 -j ACCEPT -m comment --comment "Allow SPINENVPN for ssh"'`

`node.default['iptables-ng']['rules']['filter']['INPUT']['20-allow-SPINENVPN']['ip_version'] = 4`

#### Allow local traffic to itself

`node.default['iptables-ng']['rules']['filter']['INPUT']['30-allow-self-traffic']['rule'] = '-m state --state RELATED,ESTABLISHED -j ACCEPT -m comment --comment "allow input from established connections"'`

`node.default['iptables-ng']['rules']['filter']['INPUT']['30-allow-self-traffic']['ip_version'] = 4`

#### Allow established connection input

`node.default['iptables-ng']['rules']['filter']['INPUT']['30-allow-established']['rule'] = '-i lo -j ACCEPT -m comment --comment "allow traffic from itself"'`

`node.default['iptables-ng']['rules']['filter']['INPUT']['30-allow-established']['ip_version'] = 4`

#### Log all recected traffic

`node.default['iptables-ng']['rules']['filter']['INPUT']['80-log_rejected']['rule'] = ' -m limit --limit 5/min -j LOG --log-prefix "iptables: dropped packets" --log-level 4'`
`node.default['iptables-ng']['rules']['filter']['FORWARD']['80-log_rejected']['rule'] = ' -m limit --limit 5/min -j LOG --log-prefix "iptables: dropped packets" --log-level 4'`

#### Drop all input traffic

`node.default['iptables-ng']['rules']['filter']['INPUT']['90-drop']['rule'] = '-j DROP -m comment --comment "drop all traffic"'`

`node.default['iptables-ng']['rules']['filter']['INPUT']['90-drop']['ip_version'] = 4`

#### Drop all forward traffic

`node.default['iptables-ng']['rules']['filter']['FORWARD']['90-drop']['rule'] = '-j DROP -m comment --comment "deny all forward traffic"'`
`node.default['iptables-ng']['rules']['filter']['FORWARD']['90-drop']['ip_version'] = 4`

#### Deny everything, we need to make this all work eventually

`node.default['iptables-ng']['rules']['filter']['INPUT']['99-default'] = 'DROP [0:0]'`

## Usage
---
### spinen-iptables::default

Include `spinen-iptables` in your node's `run_list`:

```json
{
  "run_list": [
    "recipe[spinen-iptables::default]"
  ]
}
```

## Supported Platforms
---
This cookbook runs on the following platforms:

* Ubuntu 12.04

## Contributing
---
1. Fork the repository on Github
2. Create a named feature branch (i.e. `add-new-recipe`)
3. Write your change
4. Write tests for your change (if applicable)
5. Run the tests, ensuring they all pass
6. Submit a Pull Request

## License and Authors
---

Author: SPINEN (<keli.grubb@spinen.com>)

Author: SPINEN (<luke.reimer@spinen.com>)
