# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  # For a complete reference, please see the online documentation at vagrantup.com.

  # A little configuration for VirtualBox. More memory than the default.
  config.vm.provider :virtualbox do |vb|
    vb.customize ["modifyvm", :id, "--memory", 1024]
  end

  # Every Vagrant virtual environment requires a box to build off of.
  # Use latest 32-bit Ubuntu from vagrantcloud.com by default
  config.vm.box = "ubuntu/trusty32"

  # To specify a URL or file path of a downloaded box, use 'config.vm.box' instead
  #config.vm.box_url = "http://files.vagrantup.com/precise32.box"
  #config.vm.box_url = "file:///tmp/vagrant-boxes/ubuntu-trusty32.box"
  
  # Assign a hostname to the vm
  config.vm.hostname = "sakai.local"

  # Forward a port from the guest to the host, which allows for outside
  # computers to access the VM, whereas host only networking does not.
  config.vm.network :forwarded_port, guest: 8080, host: 8888
  config.vm.network :forwarded_port, guest: 8000, host: 9999

  # This enables puppet to use the "files" directory as the source for files it's provisioning
  config.vm.provision :puppet, :module_path => "modules", :options => ["--fileserverconfig=/vagrant/fileserver.conf"]

end
