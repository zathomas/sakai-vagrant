     __       _         _                                    _   
    / _\ __ _| | ____ _(_) /\   /\__ _  __ _ _ __ __ _ _ __ | |_ 
    \ \ / _` | |/ / _` | | \ \ / / _` |/ _` | '__/ _` | '_ \| __|
    _\ \ (_| |   < (_| | |  \ V / (_| | (_| | | | (_| | | | | |_ 
    \__/\__,_|_|\_\__,_|_|   \_/ \__,_|\__, |_|  \__,_|_| |_|\__|
                                       |___/
    gem install vagrant
    git clone git://github.com/zathomas/sakai-vagrant.git
    cd sakai-vagrant
    git submodule update --init
    vagrant up

Vagrant is a tool for quickly setting up virtual machines for developers. Vagrant has a couple of dependencies: these instructions assume you have ruby, rubygems, git, and the latest version of Oracle’s [VirtualBox](https://www.virtualbox.org/wiki/Downloads). Note: depending on where rubygems is installing things for you, you may need to use `sudo` when running `gem install`, e.g. `sudo gem install vagrant`

The very first time you start this VM, it’s going to download a base Ubuntu server image, install the necessary tools and then checkout the Sakai source code. Once it’s underway, this is a good time to take a break. The source code is close to 500MiB, and Subversion takes its sweet time. You can check on how it's doing from time to time by opening a second terminal and measuring the size of the source directory, like this: `du -hs sakai-vagrant/sakai-src`