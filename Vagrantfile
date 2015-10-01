# -*- mode: ruby -*-
# vi: set ft=ruby :

# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.

require 'yaml'

Vagrant.configure("2") do |config|

  config.vm.box = "cumulus-vx-2.5.3"

  # Number of nodes to provision from external yml file
  properties = YAML.load_file("provisioning/properties.yml")
  
  # Number of nodes to provision
  iter = 1

  # Spine definition and config
  1.upto(properties[:numSpines]) do |num|
    nodeName = ("s" + num.to_s).to_sym
    devName = ("s" + num.to_s)
    config.vm.define nodeName do |node|
      node.vm.host_name = devName
      1.upto(properties[:numLeaves]) do |leaf|
        leafname = ("l" + leaf.to_s)
        node.vm.network "private_network",
                        virtualbox__intnet: devName + "-" + leafname
      end
      
      node.vm.provision "ansible" do |ansible|
        ansible.extra_vars = {
          loopback_ip: properties[:ipAddrPrefix] + iter.to_s
        }
        ansible.playbook = "provisioning/clospf.yml"
      end
      
      node.vm.provision "shell" do |s|
        ssh_pub_key = File.readlines("#{Dir.home}/.ssh/id_rsa.pub").first.strip
        s.inline = <<-SHELL
            echo #{ssh_pub_key} >> /home/vagrant/.ssh/authorized_keys
        SHELL
      end

      iter += 1
    end
  end

  # Leaf definition and config
  1.upto(properties[:numLeaves]) do |num|
    nodeName = ("l" + num.to_s).to_sym
    devName = ("l" + num.to_s)
    config.vm.define nodeName do |node|
      node.vm.host_name = devName
      1.upto(properties[:numSpines]) do |spine|
        spinename = ("s" + spine.to_s)
        node.vm.network "private_network",
                        virtualbox__intnet: spinename + "-" + devName
      end

      node.vm.provision "ansible" do |ansible|
        ansible.extra_vars = {
          loopback_ip: properties[:ipAddrPrefix] + iter.to_s
        }
        ansible.playbook = "provisioning/clospf.yml"
      end
      
      node.vm.provision "shell" do |s|
        ssh_pub_key = File.readlines("#{Dir.home}/.ssh/id_rsa.pub").first.strip
        s.inline = <<-SHELL
            echo #{ssh_pub_key} >> /home/vagrant/.ssh/authorized_keys
        SHELL
      end

      iter += 1

    end
  end
end
