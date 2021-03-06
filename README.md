# Cumulus VX + Vagrant + Ansible
##### _A downloadable demonstration of a scaling unnummbered CLOS OSPF topology with Cumulus VX deployed by Vagrant and some simple Ansible Playbooks._


#### Requirements
1) VirtualBox, Vagrant and Ansible must already be installed on the system.
  
2) The Cumulus VX box image must already be added to Vagrant with the name "cumulus-vx-2.5.3".
  
  - Detailed instruction on the above processes can be found at the following Cumulus Networks User Guide.
    - http://docs.cumulusnetworks.com/display/VX/Using+Cumulus+VX+with+Vagrant

3) The Cumulus Linux Ansible modules must be installed.
  - This achieved with the command "ansible-galaxy install cumulus.CumulusLinux".
   
  
4) The hypervisor's public SSH key must be at ~/.ssh/id_rsa.pub


#### Side Note
Vagrant creates a NAT network with eth0 of all VX images, forwarding a localhost port to TCP port 22 of the guest for SSH access. While this works well for purely local SSH access, it inherently makes it hard to connect and develop with these devices as if they were actual remote network nodes.

With that in mind, all Ansible automation has been built around having a local SSH alias for each VX, thus allowing "ssh vagrant@vm" access. This is achieved through the Vagrant-to-Local script available at the following link.

  - https://github.com/slaffer-au/vagrant-to-local

  
#### Instructions
  1) Change to the directory where this repository has been cloned.
  
  2) Edit the properties.yml file with the amount of spines, leaves and first IP address.
  
  3) Enter the command "vagrant up".
  
  4) Git Clone or download and execute the Vagrant-to-Local script in same directory once the "vagrant up" has been successfully completed. 
  
  5) Connected to the Cumulus VX guests with "vagrant ssh <hostname>" or "ssh vagrant@<hostname>". 
  
  6) To run Ansible ad-hoc commands or playbooks, change to the automation directory.

 

#### Credits
90% of the Vagrantfile and provisioning automation came from the fantastic Customer Engineering team at Cumulus Networks. Please be sure to check out their demos and code for this and much, much more:
  - http://docs.cumulusnetworks.com/display/VX/Using+Cumulus+VX+with+Vagrant
  - https://github.com/CumulusNetworks/cumulus-vx-vagrant
  - https://github.com/CumulusNetworks/

