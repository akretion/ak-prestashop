#package
default[:ak_tools][:apt_packages] += %w[
git
]

#Choose the git repo for prestashop
default[:prestashop][:git]                = "git://github.com/PrestaShop/PrestaShop.git"

#Prestashop configuration
default[:prestashop][:dir_www]               = "/var/www"
default[:prestashop][:dir_name]              = "prestashop"
default[:prestashop][:dir]                   = default[:prestashop][:dir_www] + '/'+ prestashop[:dir_name]

#mysql configuration
default[:mysql][:db][:database]              = "prestashop"
