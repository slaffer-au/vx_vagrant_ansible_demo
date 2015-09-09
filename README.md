# Cumulus VX + Vagrant + Ansible
##### _A downloadable demonstration of a scaling unnummbered CLOS OSPF topology with Cumulus VX deployed by Vagrant and some simple Ansible Playbooks._


#### Requirements
  1) VirtualBox, Vagrant and Ansible must already be installed on the system
  
  2) The Cumulus VX box image must already be added to Vagrant with the name "cumulus-vx-2.5.3"
  
  - Detailed instruction on the above processes can be found at the following Cumulus Networks User Guide
    - http://docs.cumulusnetworks.com/display/VX/Using+Cumulus+VX+with+Vagrant

3) The hypervisors public SSH key must be at ~/.ssh/id_rsa.pub
  
#### Instructions
  1) Edit the properties.yml file with the amount of spines, leaves and first IP address
  
  2) Enter the command "vagrant up".

#### Recommendations
Vagrant creates a NAT network with eth0 of all VX images, forwarding a localhost port to TCP port 22 of the guest for SSH access. While this works well for purely local SSH access, it inherently makes it hard to connect and develop with these devices as if they were actual remote network nodes.

With that in mind, all Ansible automation has been built around having a local SSH alias for each VX, thus allowing "ssh vagrant@vm" access. This can be achieve through the Vagrant-to-Local script available at the following link.

  - https://github.com/slaffer-au/vagrant-to-local
  
It is strongly recommended to clone and execute the script in Vagrant directory once the "vagrant up" has been successfully completed.  

#### Credits
98% of the Vagrantfile and provisioning automation came from the fantastic Customer Engineering team at Cumulus Networks. Please be sure to check out their demos and code for this and much, much more:
  - http://docs.cumulusnetworks.com/display/VX/Using+Cumulus+VX+with+Vagrant
  - https://github.com/CumulusNetworks/cumulus-vx-vagrant
  - https://github.com/CumulusNetworks/

