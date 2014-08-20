# -*- mode: ruby -*-
# vi: set ft=ruby :
PrestashopPort = 10100
PhpMyAdminPort = 10200

Vagrant::Config.run do |config|
  config.vm.box = "precise64"
  config.vm.box_url = "http://files.vagrantup.com/precise64.box"

  config.vm.forward_port PrestashopPort, PrestashopPort
  config.vm.forward_port PhpMyAdminPort, PhpMyAdminPort

  config.vm.provision :shell, :path => "install_chef.sh" 

  config.vm.provision :chef_solo do |chef|
      chef.provisioning_path = "/etc/chef-solo"
      chef.add_recipe("ak-prestashop")
      chef.json = {
        :prestashop => {
            :port => PrestashopPort,
            :git => "git://github.com/PrestaShop/PrestaShop.git",
            },
        :phpmyadmin => {:port => PhpMyAdminPort},
    }
  end
end
