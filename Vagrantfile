# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.vm.box = "cent6.4_x86_64"

  config.vm.define :postfix do |vm|
    vm.vm.network :private_network, ip: "192.168.33.10"
  end

  config.vm.define :dns do |vm|
    vm.vm.network :private_network, ip: "192.168.33.20"
    vm.omnibus.chef_version = :latest
    vm.berkshelf.enabled = true

    vm.vm.provision :chef_solo do |chef|
      chef.run_list = ["dns"]
    end
  end

  config.vm.define :client do |vm|
    vm.vm.network :private_network, ip: "192.168.33.30"
    vm.omnibus.chef_version = :latest
    vm.berkshelf.enabled = true

    vm.vm.provision :chef_solo do |chef|
      chef.run_list = ["client"]
    end
  end
   
end
