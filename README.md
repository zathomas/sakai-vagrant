# Sakai Vagrant
Vagrant is a tool for quickly setting up virtual machines for developers. Vagrant has a couple of dependencies: these instructions assume you have ruby, rubygems, and the latest version of Oracle’s [VirtualBox](https://www.virtualbox.org/wiki/Downloads). One more note: depending on where rubygems is installing things for you, you may need to use `sudo` when running `gem install`, e.g. `sudo gem install vagrant` To get up and running with Sakai, follow these steps:

    gem install vagrant
    vagrant box add base http://files.vagrantup.com/precise32.box
    git clone git://github.com/zathomas/sakai-vagrant.git
    cd sakai-vagrant
    git submodule update --init
    vagrant up

The very first time you start this VM, it’s going to install the necessary tools and then checkout the Sakai source code. Once it’s underway, this is a good time to take a break. The source code is close to 500MiB, and Subversion takes its sweet time.