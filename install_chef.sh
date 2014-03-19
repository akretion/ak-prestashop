#!/bin/bash

command="wget -O - https://www.opscode.com/chef/install.sh | sudo bash"

repo_list=(
    http://github.com/akretion/ak-prestashop.git
    http://github.com/akretion/ak-tools.git
    http://github.com/akretion/ak-lnmp.git
    http://github.com/opscode-cookbooks/apt.git
)

set -e

#Install last version of chef
if [ ! -d "/opt/chef" ]
then
    echo "Install last chef version."
    eval $command
else
    version=$(chef-client -v)
    min_version='Chef: 11.0.0'
    if [[ "$version" < "$min_version" ]]
    then
        echo "Actual Chef version is $version, minimal version required min version $minversion. Update it."
        eval $command
    else
        echo "The version of Chef is correct, enjoy Akretion cookbook !"
    fi
fi

if [ ! -f "/etc/chef-solo/cookbooks/cookbooks/installed.flag" ]
then
    echo "Download cookbooks"
    sudo apt-get install git -y
    mkdir -p /etc/chef-solo/cookbooks/cookbooks
    cd /etc/chef-solo/cookbooks/cookbooks
    rm -rf /etc/chef-solo/cookbooks/cookbooks/*
    for repo in ${repo_list[*]}
    do
        echo "download cookbook from $repo"
        git clone $repo
    done
    touch "/etc/chef-solo/cookbooks/cookbooks/installed.flag"
fi
  
