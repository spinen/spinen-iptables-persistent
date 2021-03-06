require 'spec_helper'

describe 'spinen-iptables::default' do
	let(:chef_run) do
    ChefSpec::Runner.new do |node|
      node.set['dns']['vpc'] = "development"
    end.converge('spinen-iptables::default')
  end

  before do
      stub_data_bag_item('configs', 'networks') { JSON.parse(File.read('data_bags/configs/networks.json')) }
    end

  it 'installs the ufw package' do
    expect(chef_run).to remove_package('ufw')
  end

  it 'installs the iptables-persistent package' do
    expect(chef_run).to install_package('iptables-persistent')
  end

  it 'creates /etc/iptables/rules.v4 with the necessary attributes' do
    expect(chef_run).to create_template('/etc/iptables/rules.v4').with(
      owner:   'root',
      group:  'root',
      mode:   0644,
      backup: false,
    )
  end

end