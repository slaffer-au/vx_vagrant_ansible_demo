require 'spec_helper'
require 'yaml'

properties = YAML.load_file('properties.yml')

describe "OSPF and Zebra MUST be enabled" do
  describe file('/etc/quagga/daemons') do
    its(:content) { should contain 'ospfd=yes' }
    its(:content) { should contain 'zebra=yes' }
  end
end

describe service('quagga') do
  it { should be_enabled }
  it { should be_running }
end

describe 'All OSPF Adjacencies are Established' do
  hostname = ENV['TARGET_HOST']

  if hostname.start_with?('s')
    # Handle spines
    1.upto(properties[:numLeaves]) do |link|
      iface = 'swp' + link.to_s

      describe interface(iface) do
        it { should be_up }
      end

      describe command('sudo cl-ospf interface show ' + iface) do
        its(:stdout) { should contain "This interface is UNNUMBERED" }
        its(:stdout) { should contain "Adjacent neighbor count is 1" }
      end
    end

  elsif hostname.start_with?('l')
    # Handle leaves
    1.upto(properties[:numSpines]) do |link|
      iface = 'swp' + link.to_s

      describe interface(iface) do
        it { should be_up }
      end

      describe command('sudo cl-ospf interface show ' + iface) do
        its(:stdout) { should contain "This interface is UNNUMBERED" }
        its(:stdout) { should contain "Adjacent neighbor count is 1" }
      end
    end
  end
end

describe "Loopback is being announced" do
  describe command('sudo cl-ospf interface show lo') do
    its(:stdout) { should contain(/No Hellos \(Passive interface\)/) }
  end
end
    



