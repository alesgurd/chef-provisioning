#!/bin/bash

if [[ ! -f "/root/chefdk_3.8.14-1_amd64.deb" ]] ; then
    echo "---------------- Installing the chefdk ----------------"
    wget https://packages.chef.io/files/stable/chefdk/3.8.14/debian/9/chefdk_3.8.14-1_amd64.deb -P /root/
    dpkg -i /root/chefdk_3.8.14-1_amd64.deb
else
    echo "---------------- Chef client already exists ----------------"
fi

if [[ ! -d /var/chef/cookbooks ]] ; then
    echo "---------------- Creating cookbooks directory ----------------"
    mkdir /var/chef/cookbooks
else
    echo "---------------- Cookbooks directory already exists ----------------"
fi

if [[ ! -d '/var/chef/cookbooks/devSetup' ]] ; then
    echo "---------------- Cloning cookbook from git ----------------"
    git clone https://github.com/alesgurd/chef-provisioning.git /var/chef/cookbooks/devSetup 
else
    echo "---------------- Cookbook already exists ----------------"
fi

echo "---------------- Establishing the local berks repository and resolving cookbook dependencies. ----------------"
berks vendor /var/chef/cookbooks --berksfile=/var/chef/cookbooks/devSetup/Berksfile

echo "---------------- Initiliazing chef-client locally. ----------------"
chef-solo -o devSetup::packages
chef-solo -o devSetup::fileHandle
chef-solo -o devSetup::desktopEntries