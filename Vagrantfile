# -*- mode: ruby -*-
# vi: set ft=ruby :

# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.
Vagrant.configure("2") do |config|    
  # The most common configuration options are documented and commented below.
  # For a complete reference, please see the online documentation at
  # https://docs.vagrantup.com.

  # Every Vagrant development environment requires a box. You can search for
  # boxes at https://vagrantcloud.com/search.
  # https://app.vagrantup.com/geerlingguy/boxes/centos7
  config.vm.box = "geerlingguy/centos7"          
  config.vm.box_version = "1.2.7"

  # Disable automatic box update checking. If you disable this, then
  # boxes will only be checked for updates when the user runs
  # `vagrant box outdated`. This is not recommended.
  # config.vm.box_check_update = false

  # Create a forwarded port mapping which allows access to a specific port
  # within the machine from a port on the host machine. In the example below,
  # accessing "localhost:8080" will access port 80 on the guest machine.
  # NOTE: This will enable public access to the opened port
  # config.vm.network "forwarded_port", guest: 80, host: 8880

  # Create a forwarded port mapping which allows access to a specific port
  # within the machine from a port on the host machine and only allow access
  # via 127.0.0.1 to disable public access

  config.vm.network "forwarded_port", guest: 80, host: 8880, host_ip: "127.0.0.1"

  # Create a private network, which allows host-only access to the machine
  # using a specific IP.
  # config.vm.network "private_network", ip: "192.168.1.100"

  # Create a public network, which generally matched to bridged network.
  # Bridged networks make the machine appear as another physical device on
  # your network.
  # config.vm.network "public_network"

  # Share an additional folder to the guest VM. The first argument is
  # the path on the host to the actual folder. The second argument is
  # the path on the guest to mount the folder. And the optional third
  # argument is a set of non-required options.

  config.vm.synced_folder "./shared/ansible", "/vagrant_data/ansible"
  
  # The wordpress_dev user key to be accepted on the server

  # Enable provisioning with a shell script. Additional provisioners such as
  # Puppet, Chef, Ansible, Salt, and Docker are also available. Please see the
  # documentation for more information about their specific syntax and use.
  # config.vm.provision "shell", inline: <<-SHELL
  #config.vm.provision "ansible" do |ansible|
  #     ansible.playbook = "ansible/playbook.yml"
  #     ansible.become = true
  # end
  #   apt-get update
  #   apt-get install -y apache2
  # SHELL
  # TEST COMMENT
  # Daniel 2
  # Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
  config.vm.provision :shell, :path => "provisioning.sh"
  # provisioner = Vagrant::Util::Platform.windows? ? :guest_ansible : :ansible
  # config.vm.define "web" do |web|
  #   web.vm.network :forwarded_port, guest: 9080, host: 9080, host_ip: "127.0.0.1"
  #   web.vm.hostname = "web"
  #   web.vm.provision provisioner do |ansible|
  #     ansible.playbook = "ansible/playbook.yml"
  #   end
  # end
end
