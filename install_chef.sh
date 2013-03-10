#!/bin/bash

command="wget -O - https://www.opscode.com/chef/install.sh | sudo bash"

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


