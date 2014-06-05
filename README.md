Spinen iptables Cookbook
===

This cookbook installs iptables-persistent, and configures the server to open the specified ports via iptables.


## Setup
---

For the spinen-iptables cookbook to function correctly, you need to create a data_bags network configuration. A sample networks.json is provided, but is not functional. Use it as a sample framework to work with. Replace the "sample-network" groups with networks that you plan on using. Replace all "33.33.33.changethis" with the corresponding network ip addresses, and replace all domain names with the desired domain.

## Attributes
---

### If you want to add any partial templates, change "no-partial" to the partial you intend to include.

`node.default['iptables']['partial'] = "no-partial"`

### Change "development" to whatever vpc you plan on managing.

`node.default['dns']['vpc'] = "development"`

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
