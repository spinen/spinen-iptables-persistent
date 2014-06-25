require 'spec_helper'

describe 'spinen-iptables::default' do
	let(:chef_run) { ChefSpec::Runner.new.converge('spinen-iptables::default') }

   #add data bag support to this test so that the test will function.

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
      #add variable support for testing here
    )
  end

end